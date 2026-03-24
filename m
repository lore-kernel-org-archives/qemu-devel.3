Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F69FEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w574s-0000Om-QP; Tue, 24 Mar 2026 15:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w574q-0000N5-Sg
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:06:08 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w574o-0008Ck-U5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774379165; x=1774983965; i=xypron.glpk@gmx.de;
 bh=Vgd8fMRycG9E96MMASP9BCjVDXkqOHjQ4VAK6dF/c+g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ULrnkWh2m38zJywHIvtk7as6t7aOAxEw4uJZ0SGpLaRDQtcbBgiNfexDiwQAL2QA
 LHDEof+cjpQsjfz18V+FRmViyen7JQOJBfQ2yV6WwLnAcOj77dy5Zwh/Va/R1VKSI
 B8xjrLuG/07EGGNsy/Sfp4eeM3lRSNypz//hxF125zGfXZ7m2T63YDq755P4cL84B
 ADjD6hrjMbrcC8Lcj47cEncWUit8WnMYRIS3DMLHJlJdRfCTFGHhdpt9jYZ3Tdl0m
 6ju6XAda0y2D5zkOOqLm5SPo0AZhhLPWYov0sNajl0bKoRCvd3BT8/eY9mrUeV5gT
 //VgVEu6cyU9/GWlGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1w8hZg1BvR-00CnTu; Tue, 24
 Mar 2026 20:06:05 +0100
Date: Tue, 24 Mar 2026 20:06:03 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de
CC: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com, me@ziyao.cc,
 anshuld@ti.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] riscv: andes: Add Smstateen extension support
User-Agent: Thunderbird for Android
In-Reply-To: <203AE23D-AC3C-409D-B79C-8FF631D828E3@gmx.de>
References: <20260319082911.3270255-1-ycliang@andestech.com>
 <20260319082911.3270255-2-ycliang@andestech.com>
 <203AE23D-AC3C-409D-B79C-8FF631D828E3@gmx.de>
Message-ID: <B169E404-4EF5-4FD8-9E79-284BC34D4869@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jQiQ8IkeCWUvnSf1xCKUE2B2IMc5Fi7FHLP9Z46GKl3QpNM83Zq
 CDUiZbqqSdDAS1xW+QDx72921dM7xIeIlLKsS/WFghx+rEwGF8OqV+d+AofPIfUq+aCFZUf
 3/5qewLYAZp/52uzsGTHe1QMqQ/HFTCVlVfTRSfL1iZS0Jk68BjbjYr7QZwL7qXAuwr2fGf
 Ajh6CHbAl0T2VxZtzKM6g==
UI-OutboundReport: notjunk:1;M01:P0:ozdEAXcwCeA=;v5OKH8ZQ+bvcusIgPmt4e928Ys0
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=xypron.glpk@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24=2E M=C3=A4rz 2026 20:03:48 MEZ schrieb Heinrich Schuchardt <xypron=2E=
glpk@gmx=2Ede>:
>Am 19=2E M=C3=A4rz 2026 09:29:11 MEZ schrieb Leo Yu-Chi Liang <ycliang@an=
destech=2Ecom>:
>>Use the CSR detection mechanism to probe for the Smstateen extension
>>and initialize mstateen0/sstateen0 CSRs when present=2E
>>
>>The mstateen0 register is configured to allow S-mode access to fcsr,
>>AIA, IMSIC, indirect CSR access, environment configuration, and
>>sstateen0=2E The sstateen0 register enables U-mode access to compressed
>>extension state and fcsr=2E
>>
>>Supports both RV32 (using MSTATEEN0/MSTATEEN0H split) and RV64=2E
>
>Why is this change needed in U-Boot?
>Does EDK II do the same?
>Isn't this the kernel's job?

And why add this in Andes code and not in the generic code?

>
>Best regards
>
>Heinrich
>
>>
>>Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech=2Ecom>
>>---
>> arch/riscv/cpu/andes/cpu=2Ec   | 29 +++++++++++++++++++++++++++++
>> arch/riscv/include/asm/csr=2Eh | 15 +++++++++++++++
>> 2 files changed, 44 insertions(+)
>>
>>diff --git a/arch/riscv/cpu/andes/cpu=2Ec b/arch/riscv/cpu/andes/cpu=2Ec
>>index d25ecba0e88=2E=2Efeb755a4f0d 100644
>>--- a/arch/riscv/cpu/andes/cpu=2Ec
>>+++ b/arch/riscv/cpu/andes/cpu=2Ec
>>@@ -9,6 +9,7 @@
>> #include <irq_func=2Eh>
>> #include <asm/cache=2Eh>
>> #include <asm/csr=2Eh>
>>+#include <asm/csr_detect=2Eh>
>> #include <asm/arch-andes/csr=2Eh>
>>=20
>> /*
>>@@ -60,5 +61,33 @@ void harts_early_init(void)
>> 		mmisc_ctl_val |=3D MMISC_CTL_NON_BLOCKING_EN;
>>=20
>> 		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
>>+
>>+		/* Initialize Smstateen if the extension is present */
>>+		{
>>+			int trap =3D 0;
>>+			unsigned long long mstateen0;
>>+
>>+			mstateen0 =3D csr_read_allowed(CSR_MSTATEEN0, trap);
>>+			if (!trap) {
>>+#if __riscv_xlen =3D=3D 32
>>+				mstateen0 |=3D (unsigned long long)
>>+					csr_read(CSR_MSTATEEN0H) << 32;
>>+#endif
>>+				mstateen0 |=3D SMSTATEEN0_CS | SMSTATEEN0_FCSR |
>>+					     SMSTATEEN0_CONTEXT |
>>+					     SMSTATEEN0_IMSIC |
>>+					     SMSTATEEN0_AIA |
>>+					     SMSTATEEN0_CSRIND |
>>+					     SMSTATEEN0_ENVCFG |
>>+					     SMSTATEEN0_SE0;
>>+				csr_write(CSR_MSTATEEN0, mstateen0);
>>+#if __riscv_xlen =3D=3D 32
>>+				csr_write(CSR_MSTATEEN0H, mstateen0 >> 32);
>>+#endif
>>+				csr_write(CSR_SSTATEEN0,
>>+					  csr_read(CSR_SSTATEEN0) |
>>+					  SMSTATEEN0_CS | SMSTATEEN0_FCSR);
>>+			}
>>+		}
>> 	}
>> }
>>diff --git a/arch/riscv/include/asm/csr=2Eh b/arch/riscv/include/asm/csr=
=2Eh
>>index 986f951c31a=2E=2Ecef0fd906da 100644
>>--- a/arch/riscv/include/asm/csr=2Eh
>>+++ b/arch/riscv/include/asm/csr=2Eh
>>@@ -97,6 +97,18 @@
>> #define SIE_STIE		(_AC(0x1, UL) << IRQ_S_TIMER)
>> #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
>>=20
>>+/* Smstateen: mstateen0 / sstateen0 bit definitions */
>>+#define SMSTATEEN0_CS		(_AC(0x1, ULL) << 0)
>>+#define SMSTATEEN0_FCSR		(_AC(0x1, ULL) << 1)
>>+#define SMSTATEEN0_JVT		(_AC(0x1, ULL) << 2)
>>+#define SMSTATEEN0_CONTEXT	(_AC(0x1, ULL) << 57)
>>+#define SMSTATEEN0_IMSIC	(_AC(0x1, ULL) << 58)
>>+#define SMSTATEEN0_AIA		(_AC(0x1, ULL) << 59)
>>+#define SMSTATEEN0_CSRIND	(_AC(0x1, ULL) << 60)
>>+#define SMSTATEEN0_P1P13	(_AC(0x1, ULL) << 61)
>>+#define SMSTATEEN0_ENVCFG	(_AC(0x1, ULL) << 62)
>>+#define SMSTATEEN0_SE0		(_AC(0x1, ULL) << 63)
>>+
>> #define CSR_FCSR		0x003
>> #define CSR_CYCLE		0xc00
>> #define CSR_TIME		0xc01
>>@@ -105,6 +117,7 @@
>> #define CSR_SIE			0x104
>> #define CSR_STVEC		0x105
>> #define CSR_SCOUNTEREN		0x106
>>+#define CSR_SSTATEEN0		0x10c
>> #define CSR_SSCRATCH		0x140
>> #define CSR_SEPC		0x141
>> #define CSR_SCAUSE		0x142
>>@@ -126,6 +139,8 @@
>> #else
>> #define CSR_MCOUNTEREN		0x306
>> #endif
>>+#define CSR_MSTATEEN0		0x30c
>>+#define CSR_MSTATEEN0H		0x31c
>> #define CSR_MSCRATCH		0x340
>> #define CSR_MEPC		0x341
>> #define CSR_MCAUSE		0x342
>


