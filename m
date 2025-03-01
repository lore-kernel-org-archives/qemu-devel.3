Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C372C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 16:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toPJg-0004aD-7M; Sat, 01 Mar 2025 11:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toPJe-0004Zn-4a; Sat, 01 Mar 2025 11:03:50 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toPJc-0005kp-Ia; Sat, 01 Mar 2025 11:03:49 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 10CBB4E6069;
 Sat, 01 Mar 2025 17:03:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id nGia2JhuWlel; Sat,  1 Mar 2025 17:03:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 286034E603E; Sat, 01 Mar 2025 17:03:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 26F5B74577C;
 Sat, 01 Mar 2025 17:03:45 +0100 (CET)
Date: Sat, 1 Mar 2025 17:03:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: philmd@linaro.org
Subject: Re: [PATCH] hw/net/fsl_etsec: Set eTSEC device description and
 category
In-Reply-To: <20250218155407.838774E600E@zero.eik.bme.hu>
Message-ID: <141ff667-042b-f7a7-605e-bf4bfd654ecc@eik.bme.hu>
References: <20250218155407.838774E600E@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 18 Feb 2025, BALATON Zoltan wrote:
> Add description and set category for eTSEC device so it shows up
> better in -device help.

Ping?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/net/fsl_etsec/etsec.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 3ce4fa2662..adde644892 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -423,8 +423,10 @@ static void etsec_class_init(ObjectClass *klass, void *data)
>     DeviceClass *dc = DEVICE_CLASS(klass);
>
>     dc->realize = etsec_realize;
> +    dc->desc = "Freescale Enhanced Three-Speed Ethernet Controller";
>     device_class_set_legacy_reset(dc, etsec_reset);
>     device_class_set_props(dc, etsec_properties);
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> }
>
> static const TypeInfo etsec_types[] = {
>

