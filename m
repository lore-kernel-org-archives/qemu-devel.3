Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyAR-0003DC-MJ; Tue, 07 Jul 2026 01:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyAN-0003Cp-4p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:16:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyAK-0006Lo-JT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:16:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so27662845e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783401365; x=1784006165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w+IFLXJ6Rh2KW0UegRPvjJlrtOAlujmNmMT9+/Q/N30=;
 b=lWAT7n9O09s5LWYx5XUzSC/xDXDhiT2LPYBqxWHkQ+MDOMZHmznifERgikXF4UlEDa
 QRrFH+VsjJa6eV0/5JPOFRkWnBLCdpIPFl7shidmdFXCySinnd/+HK5ZuXlriOOsnOem
 EhUP3v9jon4xY5Zfsn3YyaGfAkojMsHLaDA+N7RveXHUTmsdcTk+sJdDtDJAtQtOX5gS
 LFPnho2/9QRpd9+lPLevEQlb73iIe11xUjrL14JTst6Dni+EirWv7RCx5RKNMzmtVHVG
 VP04qd0iNxKTe26VpWoikH5ZhnPTFnfamHrevbMdAkL3cbfi9WnH805dfbodX5iAWtUT
 gxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783401365; x=1784006165;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+IFLXJ6Rh2KW0UegRPvjJlrtOAlujmNmMT9+/Q/N30=;
 b=I/RYMe4L8ZU7GSJK7G76S2VrMAfQf7hWxmuxwYY4O9I6UEYczYM8xQLkV3gYescGV4
 dkPRLn3xBB9CowMUStmNlkvkVfcd2c2F0LXQkmeKXHbve3Z0iuqpfcvVWJVk0anp2qGZ
 du/SzEMTidSi9qwDQ6N7opJmsUPtLfLP48F/Nd1zz6xLnu1GjbBNq55hYsbI3LNDzbjN
 N8zaUwIukXzB4oa5MooM5BuoTlYkJqyDPREBXlLR6qgx5EPYaOOdqfpLuJehyaR2S/+p
 AlYYPt7rwMdp0LjxB0R2q8uJ+1N6GeRBypWaVAIK/zxB+NVCB5l/cwAQxmW6xjUvfUbD
 hWWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5fPYbts0vHYKGadYcO3ODjaDTyvSiDPKqbLffZoiIdtOR2PKI1YwaTbTtiI2PeRXXbWu44PbYMP+G@nongnu.org
X-Gm-Message-State: AOJu0Yxk7nX1qkPm3rk1vXh+w7qnlZ6XhpCBmfyyPWRkkMb0I5TMuFlh
 +TEZiU6g0zTgyu8C79iGjVMTQw+wMJCo5388y8Z4HNHHzLYH5PekeCdkSLwzXw1onec=
X-Gm-Gg: AfdE7clvUfce6zTljaMiyB19faC3LSdghfs83wIPaWdu9xdxaA+Y0MI2OW0bPSTzqxH
 D5gAPn4RrjpEvfYqSm5yyEn9j9bJ7bkg4nan6fV2JZU/lBeMTIWPPvNYyNpQLspxfwmerng+B/Q
 A1EjYruXcMQMAgomWndS2CthDjx5wIw80SSvir9WOR7TDseBtjEEnk/DkHE3a+IFlGl+P1geeoR
 Luz+OqAWwBfPH48J18t2coRzCc3PVPyl6szIbh2sNPPqzRsTGJatEkWIvnDeG9BvmDtxfwakOQA
 X4w2dUWSzJNd3tisnE2ltvGJJNTdzyx6FXcuUsy2hKj1sWIEPe2q7AMBpJwnozS9MIFcczBaDtg
 h8/1SGIoURZo7sfijT2HZgncuLnC/VOMZs1fw+8WdOL7FLwgTDdz8Qu0Uhe/uyn/mxG8Hhki6P9
 PD3J618GGbfERKksB97URamvrdRnxfvMHgR6Nso8kSuWCVEuw+jOG0e5f2FtHymUD1zEEVRYxlG
 FewbQR9DhCYwaR4q1Stef0RC4cjhyD1LoCnlTTKUGCkg55QJKEMvhhojz5RV5HV5JO4IJvm9I/S
 m+55VQKUlQErEH93FIAL+W08ZEMpJJIAoUcdIw05EA5EUED9a7RT1fA=
X-Received: by 2002:a05:600c:37ce:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-493df0777bemr36671665e9.37.1783401364882; 
 Mon, 06 Jul 2026 22:16:04 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3676dsm29382215e9.5.2026.07.06.22.16.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 22:16:04 -0700 (PDT)
Date: Tue, 07 Jul 2026 08:15:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 16/91] tests/tcg/meson.build: introduce expected_output
User-Agent: meli/0.8.13
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-17-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-17-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thshar.39p6by0xmpnw4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 07 Jul 2026 01:32, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>A test can declare it expects a specific output on stdout. In this case,
>we compare it to a reference file. We implement this instead of relying
>on a wrapper because we need the flexibility to resolve name of
>reference file per target.
>
>For instance, multiarch float tests expect different ref files for each
>target, which is something we can't express with a test wrapper.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build             | 12 ++++++++++--
> tests/tcg/scripts/run_and_diff.sh | 15 +++++++++++++++
> 2 files changed, 25 insertions(+), 2 deletions(-)
> create mode 100755 tests/tcg/scripts/run_and_diff.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 2106f5d979e..1dd0e492810 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
> endif
> gdb = find_program(gdb_progs, required: false)
> prog_gdb_test = find_program('../guest-debug/run-test.py')
>+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
> 
> tcg_tests = {}
> # tcg_tests is a dictionary with following structure:
>@@ -24,6 +25,7 @@ tcg_tests = {}
> #           'test_name': ['provide an alternative test name'],
> #           'cflags': ['additional cflags to compile test', ...],
> #           'qemu_args': ['qemu command line flags', ...],
>+#           'expected_output': 'file_to_compare_output',
> #           'gdb_test': ['gdb test args'],
> #           'env_var': ['VAR=value', ...],
> #           'wrapper': [program_to_launch_test, 'args'...],
>@@ -87,8 +89,9 @@ foreach target, plan: tcg_tests
>     foreach src, setup: t
>       # return a clear error if user misspell a setup entry
>       foreach key, _ : setup
>-        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
>-                   'qemu_args', 'test_name', 'wrapper']
>+        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
>+                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
>+                   'wrapper']
>         if key not in allowed
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
>                 ' (possible: [' + ', '.join(allowed) + '])')
>@@ -202,6 +205,11 @@ foreach target, plan: tcg_tests
>               ]
>       endif
> 
>+      if 'expected_output' in setup
>+        expected = files(folder / setup['expected_output'])
>+        cmd = [prog_run_and_diff, expected, cmd]
>+      endif
>+
>       if 'wrapper' in setup
>         cmd = [setup['wrapper'], cmd]
>       endif
>diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
>new file mode 100755
>index 00000000000..3e51cdc9663
>--- /dev/null
>+++ b/tests/tcg/scripts/run_and_diff.sh
>@@ -0,0 +1,15 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 2 ]; then
>+    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
>+    exit 1
>+fi
>+expected="$1";shift
>+output=$(mktemp)
>+trap "rm -rf $output" EXIT
>+set -x
>+"$@" |& tee $output
>+diff $output $expected
>-- 
>2.47.3
>

