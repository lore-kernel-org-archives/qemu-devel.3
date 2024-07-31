Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1DAC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBCI-00031j-PT; Wed, 31 Jul 2024 11:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBCH-00030S-1n
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:25:01 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBCF-0007S5-Ag
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:25:00 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so93642351fa.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722439497; x=1723044297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbTHT0qvnu6vf2OvMygGdl0Go89VN41YiVMhaaem9/s=;
 b=f8u80oERotjaKF2v8oFIz0AYTwziBKVwL7rrxW9sCV/ZI3oOLEcjYrIyTfUOBwt8Lh
 FiezzboiboSsM42bAJX/IipNLgRx5KHAR4YHhyqxy72PHkT94ZuowNiKPtveUkAZYhL6
 nXF7nWM/p2r4GbStC5mi6h6N2DQGbbJoAw0ksa3/RrXKq5uJj1AlSImo1z0MyL8/LhL6
 3ZAu6Uod362P3EFvCp0VlxRgYJfvSJxOOmbCk1QNuWS0hyBhiSIvlV0Pt+grQXwsptCu
 0Oxe9jpKd2IF7FQ4bt1+85i0HUGESdfoKe/QuQf76efKAn9TqqewWVc5stmVeJO3Nvw1
 bBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722439497; x=1723044297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbTHT0qvnu6vf2OvMygGdl0Go89VN41YiVMhaaem9/s=;
 b=ri9J0X+jvVGCQcfufdfCpsGFwxPxtGa+/eQhBqsc8xW+J//u19G0YD1ZN8Kzkc77xZ
 zufTzXYE9SPFTaBFSeNgk/K+tuWebYDqkD158iHRqxbxYk8a1FDF0GD1SIAqYJgT6aLX
 DIVgp/Kx+EP1Dx8TtA2jyWH0hOfB/4XFdZ3ijDXVfWv7s7ffukrZFqtk1aYqb7jUSbZV
 wFtePhBJf0Ew1gx5gGuak8EIB2UKJFohOXBmxu3BTrx8gg6i7y+OfIey58RklsIer1jT
 k07iQ2WHBgaxFMAE2gi8i3yImK1rcLlIpA6X/t28YzeYbWpxzBQMi7ZggRCGk7BuFexc
 sOOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDECPsG6a7LZKrXzoQvb4cSynqFPKX7IMzBzau6P0QEOdYNlc5UMfC60OXm7hfscLv3jF3K/AaCXEFoF59UD4JESqoaWw=
X-Gm-Message-State: AOJu0Yw19h2r8D3JaADO7g6Zm9Yi53zVQh18MDhZJT6faeIEkn41Rtqd
 GJ3OPjDoJ0xlTYyNhUtAAzxZO8d3b2Pnw9pwwS6a/x+zLmqiVZfrH24DR5MKK2bNyrpvzolU1MY
 Sy0/RswUzWDejeAodG8XJi2m0f+iCihs8L4VLmQ==
X-Google-Smtp-Source: AGHT+IGLQjZ/edtnpso1u+UPjqiwtyRuWklk5flxEgsGFZMezmdLwbPBwGwK5xHpor0yBhQ6JPnwSN9TBGR/6l4ti9U=
X-Received: by 2002:a2e:b059:0:b0:2ef:2685:177d with SMTP id
 38308e7fff4ca-2f12ecd5249mr94782981fa.20.1722439496652; Wed, 31 Jul 2024
 08:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
 <ZqpF6VoZgFsfhhl7@redhat.com>
 <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
 <ZqpWYfst2jsG3TB1@redhat.com>
In-Reply-To: <ZqpWYfst2jsG3TB1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 16:24:45 +0100
Message-ID: <CAFEAcA83zF4Gr3KUDAZMYmwZ7onw0zs=N0HeNkc3mSMF6n_sKQ@mail.gmail.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Wed, 31 Jul 2024 at 16:21, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jul 31, 2024 at 03:32:52PM +0100, Peter Maydell wrote:
> > This is why we have the RETRY_ON_EINTR() macro, right?
> >
> > Currently we have some places that call qemu_open_old() inside
> > RETRY_ON_EINTR -- we should decide whether we want to
> > handle EINTR inside the qemu_open family of functions,
> > or make the caller deal with it, and put the macro uses
> > in the right place consistently.
>
> It is incredibly arbitrary where we use RETRY_ON_EINTR, which I think
> points towards it being a sub-optimal solution to the general problem.

Agreed (and agreed that SA_RESTART is the usual approach to
avoid this mess). Partly I just vaguely recall discussions
about this back when we added/improved the RETRY_ON_EINTR
macro in the first place: maybe there's a reason we have it
still...

> > I agree that it would be nicer if we could use SA_RESTART,
> > but presumably there's a reason why we don't. (At any
> > rate code that's shared with the user-mode emulation
> > has to be EINTR-resistant, because we can't force the
> > user-mode guest code to avoid registering signal handlers
> > that aren't SA_RESTART.)
>
> For user mode emulation isn't it valid to just propagage the
> EINTR back up to the application, since EINTR is a valid errno
> they have to be willing to handle unless the app has itself
> use SA_RESTART.

Yes, that's what we must do for cases where we are doing some
syscall on behalf of the guest. But for cases where we're
doing a syscall because of something QEMU itself needs to do,
we may need to retry, because we might not be in a position
to be able to back out of what we're doing (or we might not
even be inside the "handle a guest syscall" codepath at all).

-- PMM

