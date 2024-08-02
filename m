Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C7EC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZntD-0003CS-6P; Fri, 02 Aug 2024 04:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnt8-0002vf-S7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:43:52 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnt6-0003f9-QX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:43:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so9342134a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722588227; x=1723193027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1vz0n4zWQLIuA5h28EZX75s8mHC9XcUmg6LHZR5Q7FQ=;
 b=Fd24MPZfvgy2Ta1IWX9PEFoPVqI9mB7ASk9/H0mMn0Jv9ccIQOFNmYVoPVaKetscWZ
 nWbsM7lzowb/E/2Px4FxaOvmIv8tJ7e+BNnLboUWQJ9FVaTL4mu//F1u3WSUn1zpRJiZ
 P0SG/lOW0GzugNOa2+JVa6p4JNgUGyuvKp0yu+AePYW0ry+CfRryKi6kTRi2votjUnp9
 F7kPBj3MxzEDMEf8JXVERJtOfvOLrlqdLBwO2bYIngOx54FfMFQ6whPBlhAEnN7hiQ8L
 f5cf0aDpZTff3NohWg2mFbzl50xhLSwSBAZmJus2zNiGj8g+UMrnZrUwXvUs5opzZmlB
 Yisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722588227; x=1723193027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1vz0n4zWQLIuA5h28EZX75s8mHC9XcUmg6LHZR5Q7FQ=;
 b=MzF6hVwlrbCI8SbDZisbKgHQfXM5Bzoca/0ZkOW1oJ06YkV9aDvSU2R4BA9fSKHXPx
 oziqDx0KlHsNnC8P3lJ6BZykqB0HHrHKQZO1yjF1AATbUaq9n8cmGTDInXYtf5MwFGci
 Zw0sUJ5HZjL/thF7pFFQuci+4uuSMPTtN0ca5Nn3wciJODVbnuLZf9FSJygivD1RkrXI
 sv/Y4Ew8QAYyfhKCV+jPmFaV43vCA74ssSas2JV14CoJYOtNjXLlRWegjTSGqVsOngAI
 BGBCZ5n7UkWFuRQpc5kqQF1nh5uryBqZL8maPcfdM+YZjY1BlKjfinTGxqfzPEAXAup8
 MJLQ==
X-Gm-Message-State: AOJu0YxsuVLvn2XsIA9EiYyf8M/OpphHlcMGVUb2DcEm4IEiSj0BG+Pl
 XGoUHxzP4PgNsTJF6TW6BYSw3GK4RIT22nHm9zM+s0YkeUUSjWqnVOOEfmw9uC3hlGIAb/jV9GE
 UEwZwwc1qKla0SDN+SUQyM6G7irQcv0P+PiPepw==
X-Google-Smtp-Source: AGHT+IFq0v7PWqYRyXiKJZ9Y5sRXcg8C8MFLQCFPWMuR6JvMH4cc14tb4yxG0lwf4JRQaVxJn6RjRzN2CcsIFLXwtDo=
X-Received: by 2002:a50:fc0c:0:b0:57d:4f47:d9ee with SMTP id
 4fb4d7f45d1cf-5b7f5dc0b27mr1966522a12.31.1722588226650; Fri, 02 Aug 2024
 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
 <20240801142322.3948866-4-peter.maydell@linaro.org>
 <162f8e89-1f1d-465d-a787-8abd565ce0e3@tls.msk.ru>
In-Reply-To: <162f8e89-1f1d-465d-a787-8abd565ce0e3@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2024 09:43:35 +0100
Message-ID: <CAFEAcA9GN5XNQOEUOfEVZEMR5T8st67Qmo9TXcdzH63JAtZsLQ@mail.gmail.com>
Subject: Re: [PULL 3/4] target/arm: Handle denormals correctly for FMOPA
 (widening)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 2 Aug 2024 at 08:45, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 01.08.2024 17:23, Peter Maydell wrote:
> > The FMOPA (widening) SME instruction takes pairs of half-precision
> > floating point values, widens them to single-precision, does a
> > two-way dot product and accumulates the results into a
> > single-precision destination.  We don't quite correctly handle the
> > FPCR bits FZ and FZ16 which control flushing of denormal inputs and
> > outputs.  This is because at the moment we pass a single float_status
> > value to the helper function, which then uses that configuration for
> > all the fp operations it does.  However, because the inputs to this
> > operation are float16 and the outputs are float32 we need to use the
> > fp_status_f16 for the float16 input widening but the normal fp_status
> > for everything else.  Otherwise we will apply the flushing control
> > FPCR.FZ16 to the 32-bit output rather than the FPCR.FZ control, and
> > incorrectly flush a denormal output to zero when we should not (or
> > vice-versa).
> >
> > (In commit 207d30b5fdb5b we tried to fix the FZ handling but
> > didn't get it right, switching from "use FPCR.FZ for everything" to
> > "use FPCR.FZ16 for everything".)
> >
> > Pass the CPU env to the sme_fmopa_h helper instead of an fp_status
> > pointer, and have the helper pass an extra fp_status into the
> > f16_dotadd() function so that we can use the right status for the
> > right parts of this operation.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 207d30b5fdb5 ("target/arm: Use FPST_F16 for SME FMOPA (widening)")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2373
>
> I know it's too late already, but it looks like this Fixes needs to be:
> Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")

It's fixing a mistake in 207d30b5fdb5, which is in turn fixing
a mistake in 3916841ac75 (but didn't quite get it right).

-- PMM

