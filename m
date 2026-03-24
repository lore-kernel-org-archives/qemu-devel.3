Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECBBFEC0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56v9-0004X7-2K; Tue, 24 Mar 2026 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w56v6-0004Wr-Mt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:04 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xypron.glpk@gmx.de>)
 id 1w56v2-0006d4-Um
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774378540; x=1774983340; i=xypron.glpk@gmx.de;
 bh=/cymX/6jnUG2a13heIXwFZWKhER/4Soc5jPuwy3nfgc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PAAIYDMmRFSaaxpqMdBRFciErfDr4kfLsEH/0cHVBDnVpAOHPxhK/gmM0cWsjH50
 W15CjsvECHw7SqGD59EVvSHFEILbo49PXNkAVGGKXXxlNv68KiAz6PUdkT8byCrFi
 +vSWUbkI3BnmWJarhX3LwLKGROPQiCyccmB3YjCGD1T15g2q3mUCXZt3HVnwK1Rqp
 HPXqE+Pk6KRUZ0lfCOs7R2N8kP5oMvb1ndPlgYp8RYAsfdDV19hMpEpHZNH/NiM5Z
 1NNbFHi2jZIo41h5GzAfSnbI87Fjt9FBYt5ZFXCfeyP5OnNFTtzk/hiC2cO3hwCCz
 +zxt+bGdM1xlitbtuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1vrY910YFf-00Vqnm; Tue, 24
 Mar 2026 19:55:40 +0100
Date: Tue, 24 Mar 2026 19:55:35 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de
CC: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com, me@ziyao.cc,
 anshuld@ti.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] riscv: Add CSR detection support
User-Agent: Thunderbird for Android
In-Reply-To: <20260319082911.3270255-1-ycliang@andestech.com>
References: <20260319082911.3270255-1-ycliang@andestech.com>
Message-ID: <9E0E8083-2F08-4621-AD8C-E8B7AA91F205@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oCabSaglRq9UBn7Xq63AEZW9y7RLlHw+mm267lA5DSQ1nebb3QR
 p7M+tzzARYRbnAn2O7DO+lHVuKSMk8KNreFXhXD8GQPawrVAETXyKPNZ2J8qx8Tz0PzJl1A
 0Qtl1vI0VNxvJwPJ4H8cbGxki1j594G1PTjiK1pOpEsACcogvyLwqi9KdnrmLoDbUVfjW7i
 WNs3D5/jSahCG80zHnXtA==
UI-OutboundReport: notjunk:1;M01:P0:b1zjxN6nkNc=;fRQEtvWzYHJaqwUnMxSavp/MsjT
 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
 FOX80ze2f6FkohNWWcU+oo6A==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=xypron.glpk@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 19=2E M=C3=A4rz 2026 09:29:10 MEZ schrieb Leo Yu-Chi Liang <ycliang@ande=
stech=2Ecom>:
>Add a lightweight mechanism to safely probe CSRs that may not exist
>on the current hart=2E This is useful for detecting optional extensions
>(e=2Eg=2E Smstateen) without relying on MARCHID or ISA string parsing=2E
>
>The implementation consists of:
>- A minimal expected trap handler (__riscv_expected_trap) that advances
>  past the faulting instruction and signals the trap via register a4=2E
>- csr_read_allowed() and csr_write_allowed() macros that temporarily
>  swap the trap vector, attempt the CSR access, and report whether it
>  trapped=2E
>
>Ported from OpenSBI's sbi_csr_detect=2Eh mechanism=2E

We already have a more generic mechanism for catching exceptions on RISC-V=
=2E See functions  riscv_zkr_bind() and set_resume()=2E

Do we really need a second mechanism?

Best regards

Heinrich


>
>Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech=2Ecom>
>---
> arch/riscv/include/asm/csr_detect=2Eh | 90 +++++++++++++++++++++++++++++
> arch/riscv/lib/Makefile             |  1 +
> arch/riscv/lib/csr_detect=2ES         | 23 ++++++++
> 3 files changed, 114 insertions(+)
> create mode 100644 arch/riscv/include/asm/csr_detect=2Eh
> create mode 100644 arch/riscv/lib/csr_detect=2ES
>
>diff --git a/arch/riscv/include/asm/csr_detect=2Eh b/arch/riscv/include/a=
sm/csr_detect=2Eh
>new file mode 100644
>index 00000000000=2E=2Ec058b6b85ea
>--- /dev/null
>+++ b/arch/riscv/include/asm/csr_detect=2Eh
>@@ -0,0 +1,90 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * Copyright (C) 2026 Andes Technology Corporation
>+ * Leo Yu-Chi Liang <ycliang@andestech=2Ecom>
>+ *
>+ * RISC-V CSR detection support
>+ *
>+ * Provides macros to safely probe CSRs that may not exist on the
>+ * current hart=2E Uses a lightweight trap handler that simply advances
>+ * past the faulting instruction and sets a flag=2E
>+ *
>+ * Ported from OpenSBI's sbi_csr_detect=2Eh=2E
>+ */
>+
>+#ifndef _ASM_RISCV_CSR_DETECT_H
>+#define _ASM_RISCV_CSR_DETECT_H
>+
>+#include <asm/csr=2Eh>
>+
>+#ifndef __ASSEMBLY__
>+
>+/* Two-level stringification so CSR macros are expanded before quoting *=
/
>+#define __CSR_DETECT_XSTR(x)	#x
>+#define __CSR_DETECT_STR(x)	__CSR_DETECT_XSTR(x)
>+
>+#if CONFIG_IS_ENABLED(RISCV_SMODE)
>+#define CSR_XTVEC	CSR_STVEC
>+#else
>+#define CSR_XTVEC	CSR_MTVEC
>+#endif
>+
>+void __riscv_expected_trap(void);
>+
>+/**
>+ * csr_read_allowed() - Read a CSR, detecting illegal-instruction traps=
=2E
>+ * @csr_num:	CSR number (must be a compile-time constant)=2E
>+ * @trap:	lvalue that is set to 1 if the access trapped, 0 otherwise=2E
>+ *
>+ * Returns the CSR value on success, or 0 if the CSR does not exist=2E
>+ *
>+ * This works by temporarily installing a minimal trap handler that
>+ * skips the faulting instruction and sets register a4 to 1=2E Interrupt=
s
>+ * must be disabled when calling this macro (they normally are during
>+ * early init)=2E
>+ */
>+#define csr_read_allowed(csr_num, trap)					\
>+({									\
>+	register unsigned long __mtvec =3D				\
>+		(unsigned long)__riscv_expected_trap;			\
>+	register unsigned long __trap asm("a4") =3D 0;			\
>+	register unsigned long __ret =3D 0;				\
>+	__asm__ __volatile__(						\
>+		"csrrw %[mtvec], "					\
>+			__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]\n"	\
>+		"csrr %[ret], " __ASM_STR(csr_num) "\n"		\
>+		"csrw "	__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]"	\
>+		: [mtvec] "+&r"(__mtvec), [ret] "=3D&r"(__ret),		\
>+		  [trap] "+&r"(__trap)					\
>+		:							\
>+		: "memory");						\
>+	trap =3D __trap;							\
>+	__ret;								\
>+})
>+
>+/**
>+ * csr_write_allowed() - Write a CSR, detecting illegal-instruction trap=
s=2E
>+ * @csr_num:	CSR number (must be a compile-time constant)=2E
>+ * @trap:	lvalue that is set to 1 if the access trapped, 0 otherwise=2E
>+ * @value:	Value to write=2E
>+ */
>+#define csr_write_allowed(csr_num, trap, value)				\
>+({									\
>+	register unsigned long __mtvec =3D				\
>+		(unsigned long)__riscv_expected_trap;			\
>+	register unsigned long __trap asm("a4") =3D 0;			\
>+	register unsigned long __val =3D (unsigned long)(value);		\
>+	__asm__ __volatile__(						\
>+		"csrrw %[mtvec], "					\
>+			__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]\n"	\
>+		"csrw " __ASM_STR(csr_num) ", %[val]\n"		\
>+		"csrw "	__CSR_DETECT_STR(CSR_XTVEC) ", %[mtvec]"	\
>+		: [mtvec] "+&r"(__mtvec), [trap] "+&r"(__trap)		\
>+		: [val] "rK"(__val)					\
>+		: "memory");						\
>+	trap =3D __trap;							\
>+})
>+
>+#endif /* !__ASSEMBLY__ */
>+
>+#endif /* _ASM_RISCV_CSR_DETECT_H */
>diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
>index a527b3e9ae3=2E=2E42463b8bed0 100644
>--- a/arch/riscv/lib/Makefile
>+++ b/arch/riscv/lib/Makefile
>@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)LIB_BOOTM) +=3D bootm=2Eo
> obj-$(CONFIG_$(PHASE_)LIB_BOOTI) +=3D image=2Eo
> obj-$(CONFIG_CMD_GO) +=3D boot=2Eo
> obj-y	+=3D cache=2Eo
>+obj-y	+=3D csr_detect=2Eo
> obj-$(CONFIG_SIFIVE_CACHE) +=3D sifive_cache=2Eo
> obj-$(CONFIG_SYS_CACHE_THEAD_CMO) +=3D thead_cmo=2Eo
> ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
>diff --git a/arch/riscv/lib/csr_detect=2ES b/arch/riscv/lib/csr_detect=2E=
S
>new file mode 100644
>index 00000000000=2E=2E69c4b8e7933
>--- /dev/null
>+++ b/arch/riscv/lib/csr_detect=2ES
>@@ -0,0 +1,23 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * RISC-V CSR detection support
>+ *
>+ * Copyright (C) 2025 Andes Technology Corporation
>+ * Leo Yu-Chi Liang <ycliang@andestech=2Ecom>
>+ *
>+ * Ported from OpenSBI's expected trap mechanism=2E
>+ */
>+
>+#include <asm/encoding=2Eh>
>+
>+	=2Etext
>+	=2Ealign 2
>+	=2Eglobal __riscv_expected_trap
>+__riscv_expected_trap:
>+	/* Advance past the faulting instruction */
>+	csrr	a4, MODE_PREFIX(epc)
>+	addi	a4, a4, 4
>+	csrw	MODE_PREFIX(epc), a4
>+	/* Set a4 =3D 1 to signal that a trap occurred */
>+	li	a4, 1
>+	MODE_PREFIX(ret)


