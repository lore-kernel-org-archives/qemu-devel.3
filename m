Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F3606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpUKKtBz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6eB-0005rs-LB; Wed, 11 Nov 2026 06:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xR6eA-0005rX-CW
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:37:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xR6e8-0006mn-Ec
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:37:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so37563615e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794397063; x=1795001863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zKBdxMB6UtNxGZNhksSRBrQUO2gWC0ZYZYYSOib8wXo=;
 b=lpUKKtBzsRiFdYWPbSYPUm9GDfFjqb2X5FfVW6ihM0dOvMl3IV0oMr0IR2jAL8jwpK
 IxCFC+uLTpCz1TAip+AAfm6CiWaDfY+M4tV+gECatRhK99drakbiEQpUu2cJ8DQmh0S9
 u9bkUX/nWYSgv6Qps3hT6stPR3OK+ctwP8iRlvTGPrFy7KwFSrQXFctyqCL/ZEZq6tK5
 5kSyPnkNxKrzQaXlxLiofi0o44q9hZeXbVxHPsGfsdXyAvhcoDfWiezt8Y96QN8Nsvt1
 cmyDD9J5pFiZl2zFooKc/yVCPNcal/+CDp8BgFE9PQgYqq60u8uyKfSwzGUfozJCp6VB
 2k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794397063; x=1795001863;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zKBdxMB6UtNxGZNhksSRBrQUO2gWC0ZYZYYSOib8wXo=;
 b=Ic2UbyxgyyyaYvNP8WUlQ1evklmRzQfrz4W61u13IpZKkU5kr3p6iLQBLEQIX19UHl
 TiBHFyMDbYygGcEMwYxsQ1EQyAjwM0vtxyg2tAbLeuPMIB7OMUnKuLti0IbZd8EaX+5I
 PpyVGwjupv9m7VqIRGh7vSdCRT1DGp1NfAPRONBsijxe4utO34xdG1y/jGt7TPuhar94
 a8fUEuzgtwlRKGjEvqWftHkZTFkP1kEBKhhEh3fYLW9Zdb3HwatqmD8Vn7GBIOm94pjE
 ubx7QnbWhdABUK9Wg80K2whcrAdgkDT9vFdxzWSCa/G0VUuzqEyG2ozp3JS9WvH5CJDw
 /INA==
X-Forwarded-Encrypted: i=1;
 AL+hErEC9vBzOZkV5vkSqBfem71KhwGQBakOGkYUhazH5VLIaeQA2ZH1ToBsqA+eGndlW3mA43pytJX3PNQt@nongnu.org
X-Gm-Message-State: APuU4Z8kI5VV2e5lzCjj14w4sgSdMqeKhehWOn6XmfN8Bi7mkGHby/H8
 UuB496g8pdC07VY7rBWKy7m6cWUj6FSOtQwjDtM1R4K72v0uxbYozd7K
X-Gm-Gg: AYBFou0ZWxlvCMIhFzPxcJHDY/lTOd8cQwnjuV+ky/BOLPZgO2n6RM3krCBlrd2vSRC
 Q9H8YD4Z3K1GkLPidsRD1nosEDMzQf0bC68aUYJxo+/WFVmEumUYjmhGV/PrdFKjZShWrfNCfDF
 iLT6auxqaRPBmrnQoqk6hi/ITKMWjh5X3gtENrTwvmcSVfn8rcCoOsOmcdFBeJ3PlZN4Ak/0Yr4
 daxNDWvATEZ1g1rFWR4sOxyiq0g6PMplnUEOJ0Jm/8CdzOmsHP9yZZebxnPDGYV9TIn4oCP/4Je
 0kDRXz4XH1RT7XvzRIuSqGLzzDT+jc56eZrSqL1wc/jX5MS4zC7Xm4DkTw7sl3RD+UZAKVWPNw8
 6hJ8i8uegXHd2X/X4i2Kor8MqbrzWCYkwQXrhOIQo9i1xXt5NO3CuARzEYDu9gEUxfwUpD3LbL7
 VZqB4ZfN+1UcQ854IEshnkvAUOMTY5Uhv2ZDZ4Rwyp6P620R9oi+oFhfGhS+rKTzjwYJOH3oBB0
 14UQVm7MW1qrRoK939EC+tL7W4wOEU/Kkun0KVsE5Ga52sMoN+8kizKLa+5pBTSXLIkMG1821hq
 kx+3IheQQw6IWvW8h1qClnOazHlRo7SNJw==
X-Received: by 2002:a05:600c:c167:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4ba093acf6dmr34298495e9.33.1794397062620; 
 Wed, 11 Nov 2026 03:37:42 -0800 (PST)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm205775175e9.5.2026.11.11.03.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 03:37:42 -0800 (PST)
Date: Wed, 11 Nov 2026 11:37:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_09/11=5D_hw/arm=3A_Add_ITC?=
 =?US-ASCII?Q?M_and_DTCM_memory_regions_to_i=2EMX8MP?=
In-Reply-To: <20261007101105.3917771-10-gaurav.sharma_7@nxp.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
 <20261007101105.3917771-10-gaurav.sharma_7@nxp.com>
Message-ID: <0352957C-EE7D-47ED-B773-69F4F332EB1D@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 7=2E Oktober 2026 10:11:03 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7=
@nxp=2Ecom>:
>Add the 128 KiB ITCM and DTCM used by the i=2EMX8MP Cortex-M7
>subsystem=2E
>
>Expose ITCM and DTCM using the system-bus windows available to the
>Cortex-A53, and add the Cortex-M7-visible aliases at 0x00000000
>and 0x20000000 respectively=2E

We need a dedicated AddressSpace for the M7 where the aliases would be map=
ped=2E From the top of my head I think there is a link property in the cort=
ex-A7 CPU model's SysBusDevice named "memory" where the address map should =
be linked=2E See e=2Eg=2E "[PATCH v2 06/10] hw/riscv/atlantis: Add the RCPU=
 to the Atlantis SoC" for inspiration=2E

However, the address map should be added in the patch adding the M7 CPU=2E=
 This patch should only deal with the A53 memory map, and it could therefor=
e be moved somewhere in front of patch "[PATCH 04/11] hw/misc: Add i=2EMX8M=
P GPC (General Power Controller) IP"=2E

Best regards,
Bernhard

>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> hw/arm/fsl-imx8mp=2Ec         | 33 +++++++++++++++++++++++++++++++++
> include/hw/arm/fsl-imx8mp=2Eh |  4 ++++
> 2 files changed, 37 insertions(+)
>
>diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>index c168c97d1a=2E=2E18d2b17ca8 100644
>--- a/hw/arm/fsl-imx8mp=2Ec
>+++ b/hw/arm/fsl-imx8mp=2Ec
>@@ -779,6 +779,37 @@ static void fsl_imx8mp_realize(DeviceState *dev, Err=
or **errp)
>                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM]=2Ead=
dr,
>                                 &s->ocram);
>=20
>+    if (!memory_region_init_ram(&s->itcm, OBJECT(dev), "imx8mp=2Eitcm",
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=
=2Esize,
>+                                errp)) {
>+        return;
>+    }
>+    memory_region_add_subregion(get_system_memory(),
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=
=2Eaddr,
>+                                &s->itcm);
>+
>+    if (!memory_region_init_ram(&s->dtcm, OBJECT(dev), "imx8mp=2Edtcm",
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=
=2Esize,
>+                                errp)) {
>+        return;
>+    }
>+    memory_region_add_subregion(get_system_memory(),
>+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=
=2Eaddr,
>+                                &s->dtcm);
>+
>+    /* M7-view aliases: ITCM@0x0, DTCM@0x20000000 */
>+    memory_region_init_alias(&s->itcm_alias, OBJECT(dev), "imx8mp=2Eitcm=
-alias",
>+                             &s->itcm, 0,
>+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM]=2Esi=
ze);
>+    memory_region_add_subregion_overlap(get_system_memory(),
>+                                        0x00000000, &s->itcm_alias, 1);
>+
>+    memory_region_init_alias(&s->dtcm_alias, OBJECT(dev), "imx8mp=2Edtcm=
-alias",
>+                             &s->dtcm, 0,
>+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM]=2Esi=
ze);
>+    memory_region_add_subregion_overlap(get_system_memory(),
>+                                        0x20000000, &s->dtcm_alias, 1);
>+
>     /* Unimplemented devices */
>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
>         switch (i) {
>@@ -796,6 +827,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Erro=
r **errp)
>         case FSL_IMX8MP_IOMUXC_GPR:
>         case FSL_IMX8MP_MU_1_A =2E=2E=2E FSL_IMX8MP_MU_3_B:
>         case FSL_IMX8MP_OCRAM:
>+        case FSL_IMX8MP_TCM_ITCM:
>+        case FSL_IMX8MP_TCM_DTCM:
>         case FSL_IMX8MP_PCIE1:
>         case FSL_IMX8MP_PCIE_PHY1:
>         case FSL_IMX8MP_RAM:
>diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=2E=
h
>index f3e134cdc0=2E=2Ef547cbae42 100644
>--- a/include/hw/arm/fsl-imx8mp=2Eh
>+++ b/include/hw/arm/fsl-imx8mp=2Eh
>@@ -90,6 +90,10 @@ struct FslImx8mpState {
>     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
>     OrIRQState         gpt5_gpt6_irq;
>     MemoryRegion       ocram;
>+    MemoryRegion       itcm;
>+    MemoryRegion       dtcm;
>+    MemoryRegion       itcm_alias;
>+    MemoryRegion       dtcm_alias;
>=20
>     uint32_t           phy_num;
>     bool               phy_connected;

