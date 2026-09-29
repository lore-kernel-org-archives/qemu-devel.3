Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344D5CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSZ-0003ER-63; Tue, 29 Sep 2026 03:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSU-0003Br-Gl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSS-0005ry-Dq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:41:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tr5d3684709
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aC7r5+mcTfu
 WNp3B9fT+dwR9kpimNGXtzOEVd7ErIEw=; b=SLjy8JtdOU7M8uccESm0PJsdR9C
 VLrcbtVsvv3dMOvIgjJBvMsVi8vyIw+J3e8pcVbgRucwFeP5O7TDxZIwF07XA+dF
 dyaxffW9d6+D+/B7lnSX+YRwE5EMDyM45zOuzyldrNayacqosd/HqhJEP9icdBiv
 2t2UQoGRHhRlgB9KOVY/2rHthd90PL6I6T5k7ag7gVl6R5MNV8efx9AfvwbKuotP
 nYbqlxL5jrZftdpvJKUAwRhuxmxNUbPM1kNNrbxo6BVBHHqhCPlPmftHIF5VFk3x
 0daW3y51+hr2r9tm/KYXl+idkjv8aOO0I3yV/yU1XwCGEt/It4Fw5nmyzTA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144sru4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so2042764eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667653; x=1791272453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aC7r5+mcTfuWNp3B9fT+dwR9kpimNGXtzOEVd7ErIEw=;
 b=gm1abKuhU9YcI16rHdr6jID/hB//B8r/RaRj3YCjd6P/g8US3Shk7S+rVS+qvYtWQ4
 hFdneVlAy4m+fPygizdvf5DQpSx3wEhvx/nTcxJZZrr4i5HHaZqKSnBk1vPcHWbiewKv
 DznWwMrglGKAQOH4j+r4G/H1qC44iFsnye8Dv1X9RW0XLrJnr6kj2DXq0OJvC4/eTxft
 W0azv+sz9aGTZrEuJUWhGAV5Z8SJqw43rrZcCGVNbOVGXn4aoRRCIvQqzh+XjsPiVz8d
 Q3RZhBMZ4LDWiUjfHxWJA8vl7uvABn/SlZJOc5oHoUMZ9L6zka2LROCV54lIyQnzBIMC
 5GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667653; x=1791272453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aC7r5+mcTfuWNp3B9fT+dwR9kpimNGXtzOEVd7ErIEw=;
 b=WgwCw3oAl17FZMcJgC2lgboAh/eiKTdYPi3CYUnlGg2t6pxifpZc8rJEbYlS2+sIHH
 LL80YZ/6pUYvaPi8Pcbben5HD8PBoi8DdsdRoaDXw0XL1W6OVbVyD+IHxn3TCHkZoAHF
 XsdZP2nUCnBw4Ct8TfAPiDt/HRBT1umnHBXXIbaLhVOqXUT5ovBa03kcxqymZXO/0qa/
 lepIYwp/5L7Yfxo3/u7kIvwfo/vqVKYUD4ClIvZ6hbDWYb14oQG/E6Hiyc+1QsF3sN1h
 6Jfk33ZvMxAX9RE1bV3Vg8PAm4I5NbA/28MntJLqm399StWPiSNs5sc763mCVqhVOkWH
 51XQ==
X-Gm-Message-State: AFq9FYLluy0dGaxUKkLij8nxET5Xdabv6oa1Dt81cJOs8Gkrgj6XeujF
 V3m7ZuASM4cPMHbVwAx/DPEE5iUCIR84DDIxE/dfjDHWw58sMWYnhlGZh/3Gi2d+XrBVog8bLQp
 d7gkFNT2H47E/iXgw1hXS86TvWYdmM/l3LuCusQ1ZFtcx4wexW68z9oIuduDvUpd5/w==
X-Gm-Gg: AYBFou2YRi7PXpClsySwl0vsVkWzuT0EZJKWPXlF0fPEI+C1bN9goyXmrpZlKUYm0fB
 IKVJDybStyXoMS+2Ix+lFw0we2qHa9kT8LCMqjszzqK9Mcf1n4HGv9HIxN+oKVqw0dhtXGLc24x
 EKma+pGoZG5MqIdwHxM8ih3ZNIspe5gH36oLVZZnrHqm4GshUJT2A4qL5bEVFEQniK7+rkV+INZ
 4TCL+tNnUcUq75+Gu5I5HJ+q8BEbhr33RtMCYAPw/I3u5GZ1yLgL53dpKEtVk3oS/ldRp+TimDk
 TsXsJdwTYU7e3JD/Ba4l24wZXl5nkKp7QdsVwpABtZfY7HcjXdggiSC/orJAur/tgq+FDq1HG3t
 fcCTaTSgw1C6RCtFXGLB+q1ikWLlaAPs6UwrZKksCLwstZzgNqm0GnEZdbA==
X-Received: by 2002:a05:7301:a2d:b0:342:9a9:1f68 with SMTP id
 5a478bee46e88-34272179374mr11720637eec.23.1790667653206; 
 Tue, 29 Sep 2026 00:40:53 -0700 (PDT)
X-Received: by 2002:a05:7301:a2d:b0:342:9a9:1f68 with SMTP id
 5a478bee46e88-34272179374mr11720612eec.23.1790667652595; 
 Tue, 29 Sep 2026 00:40:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 16/19] tests/tcg/mips64/mips64r6: update failing tests to
 use check_binary_op_64
Date: Tue, 29 Sep 2026 07:40:04 +0000
Message-ID: <20260929074007.118970-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX096/WawSZQwD
 oabk1QkowfuJk1ly9nF3wpTW/p/elajFP78TaOu/JRVBDXzaI5/e3ipeE98PCo2dlVVkGb3qnl0
 ugB41BG2jpxfp5MTCro4rW5ivLXjmBcjXpoYP1eaO+6P5guUoFfGS5c6HLXrBRk7W/qUyk/9hh/
 0fLYWonBK68EsuXV0He09ZYdUY/KIaY8I1krfGTksrBIuEvZZEa6UFdpuXOdOBBOzalUgtyE9Mr
 94NGDR4SkI2RmMAhIFkXkvcCdW7dc5pJXLIAXvKYRyjskKD0ogl8nM9FSWQcgQ1xtjqFsoAfX3X
 L32pc1BsnHOIMJvcBiAyONdbZOSYakqb5okAj/Z7e6o0xDOsqNgY63M40Hi4Q7031qvliyVWtfl
 +3k3jvJ+2H1cTXpFM2mWO5AvDaCyD3Rh1j19vSB5B01aMKaad0jXh2qIK2Jd44iXjwh2vYsa7nx
 v8CrECTIUypPBmmQhgg==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6b86 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=PcVzVgQPoUBHH7xJLpkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: iu7YnZUFeIDOjKwTYW1KiXYxHG9hxC6p
X-Proofpoint-GUID: iu7YnZUFeIDOjKwTYW1KiXYxHG9hxC6p
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7Zd1pXk82eek
 vR/RiS48jcMrmxWJY6kzASFUOWPFRh7KzBwb+cBDLL7dM1nLhtUPXe+6rK0OUd0H3YTUrFeZ1QD
 PhEBLW4YmA8YD0B3NBv8KGFOmNkz/JE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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


