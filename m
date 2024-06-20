Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61808C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEfL-0006iR-KM; Thu, 20 Jun 2024 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEfJ-0006i8-Bd
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:05:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKEfH-0007ez-Hu
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:05:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so768976a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718877910; x=1719482710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BcjW6Xk7rpO6ZbCiQj+w7Y+/X3apRINHHNW3WYLCgSs=;
 b=bA2EcbFLn/JIYsbk1JvDrClaku8KEvj9mw6Z8pbG0PqfpPfxosSGNdGi8KbwBikdem
 NJWXleuiRZPOw04bp/BgPHo2FS+OzPh3oPP2cyCbB/BUK/Txk775xeWsTHd8G4cHfJKJ
 8vDvlOsmhLV8MlbQBh0bV8DsfoAU18+AaRQJLUZmDfmxf7GunhrdAtKZFU2s/uLDt1VG
 52NdMbXGyVC3UFyDzEJXCr0xxWT2U7SBWGcfDSJJYdXY9zXtO4+mFIp8mLsV7fUqoueJ
 n81u8zY8s0366xzhKo5dujuPw7GO8XKWpJFQ7jm27uTuFjEHqRSR8FV+AK7yZcZ+2D4f
 Ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877910; x=1719482710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcjW6Xk7rpO6ZbCiQj+w7Y+/X3apRINHHNW3WYLCgSs=;
 b=JKwq7maXNiGSERLi1B4dD2tM7Hitog/MRghb7K1aqxrJvYO0mgLVudWQMGy1Ksa1Zz
 v3bWwxJx+yEYIlcHKfdPWTDY2uql92KPDxEImr+bEkLjvRRO5mZ6BZgBrhUB+9OeNlbT
 9UVcOsfAdd1erJJ1qhnwZiDS2v5931c7bzNIOppk9+QXFGCEx5/rK2KQ8tig1ecSikOa
 hFty+8Y4QlHKN6JJYQeKnOMNfFaobJbLHsZjHckk+pFhgEhqilgB8uVmv/0okln0XNy9
 b/LWPLzXqlucePiwqfhgag0M1gvMDkxABYJ2y3xKSqwB6eMKvecvJr+WIk8PtdI3JYM2
 BVcw==
X-Gm-Message-State: AOJu0YwhADhwpQDmNrbDG8GpOSVb0TqiXtM3bcZk5uj6MDQ7au5S1bMR
 d7efCy/wYg2KLXkLWvhrudtf8zhxT4mp9kKp4qBM2WhSHaaKxgVLzxGLNKyQ4a5725Z0TZB+gWn
 8FCQet8rWmCXAjbHRyycHel++vdqZSiRgyeOvIw==
X-Google-Smtp-Source: AGHT+IFv7Eu1nhZjoBKeP6GhPwaijFj6en0te5XlJgtig5U15lQsD+63LsqcKWsz9ViXw76U1u5kFf/UoYlHoJKerJw=
X-Received: by 2002:a50:9312:0:b0:57a:234d:abc0 with SMTP id
 4fb4d7f45d1cf-57d07e6eccemr3507510a12.1.1718877909680; Thu, 20 Jun 2024
 03:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240620060014.605563-1-marcin.juszkiewicz@linaro.org>
 <20240620060014.605563-2-marcin.juszkiewicz@linaro.org>
 <CAFEAcA9XbYr9jzYm908_stCUrZCqixB+cysFTRCe2MnAFW1FVA@mail.gmail.com>
 <d7880fca-2bfb-4368-9419-8227616f2ce9@linaro.org>
In-Reply-To: <d7880fca-2bfb-4368-9419-8227616f2ce9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 11:04:58 +0100
Message-ID: <CAFEAcA9vM-5h8a_xmEUAiKTHoS3kOyutm4er+3+y1_T89U5biw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tests/avocado: use default amount of cores on
 sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org, 
 Rebecca Cran <rebecca@bsdio.com>, Ard Biesheuvel <ardb+tianocore@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 20 Jun 2024 at 10:55, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 20.06.2024 o 11:34, Peter Maydell pisze:
> > On Thu, 20 Jun 2024 at 07:00, Marcin Juszkiewicz
> > <marcin.juszkiewicz@linaro.org> wrote:
> >>
> >> I was wondering why avocado tests passed with firmware which
> >> crashes when anyone else is using it.
> >>
> >> Turned out that amount of cores matters. Have to find out why
> >> still.
> >
> > This commit message confuses me.
>
> Had no idea how to write in more readable form. Will reword it for v3
> (with reverse order of patches as recommended by Philippe.
>
> > It reads like "running with two cores will make the guest crash",
> > i.e. "apply this patch and the test suite will stop passing". I
> > assume that's not the case, but what's actually going on here?
>
> That's exactly the case. With sbsa-ref firmware which qemu uses now we
> have crash if more than 1 core is used. Avocado test hardcoded "-smp 1"
> and was passing fine.
>
> And I forgot to mail qemu-devel when I got hit by that crash.
>
> This week Rebecca Cran pointed me that crash is in BootLogoLib in EDK2
> and I wrote some workaround for make things work. Then Ard Biesheuvel
> found the real reason, fixed QemuVideoDxe in EDK2 and we got sbsa-ref
> running with any amount of cores.

Oh, OK, so it's just random bad luck that enabling the second
CPU means that we end up doing an unaligned access to the
framebuffer, I guess.

Then, yes, Philippe is right and we need to update our sbsa-ref
firmware we're using for the test first, to avoid breaking bisection.

For a commit message for this patch, maybe something like:

 The version of the sbsa-ref EDK2 firmware we used to use in this
 test had a bug where it might make an unaligned access to the
 framebuffer, which causes a guest crash on newer versions of
 QEMU where we enforce the architectural requirement that
 unaligned accesses to Device memory should take an exception.
 We happened to not notice this because our test was booting with
 "-smp 1" and through luck this didn't write the boot logo to
 the framebuffer at an unaligned address; but trying to boot the
 same firmware with two CPUs would result in a guest crash.
 Now we have updated the firmware we're using for the test, we can
 make the test use all the cores on the board, so we are testing the
 SMP boot path.

?

thanks
-- PMM

