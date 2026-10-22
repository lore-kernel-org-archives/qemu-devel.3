Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I9w0su3+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1YY-0002wT-TK; Thu, 22 Oct 2026 18:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xK1YO-0002vW-Bw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:46:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xK1YM-0008Ia-2d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:46:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso141896f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792709187; x=1793313987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mQxyLPDRiFLfMiCILZwrHP1ZDNxwhKcamovn4mGlXGU=;
 b=I9w0su3+PrOfRQBqzc1B8FlrEp7QWpn01kf/DJ0dKt6AXBHMqlEu2msqkStak0k/Q4
 GLPuqzoocfNp3GR65lkJqsY5yXl2Yez+xbW0u/5/kiAuvdp+XfyOera9nVTwZmVf6QKO
 Wf+h2mPGUkWSZKp3GJI0+f5gHCAwnYpQw0qxpFc8TE2lt5zDtfwGzWfCxgLk/zrGWU/b
 GFpjsCcBXPKwQ52CYHGNGDltIW7rDmlOXCTXQMIT01mLGBzFeOtH/57xufh+gaYvZpPV
 yQVLxSJkQ75u3IvXzcAOAhNTB1x+DEVB8OerESG6lwSY5/WQ5MrOI0XTnruCIQ3Cg+iT
 eGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792709187; x=1793313987;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQxyLPDRiFLfMiCILZwrHP1ZDNxwhKcamovn4mGlXGU=;
 b=PL5P5g4EnPU7JF0h8t5soVWklJ0PoYsvv1NT4ZmzRVFYmYKsmqHyWvxQ8ehBVqBByG
 aEiulm9b0j0ULcBz7gSx2/SOdM9YhQDY+lHgKeEuALU3dz30YePte5BqLnpHUTFXZ8jr
 y+YQWAUX9bAIFD5lbM/GFcKgl32efLx9cEUxCPCYvQg9/0w+m1gtJo9rYshfGqL23RLY
 kqsZQPcpH41rJFOwPpfgAWL5bXvjQNXlN7bcju9sGj9R9x5XEqBtSOu3+RTOpk/6Y9w3
 L8EXjjTCKCM2uypTHp6g+5HVAhUbUTvhlylB5AY7U94Qj05sxcgL+EpqWh1qsJyZ5o7Q
 rJlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwozxulU9lCwSkLUGpPYySNYpSeTNmQBKXQlJw/Xkz1N6FzLr0bLbvTDzEflpm0vKDCTCZLmOLkdXsN@nongnu.org
X-Gm-Message-State: AFq9FYJs3AbSoIa1jHSDCOs1Mq6D7yDs/LxbwCJYhmZAbCEVdraoW4Lx
 i0HQ5dj1h0fRbbgQC7BgqE22YRIcUt726IapHYwgJaWNbJYTNXgHQrcfgDvhMQ==
X-Gm-Gg: AYBFou3VODfiO/HhSCtHN5bSCNs11QSb3aXy6FsdzZwPv6Vlm5uIa855+rBpgBzy84f
 pXR2H3vXiQfcD6J8KX1jmEnemLViDcJpqqQmA7fdPgHX2JHUeT+trsTvDqp/ORQ71f/2E6jSxtT
 ShTTjYdurPs9Ewpn4bJTEFGlu+oE8f+2uYtb8MlomVEJzl7Wq6wywVSRfk8z126+DULV1Evpv5D
 Lx35luX+MBhDW7kTj7qj0/sImNnAbwzZ51j16BzVBotXnElRKu8BMdlHEq8UZoFOpZktyqR3aqW
 /tZzI3rFlin8lRHDuy0oGv/PgIek/THRjEsXUxlzUuBLUVlqj7HszS4IJDLNhSvC5t085oicSIZ
 aV7gM4xpznELzTEv1Qti66uM7QK0x7HieOdRv0HtqkOfBoi8FdqgSEQJd4mkzEzNY/T085C6UwQ
 wFb2L+BvmkADUvE+Fmu8ytQioqM3tRatioP9NfzbFNcuBZjUINkrckbObWn9A/Gt+Ib8h5xdHAu
 a28TcaIqODi38qdhDaYUfDMKYj2av9SJzelKK7tUgC6G1Hvh4OQZJXKcq91nDWZHRS8I7CnrgEA
 tbJxEXRtQqG+8e1+z+TGB8nCOYD5S/SQdxLUew1ZDCRQibuZm279oD0Z3VhiXeAHGfUBiSfF
X-Received: by 2002:a05:6000:186e:b0:48d:f39b:83de with SMTP id
 ffacd0b85a97d-48e3854c650mr440207f8f.3.1792709186459; 
 Thu, 22 Oct 2026 15:46:26 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1dba-0000-ec6b-a832-f355-434e.310.pool.telefonica.de.
 [2a02:3100:1dba:0:ec6b:a832:f355:434e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3805c2c8sm792317f8f.48.2026.10.22.15.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 15:46:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:46:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_06/10=5D_hw/sd=3A_sdhci=3A_?=
 =?US-ASCII?Q?Honor_i=2EMX_uSDHC_vendor_clock_gates?=
In-Reply-To: <20261014045605.399684-7-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
 <20261014045605.399684-7-bin.meng@processmission.com>
Message-ID: <D3DE9BC4-6058-49C9-A6EE-67883C2FD6FE@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14=2E Oktober 2026 04:55:56 UTC schrieb Bin Meng <bin=2Emeng@processmis=
sion=2Ecom>:
>U-Boot enables i=2EMX uSDHC clocks through VEND_SPEC, so checking only
>the standard SDHCI clock-control bits drops commands and prevents
>firmware from loading its kernel from the SD card=2E
>
>Present vendor gates to the common clock check during uSDHC command
>writes, then restore the guest clock register=2E Retain the standard
>clock path used by Linux without adding vendor quirks to generic code=2E
>Report SDSTB and handle partial vendor accesses in uSDHC MMIO handlers=2E
>
>Reference: IMX6ULRM (Rev=2E2), sections 56=2E8=2E10, 56=2E8=2E12 and 56=
=2E8=2E26
>https://www=2Enxp=2Ecom/webapp/Download?colCode=3DIMX6ULRM
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>
>---
>
>(no changes since v3)
>
>Changes in v3:
>- Translate vendor gates in uSDHC MMIO instead of a generic quirk
>- Preserve the standard clock path used by direct Linux boot
>- Handle partial vendor accesses and report SDSTB in uSDHC reads
>- Migrate the vendor register in an optional subsection
>
> hw/sd/sdhci=2Ec | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 80 insertions(+), 13 deletions(-)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 0c5b0ed984=2E=2E1831e5e8ff 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -1604,6 +1604,24 @@ static const VMStateDescription sdhci_hostctl2_vms=
tate =3D {
>     },
> };
>=20
>+static bool sdhci_vendor_spec_vmstate_needed(void *opaque)
>+{
>+    SDHCIState *s =3D opaque;
>+
>+    return s->vendor_spec;
>+}
>+
>+static const VMStateDescription sdhci_vendor_spec_vmstate =3D {
>+    =2Ename =3D "sdhci/vendor-spec",
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>+    =2Eneeded =3D sdhci_vendor_spec_vmstate_needed,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_UINT16(vendor_spec, SDHCIState),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
> static bool sdhci_pending_insert_vmstate_needed(void *opaque)
> {
>     SDHCIState *s =3D opaque;
>@@ -1623,6 +1641,7 @@ static int sdhci_pre_load(void *opaque)
>     SDHCIState *s =3D opaque;
>=20
>     s->hostctl2 =3D 0;
>+    s->vendor_spec =3D 0;
>     s->sdma_boundary_paused =3D false;
>     return 0;
> }
>@@ -1698,6 +1717,7 @@ const VMStateDescription sdhci_vmstate =3D {
>     },
>     =2Esubsections =3D (const VMStateDescription * const []) {
>         &sdhci_hostctl2_vmstate,
>+        &sdhci_vendor_spec_vmstate,
>         &sdhci_pending_insert_vmstate,
>         &sdhci_sdma_boundary_paused_vmstate,
>         NULL
>@@ -1801,6 +1821,10 @@ static void sdhci_bus_class_init(ObjectClass *klas=
s, const void *data)
>=20
> #define ESDHC_VENDOR_SPEC               0xc0
> #define ESDHC_FRC_SDCLK_ON              (1 << 8)
>+#define ESDHC_VENDOR_IPGEN              (1 << 11)
>+#define ESDHC_VENDOR_HCKEN              (1 << 12)
>+#define ESDHC_VENDOR_PEREN              (1 << 13)
>+#define ESDHC_VENDOR_CKEN               (1 << 14)
>=20
> #define ESDHC_DLL_CTRL                  0x60
>=20
>@@ -2051,12 +2075,67 @@ static void fsl_esdhc_le_init(Object *obj)
>     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
> }
>=20
>+static bool usdhc_vendor_clocks_on(SDHCIState *s)

s could be pointer to const (though this isn't very common in QEMU, so no =
blocker)=2E

>+{
>+    uint16_t clocks =3D ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
>+                      ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
>+
>+    return (s->vendor_spec & clocks) =3D=3D clocks;
>+}
>+
>+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
>+{
>+    SDHCIState *s =3D SYSBUS_SDHCI(opaque);

No need for an explicit cast=2E

>+    uint32_t value;
>+
>+    switch (offset & ~3) {
>+    case SDHC_PRNSTS:
>+        value =3D esdhc_read(opaque, SDHC_PRNSTS, 4);
>+        if ((s->vendor_spec & (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN))=
 =3D=3D
>+            (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN)) {
>+            value |=3D ESDHC_PRNSTS_SDSTB;
>+        }
>+        break;
>+    case ESDHC_VENDOR_SPEC:
>+        value =3D s->vendor_spec;
>+        break;
>+    default:
>+        return esdhc_read(opaque, offset, size);
>+    }
>+    return extract32(value, (offset & 3) * 8, size * 8);
>+}
>+
> static void
> usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> {
>     SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>     uint32_t value =3D (uint32_t)val;
>=20
>+    if ((offset & ~3) =3D=3D ESDHC_VENDOR_SPEC) {
>+        value =3D deposit32(s->vendor_spec, (offset & 3) * 8,
>+                          size * 8, value);
>+        esdhc_write(opaque, ESDHC_VENDOR_SPEC, value, 4);
>+        return;
>+    }
>+    if ((offset & ~3) =3D=3D SDHC_CLKCON) {
>+        esdhc_write(opaque, offset, val, size);
>+        return;
>+    }
>+    if ((offset & ~3) =3D=3D SDHC_TRNMOD) {
>+        uint16_t clkcon =3D s->clkcon;
>+
>+        /* Present vendor clocks to the common command check */
>+        if (usdhc_vendor_clocks_on(s)) {
>+            s->clkcon |=3D SDHC_CLOCK_CHK_MASK;
>+        }
>+        if (offset =3D=3D SDHC_TRNMOD && size =3D=3D 4) {
>+            val |=3D s->trnmod;
>+        }
>+        sdhci_write(opaque, offset, val, size);
>+        s->clkcon =3D clkcon;
>+        return;
>+    }

Any reason why these if statements aren't incorporated into the switch sta=
tement below?

Best regards,
Bernhard

>+
>     switch (offset) {
>     case ESDHC_MIX_CTRL:
>         /*
>@@ -2076,18 +2155,6 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>         s->trnmod =3D value & UINT16_MAX;
>         break;
>=20
>-    case SDHC_TRNMOD:
>-        /*
>-         * Similar to above, but this time a write to "Command
>-         * Register" will be translated into a 4-byte write to
>-         * "Transfer Mode register" where lower 16-bit of value would
>-         * be set to zero=2E So what we do is fill those bits with
>-         * cached value from s->trnmod and let the SDHCI
>-         * infrastructure handle the rest
>-         */
>-        sdhci_write(opaque, offset, val | s->trnmod, size);
>-        break;
>-
>     default:
>         esdhc_write(opaque, offset, val, size);
>         break;
>@@ -2095,7 +2162,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
> }
>=20
> static const MemoryRegionOps usdhc_mmio_ops =3D {
>-    =2Eread =3D esdhc_read,
>+    =2Eread =3D usdhc_read,
>     =2Ewrite =3D usdhc_write,
>     =2Evalid =3D {
>         =2Emin_access_size =3D 1,

