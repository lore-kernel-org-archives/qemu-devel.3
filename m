Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n86iFd69;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=du88eXyx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrKA-0006Uu-LJ; Fri, 30 Oct 2026 14:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJi-0006In-OT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJf-0002Q7-Kr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuLU93669827
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ni7I46VnjFceS3JA9AvWDDq+HO1ygybvqydkTriCfiI=; b=n86iFd69d8yX8kIm
 mITbceI8mEcPVr6gmv8jXLmp1yXhO4ovzSEe5KhW4ITqnxDy4AhtNFJgsZLKOtms
 0WCtT6ZJrsmOsUVint47ScXxpjQqLJywiQVXQddnrUM1uDT8HY26CwAiSbNzT7Nt
 X7rJNyEVUgldo06RXzMGKrPOMSEDdRfPAhcYHpV20zbpX/xPHMj1GI4PPfPw1D7w
 u2sSVl1JbEuHLQJaW/20jac3PV9W21x5IhKgDDNoypmLupXLAZ6iI97UcN9Xnchn
 MdXeqkjbM0gH7McILz9qrLjUhzpopmPc3Mpb+c8K6l07r0Le7Wd1nyL2yprEqcxY
 mF2i9g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmejn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988bea8fed6so782714241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384821; x=1793989621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ni7I46VnjFceS3JA9AvWDDq+HO1ygybvqydkTriCfiI=;
 b=du88eXyxgN/fTBxOOZr5tDg7dn1SkrQ6uHcSDWKuEC7cXqsqtuktJE4zeIJV+zk55G
 Xqzenqxn3A6+2lKgqAuXxGze6JypKju+XIn4GrWVEQbmypGEVzewAPU9o3BpEmgzlRza
 rz7Du/9yyIIT8vgF0p96t14b0Q6/e5Kjjdf0gzWcrQs7OdY9uilB1C1C+ChJ41NpGwb6
 +q/BOZD/DKh7ZvcgQilPCi7PPdMULIQ29CrW/6KW39sk23wD2klk9h2AJdSOJ/jy6HyR
 rd7KsD4BCZjGkMm+qn/HXvMndqDdrrSAJ0xWp0XtsgtY22UuE1Sw+b5mdtYRhZpMAv+k
 7Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384821; x=1793989621;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ni7I46VnjFceS3JA9AvWDDq+HO1ygybvqydkTriCfiI=;
 b=xAJNSWCsV4YLk0g3R70x+ttwfhvAktmIEneGRs4xy3ZwwXJ6RgbUSrXBrUl5O1SD33
 8SIHhV47T3JIOJt815WoMfXqrMhEcNzd+bWezTodWuONzVem8k3NnQD/8JpLWOcCZG+3
 LeH7YtPreocmgKGO8UtJ/2w2576XeD2J/Qgo6XVmG6AuU8bXFgcNqlOzXpWtCff84bWo
 aDt9SBCRWWAt/nTzNG9ybrBwKKlFUqAHPMiTTXkpl+saspSn29aUCsVdJLF2uaxyk5zb
 ZYv9bRXclFhx6Qxt7gWrp6Us9t6RBftezvg0NsMnr3kVW8yNMtooimTvZjY/P5Piq4AM
 FORQ==
X-Gm-Message-State: AFq9FYIxlGetoEFpqocKQ3anVQ6H1DhjyJMfGF5HaIZXMLrpEKUiNQJc
 Yo43+t0ZksUMtX8tW69Mg7t3mr3izj8PSjTnv/jzuXlJwH9bx5FKC4uGUoMZtjd9avdX1NWujZC
 faini/HRGSMosMjUH1tGVvv4m0Yyix4slopqnf687+JCuvz76RYrOrYN/nZf2AW5gjjbt
X-Gm-Gg: AYBFou2llJb7ObW45kq+9THG9ZyBMczzTVj5WFnpSciX4rFdg0Th7HkVb6FKGSllTA8
 P5IXXQobpkA1aqAcQBcpUHi+iGWat18WP6UbsSgqp5CEtgxMJB/7aMyt2UFUoK1HYFusm0g9LA+
 9ixZaErnom4xXg64rkRu83UVxlHgau7DJ6IR614ObPfEIH59nBUEWBakjSVlB/0PZ3qL/hetulT
 CO41a3ceI4907zvQIze685injjVZWwLmtAi2KsxFGafLhdH4clyn3+EI0XhX/I5c6jmhElVnZYY
 RX7EWpHuwBbOQt7kAAAfQuGpI46iiF7oBwJUuwYfJhcwTAcYr1ZJOgn7KVfJt0HCVAbbFbrRIjc
 X5ef4LLZLc4IPk7KDGXJCkEnfNzs6MHroNe0KC5YQKHeiwDmcU++JNO0fiJ5z0GbGHlBrXCK5KV
 kHRRgImUDqCYOqyXkfEuoCpPGWS1oLnw==
X-Received: by 2002:a05:6102:6888:b0:7cc:1045:604 with SMTP id
 ada2fe7eead31-7d07275c681mr1742559137.30.1793384821471; 
 Fri, 30 Oct 2026 11:27:01 -0700 (PDT)
X-Received: by 2002:a05:6102:6888:b0:7cc:1045:604 with SMTP id
 ada2fe7eead31-7d07275c681mr1742549137.30.1793384821095; 
 Fri, 30 Oct 2026 11:27:01 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm4804968f8f.30.2026.10.30.11.26.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 08/12] tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
Date: Fri, 30 Oct 2026 19:25:41 +0100
Message-ID: <20261030182546.2508-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4e176 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Z1e1Q9QNEkR2sOvC9foA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 1_4s3FYaafuWpeodxNlYD1c-gxnjhe3h
X-Proofpoint-GUID: 1_4s3FYaafuWpeodxNlYD1c-gxnjhe3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXxNjm6BUAoQfo
 AlHqV5gG3IY578Y0133HGXkYHN+m88l8wW4hUz485nLRK2wK2XqRXzc+eQlMqqLbrxwxKJWECMm
 HZTRrxsWLsbdZ4X4IQ6t8sh/ea+d1dghdKEqqXS8cghHtC2Oz0jwtpcG/u6O2oU/65FhXx6B1OP
 teItNcYn/tm+/Wgp0BA7DItkJICwgGYSQ+9+c+F4xXqA3x6cwgk//QJ3BFp2Qx+SkgFKRKmd9k/
 qUEhKegmvVNI5qVWS83EMS5bGegQgR4WEbdTFSDIS65lnmGLyKQFNnCLTRNNYNFnJL3HRju6JGr
 uQIdqhWZ0lrd5XZD27ONy1boNE2J+J54/6pVNpN9cUZTA/G8FH7E++ClEk/i6yPzEGlV2sGpRWO
 X6e+uS0TqO6YMjzBS3Hrz4oG1Wp5maX5HjBLz3rp5u5kHD749b0+KfEAnK6scgbC4nyfkIyMotR
 wSzQM1JV2DEM2Bz4Iyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX9mjXctQnKWdV
 o+Lvl3PPxsEaujBVZf5O29DK3f/VPvCp/klW6Vbw246tJS+l2fKP4wgwc9h6jzFsrCXb1CQOVwa
 2OjxkHAD30qJx+26/bv93kLMSecvB5A=
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

Test SEL[EQ/NE]Z.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 3 +++
 tests/tcg/mipsel/test_mips32r6_logic.c     | 5 +++++
 2 files changed, 8 insertions(+)

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
index b640aa0975b5..45fc8e3a9ef7 100644
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
@@ -55,6 +58,8 @@ int main(void)
     run("NOR", do_mips32r6_NOR, ref_nor);
     run("OR", do_mips32r6_OR, ref_or);
     run("XOR", do_mips32r6_XOR, ref_xor);
+    run("SELEQZ", do_mips32r6_SELEQZ, ref_seleqz);
+    run("SELNEZ", do_mips32r6_SELNEZ, ref_selnez);
 
     return tap_done();
 }
-- 
2.55.0


