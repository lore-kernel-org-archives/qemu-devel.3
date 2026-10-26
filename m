Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAC606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OMKswcv/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WvqksTMI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSk-0001xt-IN; Mon, 26 Oct 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSW-0001DC-Lo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSU-0000dI-FN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEwQR82082442
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9/nfVe/E/o+KMCT1SYzZIAhV/bjb3cYC6e+vDGtBZY=; b=OMKswcv/WP/C7Atu
 u5bdYJxuqxnsMUS9CmBqsxbWSzPI6brltD/psa+X2iwGrjfDYB095il9Ml+yWJzw
 ho/mZOHsUstWPTpq3gkS8rq6jZpeiRIGGTOptPukX6pT/N6Lv+lvjJDYDxOo9PRk
 zq/HlYLvH2+hjexcXRqNPwpnHfB9XmQaqRD260gXF3dvyZf+SdFpZLIr7ix86fKC
 9aLZZU/sfm//TKAWjEyLbcbovJhtmLi0enjVH4Vn/FGZX1YdIUBhKpg2C4oXAz4S
 PepIpCl5MAORT2EZ4/h3ftq5Tgsg4FTBph9r3DTKUyCHy7FDj0W4S48GZu+8CArG
 lBjTkg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsub3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso563654137.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031720; x=1793636520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S9/nfVe/E/o+KMCT1SYzZIAhV/bjb3cYC6e+vDGtBZY=;
 b=WvqksTMInjVvJykgQmpdz3dRQwRXNxFCdueHLLCqr96G05OScKk2RWtyatu9EoFelj
 PZZ5Cg2AL3mPDVovQrFZwttCsMQr+wdy3TUIWVf3WxN2YPjGOtd3UNY7RdKJXYdjUvuA
 FEQsCzod7naE8hKeZv29yxsNe4ZmQed5aCofGRFzoG0j37cJe6pyev4ZnR4D0BszK1Yv
 99gv5ysOWtSkXovXRP/+1z9V1Yh1BmU5Lg+w9fMY6wkYu7PKSoteBLX9lktM8/wce4/d
 aIUhr9XvITLRxpbxHs4zy6ClaZZVlIBHmQxgiUn5CO+luxfdsCZ05Uf3bbnWmVCBAWwW
 DGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031720; x=1793636520;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S9/nfVe/E/o+KMCT1SYzZIAhV/bjb3cYC6e+vDGtBZY=;
 b=RVqW0uoOPubgzW0M1iPANt0ztoyjx0toHCemZbzLg97VzumvNbqXA1Z+0irUj737cY
 wSD3//3Qj56zA1pvqcyIvHm7dg2G7B3aEzagYXbxAygJjzvPokQrY35z7awRAUoVRPfJ
 7WDWpGQpaPU/QrLHeY0lcVrAWRKk5ZoEYDa8gjiZRImpKmlYk/mKruV/JOTp7dMUmqC0
 ZccKGQQ7tpxHga75zd9O4tjLuQR6R+VK6mXdqtGrzubpxfeKIvBApRnzvREmElY1hUSN
 s//Zt/6yjG10+bU8RpipiMAjPAshPnb4lAuxG+n7YTsjWUYxUU/U8iqYswg0Kf1iIz8J
 sPww==
X-Gm-Message-State: AFq9FYJJvuC4uVi9j/mrN+N22C2mUTN8XlxXnN1YZN/5oajZpdKjDEw3
 7Fwece7k+S/tzywT016r0znntUYXiiTGpMvlr1usM43HdaVSJmga5i7doy/Y6me6Y2P43mNvY5S
 fwo3psbHANerK1a7CDApLy5k5YZVxTelXTvuiCARgs11jZ6ndC8H3Vmkxm41x1nOBKw==
X-Gm-Gg: AYBFou3kgKTcU0QTHRC97LREPsVtFlSyrDMsj2B+AJDJPyo8A1lvJ7n8p9WwRKCZbPN
 viht/1C5FLeRdKr13F92McHEb7pvKG7kXE+fIurrfsxw8eKgASoAKfFDE7xkSqm/C6w/YTKW2XF
 bm3nH0L6KsTo/AnY6E/5jIMEBegr0sTCaMWR+oVCJ98CgsUVETyepWKyTnXDQCDcVFEfA2DvIFQ
 aDFgXyCw/m7AcXn2+NfqG9SnVdP0Jtn06paRcgx9+8ZqQl5uEm302gOztSfppo0O0r2k7Q4UqF3
 YYacnvxIFO9Jou9yj+GZ28OjZRTjWoCJC5LgeirwY66zDAY59X3aUOXpPxKMHGMudnb8JupZJRI
 cjtAQrPXWfzeeXpp19SrfRW1BGlIAzJgBXnHTqowE
X-Received: by 2002:a05:6102:a187:10b0:7cc:b246:31e2 with SMTP id
 ada2fe7eead31-7ce5cdcaef7mr1328833137.22.1793031719692; 
 Mon, 26 Oct 2026 09:21:59 -0700 (PDT)
X-Received: by 2002:a05:6102:a187:10b0:7cc:b246:31e2 with SMTP id
 ada2fe7eead31-7ce5cdcaef7mr1328799137.22.1793031719196; 
 Mon, 26 Oct 2026 09:21:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a029332sm181367325e9.4.2026.10.26.09.21.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 11/14] target/mips: Add gen_li() helper
Date: Mon, 26 Oct 2026 17:20:30 +0100
Message-ID: <20261026162034.32711-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXz5aFDC6GfUPQ
 f443OlTxgMJodehezgpWp2cfFpxvAFi9yniX6+Xkvwc7YiqdEULbHoMVkucVBcf5rogknPFxDEy
 flKQHAtqurgpL2iGrXRRxGHKiiqJgmg=
X-Proofpoint-GUID: EXB4UY2x_7UX8dqSOTX01uwVKRj2AxLD
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf7e28 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ixn1CAxRAAAA:8 a=9wBE2GFEVIKmlDHdakoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=cvBusfyB2V15izCimMoJ:22 a=_0vDLAJOulx5KDpLVjVP:22
X-Proofpoint-ORIG-GUID: EXB4UY2x_7UX8dqSOTX01uwVKRj2AxLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX2cY+3XBsjARd
 WTHxooHsxe5gPJRZrCMR91CYBbFlfTgl5FvXCWt5G5IXwiiQYIbS7vf9bltyHnojStcUFcYvOmg
 luVedq4T5jdbzzh43sicA4b5CL2SmCQqggJcUL6ukb8hN0w/XE4v5dfo7MpJcL6n5G9Q/eFN0/w
 xuQ/QMRteEd9hov5xDVNqG79EBvxuR7tLqf4OoDafCyZF4WlD1WzOHgQve3+SvF4uBbIzEmz2As
 1ItWGG2Kjhf1wYWGdQEZGxP0tnGh53jilOcFILduo1nd+Rz8DWQv4CIP9Yjp7hoVdyAMYfTToyr
 6q1p7+r23b3Ld0KbWcQ3iNbXmRJkXKBXXnMReW0oExqtgnZ/3GljN2ZVC0wuYoaFq4afS+FKX7v
 KkZdSW3p7CYtEHCTyljZMQ2BQ06p/UWVAW9j/QM6CPuiqzmn1Y2h9Jm5zt2Fd81EcHlGb/WOjqK
 zto84D3gsthqSQjmawA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add gen_li() to load an immediate into a GPR, ignoring
writes to $zero.  It will be shared by the microMIPS,
MIPS16e and nanoMIPS LI decodetree conversions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.h        |  1 +
 target/mips/tcg/comput_translate.c | 21 +++++++++++++++++++++
 target/mips/tcg/meson.build        |  1 +
 3 files changed, 23 insertions(+)
 create mode 100644 target/mips/tcg/comput_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 50b62b9dfd28..71370f336dc1 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -169,6 +169,7 @@ void gen_store_fpr32(DisasContext *ctx, TCGv_i32 t, int reg);
 void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg);
 int get_fp_bit(int cc);
 
+void gen_li(DisasContext *ctx, int rd, int imm);
 void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop);
 void gen_ldxs(DisasContext *ctx, int base, int index, int rd);
 void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt, int bp);
diff --git a/target/mips/tcg/comput_translate.c b/target/mips/tcg/comput_translate.c
new file mode 100644
index 000000000000..9e809d613dc3
--- /dev/null
+++ b/target/mips/tcg/comput_translate.c
@@ -0,0 +1,21 @@
+/*
+ * MIPS emulation for QEMU - computational translation routines
+ *
+ * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* logical instructions */
+
+void gen_li(DisasContext *ctx, int rd, int imm)
+{
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    tcg_gen_movi_tl(cpu_gpr[rd], imm);
+}
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 644ca85f6390..833bf51ad0d5 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -19,6 +19,7 @@ gen = [
 
 mips_ss.add(gen)
 mips_ss.add(files(
+  'comput_translate.c',
   'dsp_helper.c',
   'exception.c',
   'fpu_helper.c',
-- 
2.55.0


