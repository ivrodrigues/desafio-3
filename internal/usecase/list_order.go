package usecase

import (
	"context"
	"errors"

	"github.com/ivrodrigues/desafio-3/internal/entity"
)

type ListOrdersUseCase struct {
	OrderRepository entity.OrderRepositoryInterface
}

func NewListOrderUseCase(orderRepository entity.OrderRepositoryInterface) *ListOrdersUseCase {
	return &ListOrdersUseCase{
		OrderRepository: orderRepository,
	}
}

func (l *ListOrdersUseCase) Execute(ctx context.Context) ([]OrderOutputDTO, error) {

	orderList, err := l.OrderRepository.List()

	if err != nil {
		return nil, errors.New("failed to return list of orders")
	}

	var outList []OrderOutputDTO
	for _, o := range orderList {
		var out OrderOutputDTO
		out.ID = o.ID
		out.Price = o.Price
		out.Tax = o.Tax
		out.FinalPrice = o.FinalPrice

		outList = append(outList, out)
	}

	return outList, nil
}
