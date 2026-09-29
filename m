Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37EAC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSU-0003Bt-Pp; Tue, 29 Sep 2026 03:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSS-0003BS-J7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSK-0005rU-LC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7ToEP3220601
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/rgMAnHhrCX
 imBNG6YIjFj0XIqIYRzMOCjJNP+IQ9Sg=; b=f17RckzfQxl77/nWzJl8aL3tFzM
 LF3zoVk4prDhLsI6l9l4m8ANnZG12DqSiB7F++tNPJlyGelrDiHJYgL7YT1RRppr
 pVtonRfU6gUwSTPGtsFSE1gz3c37xFvEKbrQa12sZuBz/BU6VSV8F/7JoQjfQMoN
 nSQ9TvnCnBLwCusIw02VSKuOuUhvu+uDjgEv3l5bFO/7jTLayhI3FhleWd+639WZ
 +tuJzc+NgeuJdBF+2rrnZ67j0/XGkBjYXjaAUDxjmJUwjjAqoescGiYNuneoZ1PR
 gt/hUViftJqM7AtvTue7C7gTDwyEfcL2XfqVqQUhX5pVnhCL9xnYEJGIusw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw22v16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342b66c0b06so746841eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667651; x=1791272451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/rgMAnHhrCXimBNG6YIjFj0XIqIYRzMOCjJNP+IQ9Sg=;
 b=fUfqabzka9qtmtjAkt8fs8iKAHD7Y7gDnAzOWOX0XNO+ZZx6DkveNpzfd6PS0K2cmu
 6SpBrNTF2morOS9GraJAmgAJjFyrIUqmcn2hS3Q7dodqRIpvoujR9+LGQ5prnoXX7Dba
 0wwWXO2i/aFne7BDH6KtZvNnF5Txv8Vf++kwS5sFuNPQBdX1InQOJzVg3sWRr37O8vCu
 wutVfSIhIHwoMXBzuBNulCT6MBZmv7RtlCvN0KV1VfqP1Ptb25kxDkWvXhPIM12laU4a
 QvPn7V6vCkWk79s2THNRrrnRhpEY/GwRGAnRPu7Vqj7OtILGtWmbQkxv1lWydlVhz4Pn
 iXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667651; x=1791272451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/rgMAnHhrCXimBNG6YIjFj0XIqIYRzMOCjJNP+IQ9Sg=;
 b=s3IyOo6IOgUnHiAluSt0IS79syVSrDJC1oUzGg6wB2QOyHQupKeRw7AK1xj4FpMzQY
 ukFu/0ihbrnQkIiRopvrGeib66b7jY6lBrikDzeeUMl23Kb11/BP328RrGp+nQcp9nSv
 06kZGAMvUTwXwKgTUEp5cXuWBisredkVekOriKZLNpLDpgm0rEt+yRL/GMlyhXf6QI5T
 L/LlSewi5VSljjrV0nKaTtiv6AY8JfYNshHdVM6kLrAL6r/HXM2ic7pMZ3QkxBIUnSvs
 cfbGPrQvTbINvJrSS196aTZqzzO3W0Hj/EgzokJc5Rk3yoHqoIEsG4wXkxuoDXnnkhEN
 aNQw==
X-Gm-Message-State: AFq9FYKm7K5iFJvRbmvDIocaQPMr+mBKBZibUbkQ79PYIyaQ3kmixF1N
 SbZgYWnCxF+gtRe2T1+42zq30BNkSYeezQFyqNf5aKBRClFjY7t6ba4t4Q+BakHjYa1drDb+4J+
 7v/cGRDlYrmP2UKF7j9IxoYkBcnVJ6C/19tZqgfR/1M2fjss12dFteqkkU/UUNynuzA==
X-Gm-Gg: AYBFou1Sgbx+T7CiOeqOKm5CrxdNuboxxpTL2MRDDvM8zm6/QusetxMToy4EE2HnZW5
 IsZFHDiagPkRjg5KD5ZWLPGoAZvGCIvI+EshA5b5DuqzsFT5FN49FgyLgECpItHq8ZRxUMcMoW7
 ywipAJTQlo5JS0u+1Tm0HUeVhhP1f9CZb7HQnCb8A3rQMFTj5zBuW73meoPi9rxjXAC4CCA58Gf
 9hlfVxUg0T2Gbt0X1ySoleiSTi6+eCxiEFph3QFubSBeI9+a2grQ8sanItbSb9/oPyTT1qUrpqt
 qI8uyahCjQ4ExiST+5q/4ytLvXtHuaYVPstBHglm2D3GhxNAiE0rAUgnom+MzJihxkn4U3aw72o
 +bBwuSSpkd3U00qE+Ocbs50lkwGu7KS96LT2k/RhNgJ9ZfKdO3M0LLAJ8VQ==
X-Received: by 2002:a05:693c:8808:10b0:332:94e9:a72e with SMTP id
 5a478bee46e88-34af5cca9c4mr1947370eec.9.1790667650350; 
 Tue, 29 Sep 2026 00:40:50 -0700 (PDT)
X-Received: by 2002:a05:693c:8808:10b0:332:94e9:a72e with SMTP id
 5a478bee46e88-34af5cca9c4mr1947349eec.9.1790667649621; 
 Tue, 29 Sep 2026 00:40:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 14/19] tests/tcg/mips64/test_mips64r6: fix call to
 check_results_64
Date: Tue, 29 Sep 2026 07:40:02 +0000
Message-ID: <20260929074007.118970-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb6b83 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Jd2gHzoULpm3QAu6kFYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: lMJdMD-i7ky0DyJWHU-gFlWvke-0hOtT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX5O212LQ3Gc9r
 UQNkXmH7ImSCTxKbOeVpmsZMoGLC4PDmDqZhZ8kwLcMNIBp5OWzqmXEbT9JdJrWoBlG1nhVqjFe
 XV43w/Nu86bRS+6bqvlCVnMcPex3RlJWNrXynGwvIsV6FlTh6FArv3/unSdKdjoD7HwYe3M72s0
 EP1G/yr8UqF8qXqur4cCl7oBgCKBrexUom/E0bgqSpJv3EvU9R7zoQoKDGoVCbx6zY/ZUjku1pH
 vQZFvDHkymkNtlapLkHiAdvPNbJDH+Q/MiYlso2UwL1U3BYoGLXUiC8/USLZjbiYA50EcJosz1e
 j5bOaREePtgd+dgCd+tE+rhgIUq3Bywfo+cvI7S+w060fuw2w2KIkUx06LaLL5kx18AWq6HZGYq
 732CwuitKjZarUqK5pyJBaakEmwsxK4gs8rcCiY28bB1cXX0xmYB6C5EEArqS+lvINgTJlMH/ZO
 dS6/9zX1ROCEeCR4toQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX4AvhM5c/MLpI
 R9MY4UwBlQxyCTWOsJSxKj9nsz2FOiHL+m4tYG8n3Rtf6v/5iolA/NZSubBJqDVkWcjcpq6ZU8m
 psG79JIyAuEXIZjGTMThe9JrtRLVTmE=
X-Proofpoint-GUID: lMJdMD-i7ky0DyJWHU-gFlWvke-0hOtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

isa and group names were present in all files, but not passed to
check_results_64, which expects them.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_bitswap.c  | 3 ++-
 tests/tcg/mips64/test_mips64r6_clo.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_clz.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_crc32b.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cb.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cd.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32ch.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cw.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32d.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32h.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32w.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_dbitswap.c | 3 ++-
 tests/tcg/mips64/test_mips64r6_dclo.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_dclz.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_dmuh.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_dmuhu.c    | 3 ++-
 tests/tcg/mips64/test_mips64r6_dmul.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_dmulu.c    | 3 ++-
 tests/tcg/mips64/test_mips64r6_dsllv.c    | 3 ++-
 tests/tcg/mips64/test_mips64r6_dsrav.c    | 3 ++-
 tests/tcg/mips64/test_mips64r6_dsrlv.c    | 3 ++-
 tests/tcg/mips64/test_mips64r6_muh.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_muhu.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_mul.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_mulu.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_nor.c      | 3 ++-
 tests/tcg/mips64/test_mips64r6_or.c       | 3 ++-
 tests/tcg/mips64/test_mips64r6_sllv.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_srav.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_srlv.c     | 3 ++-
 tests/tcg/mips64/test_mips64r6_xor.c      | 3 ++-
 32 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index 38ae641e907..3a3d8e68831 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
index ae2f74b34ee..5e5f948e250 100644
--- a/tests/tcg/mips64/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_bitswap.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
index 611dcc9572f..a2e370849e6 100644
--- a/tests/tcg/mips64/test_mips64r6_clo.c
+++ b/tests/tcg/mips64/test_mips64r6_clo.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
index 3f89cbdec2f..0707cf751b7 100644
--- a/tests/tcg/mips64/test_mips64r6_clz.c
+++ b/tests/tcg/mips64/test_mips64r6_clz.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
index 7b8955cffd5..d9956b4e20e 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32b.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32b.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
index 58479c2733b..7edced391b7 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cb.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cb.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
index 417cd895fb9..f7e3f474aa6 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cd.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cd.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
index 9ae4804e687..b5f0bc207bc 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32ch.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32ch.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
index 2e1ca6f836f..a8e37f43929 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cw.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cw.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
index d916ee2586b..b6e97fc71c6 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32d.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32d.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
index 72575e95858..72bdb59d136 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32h.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32h.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
index 4518b4fe482..b625cce241c 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32w.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32w.c
@@ -134,9 +134,9 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(isa_ase_name, group_name, instruction_name,
-                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
-                           b64_expect);
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
 
     return ret;
 }
diff --git a/tests/tcg/mips64/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
index 7473f3f0ceb..9ded266e77f 100644
--- a/tests/tcg/mips64/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_dbitswap.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
index a6f8688b76c..864736275c7 100644
--- a/tests/tcg/mips64/test_mips64r6_dclo.c
+++ b/tests/tcg/mips64/test_mips64r6_dclo.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
index ab2d3eadeff..8c7e7389cc4 100644
--- a/tests/tcg/mips64/test_mips64r6_dclz.c
+++ b/tests/tcg/mips64/test_mips64r6_dclz.c
@@ -139,7 +139,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
index 490c81f884a..0bcaf97d50b 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuh.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
index 28dd2026418..b4cb47f884d 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuhu.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
index 2a33d678992..c5cc48ad0db 100644
--- a/tests/tcg/mips64/test_mips64r6_dmul.c
+++ b/tests/tcg/mips64/test_mips64r6_dmul.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
index 161d1fe96bc..739ad90f043 100644
--- a/tests/tcg/mips64/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmulu.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
index fc93e0b218a..fa8108ee750 100644
--- a/tests/tcg/mips64/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsllv.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
index e496e8fa83a..f5752e4141a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrav.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
index 2c4c04f4c42..62b7f974ed3 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrlv.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
index 8f371e22e61..2706de4c0d3 100644
--- a/tests/tcg/mips64/test_mips64r6_muh.c
+++ b/tests/tcg/mips64/test_mips64r6_muh.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
index 79824c05b13..c4f34ced688 100644
--- a/tests/tcg/mips64/test_mips64r6_muhu.c
+++ b/tests/tcg/mips64/test_mips64r6_muhu.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
index 9589c4c3a08..87c0422ba09 100644
--- a/tests/tcg/mips64/test_mips64r6_mul.c
+++ b/tests/tcg/mips64/test_mips64r6_mul.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
index 72b4d038cfe..2ccda6b912f 100644
--- a/tests/tcg/mips64/test_mips64r6_mulu.c
+++ b/tests/tcg/mips64/test_mips64r6_mulu.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 04b841c8df1..6edcc1e394c 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index fde9601a78d..e6b07cd4bf8 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
index 46136de0634..2d3f0d38dd9 100644
--- a/tests/tcg/mips64/test_mips64r6_sllv.c
+++ b/tests/tcg/mips64/test_mips64r6_sllv.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index 94c528f8ab8..951bd7826dc 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
index 993d0b75205..0195802f660 100644
--- a/tests/tcg/mips64/test_mips64r6_srlv.c
+++ b/tests/tcg/mips64/test_mips64r6_srlv.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 3ab67ea0555..52981f73579 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -146,7 +146,8 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+    ret = check_results_64(isa_ase_name, group_name,
+                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
                            b64_result, b64_expect);
 
     return ret;
-- 
2.43.0


