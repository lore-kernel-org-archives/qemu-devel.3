Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34D0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKK-0000SH-DG; Tue, 29 Sep 2026 17:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKI-0000NG-UF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKF-0003sS-Qg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TL0qHq942361
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 00b0x4BcKuHK0PJLODljFnDDrWevc4u7cUXy3tIJ0Rc=; b=JmX8o281TnUFzryU
 iw6IkErHMwctZ/b7irluilQbczVd6Lw/QrmzqmQdpl6/0xrvUZsU/TNEVvgyuXmK
 bD3aNEy+z0sfHRl8SjZJJSL/ESAHQxSgKG9L0w6tVFmA7QBYAwQUoCq2+t14To+S
 YbQQmrtm/2/JVjrWe1ZULe7reHMtkzXguljOZAfAyydWMB7OlBBLBifXQbbiANeC
 PPQ+KmhOuZ3rcWywYXcPh72+seC5hzCF/LL97OJnkIJsXFqAOodnmnGxgMn2ftk5
 jcbKZGhFTFawjKxD8nl5eGkjmb/LZsEt+ssXSbLdc5jK1YdbQzQfRa6AoH+VQsXc
 NVfeXw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftuhjuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-349ffa249bdso3887813eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717122; x=1791321922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=00b0x4BcKuHK0PJLODljFnDDrWevc4u7cUXy3tIJ0Rc=;
 b=YBeiO1p+ZbfBM7iRtQCkgEmBQJzkc9iNa2V8mmO8eoBdjsTMH4SEV7Q9e90PYIwUhK
 kCDTSV317N5lpofyQj2aENaRr3eQ4L7sC7TZAPP1p0ZumWWJtvK8yJRIbqKOghBqEkKv
 4YhgR3pmCsAD96JzBXNKJN/jv/ggDyizL1iQvCIJ/lTLX3f6AAgcocxn+MLkgnZRIAjV
 CwacZvZJlegjbL2CGrbyiO+2UUS778z/SVvM3AY8eKzHUNg9sd/wA95yBaFT1CoIE7rV
 TdCrdmr5pc47vzaUBWDXhhBZ/ou8r1UiFAiMXTarCp+sJPh9WtX/44XoPweNiX9pp8qL
 w2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717122; x=1791321922;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=00b0x4BcKuHK0PJLODljFnDDrWevc4u7cUXy3tIJ0Rc=;
 b=25NKagN8dNEed+yVnW7LihczktqdkLxzUeYVZ7vNcSDUeQDyS7O+eyAYY/+ueRf6FE
 d2UinqbSnvh/7c+oV/lL+VthEk4ytcWjS4o/7ratBhE/RXISlcxhTyL+itIlSYdjOCGC
 VGquZd6OMX2pCw8XOfMm62Qs0ZaC0lNK32F4VDKhRxH1UB6Huu8/3J17oTCNoLjv3QRj
 B+CSRAP2YDa0UOusA6F8n794tcSlJk5mGo4uBXhtTAuNZNvW1iqLeKtHKdtaDZoKH2JE
 hwSLbRVrdRP3SrLGhzxcdGjdzAhSXyxyUQV+nwznpxu7Uby8c+QknzRO8jw9sfyspVnq
 AhoQ==
X-Gm-Message-State: AFq9FYKwAWAsXa1RIdXqsHTg+KGIHjafwjhAhbFZWNt0ofLVSFWXhC7s
 rD8fW85VokhGicC0413LrYASlBcCt6hKSDQCNyJ8hBoJ1PHAp3KMzH7ecjUhi5PLAdjNLZYCeb7
 ehOqGvsjdtVYXoqSewtukUpc/kYADs17/hzOZd14MtpspRPgaVLMxs1hEsMs60U2gzA==
X-Gm-Gg: AYBFou1dKuz+znUvQkM61JlXrj9GAJnBekRQy0P+UoTbgM/mHr9GDMrDpw8Cli/viQM
 vMT/8+0qz+NBWgMMEDpoTI1cXFDONPJyor/s+LzxgVxCCJAY6hsZGD+jrvYn4kDGll/F1D3c/S7
 CPmccMCgyrfwKXiOOMQuxA2dl/5YVJw4cY/n1KXkszj+ZVabpf4Up1mbTyy322j3TtU8Xn8wLDz
 LV3HCccCsEAzxI4bSFX3VhyI2YVntyJidrqKFP77rRueWmg8S2BxB1Gvo/dvOwGIHuF3cG1f9VS
 7LbRkXrWUyDncsLTEvayu9oAUphl56Y3c6aUeNQU5oSZYqdt77dmIOLhxiUHvebaKhuM2mAfVXL
 HUTo6PqgqoMxrDBCFJHN1933+q+wDC6TfCbRrav9u3HxMDE0CL5dnhojIn1Ng
X-Received: by 2002:a05:7301:dd84:b0:342:a328:fe1e with SMTP id
 5a478bee46e88-34c672e5098mr688962eec.28.1790717121490; 
 Tue, 29 Sep 2026 14:25:21 -0700 (PDT)
X-Received: by 2002:a05:7301:dd84:b0:342:a328:fe1e with SMTP id
 5a478bee46e88-34c672e5098mr688894eec.28.1790717120146; 
 Tue, 29 Sep 2026 14:25:20 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 14/24] tests/tcg/mips64/test_mips64r6: fix call to
 check_results_64
Date: Tue, 29 Sep 2026 21:24:29 +0000
Message-ID: <20260929212439.110454-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX5acLuWCHt3UI
 V1kh4EDSpUXiV4lk/loOjBgYW5fkewsxFDgA43hYx/oONJvo7ck+yUp103keA2H2ZqQEtysK6Id
 CEYAO8dZlxvub95HPe3q+HwEkFxXG5TgbQuk/AZMaJ2RSK9+MAhyvpvmWmW7Rif2Q4+1amoAHlM
 lynV+M9VUAhVTh9YE7BYn44WyK6oFCSiKn1ogoox+9wPGIVs40C+mmLBCCgy/dE0acC/dM6j4AO
 aea4xyA2jFCtM6gmEqwRtRe+ALM31HDPp7JeGpz2pS786F9zdctYIRMnGVZRpi7g3qjlKptxRNw
 m/49j6BWdnL9QZGEjQGAgQlEuTuz9pcAncPY9DdWeFG+LbWQ+g6WKwewPepRB7iSSMp5nIwp67K
 li8DwADAbPWJBtmIz7RpTp+KPVp2Ur+pNhKEkz2DohuwDOSOZ+GB41vRyeqg+7FV5hHCqMKJxe0
 bGhwhABBGmjX5bgP8eQ==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc2cc2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=au1VBuIrrAiolwtL1wwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX7bvLKG0U1m8P
 7wOSxNmCzTnjV7ygAjG9BD0Md6MaiNAyisJiWChaUiByAMU8icCvFja5HqhoOOUX09sRC0Qrv+w
 bRp7Ifg1dKYVVRk25i0RdpyLMHcDD+Q=
X-Proofpoint-GUID: L4tqg-GdFAenZPTulQp6FGei50VQL3m9
X-Proofpoint-ORIG-GUID: L4tqg-GdFAenZPTulQp6FGei50VQL3m9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


