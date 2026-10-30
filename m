Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEF606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OcZO3Bzy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DOlkuvAB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrKK-0006fx-G3; Fri, 30 Oct 2026 14:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJy-0006TR-Eq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJu-0002Qh-Qs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuLs63669811
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zyNDzZ9b0LcZqZDIK0c8/KsSh0SI5paxKhm5PlRe2Wk=; b=OcZO3Bzyot/Y0L2H
 UeMNXj6f5OpPtl6QjPfmEMv3U3fm/LgDEuDt9fUP0ktMD1UamYaBgg2jB2z20A+x
 d52rLMQFt6iXGV1t34GATzvDW1AB1zy8KfuTjI8rSd2DnzTZQg/PsdgndRdDRWMT
 RFUhfevaeLyifMj4092YHsCuwkcqeVdp65ycDGRm/0Uz+C+y4YMf03LxJEmkyKTY
 UGv0T2yzcnn8fsoEDUXzIRb687IM7Zti5QW28Z1UyHTXltAl+E9gwzm8QZl+xbM9
 FIic/repRhkrClLLlpiMo1hS0pXPjrjrlJV4uQSlAnx+MQKkZvblvuGDVSMiw16a
 9MZARw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmekv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bfa915da7cso882318137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384837; x=1793989637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zyNDzZ9b0LcZqZDIK0c8/KsSh0SI5paxKhm5PlRe2Wk=;
 b=DOlkuvABmpTY52/iL3V+43QXJ09XDTWM+g3fLD6jsaJI9HC0xdMG6JwKm897j9Qiyu
 xoredtdo5XIGA1/xwwuI8n0Fd8zwN+i9nV65mp/OdCN0N41RqWXdlKL6WKq5eJQ32/xL
 Q5Qfpn8f5kB1qPG25kmhl/8A08Fx3bec3SLD7iPYKgjWgmW9hy1ErPwWKIJ9ZAtQ+1JS
 rjxvPPr/Atx5U8kqFW3TrRIFyz8wq9J5laZVjJe943n+J+4QUosfkXo6cAQ/oy9mWkm4
 ktFo30bIgYl+liyjR28i+jSLkHaI8+SLTgrCwns371Gn+2z/KDESISNbUGeCOwWX8xcL
 ae/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384837; x=1793989637;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zyNDzZ9b0LcZqZDIK0c8/KsSh0SI5paxKhm5PlRe2Wk=;
 b=ha654m9jz1aicOHdwCsWXWT6xiBtTalhtAoGrg7mbzAe6hbzAzzX7VdgdJEzfEJjBx
 /YEfnk/PK4ZR/rGx4cg0pArgwqo2DpEOZ0qk+oVgfcZH9XmAa+kF0cXi5gEGz586vVeD
 t2A0/BzH5UnuuX9FKiIdZkOw2jEPvNCqtad3OZcbdLL5huFvcySBWOfNDn5XQSb6WoqW
 ewJy7PwjIEpzM+JwsDUMhJsc+t2qTeJJCwY1dpJ5b5f6cJ7U2JnM5D/bbS2hFDBzdK1j
 Cdj7/ahRb0qySsbuVln849Nj3HoCZfYdSZdWjB16Fqe06g0pYUYpGKsWogcDdR+XnQRy
 cbWQ==
X-Gm-Message-State: AFq9FYIb25eWsmyBCruPghxyhX+/eYkGFktYpbZidwC06lwnWEloUexc
 edRjLaOMu4ID0kqshKpBX4kYssxRP+oWe79PHL6bk9IOHzqQJ0bb+PLi5ecummJVZWK9mN0Pwns
 U/W+9Kr4RClnreRARPEWn0MGd5Fb2IMCPXnvopk0QbIQgWZ1qxHQBi49RLViPxDwz+Oxb
X-Gm-Gg: AYBFou04iPldzox3DColxgxftzixvGXPNyOjgyxw87Xxjt3m57XJLg/a4pJj0Zxa+YF
 DMbrrnzMhun2I2LlInrLc9dsx8E0HEbFmqDMKzoMuvm35P9S8c6NxMoSRWfRd5hVnL9Sh4Iycl8
 1dKWu+fSc0otzrA77+N5rZzxGydjScc1J0IEq1D6JjApxsEVu/TqGNpYsovrtGssQoKbCW0mh7/
 jQu33zMOeL8UDrX/DCjC8H8RBxoLmR9UPzsspO0zc6YAzYoj0O3iQtXwwyFdMnHSwL+skRIcwez
 qyaKRtddDcKMp7reB7FYX4IO8Ryb96UDosP7Qd5upSwXJQGGQeBSBedFLWBldonl7HNgJXaNoDJ
 0I1iuSenYQ9RNbfr1r1m4Na4BN3ugKE4FZBmgPlxkRrIM8SECgBuLo4wNbYw9lgfiN+WFvb6KvX
 O9wd2yunEYSf54CKtK7I9AtGoUAmcv5Q==
X-Received: by 2002:a05:6102:6058:b0:7a1:f2b5:6469 with SMTP id
 ada2fe7eead31-7d05436380bmr1917064137.38.1793384837023; 
 Fri, 30 Oct 2026 11:27:17 -0700 (PDT)
X-Received: by 2002:a05:6102:6058:b0:7a1:f2b5:6469 with SMTP id
 ada2fe7eead31-7d05436380bmr1917061137.38.1793384836611; 
 Fri, 30 Oct 2026 11:27:16 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm4763400f8f.39.2026.10.30.11.27.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:27:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 10/12] tests/tcg/mipsel: Test MIPS32R6 LSA
Date: Fri, 30 Oct 2026 19:25:43 +0100
Message-ID: <20261030182546.2508-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4e185 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=veIKPg1plPCbqLeGzsIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: w978UUZuV8QbsXzl2XA-8syMM0z57k9G
X-Proofpoint-GUID: w978UUZuV8QbsXzl2XA-8syMM0z57k9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX9bEO3hka4F4T
 SKSI5p+KucSPZEi893cgvOxFV5KBS2HLpHec7FvN2eFfdMcqbL7egSEayzu6o7m4Zapoo9HzAbQ
 3lbk3JGvlvkWPCk3nmSsJ4qY/Ajo8nd9sV2Ifa1sXpERCxW1hxnmEXiPBWKM4FeIhxGVIPOzVR6
 bcnH7BGv5wkt1JfOZ70VG1L/D1Ib7NXv6QFoeZ9kb5OiIkArkDVkvJPjL9JKKL2BmCV6Xf+M1HY
 ky7Y759EFV3jatxjtMPQhU8mTNjGXsFsRm5Apz1nj6FPgG0x1aSSOqLaDfh6EaBcSNIUwUBOXi4
 hyDq3mnUST7/F7lhQxwo4cpDX1pmRYmznkw9JqeWmL/UDs7JKVnTpev4/fpGy0swGjN2Td0P1Pe
 hck4UUhBat6wrfMXhKztEC1hk733g54e7Tzazw1wiYiR+Pt77xIeK5SjbhblMZfEscusSclgAKL
 lRa9LvbD4dbuYxrQt5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX1wO2J+q9/9dY
 HNHG51UE82hnOd06fgghu4Iku8aElTNEQ1q7WgfRG+8a2rx/EqHC7GiLbZMCBMGCQNDAlyhsDiz
 WU3r6zKmc+GbkY/kMNX4UdZwLeZjCAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Test LSA opcode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 22 ++++++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_shift.c     | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_mips32r6.h b/tests/tcg/mips/include/wrappers_mips32r6.h
index cbff8450b656..63b4496b3188 100644
--- a/tests/tcg/mips/include/wrappers_mips32r6.h
+++ b/tests/tcg/mips/include/wrappers_mips32r6.h
@@ -48,6 +48,28 @@ DO_MIPS32R6__RD__RS_RT(SLLV, sllv)
 DO_MIPS32R6__RD__RS_RT(SRLV, srlv)
 DO_MIPS32R6__RD__RS_RT(SRAV, srav)
 
+/* LSA rd, rs, rt, sa: rd = (rs << sa) + rt, with sa in 1..4. */
+#define DO_MIPS32R6__LSA(suffix, sa)                                   \
+static inline void do_mips32r6_##suffix(const uint32_t *input1,        \
+                                        const uint32_t *input2,        \
+                                        uint32_t *output)              \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "lw $t1, 0(%0)\n\t"                                              \
+      "lw $t2, 0(%1)\n\t"                                              \
+      "lsa $t0, $t1, $t2, " #sa "\n\t"                                 \
+      "sw $t0, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS32R6__LSA(LSA1, 1)
+DO_MIPS32R6__LSA(LSA2, 2)
+DO_MIPS32R6__LSA(LSA3, 3)
+DO_MIPS32R6__LSA(LSA4, 4)
+
 DO_MIPS32R6__RD__RS_RT(MUL, mul)
 DO_MIPS32R6__RD__RS_RT(MUH, muh)
 DO_MIPS32R6__RD__RS_RT(MULU, mulu)
diff --git a/tests/tcg/mipsel/test_mips32r6_shift.c b/tests/tcg/mipsel/test_mips32r6_shift.c
index 6828e90dd8af..c2d0e61137d0 100644
--- a/tests/tcg/mipsel/test_mips32r6_shift.c
+++ b/tests/tcg/mipsel/test_mips32r6_shift.c
@@ -21,6 +21,12 @@ static uint32_t ref_srav(uint32_t a, uint32_t b)
     return (uint32_t)((int32_t)a >> (b & 31));
 }
 
+/* LSA: shift rs left by 1..4, then add rt. */
+static uint32_t ref_lsa1(uint32_t a, uint32_t b) { return (a << 1) + b; }
+static uint32_t ref_lsa2(uint32_t a, uint32_t b) { return (a << 2) + b; }
+static uint32_t ref_lsa3(uint32_t a, uint32_t b) { return (a << 3) + b; }
+static uint32_t ref_lsa4(uint32_t a, uint32_t b) { return (a << 4) + b; }
+
 static int check_one(const char *name, binary_op_32 op, ref_op_32 ref,
                      uint32_t a, uint32_t b)
 {
@@ -66,6 +72,10 @@ int main(void)
     run("SLLV", do_mips32r6_SLLV, ref_sllv);
     run("SRLV", do_mips32r6_SRLV, ref_srlv);
     run("SRAV", do_mips32r6_SRAV, ref_srav);
+    run("LSA1", do_mips32r6_LSA1, ref_lsa1);
+    run("LSA2", do_mips32r6_LSA2, ref_lsa2);
+    run("LSA3", do_mips32r6_LSA3, ref_lsa3);
+    run("LSA4", do_mips32r6_LSA4, ref_lsa4);
 
     return tap_done();
 }
-- 
2.55.0


