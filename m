Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CBDEBFD36
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEqS-0002i6-3y; Mon, 13 Apr 2026 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCEqO-0002hh-8N
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:48:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCEqM-0004BR-Eb
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:48:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so4273779f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776077317; x=1776682117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0jSCRpjYuTTwxYlE40T1HmmVtjuccmCQemHdO1//rI=;
 b=LsFMYhZfEUTjNKUfVcjvzbLXn2q5lWDfGTBJQCRJl7EAyUbU/8OBvwuMhFqH0zcikU
 mGsyc55hy465etOttcrZwKJuUaCcZvlx7im//Ee7+QQrTt1vykynAo9zBWGkSp5ufOau
 yaD8ufJ1UUmxRbMARPj4zfvWy7vRE4ihNFvQpkesj4I4uff5Vv4M23rwW2f5zqQIzRCi
 eo3PfR2HIOQ981M6PGAesWY6mITv6M2ugE5kYZTVu0R2EgXJkd7mYww3yWHOg78GBQan
 LeUGd24sNcI1y8QT2pp+vzvJc7bzgbD0hzCgu3u+mO/x4Jg5DUB7xYRlVXO0sd8rPvhq
 w6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776077317; x=1776682117;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0jSCRpjYuTTwxYlE40T1HmmVtjuccmCQemHdO1//rI=;
 b=nP76n/O9u7YkyyHX8weEf0BOdkD+qheaDo2y0JCfmx0ZPor7qvUZCISaXJlQjDzSQT
 a528uHPoKRuR8hYNk3f2Ub+rk/lRZEgqrsqzuKRM0M7Wvx3RzzeGbtBV28UfbDlNWhCK
 heR+rIO9qnD1xkl+FCEGZQhk4I6aZcdGxs5Z9ECKYLd40FqYkSfNL7poOfRE9IwyG/4s
 V88sQMPjfHgPsasLGx0NZhz35n2uhYQT1SSSb/TZkP77EYnF8bDQWAANzoqiI6NUOAw4
 Mz6nfe03pZW1hCipRziPWgXqNMOE4VINW6t9ioNDXq4SY8REMmAQQ24Qj8V4lEGq5TWw
 yJ2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E0PMJoWyzg3Hmv+BMJF0rTCoRRB6mIlIL4VjfLKDRn16+aQcIN4mFpfwntpWlvHc9d/3eVN/gyDTH@nongnu.org
X-Gm-Message-State: AOJu0YxddkcAXoN1Mv7EIkygv3l2dC9KvK5KIkT1JWGvLTufGhrIT1K0
 Nqzxperly2PX4GGTlxGqghKCfi+IVX1Oed3yQ8QfsClt572tm6O5zCqE1WdKHHdxGBY=
X-Gm-Gg: AeBDievst/WfiWJxzb9Hh2AKVt/07FihM+nb1GVtbisTOW/IVDuinitnkleyAS+vWT+
 hpP+hGYuDCSx34/zDoLlqUmS4a0oFfq2KSBdOByDinnwu+fLA4dBBkDtd2e9am1sWDVOrlTRYov
 MR2+Yuz+u8xvZsbsz/Zz/Hor+abpPJY7RVK9hv9WU3WF+6f38NzWuSWGuHZRnWFlLk3/UqjecKX
 PIXPy6i3FRlJcr+KXO2g8jqmAEa5eaVVaB3wHgv97UJ/jmOaM3k3XJ0ycJAdQyK0aXe0JyqClSD
 13AevNX1irNX9Ptd2bVk8tn3LFUtrXF/cSnQNazLC3x51SvqfnUbU/YpfVglaRTeYPzExAS+hvD
 zdk4y6axgn6+BCnZrQesZfF0Bpn6XuZQF1b8O2+NlxG0kifa09MYK/RMTHzpsNgOrYISHBpp0mC
 6m6AokPDQDGCMA0wtAY+G2btw=
X-Received: by 2002:a05:6000:400a:b0:43b:5192:894b with SMTP id
 ffacd0b85a97d-43d642c8538mr18222937f8f.23.1776077316588; 
 Mon, 13 Apr 2026 03:48:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a85sm32687009f8f.24.2026.04.13.03.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 03:48:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 141C05F864;
 Mon, 13 Apr 2026 11:48:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH for-11.0 ?] docs: Deprecate Arm OABI and NWFPE support
In-Reply-To: <20260413103754.45745-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 13 Apr 2026 11:37:54 +0100")
References: <20260413103754.45745-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Mon, 13 Apr 2026 11:48:35 +0100
Message-ID: <87fr4zt9to.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Linux for 32-bit Arm has had two major ABIs: the original OABI and
> the more modern EABI.  OABI support was marked as obsolete in GCC 4.7
> and dropped in GCC 4.8.  In the Linux kernel, compatibility handling
> for OABI (OABI_COMPAT) is not generally enabled by default and is not
> compatible with building a Thumb2 kernel.  Distros dropped OABI
> support fifteen years or more ago.
>
> NWFPE floating-point emulation handles the ancient FPA11 coprocessor,
> which is only needed/supported with OABI.  Our implementation is old,
> untested and not thread-safe.
>
> Mark OABI and NWFPE support as deprecated so we can remove it in a
> future release.  Our main motivation here is to be able to drop the
> 2500+ lines of NWFPE emulation code.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> This just came up today; it's tempting to squeeze the deprecation
> notice into 11.0 so we don't have an extra three months before
> we can delete it, but we could just deprecate in 11.1 instead.

Seems reasonable to me.

>
>  docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index a6d6a71326..10de10dc23 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -452,6 +452,31 @@ It was implemented as a no-op instruction in TCG up =
to QEMU 9.0, but
>  only with ``-cpu max`` (which does not guarantee migration compatibility
>  across versions).
>=20=20
> +linux-user mode CPUs
> +--------------------
> +
> +OABI and NWFPE support for Arm CPUs
> +'''''''''''''''''''''''''''''''''''
> +
> +Linux for 32-bit Arm has had two major ABIs: the original OABI and the
> +more modern EABI. OABI support was marked as obsolete in GCC 4.7 and
> +dropped in GCC 4.8 (released in 2013). In the Linux kernel,
> +compatibility handling for OABI (OABI_COMPAT) is not generally enabled
> +by default and is not compatible with building a Thumb2
> +kernel. Distros dropped OABI support fifteen years or more ago.
> +
> +The original floating-point coprocessor for 32-bit Arm was the
> +FPA11. This was not present in many CPUs but did get baked into the
> +OABI for how to pass floating point arguments, and so the Linux kernel
> +has support for emulating it via the config option FPE_NWFPE; QEMU
> +follows that. FPA11 support was also removed from GCC in GCC 4.8.
> +
> +QEMU's NWFPE code is old and untested and not thread-safe; the OABI
> +ABI is long-obsolete. We are therefore deprecating both OABI support
> +and NWFPE emulation, and they will be removed in a future QEMU
> +release.
> +
> +
>  Backwards compatibility
>  -----------------------

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

