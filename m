Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8EBF4BB8B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzxM-00051h-TW; Tue, 24 Feb 2026 16:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuzxI-00051K-Ga
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:28:32 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuzxG-0003yS-L3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:28:32 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so1804180a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 13:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771968508; x=1772573308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEKcIzCZCZxoqSgvGqdR8lMiwGjdHjq58Plzf/DoDSY=;
 b=iWCWtjqj1c6uvKe72xD037kUs8lrXY1jmeRUidqAyxZtmAQKo9Qo5SKi6b7F76waZu
 kuBblhqplR4NPEQvR0MGlArb1TsUuSJ/gBuRb3MCFbwL5v8sGNwibPY/0Id+HxYmcFV7
 XFt1BfWzocWfrJphJiCCMDksoNoP1eSNQmeT2g9FU+nuLN4c+OVP4YnxMs3EKlGDRgHV
 SlBFkytQ5SW8v8THUsdXt+Oiv9dGdd/WWoVU+pQoSoV26XpIIsmUCvTDM/XpQF01YSNq
 44BU7WwHaiVcTT6yor3KV2EPmbyrXGyRYME3K80wz1vkS0DYlJFdlNAZvCVl1WNTEAdW
 dbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771968508; x=1772573308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEKcIzCZCZxoqSgvGqdR8lMiwGjdHjq58Plzf/DoDSY=;
 b=tsXWKu/4nR8kd6/hoffkavRCPCCzUQ8gN2d6t0MY78FVTztLpg7XzPOqYf7hWqza93
 WBi3jV5EzinDFU6Vrrg3f6zml31qY5ejExBtLc5PWGrwLAu22/gamT20t0+rxNGmloTU
 pYerQsuV6hQ7S//9H+4OD1dIoyF9m5fZL2uXqT1p4PGuUDQqAigrFFXcUfFTQuB5I4hW
 l5fVC+GbFBiviD2fSFO/CDW0q0pXud+62aVZBtK4I/lqOxusA3z7GJr/V1qu+/Mq9P6K
 FlMicH49ThuYbKcSS2xuqx57ZQRvz6xyEddX1sQx4qvazDm/TSQir7Gotrl1wtR5qjNe
 7q+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFOYBdlg8f6M9OshkVkt/LKMrkKZXoz0LEdJ/oveTaaUmt0v4PX5mHWNAezYQUT2Deh03ANyg/t8to@nongnu.org
X-Gm-Message-State: AOJu0YzFFXVqtI/CGfhoVH5p2K087cJajjk1GRr1FBQTzuaKlj3oujxT
 LhoSfxFxFknEC6MvtmPQuv35SBCt89DoQ7txQJbq8sFAVrQs52IjfuMf34zMNHw5wUo=
X-Gm-Gg: ATEYQzzYxvvtksvailLBSxWdjE1C60oXq5W2PxzqOWfeaO9ERCDKq9ndibGhjJfCV9h
 rEQ+UhPsZIjfBhfel8+7YgyWMjWdbwJG5EoernI5q251edXlC72672nwcPNrEujV9ioh0TrHvT8
 CubmAlzCp3jAl3IpdhkfliX+CIvKWphVFnABwRwquEcMGQnjxnztEGQ5CSi7GdusV4asBb6Z7uG
 K0U0dgrcaF2nAJyYs6Ic4ov/QWQotpkIltSq6BXE/w2G/kyvnbj9h3My1OsDRssaDoKo8s6VqM7
 dQoXisrf8vewFO9RU1zV7wntfQYtvAvJ/93kIpCzh/U2o/6poEWPFeGm8PdVkYAr8J/NhUk9Ykg
 Ma8c7JTSK19PyrVpAnylEViwSiBdi6g2waT4f1G8Oqzt4l++vvLesRSthjHp0E1cd8F7TIjC+fn
 15ooD9ScZiZrpmb6+Njq5Dh04haz8HQjbYigPSNMeRhwxj0nkvvYYJWIQay/RlGWSuO5l8
X-Received: by 2002:a17:90b:17c8:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-358ae8cfe96mr10409117a91.25.1771968508337; 
 Tue, 24 Feb 2026 13:28:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35902bdaffdsm718264a91.17.2026.02.24.13.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 13:28:27 -0800 (PST)
Message-ID: <e39a559d-337a-48a5-8e68-27d494ad1ec8@linaro.org>
Date: Tue, 24 Feb 2026 13:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 2/24/26 7:52 AM, Florian Hofhammer wrote:
> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the architecture-specific Makefiles
> require setting specific compiler and linker flags in some cases.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   tests/tcg/arm/Makefile.target                 |  6 +++++
>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>   tests/tcg/mips/Makefile.target                |  6 ++++-
>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>   .../{ => plugin}/check-plugin-output.sh       |  0
>   .../{ => plugin}/test-plugin-mem-access.c     |  0
>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   |  6 +++++
>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>   12 files changed, 131 insertions(+), 3 deletions(-)
>   create mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64el/Makefile.target
>   create mode 100644 tests/tcg/mipsel/Makefile.target
>   rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>   rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>   create mode 100644 tests/tcg/sparc64/Makefile.target
> 
> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute an invalid syscall. The syscall test plugin
> + * should intercept this.
> + */
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +void exit_success(void) __attribute__((section(".redirect"), noinline,
> +                                       noreturn, used));
> +
> +void exit_success(void) {
> +    _exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char *argv[]) {
> +    long ret = syscall(0xc0deUL);
> +    if (ret != 0L) {
> +        perror("");
> +    }
> +    /* We should never get here */
> +    return EXIT_FAILURE;
> +}
After reviewing patch 2, I think it could be nice to test also the path 
redirecting pc not from a syscall, in addition to what this test already 
does.

You can reuse syscall mechanic to communicate with plugin to share 
address that should crash and which destination it should reach instead.

And while at it, you can add the same thing from a signal handler 
(reusing syscall trick), so it should cover most of "special" cases.

You can merge all test cases in a single test.c.
Also, you can create a new set_pc plugin combining all this, because 
other test cases don't really belong to tests/tcg/plugins/syscall.c.

test.c:
int main(int argc, char *argv[]) {
   syscall(..., &&skip, &&dest);
error:
   g_assert_not_reached();
dest:
   return EXIT_SUCCESS;
}

plugin.c:
static void* error;
static void* dest;

void on_syscall(num, a1, a2) {
   if (num == magic) {
     error = a1;
     dest = a2;
   }
   return true;
}

void insn_exec(..., void* pc) {
   if (pc == error) {
     qemu_plugin_set_pc(dest);
   }
}

Regards,
Pierrick

