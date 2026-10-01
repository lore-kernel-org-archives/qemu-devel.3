Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D317CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxy-00086c-Fw; Thu, 01 Oct 2026 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxg-00082V-7F
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxd-0001pL-Vv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FscXm2686639
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0/rQZ75aOPavArId7LTU7jtbwhgCb3gDLzZrcZO4Go=; b=FhSsYrB0CMq+EvdK
 CVTDgS/mRbdOVVfjy7EKz6t7OvcOCfkMwOnHKPjfFYoldYVtdz/rHsOF2v5/mTq5
 KoIzFXsSULpsGjX+KQccxQWLjSI6/MOEpKdySY4hKw85HUvYgx0RdUo2LgfWglBp
 7Avm7vAyfCPiR1g4bSiZ74HzXL9gCodcKXML09YMVWjC+1t2YR58Mj31vvOvy0Sy
 fnfUlpUErz1ic+7gzZ7YZ6awmSoVp3wr8AITYzsi1ACqN2zH/E4LIVDxtQZDbYJ0
 2CcTiv+s9xmNzSCFwovdYserUNNkBq/Na/mHOgveWtgpjv+bkqL/fkeN3dDOZAOY
 kpmYKg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so4568610c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877158; x=1791481958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V0/rQZ75aOPavArId7LTU7jtbwhgCb3gDLzZrcZO4Go=;
 b=O7HTGKU/EfDxWhQND/A7SShAal3J39hWPBZZ9Mzyj4n1KBGZS07IrRqD2xblYZATHa
 //ZiqPa3QDGvoFyr99E/JJg6BFaGngevxvxrf9v1b17QF1z/QFsMGk4SD7HhBMlRFime
 ya2gVyA7kuwjJFfyRedIpTmHwRWphS9OcsubrG9PeDEF7uDRw/VvSP9mZ5pbut2ILIJB
 9bkLMdyQbShNqRKICz+GuoynuqKppWke8dEmvDOq2r6VZceFfxirrCsqaxYpF6N9suQL
 98LiaTxwUZuCAtjtFqC2Zf93GF7F2XESYExZWprD6ubfphS7g+fS2Rk8j2Uo/eyIgtW5
 nHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877158; x=1791481958;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V0/rQZ75aOPavArId7LTU7jtbwhgCb3gDLzZrcZO4Go=;
 b=XCllcyV4Pe8avXoxMIcFUBqQ6V73DGIqLHnsi2Rdz+HTdBA5qcSm5Dxmn2YQCHUOMv
 pTxGPvBsbalUehLJw/j1SuCltu0ugGkrHa9MhkAyIGa5YDXF2bnYHPIH+lwi9Ha0cSiY
 Yo8fh19wwSJgntyHg94rhpia8emU3sXBDXFVABAJ48tWq4se6lpZ3oLajQF4Pe15fGhC
 IQZmpfS/LE2NRMfd9kaHdy65ArE2RxS1CBktaSfE65p0UuwLWMrg3MgHuEjlYjWrpAUR
 270xaFAiP4/WbT5gQxpIIrVLuDFsP4jZPOTyRyI6Q140SaqFwYYMIYzAcgowMulRV8br
 rkvw==
X-Gm-Message-State: AFuF++lVqLYvF1EB2E/kQNpiReaexFjDEnItwuaiUdYnbzieioL0wo/g
 535PEUUtE80iPTY8f9YMpf8Z+64dXB/LoRKckmly1G1wP97A6kurBLJKQUBz/WCbrneqKpILNyE
 ahMCy9gB+hIyQuGmMkBotPWlJDm4kKMFM4wpsAMVe/fgvvL0hRy4jF9MzlRaga6WooQ==
X-Gm-Gg: AYBFou3bOZmiA6zanuM4s7vEJS3KLdcuX7KyP4bHKx/AwFxagMr7JGupihm6bEFQdsO
 T4nHMlVMRUUE/cqTxkGLZL5Vmf0DiwbeYcc2iEGkiWkldXrs0T1BrbshwzDemUvnocfttdQqAkX
 /PxXXuBEzRnnmDFwxzVVI63EQc2xVGeu0E16BIWDSSvABJxMOQzNbotiX43lK16sghKMy2Bh1wI
 Q/XQSb2gd81y4mTQ7qfvQhW+9dTabqq4cb8oyOsePTqXEJD6wznKETlTJayH5hGngPNh4TQrpy4
 H1bocIupCltmapDNYrTo8SWDe0yhCvW6fP6Uj0WCgOlOex3KuNrSKQHnL3jm8AJpP2Bs3L7qtIW
 gHyp26KEoC5PKlAtS3Rs1xQJ/UKgXvm56sCdDaXrQQgtrK+/E09nQwz5HGxsc
X-Received: by 2002:a05:701a:c951:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14dc23ec9ebmr5205394c88.10.1790877157820; 
 Thu, 01 Oct 2026 10:52:37 -0700 (PDT)
X-Received: by 2002:a05:701a:c951:b0:14d:c23e:c931 with SMTP id
 a92af1059eb24-14dc23ec9ebmr5205333c88.10.1790877156783; 
 Thu, 01 Oct 2026 10:52:36 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 16/27] tests/tcg/mips64/mips64r6: update failing tests to use
 check_binary_op_64
Date: Thu,  1 Oct 2026 17:51:52 +0000
Message-ID: <20261001175203.8673-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4XjGbPvp8tKO
 C1NPsGmVtYTeO4GjEGRWG84Ljn2sxjQo4Ac4VVlLVQciZBbchPrMyWveGqMy/FlBhy3ARSMMYXk
 Gvow6do8a8GtR/UL0KiEFd88SnTASzM=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9de7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZW_GBMptycfP_MiIRIYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: a5-xQWtmslibd0ohuKEun-TJeaO3SDdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxfGftDvKV733
 1PS7R6WyXQmyf1ijYPNBEJ4ydxEaS64TAhYj+O7j4GYGVe2F5HBuOaYYEezTvnTqeiW11md0OW9
 OcF6mZNfV9VeMbn4+ynEdSZKdZL8i/KTygKFMfsxd6f6ZSDcHWDq5AcPK3VBGraC1kdVDlGPN/k
 nVeMjMI+WOC4n93HEqc91bGRIq6zLv5on4Fgfwn/KGz00v37JVK27osaPIXnuGOj5B0CgtSVJeT
 nVYXeHVPZN7fuVaSvbaH4G9FLJgWI4VAuNA3OtWVVnfZ8SsPE1YBK1FjUfXlfyY9XgQ+Tqib702
 yJhT3yLevquB2Be3025ftuOhpTNf4nBrpoJPxtFjPNoo2GWGUzOuKn2r3lJofM+SIRkF45prGgN
 UZAsSeSn2LJiJZ8eqLHenxRZ+hC6HYviY3ZW2hbfi9ROj+iU6O2q0eHoNT9Vv+R3ZSptW+DgEAn
 QPEH/fjcFLxFmAN50DA==
X-Proofpoint-GUID: a5-xQWtmslibd0ohuKEun-TJeaO3SDdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-17-pierrick.bouvier@oss.qualcomm.com
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


