Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A41CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKS-0000ef-Na; Tue, 29 Sep 2026 17:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKL-0000Vd-Lf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKJ-0003sc-GF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TKWj1j2609016
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t8AoJlIulN1ib99VAfed0Hhy/i7xaQSF/XEuw21tUWY=; b=gDJ0LAh3RWyfjc1h
 OYSlmRPgdcmlVfTvQBVsBsKipodXoa3ZIt12tJHrniQfYOEH6bJ3z1VgCzSDUCqE
 e3uvG1SbK2k2NmkTDu3+okBaHKLPsLroQ4hqQYHZLzt0crsPmFAhf2Ir01yG71Un
 oLhy6rCeu6mKIu708Zqil12a0T9eP8K4cLMHl+51drSlpHwFvm1779Zis4mQ5pHh
 0KBflogqqTnRyGyVqKDxOh40rNoahui3Zk2ppHSiAFZApmRyZGkKhNjbfJeXC+ee
 L9LPYgaa8M1dEzUw3XNG06u3rw8U5GP9+F019aDgAowOTjDxpzSy9FGhhoW1GFFt
 Jm33Ew==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfa85f5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so4781059eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717125; x=1791321925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t8AoJlIulN1ib99VAfed0Hhy/i7xaQSF/XEuw21tUWY=;
 b=LuKJqqQPRZeTZE9jijR1Cdci3XiRSc8pi4qRxM78AqgDT6UuXM7KbU4NQKrrs2qInd
 IthKNXrpYXv42wWro6Q5yfERLT1ZgbddVX5DRKhefQtvvAJLe9nQTFmUPjEolVOMGL5x
 ZuHCoJGLhgG+qg6AzgH/89s7hBpa+vzagI+VQC0N+6rntSTIHZhCD6RSkm794NhHewW4
 YgixBMlMhvJGtTpTW6RLN3jytVVfegwVuembGqiCxK1S1WBOBGoZN2g41gK+8wVwQbHE
 +KupT47CxyXVPzPnxLSMeE+I9s7qAjv92kDcgSqIh0QLuomJ7qGj1PnZ0wvDvjjfPseE
 3TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717125; x=1791321925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t8AoJlIulN1ib99VAfed0Hhy/i7xaQSF/XEuw21tUWY=;
 b=A++zkDN2eOX8XS8/FK7NiFAJazLNq4KolqDyECzYx6isgfWrxuLzBO7F4EkIeY2XSM
 iL6ck9WFts7lOP+Lzw09WkNJInSECu6OAbIFrUFiLLGjSwZBAcvoJ0rlgn8p4JdQf5my
 xeh24Hc1t8LifFaUP8GwFuDEBTI57IAiSh/WBgHFufHC2zoJngLU1ewz9aF9ubMjuGVE
 QB3GXHaeHis+GAz+huD3LC4cci6h53ZoIPWgz7sEqShtoE6Z5qSIIn9fcUBlSxvVvorO
 eKgS5nPFmRl4XhCrrIHFoYWfN9zhUO8aPqHk6SFngfMJVqfJY/3h+AY2oR7WdEebAcvE
 4MgQ==
X-Gm-Message-State: AFq9FYKrqOwZ26msr8jc/8xTI5mY03R8RFua0vVPME5aCI4xL1GOe5zJ
 O7usQW3gbfDA2Uh7HWFuFGKM4k8MturdO6sISt0DSbLvM4LtIGCAiRgDejBmY9dpofR6sY3ndDS
 Sj4luGAnCMMpAKW5dMspN4kIhkKmAhRCj38fkAvPEin6o2+VWSCCuBdW2Ag13GHW0Qw==
X-Gm-Gg: AYBFou2KTWMkLC+VlXXcGfpigCf9x1Ahvuh3YSqUP3XJgIEez5tbYckJj8XI1KegPVs
 t4/WP7GcLhUHv5lm9FOVcqAlXBP+QVXGEaz4UdgFeYyV1gDzM7IL2DP+XAzWYtaJvftNBS5i++7
 BpfcUzFu4w+1XXToyfcmM45Hje3HAepYhuPl63Lhr5wiqrUGZdC5ZfUy4nbOwL+7OK8NhAlsglp
 BrcETghAlsXA4V+TSqPRhDBtvdLBjYwg2tDbirpt2VhEgxpGQC9iyH2UVT/ZpOwjgCXZaywTmux
 yj9hKYjXJfVKfe3Q8hlX+2lMcMorPJGYydWg4QCdLxyiwVSYZGBWf5+ZaFuNrJIhOTaeh1OG5yp
 t0m754oM7i/da9rqDvzcdDzrZkLHhcDrm2KGQ11XCDuzhat7zeAHntD53rL63
X-Received: by 2002:a05:693c:4018:b0:33b:fc17:e786 with SMTP id
 5a478bee46e88-34c6672779amr683934eec.16.1790717124936; 
 Tue, 29 Sep 2026 14:25:24 -0700 (PDT)
X-Received: by 2002:a05:693c:4018:b0:33b:fc17:e786 with SMTP id
 5a478bee46e88-34c6672779amr683901eec.16.1790717124242; 
 Tue, 29 Sep 2026 14:25:24 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 16/24] tests/tcg/mips64/mips64r6: update failing tests to
 use check_binary_op_64
Date: Tue, 29 Sep 2026 21:24:31 +0000
Message-ID: <20260929212439.110454-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX75xu8ks4TU7l
 JpbofvkIEHcBYeq2So6KSpjoTiGmVXYpe+menHu3pk5Wwf6sJzGZPx1DY/zz2Ix8SMu319LdbnE
 gZJXNTbg1Yo73XQyncS2o4oqajk1XxxzUGL4UawgeO5i9z8GAM4VJLbzCOO/93vVNBxjD00NHwe
 u8cz7lLGlVabEBbht/my/QoPhyCkcFLP8vkFyW0VCWo1WSXqMSFgQpKQ4yPdYtDJxGup248LR/k
 fbMP17fUXOjdDYiiJeG7v0uUCBV7mVbfJeXl+cOM0EzrqR9R/aUEhiKdjVRLQmqd+sOxrBHQ83C
 4tp1lDalSiQLJ3/W0AWdn+rEeOpiajsCFoeTWnRwDJ7rvrh8uFS1fSDhe3WR7IQzdkc3x9iBa7o
 85QCzFaxKNrJYGNx9G2PYAZCqdXJBrc9vT1LbNIdFmaGt+TwpLhguRp7ftFcYM2Tu8ryhSW9yKC
 43niQsW6Nw+H5/IjUXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXzidWTz+NT8jC
 ypzBHtkEHkkSsjniP/7KLJXlTV9xRkM9PBFyRe8pyG3cUw53dJStl1Hpx/kndjT9r3pi0xgrRPi
 /Ouj9qNslBn3vBRTkvPMDDKK+Tzb7eE=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abc2cc5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZW_GBMptycfP_MiIRIYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Vc8amyXlwpKc96vCqUw2J_MRnonN4K1c
X-Proofpoint-ORIG-GUID: Vc8amyXlwpKc96vCqUw2J_MRnonN4K1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

We can now benefit from a proper trace to update their reference.

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c  | 38 +--------------------------
 tests/tcg/mips64/test_mips64r6_nor.c  | 38 +--------------------------
 tests/tcg/mips64/test_mips64r6_or.c   | 38 +--------------------------
 tests/tcg/mips64/test_mips64r6_srav.c | 38 +--------------------------
 tests/tcg/mips64/test_mips64r6_xor.c  | 38 +--------------------------
 5 files changed, 5 insertions(+), 185 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index 3a3d8e68831..f83359107b9 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -31,15 +31,6 @@
 
 int32_t main(void)
 {
-    char *isa_ase_name = "mips64r6";
-    char *group_name = "Logic";
-    char *instruction_name =   "AND";
-    int32_t ret;
-    uint32_t i, j;
-    struct timeval start, end;
-    double elapsed_time;
-
-    uint64_t b64_result[TEST_COUNT_TOTAL];
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
         0x8000000000000000ULL,                    /*   0  */
         0xffffffffffffffffULL,
@@ -123,32 +114,5 @@ int32_t main(void)
         0xc593578c78938000ULL,
     };
 
-    gettimeofday(&start, NULL);
-
-    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_AND(b64_pattern + i, b64_pattern + j,
-                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_AND(b64_random + i, b64_random + j,
-                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
-                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
-                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    gettimeofday(&end, NULL);
-
-    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
-
-    ret = check_results_64(isa_ase_name, group_name,
-                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return !check_binary_op_64(do_mips64r6_AND, "and", b64_expect);
 }
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 6edcc1e394c..13a51490187 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -31,15 +31,6 @@
 
 int32_t main(void)
 {
-    char *isa_ase_name = "mips64r6";
-    char *group_name = "Logic";
-    char *instruction_name =   "NOR";
-    int32_t ret;
-    uint32_t i, j;
-    struct timeval start, end;
-    double elapsed_time;
-
-    uint64_t b64_result[TEST_COUNT_TOTAL];
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
         0x8000000000000000ULL,                    /*   0  */
         0xffffffffffffffffULL,
@@ -123,32 +114,5 @@ int32_t main(void)
         0xc593578c78938000ULL,
     };
 
-    gettimeofday(&start, NULL);
-
-    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_NOR(b64_pattern + i, b64_pattern + j,
-                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_NOR(b64_random + i, b64_random + j,
-                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
-                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
-                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    gettimeofday(&end, NULL);
-
-    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
-
-    ret = check_results_64(isa_ase_name, group_name,
-                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return !check_binary_op_64(do_mips64r6_NOR, "nor", b64_expect);
 }
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index e6b07cd4bf8..e4d7a95d37f 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -31,15 +31,6 @@
 
 int32_t main(void)
 {
-    char *isa_ase_name = "mips64r6";
-    char *group_name = "Logic";
-    char *instruction_name =   "OR";
-    int32_t ret;
-    uint32_t i, j;
-    struct timeval start, end;
-    double elapsed_time;
-
-    uint64_t b64_result[TEST_COUNT_TOTAL];
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
         0x8000000000000000ULL,                    /*   0  */
         0xffffffffffffffffULL,
@@ -123,32 +114,5 @@ int32_t main(void)
         0xc593578c78938000ULL,
     };
 
-    gettimeofday(&start, NULL);
-
-    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_OR(b64_pattern + i, b64_pattern + j,
-                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_OR(b64_random + i, b64_random + j,
-                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
-                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
-                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    gettimeofday(&end, NULL);
-
-    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
-
-    ret = check_results_64(isa_ase_name, group_name,
-                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return !check_binary_op_64(do_mips64r6_OR, "or", b64_expect);
 }
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index 951bd7826dc..e98bb9b90ee 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -31,15 +31,6 @@
 
 int32_t main(void)
 {
-    char *isa_ase_name = "mips64r6";
-    char *group_name = "Shift";
-    char *instruction_name =   "SRAV";
-    int32_t ret;
-    uint32_t i, j;
-    struct timeval start, end;
-    double elapsed_time;
-
-    uint64_t b64_result[TEST_COUNT_TOTAL];
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
         0xffffffffffffffffULL,                    /*   0  */
         0xffffffffffffffffULL,
@@ -123,32 +114,5 @@ int32_t main(void)
         0x00000000000178c7ULL,
     };
 
-    gettimeofday(&start, NULL);
-
-    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_SRAV(b64_pattern + i, b64_pattern + j,
-                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_SRAV(b64_random + i, b64_random + j,
-                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
-                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
-                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    gettimeofday(&end, NULL);
-
-    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
-
-    ret = check_results_64(isa_ase_name, group_name,
-                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return !check_binary_op_64(do_mips64r6_SRAV, "srav", b64_expect);
 }
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 52981f73579..6aab6fc1d47 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -31,15 +31,6 @@
 
 int32_t main(void)
 {
-    char *isa_ase_name = "mips64r6";
-    char *group_name = "Logic";
-    char *instruction_name =   "XOR";
-    int32_t ret;
-    uint32_t i, j;
-    struct timeval start, end;
-    double elapsed_time;
-
-    uint64_t b64_result[TEST_COUNT_TOTAL];
     uint64_t b64_expect[TEST_COUNT_TOTAL] = {
         0x8000000000000000ULL,                    /*   0  */
         0xffffffffffffffffULL,
@@ -123,32 +114,5 @@ int32_t main(void)
         0xc593578c78938000ULL,
     };
 
-    gettimeofday(&start, NULL);
-
-    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_XOR(b64_pattern + i, b64_pattern + j,
-                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
-        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
-            do_mips64r6_XOR(b64_random + i, b64_random + j,
-                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
-                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
-                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
-        }
-    }
-
-    gettimeofday(&end, NULL);
-
-    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
-
-    ret = check_results_64(isa_ase_name, group_name,
-                           instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return !check_binary_op_64(do_mips64r6_XOR, "xor", b64_expect);
 }
-- 
2.43.0


