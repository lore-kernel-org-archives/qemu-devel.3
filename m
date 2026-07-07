Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ED8C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAN7-0007Ve-86; Tue, 07 Jul 2026 14:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMu-0006ue-Br
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMs-0006cQ-82
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTGMY4059295
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZLpYZGBQM4c6BxYlWik9hnlxQknGdLKYWPVcWlRha3M=; b=Buv68Fpx9UGg4K5N
 NFWlPPe12aWhk6UV/kGX7JzSOUpMzTIBz7LK7V4qc8RrtfoL0keuHGV9kQJ7UUZN
 o6d3UIr2PO51d8rvJGuzf5MfcJ/S5QeLWeJmQkrrVH029MTijGlsS0bXHo8VboGE
 xnw7ilQqhManlkwytHyHe0vOr7cDMj9Eqei8y52RmeFJtaNAFoFQkkzKJP1zr7UI
 Oj4D2yWXjK02g3fgAIQiVzf0rWYyM4uLaXirwmHBAzjmEJF6CX8D4lBsFV88zZHp
 HeL5MCrbfCn5x3Dedw2W1lIPuSfkgf6nvy4Kww3s94VzSpGQ02/0yH4hPlUXLdy4
 guqM3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8kgpg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:18:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso60843041cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448279; x=1784053079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZLpYZGBQM4c6BxYlWik9hnlxQknGdLKYWPVcWlRha3M=;
 b=H2URvW0JP+t4kkrmypKIomQ5+4Ns2aCew59D5ucu4KuAjLKGsVSPI7QTV7E3P7w5iU
 e5ZLj3We8YP3TVccYohXP/NEJPLD9NUqnREkXPGuiD8G1VzGUYsIsZ5TqPHViUD2awLe
 ERK/S5PYC0mu8XI1tgcZpoyM11/HnzW+9i2Et/hu+AmpaR9uepBUCRhSX26bFZ+X8/G9
 MGCvZHYVslmlN8RUJGzFIw4a47a+FbQtB651bImwGSkZ8peao9qk+NK42wGbt8NpxNAf
 nLFMp8AANxd606i89QELivrIMOfCL8zOEVQKtKViOkm65ZewB2o3BjDPmXM2PloQKpdI
 mDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448279; x=1784053079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZLpYZGBQM4c6BxYlWik9hnlxQknGdLKYWPVcWlRha3M=;
 b=p4XAqKK6jGRGAK6ZHNAxr+GIuMQ8ICoacmFe9cQWL4GHFXBugfWjMhZTtONaMqDGbg
 LpGQb9ymLPYcYJraHHnH32Gf856dHo/TDjUDEot+9dHJiQl6tSwAQecwCzWJOdbd41+M
 qshX9Q4f0YFXIxKREiWIIw/U0pHNXESyDDh2/29W/LNb2Tj9x3R2reyaTRvO3CsOmebC
 18MsxoOnxkCqfrnlcvOp5j6YSZm3H2Zn5jiuNnrZrotph2ODwQ635pPDv8bgsUP2gxJ6
 oAx4CCDY9I8UaGpeHQ/8JudXuoFRL64uQDQ4GpjSmItZxxge4TYv2R4T9btbIEAUOF8S
 zkSQ==
X-Gm-Message-State: AOJu0Yya5ncnsY9w6JQEUIFfAk54FDxyZ8Y6uLhkY5arB22GmQ9RaGWU
 df7NxFYJq12782SEivzmyiVzbwyk92h7h/vs5BWEmeLlqxioczyinW2tPVX4RaynYr5WiiWbrHi
 KTyl4/UJBQ8BKRgZczcPgQgNDAdkzngecYZlcSKqJjWV8yUYTrrQrafje4xjMtZFWJw==
X-Gm-Gg: AfdE7clGFC5jOuidv6R0wzH2Tdeckjy42bZTs28D747WF5y09yrsvVp0KvMy1THukOG
 3lkV4wxQyFTsgwwHi15d0lc0hvERxeWVIq2JF+VywGwNDVvo83+/tV6nnrii4I/LYoA/JAXwKrI
 lzkuz/+UhQp3qJYiaYVAmcA+dGW8bF3+b1GR1QHNfWTsiuu17s0eAkY+Cq600tRS/cHeTFF2mN4
 vVETqPb+1/gfdhUfqV8gj5ZsNfANUGqbKHCronoFKvVIelUv3rH4050+nYnyQPKbQwyeA8iu0Bk
 XiFoXoDDF7n8/NIwOSVdnvH5u9uRJrE1+HYB64SbD7XCzSCr7tyUsrhnAXxOLtSeD5v81ywDpat
 bibdq3/ciCmOfJxXAwttFSo+lTHIICs8q3Oo2yAtEmPzyhmYH9dMypjVrfa82nSUsBONU
X-Received: by 2002:a05:622a:ce:b0:51b:8539:e8f7 with SMTP id
 d75a77b69052e-51c748bf8ccmr66431071cf.42.1783448279084; 
 Tue, 07 Jul 2026 11:17:59 -0700 (PDT)
X-Received: by 2002:a05:622a:ce:b0:51b:8539:e8f7 with SMTP id
 d75a77b69052e-51c748bf8ccmr66430541cf.42.1783448278359; 
 Tue, 07 Jul 2026 11:17:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm36154564f8f.5.2026.07.07.11.17.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/23] tests/tcg/mips: cover Octeon QMAC instructions
Date: Tue,  7 Jul 2026 20:15:26 +0200
Message-ID: <20260707181529.60191-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX0DEY91mqq/Ds
 0Ar4JMaHUcYEhLz8CSq468cwxxqQ4SxUfj7DUPTaijZEzVmhSNdFGoTVz79LCBbUXBu3vICFPR5
 YIGO6RPpo7r50oFgb0cVS1FaJRIjHyjj7XHO0Y7g5dK/d9tnVULjaLyYiofgnf4dY/04g+zLtwT
 eHhk8oZAL/xMF3clagfgOgwyuhDIMlFi+PbT2mH53Q73wU0lZ1lrI30voh5SjXrgAxhYsJBq0Vk
 +TchSbNz+f1Ku5OiQIGyKRb4beJKiZvMOhVC+vHVRfA8xkNK/kR2e3TuLaxxt6gUr10tD8InhOz
 RNXKLrL0VSys2zpuuW9waS7HBFNhdFOB66rDLTOmHFVdd0T4I81mAGi1vozEmJTkBALw8JPP0kr
 Nr1cMR/Wnk9uL5xah8zmuPKAeKA4BTKjcXaY7ZpIhtmwX0ul/zwjVg9PjK9HGO/LeEIAo87G2SB
 CfHeGNvYUc0LMBbt2kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXzU4DcBZ98TtV
 edfF2zSuiNVGOfbzUhZSMaX4fyUrAMWYewdkAtjQeJ/SpDPZKzSBueZHn45+jR9XRYpiJC7dti2
 u0TsYL00IDcZO1+QmYyB9b3R/TYH6fA=
X-Proofpoint-GUID: 5tIGlyK9DtXFy2yLpF5sxNVg6v9awF9n
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4d42d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8cCW5OL_3pmOQgKCisAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5tIGlyK9DtXFy2yLpF5sxNVg6v9awF9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070179
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add smoke coverage for Octeon QMAC and QMACS fixed-point accumulator
instruction paths.

The coverage exercises normal accumulation, saturating accumulation, and
the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-21-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 6480c8532a1..6fffc820103 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,43 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
     return rd;
 }
 
+static uint64_t octeon_qmac_lo(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x710904d2\n\t" /* qmac.03 $8, $9 */
+        "mflo %[rd]\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return rd;
+}
+
+static uint64_t octeon_qmacs_state(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t hi, rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x71090012\n\t" /* qmacs.00 $8, $9 */
+        "mfhi %[hi]\n\t"
+        "mflo %[rd]\n\t"
+        : [hi] "=r" (hi), [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return ((hi & 1) << 32) | (rd & 0xffffffff);
+}
+
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -355,6 +392,9 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
-- 
2.53.0


