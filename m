Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 08:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7Ew-0002Mw-2z; Tue, 09 Apr 2024 04:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru7Ep-0002MM-SG
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:53:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru7En-0007Qa-Io
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:53:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso5465940a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712652831; x=1713257631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rdAuDtEcvwWsfJBGuPkvfv9cE4wlLDJBwylt9WMLA4=;
 b=A2PGEl7aGpN9FQPGWHHpwYjZ9SVP2oAB4hle16eb3svy8i/1Atvg5VNmwX/9bVIqda
 0UUZgi+t/HDZ9aLpyq+WZErpKRk6Eyg/Alb+K/MofkuosTB7VpR4hQp0oRe3t2V/N+vO
 R8uQ9eEbR6epzMyR9XReY6e33jCTyrVB9Oy4M1dE7JL64KqFD/EE6hL5UqsANEs5j48m
 aJ0r2F77UuridRSAuT6yRF4leX21KhyDSyCv9xdmmxvwIJGnSQP8Ht+TwU+vt3A/weaJ
 NURj69JFr2ZQDZY5XHAztfxe/cO/DA2Hi60ok7zA6ALN9vgoAqRChyVxGAnaKMDmekHX
 0KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712652831; x=1713257631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rdAuDtEcvwWsfJBGuPkvfv9cE4wlLDJBwylt9WMLA4=;
 b=uDAMdtjc2nMkJn79RJo+ZrMqCJuUFOJkdNuhYHlNgYeg6XvXZsCAqPSq4uN+XLVRvE
 qXzrC4eYZ0Q+D5fu67v88t61MvyEE+wJwjywXJi1w5UWTkWMCA0GhyPE3jS9jNcdLhvp
 rp9bkxsKl41WKP8XTnikZGKrKg2NwVCqMkEtKe+W6Pkz3YQTCJxi7upzHjGCtwWrwoBw
 S2eRPw5znCFGMh265Y44LUdxZGbzC2X5hrDUM+n8hKOaAJbR2adM57dy/+32zVX5WCSg
 NcLr7yG4I6PZORbm1BWn7uOj0bxv2d292aX9raPkJh2je6wzh6M6eO/nciXl1FoyB+Lm
 SKow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSCQ1H2mPK6wqbUzkEjMekYm7Yt9S7innm7FRhr0Rx6HRIKPivi8xvTom08qh8WxZNCiw932fFeCqNJVRZz4hcEifMOUU=
X-Gm-Message-State: AOJu0Yy8V/eSgoTjyBs+NuLXbZuNgIRlrAAu/RjOYr4M7MsIb7RsGHaN
 l0VvM+W/KPwHcOegDDIcM+EY6/BzWEVIM2A/9ntaWWeSI/mnmTsRNlhsdT3DhgGEru/1/P/zYuN
 /MdzsqRewGsNtEBm3HjaC7ogL6zqEIbadRDtZtw==
X-Google-Smtp-Source: AGHT+IFzbuUZmqxyPMGBtx7szIwtsUGSjRCaB0uXgzFvNmHrEMsoV2hSrhxrwJiGnibxWGrUbgbp/cmV3MDR3EbWCEU=
X-Received: by 2002:a50:ccdb:0:b0:56c:1db1:f9eb with SMTP id
 b27-20020a50ccdb000000b0056c1db1f9ebmr7671171edj.19.1712652831214; Tue, 09
 Apr 2024 01:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
 <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
 <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
In-Reply-To: <CAM2a4uwMomHgYVQvRV+3UjsjTkE-BOK=zn8Rgv5y7OGjy0HfTw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 09:53:40 +0100
Message-ID: <CAFEAcA-CDgR2r7uNh=PQaQfVspa5tnNTwiK7Dbor7faxY25V=w@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Gautam Bhat <mindentropy@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
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

On Mon, 8 Apr 2024 at 20:25, Gautam Bhat <mindentropy@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 2:23=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> > This will not work (yet) -- CPUs do not get reset as part of the
> > whole-system three-phase-reset, so using the exit phase method
> > is not sufficient to avoid the reset ordering problem here.
> >
> > You need to use rom_ptr_for_as() to see if there's a ROM blob
> > at the address you're trying to load the PC from, and if there
> > is you use ldl_p() to get the PC from the blob; otherwise you
> > use ldl_phys(). Searching for "initial_pc" in target/arm/cpu.c
> > will find you the code that does this for M-profile.
>
> Thanks for the tip. I am able to see the program being loaded based on
> the dump of rom pointer in gdb.
> Now the problem is I am loading a binary file (msp430-elf-objcopy -O
> binary simple_test simple_test.bin)
> and due to this I will be missing out the loader loading different
> sections in the right parts of the memory.
> The reset vector which is supposed to be present at 0xFFFE is present
> at 0x3FFE in the binary file.

That sounds like a problem with your binary. If the reset vector
needs to be at 0xFFFE then it needs to be there, and you
should arrange for it to be built correctly. It doesn't matter
whether it's an ELF file or a raw binary file, the data has
to be in the right place. (Generally when objcopy creates a raw
binary from an ELF file it doesn't change the address where
the data is, assuming you load the resulting raw binary to the
right starting address.)

-- PMM

