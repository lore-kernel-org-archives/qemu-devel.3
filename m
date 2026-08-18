Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E698C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPj-00070a-Tp; Tue, 18 Aug 2026 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPh-0006lw-7p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPf-0006dK-C4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGfME1518055
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=; b=fN/PoaFWxjQ3UiQF
 tQ6OoivYqB5oL+EmJ8eRwgbB/k6Upad7tWCFk5SmRxAwfu4dd7/4NyoPByLJFuGi
 QRUmKdRGaCtd09W2n2FQQQyPU77WBXKyvcNQh2L1nFAjQFl1Dus4Rda3AKuN+761
 2oBD4V0Oyt8ahudX9sCY2IIriHWpJaxRNOql1KIr1jZyJGFm3gXe0Df3qie6n1wA
 flFa/UhZJKSai4L6of2VkbV3oB/DubkfD6BHKT99TtYEzmM8DxjS2FRz9967x3Dt
 bTmwyyfEiWxlrI2ZnlpSY1jtCjv+4f/fkKzwi9qnBULiaPbTJloZD1x2EVscsOYg
 3qfaLQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0ne9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso162423a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081023; x=1787685823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=GZHKQGm1QBRKdN5nIFxMl9jrsAKaXOWZsqKauvKPWrtmCBW0iU9hToVnmJ6pD6wihl
 W9vIOsDuX/t8rah2pe3UX/tL9IKxj1g1cDscbBstvfaWFC2lJuPZoNjIlc3TN9eeIWqG
 bjG1T0IZ8oXUQeBiaTEJ6Z+dg0c95tJ2wj+hNXS/uhX4hzdof7KzEbi6T0X/NouabEvF
 BcMPRDOjQLjbxPCx509zyfYDTcb5qglOA0+iAJjc39oVtY62QndbC7ZkJRYGdib/oM4I
 WTrgpALc5D9ramkGKi2hc/z3pl1FyhDC3q5kud1GKC7RjZAQLNGgwpCVM8dpRUJ5I8vU
 +ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081023; x=1787685823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=pShjuk0prXaK3KRqv/Vu54AeOIw2Dn0/Ik8/6r8SIwO+th87d2Eie+edvTdgGeenGt
 b5CNc1WSZbxjU2yA4hwHYBNyIWPwhOYZO1vmOkORihNbKt8qcZQjpnbNlXRWgNxSvofv
 zJVse0nMWlRJf4HLB3+pjBKSaR1q7/NP75hvRpxRd7SC6He6KpmkW9MWvrGlk/mAs3/4
 tSS3sh91u8o7kSSuMhpt7wnID/p6l7jsL7BECjD/vilkVWZcKh4l5cKMSM2nodOX10xD
 mSzWTLyxerccJ4i4HRKFJClakiHCKhHu/F9+OPQ0p78NNL+qMB5KI8BEK6A+C7ed+ecS
 iwkA==
X-Gm-Message-State: AOJu0Yxyo3pqYozWuHUe9kvbqEnljFJFINUP+FsHtgzOKk7JPjzpz7Yn
 IYOsuArxU1zMhFwWkzR+eoCMpl+djgnRIsWLiVsC851L2Yb76mxlb/o/3G/82LHnl+QgV99yZBw
 7eevW15eAEtOPAIw2UWkl7xPuzZtYQrCloGfANyx/rAnEbBSqld/gDp+K5h3lLQduVQ==
X-Gm-Gg: AR+sD12co823UX+c3pqylGB3vQOU/Txf62VXK1aw9lJBrVZ5gdBK8csvC9K4P8HT206
 4r4++agGA0pbp5Ump0y3/R5wnvOyV+1qpisC7vi2x+TGtxCYbBfsptvza60y2rT4Nky0YEFMC8H
 7WbUEZuVQE04OQh5yo+EpOgX2LR9Zsq7dq0w3T6zOHER/7bgDQpvGFqtvnq8Ylhy1+QF2KV/BQZ
 gypkgFg7MAVhrvj5ky9hphgpZqv3naJx9CKUwazr6MYsFSP6bQVBJZE0HHZMc7HapWJKOA911MS
 4Iz7PJRpfM15lJLVBQn9NLuZXYbUhwGSad4RW4oCztEHHflTrjrdpRbRPfQfdCk3RRMJoMXIXzv
 aI0EltYaJLBu8fB18H+kB0DEUxKd7R+praRmWiSjMZvgPFAPI7eFTD2FqkVU=
X-Received: by 2002:a05:6a21:3315:b0:3cc:ec12:a788 with SMTP id
 adf61e73a8af0-3ccfec4d573mr267308637.4.1787081023054; 
 Tue, 18 Aug 2026 12:23:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:3315:b0:3cc:ec12:a788 with SMTP id
 adf61e73a8af0-3ccfec4d573mr267202637.4.1787081022483; 
 Tue, 18 Aug 2026 12:23:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 017/104] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Tue, 18 Aug 2026 19:21:41 +0000
Message-ID: <20260818192309.22169-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4D+yTfQZ64gH
 FXTGkaOFb+D8wj8y1hqoIHKGVGPe3KJ1Ama+beEnemTrH/vMQmhfUIvjEYzmkQoCjDpGEye813x
 KLCa6uzwV15zTEd51qyEq4og77gnz8RRchmEPwunc8HBp0kbd/CTESvFWa9flsP80YmBQdHwvUa
 9yJwxM3JXhY5gy0UR0/2LAAAqUIhfxqeFATpzlkngHQ8+a2iSBvFLylOYCWcaW3G01LFzmBlM64
 EOJyuCwh2ZTE+Yy5nBuppCVbNnuK7bjjuk6q5KxRJfflQEL5Yc6clGK9CN0f/DZvVD4Gipm7J8k
 wxfTNI2pIUyE70HrwBAwoRXu7EGIycUICkD4sddB68KPYhS4+8Isp4E4meJ1Q541IS1BiV4Fp9E
 Asg2ol3Tulm2JthiX1nl31EAgJPkw6f6bg1NaeZs0Dgx6XvHzeOmsq+BML4Nmvgbrj3gl47U5Ln
 0G3hKH0AFu4Yo+oId9A==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b13f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gqqk11vh0XjQLCILjviMmn9PDD9JCpI5
X-Proofpoint-GUID: gqqk11vh0XjQLCILjviMmn9PDD9JCpI5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzPTeI8ZGfVn8
 7LCGC8My6AptIYk73EPvZyVxqXJIcHqaUhLqMdGZVxoXvT3jY5g1luG4jF5CJZFsd6q2xjGxn0/
 xbNbsIw34ODPdORyh0MAa6cOsm4C7g4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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


