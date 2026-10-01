Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B3CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxi-000833-FU; Thu, 01 Oct 2026 13:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxf-00081o-HC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxc-0001lw-3u
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FtBMi3355914
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ArdUb+HUe53J4VD1eBc8n6LB/koYmsFeFR+CxtLayQg=; b=BWmwNp514N5KYDJG
 WZaDTwzknixTpod/zZPGMWdlbHpL1kXB+HYxV0xS82xK/x/Qq+R471qdmQGVTEqk
 drGnU8n+A1GnBv+qHxBq16S8u1r/TwCXAL8ZMmq4EXQE8HdjbZN0co1QekQV/qA8
 OQZVIBsEbg8k4NPm5QxBQzyjp5CNO39xd6RDEqs2H/JP04JDDMl8muEg2WHfGL6H
 lcCOP6/q1UxQmGj9lmGzdUHY+yL5PUAU8jC0mgR/sOpgS64oMifMfb3FKtHqhIaj
 TnkAz9zjmx3uJMgnn5wWJjmyIzy71Gu4Lr/CCpv8wTSKlotJjQvQMHmF/la+jz6n
 90Gnqw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nub7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1431ba79941so7872605c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877156; x=1791481956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ArdUb+HUe53J4VD1eBc8n6LB/koYmsFeFR+CxtLayQg=;
 b=blE6FeqDpmVaOsdHgqX87inhDexJ2cC0JiK1V9oixqKmUtBSN+IJfiPIrmSTS55giU
 PssRiLlTFgCTTvNFNUXB9dhCrRBNFJpykg2hmYOMp4AGkCAwVUQOzXgZoj7g6+nsEKa5
 KHRbaJIW2ctNhpeB3FJbZdtpPo+8kJ6BFQQsturmLyxVy0OpAijMb30ARZV0bhPwGNym
 msSFv0ya+I3X/Itb6nHCtcFXsclsfa1hdNMhmh986BQLHByucigUgGaOaNQOX03Ds2Qu
 /aBc+ChP0MDKNABQYMRTF/+JgV6ifBdwcQHDjFG99fe0HlsIrgChnuJ7r+RdhK5Pvq6q
 Z91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877156; x=1791481956;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ArdUb+HUe53J4VD1eBc8n6LB/koYmsFeFR+CxtLayQg=;
 b=UprWilPV8Ddtw5TWaghOkZzCMopMgr3Y0o4x1IeSdM2Fh8L4x2n3BQc83yd4MBMVxM
 jaSkoUNwfaVhKINvyItqpnu1HuUYVJIK6sJ94gPRUWHRiBie0G+w0q/2vT3q/pArEl8+
 5fvbbeOdd0oVWgJ6uFym2p9S9srhdXQieI9bzsqfX8bJyjvqoFhJ6PCDgkzCc0G5t9hd
 4B7x0n/HZGjqGgfXGFmeV1Uf2Ctm6rNZdB/mrkD6yBHuZyLqvKG9bk+rkhTJAvV7iPzJ
 5Tu4bpoq/hyMC9aVoEsje2kxg4+ozVUNhP4f0vdG9mF4Ou6X8PfOadOUfNzJGPq9udEm
 VOqg==
X-Gm-Message-State: AFuF++lf3y6Bu/intlwaG0xZi6NUzLcrFLQ6PK4HHnVrtFVb817xDMZI
 gCOauA+9yW+ixXo7FO9h/KZKsZzRUMpn/Nt+1l2T/vnqDH3QF7IM/uq75QE2ogEBhLWwxA3XWJ1
 LwPUlBizLKbCpWhwq2agqnKiPVMzXbfDSs+/0PMS/oySV1ccZlRVS9MYtLzUVWQVLmg==
X-Gm-Gg: AYBFou1sJgj6YpuJa5aRa/FfApXptHx0XONFshhmOudpjXDeBHTNymLfyGQJYIMT6Cx
 tjV8jaNPGiJGqdOJPKEQ29/e3r7l+9lPBc1GNwr3IU48FIJ+su2X3I33END5alBwgFC0jSM4sId
 kP3awSUZZgHJ0J+aeySGZs2fFZN6zNRVFwg1G9sdSF4F+fBqOMVrieygm9ZH20Pfua53LvW/Jhb
 4KfN+QOeimMUzgAoV1VSmI21/f6c5kBBDJjlfG7KK5/VUCxEUzgJfCkcHP0uLdV5i5K6ZsyYQt7
 P+iPmMEk/vGT1kwIIKdyIi72XLME7vVzdjBbJ+E6cOMzHbgr8txHmrxyRphlKS5oI6QSnOzUWWV
 UmXwQdcQe4gidCUeR+65Gfag5YNkubzzRIG4THhP4do9gPumQGe+unutP3vXG
X-Received: by 2002:a05:7022:fa2:b0:14a:c6cf:1449 with SMTP id
 a92af1059eb24-14d330b01b8mr8821787c88.32.1790877155549; 
 Thu, 01 Oct 2026 10:52:35 -0700 (PDT)
X-Received: by 2002:a05:7022:fa2:b0:14a:c6cf:1449 with SMTP id
 a92af1059eb24-14d330b01b8mr8821712c88.32.1790877154664; 
 Thu, 01 Oct 2026 10:52:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/27] tests/tcg/mips64/test_mips64r6: fix call to
 check_results_64
Date: Thu,  1 Oct 2026 17:51:50 +0000
Message-ID: <20261001175203.8673-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe9de5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=au1VBuIrrAiolwtL1wwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX8Kgn6H0bg56E
 BPrIImdmqnJQRkYAr1jMEMzCM/dBif+KYViJvGr1X6+3v5Mir7jwRrZZjGx0iyTbgKJd3j3kutI
 D0ln0REUlpuBONoQhTT0ovYc5Li74AY=
X-Proofpoint-ORIG-GUID: VZfN7aF6lohqPkjPz-PMb8uTd5qezIw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX9fjX6mWZRpAS
 jJE9bR9qWOU/aFjePW9MJjrIB/jtcmmS2fziQfZHqxHlkUeBWAWiuf/tVuvrE9P5vjlj3nnlfdP
 XSJVgFhk4qHrIy6tcUcnqyeOMiTjHqz78wpxWKFnQHCzbQJsh8LRtLxyARYoRM8fKx+wPgxmxI0
 +lCzOtVXPEOyejLYlkaIw/W51KsmCQSQ9DJEU4JbKCtGHJHpyO95QGq4mW0IDb6c/BMURlWlSyw
 RFeV6ynwJXELk/VtHuSA/2ciEzxo9Dw8+tqW5Em5y2BYvirM+bXya4fJSWawOT9euvvv8V8zXB+
 186nQ6Ay5cFqE3ELiDgfPcNxMyYf8UwO7WDxEVnuV0PxlhlSfNIGi206bGdft/n8k9RSN7/hLXs
 5LBYgQmhwcSm1A+lN1DgcdTF9EnshkJka/CMvsIWQCmyjCuQc4/YyynCC+qPuaRLBWbYYeu++6c
 SJkuiB1X0TwajBicsXQ==
X-Proofpoint-GUID: VZfN7aF6lohqPkjPz-PMb8uTd5qezIw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
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

isa and group names were present in all files, but not passed to
check_results_64, which expects them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-15-pierrick.bouvier@oss.qualcomm.com
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


