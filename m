Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D129C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyGm-0004QI-Qs; Tue, 07 Jul 2026 01:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyGm-0004Q9-33
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:22:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyGk-0007mh-CY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:22:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so23673415e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783401772; x=1784006572; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=alJefnlTedjropB+njGyxN2+sz+c4wxgyBtuFJFIFzI=;
 b=y52K4fz7kRRTeFp0EecIYIeCTp6GSshsPrCTVUJebvPWSHG2nmpoX8jR/Qja0vtWsG
 L3g4hJi5U4SFN1HXHbx05v2pw/YTykq2su2QYKBpQDj6+EXqtB79QLP2nWv2sEf+fwyB
 Q1Tj9DSnRUxLAV40adircc8edkHVbP1XA7CFw2c4m9VycwvtP5g9PKAaqSgJN0xAHLlb
 rrRw5NJqQ2Uk5Rttnxy78bNiSXoU9tvxVYY1dknShnVQ6jeCYVqVNoJkQbhCQ50hE94z
 0EL+pK61F3lPGnLoQFz9KnnvVGb1gLKk1/+CXFBeSslPnOofZ9jF8EZkTbUjMeacCpv6
 AKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783401772; x=1784006572;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=alJefnlTedjropB+njGyxN2+sz+c4wxgyBtuFJFIFzI=;
 b=N52i4iHC9A+I13nLj1h0Ix+SstSzkUp9RDsj4lFC5PRamSfRlPAf3sGJ8yoGZmhuhl
 0RaEqc0Mpkv1ZGxzDAAA/8puDZqesUFXbLZ+3VFg7Dn/xjmFdodue2UZl71R83hXepfn
 owHakkFUio/3nHhcgrB2nJhYBKjNfqQvIzwldYtYMFjMO67KhLLJjLa4J0p9kFuCXmL4
 qfxSUFyljEvmFvzSLvv4V8MCR6h45b4/SkSW12s4rQNv69FMFfoNBGPByNuv2bcF5S55
 UFuSvauaAB+y9Yb0LgfY+VNAt+yrEC5ygwbXhUxtUuAKzTBFBi/krbIUODMPwyOHoLF1
 SLVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKg/lZFoEiLqDG2mMt8yqpxmSYAw8ArQlTC9hPE28Mjm5bleW0N/nChSkogAF95nF+cl/lZWXjGYe5@nongnu.org
X-Gm-Message-State: AOJu0YxkFExoVVoDJoirUA8/WjSBffqScn1FJidS4lgIA1cp5AenpBtJ
 JPSHefoPgDK9qXsLD4oTzT2oFBTlqAI/T2Z5IPhTyjhMOmmdIZGD0GuPemZmN1Agln4=
X-Gm-Gg: AfdE7cmsvq1LRB4ogwoaEPNtCEXNzfH5AxW1DfNFw210h7bHlge8neobVI6W65ge3M8
 LZZNd8aeCxphuOuZP576WxK+SCqMHEwV8SNO77ZYTlwMi9THhVst4z6oetjU+Ch4HCA9lUZJt2z
 eiAQMJa1KMpHIv+RJWSFQ1cKCCk0DQzgx4TyZCOu4T43Px0iy2RuJOIhOTBRonukSMzEidl0mx8
 c7isMgRdij2BTrgUYebEeO8t+4VjMYeWekU6739crWyK8OzeBC6m3rsAt4pKv3SO8VZh8pm4unI
 xgOVNZBtxL/jQXSEy7wyiK2Xu9PAXd43Kb4VnZVhQYzkCKK6YS3dQTxz95ilR/NmV449efUQ5dw
 beO/sj7iacB0x7ODc7ArvGTZj0Ss8zZbLxNKFa4LQ0sNk5c64LxKlAwvyVCLls3XdRUzlOXNMcn
 ZxhuZl7BhjZQHBLH0m+T9FfIHbfiqvENRMyNxZI1Oa5gr1fDGu6c8fLNLSZdJgAuo+FVbNXCfir
 sIqh2+Gcxc8KbXsWzwVoEsWZ5R2VjjOFXRbPkOnUEFqoiJ/gAkWRAIBC1l7AgRPycpWZlVf5LsN
 qsKr4jdUmERPAfn1ealDNPwgVFfZUJhyG3NxWaT6Eg1uH8r7vV34oeE=
X-Received: by 2002:a05:600c:620e:b0:492:1e7f:d41e with SMTP id
 5b1f17b1804b1-493df06f828mr29892725e9.10.1783401771916; 
 Mon, 06 Jul 2026 22:22:51 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0ab4dd0sm28012255e9.2.2026.07.06.22.22.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 22:22:51 -0700 (PDT)
Date: Tue, 07 Jul 2026 08:21:42 +0300
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
Subject: Re: [PATCH v3 18/91] tests/tcg/meson.build: add wrapper run_with_input
User-Agent: meli/0.8.13
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-19-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-19-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thshm2.kpi8kgpg4enc@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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
>Semihosting console tests require console interaction, and were flagged
>as manual because of this. This wrapper automates interaction, by
>sending a specific string on stdin.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Btw, for more complex usecases there's always expect: 
https://en.wikipedia.org/wiki/Expect

In case some future test requires more complex interaction.


> tests/tcg/meson.build               |  1 +
> tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
> create mode 100755 tests/tcg/scripts/run_with_input.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index adb11af7acb..30178df0f7a 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -8,6 +8,7 @@ endif
> gdb = find_program(gdb_progs, required: false)
> prog_gdb_test = find_program('../guest-debug/run-test.py')
> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>+prog_run_with_input = find_program('./scripts/run_with_input.sh')
> prog_run_and_check_forbidden_output = find_program(
>   './scripts/run_and_check_forbidden_output.sh'
> )
>diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
>new file mode 100755
>index 00000000000..3d280547c3a
>--- /dev/null
>+++ b/tests/tcg/scripts/run_with_input.sh
>@@ -0,0 +1,12 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 2 ]; then
>+    echo "run_with_input: input_string cmd [args]..." 1>&2
>+    exit 1
>+fi
>+input="$1";shift
>+set -x
>+echo "$input" | "$@"
>-- 
>2.47.3
>

