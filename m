Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661FCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDLu-0000Zg-Kj; Wed, 10 Jun 2026 03:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDLt-0000ZB-FR
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:27:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDLr-00010f-QY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:27:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so25418795e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076470; x=1781681270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=elJndy2TyNtLhLr7Izvr6doyPdLBoYWJDsuDI/BM7z8=;
 b=AJsgfhWbtBtBafuKQLTAoOhoK0DgXnXrssf9Mj6y+IAhSGpU4lSbEjwiPIPNr0JDof
 a/QRXzXYs6jwYHbYT+8YEImIMZHumTOCkBGVCvf0X6p+AzVnp5oh5uzlejmNIh7rpvzz
 iS3I4GZiXLgSgPEfWbJZcJAFtO5REtdqKmuX472CEaFuL7Cbn5wf2dE6tEsg3rki9+JM
 DoirOljGBCcYV9S5YP0ckHpYcGpbYo/Amx0UW3eFknVoJm2GWxRXjm2x7Ax1i2+ossVu
 768rc2IbB8RLgad9H/9gsa+WkN62uFjTZqOKkWgEVrWTlYrgsmoZ8ylQtDV87P3bcYl6
 GgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076470; x=1781681270;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elJndy2TyNtLhLr7Izvr6doyPdLBoYWJDsuDI/BM7z8=;
 b=LuIw6pfVCCpxokF9MIYhDOooNwRTldcJzZzV4a5RE1RAu3DgeAwaaYYKrQ5e2lV0KZ
 2sMZYqGumXHndlQGpYMQXQOzhQP/vquxgKvHZLRBZ9MetcxzUYq/O8r2rXrqSe26fNxv
 je0Ql3uNOFOChZaWh2dDZAvtEkUfYGi3tXtXTNbtAwuZXJ4aXcR2HnXfYwWyzzEKzVVt
 EeKzM5Tb/uWWEzkfC2EF/aQViRO59ds+fBvPvBlE1cQKV9RR95+6WFTkjk/s+Sp5uL2E
 S+z4ioPl4e4F9pZahR0h6y+rFscuF+9O9GtECwXd3TPUeGLjtbga7+w4MdnntSsBBCUF
 xk7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B/tS5jnI9TCFvIWLQ01bGXwEqBO4HTiymJaecf9hnD3k7gSQ7c0BL7hfUR0m87/flWb6v4ioeir5o@nongnu.org
X-Gm-Message-State: AOJu0Yxyc7/cJHxcaBmet4xI9yqW2Q/lB72DP7LxCushFu3vTN7ThQht
 8uPyfwYeF8CUpt0jKpkcVgv0VeixDj4d4lfh2BSSbb9HEwkjIPE6XParOezsVCGUroA=
X-Gm-Gg: Acq92OGRqaG2pkiB4cKUYd7bPQuTjewO+vIdy59zXJRqvgduCxp+O4DN8uqqt7GO4eO
 re6OVA6FMfpBZjkk68MnEAF60gMDJnl5+9r76UHl7LCpOYscTRzpn/vfydGlkJepjlBDi2z1Ye/
 vraO1SyaIKKdr+GwNEbTwvPeBOBb13Z4rZBcDBjXybViZAYtAVaWZ8DeSfTyozJfdXsuEpRd7lt
 C1dw4a88dN16Mx+695HVIi1zbj3a3U/dp6gApWEqsPRUGUVBDwkv+Z4h5nanDl8+6Wo+NwPfl1W
 MXRwUEiPURJvNlZNqDEzk6YYjJBiRQW4xFC1p44t9qXH9e6qx70pxrAn2m7jyaf8485SqWGlRa5
 wqmRuzaqDtgLYDyYUD86PZwYBLNQ/YE0VT/nWjQjSp46PAaiE3o0iA6AC3Yjb47F6aJ3elXuiTq
 mmE+xRBd7nCIi4iBCKYnpCvwKu2DDHqI1OHZKh7S4956QQSEr6Wy8/DDjIcGHwF+sPIho9t4C0V
 b1zprH5IFapf+4C+KARIS15YLV12JoExLfBXRbsFinVcg1IzpjLzjKonM9L2iascNngdR7L1bA=
X-Received: by 2002:a05:600c:46d2:b0:490:b645:3213 with SMTP id
 5b1f17b1804b1-490c25f17ecmr401283115e9.19.1781076469934; 
 Wed, 10 Jun 2026 00:27:49 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm507812965e9.2.2026.06.10.00.27.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:27:49 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:25:43 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 16/27] tests/tcg/meson.build: introduce expected_output
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-17-pierrick.bouvier@oss.qualcomm.com>
 <b7ab8f6e-7600-40ca-947f-e7e357055272@oss.qualcomm.com>
In-Reply-To: <b7ab8f6e-7600-40ca-947f-e7e357055272@oss.qualcomm.com>
Message-ID: <tgenec.cusd1nl68lj9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

On Wed, 10 Jun 2026 07:30, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>On 6/9/2026 2:47 PM, Pierrick Bouvier wrote:
>> A test can declare it expects a specific output on stdout. In this case,
>> we compare it to a reference file. We implement this instead of relying
>> on a wrapper because we need the flexibility to resolve name of
>> reference file per target.
>> 
>> For instance, multiarch float tests expect different ref files for each
>> target, which is something we can't express with a test wrapper.
>> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/meson.build             |  9 ++++++++-
>>  tests/tcg/scripts/run_and_diff.sh | 12 ++++++++++++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>> 
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 5380a360830..3d2c0d6583b 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>  endif
>>  gdb = find_program(gdb_progs, required: false)
>>  prog_gdb_test = find_program('../guest-debug/run-test.py')
>> +prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>>  
>>  tcg_tests = {}
>>  # tcg_tests is a dictionary with following structure:
>> @@ -24,6 +25,7 @@ tcg_tests = {}
>>  #           'test_name': ['provide an alternative test name'],
>>  #           'cflags': ['cflags to compile test', ...],
>>  #           'qemu_args': ['qemu command line flags', ...],
>> +#           'expected_output': 'file_to_compare_output',
>>  #           'gdb_test': ['gdb test args'],
>>  #           'env_var': ['VAR=value', ...],
>>  #           'wrapper': [program_to_launch_test, 'args'...],
>> @@ -84,7 +86,7 @@ foreach target, plan: tcg_tests
>>      foreach src, setup: t
>>        # return a clear error if user mispell a setup entry
>>        foreach key, _ : setup
>> -        if key not in ['cflags', 'qemu_args', 'gdb_test',
>> +        if key not in ['cflags', 'qemu_args', 'expected_output', 'gdb_test',
>>                         'exe_name', 'test_name', 'env_var', 'plugin_test',
>>                         'wrapper']
>>            error('unknown tcg setup entry \'' + key + '\' for test ' + src)
>> @@ -197,6 +199,11 @@ foreach target, plan: tcg_tests
>>                ]
>>        endif
>>  
>> +      if 'expected_output' in setup
>> +        expected = files(folder / setup['expected_output'])
>> +        cmd = [prog_run_and_diff, expected, cmd]
>> +      endif
>> +
>>        if 'wrapper' in setup
>>          cmd = [setup['wrapper'], cmd]
>>        endif
>> diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
>> new file mode 100755
>> index 00000000000..d1e9243c49d
>> --- /dev/null
>> +++ b/tests/tcg/scripts/run_and_diff.sh
>> @@ -0,0 +1,12 @@
>> +#!/usr/bin/env bash
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +set -euo pipefail
>> +
>> +if [ $# -lt 2 ]; then
>> +    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
>> +    exit 1
>> +fi
>> +expected="$1";shift
>> +set -x
>> +diff <("$@") $expected
>
>Fixed this line, since it hides return code of program.
>Write to a temporary file, then diff.

Also, consider if using #!/bin/sh is possible, since it's universally 
portable.


