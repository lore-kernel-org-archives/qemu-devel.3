Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D77CDD1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 14:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suBqS-00086u-BM; Fri, 27 Sep 2024 10:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suBqQ-00086G-1c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:21:18 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suBqN-0004tK-G1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:21:17 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f8ca33ef19so30006931fa.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727446871; x=1728051671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5Uu0lyciqJKmTGcNbVC0EYnP/DrNJE93YuOq8UX640=;
 b=tJBQH6d6z2nJKXNDFG7cG7VNTUPFGWYhORLUsBW8soWuroGdDTEywJxIePsBfu1CVC
 kUcWqS7GxyjHiBdmeDm1/nY30Q8Jwl0avNvWEAsvgJC/k2XjDzJEH6STfdXVVgVn/9Q9
 8otdE8SyJecXCuehBef8CoZLUCCSLSiS97Nm3+/9YzH6jp0pF1YpQiWECna/sI/q6AGi
 3JZtQ8S2jIjO4SpJ9DC//aW3q1eswWYb+K2OV45OZLAeRhy09pMrC2eQPc5exSnTd2Zx
 J8d/cPbF0Yr1l/xptkZzj09Cv4wVrv3EY0iGZvFD2UdihAkhXRDAJdURb1AUD0XvQ56a
 0gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727446871; x=1728051671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5Uu0lyciqJKmTGcNbVC0EYnP/DrNJE93YuOq8UX640=;
 b=KvsWBhY/jkwKeS4dvP/Qkc+uRajlgHtumxFw+pN+OQmoxYUxvvL4Avo4CBqwUyTnsk
 SydK8cYv1BND8Ejda8yVkPOsptlWff/HQKWAFD+P37JDjku9Zd3YJvggCja7974IJ+LD
 xSF+6Bk+P5HyjbfD8AY27gma2M72m6RfAIKk97172tQCviiPzpr3vXubfdhFVvRBmKlj
 PosvUjts/GT7YILgWOZCZFg/i9a9pePvEeYsRVzd3euX0d2ENePLxKIY+AcVjyBBFh5h
 nBPRpZjBjCB8oCj+0j5vMxDGK9/etxq8kOC5hn32XWR20L8axyYjG5TYGS3HSKZ70AWN
 OIXg==
X-Gm-Message-State: AOJu0YzlJ1mOGW37UVegvlvARfgxtj/n4kiyWRgoiPRdmzSML+hK1bkx
 nwaMYs2BCMLEcLZvJNdLmNYm3pA3rolMMe43H2sedwEkj9Qb99CMOoXsdwWu3owQrQrwNZ8tbcN
 sb5SO5+wZEAnvuqgsB5hLixGkkSpiAD2hZf3A1A==
X-Google-Smtp-Source: AGHT+IFfDxZ69x7s/LJ0QB+OeM3/6ip+YnQYVITNHqCSgWrAL5cS7xw/tjqQLW3sZG//bJaGPHSFJgPLGNghnIsN/hM=
X-Received: by 2002:a2e:719:0:b0:2f6:4a89:9afa with SMTP id
 38308e7fff4ca-2f9d3e59e96mr23402011fa.22.1727446871188; Fri, 27 Sep 2024
 07:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727425255.git.chao.liu@yeah.net>
 <CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com>
 <c9bfa6ba-7399-4edb-a882-7cb11e9d7b58@yeah.net>
In-Reply-To: <c9bfa6ba-7399-4edb-a882-7cb11e9d7b58@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 15:20:58 +0100
Message-ID: <CAFEAcA-Eod5HrhsNzPcrszTLS2G2+n=87svbfUEs8BhA=F_MwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 27 Sept 2024 at 15:03, Chao Liu <chao.liu@yeah.net> wrote:
> On 2024/9/27 20:18, Peter Maydell wrote:
>> On Fri, 27 Sept 2024 at 09:52, Chao Liu <chao.liu@yeah.net> wrote:
>> Even if our test set is not sufficiently comprehensive, we can create an
>> unimp_device for the maximum address space allowed by the board. This prevents
>> the guest system from triggering unexpected exceptions when accessing
>> unimplemented devices or regions.
>
> What would be the benefit of doing that? If we're going to
> say "we'll make accesses to regions without devices not
> generate faults", the simplest way to do that is to
> leave the ignore_memory_transaction_failures flag set
> the way it is.

> Introducing this flag provides a straightforward way to suppress
> memory access exceptions by checking if the flag is enabled after
> a CPU memory access failure; however,its primary purpose is to
> ensure compatibility.

> Since we can designate unimplemented device memory ranges with
> "unimplemented-device," this represents a more standard approach in QEMU
> for managing RAZ/WI behavior.

I don't think that using a 4GB unimplemented-device is
a "more standard" way to do this. We have a standard way for
the board model to say "we don't know whether there might
be existing guest code out there that relies on being able
to make accesses to addresses where there should be a device
but we haven't modeled it". That way is to set the
ignore_memory_transaction_failures flag.

There are two things we can do:

(1) We can leave the ignore_memory_transaction_failures
flag set. This is safe (no behaviour change) but not the
right (matching the hardware) behaviour. The main reason
to do this is if we don't feel we have enough access to
a range of guest code to test the other approach.

(2) We can clear the flag. This is preferable (it matches the
hardware). But the requirement to do this is that
 (a) we must make the best effort we can to be sure we've
     put unimplemented-device placeholders for specific
     devices we don't yet model (by checking e.g. the
     hardware documentation for the SoC and board model,
     the device tree, etc)
 (b) we do the most wide-ranging testing of guest code that
     we can. This checks that we didn't miss anything in (a).

I don't mind which of these we do. What I was asking in my
comments on version one of your patch was for how we were
doing on requirement 2b.

thanks
-- PMM

