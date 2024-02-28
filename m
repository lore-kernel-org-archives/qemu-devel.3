Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C751AC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNi6-00039j-R7; Wed, 28 Feb 2024 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfNi5-00039E-Ez
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:27:13 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfNi3-00012F-NO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:27:13 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so14123a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709141229; x=1709746029; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEA7fDq3W20uaqnBu7x7mszqB8YQe35fmemnTM8fyqo=;
 b=iAhJ7z9nhusmapRlqaJTGgqUTvCV8lkdZEA/hf3WAPaqjn/oBxRxLz5n8g2MgPp+LF
 9dspZsCbb1WqWhxOl0o3GFoDolDNkBtCD9Poj78eQ+Cuzqr1oFRY+E83wGp4X+ecCdiU
 I2PieVHlDL3obnLXt1vFppHjqjvHst+6RFp6m/BZTbEPT/cf0ImSWMdtH/fKLUWK9mUq
 MSW5kbz/FVJhG3fMpwEvh9t5/k6hHOSXSEqGd7r1yR+YNvzympjwObugIJF0Ko5WQ37Q
 XdCG05q2HcAJP/+EMg+a9LdrCq3ZGw+nd3YjOKbL/k6SaLa5glY1wKuencqJdA5w0qT4
 dBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709141229; x=1709746029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEA7fDq3W20uaqnBu7x7mszqB8YQe35fmemnTM8fyqo=;
 b=ESWbS6BYpK0YSRG+TGzHrspBDQW4jGyGSBh6Re4EEIiBnlaVeDEqgjYQYNEweguoC8
 S1znfQgA1RL64vO6ssDOpWQEirUZWtpB17rKVDLp13PYI/mc+zl7XnQyOWlafFGk8hou
 tGv6fmjTalGY/7m2h7qVtifNhiCyz9fiys6VkUR4lbwbyuyBpHaFrpLAR0/6eTjXHgLE
 gXZm99bbqNYc2qR9wrIDK36sTR0icGQJg7uMKVoeV1Im03g4eoAvL0t9aeVCT/cAhp48
 bz66F2EHJ9wndEJz4Gx7Oxhv1Y78kcHyx6bOjp8UILslZNjNP9Bh6umjlNYRpNbnhpUp
 LuCA==
X-Gm-Message-State: AOJu0YypaGymGunt7Tii6i1pmw4yH63XruAOaGAsOtyoRILaamGxq1Hs
 MYG40nkuVy5kocQRCZy049qnObw8HHmsUBZhFEfLDU6D4td9UZA1keNs4Ejp2FrUnersGfR34Yi
 V2d6Y/9BB/hxpGSlA9BvmjYuUVoBGkaOySoBVKyQQYvjIc7dr
X-Google-Smtp-Source: AGHT+IG7QkLl9ASAJNNfYET7ec0lAw6YHo5UXIuWU/1yElhf6vXTGdeo0OHk6CKPRd0fUUSBwKi9+GuHkkjRc1dWq3k=
X-Received: by 2002:aa7:d14b:0:b0:565:7b61:4c86 with SMTP id
 r11-20020aa7d14b000000b005657b614c86mr62825edo.6.1709141228981; Wed, 28 Feb
 2024 09:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2024 17:26:58 +0000
Message-ID: <CAFEAcA9y3z_=ARgc0VFn1hf-CsvR4oUwmprsyr-NtTiAu+-shg@mail.gmail.com>
Subject: Re: [PULL 00/29] testing, gdbstub and plugin updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 11:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 158a054c4d1a40179f5e83cd7e1cfe65de457b=
92:
>
>   Merge tag 'pull-target-arm-20240227-1' of https://git.linaro.org/people=
/pmaydell/qemu-arm into staging (2024-02-27 15:34:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-280224=
-1
>
> for you to fetch changes up to 02ca5ec15089c8717d435d8a842360f15afa7d20:
>
>   docs/devel: plugins can trigger a tb flush (2024-02-28 09:11:42 +0000)
>
> ----------------------------------------------------------------
> Testing, gdbstub and plugin updates:
>
>   - fix some test/tcg license headers to GPLv2+
>   - bump up check-tcg timeout to 120s
>   - avoid re-building VM images too often
>   - update OpenBSD to 7.4
>   - use GDBFeature to build gdbstub XML
>   - unify plugin vcpu count under qemu_plugin_num_vcpus
>   - avoid spurious idle/resume callbacks on new vCPUs
>   - ensure nios2-linux-user processes async work
>   - call vcpu_init plugin callback through async work
>   - define plugin helpers when registers being read
>   - add plugin API for reading register values
>   - add support for register tracking to execlog
>   - update plugin docs with assumptions
>   - mention plugins can trigger tb_flush in mttcg design doc
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

