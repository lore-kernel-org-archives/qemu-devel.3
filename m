Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyC2-0003i2-Vc; Tue, 07 Jul 2026 01:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyC1-0003hY-0o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:18:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyBz-0006U9-GM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:18:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so2206804f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783401478; x=1784006278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3SiFrJU6z53vpc7D8n+GDSQpwijUDbwDG0dP2RxpYn4=;
 b=PQfXtyeTPvz4mY0uH1jHM2IqvGLRk5SaQfhHh4p0TGn6vsiT6Lr7sOXWnwQrrgr8WK
 DKNW0K8P+nbGWoYv3ror62h/38GMoQHvd3T3+54F+AR3NwGpcwSHL35nKDrRFoBTr9Gb
 nQbP0qWbWEUlzgebHBkosMAY4MacNwlHD+fkOwhSTWyltEIQ3mu6uswXsKFI7H9rlErO
 dDPqAla8L0nqag+eIgkQkc2mOZ1FstemVhe+0p3KAiNh9rVbhvvWmbmHxFPvPXfPUvPH
 KXNxTb6yOSQ5yWDOychQ0z1b469hYqIWDsKyQ3ocEZSSDF+RdxuMUqHfoEsxSLa19C+G
 qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783401478; x=1784006278;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3SiFrJU6z53vpc7D8n+GDSQpwijUDbwDG0dP2RxpYn4=;
 b=JB4nyvGLsVnAp0PguRO5mYJCkScZa4NKYb2SC457sZsH+sDaFzSBq7Ff2Ky/C9yQ6O
 F0Na30oId5SXbCYkIdOT7o/xQT9gth1cPD9A49mAxZuLtrDXMs1jv6rX2+OGdvMxhhe0
 iaKGUAouVsVYWgoCpS4DgRjBlPpoIhPIo1UyXjCJgnPkmsF+HiI0dUgL6V1Ccght/a7n
 mJBYdFmYDmf94ULvWbd79ki1qdCSLnCB4FfIiLtwtg0/U72XG4qy251d9qpVmWSgTZja
 dpwX93mqgXyeUWNeAP/xGmQYLFdsooQPEspBJvpwI3BAt7ouHkTGzX/B1zBjVUeLGkp1
 kAHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAG0qaJfDiigttloSXVjCYI4rLXHrcrqUdcZ8tcLTU1CFxbPJNSpHlgftfAOOC+TgwCk7/4YyNFz35@nongnu.org
X-Gm-Message-State: AOJu0YyRBwQXIPVoKW0zW2h/TCQYWqATEAYWQgpSg/v++BfuT/mokpmt
 rY5nWZ+jCSKmuRguOz1mrj2YdcYL1PjZ+eVqINgsQ2vT9nRzipywrMdIx+FGZtUWlk8=
X-Gm-Gg: AfdE7cnUVoyBAQyR+6KI/sqMlZEMbYBi8aiKRg1LzqzBL/3Ksl3i8Ri2jynPwTjvJsR
 iAsicbcoEjBhwE7kONymY1qC6AUppIwo+IJqbAkwQPmRFxZ7Etq690+kECDVxusJaMzJ0OdV9ea
 J9MHePwVVx6b5S39wfNBEfJJglW9T/2l6yslym7+4vY+Dv2vRujuYHCHtFuAy4/eHU13NA3LUNH
 jgascga2kttkIbeaXUQCBAqhOhW4+9Gx/MI3uCiSYt6a0zvDSEs+0E1ohsDBSEs/QT/GuVwv7lR
 3lWMIOItC4w5y1UD+O27kIoc84vxaNoqEwbxNqpk5nMYEEjIkbDS/1UNusCPK8RnWCRCmk+1ChU
 DkuQLRii4TM+Wz6ibhjbh+F0MOw/RFS58VswN4JONkoneNaCsl8AXhI+38Z6DZ8clXdnSZBNAV3
 tsjAski/9gQPbZOPQxF4EjVZS9qqsvHmY88tHgQdlNRffXJWM1SwPsWU8kwateD5On6spv/xrsp
 JZUUwQsdUls26SnFHWSIlVfXLSXJYAP6aBMwau0AAeubPgT7segC1cHMgH+P+E1b4fx6gyScyMy
 UBKPiLN4jpqf1DesGoX4e+2i6MamMy8lQjhoYLebcQlLNE4g6Uy4n1Y=
X-Received: by 2002:a5d:6a49:0:b0:475:cff8:b465 with SMTP id
 ffacd0b85a97d-47de66a606cmr2595466f8f.18.1783401477393; 
 Mon, 06 Jul 2026 22:17:57 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm30945084f8f.22.2026.07.06.22.17.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 22:17:57 -0700 (PDT)
Date: Tue, 07 Jul 2026 08:16:09 +0300
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
Subject: Re: [PATCH v3 17/91] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
User-Agent: meli/0.8.13
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-18-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-18-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thshdw.1g79ol5qnukzx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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
>One of our test requires to make sure output does not contain a specific
>string. An example is system multiarch test run-gdbstub-untimely-packet.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build                         |  3 +++
> .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
> 2 files changed, 22 insertions(+)
> create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 1dd0e492810..adb11af7acb 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -8,6 +8,9 @@ endif
> gdb = find_program(gdb_progs, required: false)
> prog_gdb_test = find_program('../guest-debug/run-test.py')
> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>+prog_run_and_check_forbidden_output = find_program(
>+  './scripts/run_and_check_forbidden_output.sh'
>+)
> 
> tcg_tests = {}
> # tcg_tests is a dictionary with following structure:
>diff --git a/tests/tcg/scripts/run_and_check_forbidden_output.sh b/tests/tcg/scripts/run_and_check_forbidden_output.sh
>new file mode 100755
>index 00000000000..4486ca8ef83
>--- /dev/null
>+++ b/tests/tcg/scripts/run_and_check_forbidden_output.sh
>@@ -0,0 +1,19 @@
>+#!/usr/bin/env bash
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+set -euo pipefail
>+
>+if [ $# -lt 2 ]; then
>+    echo "run_and_check_forbidden_output: 'forbidden string' cmd [args]..." 1>&2
>+    exit 1
>+fi
>+forbidden="$1";shift
>+output=$("$@" 2>&1)
>+set -x
>+if ! echo "$output" | grep -Fi "$forbidden"
>+then
>+    echo "output does not contain forbidden string: $forbidden"
>+    exit 0
>+fi
>+echo "found forbidden string: $forbidden" 1>&2
>+exit 1
>-- 
>2.47.3
>

