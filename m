Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F7606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hl1qN/Zv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBLr-0006jH-SA; Wed, 25 Nov 2026 06:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWBLo-0006iX-U0
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:39:49 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWBLn-0007mP-9a
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:39:48 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-677bc4704cbso6660703d50.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:39:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795606785; cv=none;
 d=google.com; s=arc-20260327;
 b=kwpTqYPUdSoV+LCNxTSeutPeWzm8WZJebJDlFa8xCBz8BBeH1U+904t/c8W+mfWPrp
 iFkAG5M9IWmsEgr4zW6NQCWZf5oVh0lJ1zbgXLqNh6pihBdxHdeSSMDBH9FL/56Vhl6u
 tC0vRmdOrO5nP2hZ8JqBFuHxgjuewnexMglgIlRxvpteg5kpHpXBedXXaRNj2MgCnWmg
 YgUgZGsbCLzjUzxsQG5v5RgMSZllKgKUVS3qiTEo6KWXhQmhPMCtiMImgzBfdp1QxTx0
 1LkSRdCK3HfciVeuAenOs5QLwRUKpBBCWmveEPCBATDS8FzG2/oNv/wWCHUuOb9HBfcF
 fWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XaVCcn9Z5aEq7uhLaB/jWmPC3YsCFZjaL4km65O59lQ=;
 fh=Ud8iGdqw5T3Met7Z9Yzel8T0E9pDK4VqfUShOErD7D8=;
 b=gdbe6GXoCJYWBQK/FGvCn9R5P2R4kA1yuaDnbJAr5+8TeGD2JANypi7h9m/EfXv6n3
 4nvNWzu/VcW/3jdlAb09kRJd7EE1KTIqBeGKzlr3Jz7cBYM+D493xlnJ3OeTDK1RVsEJ
 HODhxBmkwER8vW+HdeKciAY3JxoVG3BOgckMKA4lI92QdIAcvPgQgjX4caQisYb/iTWb
 PB4zMPM7XQ+OoSGyAPa4NJs1HB74ckfAnQFnjntTBvnTxWWu7RD2cM6Rg68unQPG7WnL
 wbdJm2dbzCKDiZ8LGVeJlzyN8I+iLk3NgE0fHYZxGMUUjGv5A0vK9CNf2o9f31lwW1yc
 U1Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795606785; x=1796211585; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XaVCcn9Z5aEq7uhLaB/jWmPC3YsCFZjaL4km65O59lQ=;
 b=hl1qN/Zvpw2ovsbkKignjhVgxwxqCwiKO0SBLiHLPHIWBzKIANJqXsDoRaGT0K9cFH
 CjhQDPDP8H4DSSLSrZhoLFFlmPC1wWNayaGAeN6LT5glrw6T2Cx34h0AkMEQU1tk2JNA
 HFJ5+Pt/IFwAn3QSuJtHfLCGNWwXml7MfegW9329Mr+Poi8xbElUuUF+FyCk9BFsZVZq
 XQLP5lfXIFZYbdJpasnZLPPJDiGlcdissA2wmi8nmnKL51SDtxhiww+rvmEC/m61uVOC
 PthC+WbsNIreyqBcugdbMhaELgy6F4Fpc/O+YJsP/KX+Nk+lznNl1r8epcu5L8Q/e0gC
 aRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606785; x=1796211585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XaVCcn9Z5aEq7uhLaB/jWmPC3YsCFZjaL4km65O59lQ=;
 b=wlUE1jr1vOQCHR34IIJDLUdxH04OtWKd/UC3pnLIY9UdQIoG0IczgBOVbof0UHRwqS
 cm5DcODAWpU7wkLABAkYVWUVkNW1yi8DIwPKCO4MUvy8cRo5dxOhT6KfCiuw+bXBsHOf
 pXtXlQ+8MwHDGkdrd58o+ZfJ8nW77xm1MZc0iKHCUI0TrS/J75RSPHnTvnjJQgaV074+
 Fa2S3X9CN5SQCwuG8CGmDJJ8AsCYdVJR2vOYx1HhxrBorXzLFITHCKoLEPWHxtcFK1yi
 nAhtBGmBiNUwEJ5+5euHDGGME6XRI9Juc5rm3euNaHge9EglUCwMb3QyV1W2sX3pbNKA
 6KCA==
X-Forwarded-Encrypted: i=1;
 AL+hErHuTOTOnPCCbXpGq75TivUr3h0voO/3O/usqPQbT1m/k2sKMr+oiUJ0sH2hoQIz9uTPuAEDAQv6m5Hj@nongnu.org
X-Gm-Message-State: APuU4Z8LT2+4fWM0/L8MuyTk1hiC1Fd85MzdKXeYist8oNx2Weru0zPj
 3JUU9gFEd0P3AaF4eWv1Zs7N9n9o8JvUTnMDXMHnquUQL/unhJJLRkaHR8EDcoapyo7jwl9U+RL
 7u3AixLOAtI0DX5KzVYIsXnEdwWyZu9ECHSdWYAb8JQ==
X-Gm-Gg: AZFdTZcyQMNxKgzcuZYMT1P6cU7TuwDU58dinas2D6qncboO9hoQufThxix25BUVI2q
 V5Nl/nleUV5SVXR4DyE+h4NUg1mRZHxxVYf/y/vZ/kghsjlV2EXWltpnMNHrtr1VRLCexLK6yRZ
 9NiwcdLZUNfSZDPTdRO/cn7MZxWZgNCYHCwjyPy1ivM7cQFSjcqRgQ5NmYxmNBTh7Pmb7o50Whm
 mJOi7FKzQ5EYDwUveIZO9/eTpI305tPZB2XyzrNVq3q6lzNnbhlsM9cp2qVUSFpuuIVSCfPq5hx
 ZOMgpX/5gJjiw3+0WfqlEoWN4JF7sUQdsUXEbGpaS2umizUgzDeXSfYJJ9g/hKhU75KtxEdoX+p
 /FNpKWeplXBJoY0YW8+1DGqti/a4GGu1godpDy+6JzZAY0j8lKTB9xbnR5EecfRE3Il8nNusuau
 TYSzzhsH8yG99qcK8pE9c8YsJ+u/EFxg7xupm8OTqkYg==
X-Received: by 2002:a05:690e:1697:b0:67d:a31c:4f8 with SMTP id
 956f58d0204a3-67df44162dcmr5578825d50.58.1795606785213; Wed, 25 Nov 2026
 03:39:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-4-pbonzini@redhat.com>
 <e083cd5c5658465323879c7a7e1f703fe1044c72.camel@infradead.org>
In-Reply-To: <e083cd5c5658465323879c7a7e1f703fe1044c72.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 11:39:33 +0000
X-Gm-Features: Aa3M54qoGktmV6ySFTFU5c_aXFFBHCKZLJFdakVMRSzP1Hqdvlf85JGGFipA8ZU
Message-ID: <CAFEAcA8pnKtgaEym=Pq05cCSBfd0J2UfKgdpzzRn_8pOjJgxBQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 10:28, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2026-09-30 at 10:54 +0200, Paolo Bonzini wrote:
> >
> > +### No AI-written text must reach maintainers
> > +
> > +These rules apply when publishing AI-assisted work to GitLab or the mailing list:
> > +
> > +- **AI-written cover letters and commit messages are banned**.  These are
> > +  easy to recognize and waste reviewers' time.
>
> For commit messages and to a lesser extent cover letters, I think this
> is missing the point a little.
>
> What do we *actually* want here? We want better, more coherent commit
> messages.
>
> Surely it doesn't actually *matter* where those commit messages come
> from, as long as they're good commit messages?

I think the problem is that one side of this argument is very
sceptical about getting good commit messages from AI. Specifically,
I want commit messages that are expressions of intent, which means
I want the human's intent, not the AI's summary of what code changed.
I don't trust that an AI written commit message is actually going
to be good, as opposed to maybe having surface level characteristics
of being good. I think it's much easier to say "don't do this" about
a practice I expect to produce bad results 95% of the time.

Writing the commit messages and especially the cover letter yourself
is also the signal that you put thought into what the patchset is
changing and why, that you reviewed it and understood it, and you
didn't just blindly go along with whatever the AI came up with.

AI commit messages also tend to be really bad writing and horrible
to read. That as you note can be dealt with to some extent, but
I see it as a secondary problem, not the main issue.

-- PMM

