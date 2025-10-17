Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E51CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d1L-0001hb-24; Fri, 17 Oct 2025 01:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1J-0001gt-7d
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:28:53 -0400
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1E-0001le-LZ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:28:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.216])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cntf46z9lz5vRy;
 Fri, 17 Oct 2025 05:28:44 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:28:44 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001c7b7ccc4-a4cb-4b4c-a1f6-2c1f4c1292e6,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b59b7d5d-2d2d-49dd-b3bb-41ea97f67580@kaod.org>
Date: Fri, 17 Oct 2025 07:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 05/12] hw/arm/ast27x0: Share single SCU instance
 across PSP, SSP, and TSP
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
 <20251015062210.3128710-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251015062210.3128710-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: f92fd4e3-7cfd-42d3-bd7b-cf6159cd13de
X-Ovh-Tracer-Id: 15279587638128905007
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFlqSeJQXFUmyZ+txbTNFbWQZUDggwjbBbhkLGcXARGQjj3uTqXuKCKL5j0h0GPl6snSalzENM8uKlMuZMLOyqmriVq0fSKP5uQNcFF/UVJ7WJEPJkUt6VeDY7wgYtQ4fjDKqoa9NlCSJZK56ZwJh3Rh3pYxvIGL1enKAw0QXec/JKLWabVL2Y/2iDH1hzT4nIHyeZeQ+GOukgRSC/oxe/dyfSQk6SFCo868E5J+CrKlUxl8PhvzVvsHGEmFrpj9dhyUFURuXJJKTR85AgV7j7xTmuminMqWc2KeqJMB02djOfbLXeT7i/eNoO34/HLEu6zL/IKaPxQlwYeVaKjYXlwLmppwkZOsKt4MeW+6Iv5reb8AZY8L1oX9p0EpMHWVlsypjoWpuO8YHzH+D8jAZCy0BNeCZYAbz84l1agTkLnelBTbYyIZfdmAqjas6bkObCD0Is2+ZxGc+xqLyOzz0nkHYusOq6/KHaHaWcWvFWWlQRo1qheNMomG8mwZmhZm9P7vt4ALGhaHjQJPkHAD30Lelz5nK/DbZn0Vb0qgQwORHc+5oJZzY3w/vaxRj04jonbxFn5w9KdNEkiu/KzXI5Nq/SKWc8IQpMR6Pv1pZtEACHMFZZpR53nXBR5WcO8MfrC3sxwt52LptBt8i4ooM70+YaPykK0oqLXz3TlICeUWw
DKIM-Signature: a=rsa-sha256; bh=UprJPJdqXnWR5KRHWy+stXDdktnUjQT7AvJbrfpvl/k=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760678925; v=1;
 b=fJ8FP9JbnZJkbkQCoE70GI6q+JP8BN4TmLTSiL5ZjDQSGCf4IL+7tUlE96aF3xvloM/q67Pq
 mdF2CwiB+hF8YpGdYWHESMqHac2DRvEV5rsbD3oiqbxWtdj6+FDNNwRDGGR/J1OBR7Gf579zL93
 bP34VmVvvPECL4UUOW84MgUYwSGuCWN9PY6qq01SvpYE0oqtRlLHMIfBm3w8KXNyhaNarWhYFZS
 Dh4uFWhfiYqLqGcpsOho3ESilQZkdzy1IcIn1wd0oxWXf8/xc/+ysWmoTp6J0fuZ1ZOp4m234wZ
 x7qd6jL6yrCCrgObPEnQS2t3qsi8RlkccKG/q1dKQWm8w==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/15/25 08:22, Jamin Lin wrote:
> AST2700 has a single SCU hardware block, memory-mapped at
> 0x12C02000–0x12C03FFF from the perspective of the main CA35 processor (PSP).
> The SSP and TSP coprocessors access this same SCU block at different
> addresses: 0x72C02000–0x72C03FFF.
> 
> Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCU
> device, resulting in three independent SCU instances in the QEMU model.
> In real hardware, however, only a single SCU exists and is shared among
> all processors.
> 
> This commit reworks the SCU model to correctly reflect the hardware
> behavior by allowing SSP and TSP to reference the PSP’s SCU instance.
> The following changes are introduced:
> 
> - Add a scu property to AspeedCoprocessorState for linking the
>    coprocessor to the PSP’s SCU instance.
> - Replace per-coprocessor SCU instantiation with a shared SCU link.
> - Add "MemoryRegion scu_alias" to model address remapping for SSP and TSP.
> - Create SCU alias regions in both SSP and TSP coprocessors and map
>    them at 0x72C02000 to mirror the PSP’s SCU registers.
> - Ensure the SCU device in PSP is realized before SSP/TSP alias setup.
> 
> With this change, PSP, SSP, and TSP now share a consistent SCU state,
> matching the single-SCU hardware design of AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  4 ++--
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 13 +++++--------
>   hw/arm/aspeed_ast27x0-tsp.c         | 13 +++++--------
>   hw/arm/aspeed_coprocessor_common.c  |  2 ++
>   5 files changed, 18 insertions(+), 18 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



