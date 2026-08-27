Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87520C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNn-0005Dg-4N; Thu, 27 Aug 2026 18:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNi-000536-NK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNg-00065A-5B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLsIO653848
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=; b=XYH2shO/3XbmTriq
 pi1i+nLhnbQ/niohoimLiOAhcs4trIAAdEtxh9x+xUFBq7v11wiL82RErRBzkY9M
 NxE8kTl1SWdALiFyY4e7rPTIXmr9yvpEJPsafq9/KCK/br7gZcO+RpKFCWBG8XTD
 2ol9xZ6idYcSijh5xFVCRYgonYirh33AF45wuB9jJD0DgQpSwPaiK6W9u/CQ6fSq
 ncYqJ/wxMBlQ65V6JFpgWe/RDCcAMFfw5xgFom01vZnwT8PYL6hqv0jECy2LkuXy
 0Sy+0IJjjJEswUICdB2hVa+Qq3PDbLN7uSqMUFh8j68aVbvGp376BfLusDM9VO5U
 ToGCVg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuk2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8544b721ce9so289411b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868930; x=1788473730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=YrEe/IyJZKCw2fcEhVKQlb6qWxk2lALYzMhGoE8uDizgpvGZiS3mWILeDPTtPKdDTm
 NxmwgnoWvrOHmu361F1m9yY5zlWFPfbi7LmbIG+VFU34ShC8HLDqK1DSMUevSAsSzdl+
 y1/IKmp1IQVPO+JQ7g4wQC7R+uyDMIwhRNre3a3lRmVNfeUwNKDumLpXerVXpoZ/QrHP
 JUwkYWztpE6itKbLdFUXl1iMWDQqtxlJ/y06kbv1KyVFu+c5gKdZ8WmT8VOnGu3T9UcR
 FyIOYHUkr3t5lQVW/Ywcaj5kvv5esDXMWS3Xf9XENNbFsJ/eLRHft+szprTkuD3y602d
 od9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868930; x=1788473730;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=Ctobu85+wR6fYZO77QDdSRfq7SnSsxuSZ3ZIJ0jLqEbDDuzFXRVhqzND/nzzNhJ9ip
 1e8o7dZ4pOpQQtLVZfNSWZVCE6L+SzD1lA5FC18LhxxchMVoXW9Un/GzbFplXq8oDXP7
 kpu9qAzHIjKDaMePSeM+TTx+S+GCjbP0lZylJSRpZZLo5Qi2jB9759D99gIQIT/gKXzh
 5LQY7gOsM5BWHxPbWOd5dh9rv1Ahbq7z7UgC1OvhriREz/WPzgDl9T8OZLCWKWSMRcvX
 Hr40/3GyTrYer+vHvzF9AL4bsUJhfy24GA6ZD51sZHlpFKmWkDUj6FUOnYNf2DZgNmtq
 S9Qw==
X-Gm-Message-State: AFuF++myUEajFl+SbPUSomu8HR95Dwjo+d3JqpOp6Vx5rOCcySZJQEwF
 9cXwEydZ4yso4Cvy59wZ2XP2rrnJyhrDAnwCYmUL8sB8GLMgaldiyteivJazxpXhOyNMk15uF09
 c3dDixsaSJ74LU91K54ooBAEBf/HoQvjvT8pecihzjeRhSTLSDIDcenclC+ZOHJG5nA==
X-Gm-Gg: AR+sD10fgNezuoytL1xq7xK5+ORTYGji0q/vjQE7eOwJRb9yjq2fs/9GmdVgi9o2jMZ
 OIrPEdlZxuDOsZ+1ngR4/dqsbcsOFRzoTR0UMQ84DOm8GvXjIAYyEZe11uNIWJehGW73m8s4DNj
 /f0E2lZDZ+iSXPZ5v98qhZOJawXdx3YSDyEBRdznT7xfUuh1mbJ2Fg5TTbQoDtogGjGGnLmXqCB
 HV+oE34vlRQdNPaq6cDsgbB1gV+FE49vJUPOl8or4zoZU+lxUXPZEraLbcygvB79CFvZvRSp9Bz
 QAk/62qYRU6zBM6aFz/dIGJxyq9vnHzf6D9x7nn47WJaukl81bFi9Gg8Ta+ICZG2rE4ehjOiZrr
 ++Gv0Q50QQbDTZ3dxe/5/+iV8AgP6+hJQWlyN5mN9pSZ+NMM5FFWx7GapT2Y=
X-Received: by 2002:a05:6a00:1143:b0:852:131f:b9d2 with SMTP id
 d2e1a72fcca58-85626f06db3mr4249755b3a.2.1787868930064; 
 Thu, 27 Aug 2026 15:15:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1143:b0:852:131f:b9d2 with SMTP id
 d2e1a72fcca58-85626f06db3mr4249609b3a.2.1787868929356; 
 Thu, 27 Aug 2026 15:15:29 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 017/105] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Thu, 27 Aug 2026 22:13:38 +0000
Message-ID: <20260827221506.91574-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7CvfRcX2OoHt6-o5h1Ls2iwgVEeES_4S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3c+SMsfefZQp
 jYTuKCJLqFxGXN5K3mQ53Ipze+y/dmZ2AUjc8FQKOGFMbZ15o3ZlFtq9KL/4cXZeD+985jn/8QZ
 iQOvLKQXTazX4uaHNwjOyjOgj+CKgnY1fJQMGC4KuseRo3uJDZpHNi/8yXXTLMzevGbxYuVarJY
 vvDCrTjRj8ry1w3u5oiOOWhd42t7JCdBdVzKOHQ7xwOxFvJbTQqNPq5eg2h+Ytcg9SlUs/Rsb6x
 FrKthuoSmiKGY/Lf5Z3wuZN9xRoq4CEqloS2wwO2wAdpUSpzu4OheaAv/sAWsGQOz2X6mCi2E9l
 g++mMH4RE3MffMC4aExaY989HFLDaL+sVqPXZHg7sEDjdofprIhXIU+6/waNqOKTW/j0EPHXXDx
 b22obJXVzXedzn23UXjcdHX5p+NZEkzS8+ZDje08SISHwX0n9iPlXx8q8u+7yKAfsMbrW3rDemQ
 +DDcNrF4/6sv9If7sNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX88rtsnNOAeJh
 78OAaWHMJutkHeG9Um64RyFSniswoUIl+TD1ewmaMuXH1Hvu2m0fC8EUXpLrCD0ZJt3JmsrUmQP
 Q7RrlnIwfkflJqLmo3Aq98xNi1r6TNI=
X-Proofpoint-GUID: 7CvfRcX2OoHt6-o5h1Ls2iwgVEeES_4S
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b703 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

One of our test requires to make sure output does not contain a specific
string. An example is system multiarch test run-gdbstub-untimely-packet.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                         |  3 +++
 .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f5fd9bee7bc..c718555d257 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,9 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_and_check_forbidden_output = find_program(
+  './scripts/run_and_check_forbidden_output.sh'
+)
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
diff --git a/tests/tcg/scripts/run_and_check_forbidden_output.sh b/tests/tcg/scripts/run_and_check_forbidden_output.sh
new file mode 100755
index 00000000000..4486ca8ef83
--- /dev/null
+++ b/tests/tcg/scripts/run_and_check_forbidden_output.sh
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_check_forbidden_output: 'forbidden string' cmd [args]..." 1>&2
+    exit 1
+fi
+forbidden="$1";shift
+output=$("$@" 2>&1)
+set -x
+if ! echo "$output" | grep -Fi "$forbidden"
+then
+    echo "output does not contain forbidden string: $forbidden"
+    exit 0
+fi
+echo "found forbidden string: $forbidden" 1>&2
+exit 1
-- 
2.43.0


