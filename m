Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C285606FAE3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1ixuL+T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCRc-0004Jm-JJ; Tue, 03 Nov 2026 06:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xOCRZ-0004JN-LW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:12:46 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xOCRX-0004pn-P5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:12:45 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-36c9a93a1abso268527eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793704362; cv=none;
 d=google.com; s=arc-20260327;
 b=H13Xuj31o+5z5ywHGOQ3dsRkWAP+qcVisBEciamoGkfIHjgE95wA1j3HK2yXjOjzD5
 Xxl7BgM5Vh6zh0AgSKBAXsffK/bi4us/c+/nDtd7RFL/hCf4SW+VVWNzhT/RXeLELnY4
 50uC1k+g1MSO4VUz2rDfn3ANh/toW/fq+usyx/T29iyI/dfAxElrtQCaQFFbgjWCRVpO
 aOa+uhy+SBEHDfCFqyGPk+vzuACZ7Ku6ZGrvI6WOaTs5875NQIR3/7EFqTshtHRPnqhx
 mrPn+k4HpUO7yqO5aSL0SXldJwPcR2SAxaE04RqovwvyCDTG6+mEX+e6d0IvWBUdkorg
 60Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tpdLM3LKm1OAwl0gzD6ftPos8oPNvwZ1Cn4P3BGntfw=;
 fh=cqM3doaiJUK2Lm8Urb0UqL0Do5xqq0YscmizfewwXrc=;
 b=SiHZfs7JtFS4vEvASFfzkyaxHw+dstEr4LOM+wL+1HaZKEtvX6JzV6I8El7UlYhue/
 eCt1eZZDBSNzIyQ1WVgUfe8nlQxHD0SBIR1rCzYkwiUMaKiCR1Nj8qX5ii9vfAR205w9
 FZn65jewSpx+rrQQbLDa3aHEjncTBKbDea8PvUw7nNoQhjsuCzYYksMIgIYp/r8a07wb
 j7c491NXYR8XwZuqxCKcngB6W6dLIcK1ki6rj+mfwPEPbKttJJdExwDv1yz99zGC7fXX
 tf/oaLoB5QS4sQ2UNU0vwtCRDQbZTKCxyBAZg5XmRJJUus45I0Qlq0mLF3SmssZfJD8T
 KeXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793704362; x=1794309162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpdLM3LKm1OAwl0gzD6ftPos8oPNvwZ1Cn4P3BGntfw=;
 b=a1ixuL+THrekjpTQO3DTqq5uiNMs+rdP1vLpzwyIhTyJ1mejLZ6SHkipqlFPvPCn97
 uJdyMcFV4yV1QtWm/NwDzOkA8+adIGzH5MGYG25hyqnCPVUr4MV1QJKM1LXmXPnrKRII
 erUWodSGfYJQx+DqHig7RW32Z/0tFcBTq8TDZKRcIZzytckuDQ8QQ4PfpEg5ESTXqfVL
 nKbkTwGFaD7K57G06oNShNHH+zLtMZI9mmEb83w2lJscfYeP60jhBCYAunumB1hCyCnq
 sWeZjKZCdpceOqRG38Z/IsPDGWXOs5SEMDC/6p171qrE7Z7uFvqoBwN8ou/Js9NfSoIy
 u37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704362; x=1794309162;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpdLM3LKm1OAwl0gzD6ftPos8oPNvwZ1Cn4P3BGntfw=;
 b=g3QiXZ0j0hWcD1g6Ikc6ynrcg1OwSe5qgJNnywlE+TTHvkl0nqWScR/3rP5FEOLGUD
 nazC56yfCGw5eGSirEBKBI9QTBAM6jHpYCyaC7C1qYgjX8ejXHRzRMarCMJtmeDfVGSL
 uzYasHI51HD/oVv425VFKBXYgI0KGkhoMZsqN18QCjXGF51HSfKlzCFfRj2tXRZiyVN7
 GOf3MOHYg8EcKZZkbi/ha5omIWyTKLPa0FlvCXb3yFHBZCBVVr/JKRuKADmcRXrEIvhN
 oUHX5mhILlcvZ8D4zcSLfF2Tllc9fYMkkfNdy2OUN9O4xPkO/fVIgEIg6dzzHx5uchVa
 o0jQ==
X-Gm-Message-State: APuU4Z8KM2mpUd0a15OmBOetqBNW5B+J0zURMJaP62a8VDbfE2Ko2YEK
 mXvu17NDRPInLRwLyScexQvmyXjg0gmhBScppb8tKfpDmmq+phuABSn7yYlpcWfnHM87FPxpMd6
 lZs+QKk1sY0NkqibZlALEvzsYFnp9Hx0=
X-Gm-Gg: AYBFou3RqZUINrBgQMNd6coWYXR0/s9ehKwMgpHF7aSbBm0Fokc0GHlboIWU4Vgi/lL
 +7YPs7XhzKBMfP4eWhIik4S0fym7VjaB+eiT1DluCGpEh58JtlOUQHRKB0+cV/iERrL1Ka12Icr
 WbIOUV+S/aN9qqjU2H9+Plk5/Qw1E8nfWPmFo2fbDd67W93hC6BBk8sSahtURvdu9zk27Zwweym
 5FtYl1C3U1Gs9E88U9Xt2cys4EGdMRI6/2bEnikYgH4tT26FcV3ZMx6Y9+0m8nLOQ+98qNf7vkm
 gSrKJb5rQ8+534ILD8A7dOArnM4V2oKI9Kqt5dv8D2R7Bc6K/W6bG0eQaFKoLyXfiDTlhU19gr/
 QyKsNuZmBJy67RlO8ofLbE4I/2A2u1vQC7IzqRwTEThQMwz1U3HkVaTgdzi/60Th2hWU8
X-Received: by 2002:a05:7300:cd91:b0:369:f231:b98f with SMTP id
 5a478bee46e88-36a300084d3mr29863138eec.4.1793704361707; Tue, 03 Nov 2026
 03:12:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
In-Reply-To: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Nov 2026 15:12:29 +0400
X-Gm-Features: AclHuK-S_cLF2ktuPaK7s9wr-HpyTYWfgRyIssjdn9hOSyrhYKVEffSj0y4nhz4
Message-ID: <CAJ+F1CJwnGr8ViY3VWT9xOFMW5oqugj3zYigBurVm5nhgi=tDA@mail.gmail.com>
Subject: Re: QEMU Sashiko
To: Alistair <alistair@alistair23.me>, roman.gushchin@linux.dev
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 29, 2026 at 3:32=E2=80=AFAM Alistair <alistair@alistair23.me> w=
rote:
>
> Hey,
>
> Sashiko just merged initial support for QEMU [1].
>
> For those who don't know, Sashiko is a LLM powered review bot used for
> the Linux kernel. When people send patches to LKML Sashiko reviews the
> patches and responds to the mailing list with any issue that it finds.
>
> Like all LLM tools, it is both useful, but also verbose, prone to
> hallucinations and misses things (like humans do to though). The
> general consensus in the kernel community is that it's a useful and
> valuable tool.
>
> Sashiko is just a Rust application and prompts, it doesn't include a
> LLM and you can use a range of different LLM backends.
>
> Google sponsors the development and runs a Linux instance. So you can
> see the hosted Linux instance here: https://sashiko.dev/ and it uses
> Gemini for the LLM which Google pays for. It seems like there is also a
> GCC one starting up.

Have you made a request for QEMU? Apparently, Roman is taking care of
the various deployments, reaching out to him. Would it be possible to
add it? QEMU patches are roughly ~25 series/day (usually a few
patches, sometime up to 100). At first, we probably want a silent
instance (not sending review mails) for evaluation and compliance
checks.

thanks

> The cool thing about Sashiko though is you can run it locally as well,
> so you can use it to test your patches before sending them to LKML, as
> long as you have a LLM backend you can use.
>
> So, now that Sashiko also supports QEMU there are two exciting use
> cases:
>
> 1. Developers can run it locally to review their patches before sending
> them to the list. This can catch issues before sending patches
>
> 2. Maintainers can run an instance to review patches. How you set this
> up depends on the maintainer and how many tokens you have. Pointing it
> at the list directly and running it for all patches might be too much,
> but some combination of manually triggering it for certain patches
> seems to work well. The Settings.toml file can be setup based on what
> you want to do.
>
> The hope with this is to save maintainers time as Sashiko can catch
> issues without requiring much time from a maintainer.
>
> QEMU support in Sashiko is very new, so it will take some tweaking to
> improve things, but it is at least a good starting place.
>
> 1:
> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e=
6c834d8176f70
>
> Alistair
>


--=20
Marc-Andr=C3=A9 Lureau

