Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B2FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5Wb-0003Sv-Rw; Fri, 10 Jul 2026 03:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5WS-0003SR-F9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:19:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi5WQ-0004ra-Ek
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:19:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso1120365e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783667980; x=1784272780; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xrxZAoI3szvm+/t+oVkq3F/HnhCuOvnrBDCm/IpzljQ=;
 b=fjb8vQH4OsAigtjpREsiFFdmOjKuqNAFejBOgiDiWg+fqnOj3MZQqMm3K/6x8WA5Q4
 3W/IcHHN6Eg1+nLhVUf+oa/DBIQu9mdqTVwWZlAnm7z5MoT6AF+dLvwxZ3H6szFlwmXc
 cd37NW2lGpsQZPH2a10ebNHo2I+F42KbVuN1NTxXAsEPSnlVedtuUsjk2b6Nkr6AbFC5
 ZiStvHB78VJ+DPn8mc3pnDL04OD6Y9u9zwtkmFW5Da0D+4smrCscrjpJEhY0QgpdiaDJ
 7eFiTglm9eFvyQHCvnuHqDNRi38ZRmQQKFTt/+CqV4jy/Yfnvfp8CK1m0oBSW5k7uFq8
 rCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783667980; x=1784272780;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xrxZAoI3szvm+/t+oVkq3F/HnhCuOvnrBDCm/IpzljQ=;
 b=hz3AwMG9jUnj1UhnuWwZJTNFnBpb4V4KYUfAUdmiugswmYs9zo0xO/ny+zHyhsukvb
 pl/h8PWsym2NZylFkdlmnSWdMhsq2Hx6/tE6x/EDyBmuFvLHE32BzkyHlSlnegp8rKPS
 pkhWbvVeYqUXLV/bQVyrWBAGh4Oba2IjQb8yrNgeXLVIa/Uh6of7ziEYaJA/cQsj7SWK
 4s0Q6CFi5q8IV0Nfa+lhoAy5/9Aoxa9PxalRAPB9rIduhvEMEtB9X+O1dVzlJA5Frl3a
 64uqP4/iGovS1RhBVVHwYzMdzvILb17HyZrqwA1Mys/VJ8SVaZKEC3cvMkRygEfAsi2c
 5TEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RonZEp1MCyD/QERKS5A178cCRh2XrN5pxz7N9H3TRcvBkqkpM5n8wzS/AcvQRtcBas3oEFLDBqwXoqG@nongnu.org
X-Gm-Message-State: AOJu0YznanyOE4zphhYyHT2jHWWYj7cdplRp785nKq0rP+nuQSJztHmo
 h2GDB3PsiSFUE08cHFKJnISJYiRX0WGzjW2GbLu3M93JtFBiuq8ivyeOarXHlunPHpo=
X-Gm-Gg: AfdE7ckiXu96nm/i5y/GOxptZO5ppafQK9gHd+1InQWyT3IRzBVPzxR2kvEInTUFbus
 iBZdhx5PUKYGc05h/t0hJdF5Df/dtdqH9w0ZiHWIAuurjXD77txcz3qEzgqq1bkV7eND3LgHsXT
 6jYzpPorFidhcO9aspzV3VAImSXc3M0Bqejl8/wS3KnX00ZjLCZ5xGfGjvOjBUDbW4CRqVQkPgU
 DeNZO/bj8ACEk0CIrEy6K5BLaeB3cI1pxjnkskDfnCBtM0m4eo8Gr9lsyZj6YGNBKUJZvvDZwsc
 wVKpaw1oRyzoH9eJVhkdbLV1LrdIAKjbSDOGjMkkBkNRjMZuODiZlbncxU5HnwPVAn1A6wvYImf
 AUzl0cycoeSgDYo8Cf7YlqG3hMHJ09onFYQYytXNaW6ctOPdFE2tdzDpzHIqYwANh5rJCB+DTfz
 NrDTqB75t1DoVsfXgmkbaV3VE4TH7D9F1lVtb6tCyof0dkjuL0+XY49pj2+kgjNHr2VBfTxwR5r
 WkSDJBlOlPaR5hHc08fqduT/+R4v/k3+cwyOl/Esgm82PCYDHxqyXCXyz9+yptq6W85H5N2ql8W
 zET7B4wEPwx08J9Wv3P8hPW5XPgR6g64EelonL40K8Fmn82NDtRBugo=
X-Received: by 2002:a05:600d:6401:10b0:493:d117:18a8 with SMTP id
 5b1f17b1804b1-493f2b3376emr14873355e9.9.1783667980290; 
 Fri, 10 Jul 2026 00:19:40 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm127915855e9.14.2026.07.10.00.19.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:19:39 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:19:16 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 20/97] tests/tcg/meson.build: add wrapper
 check_plugin_output
User-Agent: meli/0.8.13
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-21-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260710062016.1818125-21-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thy70r.2vd7ynzt9rb8s@linaro.org>
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

On Fri, 10 Jul 2026 09:18, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>This wrapper runs a qemu command, record command output and plugin
>output, and forward both to a check script.
>We use this pattern in several plugin tests (for instance, with
>validate-memory-counts.py).
>
>Tested-by: Alex Bennée <alex.bennee@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build                    |  1 +
> tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
> 2 files changed, 26 insertions(+)
> create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 92f8fe97649..6dfff7ab5e4 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
>   gdb_progs = [config_host['GDB'], gdb_progs]
> endif
> gdb = find_program(gdb_progs, required: false)
>+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
> prog_gdb_test = find_program('../guest-debug/run-test.py')
> prog_record_replay = find_program('./scripts/record_replay.sh')
> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
>new file mode 100755
>index 00000000000..d942082ad86
>--- /dev/null
>+++ b/tests/tcg/scripts/check_plugin_output.sh
>@@ -0,0 +1,25 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 3 ]; then
>+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
>+    exit 1
>+fi
>+check_cmd="$1"; shift
>+check_cmd_args=""
>+while [[ "$1" == "-"* ]]; do
>+    check_cmd_args="$check_cmd_args $1"
>+    shift
>+done
>+
>+qemu="$1"; shift
>+tmp=$(mktemp -d)
>+trap "rm -rf $tmp" EXIT
>+
>+set -x
>+
>+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
>+cat $tmp/plugin
>+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
>-- 
>2.47.3
>

