Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD8C48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 01:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcEj5-0004f7-Ck; Mon, 19 Feb 2024 20:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcEj1-0004ep-V0; Mon, 19 Feb 2024 20:15:11 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcEj0-0000fA-5W; Mon, 19 Feb 2024 20:15:11 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso15913295ad.0; 
 Mon, 19 Feb 2024 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708391708; x=1708996508; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mU/taw32pGhZm1F0cI013nJwg5RTjM1lNIF55EI92G8=;
 b=WOqql+GCqvpz7byEAXhLMpS6a4dSJ9ayMiYJ9+9AKsMQ5R5meVSmw7GCQlxQhYluK9
 vTsZN23zdRC69R3M/ivwIPj+IoiYHdM4EbYoHi5PJZRYbeyCUP5n34CqCNIF8lCfYCZO
 u9QQfJ3+DI2XSTln9VSZgKMYYzaoFQfNib/3RTbOBSDMc5E7gZ/lyMnatDguHrbXDtPP
 z0r/QgIIz/G8rjpSQ65IGqosoZe62djlFjGEa0XknB4oE1AKGS1N9PmzkRXB4MgQ2LWJ
 i9RFn/bRzcVIArNf8mAvTOcP+BETV8zsTCBwmpjn852KXO758w6xjsphLxy8NQNYfNJP
 b9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708391708; x=1708996508;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mU/taw32pGhZm1F0cI013nJwg5RTjM1lNIF55EI92G8=;
 b=oSzneao20S4ax0j3g3KRRW8Gs6CbQMt9CUJ0nZP0IMgSBrk9TzRbOlRmOBY3gKeT8H
 siuF7qK60C70+CB1j8a5Pks2oG1f4g0biUXv6/gH2T6QsT98iBUPO8Fn24d+x1oZXHXW
 QeFAXVzFq8mjZiL6qP9FR1QGOglA0oUW228IU4NaRYo9Es01O1fiuK9Vl94iP4STNehY
 WNZnHrPObwRv9A7WIED0khcKxNXMyjBupTRFLPp+vwu0Crb2oYTwSZLGtEMojXpy7lXf
 Fu0Daor/25GgU/nqP+66LNfWKEW3npAFaKzQW8CMIVudK1VLg3PS1+6EccntRBi6xV1H
 jhsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeDikymzcdw2Yd+PAL6+vphmLzXKy7Z3qtPbDb8zD327J/+F+fKxQi0uVxje+4SgXIo9RHFDX9VvDJszamj8D429V4
X-Gm-Message-State: AOJu0YzKXJGfjL005nFYVmfh6IRsdvQv/FOvIvotvrMG6nvh51HgI2e7
 hhxno3nWEUYIok4FtG/Mtx2ePleERXwijASLV7Z4XuerAOgAn4Fb
X-Google-Smtp-Source: AGHT+IFUwASUWKS3ayWRJJ2xpo74BmdhxzNljpAxVlnHXpJ3XTzIVUYHhX1+exuraoV41eq7yLT1aQ==
X-Received: by 2002:a17:902:f711:b0:1db:ad25:488 with SMTP id
 h17-20020a170902f71100b001dbad250488mr12362602plo.19.1708391707895; 
 Mon, 19 Feb 2024 17:15:07 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 h4-20020a170902eec400b001d911dd145esm5035791plb.219.2024.02.19.17.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 17:15:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 11:15:01 +1000
Message-Id: <CZ9IBD2D9NIH.1BK4RCHM1B1DU@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PULL 00/49] ppc-for-9.0 queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240219082938.238302-1-npiggin@gmail.com>
 <CAFEAcA8q12k99HohX24rGCB0u=UgV5J_3_5aPw77yCsip9VfjQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8q12k99HohX24rGCB0u=UgV5J_3_5aPw77yCsip9VfjQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Feb 20, 2024 at 3:06 AM AEST, Peter Maydell wrote:
> On Mon, 19 Feb 2024 at 08:31, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > The following changes since commit da96ad4a6a2ef26c83b15fa95e7fceef5147=
269c:
> >
> >   Merge tag 'hw-misc-20240215' of https://github.com/philmd/qemu into s=
taging (2024-02-16 11:05:14 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-20240219
> >
> > for you to fetch changes up to 922e408e12315121d3e09304b8b8f462ea051af1=
:
> >
> >   target/ppc: optimise ppcemb_tlb_t flushing (2024-02-19 18:09:19 +1000=
)
> >
> > ----------------------------------------------------------------
> > * Avocado tests for ppc64 to boot FreeBSD, run guests with emulated
> >   or nested hypervisor facilities, among other things.
> > * Update ppc64 CPU defaults to Power10.
> > * Add a new powernv10-rainier machine to better capture differences
> >   between the different Power10 systems.
> > * Implement more device models for powernv.
> > * 4xx TLB flushing performance and correctness improvements.
> > * Correct gdb implementation to access some important SPRs.
> > * Misc cleanups and bug fixes.
> >
> > I dropped the BHRB patches, they are very close but minor issue only
> > noticed recently held them up. Hopefully we can get those and a bunch
> > of other outstanding submissions in for 9.0 but this PR was taking too
> > long as it was.
>
> > Peter Maydell (1):
> >       hw/pci-host/raven.c: Mark raven_io_ops as implementing unaligned =
accesses
>
> Hi Nick -- this commit went upstream via a different route, and
> so it now appears in this pullrequest as a commit with a commit
> message but no contents. Could I ask you to respin the pullreq
> with that commit dropped, please?

Yeah, sorry about that :( I think I noticed it when rebasing but did
not check that I'd fixed it. It's nice to keep gunk out of the upstream
so I agree, I will respin it.

Thanks,
Nick

