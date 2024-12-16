Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B0AE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 11:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN9PP-0001ik-4j; Mon, 16 Dec 2024 06:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tN9PM-0001iR-0Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:37:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tN9PK-0002lW-65
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:37:03 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B05C4E6013;
 Mon, 16 Dec 2024 12:36:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LcRv9aCQNuir; Mon, 16 Dec 2024 12:36:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3566B4E602F; Mon, 16 Dec 2024 12:36:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 32F74746F60;
 Mon, 16 Dec 2024 12:36:54 +0100 (CET)
Date: Mon, 16 Dec 2024 12:36:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 06/24] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
In-Reply-To: <20241216035109.3486070-7-richard.henderson@linaro.org>
Message-ID: <1738e531-0f61-9b0e-c4ab-9879812e8d3e@eik.bme.hu>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
 <20241216035109.3486070-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 15 Dec 2024, Richard Henderson wrote:
> Do not register an empty set of properties.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> hw/ppc/spapr_nvdimm.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 2ef6f29f3d..6f875d73b2 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -884,22 +884,22 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
>     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
> }
>
> -static const Property spapr_nvdimm_properties[] = {
> #ifdef CONFIG_LIBPMEM
> +static const Property spapr_nvdimm_properties[] = {
>     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
> -#endif
> -    DEFINE_PROP_END_OF_LIST(),

Is it too early to remove END_OF_LIST in this patch?

Regards,
BALATON Zoltan

> };
> +#endif
>
> static void spapr_nvdimm_class_init(ObjectClass *oc, void *data)
> {
> -    DeviceClass *dc = DEVICE_CLASS(oc);
>     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
>
>     nvc->realize = spapr_nvdimm_realize;
>     nvc->unrealize = spapr_nvdimm_unrealize;
>
> -    device_class_set_props(dc, spapr_nvdimm_properties);
> +#ifdef CONFIG_LIBPMEM
> +    device_class_set_props(DEVICE_CLASS(oc), spapr_nvdimm_properties);
> +#endif
> }
>
> static void spapr_nvdimm_init(Object *obj)
>

