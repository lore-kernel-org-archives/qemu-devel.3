Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E118606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LaVxI+lJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ibFC7lHt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4kO-0005iB-4X; Wed, 28 Oct 2026 10:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4j1-00051N-SR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:34:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4iu-0004Ss-Pl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SDI6sn718092
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kDWTymZYQGoacUv9TB5H54Z88VJQmmNX1/Q34guwBF4=; b=LaVxI+lJZ2G+FK/X
 y0OI437UW3zu3X2cyXrM6kBdKFxssqNreHuPhAmg9ElKOYVo2mkE+z/pi2HnowkU
 WrhrCzXRnBZ7RZDb9qOqqfpQP6Qyi2Uth1o1m625rKFh1ObZ4ZrZmcAw4AbBbn+D
 CuR++rJfpuAWbdM+O8dwlNynHl/rx618taxVdrIQ76z7UiAtDrSKq1LRFkXvWvWi
 tkNUT/xX83V5FvTZuXbFKS33Bb0ue+8HekJvqCHw9YtS5YXVzz+/oAuLeO06K9TX
 0dKuVjKbgEBwRJcOeh1u57p97+68G5CzF5VlejDzLQEXcF/9mBsvjlGZDn2+FTRw
 l0Oyng==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjgagk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7a26f892so22781126d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793198029; x=1793802829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kDWTymZYQGoacUv9TB5H54Z88VJQmmNX1/Q34guwBF4=;
 b=ibFC7lHt6EhZ56biJQG/oKr40X80tXBkNLGHSH//621eFAj0nkd+P86EV/lAbQaQXc
 xotX4dJbTM9jVZrVB/oLTdzS0PbHXR8O4cx6rMlFnHSAc0w+1d4PRFCwR5xKi4bG4pto
 lmB++0uRUnwIPRzmm0gzUN8yNKZmfVGyxwP1VmjjktoVOM9fAuNJzLzCor1ixKPYILqO
 26GCMnlQmgoA8wxj/exUsmKwJh1EcV+tRkLZcaZkLtItscHsl54TiEppcDxF0hz98GsE
 94JMcfYNIBvDnK+VHFiPj9ZvnKz8kdO7cq5dzR0navnExJFW190zzG/xdcPS7UC3kug/
 +cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198029; x=1793802829;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDWTymZYQGoacUv9TB5H54Z88VJQmmNX1/Q34guwBF4=;
 b=BgKraXO5RicJNi4xj0MluL0qOti/6Q4e7pXWUYGPo4BGR/v83suGEBcWq3U0SM+u7j
 m/OvWtXis/vv/sEZkHIDYcu6DDUQJVWRITc+P3iLjHYdSicq9YLqQV4CL08Wqh3hWwL3
 q/aYdCVUuP+bZ5RgeipGkE/M/qcyPhisDgo1I9breL+cHo9zfghX0zyZ/u21JEnPaL1F
 pM/NhPvnbZzTahuFtvgNgqEEY4CVCkA6R0/UoZVmluX21JybgZKhDnf8RyIyffxQ5/Qd
 khrFhTPVC6d3J2UV3QYpEqg3zxalczyBr6CqE7YlMeO5ntBcW5paW8qvqX9fNtRmG4np
 fIbg==
X-Gm-Message-State: AFq9FYI3v4MHMS62jUuMAc9ExV6/b3/xkTomfTL5uKxZgtUBCW2Gxb9S
 iKnOen2kM8zMYw3XYloP2ZL9KHdqsQbggvnrP5EQkuGahlhOD/Q2SPfs4TgqsIIYatWZGlyWYvU
 CtivPtFfl2peFpzPAtTdeqVR+5DN99GizyGYwupt5VNO92Cr3cpySXp5sxmN2CV5XQtxH
X-Gm-Gg: AYBFou1bn66wFCJfjS81M5sLA6FxpzkvWDgNZ7t82A9Ov27U6sjQIjd+ooaE0EDvpTF
 Nw22hY+0JwaqV0sOn1UlwGEiWeluJLECiq8HAtWGLIRH7DZ2y/NdQ0MDQMIlVLw/i5Vd3PV1/Hg
 Hv/VAzA6FpeMLCxcbKaS/7CN93mvp/6uBrJ94166RHCqWe8aq+L+Y+gKDIa4QrE4PAE9jfMOLWU
 yqRp2NofVQI10F2r1yFQCnUthiNRo+vWgO0Bh33PT3Po/OTUyub37TPVkvVuT9H9/0uN+/QJVs4
 orf83KbsS0xDd6wBirwBqYc9m3g5lbPOWJjJRIS8kcsdnScQlBqhGTst3Jwu9n3Vbrg9XJImSfI
 NQGmRYVQmagQvZ+FQFQivikQ6xTJLeWCGARdCxyhKEg7DVbrwuYuhlVEkrH7mN+I5WegzmFr2G2
 rVC6JTRik6WDCHgCnhGCvi2x+N18RjOA==
X-Received: by 2002:a05:620a:8015:b0:93f:3bb5:545d with SMTP id
 af79cd13be357-94408a26979mr349024785a.27.1793198028972; 
 Wed, 28 Oct 2026 07:33:48 -0700 (PDT)
X-Received: by 2002:a05:620a:8015:b0:93f:3bb5:545d with SMTP id
 af79cd13be357-94408a26979mr349019385a.27.1793198028497; 
 Wed, 28 Oct 2026 07:33:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c42ca77sm46733795e9.8.2026.10.28.07.33.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 07:33:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 2/6] tcg/riscv64: Use a uimm5 encoder for vector shift
 immediates
Date: Wed, 28 Oct 2026 15:33:26 +0100
Message-ID: <20261028143330.6518-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028143330.6518-1-philmd@oss.qualcomm.com>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX9F9e1Ipf4BoF
 G+NyoMNjLmZ/CrqtoeezZ7k46QUCHJTKEdCmM2KSuoK9XNZs8C6bwCzxXlaEpRPUm94oRycBFI6
 dPRz4FMsJ8uhmO1gGPUXQ7RGyK4nSMQiKONk5vIgvV/0DOK4kFHOGsdXK0mGKfhlsuJ0nC/A7OL
 5bPR4GUINRmiCrL9/w1cNiYS+GvghfTKoYsoVTl2OTq4rfnEYrXnsJAxu/3lWRrs8r784H6UYj8
 EfH5Zl8wDyUA4Wg6EU6ETRKHXFwcIEI3xAqoDbFQkz+JKv/3FfsZCipNBhyZJ9FO5HUN6ScpUmy
 7NtqGk/UCDE92ERkTUrtQK5jB/ZGiTibPZMy8TgLHWPyBGOFlDC8I/5uFgrFZz+R8sa6ZoKlA02
 3TZ9oGze9/gtV4/ZL6QgeVV5+iLHMFXkazIyzn9gREmzDBxhAx4jpqzy22U/na5teRWN2k6Uu+w
 pT4dCAjbwUb/R8tbxiA==
X-Proofpoint-GUID: _mJmqqSP3ZIunHQuIJ6RRrcQ57E4B6uy
X-Proofpoint-ORIG-GUID: _mJmqqSP3ZIunHQuIJ6RRrcQ57E4B6uy
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae207ce cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vwcle1UgPbd9zKqFLQ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfXwyKWq68pGbRb
 83s7YNHP/GT5sed/5z+qgvmb8J2WAJftM2ZTDqPWzcuMSPmyjTg7jJONzjUm5CygqAZ9z+r4OEL
 MXLtk/V4zL3q5WJ+kWWGJPxxWbEGp2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280057
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RVV shift .vi forms take an unsigned 5-bit immediate, but
encode_vi() checks for simm5, so shift counts 16..31 trip
the debug assertion (and are undefined behaviour in release
builds).

Add encode_vi_u() and use it in tcg_out_vshifti().

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 712170c1203e..0e749ae296b8 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -541,6 +541,7 @@ static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCGReg rd, unsigned imm5,
            (vs2 & 0x1f) << 20 | (vm << 25);
 }
 
+/* OPIVI with a signed immediate (simm5). */
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
@@ -548,6 +549,14 @@ static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
     return encode_vi_raw(opc, rd, imm, vs2, vm);
 }
 
+/* OPIVI with an unsigned immediate (uimm5) */
+static tcg_insn_unit encode_vi_u(RISCVInsn opc, TCGReg rd, unsigned imm,
+                                 TCGReg vs2, bool vm)
+{
+    tcg_debug_assert(imm == extract32(imm, 0, 5));
+    return encode_vi_raw(opc, rd, imm, vs2, vm);
+}
+
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
 static tcg_insn_unit encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
@@ -720,6 +729,12 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
+static void tcg_out_opc_vi_u(TCGContext *s, RISCVInsn opc,
+                             TCGReg vd, TCGReg vs2, unsigned imm)
+{
+    tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
+}
+
 static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
                               TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
 {
@@ -1578,7 +1593,7 @@ static void tcg_out_vshifti(TCGContext *s, RISCVInsn opc_vi, RISCVInsn opc_vx,
                              TCGReg dst, TCGReg src, unsigned imm)
 {
     if (imm < 32) {
-        tcg_out_opc_vi(s, opc_vi, dst, src, imm);
+        tcg_out_opc_vi_u(s, opc_vi, dst, src, imm);
     } else {
         tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
         tcg_out_opc_vx(s, opc_vx, dst, src, TCG_REG_TMP0);
-- 
2.55.0


