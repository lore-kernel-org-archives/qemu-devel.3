Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50811E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa4o-000210-QE; Tue, 17 Dec 2024 11:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNa3i-0001GN-Vh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:04:31 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNa3f-0002Wr-OH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:04:29 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f26c517979so40637247b3.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451466; x=1735056266; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dIZOgxF/tRYx2sIQR6Y3DY+73cDyS/9EAfk34n4Xl5A=;
 b=qOPoVmIvgllw/pyllIt6s0AfMjZj0xzebVbBarhOZbRBpPrpqUIls5tilT5BWZLStE
 MUD7FaUkFYQKxlfA3NkE8GU+PDvynHsfqoplREzvZpgxIkLj0AcNOlXd83lq+O5ebTh4
 sRjUytMzrYh4zF3PRBh65fyHdqiwmHP9fLYvzVFOWvX0jKm3hc+dlqEtlOcbomFCaRBY
 Lp00oDU99pzZ0yYZVRh+Q7oF1Uzk+mC6r7Vsc4m2EWn29CLqZfmVHENSVPgVvTAkHaUU
 SJc/70H8RJPIE0igldO+gdCtINejyh0Bn3ETgkr28mVpRdL42eMlKhYvbH1LWWxrVpha
 /B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451466; x=1735056266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIZOgxF/tRYx2sIQR6Y3DY+73cDyS/9EAfk34n4Xl5A=;
 b=fKXsyGQTSdYNbGoFQfHxL5/eg5LVoYVxHp30lMj2dTFsYVfn5BXorKQUh4QejjDmWi
 BteMLFYYj+qTOOiB6wIeJYJzVMBoBYL0bnji+jjHhPVcSU88d2VICqw8dg9bqfC0T1Kd
 r+ifHCGug6kxg4YM9eO1ajLvHtC9eAa2BPKZSCgVBUkVnUUpafPmy0XexBjiSitv7fxQ
 s/Fg3oFxAGkcskTuYe6Rme3vbbhRqGCHc9Uv8wRsuy7oM5eeRpu2d543yBuRitRW8C8J
 Gi/MxbtnJ8EnDsRDhGOI2OIXehCp73hUCRfquvsv9TxbwJbq4AYUIzmPEn6+F8HioDkQ
 F84g==
X-Gm-Message-State: AOJu0Yw1A3c9ayia9IK0GvCyGjbEnuN54Uz4Z/z/masyqDxUrgexPRwj
 jr2seSd7wc70WNdvyMEEVHVHiC4FkvG5bz6eyXKU+IShs7+cfAyfzEfnsYONGhx0pjUlEFrdNFD
 dq6R+09jV/kbOABQTazcjm7vy3mcFaH36Ac6KJw==
X-Gm-Gg: ASbGncvZIs8Lo+06pklZbNCUWf57LG3hmZx6Ufs3CKNRSVsf/67pYI9mA1hWSwzPIfD
 CPiVVVIxB4pkmtdlRYvpkJZQ2jAGp+6iLpA5dJKE=
X-Google-Smtp-Source: AGHT+IF54cnKa352eM/Tn5bIfVGqRcPNrdxqeLawidmh2oLK383q7mSy8kaTimg9AlBnANP0/Q2YmP85pFsnEnNAXmk=
X-Received: by 2002:a05:690c:4b86:b0:6ef:761e:cfc with SMTP id
 00721157ae682-6f279b3bca1mr127690777b3.25.1734451466606; Tue, 17 Dec 2024
 08:04:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730549443.git.balaton@eik.bme.hu>
 <a8f9fa5e-62e3-61b5-36d2-ab37a1f18ff0@eik.bme.hu>
In-Reply-To: <a8f9fa5e-62e3-61b5-36d2-ab37a1f18ff0@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 16:04:14 +0000
Message-ID: <CAFEAcA9HNay784yf21GgyxzOqkRdWmPSLBM8Qi9yY+UpB0gM1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Separate memory access logs from guest_errors
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 13 Dec 2024 at 12:41, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Sat, 2 Nov 2024, BALATON Zoltan wrote:
> > Originally memory access logs were a debug define that then were
> > converted to log messages but were classified as guest_errors which
> > already logs misc errors. As invalid memory access logs can come from
> > accessing not emulated peripherals or memory areas, these often
> > generate a lot of messages that are better be controlled separately
> > from other errors to avoid obscuring those. As an example try
> > 'qemu-system-ppc -d guest_errors' to see the problem. After this
> > series the actual guest error logs are easier to spot. I've tried to
> > submit this before but there were some people who liked the current
> > behaviour so now this series has another patch that preserves the old
> > option printing a warning to allow time to get used to the new
> > behaviour (which actually brings back the old behaviour when mem
> > access logs were a debug define). This second patch is optional if
> > changing the behaviour without notice is acceptable. As these are
> > debug switches no deprecation period is needed so the second patch
> > could be omitted. I leave that decision to the maintainers.
> >
> > v2: Rename the option from memaccess to invalid_mem as suggested by
> > Peter Maydell
>
> Ping? <https://patchew.org/QEMU/cover.1730549443.git.balaton@eik.bme.hu/>

Personally I do not think we need the back-compat handling so
I would be happy with just patch 1.

(I think the way I envisaged this working was that if there
were cases where some missing device generates a ton of
errors that we would stick in a TYPE_UNIMPLEMENTED_DEVICE in
that region, so that the logging in the invalid access
paths in memory.c would not be hit except where the guest
was doing something wrong. But obviously we haven't actually
done that, and I don't think there's a strong reason not
to split out the invalid-access logging into its own
category.)

thanks
-- PMM

