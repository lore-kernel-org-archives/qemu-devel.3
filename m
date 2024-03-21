Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C508AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnMC1-00039s-8e; Thu, 21 Mar 2024 13:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnMBz-00039S-U6
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:27:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnMBy-0001GP-0a
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:27:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bc7b07df7so1673937a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711042018; x=1711646818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6auEkLl37TD/VgmQy+OL/NLRoWucCKX0OJc0jUufdu4=;
 b=U25dx45skCNSRHbQMRhHY+8XI31luxhY5y4Cpl1CnyvBPwMPa9CBDxToHE46w+hS3u
 W9wD6PsixhaVEemN9czLAxOMbLDi4FQBHWKqf5usfz3vc5laxpnN185aWorx/bEu6cLV
 Uu+60nlKfs+HMZxTHMkKLT//4OneSMsqRa9LbtenrLS1dgHfPkXxGDsf/82PuW+SJt1h
 RnwvBI1yiSWHw6cEVXyTxTKaLlp6YEtNVsjB6Cwyx/2YPpOnr/mNkS8yIKpyXz97i0dW
 WgadJa0BQSFISpyOdTLyjLhS5PyhrOfOgV1UzR3SDzaC1JUS1TR2C32x667Aw757LN3T
 ht6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711042018; x=1711646818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6auEkLl37TD/VgmQy+OL/NLRoWucCKX0OJc0jUufdu4=;
 b=niU923tsAnnpcycNRR3WtQikHHsz2KfoxuAVapZSlSjERLcpiG0LWI5VQJrknqBJPZ
 9T2/yg3lLgbYs8DhGHmKaqi3Y3RjrwQIQwsWv6VvH41hxICoa+C2NyvnkNa93t3riADf
 hYNMdzc6sK3casnCT4B9QB0z9loGgPPOKRqU20qrKHcDsode+B1J64zEBkOGcWnwzQNM
 aNdI2c1MvXYbuRfRyCXKbvYwBnx2WYTMBcnZrHtnL2LOf3MlMMckRP02WIB5jJ0J1PMp
 9xmtBrWerP+WY5wYTYBJeKyZ3v+9jb786iX8NNJ+/Py3r1p2hav2DK8+Bn37slcRLUa4
 iXRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJBtBHp6dHEnpLn25gUeb/2aHKpOvrnLkx2uMZQyImmPfAfclkvsZS8mt+1JTrQR1jQsFFq/rScv+qnzj4OgT3iA4OLss=
X-Gm-Message-State: AOJu0YwCPpXh+lUsg0L8yoiaBci2hE+ihKvpf5w4juoyXw0MwuXlhR2a
 GTwanaEo2Mv6ThV2iwBi1mKo45ZVPu1CbSyM8Yxj1uK7ZOs73V9LxuvuASwvPoOgAPgBeH85JIq
 dNoJt1GK7IwnVO45t8eHgoT9X1B8ZKOyj3nQOVgfzoktOQCkX
X-Google-Smtp-Source: AGHT+IFeYa/Rq2DjkW1WW8t/QD9BvFYCLxTjG4ES77Mm9GQLeahJTauorrV27H2M+lzid/+aXk5XK3D2o95u/A026y4=
X-Received: by 2002:a50:cd93:0:b0:568:b0f4:fe69 with SMTP id
 p19-20020a50cd93000000b00568b0f4fe69mr3167056edi.12.1711042017783; Thu, 21
 Mar 2024 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <5e6e2c5b-70bc-4a9b-a5ce-353607e42ac6@tls.msk.ru>
 <a896620e-d0c1-47c0-9609-56a30c4f4f3e@linaro.org>
In-Reply-To: <a896620e-d0c1-47c0-9609-56a30c4f4f3e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 17:26:46 +0000
Message-ID: <CAFEAcA9hsDH4YxwOq+oD=+bFSRc9RN6c6uJzww8uyeOWJFS_BA@mail.gmail.com>
Subject: Re: change QARMA3 default for aarch64?
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 21 Mar 2024 at 17:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/20/24 23:32, Michael Tokarev wrote:
> > Since commit v8.1.0-511-g399e5e7125 "target/arm: Implement FEAT_PACQARMA3",
> > pauth-qarma3 is the default pauth scheme.  However this one is very slow.
>
> That patch only introduced qarma3, it didn't make it the default:
>
>   static Property arm_cpu_pauth_property =
>       DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
>   static Property arm_cpu_pauth_impdef_property =
>       DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
> +static Property arm_cpu_pauth_qarma3_property =
> +    DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);
>
> Per the first line, default is still qarma5 (which is the slowest, afaik).
>
> I have not done any benchmarking for qarma3 at all, but it still *looks* significantly
> more complex than impdef.
>
> > When people run aarch64 code in qemu tcg, an immediate reaction is like,
> > "this seems to be a bug somewhere", since the code run insanely slower than
> > it was before.
> >
> > And this is very difficult to find as well, - the reason for that slowdown
> > is usually well hidden from an average soul.
> >
> > When the reason is actually discovered, people start changing settings in
> > various tools and configs to work around this issue.  Qemu itself has
> > overrides, pauth-impdef=on, in various tests, to make the test run at
> > saner speed.
> >
> > After seeing how many issues people are having in debian with that, I'm
> > about to switch the default in debian build of qemu, because impdef,
> > while makes certain arm64-specific protection feature less effective,
> > is actually significantly more practical.  I dislike changing the
> > defaults, but this is a situation when it needs to be done, imho.
> >
> > But before doing that, maybe it's better to change qemu default
> > instead?  What do you think?
>
> I think it might be worth having -cpu max default to impdef.

Yes, I think this is probably on net a good idea (it's a migration
compat break but I think that's OK for 'max', right?). But in
IRC discussion it turned out that the perf loss mjt's users are
seeing is between 7.2 and 8.2, whereas we've had pauth be QARMA5
for much longer than that. So it seems like a good idea to track
down exactly what's caused it to appear as a problem now, before
we start changing the default.

thanks
-- PMM

