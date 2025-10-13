Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C39ECCD18E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8EkF-0001fn-NM; Mon, 13 Oct 2025 05:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v8EkA-0001eU-8M; Mon, 13 Oct 2025 05:21:26 -0400
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v8Ek6-0004J1-0E; Mon, 13 Oct 2025 05:21:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.70])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4clX0F4R01z6N1G;
 Mon, 13 Oct 2025 09:21:17 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 13 Oct
 2025 11:21:16 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0027edc1db7-e750-4d25-8785-777561e23d1b,
 E27D2F41E47E806E38994DC6761E007B2CBA9264) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9d145642-6ddc-4b3c-af43-0b94664f2f3a@kaod.org>
Date: Mon, 13 Oct 2025 11:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 04/16] hw/arm/aspeed: Remove AspeedSoCClass
 dependency from aspeed_soc_cpu_type() API
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
 <20251013054334.955331-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251013054334.955331-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 312ceef5-f38d-4a05-a2d9-8452de2ddde3
X-Ovh-Tracer-Id: 14162694931420711858
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFOPVdP/117dPgbZzLhrsAnCLxxY8oDKf7VZMEzwaYiBJKxY3kKANlBsr1BqwTAHQ10+0GjdBAxO9PJvjUOeglKlQR99jQsIvY+YQho5TtXycUvjIDMOMPeN/WsnleFTSfkT4vpnHTPHguckBimuSHA5tMbz/buUPsXD6WiICNJCtFENz33bNy4FnY6mbeCaYUXJtLSt3ZjgMBuBqrnhfEYTuxL223oSE69lcxxLz5RUqGsBDg+P9HFG6g8ovT0t3uffsGgnohtBO22Qfnht5FHGxc0bclEU7E+T80xJR1wKVTY/T9EG7NrVaVr9kirtj79dudFNz/da2AAeCo4ju+HDnYttxXAeoS96PxsUzSQZs/WTcQnB10T2mfqbtXqIrIdtf6V8BGKOMFaM6qvRLJjfGP0Lee4nf+S/w9gUJUzvBAEmkmVnPTQzvrpf2mE4Ijb5L/svqh6WzhiloudPkO16FzIMs93I/1UnKzVIk4KXC06wSrvJGZV4wDe+kwflO2MOidn4FVASJqdZQG/ivtWDvqqE63N8CeLG1e4SWu6ts+Tm723AR+bj0EVBh/AONgBeoVxjLN9C/mMtO29H3IExHL2leiAZxgsR7I2xTUTWoKG8sZMTIMb1rPlKAJATGrLB54Sl0AA4aXH9Va3CN0FdE3qdlLWW2u430AV+ybT/A
DKIM-Signature: a=rsa-sha256; bh=AHrJVZb7ji+CfQxgCCbSIbPpCKiDskH1p2LsUfLmt4w=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760347278; v=1;
 b=JmqM4Cu1QfCOhMVgFVXiVWXemVl7VIuDZj/wILZXXl9E9jzmeoXiYbdz9ZfgwO/p0LIgS425
 Lh3XI8WsOMasLyN+l4+I0r6ZKVxE8Ys2XTqRR+qfWCyCVjk4uCfa1PK3yCL7Tx/ghcoujRBLBEj
 U5gatN7WmKeywSzZMO65TPpFr7XAwsQWx2cSE/RmYxA79jgZSjTe+pK6WXU8FNcERNkLj4Tuy2L
 LgLYgaAX8AZHKBDmPtxf7UgLcZMci2MyKph/MAJS173AplV+Tn6fVXluq7dMYdQwx+xqrKWTo3K
 870PSSZmDYx7zOr5RhDfchvJUcnE8TMlxpRhsaoVAqYIw==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/13/25 07:43, Jamin Lin wrote:
> Refactor the aspeed_soc_cpu_type() helper to remove its dependency on
> AspeedSoCClass and make CPU type retrieval more generic.
> 
> The function now takes valid_cpu_types as a const char * const *
> parameter instead of requiring a full AspeedSoCClass instance.
> All corresponding call sites in various Aspeed SoC initialization files
> (aspeed_ast10x0.c, aspeed_ast2400.c, aspeed_ast2600.c,
> aspeed_ast27x0.c, and related variants) are updated accordingly.
> 
> This change simplifies the API, eliminates unnecessary type coupling,
> and improves code reusability across different SoC families.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  3 +--
>   hw/arm/aspeed_ast10x0.c     |  3 ++-
>   hw/arm/aspeed_ast2400.c     |  2 +-
>   hw/arm/aspeed_ast2600.c     |  2 +-
>   hw/arm/aspeed_ast27x0-ssp.c |  3 ++-
>   hw/arm/aspeed_ast27x0-tsp.c |  3 ++-
>   hw/arm/aspeed_ast27x0.c     |  2 +-
>   hw/arm/aspeed_soc_common.c  | 10 +++++-----
>   8 files changed, 15 insertions(+), 13 deletions(-)
> 
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


