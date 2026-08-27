Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE8EC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFi-0007Cg-DS; Thu, 27 Aug 2026 18:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFg-0007C3-Ld
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFe-0003Ht-T2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLcjd1358479
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=; b=W3SLFuwIsW2Xhi1N
 2rjpjj7IWisSL7ZQjWd5N2cIG/o4D6HlNnJhr3gHFzpeLC09qFlrNi7LW+8Kd5sK
 703kW3HWIm6nGHCEt9wXiNgNnkR0pVXR2S+B3V0QLvyTnGl9ZGLcMluAB3xFC36c
 l0Uo6NOON8p+1ztEX0cxXkfN7xJpsJ1ktxj5DJ0uNToLs82WZyHL7cI+O/LYeWIv
 m2XTnvUiVJtCEdLd8W/Z2NChnGywAjySG/n4Ajwst/YtIWwuKf7DqyGi3BpMm/K3
 Mx/6njiG32lhkv4GlSZOB3M67poVoQ7nJwQhREiJiLJ46U4hsKyQ5fo/eMjms/8A
 eug5KQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva8sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so398026a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868433; x=1788473233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=D8ydki7cYEy2c0XzmfM2QU8xvhHtUQDgas6+FEQxmoKtsFY/sQHgay940aSOLKecxh
 SRLmqILy/OEh5TetC+6YR2xHkNOeEhMi725jpiRE/0GabUBqqNq2trSwKQu9KboRU8+k
 OxWHn66irVwofMJTW91/w0sMxEghMGcHQ03V5O/T3S5XPNtrf+SpmIoJrsolFhGeHDnp
 tLNG4Bsx78OCIX3UlpvYuF7COoJMx+nyEpfRVxWa1JnX1eyf6GwJzV/rOvUhjZom3gVr
 8bBRYK2e8Gzlk8zkiuAy59Fq5oEkFHgSIvVbq3R1YxOZKqJnvwdQdsHze0ZTpV1BwEbN
 bxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868433; x=1788473233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGYMbxz09EMxNMNvbQqJeTICSIxFCQ5Ngb2M0UUZoSM=;
 b=Em2JA63Vegof4/1aq3xwC7cNouZBc02BDroQUIADBokh5HivSLaidVWgMP6bSNVNLj
 RROv0u/yMjIljFewEbtdooLxkTdrMYkDDsvv7V9st9wbfdgxf8k93Ry7m2vEMlL2QaBP
 6sKUe9eXXBVAXR6eTbk+hln7REtzD8uXLHz2XHvfCcS1UzdvRjYWalkIQO2KwDBA55XH
 8G0fSxsabKtud+RwD48HZg89BUTwFLYSPlJIpyUq+WulTyadUQ6io4T6C/DvgkJdpX1X
 kaPrZG8UHKypgrojIfBWPcZRgRH8mj94qq5TxV8+EvS60PeqdckQAiGptHcjwadjJMbF
 bhdA==
X-Gm-Message-State: AFuF++kzR3YtaCWSYye5G3foyHp1vFYxkbKKvFgd0RtMCRBp4tZl3MPu
 l9LYoPJZiYu8GUT0q0YulED6Dejj7EXxQ1Xu2djGwHqPINCLSiXenNxe7ssGvD/6K16M7GW0rsk
 Vtc6pMRqchRuQSZqgJb864NhcfqXFJpfI2I/8BXv6wNb8skShiGzSJCYava+ubYLutA==
X-Gm-Gg: AR+sD1255QtKxIJ0+yUlFP9CThxe60wsSjfm5vJWQ40VklH2UuOCs4MK1B2SYiXTw3b
 5hm3OPGheLOvQAtzV/AgQecL1wEhpFlPdcCB2eD+8DUnEJKcObn+QdD7VGdXmPPQOpk0JxlfOmY
 x/6xptP7t6MXoQJlX0KFbbDQogNK/lPSOO7FF8O7q27f/lAJLAyHGeqahtZb+o6xbRjwQYzl8Ir
 nTBJGxGiH81AJElWnzjRWOBaSiLlcux4F7GjVWeR5aG+TzilA5iud6GmLTaYZuLMOjArk15DKd6
 EreP3smD7NRB2UZ2Coj1tUw1ODctsPdoSh2pmWzBvKc1qnweG//OUea/c0r5QjHLYW+3G8YRO+B
 3hodChaFFxSKgstfZSOJf1PJAQjNIxWg0W51FocofHPhR175AaB5ZSUpe0cw=
X-Received: by 2002:a05:6a00:1a92:b0:84e:909:ac03 with SMTP id
 d2e1a72fcca58-8562b498513mr3676114b3a.10.1787868432579; 
 Thu, 27 Aug 2026 15:07:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a92:b0:84e:909:ac03 with SMTP id
 d2e1a72fcca58-8562b498513mr3675985b3a.10.1787868432122; 
 Thu, 27 Aug 2026 15:07:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 017/105] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Thu, 27 Aug 2026 22:05:11 +0000
Message-ID: <20260827220641.84885-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6z0Q4vZxdWQlqAYio6xQj9eLfpkWlvau
X-Proofpoint-GUID: 6z0Q4vZxdWQlqAYio6xQj9eLfpkWlvau
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b511 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2KzKb++Znlv5
 6nVwBt7XnqMJIHLk7NztYC8b/ggNCvG3kYRdVGjGZtovZjykXx0vaiREH/Nx0GXuPfGHytmZFoa
 rhRd9Xmlzqqu8ebEct5AbVIzzbeXtm9MGXu2vFXCxZhPHpPMWpIxtuZy659XGe5Qje77oJiXzty
 8IXIlML+HOJ6WX/OPusCi3YmCo4O6Omsu2Pg8MO1vS99OQ7BZxn74oI3nfv5+H2IexadePU8j5x
 /aF/aEPLKTE9n45MNzPThNBTJl295PaMzV1qAMpCUfd/CQofnWWr9mFzirLjRtA18yzKNf2zBvf
 5JMbI/FzpUhPuXYmACtwk6ndkotrGk2Gvbu2BOak87fSTB8BIqJRBYshYRw3kKFuQdA1RFByeP+
 7nYqD3DWCmbx06U38SDYk/roBuXIyxBKqOamd34mWC8bVCRT8mmFXHHbWvci1FZPU6JAz/FGyzY
 JWz1BfPjw86714rXa5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3x8Up6kXpdEF
 CtKEa1iTZ9pmfyQTHjz1NYNzJB1RDn0q+h2XtCcJ3WiHKrdFg9+2jLKKstIbaGl820e4zMiWa7n
 Gg/3kSV0ZVV73MqqeotejpRlhyX1hbQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


