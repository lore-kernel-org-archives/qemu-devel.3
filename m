Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0512D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwD6-0005k5-Hd; Tue, 26 Nov 2024 09:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFwD3-0005j3-Ms
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:06:33 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFwCx-0006c3-Ve
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:06:30 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa531a70416so216313566b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629986; x=1733234786; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5gbeRmfZivRP3rurIBnw8VKkDa8ECm6sKnFn+V8rEk=;
 b=TPf54pJjRnkV6mSS5h0VBeDKrkKUe5BuIW0V2OJJ8zh7dIyoEg9IBbXFdTMVQTOU1/
 09BuL8sN8/SfmTtNOYkQ1rMMgqEeVmCMzkvAh+q8m9J6N0IuICpsKwqwSdxmzp8+py+a
 1akmvyD6SNXNY5ViDkVjFmV/CkMAmBSWofVZn/FptrtvkjLWJlatYy6E2MVoDWhZWHpE
 O7td54PRDMfs37me1gy+IZVfHBIPaDVs1xOTdMr/FD0hkjNRXh34VK8HgTte9faVNSS4
 iYgZCijeqtCgLb9TZkNSVZ3h+PIQJcuuXnSfmLRxczbBYZo5x9EgN2VBuzrR8QxLD4U3
 pQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629986; x=1733234786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5gbeRmfZivRP3rurIBnw8VKkDa8ECm6sKnFn+V8rEk=;
 b=Q54m3c0TxUi/wZ7r4mR4AOirp87udxJJ1thjQFqlLKbSaAMHQMLdB8iwXDNiAdCbs4
 RLSWrRYI14SqwVxul5DGsc/A/ijOEA8SNL1CddDwr9+kUh+vhRdUOtyDhiyWyDHQyIP4
 Aeb1x+f8SxLui0asLcG1T5bDPBBxRABBa1W2rwnv+KumuW1MfedtOv/w2Z/f6oFEGCxo
 7TxNaJmBNqiYgq0U/86hBR3JoSq9Nob7Rdkc9lFdY4w08K2uP4Uz5AXbgFLXKwCpiCuF
 a3SqW3kYdTn8zJ/WtiNmSQBTWDhf/nt3gYb1eKIWWCpmQ1Sc4FhXQCEzxUN0VG+zfDNY
 ebmQ==
X-Gm-Message-State: AOJu0YwdTjrl17UjBjZbdIALBhXFVe3xryypNi3JQp1dmDQR0msFa8CJ
 NAdwfpQj/1VG07MUlIf85NJ2XMpwAOeOnu4jJNL7YU/b0VwtDyOGzZ2mMu9ayxxFlzPkVTVYBcq
 4ikx03nlp5kKq/ekjrA4RAjL2I25d3WVR3VqrTj3XE9hmM/gE
X-Gm-Gg: ASbGnct9DYlYRyqxp9cugGrCWXOeSW/Cmq1OvujuDizHSdlW6ll9IzDAkxPksIUST7a
 6YhZKexux1AesdpKU5t/u84kspNK0kl04
X-Google-Smtp-Source: AGHT+IGAvqzF8WhVw0lTlWVFMy4INayPqh4DmJB//xcZ1/cDBtB1X+e9y1TR0ruY6AeTp5GEEEkUnQqlFV9egIZQedA=
X-Received: by 2002:a05:6402:2713:b0:5ce:d435:c26d with SMTP id
 4fb4d7f45d1cf-5d020662f88mr20564428a12.19.1732629984079; Tue, 26 Nov 2024
 06:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 14:06:13 +0000
Message-ID: <CAFEAcA_5sbzo-73LM37rhkGtG+0Oj2HYH4szsL1H3Gfvb71efQ@mail.gmail.com>
Subject: Re: [PULL for 9.2-rc2 00/28] testing, plugin and doc fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Mon, 25 Nov 2024 at 15:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae4922=
2a:
>
>   Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into st=
aging (2024-11-24 13:39:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-9.2-rc2-updates-251124-1
>
> for you to fetch changes up to f8f5923808031e1335fc6d280a4b959ed5d28608:
>
>   tests/functional: Remove sleep workarounds from Aspeed tests (2024-11-2=
5 10:27:47 +0000)
>
> ----------------------------------------------------------------
> testing, docs and plugin updates for rc2
>
>   - cleanup leftover avocado bits from functional test
>   - ensure we keep functional logs for tests
>   - improve test console handling to detect prompts
>   - remove hacking timer.sleep() usage in functional tests
>   - convert Aarch64 tuxrun tests to functional test
>   - update Aarch64 tuxrun images to avoid corrupt blk I/O ops
>   - auto-generate the TCG plugin API symbols to avoid missing them
>   - fix rust pl011 model handling of DeviceID regs
>   - update docs to refer to "commonly known identity"
>   - convert aspeed tests to functional framework and remove hacky sleeps
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

