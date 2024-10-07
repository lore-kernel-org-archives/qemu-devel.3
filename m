Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB1CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxq6U-0004c7-3K; Mon, 07 Oct 2024 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxq6Q-0004Uv-OJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:56:54 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxq6P-0003gR-5I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:56:54 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2facf48157dso45679421fa.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728316611; x=1728921411; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAK+zUWidYiYVUXfEeO9EdnlRk7Vf5EVJSy6xvpjbyU=;
 b=uSzWE1VjgAiqLCU2vh+VQYVodHeOl6Xmd6fpGLOrEqusWVhTPBRm2VsJ5wrfYsKHRH
 GmO6KymUYsnfFXZ7wvh1Suf0ZZA0BTxICpgU3yABGI/mqzX8z5DhR6YYCc00rC8qNr4r
 bewTSQ/VZbPw09wCkDagdXwrelNk3kQRkd8cfhkCaxnsazEFbnhg8KL+df/PS4M5izTU
 9Bxj4HD5isR81cKuEp0hZ564nMEB/GY1DAMOvPbCFV/A3kZYi6lstrmqtY9jLl4qTeBD
 tR71qbIjYJsaZFwU1+imVcHPdEYQmT6tTP91e9W+bglpNVl0dFmhdDsAADEf+gjmC0pl
 9vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728316611; x=1728921411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAK+zUWidYiYVUXfEeO9EdnlRk7Vf5EVJSy6xvpjbyU=;
 b=l9PjMuYCPRjAKzo4faGTohkg78rlQK3u7n5mF6GNpUhL6Hd+4a8NKfu9a+OtZCIfV4
 8wIyBkCoDAm7Sz0cSgF3WQkeWgryO0cyMPU3+MGc+HI8ymsQURVTVjR2hUoEOKiPvMJs
 gSkU3qTzBtf3ZvB9bXkq+V77l+TTKxWuD73YGauSmUGCvOVX2u9MJfJ4RpfjRxVtaLv+
 SIJm9tZfKaymIe75dz6au8M+jo7eQjumeQdE3scekeiw/TpeNsKLEamu3Iw+sTKYQmwy
 js5dfUIz+vnIMDgWxKpwRAmeFw0aT8P5Ux55+/gME/um4yBc4YjQFf1TcS0z/oiKuRbJ
 ziRg==
X-Gm-Message-State: AOJu0YzgT33wh/cBmxEq+qebDeFlbDCXgz1N6dZBWLTgPQPSN2LWt6F6
 RPjMXZhPyHNOxWE51fz/5oI4c31CDTLkUUuTwBwI/p/wDdye01saBImTNFttxCRPWo1JZmgYzSF
 BGJ9+3YvcubsVziFM4R4nu5FVquM6gSF3fwJVnw==
X-Google-Smtp-Source: AGHT+IHE7ilL8/nITKXrHLYdD8egNSszsjnLHIP9vEMD4rfpTCPiI8+0BjI1PJvrtqJEM8bO/dP1urharNwmjB0jPJs=
X-Received: by 2002:a2e:b8ca:0:b0:2fa:d31a:1b6e with SMTP id
 38308e7fff4ca-2faf3bfff78mr46175891fa.9.1728316610755; Mon, 07 Oct 2024
 08:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241007154548.1144961-1-berrange@redhat.com>
In-Reply-To: <20241007154548.1144961-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2024 16:56:39 +0100
Message-ID: <CAFEAcA8Zc2aw3GGd0Rzz-o-Yk2=FeyzsygqZ3O7LBuz+f9sScw@mail.gmail.com>
Subject: Re: [PATCH 0/3] scripts: mandate use of SPDX-License-Identifier tags
 in new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 7 Oct 2024 at 16:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> One of the items raised at the QEMU maintainers meeting at KVM Forum
> 2024 was adoption of SPDX-License-Identifier for licensing of newly
> contributed source files, for which there were no dissenting voices.
>
> Thus, to bring the proposal to the wider community, here is a series
> illustrating a way to put the decision into action by extending
> checkpatch.pl to mandate SPDX-License-Identifier in all new files.
>
> Furthermore, anytime it sees SPDX-License-Identifier in any patch,
> whether a new file or pre-existing, it validates the declared license
> name. If it is not one of the commonly used QEMU licenses (the GPL
> variants, MIT, & a few BSD variants), it will report an error. To
> encourage sticking with GPL-2.0-or-later by default, it will issue
> a warning even if it is one of the common licenses, encouraging
> the contributor to double check their choice. This should reduce
> (usually accidental) license proliferation in QEMU code.

For the record, I am in favour of this because it will
(hopefully) catch some of the typically accidental issues
like "user refers to a non-existent license or a license
that's probably not what they meant like LGPLv2" or
"user forgets to say 'or later' for GPL code" or
"user forgets to put in license comment at all" or
"user uses a license that is GPL-compatible but which
we don't use at all at the moment, with no strong reason
why they couldn't use some license we do already use"
(to list some which have come up this year). These are
trivially easy to fix if we can do it before commit when
the author is still around to clarify, and potentially a
real pain to try to fix after the fact, especially if multiple
people have subsequently contributed to the file. We often do
already catch this kind of mistake in code review, but having
the checkpatch check should reduce the human-error factor.

(Conversely, I don't see much benefit to the project in trying
to retrofit SPDX tags to already existing source files, though
I am not in principle opposed to that.)

thanks
-- PMM

