Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E1C88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIn-0003vL-HR; Thu, 10 Sep 2026 14:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIl-0003s5-Fj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIj-00072I-E9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:11 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so27098f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064108; x=1789668908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BKgIyT7aV8pe2TGa9imwfq6KhgrYp2WoRmbiIUOnyok=;
 b=DHLLwQmjlMNVKTYq/aqQYd26sX9KbwSvqnwKZKPqt0GbE/op/lGn00iPVSxBx64ZCd
 xL1Yd8GgIvSsv2+NqQqRgOjIo7FVB6r5yTlHnyLIgJEStRqdOldgy0LYfD/ZEiR8vym7
 99mmrveK0bcw4H1b+kmHioo/8CaJaH3HLhAxY11yaKz2FmKaYi843nlYiL+n5MBuFlf3
 KfllZL6Z7a/gsXl80aZTPuHSeKykh9LTmBK+MaekiC8231+zdSXsZhY2kq5ROhNEU3C3
 6WD/3w6CihioVZfoPezzrdxwusRl/qEzHmSRcXnOtUiJnF+Bj8HqASKHOiInZM/aWfKW
 hPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064108; x=1789668908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BKgIyT7aV8pe2TGa9imwfq6KhgrYp2WoRmbiIUOnyok=;
 b=ZegTV0xnBRvCiXKiOxzuLqdWlA0yeV8repD/9V/qJwEGABOTv4l63DOBJc2JPubw2t
 YnurYwRUDi6DjFIJ061nBNH+O8mp2ZZv46HDGeDHapDjVxy3zXVtEhKFhsZjmMedbMvR
 t49vPIDoVDinIR2K7+DT7YCHF2kZEggp8FFLcyfjAoD0G7uW39PEBGf24/PM30PXdpfj
 3fwkeenxH29im5/KhWu2Ypnx8FjvDVjwaRxI96iwA/7QDIp8KTJe9OZhicxTsC3EYa75
 MQbXmsYQlU6hNAt7BpgR2WG16BMNmN89C39d5SYqRAIoPQ9AD+18F7HL/P4SjWM0K9IO
 PkOg==
X-Gm-Message-State: AFuF++n3z3g4Tf9YjaGSvor0g18Z1LoMw0cRGEr17UA3nrkJ6FrfQ95b
 icBWj9muK/1s7QM3xr1RPy4SYOBtyB/3T8B8WgMZvkSiB+jajlLI1tdlMSC4FW+/Z20=
X-Gm-Gg: AYBFou1CiTqdzokTV5HOyp5F09gbrV9s1od7/RJ/ZLkodOU0x5cvFosB9UFUxErJB78
 hEJtCSLFxnR58/ybPBrzjz1PLgEeVPiW617Kq2y9q6FFZeAMuw2u5ZKMbb5IBb+ptTjEa7gKtPJ
 ZKDHIbhR60MeHWR0oQT3wOsrp78eHibPbqHFhkfCpLbMjwRV7MjBdroBaY3bNB86uuCPUCXD3Y6
 W/41IFBYyDfAyoR4TIMUk4YmMi5riwCVjVgUYag6snP7IqKRMA9iGDfihzhosPgmk6jeLoSeN/R
 906zPirGUuLSmioSIedCpQX8Vl4A/SpBrZGMlV982AdmJZKiG2JaKcl6meKPLIpJYGSma8j8Knx
 QqvC107DEa4kikkqNWaz5xoTIzHklmjmgbVXAvxVhthUETBH4aKRnhDZOTHCnveuY+jiTj7VGyg
 gSCPubQ2BXyfXTUc/4hDAP/Iq702IZ9XE79MP8W++hOqXyq6WOiM+VqMcwy345kHXXDVs1iiYVU
 Eh87NGfVQ==
X-Received: by 2002:a5d:5e82:0:b0:485:8101:dc40 with SMTP id
 ffacd0b85a97d-486eb2d8278mr594551f8f.9.1789064107791; 
 Thu, 10 Sep 2026 11:15:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm184020f8f.16.2026.09.10.11.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3AC035F954;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 2/9] tests/tcg: improve check for working cross compilers
Date: Thu, 10 Sep 2026 19:14:57 +0100
Message-ID: <20260910181504.1010916-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

When it finds a cross compiler, tests/tcg/meson.build tries
building test_cc.c to validate that the compiler works. This
includes "stdint.h" as a witness for working C library, however,
that is not a good choice as it can be provided by the toolchain
alone:

  $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
  /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h

As a result, if you install the s390x GCC cross compiler, but
not any C library, meson decides to use the host compiler instead
of the container:

    cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-gcc (from 'debian-loongarch-cross' container)
    cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for s390x-softmmu            : s390x-linux-gnu-gcc
    cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'debian-amd64-cross' container)

Eventually this results in failure to run 'make check':

[33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
FAILED: [code=1] tests/tcg/s390x-softmmu-hello.test
/usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/multiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/tcg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/include/hw/s390x/ipl -march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/system/../console.c
In file included from ../tests/tcg/s390x/system/../console.c:8:
../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
   11 | #include <string.h>
      |          ^~~~~~~~~~
compilation terminated.

Adding more include files to the test program ensures the
meson probe makes a better decision.

Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is working)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/test_cc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
index d3614a01fe6..fafee055b40 100644
--- a/tests/tcg/test_cc.c
+++ b/tests/tcg/test_cc.c
@@ -1,7 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-/* Include a standard header to make sure cross compiler provides them */
+/* Use some standard headers to ensure the cross compiler provides them */
 #include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
 
 int main(void)
 {
-- 
2.47.3


