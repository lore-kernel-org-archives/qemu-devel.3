Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B7606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbn+LqnY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PBb3lk6p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IQ-0001ie-CF; Wed, 28 Oct 2026 15:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IL-0001NR-Jy
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IJ-0006Ed-It
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPj7E848557
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lBxgvbqkMWRbINx8X6/EZ+crGSfhZM2IgVCuySVP75I=; b=dbn+LqnY42PhLCJd
 dVYzrP78x9IAu0ezLz+XM2d1BhxAGhHNvrkbQP8c2R46qSEjNJimD4/VhM1L6ZYz
 TODoqquqBPuWFgQ52u/8zQLvqXbw+VFQ1y+H4ZxpXZsQKmUXHbBzYgjCuwY6SCnJ
 tTdvXOm7ckXtS+3Kwb+8vJI3/d25XoYaA6BqFBYdiysJ0/tqIrI4IUv3QHKmy4Bq
 9jhpkkJIxC6bmZlUuh04ZrNA6eiF7sePs/NfF/SKgmEW8MaT5IG+VYRGpvNuSPEs
 nuWpjyMMsaNHFsY2XbYUNKQeeDfef2WW6mliH86z90vH+0r6pEuqxLqhyNoqFIOz
 Af8X8g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp2jxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f6f4fe531so235974685a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215600; x=1793820400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lBxgvbqkMWRbINx8X6/EZ+crGSfhZM2IgVCuySVP75I=;
 b=PBb3lk6p0lwTq/TRLrFd2EcedYOJEOeIb01wMJTclZTba5pbYoEqAv/BuEiTj/k2ht
 7Zr8+Ygk86IYkIJG0elmcGZUt2j7/QmkSTXjTp/c+wy5eqqbOAE0rFyxqeUFpwFq+1ey
 CtUiQxs6KvGm6+YjDpapBzqrv/emOOXuUBkCb/aimwJNlhQFw1viSJqeBsQUthKv5QYC
 ZaN8QGCDJw6hhr2SVBi6ObCFqyER/O+ms/TPRD0YR+mJQMsqVZCOvETClRpXZdZ7h0E6
 44SIpIPtGVFNhCxjVj3SQV49GU3eKRPK0aHDBhvF5if7OZSGA9cx8mLAYQdSGYLkLWS7
 J+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215600; x=1793820400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lBxgvbqkMWRbINx8X6/EZ+crGSfhZM2IgVCuySVP75I=;
 b=NC3LL5rAKMLvB422PoVnxSD9yDhogAtW/Eipf65KudJPGdcx+YreVGjuxnTrz6rCU8
 tyDBV93Y3Y/te9gbAGZdDwHt/1Bgyoh+NfnxerUxfLLRbBV8eld3Cdm8me7u1+52pFJv
 epyKU9Jn6UEuf8Wayw4olB3DVKM0rP7pVTJj7boBFB81egr9xnzFKLKh6LooIfHRe9Ji
 RhcUl6KwjCdltlepp1Q7KHC6P3G4y398H8UjmEHCFDeCGiZQVwrhLfG4OI5dm6MkyjxJ
 z49oRPySIWk724NGyZSycbvxS7HbOXr0p+cxDCh9l/OjKkuw1e8101wWR9PksOMgrWa9
 dCEg==
X-Gm-Message-State: AFq9FYKj1HtmgXAu363tqw8fsIxaCxmzP3e+1LPrNR5NslpzkMP4AXz5
 9YInrwiHBzlDQtsJdrzyTIkcghOp9aODTQpoMGwtgrbEyMHUwYwGUieNhjWCkUS7YSTS57DQ+tF
 6cz/H3AEEdfk9adZENMcZ8WITpvzTbBI/r+xejj5gaIXuhpdJlu0P/M5xUogM77DMzPfF
X-Gm-Gg: AYBFou3Y28CpyQCbw57EOIz92d6UM/dnR9ok4ETTeh4/f9NaJeC03zhxXLGSVdWKKae
 HnWcWT5v/EfNjoRbf/AAdGI55w4VeNJQscI+iVPynsGKMSlmWHOUVt2nmWCzD42cmL9Em5wB4sX
 tB4a3IbfWswOu0n/b5DdYFzndIzQSDONdp94jDeBNFyjidOpHY7Kz69Jaedob+HnfkU0Orn+suY
 2qSom35bv81bqTpCz5H0F5RlxyR4i0INew2r7PwSPZZw1zTYNds6PuLHqrJOLK3oiKYtYwtZ8W9
 7d6ByysIXvg0RXg64A4uGz1nQvXIwhoI/aBAJfHTLGJ7n3r7Mop23CpfbZb76eUOi5ErFBuIOyo
 YbKtKmcGhs1c/wxzoNAMVdH9/scbScnktwdJAsoclytLWiX9qFCDFYfeubDgy3/XMNX72i/9k7g
 GITOH0wtjF+u3gdChtXJF52SkiGZVvpg==
X-Received: by 2002:a05:620a:4509:b0:93f:c0d:40a4 with SMTP id
 af79cd13be357-94408d8ae61mr478526585a.75.1793215600222; 
 Wed, 28 Oct 2026 12:26:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4509:b0:93f:c0d:40a4 with SMTP id
 af79cd13be357-94408d8ae61mr478522485a.75.1793215599593; 
 Wed, 28 Oct 2026 12:26:39 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm40606595e9.4.2026.10.28.12.26.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] target/mips: Expose R5900 registers to gdb
Date: Wed, 28 Oct 2026 20:25:36 +0100
Message-ID: <20261028192538.31600-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dkstztW1BMuS51Ba4yDXQ_IeDvea1Adh
X-Proofpoint-ORIG-GUID: dkstztW1BMuS51Ba4yDXQ_IeDvea1Adh
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae24c71 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PFyLnhpQ7rb4zKh9GroA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXxZJYZOnqxkfW
 7A5hFt9xICRQCxVM0K5sI2VeV5ISMJcTemv/z+0emo39xhE7HTQyu18xyNLHnqQr3dY5PLxyB9E
 g59GMWbk3ZRDmVeSOWaARG0+klxV/oQWDa5hKpk/GV5yc95BlMcF7Q1USvN7EYfxyntT7Ikxc4v
 2Xk6XPF7Ugyl9ftVAQUgcnW/zOzB+Aj3+0hfokfVsgY/ceqjHr/309YPBaQOrPXSQHZhJ3n+p5W
 ESbYYQ3QO6V12nLSckxsDMSjqxwYU4iVVQsTI+1aoWNManxsKqDGKidUJE3jc5X3Fwpcxt04fKD
 psBIkfwDkAxnhICGSymgCJsYPT+Nxlo2zejIDr5+LIlUNbDvWD+O8inOuacemzVBWuRzDsEx/eg
 qEKUo2vltodDY1g+IySORad42zZZMjbdQzrZNT7uqfkosp9zZh4HmB1KWDGgEUiSX0keGWlXI97
 zlkKjMY36JjPJ0COuJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX0xEwQv+5p72M
 NbDbveiHQJcHIQy6Y35jOP5bac10ORlmmYpwk9QIRZM5zqfvrbQWcrBSManwO8cRmJdCagV1JzD
 /g6TNu0CCPY/Uujxn+XOd5cWyT7oaa0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GDB has no knowledge of the R5900 LO1/HI1 registers and of the
upper halves of its 128-bit GPRs. Add a org.qemu.gdb.mips.r5900
feature with lo1, hi1 and r0_hi..r31_hi, transferred as 64-bit.

Unfortunately we need to gate on TARGET_MIPS64 because the
gpr_hi[] upper halves are only declared there.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 configs/targets/mips64-softmmu.mak   |  2 +-
 configs/targets/mips64el-softmmu.mak |  2 +-
 target/mips/gdbstub.c                | 46 +++++++++++++++++++++++++++
 gdbstub/gdb-xml/mips64-r5900.xml     | 47 ++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml

diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index 03db5ef74abc..b96e91559c9a 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -3,4 +3,4 @@ TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml mips64-r5900.xml
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index b3433d8cf7ab..089f2c0c7c43 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -2,4 +2,4 @@ TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml mips64-r5900.xml
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index e21eb6f67fbd..3678f2c696c8 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -243,6 +243,45 @@ static int mips_gdb_write_fpu(CPUState *cs, uint8_t *buf, int n)
                                        MIPS_GDB_FPU_LEGACY_BASE + n);
 }
 
+#if defined(TARGET_MIPS64)
+/* org.qemu.gdb.mips.r5900: lo1, hi1, r0_hi..r31_hi */
+static int r5900_gdb_read_regs(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUMIPSState *env = cpu_env(cs);
+
+    switch (n) {
+    case 0:
+        return gdb_get_reg64(buf, env->active_tc.LO[1]);
+    case 1:
+        return gdb_get_reg64(buf, env->active_tc.HI[1]);
+    default:
+        return gdb_get_reg64(buf, env->active_tc.gpr_hi[n - 2]);
+    }
+}
+
+static int r5900_gdb_write_regs(CPUState *cs, uint8_t *buf, int n)
+{
+    CPUMIPSState *env = cpu_env(cs);
+    uint64_t val = ldn_p(buf, 8);
+
+    switch (n) {
+    case 0:
+        env->active_tc.LO[1] = val;
+        break;
+    case 1:
+        env->active_tc.HI[1] = val;
+        break;
+    case 2:
+        /* r0 is hardwired to zero */
+        break;
+    default:
+        env->active_tc.gpr_hi[n - 2] = val;
+        break;
+    }
+    return 8;
+}
+#endif /* TARGET_MIPS64 */
+
 void mips_cpu_gdb_class_init_xml(CPUClass *cc)
 {
     cc->gdb_core_xml_file = target_long_bits() == 64 ? "mips64-cpu.xml"
@@ -262,4 +301,11 @@ void mips_cpu_register_gdb_regs(CPUState *cs)
                              gdb_find_static_feature(cp0_xml));
     gdb_register_coprocessor(cs, mips_gdb_read_fpu, mips_gdb_write_fpu,
                              gdb_find_static_feature(fpu_xml));
+
+#if defined(TARGET_MIPS64)
+    if (MIPS_CPU_GET_CLASS(cs)->cpu_def->insn_flags & INSN_R5900) {
+        gdb_register_coprocessor(cs, r5900_gdb_read_regs, r5900_gdb_write_regs,
+                                 gdb_find_static_feature("mips64-r5900.xml"));
+    }
+#endif
 }
diff --git a/gdbstub/gdb-xml/mips64-r5900.xml b/gdbstub/gdb-xml/mips64-r5900.xml
new file mode 100644
index 000000000000..6c03849824de
--- /dev/null
+++ b/gdbstub/gdb-xml/mips64-r5900.xml
@@ -0,0 +1,47 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!--
+     Toshiba R5900 specific registers:
+     - LO1/HI1, the pipeline 1 multiply/divide unit results;
+     - the upper 64 bits of the 128-bit general purpose registers.
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.qemu.gdb.mips.r5900">
+  <reg name="lo1" bitsize="64" type="int64"/>
+  <reg name="hi1" bitsize="64" type="int64"/>
+
+  <reg name="r0_hi" bitsize="64" type="uint64"/>
+  <reg name="r1_hi" bitsize="64" type="uint64"/>
+  <reg name="r2_hi" bitsize="64" type="uint64"/>
+  <reg name="r3_hi" bitsize="64" type="uint64"/>
+  <reg name="r4_hi" bitsize="64" type="uint64"/>
+  <reg name="r5_hi" bitsize="64" type="uint64"/>
+  <reg name="r6_hi" bitsize="64" type="uint64"/>
+  <reg name="r7_hi" bitsize="64" type="uint64"/>
+  <reg name="r8_hi" bitsize="64" type="uint64"/>
+  <reg name="r9_hi" bitsize="64" type="uint64"/>
+  <reg name="r10_hi" bitsize="64" type="uint64"/>
+  <reg name="r11_hi" bitsize="64" type="uint64"/>
+  <reg name="r12_hi" bitsize="64" type="uint64"/>
+  <reg name="r13_hi" bitsize="64" type="uint64"/>
+  <reg name="r14_hi" bitsize="64" type="uint64"/>
+  <reg name="r15_hi" bitsize="64" type="uint64"/>
+  <reg name="r16_hi" bitsize="64" type="uint64"/>
+  <reg name="r17_hi" bitsize="64" type="uint64"/>
+  <reg name="r18_hi" bitsize="64" type="uint64"/>
+  <reg name="r19_hi" bitsize="64" type="uint64"/>
+  <reg name="r20_hi" bitsize="64" type="uint64"/>
+  <reg name="r21_hi" bitsize="64" type="uint64"/>
+  <reg name="r22_hi" bitsize="64" type="uint64"/>
+  <reg name="r23_hi" bitsize="64" type="uint64"/>
+  <reg name="r24_hi" bitsize="64" type="uint64"/>
+  <reg name="r25_hi" bitsize="64" type="uint64"/>
+  <reg name="r26_hi" bitsize="64" type="uint64"/>
+  <reg name="r27_hi" bitsize="64" type="uint64"/>
+  <reg name="r28_hi" bitsize="64" type="uint64"/>
+  <reg name="r29_hi" bitsize="64" type="uint64"/>
+  <reg name="r30_hi" bitsize="64" type="uint64"/>
+  <reg name="r31_hi" bitsize="64" type="uint64"/>
+</feature>
-- 
2.55.0


