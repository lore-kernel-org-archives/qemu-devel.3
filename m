Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707AAC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7Fj-00017l-An; Tue, 24 Jun 2025 13:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU7Fe-00017F-FW; Tue, 24 Jun 2025 13:16:09 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uU7Fc-0005Kv-Ne; Tue, 24 Jun 2025 13:16:06 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo10644836a12.3; 
 Tue, 24 Jun 2025 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750785363; x=1751390163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stPEICxxjD0hh28faYD0ik1IUgLNtnuvShlfWporoJA=;
 b=kCIkKV5iwD4hlZNFu5NuciuC+40WKRy5/8/TdMaOwW0mWmZ5PeMlrmYdU/n8L+BLq8
 P6FA780dHzdWc8IiPOln1LlB+1RP7IHU1trvXfUUpjHlkF7lM7gYywCgYKq1KL1spkMZ
 0HRgXCCt9NnGGUIxbncxmFVo4C5A3HTTc7DXVdBJHXH3LT0x80Jed7lVNb10Jw1+GRpS
 w+dn0fW/8mvZPmdeZi98auKxjAHDu+2GwlP6H+wjRneAnuco/sdQbQj7vTfOVP25UYGx
 QUVJLT8LUsQ2TDjb3yi0vjPK+cF7rBbzZUONopu+LXEMIt0syUVhnpV9vnPAmv/Rmzq3
 u8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750785363; x=1751390163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stPEICxxjD0hh28faYD0ik1IUgLNtnuvShlfWporoJA=;
 b=aMw6DYlelbWRoj9sHW54PTmGQkf7qQdsGwAkWVV6Z6JLZkgkYpCl3r8f3nDdnAvEQf
 AGt0cUFMRD90ID/LdrJT41zbbt6ontIq6JZuRA6KvJkYahdf7SPi3rYE5kCBkYz3dSJk
 MG70M2RkNyeaf0NXg6/0gXc7f4lVy89NB/ku888Cc9ozrC0UESdZ8YbE09f0OIUXjvDR
 ymK1pnfgaKW6cuW2dfu23kSN45Re3T7dD18BOkPZwh4mO0zrU7phhwalWI8cnfd4ltz3
 amkHGXzCJkNVn5TOQWhs662f1A8ZaA/dXh/nVXLfto9VNqnRRhP6G5+9mNb04KTZyaMP
 +S9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTwHBowlyt8ffR1Q85V4jIUdirF+apUs4YZbqAI5mHTEeqHrs+GerVMgyroSXW2PDr2FlDV2wz1w==@nongnu.org,
 AJvYcCVsuwFmrQpwQNKxo+aFyRY4UrShaVYdjO0pGmX8lxF9aAQCaqpQA64eSmsyVKnFUtHW7gvlvg3+7cGX0g==@nongnu.org
X-Gm-Message-State: AOJu0YxTLb9lzXrlzv1jtuaQX3nzhoD+own8scH2dpc++5gsa8DvAB/5
 Hi+kJFfkhH2hM/8kPy9qISP5/ZDQ3MRwcDybga7r+EqOW1aoIs2vMT3toiWNJJQrlIzks1H1t6Y
 8xXl0KnUVLD7tK4tDhTepXEFSeTeBHHo=
X-Gm-Gg: ASbGnctQGY1/2GDSEr2Wt00FAVJRApj+q7glwCt1rl6cKT312sK7Gjoh50k9eNM2I4D
 I9kSqMn3oTLOBo/GwfbKfEZfH6XwzFXYvTPvzDCwxOyLPo1kTw70NS9NXvCy10yF8NbqkuRtBv3
 Rsf8fYx92xuHviFVoPMW1qQ/SBn6vSzEUMwIjeg0OcpQ==
X-Google-Smtp-Source: AGHT+IFxTFECbvdUVn7Ki5JMQKPOKFEEfWttU96BZFV81h2BvmZZP9kVDuTkzwFKIhKGOl8OBVWgEnBta0Xl2hrVwNM=
X-Received: by 2002:a05:6402:2746:b0:602:3e3:dada with SMTP id
 4fb4d7f45d1cf-60a1d18eb87mr14798817a12.25.1750785362301; Tue, 24 Jun 2025
 10:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
In-Reply-To: <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 24 Jun 2025 13:15:50 -0400
X-Gm-Features: Ac12FXwTC60e3gyDQi7IDOdYMdtwHot_gdlpHicbrJuQ6I3r0sEJaPOMbzQ_J_k
Message-ID: <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Warner Losh <imp@bsdimp.com>
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, Jun 24, 2025 at 12:28=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote=
:
>
> On Tue, Jun 24, 2025 at 10:02=E2=80=AFAM Thomas Huth <thuth@redhat.com> w=
rote:
> >
> > On 22/06/2025 03.46, Warner Losh wrote:
> > >
> > >
> > > On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail=
.com
> > > <mailto:stefanha@gmail.com>> wrote:
> > >
> > >     On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com
> > >     <mailto:stefanha@gmail.com>> wrote:
> > >
> > >     (I forgot to CC qemu-devel)
> > >
> > >      >
> > >      > Hi,
> > >      > This might only be temporary, but the CI is getting HTTP 404 N=
ot Found
> > >      > for the following URL:
> > >      > https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES=
/14.1/
> > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
> > >     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
> > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
> > >      >
> > >      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
> > >     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848>
> > >      >
> > >      > Stefan
> > >
> > >
> > > Time to bump the version to 14.3.
> >
> > Hmm, while we're used to refresh the CI images for the *host* environme=
nts,
> > it's rather ugly to see images for the *guests* of the functional tests
> > disappear. Maybe we should rather remove that test if the URL is not st=
able?
>
> Yes. Most of our images have a shelf life of about a year to 18 months. A=
nd QEMU
> should be testing all the 'supported' FreeBSD images, just like for
> other projects.
> The question becomes how can we, the FreeBSD Project, remove the friction=
 that's
> here now because we timeout / move the older images as they pass out of s=
upport.
>
> We've also just shifted to a more frequent release cadence, so the
> releases have gone
> from living for  18-24 months down to just 12. We just released
> FreeBSD 14.3, and 14.1
> is only a year old. So what's the best way of dealing with this? We
> could have a 14-latest
> but the md5 would change...
>
> So I'm open to making a change, but I need help crafting something
> that will work, since
> I'm not clever enough to suggest something here.

A test run should be repeatable. If a test passes on a given qemu.git
commit then it should continue to pass when run again. Using -latest
breaks this property, so let's avoid it.

Ideas:
1. FreeBSD provides convenient permanent URLs.
2. QEMU uses a permanent FreeBSD ISO mirror URL instead. Need to find
a mirror that is fast and reliable.
3. Someone agrees to regularly update the URL in QEMU's test suite so
that breakage isn't exposed. IMO the least desirable solution because
an old copy of the test will start failing after 12 months.

Stefan

