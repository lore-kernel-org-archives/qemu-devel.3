Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AF7C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA68l-0003Ro-PL; Wed, 30 Apr 2025 08:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uA68j-0003RH-V8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:02:14 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uA68h-0005bT-W7
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:02:13 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef60e500d7so66542337b3.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 05:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746014530; x=1746619330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTrNUbs0rHf7kHhBUd+cMNoU4jrzm2hENUQKey2H8dI=;
 b=HsdTGJSElOHth1FQR6dCcJjOglWxu4YtlGUBuAwsCSUHArXCufF6iziruS5UmZ2rP5
 pQXG+qLSeALGamZO+vNP6ibsqdODpWoxk3KzhV+jzlKU1HZ8lS603ZJbRH8IJP7sTx7r
 /qqsQpDZPB67S7x0F1GXtna3lmTa8LnNcN6Vw7lxWUXeJPm4s2Y3LDlKXbj3QYg47DWr
 HuMUbwbbN6mVv+ehbDpBGLNLGR+X0rz1MW+XulFX5omI/rgvU5pdH8NTCnvC7aCDBJBq
 4e/OwQ6O1jts4LmbODjX8bjc1JQ1sftjcuQB48NRSmSQHYIIGVzL97CUhPM2NLfkuipD
 ZmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014530; x=1746619330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTrNUbs0rHf7kHhBUd+cMNoU4jrzm2hENUQKey2H8dI=;
 b=hXB4gxzbDKUCbTKLhy4ty4anV4j98a3tcHcxpn1SK8KVlkRNy0TdYuwK1agdiheH3x
 cnk1zitVTDVX/y83x/12y4SlMmorteCMvTZbrkOrG5EwrmAlaygCDiuIWb+MALqMsXAX
 qmo/BWbESfE5zN2PnjXGnlq2kQpR2J70/UjHmUUOUEJJLBNOYUv6Dhkc0Fd2iW/8Xoah
 faU7M108GPBgvhV6EIK4+KyOssniKZ5498t09tNK9TSCIxnahCAKYjssLqviZKgiv78a
 Pq96NuHAsLB3bJVUptuFcCK2dN0q9WJNPOxJfJr7cbf39h0jXBSlqmnVnfgJzwJ6hF0R
 9nJw==
X-Gm-Message-State: AOJu0Yy+gLjsj9BUhlmpj20mnIGPozUkSEEGncmlYSeFUpzYoXZ2U5RV
 9iFHwu9U1VonGdXFReZzVlD+C1Phjg4FnQBXLp4iLJf6yr/ofXv2uOddbnNgwJAry3yv9+hQpnU
 DZRA1jm7TRyXP1ZxyFmfMavZAVeLwhCGwYATR4w==
X-Gm-Gg: ASbGncueKkcM+Om3+8HT/AYRHoZrtpACVHSdVf97RCC/1nbyrd/FV2Mi3+Q4S0klS3S
 AW8B6MMYl8HLbpL2tVn2LdGGcyWY9GP3CRjDeVe7RDHOLwkTH3oS8tkLN86OpZt/f8Onk+2HRgP
 a60nSsQ+zK008sUH/uJW22RTw=
X-Google-Smtp-Source: AGHT+IH1E62hV5/kEWVMrAsdfoI6wKHqdUfwN2TM5IKtNk93QKs37LYFrXNoA2inke0f7uhnhoeHUX/85kJ0aAb5mfU=
X-Received: by 2002:a05:690c:6ac9:b0:6fd:25dc:effe with SMTP id
 00721157ae682-708abe248a0mr39060937b3.25.1746014530349; Wed, 30 Apr 2025
 05:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <419c09dde7ca8a538f07e259a1cc3bbb4788f3ff.camel@suse.com>
In-Reply-To: <419c09dde7ca8a538f07e259a1cc3bbb4788f3ff.camel@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Apr 2025 13:01:58 +0100
X-Gm-Features: ATxdqUGvA8fYZTYdP403mWos9TmbRB25yej82zjwKHtg0YGl4y5AsmeP5drU4JA
Message-ID: <CAFEAcA-Hz5Ni-NcB0GamsvQ=2y_1BFXgnA_uhrj-ThMHMGGuDg@mail.gmail.com>
Subject: Re: Problem building (docs) with -j1
To: Dario Faggioli <dfaggioli@suse.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 bwiedemann@suse.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Apr 2025 at 10:14, Dario Faggioli <dfaggioli@suse.com> wrote:
>
> Hello,
>
> When building both v10.0.0 and master sequentially (like -j1 or
> equivalent, e.g., when in a 1 vCPU VM) it fails when we get to docs
> (`make man` is also enough to reproduce it), with this error:
>
>   [1/2] /usr/bin/env CONFDIR=3D/etc/qemu /home/dario/Sources/qemu/suse/gi=
t_upstreams/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1=
 -j 1 -Dversion=3D10.0.50 '-Drelease=3DVirtualization:Staging:10.0 / openSU=
SE_Tumbleweed' -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b=
 html -d /home/dario/Sources/qemu/suse/git_upstreams/qemu/build/docs/manual=
.p /home/dario/Sources/qemu/suse/git_upstreams/qemu/docs /home/dario/Source=
s/qemu/suse/git_upstreams/qemu/build/docs/manual
>   FAILED: docs/docs.stamp
>   /usr/bin/env CONFDIR=3D/etc/qemu /home/dario/Sources/qemu/suse/git_upst=
reams/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j 1 =
-Dversion=3D10.0.50 '-Drelease=3DVirtualization:Staging:10.0 / openSUSE_Tum=
bleweed' -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html =
-d /home/dario/Sources/qemu/suse/git_upstreams/qemu/build/docs/manual.p /ho=
me/dario/Sources/qemu/suse/git_upstreams/qemu/docs /home/dario/Sources/qemu=
/suse/git_upstreams/qemu/build/docs/manual
>   /home/dario/Sources/qemu/suse/git_upstreams/qemu/docs/system/qemu-block=
-drivers.rst.inc:506: WARNING: duplicate label nbd, other instance in /home=
/dario/Sources/qemu/suse/git_upstreams/qemu/docs/system/images.rst
>   ninja: build stopped: subcommand failed.
>   make[1]: *** [Makefile:168: run-ninja] Error 1
>   make[1]: Leaving directory '/home/dario/Sources/qemu/suse/git_upstreams=
/qemu/build'
>   make: *** [GNUmakefile:6: build] Error 2
>
> It works, instead, in parallel builds. In fact, building with 2
> processes seems to be already enough for compiling the docs
> successfully.
>
> OTOH, v9.2.3 works for me, in both sequential and parallel builds.
>
> I've tried to remove the `-W -Dkerneldoc_werror=3D1` arguments from
> sphinx-build and that "resolves" the issue, so I think the problem is
> the "WARNING: duplicate label nbd".

It's odd that it only fails in -j1 -- our current thought was that
this was related to the Sphinx version (some versions warn, some
do not).

I sent this patchset yesterday which I think should fix it:
https://patchew.org/QEMU/20250429163212.618953-1-peter.maydell@linaro.org/

You might also be able to avoid the failure if you configure
with --disable-werror   : I think (but have not tested) that that
should make the warnings non-fatal for Sphinx as well as the C
compiler.

thanks
-- PMM

