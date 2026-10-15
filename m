Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7BCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHMTD-0004ZQ-1R; Thu, 15 Oct 2026 10:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHMTA-0004Ub-6K
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:30:08 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHMT7-0005WG-Ir
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:30:07 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso3712125a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792074604; x=1792679404; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IBwWlBcDYhoFhX70zhBhdd1Qdy00MjEtCNuxWMWzaIs=;
 b=Z4BpodF7zq//IxUGJwQhniU+XWePTWV7LdNespEQRCaVETGSQCIY8kqfc5gQw+d1ni
 RKWSvjd+VuVvcx+GNQsXLW8K00YqUCwRtw1UztsmMQ9GYDq+TRqmCGrgtJwQrMK4CG5i
 5KlPOyQU8txxRu0RSpz9sslaXlDpAITCd0ifyE16/xaHNDWAsLaRZx+8kVTToh8a9RtZ
 yCAzvfVx/D5rrEs0zSJ59VBGt1jtdL77A04a7FUZiUt7BBLWR9QQWhQqDlNerVV9wBvk
 n1Dv4IqH0RrsClrw3zYY5p8fqOviTMgmucPCmRyq3BewJD+NqM2UMov6GzRbOHQ3PuB+
 kohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792074604; x=1792679404;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IBwWlBcDYhoFhX70zhBhdd1Qdy00MjEtCNuxWMWzaIs=;
 b=YfsPbHRckJNgfeBfzB0wm/7IJOipgFeu+lc50gFYTHfd2uXffJ6r6jzL5TRslWBRBb
 rVZwfyFbNzwrDxuV77PxY3glmcaP9JpsWMflcr5aIBi2YTNXy+0fRs5DOwpS930Yi9yH
 By+NHTbCYHmI5BjAP2+Y0Ce16JsU246vxJtOF+32JquXtOXceVEJzfWj6065+Tz8Fwti
 /Je1PZSpYHiT36g1GO2i8F6b2up8vrepx+PnTVky4Soowg07tM+3lXb+WtXwiaF5XlWa
 59G1cu4e2rpDYqJzdFBgzhJrYyPTRZQsUvmmqCHY6t96Yh/GOxh/tzFd5eyDhhIvKDNc
 4dAQ==
X-Gm-Message-State: AFq9FYLKKLHYCbYexhUDdcKSTlmiYzY5dzHY1Y0GG7VqWMQRaZcyLNFp
 kbGiKgtBDf2yoaXA6KlqjKF0T63RIt0CF4F1OlHvRfSRZWiir4bX06mD3zMGPSUv
X-Gm-Gg: AYBFou3tafL6TLMdO/qWHpbrRAN6ZYP2G0wluhE3AIOSH6sHPsuHjh0PzmQ3W7Zeqo8
 YF7ZDil4n1GiomVqhbmhfyTM3VTOAyhWzhwIjtzPgDmPhrtqw9dEDkBIa6HccagluvySSYr8COv
 1m7l/tCQntOpGYiqcsnTrucyWe9EE1LwxYcbNu/v7tQkVwSSZvK2ibs4DQ47C0xp8U8P/AeqHlB
 FOvySJEplHsjG3E5TfavY2iZdTmvz01RWmrvuJwMu08RxfPo1KKT87aS18/NxwyH38xnR+3GLkk
 1kT5zEbNVcfyy9gud2jOgvBCZUK0u53W58c2SCe5VP6i3AUMtsy6K4ySzKX7g0i++t/wL/Hz9DN
 G5wq0pK9GR5vxEdY7YzWKiWbAZgnFXm9Ptp/LCMqPMb6bumzthKZNQ6tw/80VaYB/NDs4zQCOvJ
 wcM3T2oWVVsqJGUcyZiL0SsgdB0sfWXdNt9ZHyku68bACG8smWonO8hca2G30W/IcPKglsaq1ED
 Wg8HA4lJ9Id9V89x5sCoV5HdUpONCk6LiKFHb2q8KNLBsZpC0pNsQZdNpKRh3uWzbh1IZb7nA==
X-Received: by 2002:a05:6402:5c8:b0:6b1:ef9d:9d73 with SMTP id
 4fb4d7f45d1cf-6b1ef9d9ff8mr6640221a12.28.1792074603481; 
 Thu, 15 Oct 2026 07:30:03 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b203839764sm2559041a12.7.2026.10.15.07.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 07:30:01 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:29:26 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] qga: do not attempt running hwclock(8) on BSD
Message-ID: <atDjRrg5ZFvKWE69@tulp>
References: <20261014112040.70284-1-bogorodskiy@gmail.com>
 <fbc18336-5e10-48b4-978e-8d6078790b24@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc18336-5e10-48b4-978e-8d6078790b24@comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x533.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Brad Smith wrote:

> On 2026-10-14 7:20 a.m., Roman Bogorodskiy wrote:
> > Currently, qmp_guest_set_time() sets system time using
> > the settimeofday(2) system call and then runs the hwclock(8)
> > util to set hardware time.
> > 
> > BSDs do not ship hwclock(8), so current implementation
> > always fails while trying to run it.
> > 
> > Update the code not to run it on BSD. The settimeofday(2)
> > call sets both system and hardware time on these systems.
> > For example, on FreeBSD settimeofday() calls settime()
> > which calls resettodr() [1] which updates RTC clock [2].
> > It is similar on OpenBSD and NetBSD, though implementations
> > differ a bit.
> > 
> > Additional detail: on FreeBSD RTC clock setting can be
> > disabled with the `machdep.disable_rtc_set` sysctl.
> > As we cannot do anything about it, do not handle that
> > case separately.
> > 
> > BSD systems do not provide a common utility equivalent
> > to hwclock -s, so report an unsupported operation when
> > no time is supplied.
> > 
> > 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
> > 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
> > 
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> >   qga/commands-posix.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 837e285b6d..f3d18e6dcd 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
> >           }
> >       }
> > +#if defined(CONFIG_BSD)
> > +    /*
> > +     * BSDs (FreeBSD, OpenBSD, NetBSD) do not have the hwclock(8) tool.
> > +     * These systems update hardware clock when settimeofday() sets
> > +     * system time, so no additional actions are needed.
> > +     * Setting system time from RTC is not supported.
> > +     */
> > +    if (!has_time) {
> > +        error_setg(errp, "Setting system time from RTC is not supported");
> > +    }
> > +
> > +    return;
> > +#endif
> > +
> >       /* Now, if user has passed a time to set and the system time is set, we
> >        * just need to synchronize the hardware clock. However, if no time was
> >        * passed, user is requesting the opposite: set the system time from the
> 
> The command is Linux specific so it shouldn't be checking CONFIG_BSD. It
> should be
> using something like #ifndef CONFIG_LINUX.
> 

Updated in v2. Actually, I have started with that, but later changed to
CONFIG_BSD check because I tried to avoid testing this change on
Solaris. Anyway, just tried this change on OpenIndiana and it works as
expected.

