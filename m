Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC0E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2P2-0002eZ-5b; Tue, 10 Dec 2024 10:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2Ox-0002eE-Oo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:43:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2Ou-000221-DL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:43:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so7222920a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733845430; x=1734450230; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SevPKJw6fDVpSdhqXRg9dWhntUqTbMilks3QaPYVwg=;
 b=c5jMTvf1ncZxYWsTLspLHrRkzik0CzzXKqShOjKsz6en8Z5SOn1AU2yL6OBXqoy3NL
 WtNIdQJDI8/32/vh3BccSuUoStORA30sSZrYySu11u680RT4EBg+ROEHINQbIDm8/VxO
 j64LriXS7dx+7fSb8GwjqLNtcm76Jj+KfevBElh+ocV4BwL6Qk/Vw3wtclelqLrp9oe/
 OyXNaxzaBXpWy2rT8Gl0XieEYjD8u+Q6PiQ1iaFAGHARHQMht7Qxu98QtBEHoVP6TCVL
 lCLEAUVGnmEZcBgZ4RQgRby95ujT6Z5v1E5SUArdBy+676cA5b7GmeTu8KBOa4q1pr7t
 GR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733845430; x=1734450230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SevPKJw6fDVpSdhqXRg9dWhntUqTbMilks3QaPYVwg=;
 b=PN84oWEK0cCLCG8QwH0R055lsKy2gMSyy9U+7elVWkSBpBLAEZbSJJRR28Cbg7XVUm
 6apfdYx1yth+bijWkhshEzc0/8w7w9R5mgZoGxSfEeI9vSwLcY/rP+s/jlVE2w4sHwhC
 03K2PI+S/yxwAH7rBsAloxv6//AR+58EFYkCrGNQfG0mkZjIS9UFEjQ7CPeImwUsn4BU
 KN2ifCAoHqCncvTRP2WdXcOZbWs28UpNePftTmIfzBfp70nGxqBlWzaT9hiAdr32Y6LH
 olF7F43iwp7LMmitiM7vfgFVUw1OZ+Os+5lUrkLYVarRNoaW2gXODuZgqmI+PNGVJv6N
 BKew==
X-Gm-Message-State: AOJu0YzT18e7bui3xEx+DNT4cTcRSYhPcp/k2KuS8CDCSPtt7iR27nE1
 stHDxbd5UPLtPGXII/AMCxmNbaiVz/VwpF0tKRrUHdN4CwYZVoXI7RDjmPO5wL9YETOkfMQkSwq
 M5olY0Gd8rf+qlCK2VbL+96KGZjl6CF02vPzhESsNXb2Or4oX
X-Gm-Gg: ASbGnctICR8PryvTMh5g1bVcWvwA1CPHVtn13Iey+f3To9T92QHMeN+N29AVS8fd0kG
 fRKiZz9tvrw+tt2PbChWcI7SFsCoiqPYEj8zj
X-Google-Smtp-Source: AGHT+IHpIS97jVXXihfEFQO/YP5WDcrWkwKC46ckaDowqkT5TajL/2oS9M37z3BF0+7HRjBoqRFBDvbmg7BiQWa+1aw=
X-Received: by 2002:a05:6402:1ed6:b0:5d1:3da:e6c with SMTP id
 4fb4d7f45d1cf-5d41853e70cmr5514933a12.10.1733845430450; Tue, 10 Dec 2024
 07:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20241210140112.43313-1-philmd@linaro.org>
 <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
 <CAFEAcA8qNrsViuQrCeCeh=2s-2GF2yXOc9d1qFxAcc+Knw0PDQ@mail.gmail.com>
 <0e9b0ee2-4928-4cb4-b7d5-a78c9a2f3096@linaro.org>
In-Reply-To: <0e9b0ee2-4928-4cb4-b7d5-a78c9a2f3096@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 15:43:39 +0000
Message-ID: <CAFEAcA9KeSVw8rmcRvqBC=bbc_WFGMB4VACROD28RKrjGcAWTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 10 Dec 2024 at 15:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/12/24 16:03, Peter Maydell wrote:
> > On Tue, 10 Dec 2024 at 15:00, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Tue, 10 Dec 2024 at 14:01, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
> >>>
> >>> cpu_physical_memory_rw() API is documented as legacy
> >>> since 2017 (commit b7ecba0f6f6). Replace it by a more
> >>> recent API. Noticed while discussing with Peter:
> >>> https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba9=
47@linaro.org
> >>
> >> I'm not sure we want to do this as a bulk automated
> >> transformation, because in each case there is likely
> >> a better thing we can do with the call than to use
> >> address_space_memory. For example most of the uses in
> >> devices probably want to have the device have an
> >> AddressSpace property that the board wires up.
> >
> > Also, examining each use gives us an opportunity to
> > consider the error handling (cpu_physical_memory_*()
> > drop errors silently) and whether there's an appropriate
> > MemTxAttrs we want to use.
>
> Yes I noticed that and agree, but do we really want to improve
> these devices? They have been using the legacy API for 7 years
> without caring much.
>
> I can repost split in 50 patches, hoping a dozen get merged
> directly. But then I expect discussions requiring too much
> unimportant work to happen, and the series being abandoned,
> giving this legacy API 10 more years...

Also, just to be clear, in the "do a mechanical transform
in a single patch" it is not the "single patch" part that
I'm unhappy about here -- it's the "do a mechanical transform"
bit. Splitting it into 50 patches wouldn't address that.

thanks
-- PMM

