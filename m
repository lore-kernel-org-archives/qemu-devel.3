Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB38C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJQ3-0002CT-NJ; Wed, 29 May 2024 09:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJQ1-0002BZ-51
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:32:41 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCJPy-0007be-L7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:32:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so2384698a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716989556; x=1717594356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yulUsyJIQ8oW6NmMzCSNnuTWpI0hdThdokzV/awQcLo=;
 b=xJVNfqCHeDGbA/bMsTWaDEht2wUHY21rXBQNkU2TCCeUPJI20s2uRUKuDb5L84Ey1W
 q8BZmoLMOa5dwo8wUu/PJI5OsHg4NH+tpRT8EH3g39tb5JXbQgPO3L0MRKSKq+8NfpiM
 UWkrBFc7Z6Rv0UT5XsuglG5uq3rk/4gwkNwedXJ7kwPx2kQ/hDgTQn/3wN4tu/ho3yxS
 tDeDVpAW6m3/F2di0/2jYa7hYNfbApwEkcY5qBEX1qqC48hkBGspFgyhqEb2+tzP0Ukj
 EyAOtPrvLQ32ttT8Keh8kmlQOYsjIUQ4BCx1d9LwjrpfWHfnl5fPlLf2x0wfQW4wbRp9
 WPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716989556; x=1717594356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yulUsyJIQ8oW6NmMzCSNnuTWpI0hdThdokzV/awQcLo=;
 b=aIWYBsSsRrDsH4EWCxemyLsGk7aQ5/Wxsx/HeX/TnZklanMxzOe1t/OQEFHxXts4vU
 eahExh7hOCVNUjkS+ce301Ods834bIBb5YLiPJG7lseqLSDWYhFFO3OyNwMR1kaB8hWj
 EUu7mVbafANtsC6mbVZJ0RrxUix5mU5xKPpyKeVHwB0NPwa3oyr09QqHb4hvMjsNo4bP
 prTmUrD0w8Z+uJSyx8EbOvvJe8ODDum2uwnDEeWzoVLesrR+jzXgSLBucL8iREvWFhBI
 vgNmetGfVuOXHf1ZrivA2OPfaicBVdWZEBGaInsC7BiFB6xrcELMMl3AVO9WVIrTSHgs
 BkpQ==
X-Gm-Message-State: AOJu0YwPrdnI1bJcwewhGcHbqbLLpOVtUgvAJhPTivrNxa0y6lQ2Vug8
 g6Fa6ojuI11enCsiiNOzEQINUnr/CE5+xyOQQbh6K9f4XH7vkcmgtLqO+wX07KltpbevH04bByd
 kDPusZAYi0cb5MsCFixJukv61nfnWS+bu8jS8WQ==
X-Google-Smtp-Source: AGHT+IGI3KNfZhwy1r1YW3spaLMvSnC+J9ZmDmbxH3rcvC5OtGZWj+sNT2R+x9Q8aYrRTersCi7kwRMKgrQet50b94s=
X-Received: by 2002:a50:8a9b:0:b0:578:59a8:f36c with SMTP id
 4fb4d7f45d1cf-57859a8f421mr7817249a12.42.1716989556269; Wed, 29 May 2024
 06:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-4-richard.henderson@linaro.org>
 <CAFEAcA89_nWDXhXKds3gezUyXdXfO61bMNgSn=em166ufgQAbQ@mail.gmail.com>
 <3f1baa61-c623-4b5b-b724-15bb68a2df3f@linaro.org>
In-Reply-To: <3f1baa61-c623-4b5b-b724-15bb68a2df3f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 May 2024 14:32:22 +0100
Message-ID: <CAFEAcA9ySeup4wE6BwtLYHi53PcktT1AME2Pg7CwgQsAJzb6WA@mail.gmail.com>
Subject: Re: [PATCH v2 03/67] target/arm: Reject incorrect operands to PLD,
 PLDW, PLI
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Tue, 28 May 2024 at 18:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/28/24 06:18, Peter Maydell wrote:
> > On Sat, 25 May 2024 at 00:25, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> For all, rm == 15 is invalid.
> >> Prior to v8, thumb with rm == 13 is invalid.
> >> For PLDW, rn == 15 is invalid.
> >
> >> Fixes a RISU mismatch for the HINTSPACE pattern in t32.risu
> >> compared to a neoverse-n1 host.
> >
> > These are UNPREDICTABLE cases, not invalid. In general
> > we don't try to match a specific implementation's
> > UNPREDICTABLE choices.
> >
> > I think we're better off avoiding the mismatch by improving
> > the risu patterns to avoid the UNPREDICTABLE cases.
>
> We do plenty of other treatments of UNPREDICTABLE as UNDEF (e.g. STREX).  Why is this case
> any different?

It just seems like a lot of effort to go to. Sometimes we
UNDEF for UNPREDICTABLEs, but quite often we say "the
behaviour we get for free is fine, so no need to write
extra code".

In this particular case, also:
 * we'd need to go back and cross-check against older
   architecture manuals and also look at whether M-profile
   and A-profile are doing the same thing here
 * the "v8 loosens the UNPREDICTABLE case for m = 13 T1
   encoding" looks suspiciously to me like a "nobody ever
   actually made this do anything except behave like the A1
   encoding, so make T1 and A1 the same" kind of relaxation

Basically, it would take me probably 15+ minutes to review
the changes against the various versions of the docs and
I don't think it's worth the effort :-)

thanks
-- PMM

