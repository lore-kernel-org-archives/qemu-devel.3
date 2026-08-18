Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F127C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPf-0006hB-6I; Tue, 18 Aug 2026 15:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPb-0006fZ-Ho
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPZ-0006e7-Qy
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1b51872791
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=; b=ktmAWvFBmzrSPsmR
 jAK+23fpEQOHveyQOTvnmiIRXbT7WwThHAHAgk+P1m+aG981ZFqXz9fNYrk0x258
 IXCCCJr/5n6RHeKI6UMyJPUZWXoSNhW0QBq5XqFqiRISp4C7VjvlJO5su6zYieI1
 fr/YC1SiyN3H2mq5mZfeXEVbAi9U+kK4WiF8dZb9GX8TceSJEzf72oclSx4JSWaP
 JoqNZaq0ccHG4LJG09iephpDA9mO2rh90GymMlRkaO0+1HylZDnmJI9+bo2z3QNO
 uHctHEujv7caAGYlwbO+0F3djeacDGJM/7MKlbHR126JJzC4cBktGaG0BiWZIH5m
 Lx0ASA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ag7c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so1341385ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081027; x=1787685827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=T/BP7zzZqQRw/o1hkls9ZBe2b3nF9yEP22u0yZqv80yUFh8ueGNcoLGLjooO79BaJy
 gGnmpfwZJ+hxnwgHgM/KBAzrHfDpMbSQsPVqcLLyN39k5U34jTftwApbN8dKxaOoSnQO
 fjQTkf7ADgOV581l69XtGcF9EWlEr78H+RWalz8xAULsqMrj7/K9wRc2igBFm61Zxj/x
 JeGBswGgmH9eP51uQDAldCuLsvYvRvcp9fZLKP5Wj3dF9aQawXN2pM6swE9qj8+pdFKQ
 /m8Q2fuoQ4S8DfrGqlmHS4UgaQKPY4NB7Z0SJvMF7XeHhAVZvyEX6g/d8fPjpBfA5aGl
 6cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081027; x=1787685827;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=a53G0shrZfrjAsLVkTHgYuVoNqK2crwaX/NLo7UBAWA3ohza7l8f45fkQOYrg87pE1
 evMv0A8qofadXwGQhVjOSzlyspUzScsiq/10Y8L8K/CDPcIJG6r+Cysov0j1w1Rb/dcI
 oQIO7jw+aLVhR+P0W8PyaUhLsVyBpNLIF9wGOdVQU6nJpr+XLX3UPGwQiAi7oT0cEuBD
 XZ8D37Dya07UxGf7R2Ir9AoKf6HA01ILy0Mt5VV0PNSaoYupzklrhDId9ST1H0JsP6Tt
 q19JoA67nPB4iV/f9STy1lSVgzzRiB1ot2teUlNckl6RCQcVZgbdvqU0ijZstRrWrx8a
 1fdg==
X-Gm-Message-State: AOJu0Yx16HO9Ay0J94txs7uRUrxzwnG3hO1EZvd3KIwqtex9POPhcJ0x
 UeU2HjEZNEaz4TMC6kcjiJ4f/VTtKIysRlYb7kowGLRYt6zaHD+E12eyiL4BEj5BT8i1vJF0CaT
 aq4f28BxQKItnZG5eqvEU8+z0aXRxkocULuzu0dQ3paIxADzv1WfCc32J5ZTlqA6IMw==
X-Gm-Gg: AR+sD125Xmr5it/caQAWJlxh9KWT0t+GjzBv/dc4iN5XddObrqD1XmBQoK3VjTGHP8P
 qigIYLQIc2Re40q/3154dALdnNLKoxY2mKvoTyPP620mq3RVbbqM2kI6YBzIhrZ/YOExuI/38XQ
 Jzysa18s9bNgH4+uSzc4ltx0cOOo0mEw8fLYR2SKP1G31InmEdiW8OW1ZsaRr/bUb0+BGu/OuEx
 VAugwOuYbfiUD1fCVXp4I05HsYiF0f21qGYEO/mKU+4kyAFQdzqOUJNZ2AfbnW0iipZIkhOJ5Zo
 Sz9uimou1RizimtT4e3fZoj+wNt1+r/7KogjOk+dtZF012+kjzu5RnTluGQl7u3tLFhtdA40nvd
 hqBniYEPJ8chhMGmRh6uiQtaZdAOeg0w8jxwMrNHR3yfc+O3T1b6TB/XvNwY=
X-Received: by 2002:a17:902:fd88:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d5cac260eamr98889195ad.5.1787081027188; 
 Tue, 18 Aug 2026 12:23:47 -0700 (PDT)
X-Received: by 2002:a17:902:fd88:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d5cac260eamr98888685ad.5.1787081026754; 
 Tue, 18 Aug 2026 12:23:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:46 -0700 (PDT)
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
Subject: [PATCH v7 020/104] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Tue, 18 Aug 2026 19:21:44 +0000
Message-ID: <20260818192309.22169-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6pVSU5WvYeE8
 3O1ezm04pS9lKK7FCeBRkUYrSGIRVxjVA7VncxIWtyoCBtkym1GgIlACsRPuNJiqe+Q4WvOtWsG
 nXYB/e6oTGlNZguwzT5hqB2PuHQEDWltv62IJU/nv3PjMx03kC/oqAuZu5inf3xIxxfFJeEiCg3
 6e5ZH/4y63BsydO6ttMU+jSVBhcmpmEsz5UCo8weH8CNinRTaRunrHdGyI934WKovi93lz8cc32
 svGlpjb5Kd4IldFynszRlwwmU8vZCyO6lOY+Aa6q3hbZTSM6T5mHEr8nCJ6hYwiYSTA29onyII/
 vICf7hTbmYLgMqLGIRrfUF+lxA4wEK4EqpZTzkK+K+/R0XJ/dT5vYGbgSPyt34AWILcd6JYACYG
 6SqkiDOs7IUd+mDI0IYSHIJcpwdTdUL33wHu05Lat0Le55RhcOTZUS2obfHfBsuAgu0dk8ATatq
 JipgaEpaeghSQ+3+XYw==
X-Proofpoint-GUID: eTldepos1Bjk-ijziVHEgGgwCO2jGeC-
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b144 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YJ5_JRR3wJtdSSnXqCYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eTldepos1Bjk-ijziVHEgGgwCO2jGeC-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyDuTg51V6IfH
 71VoeMDxYuuDLVHTzOOb+kK7HtkXpeQoqDTaeka93fc+AGZPMqN37Cl6ATz4UMAk7trYL5tNrlU
 xwxnXKOCav6nsQoCm96H0afeVvwqK4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


