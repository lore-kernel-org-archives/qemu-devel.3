Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31444606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M+BpdnQS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6qq-0000TU-OG; Tue, 20 Oct 2026 06:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6ql-0000SC-Dw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:13:43 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6qj-0001fX-K8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:13:42 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso5752737b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491220; cv=none;
 d=google.com; s=arc-20260327;
 b=sY8uf5+Y3ru4NMZkRw7+dKCBPfYa3ZHTEVCNCn70/RHActc8+IOwk3ZojPoB9ty8DU
 oj5Gf16eJkKqOD7Zi2azbI5WWhX7n9HMmUtqvXTgWiGuiS1savoX9l0e5RpbceStHavK
 CdBHRw+ydZ91EXQ4K7sl4sg9jZPfFyyR5EDPNIoVHyiucLImb1CfZ0oOdQURqOznw70E
 uLmv6xHddxDQt8N7+1ZggjyUO1LafDE3xocRzcgGMM4DJxgiaqjFTpTDKyQbtJs9p8lE
 1C5Z+DkpK6OSvllP5u3MxztuGF/VG0Jhj3hkfe8Qy9ARxWPI5EsHFwSwm39gAUmJkDaX
 1sAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRsB9LC/9b722cwBC5j1n6/wc/Ay0KTAGtZK1kbgKXY=;
 fh=Yxx9axb1iGDL+orq6XlSLdPZTt3CRBCgannvqbwfjGA=;
 b=hX5JwoHV5c49WmwyyewtKyMHmEhD3Bul1D2ApNCzHWa8E6mJnwrk7FjwolGv8xH0lD
 KM0cjHs1l45BFjB8dbASeGnGfl7bX+mDTHPJuTi+RH5fjdN1PjlfYHNsqj3MzRpZERVc
 AMscPKbPEzE5zQrgRpmFvJVCCjRSBT7xDwD38DYFuMPJkS1d+8T22NVSDWsk/AmhOmF1
 34thRAI2qvY0ukWebJwxQs/JplYwyWrtdG7ZgNneRaSqyBjtfl4QEQDQtb3YChOn5Eqq
 h7txkDUN1LMj6wzA3NntGzrdetS2zu/gy66gHEVpx+Uw/uR34T5rSqoVxc9il6bKOouQ
 g/0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792491220; x=1793096020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PRsB9LC/9b722cwBC5j1n6/wc/Ay0KTAGtZK1kbgKXY=;
 b=M+BpdnQSftRJn1mNztAdAZ85sYEvI8t01wZxoKlXaw5ohXieAM2XUWxN4S9KNMBYfH
 jrQPabAOyydw2nQZU2Vcu9NbRToE00xyXYvV1rJk+sf9O7rtD6Yz9SeFwPAbe/C5pr+h
 vc0TjCadRGtoY2Iv0+LpKc5AFDIcbL8USln7V5J01BvWuAv/6Q4FHqyH+qdg6444ano+
 URMnXBj41xpAjFsMQB42cNYhviGDLL5LdwpFA8itHSsFjHwcKpDD6MDA3ryQBZOSxqnO
 Duu1rLsf5wVrCGpX5zSFBTzMceHOyXmGxWpDd57fxvEn5g8RfdV+M3404nqJKRgeCBTJ
 Ke3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491220; x=1793096020;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PRsB9LC/9b722cwBC5j1n6/wc/Ay0KTAGtZK1kbgKXY=;
 b=oe4IaOCkTJbiEfqF8xuXM7BeTvVfkIX73DskLL8Uj362AN2vh3n5q5YDOi4ohRRcUB
 avnOnvRP2Y5kMTAPT082QdWmDhOePlzKj8YPj0aTG5C95x8CDvVfA/kj4P8596Bubtq2
 RdKsu11BTC5d/xu580QBC9Z8LbXlulMy94ddz+0dU8k/QQVvixftKqlhfiLnUpM9eMq0
 wTu6ZiFfKrjspcoqXoDG/UAPACBZUhKIVAIWw8ePgBG/k+Ae9PlnaWEh1rwhtjE6ZbQ1
 fXXvAB0SEIaraPH0ReHgsykWQs69HDeSDYHBnIGzfVObEar2YPpBpvak+uRCfnfzQzx/
 c6IQ==
X-Gm-Message-State: AFq9FYK45mJyhYSpdhX0Y+d6lCgJ9GyMK4TFgTlYQKE3qwBzPNxCyYIW
 UkD8ZeomuHaxJ8gUp5Z4H/nL9gkaAnCLGWc6/ogVN+YWjj8hy7y5j9jnck0L6NkY3nQO8K6uEph
 VflBv20IS3ky1mhyR4aZEE6r4K2EWOJCwnXki/oW5mg==
X-Gm-Gg: AYBFou2wA9VxJOhfW9Tfq7+dFz8RNozQ2MZtJ0pLwWPVeI5gk1gyLuYcRs6cy0gBnP5
 7XnHuDMSrMS4euoC0/BmROuLZiUJ10tjYiqmWauTjdfKki19Gn2UJZQqj+YiWho5S8xToxSUopf
 JSmgHhCpFtU7WmSfg728rS84jNnbDw1gIuriNwGzH81YVYQ316V1+8F2ESx5d6XrIGOwVEU0YY/
 M055wB/CR7Z1kr4GYRTctPUhv8PaRW6/wCKio59pZQQH13vIasxa31jT+HWdLspVDqFS7oOY/hl
 NzBKi4eDbIrSW59iE/k/8eJzZZm491WsVbknj148eEJOsrDWRe5ptyXV8pniKUki7M3/eeAJHGF
 N6KKfs1oZmCaCFimj5mAoKx2+JJ1WUy6svqobANs=
X-Received: by 2002:a05:690c:97:b0:8b0:bc8e:9d75 with SMTP id
 00721157ae682-8b120054e65mr5681457b3.22.1792491220419; Tue, 20 Oct 2026
 03:13:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020075927.56983-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261020075927.56983-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 11:13:29 +0100
X-Gm-Features: AclHuK8-v59XNJAaqQ3PHglvgqaCbOZMo69jmvEw9CwAMfs4PAF0IIYptsPE_T0
Message-ID: <CAFEAcA_S60THRtAeck_khNhLQkzTMTGap=jr1AnmNoDqg+8rEA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Move RISC-V 'Z' CPU properties section to
 removed features
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 devel@lists.libvirt.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 08:59, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
> for the release v10.1.0. Move the corresponding section from
> deprecated.rst to removed-features.rst, adjusting the wording
> accordingly.
>
> Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU properties")
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  docs/about/deprecated.rst       | 24 ------------------------
>  docs/about/removed-features.rst |  7 +++++++
>  2 files changed, 7 insertions(+), 24 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

