Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB5606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mihalicyn.com header.i=@mihalicyn.com header.a=rsa-sha256 header.s=mihalicyn header.b=BVMvlWyf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUq7V-0003zl-KA; Sat, 21 Nov 2026 13:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xUq7S-0003zS-7w
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 13:47:28 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xUq7Q-0007Op-9X
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 13:47:25 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso469969366b.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 10:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795286842; cv=none;
 d=google.com; s=arc-20260327;
 b=jrrDA4479pTwCd2z8yP3E8e6kuoWxgJIqhhDXoATl4uEUAR9bGvtWCZyWQ7yYDKd4a
 ikcA1loC0b2r+8nGGZMl5OHom+W3PTyHfOaRuqotLdYWgEO1TNlDtWHIFQDoD+aJejaD
 73YVnVdvgKDHc2XahxyfFgnIGWS87VfA/r4SztLCW9IwLbYnJClpB1myJLv2tJA8c25F
 nQ/HZA0beqaNBcoies/TLUiCc+BsrtwwKW7fgel9PI96oWSFjP4E1Sh2X1lw/8MNhr5M
 0+955hQWprupMAhqkPvgoZcRMZ5FA1X9KGLI/RObBL5QbLQTGNPWPpLy+H9BScGM/wRb
 AhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jj19JNCgO14JkMXdDl/LhJX1qj6AanlpJxPxLiRULFM=;
 fh=Zy6eRJWuCgBmHdhOabdGIWEMXYFO0zrKFXwnlFrTZ1k=;
 b=SxlAqMDvLZ7gbotur5NhaN/HtQQX32W7R3OqItZEVBX41GyPLw6x1FeJVqfOhuiMxq
 mcW92U3u2bjICZVVT+AbTkIVMMltX9ktz32heaiO3YfqIV85TDEGyLMqzrV5euLErH1V
 AqOWMr3JNa2DyU2FtsIM5bidvgBwRBmWzD0/iWxSq/XTllKz9nHS+FrlSWf9e7yr+olV
 zbbo43x6FzZskh8ztY86VZMXp0+aUXuHkmU9olH7SwHqXZGgBaip4d7lt2DCXHRo7juJ
 bJxMOgxPWMDkMEn7oe6qlJf2ZwdKZg28ES5l6KiR8xCFnR1crXu8/9cye8C2XlZ1Cd5r
 jOHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1795286842; x=1795891642; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jj19JNCgO14JkMXdDl/LhJX1qj6AanlpJxPxLiRULFM=;
 b=BVMvlWyfSDO+W7zY+dJsjQkJcyOFPAxyoGJZ5UCXb6p01epVXzvfPwLOmSbt3+GfmV
 hqKpQl/P5qX5tv0lbjXoFLN/WLZrqjjIx24DvGxBwU+5+ciKBu26o/yX0p55bN+Lg2zl
 40SixmJ7KSkJRuiUGbY/o77IIVqcVqrFFujjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795286842; x=1795891642;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jj19JNCgO14JkMXdDl/LhJX1qj6AanlpJxPxLiRULFM=;
 b=KIQ5QKF7LkfG1bFcG0ku9KKKijAeneDoQiBEfsKo4M/Zi0cbpIP+7pX0jBaBylGGAv
 AFOpb5mOWwlQEQYe4YPBIhJsKUFQCpc5aURBfsFYMlgzCVa9I4v3JZ0Iy8hkkjrYIU0H
 40FMSdXsgarHkhUkF2Xql01Mt7bMhUH9+8wnI1V+gfK+6JmNWEuDpwlDJz1uOG4gO2OO
 hpRoQiQEaoZO51SQvWe9AWCz1uP99XgS/7ReoLKv+CohV3L+qgQE8BHcqUVP9vHeNfj/
 UTnYl0LGK5IVhEgE+ahrCIx7dcXjS9AhadZOCGvbXSjDalq+9qXaOhyQREDtEDLgGR25
 io6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEYQNvuRI/vZCEgbNr1fgUjjFPXuL8VTkAuW4Q2ypb2UFGaEby6tWX0/u94d5YVeDvWfhEJtjNj396m@nongnu.org
X-Gm-Message-State: APuU4Z8YftqQF+0oFVSvGc4ucPtZd8vDOLQigjnCHPL+3jen9Hv+w+vS
 7srZhJLuJ8HGMbQ+m8D3XzhdVbUt5Rvz0CqJ3yWApt3NHDrMsvIAMTpSDE6ZgUdd/9n7uOZ/rJ5
 EV9+myVG9GEv3ab+97mm6o9IG1TVe9AH01tUQ1FSSgg==
X-Gm-Gg: AZFdTZcOPPKQpT/neCxtx5XQa1fm3D/6DYZKmZZP+toRrU2zPlw47D3SINTQCXV6Pb6
 J9CoYwcF0RURMTqTc00Vh/xt9g+1Pwh4P8q8X/gArkzFZUVpWlp/L42KEHArl9p0fhbdCkh8iR7
 nQ4geMCwnKvaxoYrHTqaiAdhyPNzv9AHJnzGd+yMl48fZ9NHTp4nx7aYaB3zOwXOc+TC79imnZn
 VZtmm8ezM+UqTzb8NVto3Gq+Zy1wapklxUr8P045+eHAPIuDNgI/RTy7Z5+vxwsYRAf9Mcic226
 gncHebp0QbIXHRJSKCum8xIxYHF2/JtiW4TCnlMBy4nE+rxhjFthPVNFB5KkwSWF8zXPQSY9bu/
 3NPdzWX9v7ry8efJmr6Q/VvZCVfCfxB6OalDMTECFrZ3sbfc7NZ0A6jNckPdsqknI34VrQ1z/cO
 xArOCM9cHm0OVEt2neqo/uBDNbBnaf
X-Received: by 2002:a17:906:2805:b0:c49:8bf8:a7a7 with SMTP id
 a640c23a62f3a-c513a5e6a8amr436718866b.7.1795286841405; Sat, 21 Nov 2026
 10:47:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
 <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxmTQeSUziBAtuhb94mVEjU1G_oEx1N1sLwKT3O=gDTA@mail.gmail.com>
 <av9FeuY9pnYHXblq@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <2ca9134951ab6f43be86be07f3721e52c2b3a25f.camel@amutable.com>
In-Reply-To: <2ca9134951ab6f43be86be07f3721e52c2b3a25f.camel@amutable.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sat, 21 Nov 2026 19:47:09 +0100
X-Gm-Features: Aa3M54qqiI6AlXdOrg5WGoxtX1CVqLIj9CWJ6D7yVlGZtnIJVU0-Wep2AgBpZjM
Message-ID: <CAJqdLrocJ-p9EDQxvNfxNDOnN8Qob3GtOx25YJg3XJp2tG=xRA@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x630.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Fr., 20. Nov. 2026 um 10:14 Uhr schrieb Alexander Mikhalitsyn
<alex@amutable.com>:
>
> On Thu, 2026-11-19 at 13:52 -0500, Peter Xu wrote:
> > On Wed, Oct 21, 2026 at 06:06:46PM +0200, Alexander Mikhalitsyn
> > wrote:
> > > Am Mi., 14. Okt. 2026 um 22:51 Uhr schrieb Peter Xu
> > > <peterx@redhat.com>:
> > > >
> > > > On Wed, Oct 14, 2026 at 10:18:45AM +0200, Alexander Mikhalitsyn
> > > > wrote:
> > > > > > - for this test, should we remove snapshot=on but instead
> > > > > > create an
> > > > > >   explicit overlay that will be used on both src/dst qemu?
> > > > >
> > > > > This should solve the issue too, at the same time if test is
> > > > > R/O I'm
> > > > > not sure if we really need this.
> > > >
> > >
> > > Dear Peter,
> >
> > Hi, Alexander,
>
> Hi Peter ;-)
>
> >
> > >
> > > sorry for such a long delay with reply. Was busy plumbing some
> > > other stuff :-(
> >
> > Same here. :(
> >
> > Let's fix this first, or it'll be forgotten!
>
> I agree!
>
> >
> > >
> > > > Then.. maybe no need to bother. :)
> > > >
> > > > I think we should better remove snapshot=on no matter what, then
> > > > whoever
> > > > sends a patch add migration blocker for it won't fail this test.
> > > > Seems the
> > > > /tmp mount is still needed then.
> > >
> > > Yeah, if we really gonna make snapshot=on to be a migration blocker
> > > (which seems
> > > like a clean way to protect users from doing weird stuff like I
> > > accidentally did in my test :-D).
> > >
> > > I need to look on the option you've earlier suggested with
> > > "explicit
> > > overlay that will be used on both src/dst qemu".
> > > I'll get back to you ;-)
> > >
> > > Btw, does my fix with mounting tmpfs actually solves the problem
> > > for
> > > you? I'm just curious,
> > > because I wasn't able to reproduce the problem locally tho... And
> > > if
> > > so, then probably we should
> > > land this tmpfs-mount change for now, while we can prepare a better
> > > and generic fix to get rid of snapshot=on,
> > > add migration blocker for it and so on. WDYT?
> >
> > I agree.
> >
> > I tested your patch, it works for me, used to fail almost certainly
> > but now
> > it passes in a seq of runs.  I just thought it wasn't a good enough
> > fix,
> > but considering my poor speed on reply (which is this one me to
> > blame), I
> > think we should fix it first.
> >
> > You can send a formal patch and attach:
> >
> > Tested-by: Peter Xu <peterx@redhat.com>
>
> Sure, let me send a patch on the weekend then ;-)

https://lore.kernel.org/qemu-devel/20261121184301.21112-1-alex@amutable.com

>
> P.S. Then we can plan to do some more work to add a migration blocker
> for "snapshot=on" case you've mentioned. But I'll certainly need some
> guidance to do it right, cause I'm not that yet familiar with the code.
>
> Kind regards,
> Alex
>
> >
> > Thanks,

