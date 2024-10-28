Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16585D33997
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Rjc-0001sI-JD; Mon, 28 Oct 2024 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5RjW-0001s3-TA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:32:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5RjT-0002TV-1u
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:32:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cbb0900c86so3478261a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730129556; x=1730734356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aiG4X484oBTLzSXHKcykAXIZCm5qGYo0kBexgd9SfkI=;
 b=c6qUW7itdauvz16QS7XZpc0SjAKyqwgsBfMZGoUZ/2YeX1GKl+2tMsn3LsEGGsFJbC
 FaiGvgZ011wNjloShBZa4eKYld4MRmxHQlTmS+gwK4VLNOKG6uH8dbcsoH/GqtjMJmG+
 6rgBAE46YCT4ZYDq2HBJCfLYG/LeR+kTJVaAtJg+nGYxe1mFJNkV0IeSrjPX8hVtQDaW
 m0wOmLs7eip0xJwtewLWC2npkTzeiH0gnISfFTU7RXkgHp8+WErYYdx/Pa3apOqGyb23
 Y+aeCRlmQ1sJX7KefsAEOasqegsM65FIHIkqTjefrJAHQsn3eF/qn+85WW/g8CnQCgtB
 C8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730129556; x=1730734356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aiG4X484oBTLzSXHKcykAXIZCm5qGYo0kBexgd9SfkI=;
 b=uXfh8ipm7yd9wqmQzgjLBrkyEcs0rQjZdDJ6DrAg19ieuTvGAesbi9U2P7L6QZn9/2
 eHPv6hwko+NvWzhpUIBP2AMJFZ9e4FIselLsfe2b1kRFdXtkRinGlGlxLkQErl+oJzW0
 cuntNvw7ttJ7aESb1MnXq0Hu1gbdAQBh+Iul+Mex1Im1gR41/SQcE9VyhxJJdC6iV3Xb
 oirk7kUbqV2oloia/1dC5ZwCFfEQApHT92jZ5Y6tD5IBZwoFOj7oCTiDbRSDKMD6XqQ1
 7a9Wu/kSKF+0rVY6EicR+5u5scGikIdGBgViqWMeQEDgu/lyVjJWiAz9t/ocJz8iey3y
 4R5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkJEU68pHZDM3qWb2PaObxIma1fFdR4ZmrGbeLUj+cPxGznfPcFquFLtChl/lb4LOztVkpFZ958OA0@nongnu.org
X-Gm-Message-State: AOJu0Yw5NqXDXM93fIQlrCCfttR9Uc3mZtCuL4jxASMVZwvurDcQKHYR
 50rUkiWx3fNJUDu8C6ccK8L/N3i1VErqJ8qTyckhG+Sa515PtecoumSNpbOiGH36n+I9LNMQzJK
 GjVWjpmAnpv6PmVVI+wQAX9OBW+jW/U8q4qB0LQ==
X-Google-Smtp-Source: AGHT+IHo58t+vF88cKz0w59ERmKob9Lrzxv8w6U1jJicplSGQf/FRCZXOg85d3jQmgbsWupMSy7yBad7Ue8AlW2J8XQ=
X-Received: by 2002:a05:6402:2711:b0:5c3:d2bc:2f64 with SMTP id
 4fb4d7f45d1cf-5cbbfac3a40mr6225121a12.35.1730129555695; Mon, 28 Oct 2024
 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241025024909.799989-1-ido.plat1@ibm.com>
 <53c424e6-dc51-4b87-b0fc-11c0703b5416@tls.msk.ru>
In-Reply-To: <53c424e6-dc51-4b87-b0fc-11c0703b5416@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 15:32:24 +0000
Message-ID: <CAFEAcA-DCiREHP41SDqsx67Z4ajbvQZN4LEiyVXNadK=htOEBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Fix arithmetic underflow in SETM
 instruction
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ido Plat <ido.plat1@ibm.com>, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 25 Oct 2024 at 16:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 25.10.2024 05:48, Ido Plat wrote:
> > Pass the stage size to step function callback,
> > otherwise do_setm would hang when size is larger then page size because stage size would underflow.
> > This fix changes do_setm to be more inline with do_setp.
> >
> > Fixes: 0e92818887dee ("target/arm: Implement the SET* instructions")
> > Signed-off-by: Ido Plat <ido.plat1@ibm.com>
> > ---
> >   target/arm/tcg/helper-a64.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> > index 56b431faf5..8f42a28d07 100644
> > --- a/target/arm/tcg/helper-a64.c
> > +++ b/target/arm/tcg/helper-a64.c
> > @@ -1348,7 +1348,7 @@ static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
> >       /* Do the actual memset: we leave the last partial page to SETE */
> >       stagesetsize = setsize & TARGET_PAGE_MASK;
> >       while (stagesetsize > 0) {
> > -        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
> > +        step = stepfn(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
> >           toaddr += step;
> >           setsize -= step;
> >           stagesetsize -= step;
> This also seems to be:
>
> Cc: qemu-stable@nongnu.org
>
> (Cc'ed now, there's no need to add it again).
>
> Please let me know if it shouldn't.

Yes, I think it's stable material.



Applied to target-arm.next, thanks.

-- PMM

