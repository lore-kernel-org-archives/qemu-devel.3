Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A0606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HGis64OI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxxl-0001xA-IB; Thu, 05 Nov 2026 08:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOxxj-0001wK-Gz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:57:07 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOxxg-0006fl-JB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:57:07 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ab37e44643so15215097b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793887023; cv=none;
 d=google.com; s=arc-20260327;
 b=EGxBkc9B+Av+3xrho5YkADl6Gz1E9EVL2oVlZ479iAeU1qTH6fsNG/uoFzvOrzGWx3
 R7x+nipmQ4vfA5VlstQbPqufUpdWfL1cVVPay/CyVgOV/Q5MP82OLpSg7UHaGJIqtuAG
 VOG9dn1Xm01GoK3EE7vxHSlgapot4PWpAWq8ZpjEyRhNQw8wHF2OAs+MYKy8+R8+G26O
 dykjNSha5EKfVwN47Wm6/0v/3ujPvzb+2F+QirhdouHBXA5i6EyJJeZhD+0QReRLfQzm
 OZIm6+oBqtwc5oZVqMaEbQKgTdYNrl3zWWmBB7hf1lDqVg5rohgHAcn8CJekWjvsNu7R
 ZobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X7wPc0v2tmOL6ug6XoxITK6uOzMeO5kpFhk+t5sbDWQ=;
 fh=GI7V4Xz13sv9Hk7mqOBEtjNSpxnRcTy0lcsPyPtJO7s=;
 b=RXLd3E9bBwId+gmwhViGbhof1TJMJtnlFH97S7HGxgvCywiJRlTPGMwcvPevlbWQUq
 r+DRQ1CS7pXkipgRyA9yyI9WKxWAZqmTdCsy2mCHx1lDq2BcB2XqoShHnu97CBkpKqQr
 DOFI/rnTyu1v2bMmQIET0nGPTSLINtvsqO7iIViZoOuJ/2YYm4T97JODCM1XjDpheKfu
 /Rv6b/QTRGzyJYw/JW93GJXD62ePr3/bwrAhQpkLg4tx6WG787qmPPV/tm74yzKnXG5q
 vY+J3KhzQ+fjy3Y754dJuWCXmXS+k/yff5Jels43eiPEf4HvDOz3wjjEiE4KESQm+/Eq
 QwNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793887023; x=1794491823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X7wPc0v2tmOL6ug6XoxITK6uOzMeO5kpFhk+t5sbDWQ=;
 b=HGis64OIc15/5kW9d+N6Yd6Ym8Mg1GuNq/jR7ZV72HDu4D+Q8SaXgWBVXklq8woTpQ
 h1wADIe1a0g55z01ekHXXaYIAdYfWDmzMdxiNfp1RBk9qBPK0orvu8zRcGYeWAns/oFL
 GsoK/KUTcy+Hv2tFCzer1sKdhx9ORp7EZ75sD8E+HpGj8NYtPkEGd3U1spY2rU8e2nQA
 4ikpmlXgc4lH0Ee1WxJVjnRsnyHmaO1M2qz+/WmnlCcYA5BhKgIUYVdCe/jKUZj2Xwo5
 sHS+Oy1TccDHLvz1SHr/r1p2uqroxb9QvpnA+GtIq9fSQpZRMWg4rCXSdszJvJINgCVl
 r3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887023; x=1794491823;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X7wPc0v2tmOL6ug6XoxITK6uOzMeO5kpFhk+t5sbDWQ=;
 b=vWGqdwhbWBWUx1lPbXpSBjo/gQuUhfZVoBLVFwRWgpnkEdSXIEtcwyeeWm3eX//v1m
 YCaVxl3sO7gGIlFJq4YyjdCGWlAXwpS9PyMCzxLkNNUldaR/2PueAdO0lNG03KuyhUcW
 bhsNNFGRpyL/p7jaZaq4agvuV5vfpYCyD1PLrf9xUlBXAjOYVBLzQokox8emVZL8P8Mr
 sJPKD+0cFHwkoz8TmZXHSf7vcO8voybeVNuuRAfq6gHRQbrfroC3Uq+2lNYT+HXiQBDL
 /GWzMGf/g9V0u1iKePmGbqfqDM6Yv24nDnN9DVhWPjJ4Wd3T1pjH02ubGDoxsswxcU/Y
 ecOA==
X-Forwarded-Encrypted: i=1;
 AKwUvByegt/ONtB2n0MpoMSRQI659AqsJXGo94385kgmo+XNpROc2RClIhAMsb4zemsp1zPUZLzm8LDSreRg@nongnu.org
X-Gm-Message-State: APuU4Z+J3hZwKF4RTuxW4//cvc350wpVLxPiQb3aXDdqJo5TX2vI49Wc
 av3uL2z1IKSi5VkaKO+yxtY35FBzrdMC7hQkmRrq8HGPa9nPnWaBYjTH5TtnoOfQmai9WWrkcc5
 1nOJLemRrKZdTxKzRHe/Mnw/Q34N6QQF2GFnLyz1tXQ==
X-Gm-Gg: AYBFou3AKEPmYloyeAhI+kx/ndLD0cjbfw8ufJ9rO0mW+C7XDtu++mk6HFJKxv7m+Xd
 WLeAc5gYFH52a73qJJVWZHLtAySiNrSnAlUdyJ8814TVlPhnQR8joiwHyhaDhGHHPCAApM7hl1e
 84ie166idRfUpIxQmEv88b9mwFHoxwNGCt0VQFytwCOCJYblLD3Eqq5hTPerJPgN7VYCbXh9BrL
 ESkH+qlLBpqQWGHB/k1QjiiMlROuGv8jk6U3cC0PT/E73hEX01V4cWaVTHAp4AI0fUMEAKUHxQx
 cveEKxhdgXqYsPlNpym7jhHp9VTui0iFudohsB2WNXdOsjj7d7H5HHb0250iQU8DNiIGHybmgqr
 eklVfdL/ZyosyTiDarCPGJCwLifRrQxtfQIXnnmjO6dKMXctefpzEIsB5MDg7+YM1PGoeV97dYR
 rcndsZe2aMFzuSICG3iZdMK89S7Nkye+AB9keCjhQwHjQ=
X-Received: by 2002:a05:690c:91:b0:8b3:2b8:85d with SMTP id
 00721157ae682-8b302b80aa3mr34223707b3.52.1793887023022; Thu, 05 Nov 2026
 05:57:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
 <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
 <aux5vwTnbV3cXcFX@redhat.com>
 <CAFEAcA97kTiGVdPO-QtEkQ0+AuVS1z3Ctfc-q8bJJnEqFwavCw@mail.gmail.com>
 <auyJOk0bjHWO4-FO@redhat.com>
In-Reply-To: <auyJOk0bjHWO4-FO@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 13:56:51 +0000
X-Gm-Features: AclHuK8LD2mTPDHojJSa9J_FAUjT9tU71wtHJ7lNPvkJzJHf9yuLTLWXNSjVe9s
Message-ID: <CAFEAcA_T+WtgKYU5QnaGiuAyZYpAmj6vrzvd_kC8FAFqP7i-mA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 5 Nov 2026 at 13:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Nov 05, 2026 at 01:45:00PM +0000, Peter Maydell wrote:
> > On Thu, 5 Nov 2026 at 12:42, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > > So that essentially matches the historical semantics where one
> > > CPU class magically changes its behaviour based on what target
> > > is running.  So in that sense, it works, and is no worse than
> > > the semantics we've had for 'max' models forever.
> > >
> > > Splitting into 2 distinct types is worthwhile if we want to
> > > make it possible for the aarch64 emulator to support a runtime
> > > choice of both 32-bit and 64-bit "max" models.
> >
> > What would the difference between that and configuring the 64-bit
> > capable "max" to not have AArch64 via "-cpu max-v8:aarch64=3Doff"
> > (which should work today) ?
>
> Is that really the same result ?
>
> It seems like aarch64_max_v8_tcg_initfn does alot more CPU modelling
> than aarch32_max_v8_tcg_initfn, than just a single flag ?

Conceptually it gets you to the same place -- a 32-bit only CPU
with all the 32-bit features turned on that we support.

aarch64_max_v8_tcg_initfn() sets up all the 64-bit-only ID registers,
which is most of what its code is doing. But the handling of
"aarch64=3Doff" then clears them all out via arm_clear_aarch64_idregs(),
and even if it didn't, any 64-bit-only features are by definition
unreachable from 32-bit code.

It's possible it might not get you 100% absolutely an identical thing
from the guest's point of view, but any deviations should be minor
and I think we might consider them bugs.

There are some minor UI-level things relating to CPU properties,
e.g. "qemu-system-arm -cpu max,sve=3Don" gives a property not found
error, but "qemu-system-aarch64 -cpu max-v8,aarch64=3Doff,sve=3Don"
will run (with no visible difference to the guest since SVE
is AArch64 only). It probably ought to error out complaining
that you've asked for two things that conflict, but this is
"minor bug" I think.

-- PMM

