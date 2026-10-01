Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53810CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxg-00082T-7B; Thu, 01 Oct 2026 13:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxc-0007za-E0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxZ-0001kU-0f
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Ft5xZ3355856
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oZ6T/rUJbKvq74ZpXHAO96KkEZpMJB1GRPP3PdMqKvg=; b=c6zfQnbkqUD/51km
 SSJxdxeKfKOZrl2qsQUlkUpsNHbFG4uL8SNYmDV0Z57tv6e9PLso1J9/VXAHqPDq
 9GHnJgN8JH6h55kKR9hbcITxULyS7xfwy8i926mF/pMVxN80ciwVtPDH1fO62Mcb
 wvPKnt/y7xk+6xax0JySZ0TmHxOnnZkyiT02KkhxGgjG2VXmcJnuosyVGIkGqzvq
 CGifdu5F9mu2uDe0srU6YmEYdX+uMoSu2LzGB4o7+pGyWWT9/OZj8Iaf8eV9JnkM
 ASEMer4N2X4eUrRYQtqLyGz8Rfu+PgIB5SgFi8trZAEUbFYuSstZnTQ2Bd1JT7W4
 qKFCGA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nub7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso9220525c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877152; x=1791481952; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oZ6T/rUJbKvq74ZpXHAO96KkEZpMJB1GRPP3PdMqKvg=;
 b=PLkLUJd1+LVA+b8zcLvQldXpG7NDJIhHKDs+mqC7mnOp0ZniD462CybZrnZ00RphjH
 HeNs5mKhtPiyttrdpzTrW8VyiTCH9LrHKccbKx/uUJ3CnI77+agZPUrLm4yluVah2lKz
 4IxS9oxovP+JMLpJ42YCMPBG7W62khlMdmnIKKEJaLyzwRzqe8iYAXPL04uAns8l0Rlw
 3pvovopA4FcbH2JGloZNTTN0nblbMfXwxgeE227paCpya57e7hNdQIWHRstkR1htucxi
 6cwZggEyloBCoqgBDW/Hz4SLzXIzB4k5/c6jgOE4mijzlUTc9beB4OXYz2mJoMTpnWPC
 ZCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877152; x=1791481952;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oZ6T/rUJbKvq74ZpXHAO96KkEZpMJB1GRPP3PdMqKvg=;
 b=BxoE6gT6XMU7rjqtZllWVsjfUK7sSki/PmA6FLio/7227rkhIxoTn+B5O8Paiy5fIl
 EbuJ/ghK2xgnEfxYyQUCjznwy7gZdfoyIQBTjcsUVjbJ3rx0TqyP5X/CEVTDU5nbbSEy
 RwHikN28/qsrHOyC04rfbbx9XdGhe+F1pRLHZ4m0lxGdHCJHl1ezRIw7ihBY4wVbK8QS
 2iu3lLJy6KYqO2jJffdMHSBSEcRrD5zePPRMtIAaojFAapYWmLf0jWkgvdoXmX/GFKgK
 qPZ60PJryCVENBVg9QU5tyS6n9ioIX6ysVlhawbTjWrRFwQFWNCG1pdjFDOugLXfQzey
 UIGQ==
X-Gm-Message-State: AFuF++k27I3PsCz1ywK/HZcn/lmPghVIatdvo8OzbIkLT3WL9CpP7GOV
 sW5NPKlyybVmHK1tqPPfjxI/UvBuupyxSzsSECZK9ycUEYAKB0/7sBh/MIZw/v4+sOYhJVwo4Wh
 yvQFMviPB2Xp6FAHDzsIBQqoOYr/kYPt9ouOPEKRHeCBdzQjy6zr6IBILjrLRtAiFuQ==
X-Gm-Gg: AYBFou3uCEcLJiw5F1OcheXQELal2yYbxEap6b8FJQEyxTzCN7ioxpgKTTCqvFrbZ5m
 CEDazr3EO4MLrRrG2XZRN6hYO1HJuN/b3gDof6XBjnuG6MKYL4pzbXgGTRZgJA2S/+3BuTEbGWz
 /GUHzOBjv4/tnx1ECUUw3GbPv5rVl8HRq6ZO1Mzi8ECjdntDw8R2e6SPVuoNVV7RPYm0OHoJeC8
 B4rBYJUBqA/nd6WYQ8PV1x+G7jEya6Ic0T3gAIgR5Umlz2P6LQTKsNtqOeET5xyHfZOUpxhUM1C
 8e7XkF4dwFHrIxkX2v8lA/s2qvjyhz1oQlg3hlFZ/zGg71Dw5tm0mGHvCp+MeRgIt8n95hSMwlq
 TggClJtuR339xXHw+cI8YvSLnfdD1YQ7+10HMCkjPBpPxk4ALgNkqHDetp159
X-Received: by 2002:a05:701b:21c7:b0:144:ed03:8972 with SMTP id
 a92af1059eb24-14d31798ec0mr5820869c88.16.1790877151536; 
 Thu, 01 Oct 2026 10:52:31 -0700 (PDT)
X-Received: by 2002:a05:701b:21c7:b0:144:ed03:8972 with SMTP id
 a92af1059eb24-14d31798ec0mr5820820c88.16.1790877150801; 
 Thu, 01 Oct 2026 10:52:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/27] tests/tcg/mips64/test_mips64r6: fix include path
Date: Thu,  1 Oct 2026 17:51:46 +0000
Message-ID: <20261001175203.8673-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe9de1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XxA8iSUrf-6v42RAVLYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4mpA29ih8C/P
 FoRKIO5/V8AJQSVSBIGKVF6cj0zyrBFm8ofY3smNdkyyVKk93nbt5nVvL6YOti3+i5NyRjqd0/P
 kLaDEa4edfux+h0C4phBgc4pPYqaEbQ=
X-Proofpoint-ORIG-GUID: L_Jfz1LZ-WYbjF9vHuRHFxc0w2G8zPAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX5PSXG05MWXeQ
 Lah/+LF5+eC+qpnktVVI7tm++Btn0WhWysKjnUXg255++qt4ZCKaodHzt21bvl3tLAFJLr0Y47Y
 Xqu9MznHU0NCQHFU4TJsgxZWxgeAFEcUiN2Rzop4EvZxZQ/sNSrGHUFQlIeIr5fq4i2uh/J7+Zh
 0qW60g26ZqURU1Y0v0WsmZ/bQlR4uMehHazlDUWejqSgYAyCvpoyn2IvLgqx4t0KHAfx4uBQf14
 7+IuMZcxicphuYMgSfGS8eBpf33tOJ862sGOxsBxNIg2Iu2cpEd5P8CmTaDZCgmdw0VF3PSFmk9
 i1nYSyQJ63epcMk69rPu+2tiRLIiGS8b3myjHPy8cVdhRemTvUPes3/5ptxxCao5yR2QGudh+2z
 Lv08ZtFzPgm5dCw0DW9cfoXAxFlfokpz+Odh/l2mP7lBb1HWE8Nt5ho9/8aDv6lRTNqMMJAgtnY
 aOjPE2/1WFPNPDYFg4g==
X-Proofpoint-GUID: L_Jfz1LZ-WYbjF9vHuRHFxc0w2G8zPAO
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_bitswap.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_clo.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_clz.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32b.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cb.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cd.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32ch.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cw.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32d.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32h.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32w.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_dbitswap.c | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclo.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclz.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuh.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuhu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmul.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmulu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsllv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrav.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrlv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_muh.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_muhu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_mul.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_mulu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_nor.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_or.c       | 6 +++---
 tests/tcg/mips64/test_mips64r6_sllv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srav.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srlv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_xor.c      | 6 +++---
 32 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index 4d6cf2e1f1d..38ae641e907 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
index df3d1b11f6b..ae2f74b34ee 100644
--- a/tests/tcg/mips64/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_bitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
index e7ecdc59100..611dcc9572f 100644
--- a/tests/tcg/mips64/test_mips64r6_clo.c
+++ b/tests/tcg/mips64/test_mips64r6_clo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
index a77a8e4eb59..3f89cbdec2f 100644
--- a/tests/tcg/mips64/test_mips64r6_clz.c
+++ b/tests/tcg/mips64/test_mips64r6_clz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
index bb1f3f69249..7b8955cffd5 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32b.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32b.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
index 1439d44bf20..58479c2733b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cb.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cb.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
index bf258e0696d..417cd895fb9 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cd.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cd.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
index 0e7b67732e0..9ae4804e687 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32ch.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32ch.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
index f7110b3a0a4..2e1ca6f836f 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cw.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cw.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
index e391be803f7..d916ee2586b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32d.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32d.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
index 100f02c7dda..72575e95858 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32h.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32h.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
index b4f5f4bbee2..4518b4fe482 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32w.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32w.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
index 377835940d9..7473f3f0ceb 100644
--- a/tests/tcg/mips64/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_dbitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
index eb41fbdfdf7..a6f8688b76c 100644
--- a/tests/tcg/mips64/test_mips64r6_dclo.c
+++ b/tests/tcg/mips64/test_mips64r6_dclo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
index be393ac1992..ab2d3eadeff 100644
--- a/tests/tcg/mips64/test_mips64r6_dclz.c
+++ b/tests/tcg/mips64/test_mips64r6_dclz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
index eb21615f952..490c81f884a 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
index 7316d79e2af..28dd2026418 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
index 3ac1965cca3..2a33d678992 100644
--- a/tests/tcg/mips64/test_mips64r6_dmul.c
+++ b/tests/tcg/mips64/test_mips64r6_dmul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
index 0862780e3de..161d1fe96bc 100644
--- a/tests/tcg/mips64/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
index 4f719efda12..fc93e0b218a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
index 024d508ca87..e496e8fa83a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
index fd1c398ffde..2c4c04f4c42 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
index ff1ae6fd9ce..8f371e22e61 100644
--- a/tests/tcg/mips64/test_mips64r6_muh.c
+++ b/tests/tcg/mips64/test_mips64r6_muh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
index cb2752767a5..79824c05b13 100644
--- a/tests/tcg/mips64/test_mips64r6_muhu.c
+++ b/tests/tcg/mips64/test_mips64r6_muhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
index 5cdc4d56324..9589c4c3a08 100644
--- a/tests/tcg/mips64/test_mips64r6_mul.c
+++ b/tests/tcg/mips64/test_mips64r6_mul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
index ccb3bdc1ac5..72b4d038cfe 100644
--- a/tests/tcg/mips64/test_mips64r6_mulu.c
+++ b/tests/tcg/mips64/test_mips64r6_mulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 21005ddc53b..04b841c8df1 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index 345b4544fe0..fde9601a78d 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
index a5fa72b7278..46136de0634 100644
--- a/tests/tcg/mips64/test_mips64r6_sllv.c
+++ b/tests/tcg/mips64/test_mips64r6_sllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index 79e1a047eb7..94c528f8ab8 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
index 1f8c45d8cc8..993d0b75205 100644
--- a/tests/tcg/mips64/test_mips64r6_srlv.c
+++ b/tests/tcg/mips64/test_mips64r6_srlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 7e36fee517a..3ab67ea0555 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
-- 
2.43.0


