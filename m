Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1DDCF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg9O-0002hP-IV; Mon, 23 Sep 2024 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssg99-0001YW-TY; Mon, 23 Sep 2024 06:18:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssg96-0003wZ-Jt; Mon, 23 Sep 2024 06:18:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 54CF64E600E;
 Mon, 23 Sep 2024 12:18:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 18U2WAA6vl0j; Mon, 23 Sep 2024 12:18:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 64DFB4E601D; Mon, 23 Sep 2024 12:18:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6307F746F60;
 Mon, 23 Sep 2024 12:18:16 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:18:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 04/23] hw/ppc/e500: Remove unused "irqs" parameter
In-Reply-To: <20240923093016.66437-5-shentey@gmail.com>
Message-ID: <ace58703-2b52-c116-625c-18c26a58041f@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/ppc/e500.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 32996c188e..228287b457 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -825,7 +825,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
> }
>
> static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
> -                                          IrqLines *irqs, Error **errp)
> +                                          Error **errp)
> {
> #ifdef CONFIG_KVM
>     DeviceState *dev;
> @@ -865,7 +865,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
>         Error *err = NULL;
>
>         if (kvm_kernel_irqchip_allowed()) {
> -            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
> +            dev = ppce500_init_mpic_kvm(pmc, &err);
>         }
>         if (kvm_kernel_irqchip_required() && !dev) {
>             error_reportf_err(err,
>

