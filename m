Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D734C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHEB-0004CR-M7; Mon, 01 Jul 2024 09:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOHE9-0004Br-PL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:37:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOHE7-00044F-TP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:37:53 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a724cd0e9c2so293672366b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719841069; x=1720445869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UE2UxyR+yRXYNpn7/KSUVBXO9jswGFwuc9NKyNHt5jA=;
 b=YgSZvElFftgH5J872Zlad38pqVhgXMwqUYhgM74Th29XWuC6XUBXiddPKmW0uH9q+c
 dOXpX4q6imYOq57noID+A17kvqhwxgJuznBsjsYpdn8L3AWeX5NnpJHoFs/AnO7mitR2
 DNIFYseplPmQkhnRzEXHKDSkQFS7YOA3Bw6HpuZy1eMGVCf3sqlEyyCHCLlkKc6knjE2
 zTpyruiPOAr1o6LwEFJ0yyjZS6LvBZg7CExqUsgCVoF2+c6KnJlavPzuXsQLQcXMebrr
 sTCq9BCUC0NpwnUqRCliXldegnVWTNJ2XjozaBT3v4bQxd+PBXKd4kAp76oUTbQ8AUYy
 NH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719841069; x=1720445869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UE2UxyR+yRXYNpn7/KSUVBXO9jswGFwuc9NKyNHt5jA=;
 b=mJrk5YUfEjEXgc7ZgGCYxLJgLcy1icbcAwp3t0TiT8sIGldgHtWoMJydgwmDnwFJ6Z
 zctBb+w0jwSETWtTxv4PEQNUBnGXCoRshlr/GhEs5z99y6cygSupe0CE919kBFItMQ0B
 msqDRNvLye8Ebgi4AVwU1EYgjMUNyYVdu3WNLJ/5JQiZr3x7HNzHgdVyvSgfiDMDzz8V
 SP6rLZUulSKtj5a3ES7DektJN/kdhf7C2E18A+CiHVWfhGahQZrUf/dpY6LnyEhxkd9S
 eJ4GrLMGo660T/N/WkxDDCZgIJ4kpsslmrCAY0+aPBP0p26ElGEzC3w0DgpxndqLrLnq
 sKoA==
X-Gm-Message-State: AOJu0YzzZPpPW5x6J8Jgv8b1JjLj7cE/gs3VhWZmfVnUxr+A+1ADGj5o
 N9ZWDSB++tkUlTwFq5vK1FerkLlIgA3kCYRxm5/U4ubIgcD+dRgfglgObVqgW/wZ3SEa8f1sMf9
 A5ij7SExcSeIngwCeelWoKK765NeJ0LSQW8++DQ==
X-Google-Smtp-Source: AGHT+IEGJFt6HlgJsLsKCZxRo3lBQeEJPGkYlfudsSnYcH68XiVceV+v+OgXWMqzCcRVkkgvTXbXB3/VZ21ZyD/euhI=
X-Received: by 2002:a17:906:d204:b0:a72:ae79:8357 with SMTP id
 a640c23a62f3a-a751443bac5mr339387266b.30.1719841068882; Mon, 01 Jul 2024
 06:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240624-b4-move-to-freebsd-v3-0-71496bf119d4@linaro.org>
 <20240624-b4-move-to-freebsd-v3-1-71496bf119d4@linaro.org>
In-Reply-To: <20240624-b4-move-to-freebsd-v3-1-71496bf119d4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 14:37:38 +0100
Message-ID: <CAFEAcA-suKn9LAB8qrNaRu9NeG8DyT_ae0va7uSHuiL3VSk+BQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tests/avocado: sbsa-ref: add FreeBSD tests
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 24 Jun 2024 at 17:20, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
> so we can stay on 14.x for longer. Tests done on OpenBSD will now be
> done using FreeBSD.
>
> OpenBSD 7.3 stays with Cortex-A57 test for local runs only.
>
> Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.
>
> Timeout messages expanded to mention being affected by PAuth emulation.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py | 75 ++++++++++++++++++++++++--=
------
>  1 file changed, 56 insertions(+), 19 deletions(-)
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/mac=
hine_aarch64_sbsaref.py
> index 6bb82f2a03..bb2c098aac 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -1,4 +1,4 @@
> -# Functional test that boots a Linux kernel and checks the console
> +# Functional test that boots a kernel and checks the console
>  #
>  # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
>  # SPDX-FileContributor: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> @@ -8,7 +8,7 @@
>
>  import os
>
> -from avocado import skipUnless
> +from avocado import skipIf, skipUnless
>  from avocado.utils import archive
>
>  from avocado_qemu import QemuSystemTest
> @@ -165,7 +165,8 @@ def test_sbsaref_alpine_linux_max_pauth_impdef(self):
>          """
>          self.boot_alpine_linux("max,pauth-impdef=3Don")
>
> -    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
> +                'Test might timeout due to PAuth emulation')
>      def test_sbsaref_alpine_linux_max(self):
>          """
>          :avocado: tags=3Dcpu:max
> @@ -173,7 +174,6 @@ def test_sbsaref_alpine_linux_max(self):
>          """
>          self.boot_alpine_linux("max")
>
> -
>      # This tests the whole boot chain from EFI to Userspace
>      # We only boot a whole OS for the current top level CPU and GIC
>      # Other test profiles should use more minimal boots
> @@ -200,6 +200,9 @@ def boot_openbsd73(self, cpu):
>                                   "Welcome to the OpenBSD/arm64"
>                                   " 7.3 installation program.")
>
> +
> +    # we keep OpenBSD 7.3 on Cortex-A57 by request
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')

Don't skip stuff if GITLAB_CI, please. If we don't want to
run it on the CI then we shouldn't be running it by default
when a local user runs check-avocado either.

Any skip should have a clear description of the reason why
we're skipping it.

thanks
-- PMM

