Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64277C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFw-0007NL-7e; Thu, 27 Aug 2026 18:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFu-0007L0-2k
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFs-0003LJ-CT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuvJ848976
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=; b=JclvghJCIMQUlD0S
 MgGOhOVmbadDKmbtwZFwuHcxfBoWfKhs3s10Fk3Gms9aCO+pZOcAkhpyRYb+nvyc
 w1epr2eWgz6fWoDKVFJg7iebqOkTBxh2Cj9H3TLUuKJQSSNrIF1I8I23fm94EuT8
 YQTCWDFgmQdoYz0C1b0Seq+7Kovbh7ZtBlYyMYpqcvuTRDFVKhftu/qpOQUGmwO0
 NaOQAsbYEw8tFMOHs6a/dhPVBWyhAH50sX80w0eb7jqSvrVqCcsmzshQp8+kJ1mM
 nQaUG0ei1Juj34jR8gCzicSIUQTb6H5Pwi3Z4tMMzcMhUCZrYFzwC1jPDk6wnP8T
 XefLjQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a63t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so635459b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868436; x=1788473236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=ThLgnonYzP+LyM9UyE8GY7vaUvv6RYp1+afaGugLDChOTI5f+ZOKxHKBKawCuBIv/j
 D+d+A2EePOCQMPY2pmIYKHN+y2PcseMDoyyFXvU+E3X0rlCGJxQE7UsLmshu4kD3Tzk3
 jcTSnbFCSaPHdMDJmjfLmGMGzfJ+9GiuvgJMI6vVGJx2Xm3aMbi64jKyoFdEXWxG/M2r
 PPN5Yd+zCegC7GNDoApRqqFQti5aspg87GUIU6vOg5LKymQgCn7Jm0tGyxxi/rSgwTvP
 6K8JohjakifbvaONYYxFYP0weXKQq48ihbXjWCq4AndEmulOhCQJdwJH577vqG5T/b2d
 6D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868436; x=1788473236;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=X0lQRdMSifepwJCmnKGKGifSuKr5FkHo3xtpOyAMfeUzdGUgPA2mWGji4/frXAwVQE
 qy2ucKyNbkjduUk7nVlFbgOl+FtI/HfyTd58WNNqg04iV51lWxw5+Rj8ZMtODLk6xH4M
 A34OKz96peFg9HWPeBdM2KKseZy5Hhy5GnAAYPrVz9cPj7Tvp16q0WD+40WUOr/YzfE6
 YwfTvwzuF+VlToKAR9eDuzSs5XWK90aQ2RL+k58E6VNEttkOB33DS1sU+fsOBRchoY+1
 X18Zq1S+DBlqZ6WpRMPQVtYJPAoTO/8IdS85JmXe8qunv99cTzcZwXSjiA7Jtq60YGu0
 PaYQ==
X-Gm-Message-State: AFuF++mnRShjP4KI1Fui5aIi5ZAgJr6LbaExKCquAh5oMiklLoTDO2bj
 p75ZObT/zQLoApYG9IAUVZ9Jj+pkO7/iKuUuqOWabdNT1YPzvEtmcCtXDGvKR3HcrnfdUrhKs0H
 p+z0tvhwwLXSxX6ggqHfN7uF+3Y8V9vWGhxyKpqOaijjteZ7goUVVLHVfpPnpekMTpg==
X-Gm-Gg: AR+sD11qUj6D9QhyVVWih7tcJnBow44fofLRSTzC6V/pETHVepMM22p+AABdTlfQe+U
 SA7bUmGBHNKITK9w6mWIQsdpnkGqPddXIu99cvhC3iZJy3zkELkiKlTd2KOjvlxGpt3D0PySZOx
 LT4GzxasYDCTxOUX97fGFsHSdQeh8IKIICZ9Q8F93tTYKy8HpkF9kIp+JkKLPStn9XzIUX2MWBF
 BAbe5IxRCXbINvME3qzrve4O3IBESq4TUZywElJwrWzwefteugcwVlr04y2ucOm0BhQoQ6TX3Me
 vsw9epZYHI9P9KatejG6KOceWK6B1uH1hp0hmBrH/QEGOabnwlrWZuECaqlUPvCjDj/QzUbJYyy
 jzKhzgU2rcV7HCXO/gH/oWnTd8GjGVDuDv4vaiwL8/wyXxsqLtbJ0AdVBehc=
X-Received: by 2002:a05:6a00:4c0f:b0:84e:d5e6:a085 with SMTP id
 d2e1a72fcca58-856252523ebmr4890074b3a.0.1787868436439; 
 Thu, 27 Aug 2026 15:07:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c0f:b0:84e:d5e6:a085 with SMTP id
 d2e1a72fcca58-856252523ebmr4890002b3a.0.1787868435939; 
 Thu, 27 Aug 2026 15:07:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:14 -0700 (PDT)
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
Subject: [PATCH v8 020/105] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Thu, 27 Aug 2026 22:05:14 +0000
Message-ID: <20260827220641.84885-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX9EM9ABoxbqmY
 B38QS9Ff8mx0jOMm7UNcH2ATahnZPtZVtOAxu4HE1yY1yyBrcCIHUWs8Fk/aeaVwT6F59KAZldm
 UKU6iVo5BHQSjK+uoVgID0jE94FAsw9Qmli9/6/tIHWWR02jSGgW4sadt9zHF4v2OpsFsMDi5P5
 mZG9/s7Hz6/TFpmqxWGikX86ZgTJK3zL5g6qWouzEFTZZNOrCspzkOssf5/X+BtE7XM+bV9lH1j
 lpUYzqDr3bmh7ITlYvLYhtZrreILbaJWQkdQFiXb0gL9XZsQCnmBv/M2EHvxUoFQplBKjN7ARQo
 slA1I6cDboE4NIJVSVg1Qg4ys4qN5XrwWWRS6riYyBoOEokiQGRcke3Le7yd1LJ87nvcIbfTb6P
 AYbny15Ocg+yLlz26RW9tZHw35q5X6BU3vtJzgZMUdq/hsodIFlWmUvgNzMt/M5Ear71bgMvOri
 VYAonTYNOXE0o+e73sQ==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b515 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YJ5_JRR3wJtdSSnXqCYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AKVcMUADaVuGv34DWcr87h9Sui_cUfmo
X-Proofpoint-ORIG-GUID: AKVcMUADaVuGv34DWcr87h9Sui_cUfmo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0oBlE4LtZW0t
 hBYX9uRj94/hNVXMVYZy6yEaorO84Zsn4ZmV3q+IdcwA7QPOyI7pfGUQDCXBrSQee3ZUO1S7mqB
 iPYMYR6RZeWoroLXESh2ZdON429kg84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 328592b28bc..779f9043abb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..d942082ad86
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+check_cmd_args=""
+while [[ "$1" == "-"* ]]; do
+    check_cmd_args="$check_cmd_args $1"
+    shift
+done
+
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
-- 
2.43.0


