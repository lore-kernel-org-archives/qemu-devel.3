Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF6FD58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysN-0001Ng-GZ; Mon, 02 Mar 2026 03:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vwysL-0001NA-Pt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:37 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vwysJ-0001Sx-Ss
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:37 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-38709888abeso60359541fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772441013; cv=none;
 d=google.com; s=arc-20240605;
 b=eK2hZA6cPjQJDkn3mEgM6QWy9c/r3Uu+zWbcovUAzS/r9eAG7zqbpZb4MOSuUBon4l
 GQXPwmb0TdoNg+T2be5qz7SkX7O6VJLYeGbYd5gu4o0lTlfH2SBwtRcsrzeJZCC4cB9D
 o1YC26V6S4PEYV+SkR9DxqCtc67A+IMvMOarN1mPJARFtkF7uLgxM2Xv1YG/LOcc1GqQ
 kFhh+pUyrNYLKMHHRxLEO/lvbAoC+sELhnRvgiVjM7WHSDrSd4ZRv8P81wqcPqx/PuZm
 Uj1+mO2h61UrBHTnL7sBlEoWVa/wVZhuewmpG73iPYh9RjlXTvNI49nB/SIqsxwk4Z9a
 wz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MTMd4mqiUHkCsBCpE9iA/Rfog8aYAKw5nDWHEHJelXc=;
 fh=1qfL3HhlEDEQYcjQpM/5urlGlVQZcBrsut7jqVRLSc4=;
 b=VfFkjvAfsMg2Yp/YYDwqGfo4KIIjphgLKqRc865eqeJYG+mJ68uPITaivlQUfcIg7P
 cTkIl+Cnk4P5PmUyU7e9NtqqMKnURGGzbxhAo3fKSNXyoQ9kpQqyUGfutT8hmlJSu1mm
 S150oNj00IAGE1xoNf06SHzpJEIxmvgsvSyWegI1hsTq5+4bTVPfameptgAeWda/tXS/
 ITAGSG/WwDBtZ2NN4ASB72vb6RhohEFI/c6H7ANLSBa4fjloPKJRZxnlRa/NNkQRt+AF
 DyrNVYmbioLrJ9uhZcAgL5fZw9lEFkoLXpTk8Nw9rO7iayjVmG1QdM3fx6UnFOFQiCsS
 bI+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772441013; x=1773045813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTMd4mqiUHkCsBCpE9iA/Rfog8aYAKw5nDWHEHJelXc=;
 b=W0f431SoxSQQXw1QMcsxvj2Q4v+oMD/v5vJ/TdiMrJP3KUugrY5MSd9hH07ACEgTtd
 1soa3kktlHV8yOYbmVEZ8oQZyGKWNaM8RawyVbtK5uoNB4P2lf1aKPQyEyV9g2Ir0Y7/
 TOWngWzXhA08UvE5S0e7ylBUhaK3I5Ky+fQFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441013; x=1773045813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTMd4mqiUHkCsBCpE9iA/Rfog8aYAKw5nDWHEHJelXc=;
 b=eeTvzb1I7U2TQX7CvjXqK+N+NP8Ats4b06bixzwO7LTuz0GAkYZsrOy4m4cjXFF0ij
 uPOkDwo6iwt/M2jJMXaAksun4vFQvCSBAwbGMUaSbsjCaHUejraC9G+dr+tJY50aFnf1
 dnD7AYVHRxuXTbskQXNdqafxxvmb7VmMdXXcbiu2QeW3nLE1BH9ZwBLLJRz2cj7FD3WG
 lts2Bhk28pM6gRD6GzJ1u2gv5ysRZmGTu4zxPFhrHlnWXRPqoxlCeALCokz9CicfbKgv
 ICFAW8pK+EpDUNgFS3qEqI4Fl0jeUYuZkbmDEgg3I2u3wJDP4SihR3KvbzskgUBtY68b
 fDZQ==
X-Gm-Message-State: AOJu0Yy5taAGh/y5YrEZ6CQR+THHVMOz0sKrimSUqKaZbt5uBWcXm1C4
 0vymekhXALoXF9I8cTls1BVBEFEJ0O1R77kdUEwdhgdU7iIC5sEunTby2ibiIK65ZOCWsLNoskH
 QistTdEDeixBbSdg/Z1P/BstZooEIlwiNiJoUjWtHIg==
X-Gm-Gg: ATEYQzyOEzUQpgJmJ75ZWVSqPvOONMoesWprEr5Xdx1lNeGoaZYkjuRsHFA+C7XHvYM
 4IIqQbfNKA9CUcSrnLMVhT3Wj2q9RupbfXf/IV2oZo32Cl98uqnFfXSxvpg5xSLcdS9ek3tPcfR
 IfLvnARuTM7xOETZh+lwd+cMuriOwSe9KZ28BP11Dl16zgdA6EE36nCERmCDcXff3M9l78WCWTq
 7z7wwUkJeWgBeTh0K0SJ0UoaNDy6bMZIo6v4l2pfcvlPPaz6BGgwwxRK1Jlv5WgNi8GQWeq8Sgu
 han3b6c8vUfrUCcuis9qlXmPrOfNLesCyZWKgnM=
X-Received: by 2002:a05:651c:3044:b0:382:f6d3:e0fd with SMTP id
 38308e7fff4ca-389ff116caamr75522301fa.4.1772441012964; Mon, 02 Mar 2026
 00:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 2 Mar 2026 09:43:21 +0100
X-Gm-Features: AaiRm51MMhlXJ4GYzBVNmCA4r43b7yxxYTFcKjlLH_A5W7dDP1h6o3nxF2veXrQ
Message-ID: <CAJqdLroN0i6FUe1oGBVYh0ytdYNjGOHuYa0GyoaZ9wTBfh5Qzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] hw/nvme: add basic live migration support
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x229.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Fr., 27. Feb. 2026 um 10:59 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Feb 17 16:25, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Dear friends,
> >
> > This patchset adds basic live migration support for
> > QEMU emulated NVMe device.
> >
> > Implementation has some limitations:
> > - only one NVMe namespace is supported
> > - SMART counters are not preserved
> > - CMB is not supported
> > - PMR is not supported
> > - SPDM is not supported
> > - SR-IOV is not supported
> > - AERs are not fully supported
> >
> > I believe this is something I can support in next patchset versions or
> > separately on-demand (when usecase appears). But I wanted to share this
> > first version as RFC to get some feedback on this in case if I'm approaching
> > it wrong.
> >
>
> Hi Alex,

Hi Klaus,

>
> Nice work!

Thank you ;-)

>
> As you have already identified, there are a lot of features that are
> non-trivial to implement migration for. I am completely in favor of only
> supporting migration on a very limited feature set (i.e., don't worry
> about CMB, PMR, SPDM, SR-IOV, ZNS/FDP and so on). Focus on the bare
> mandatory requirements. It would be preferable if the "is migration
> possible?" test is an allowlist instead of a denylist. That makes sure
> we don't add a feature down the road and forget to add it to the
> denylist. I'm not 100% sure how to go about that at this point.

Yeah, I agree. I'll think about it.

>
> AERs are something we need to deal with. We should not drop events. I
> don't think I have a problem with aborting enqueued AERs, but not the
> events.

Yes, this is something I'm working on right now and this week I'll
send a -v2 with
graceful AERs handling.

>
> Finally, this at a minimum needs somekind of simple smoke test to catch
> regressions. Preferably as part of the QEMU test suite itself, but if
> that is hard to achieve, then I may be ok with an out-of-tree test that
> maintainers can use.

Sure, my current tests were simple, I was running fio in screen
session and then manual
suspend/resume:

time fio --name=nvme-verify \
    --filename=/dev/nvme0n1 \
    --size=5G \
    --rw=randwrite \
    --bs=4k \
    --iodepth=16 \
    --numjobs=1 \
    --direct=0 \
    --ioengine=io_uring \
    --verify=crc32c \
    --verify_fatal=1

Also, I had an idea in mind to ensure that Windows VM also survives
suspend/resume.

I'll take a look on how QEMU test suite is organized and try to come
up with something.

Thank you very much for looking into this stuff, Klaus!

Kind regards,
Alex

>
>
> Cheers,
> Klaus

