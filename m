Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B336606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrX8pRR/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nu0K+fLc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFC-0004SI-Db; Thu, 29 Oct 2026 13:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUC7-0000PQ-Iq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUC1-0003xn-Dx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDqGt182339
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /fQlg8ys1bQF7Uns+/tvNeu1cz6luN8Rowi+ZkW1U64=; b=mrX8pRR/Rnec3apB
 azX6ekvWFxN6kKEHZDZY8vX39JBrzlNmiAI3R+sUQI+ORXNbFEqVxqTNpgFtUOen
 TbWqHYQNndqVqJrCj2C1X0IahXk9WdBv81H0e6I2128XorLKcPslpS1p8NWkrOdV
 lV5suxOxwvKyKzBtmaGxCtIq5AjE4228HaT3sbkSQKUQaNjIt6ZSuOJp30P8MA4y
 QANrmuzYmsuFhsSkqdd+69dJh8G0jOxdqIVL6Y4RuA6WMW0l7CrhksUI1uXLtev8
 ObiVNfVW1xlh0b20CINb1SFrtFGkLxYz0oltY3KDz2L6J2cJqtZgd21NJvDbBRF9
 I7TaXw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r5wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:35 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so2043875241.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295935; x=1793900735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/fQlg8ys1bQF7Uns+/tvNeu1cz6luN8Rowi+ZkW1U64=;
 b=Nu0K+fLc2jrf5S/HSl8e52a4PszBiSRdc1TNybn+jC1xBF8I4jIUHuzdLhgrlvdkZ2
 88IhOVs9qM20d4yOTADddwCnk7Zb4AdDJXmzbtKGOQyqfwTrIebhy1j95QbBHywrl8ij
 RBxyHgWkY3NLxr+T9X4sjF+9JIV2j00nROVmLZolsapKSkP3mFK8fmXgfqmqCDplXfvd
 igzNd6bqQGfzmSjEX92p0/CcDxekaC6VFVeopLwEXjfOESOnVv+OESWa8P3hdPWhFqVL
 jFRhEkZNyW9TYl2o2VoxMoIxRQquQN6d44MllXrvCY1BJR6NvfLkDXnrDMtKg0JtQXoT
 ms4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295935; x=1793900735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/fQlg8ys1bQF7Uns+/tvNeu1cz6luN8Rowi+ZkW1U64=;
 b=PQXhubRwulqHRQ0qVAN0Jgic0oaliSqUClHdqrhdprGSBwEi812F24R142gCxjh6GW
 PYbY9HchBIWTaJjGydPAtXk1/VuGqEQNmOkgvBelIRMQAuI0q+CWvjLR0AaPQTa9duCm
 JNbrS0Kis0b//MrygKTSMntp0c9wfBVNSsSJ5NZqUJlv0z85PMyAbPuR6FscvPDZKyCG
 mV1XI9ZX6cK66cpGsr+VpycFrrk8cQTlgSA+xvZPn1A5JTssK6rCHvVALEhmkWIqUkCL
 ArFiAyK7RPtGLc4SuzTdQKda5G/5NNaM4G2t5p1Zf8LlNSKZN+vkziUIPwNYhz2qA2qv
 x7gw==
X-Gm-Message-State: AFq9FYLXgon+0MQ7LcYYCyV5j341xcRamgShPOZiyvDAuT58rRNwXdE2
 jdOFUlkcCeyUbPvTLbvIQmHhmVENKwzHGBvG3Lt+rp+QZqADb1EEoPV5Z79YYLSwfsampUnIEso
 ovgP2HGjacQAHE2nU/LDtMvMEhHK53WZ5/gSO2vOsGOcfdpGn4D7Kzv2AyqatLGzYRksi
X-Gm-Gg: AYBFou1THLluPDHaLXcvM9RPFXkKoDFHFyIuNy+FWQ3ltTlFuK5EhEgCvfTP5fdadhh
 x5MnbvWIlCOv1jasqY3h3xOIHLi7lYan4uFRSYQkeJrP1xKRQAKedmBY9H4hUwbm+o5JqZDKRiZ
 0rlUVCAYUrDYLbf9usJSSPtswzdjBVXuCgMqP6IPgJWmd2V2KywjtXughtNki1qnUqRh+Spc4cc
 BFQUOXUtFYRAF324ptj+JkvT7wsk6VH82Rv5CpBiXXQQPHGSTFRnoxzP6yZEU07NvuVUhiVJRiQ
 Yoc3ym7o1P7b0yysPPm6Yamxrq+tuiRonSKTkUZ7sTl2vId27FDH/Q3g2YsbBHuOQ2MXL7Etz0a
 yR/Lkh1eviymESCUWZ9KreaFzBEJNE+KU1AgTYnYfWX957Fa2MFaTs1a0zYH08+A/zgNKFW0UAZ
 bl64ADzZ5gW3bgnw3MZ7yOXbtCtcrtmA==
X-Received: by 2002:a05:6102:838f:10b0:7d0:3ed0:c630 with SMTP id
 ada2fe7eead31-7d03ed0c8c6mr2422976137.34.1793295934574; 
 Thu, 29 Oct 2026 10:45:34 -0700 (PDT)
X-Received: by 2002:a05:6102:838f:10b0:7d0:3ed0:c630 with SMTP id
 ada2fe7eead31-7d03ed0c8c6mr2422967137.34.1793295934122; 
 Thu, 29 Oct 2026 10:45:34 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0872sm508090f8f.35.2026.10.29.10.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 08/12] tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
Date: Thu, 29 Oct 2026 18:44:29 +0100
Message-ID: <20261029174434.27985-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZKDV0ZcpQkxyJpGpbYWRLxtX8wTfHxyN
X-Proofpoint-GUID: ZKDV0ZcpQkxyJpGpbYWRLxtX8wTfHxyN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2kdNoPrBec86
 F+HFFNzOZOJIuqLFwu6hPEfPg5cQ28ZL8MK2GQf2ufaBytPhzbUmnUcXL615IhCZzVqtm6K+y+h
 Mqr48si3WBVmzRtfwnuggl4dsyX2t74=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX/hf2g5ZX1DHT
 /cvL9e8Y17DsrYTThHrGJ+3Sb1mnz9+RZLJQ6ZbsfwgS2+UDgeSR+moFcPjHZeLdbbCf5/+qb9W
 8YrONQRoP/2Zz8VxoAR5yL4NQuGQC6JpgPnxznJgPiVhnSm3xroIDTi7Ll8wwgqD40t2RoSbbu/
 36bUvkAORxGU+Lb2b8ahYMgMf2mMJdhStW4jMhs/ypNWZBWpiUcKmFUR+vKxoyA4SBeAzMq/Lva
 RQljH4rPwXtkieZY29uBnf0Rfm3/ecQl23k9X4fw8K/BEF4YM0QM1p/0vYOKb1Q+Gb+EljkLlz+
 gyjm9olkRTb0EwRg3qDlTCmpstZynp9fEkQe1p1fVzTnI3JEytWIJXIOdimMLseGwImvOtQIiPX
 q0oMCdp5F68Kf5Chmipm07mk4JpZYQ0X5WRvDKr+7OluNhbskgK797XGfjDPTQr/CIl6GXoX/Rd
 o8KiecZxhpw8+H9BZGw==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae3863f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ONzZ1bIvhkbBYAvE1dkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test SEL[EQ/NE]Z.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 3 +++
 tests/tcg/mipsel/test_mips32r6_logic.c     | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/include/wrappers_mips32r6.h b/tests/tcg/mips/include/wrappers_mips32r6.h
index 316aa69ef582..aaa8afcae95b 100644
--- a/tests/tcg/mips/include/wrappers_mips32r6.h
+++ b/tests/tcg/mips/include/wrappers_mips32r6.h
@@ -58,4 +58,7 @@ DO_MIPS32R6__RD__RS_RT(NOR, nor)
 DO_MIPS32R6__RD__RS_RT(OR, or)
 DO_MIPS32R6__RD__RS_RT(XOR, xor)
 
+DO_MIPS32R6__RD__RS_RT(SELEQZ, seleqz)
+DO_MIPS32R6__RD__RS_RT(SELNEZ, selnez)
+
 #endif
diff --git a/tests/tcg/mipsel/test_mips32r6_logic.c b/tests/tcg/mipsel/test_mips32r6_logic.c
index 48db7a8bfb15..4ba8827372d4 100644
--- a/tests/tcg/mipsel/test_mips32r6_logic.c
+++ b/tests/tcg/mipsel/test_mips32r6_logic.c
@@ -17,6 +17,9 @@ static uint32_t ref_and(uint32_t a, uint32_t b) { return a & b; }
 static uint32_t ref_nor(uint32_t a, uint32_t b) { return ~(a | b); }
 static uint32_t ref_or(uint32_t a, uint32_t b) { return a | b; }
 static uint32_t ref_xor(uint32_t a, uint32_t b) { return a ^ b; }
+/* SELEQZ/SELNEZ select rs, or zero, depending on rt. */
+static uint32_t ref_seleqz(uint32_t a, uint32_t b) { return b == 0 ? a : 0; }
+static uint32_t ref_selnez(uint32_t a, uint32_t b) { return b != 0 ? a : 0; }
 
 static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
                     const uint32_t *input, size_t count)
@@ -53,11 +56,13 @@ int main(void)
 {
     int ret = 0;
 
-    printf("TAP version 14\n1..4\n");
+    printf("TAP version 14\n1..6\n");
     ret |= run("AND", do_mips32r6_AND, ref_and);
     ret |= run("NOR", do_mips32r6_NOR, ref_nor);
     ret |= run("OR", do_mips32r6_OR, ref_or);
     ret |= run("XOR", do_mips32r6_XOR, ref_xor);
+    ret |= run("SELEQZ", do_mips32r6_SELEQZ, ref_seleqz);
+    ret |= run("SELNEZ", do_mips32r6_SELNEZ, ref_selnez);
 
     return ret ? 1 : 0;
 }
-- 
2.55.0


