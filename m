Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E65606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/9KH2Sk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C1iBgj5Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSJL-0003vr-3R; Fri, 06 Nov 2026 17:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xPSJH-0003rg-DQ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xPSJF-0001hl-5N
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794003680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aPXZnSN0tabFYKApU1EKc9dw3itHe8SGrVWPTAF1UU=;
 b=N/9KH2SkF6lpY2HkyvVoX74sNe2RUgToZHcS8V68yp3M8SWJ/GtlJ50h9upbtzkv/10n5c
 M/6cJ63JqZCSXVLY71znckCDTpXjh/jGGoAMRFx+zwyZwhqiJU2HjG6ahKGlrfRSR+EY5l
 DrWqGanmcvjWY1Jlbsl53wdego6sdn4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-9_Il9YFvNXCE2x8QADM5xg-1; Fri, 06 Nov 2026 17:21:18 -0500
X-MC-Unique: 9_Il9YFvNXCE2x8QADM5xg-1
X-Mimecast-MFC-AGG-ID: 9_Il9YFvNXCE2x8QADM5xg_1794003678
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a214a5f8a1so11991515e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 14:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794003677; x=1794608477; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/aPXZnSN0tabFYKApU1EKc9dw3itHe8SGrVWPTAF1UU=;
 b=C1iBgj5YFGCS2r+d5814HSBTRbMX0wDVxwD3thBu9bh3i8Y7BxR2edcAyshBsPl4kD
 e5342+m7j/gYy3o5LC77SG/s7LvEYmqGHEZN/fkcczLZjgDFoOacbPF9dch+O+msIkTj
 setwYRDe4VSLC9yC/Q+7PdQMRnJj3rJiEZIZyttp3ChT35eo8iF/I8VX/FjvpBWsd2uZ
 vIAHTEiQOiHGR0pJnpWXV1oNhmw5l1j3JSf1PhRx1PwxAmdgwuPitGdXHk/wZDp3ZKD0
 C078umwvVeebPAtt6nG0uyRbaU4c8oqZIJM+NcRzUBA3W+gJzqhEUj8IDqMPffqBYsu4
 bjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794003677; x=1794608477;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/aPXZnSN0tabFYKApU1EKc9dw3itHe8SGrVWPTAF1UU=;
 b=FMJ41zKTE2R8joUt07us6QGOifcY8KEA3ztdLQsnoFDWnZuO0h5Ix43cFt4Klu3ogP
 S5ZcUhoz0cYg+MQ0eHPgWgh2KYZArMc3j253xPB1jAP/efq0xR493uJMIJJmWZ6BQ95C
 bHHAVlsz8BcZ0Ba0q4y5f3Zpi6P9q9jBAfXGRcHgWSfsIJ5+0loQ13KL6Rzd8Hw6tMgl
 2jXeM6pAh3fHb9niukEE1hUlElhX92K40+dnnsi6g4obBzH5x5K4D50Zw4lIPDPrZO9D
 rBNlcEk08wcQeaqeRolJrbdo95Oh/eIP3u9vNDp6mkkyN3gZGdAh3mSrO7aZSZV9ObJj
 LWEg==
X-Gm-Message-State: APuU4Z8CQyUAPbNDlZrY0MjYq6pNLn9uPtYR+xRofLfGnO//vE70gGue
 lG+kIO26uZF51Z42EWN7AtH7mPTNXY19nTAUcMiVcYRaHnCFA+svH9nB3W22A1zRBCYWg+sLpxG
 u/qMaOqpkEtMLFdlI5xqTMYffCFoY+pPNZbK0tGokOjK7mb2vb0JzKEMU
X-Gm-Gg: AYBFou0m1HYJ54xyZZqD4Eqb3ZdHhErM3/dsHZIExMdG3fV/xa4tYsGUYnTQptkIj41
 Wqc6uXp7cafqFTntnYujlbaNiKIGdT/5oA1grgFpWx+a8+qXEUwUZEiJ9VF7hlDcVIrhe6+v98T
 uALFVKabwK36G5qxGy9zkQJ2YS0dpEI0gz8A4hKlT0uLD4NPUJybu5vl7SxNlKyJABdtdnhGrH6
 cm5kw3XSwtR2SshyrR9rySbzz+L4HLYKZzN99oifSNLUrGpTGxxZufhTQBMTVIRy6CO2bmtd0q7
 NTof3SSTFJKdO38qnuIDdsz22Yk8xDIDd1anxJUkhC/3fkc8flsimgxCYlRIkkKhKfs2PjmDI/g
 5Tax6t9SR738qvHDrbAgnfAiNstcmh5pA
X-Received: by 2002:a05:600c:c085:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4b6e5ab81bemr49740745e9.15.1794003677639; 
 Fri, 06 Nov 2026 14:21:17 -0800 (PST)
X-Received: by 2002:a05:600c:c085:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4b6e5ab81bemr49740635e9.15.1794003677350; 
 Fri, 06 Nov 2026 14:21:17 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7dbb0d4sm5952018f8f.50.2026.11.06.14.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 14:21:16 -0800 (PST)
Date: Fri, 6 Nov 2026 23:21:12 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref.c: Increase SMMU space for Root
 registers
Message-ID: <dxrwkmt76n62imxwycc6j2mcjihdhqmhukzc3ypojuepkprzsp@dm4yqcp75wrt>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
 <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-jmac-smmu-root-registers-v1-2-e78e8879d347@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jim,

On Fri, Oct 16, 2026 at 10:40:52AM +0100, Jim MacArthur wrote:
> In our implementation, SMMU Root registers are directly after the
> non-optional SMMU registers. Realms registers will be added above the
> root registers later.

nit: Root registers


> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 158b461eb4..0747f5ca9f 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -129,7 +129,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
>      [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
>      [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
> -    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
> +    [SBSA_SMMU] =               { 0x60050000, 0x00040000 },

Why +0x20000 bytes here instead of +0x10000 bytes (1 x 64K page)?

Most importantly, incresing the size of the SBSA_SMMU index is not enough, we
need to increase also the size of the "arm-smmuv3" container (memory region).

With this change applied I still see:

0000000060050000-000000006006ffff (prio 0, i/o): arm-smmuv3

on (qemu) info mtree.

2 x 64K pages: Page 0 and Page 1. Rather we should see a range to fit 3 x 64K:

0000000060050000-000000006007ffff (prio 0, i/o): arm-smmuv3

Another issue, afaics, is that the Root register page will be added to
every machine that uses the SMMUv3 device, right? Because we're not gating the
addition of Root registers based on the presence of RME.

So I think we should add one boolean "x-root" property (flag) to the SMMUv3
device that will be used to increase the size of the "arm-smmuv3" if it's set
and let it by default set to "false".

This "x-root" property would be set at the machine level, so via
object_property_set_bool() in create_smmu. For example:

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 0747f5ca9f..36b0164510 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -630,6 +630,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
                              &error_abort);
     object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
                              &error_abort);
+    object_property_set_bool(OBJECT(dev), "x-root", true, &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9d9bc2601b..9912fbf920 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2267,6 +2267,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
+    uint64_t size = SMMUV3_REGS_SIZE;
 
     if (!smmu_validate_property(s, errp)) {
         return;
@@ -2291,8 +2292,12 @@ static void smmu_realize(DeviceState *d, Error **errp)
 
     qemu_mutex_init(&s->mutex);
 
+    if (s->has_root) {
+        size += SMMUV3_ROOT_PAGE_SIZE;
+    }
+
     memory_region_init_io(&sys->iomem, OBJECT(s),
-                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
+                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, size);
 
     sys->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION;
 
@@ -2382,6 +2387,7 @@ static const Property smmuv3_properties[] = {
     /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
     DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
+    DEFINE_PROP_BOOL("x-root", SMMUv3State, has_root, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /*
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index a538334066..5d1cb759c3 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -411,7 +411,10 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
 
 #define A_IDREGS           0xfd0
 
-#define SMMU_ROOT_REG_START 0x20000
+#define SMMUV3_PAGE_SIZE        0x10000
+#define SMMUV3_REGS_SIZE        (2 * SMMUV3_PAGE_SIZE) /* Page 0 and Page 1 */
+#define SMMUV3_ROOT_REG_OFFSET  0x20000
+#define SMMUV3_ROOT_PAGE_SIZE   SMMUV3_PAGE_SIZE
 
 REG32(ROOT_IDR0,            0x0)
     FIELD(ROOT_IDR0, ROOT_IMPL,   0,  1)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e2708e13fe..a8b354438c 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -92,6 +92,7 @@ struct SMMUv3State {
     OnOffAuto cmdqv;
 
     Notifier machine_done;
+    bool has_root;
     SMMUv3RootRegBank root;
 };


Cheers,
Gustavo

>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
>      [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
> 
> -- 
> 2.43.0
> 
> 


