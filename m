Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714CCC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SLc-000586-Gb; Tue, 01 Sep 2026 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x1SLb-00057f-BM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:32:35 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x1SLZ-0007p7-GX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:32:35 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a5f1d0af69so177714a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788283950; x=1788888750; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lz80P4paY/pguLwqrMMKHK8LbtL48CgUlfa/c7sK+Kg=;
 b=EOHs9B5IVq2v92+UVxBXTuPj07T3CLt3PRlqxZ2O8tVijffpIyna4kL1yjMK9Y9PHz
 NqeWIpkdBm2oUK1txrs+Mg8keaMRUdqefwGQmxfdjPbSQjkzCXlvH5AbsskiJQPCVe3T
 HbUOK/zc1J5i9gcx9GSCyAqUUFTfDq0UhYfQM3ADQ/j+NT6ukvPHHyMnKthsmngHrQaO
 O+uiGkkIyUY8ujtrbHUDTepfOz5MoJhppgVbwb3qrbl4agellLJLChYUlUzX5mcJDBEf
 byzAT3yaIkkZC95MF17Kz8KRXxL6XQsaH3sggnP4WJ22eQPOPhVyoGWNWv3dQHCyII+v
 snFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788283950; x=1788888750;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lz80P4paY/pguLwqrMMKHK8LbtL48CgUlfa/c7sK+Kg=;
 b=rBqUAQc9qyVk2qz2b+XjoG4S1EoqXBvt236vRJp69GPEGhve/z0wtrDgAJDOuJclAN
 cshJkWjzQt7w/6O+yF2md3dpNjlwEUF1mqh1+VYopyC4+GJlU9usrHW5K+P0RDOUCm91
 oZw2iTuAYIbjSd0mL3lRS+J08z6icmt4Qsf2J5BMMRtZeQYtwstCU9eYrgAP/AuBKGY1
 Y79AF0BAS4SwT/yDo0B39dpzsfEFeTKBHk7mlPMTNPWwesu/bDr5g9AsF7mbCXNJfKmx
 S0B90t93RigT6X6YoPWZOa3so8UctwYPzcKVVfpEpkKFNITE22AQ4dXta/B4sQzZNQ3L
 COeA==
X-Gm-Message-State: AFuF++n6HSOgS26K1ZSmWZEgk4SEASw+lXLZlEr8HUEwRTBne1J6TYC9
 sSjM9opx36Lp3c9+evdHYX+w1FdbSO6wc7vc8GhALnm0YNkhsE7DCpkf
X-Gm-Gg: AR+sD10TeHjqc+YOyOT62Gsx9TDWt8jxJ9GITwK+N1XYz0t5SCsrUentArqLHOXQhqD
 akeX1N06bHVlBTR575BylF+xFMDvxXgA46TB/fUIGA1CdoNek6kD/yY+bXgm+uJ6aXhRg99gFoU
 Ye3iozqXCdWWSrc+3V/OtK1F1ulXQBF6JzKUfktwLTkLetSXucnNNy9CpqO3KO1FUsmIJNjPFps
 8ZJMbxLVOmA1tzcE/mfGOH87QlH0YnGP1kvbQJrPdGDRhBBvNFowzOEltro0Mh7otR8We414ahE
 efJZFdrEJmPLkYihzFC7lf1ru38GjiQlUlRBXBiQq9W0OVcrZol4RMHz8OtJdJQ0SyIOzKVMcVQ
 YREElKjCvF/Xw518WKOqbaEB7deO0XCOZ2gp/OQpkN961hY6aJvvLHC4w0inJjD4bH2q4NQZOXH
 TDF7Y15tG5Wg3XFZ1dgm54xRqrQFwzDPQ/h+Qy6+Fs8fsPJlIaKGsLf+uCyd20JVk+y1j0EGvXW
 Bi35DWQo5nYp13V8FMEVPHvmKgS6th6JZry4o01YVARaNPugcoebftIIeARYg==
X-Received: by 2002:a17:907:da16:b0:c1c:4858:c19c with SMTP id
 a640c23a62f3a-c255740d809mr2191365766b.23.1788283949842; 
 Tue, 01 Sep 2026 10:32:29 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d039d2c2sm3257466b.32.2026.09.01.10.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:32:29 -0700 (PDT)
Date: Tue, 1 Sep 2026 19:31:09 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
Message-ID: <apcL3cfPcBw9YEf9@tulp>
References: <20260719160329.73695-1-bogorodskiy@gmail.com>
 <CAPMcbCrLmS2NXASKAWujm6=do9cAvMcB4p5Yxp73T_6HshRGQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCrLmS2NXASKAWujm6=do9cAvMcB4p5Yxp73T_6HshRGQA@mail.gmail.com>
User-Agent: Mutt/2.2.16 (2025-11-22)
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52d.google.com
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

  Kostiantyn Kostiuk wrote:

> Hi Roman,
> 
> Thanks for your patch, and sorry for the late reply
> 

Thanks for review!

> On Sun, Jul 19, 2026 at 7:04 PM Roman Bogorodskiy <bogorodskiy@gmail.com>
> wrote:
> 
> > Implement the 'guest-get-diskstats' for FreeBSD.
> > This implementation uses the devstat(3) library which is a part
> > of the FreeBSD base system.
> >
> > The build system is updated to link qga with `-ldevstat`.
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > ---
> >  qga/commands-bsd.c   | 127 +++++++++++++++++++++++++++++++++++++++++++
> >  qga/meson.build      |   3 +
> >  qga/qapi-schema.json |   6 +-
> >  3 files changed, 133 insertions(+), 3 deletions(-)
> >
> > diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> > index 94ff6fee6a..763db33c9f 100644
> > --- a/qga/commands-bsd.c
> > +++ b/qga/commands-bsd.c
> > @@ -27,6 +27,9 @@
> >  #include <net/ethernet.h>
> >  #endif
> >  #include <paths.h>
> > +#ifdef CONFIG_FREEBSD
> > +#include <devstat.h>
> > +#endif
> >
> >  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
> >  bool build_fs_mount_list(FsMountList *mounts, Error **errp)
> > @@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned
> > char *buf,
> >      return true;
> >  }
> >  #endif /* HAVE_GETIFADDRS */
> > +
> > +#ifdef CONFIG_FREEBSD
> > +static uint64_t bintime_to_msec(const struct bintime *bt)
> > +{
> > +    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) * 1000ULL) >>
> > 32);
> > +}
> > +
> > +static void guest_diskstats_append(GuestDiskStatsInfoList ***tailp,
> > +                                   const struct devstat *dev)
> >
> 
> Can we simplify pointer logic?
> For example, return GuestDiskStatsInfo* for devstat* and then append the
> list in guest_get_diskstats.
> ***tailp -> more pointers - easier to make a mistake or memory leak.

Yes, will address in v2.

> > +
> > +    diskstat->has_ios_pgr = true;
> > +    if (dev->start_count >= dev->end_count) {
> > +        diskstat->ios_pgr = dev->start_count - dev->end_count;
> > +    }
> >
> 
> In case start_count < end_count, you have has_ios_pgr = true, and ios_pgr =
> 0 (g_new0 initialized to 0’s)
> Is this expected? And in general, is this possible?

That's an interesting question.
`start_count` and `end_count` are uint's. It is possible that
`start_count` will wrap sooner than `end_count`, so 

   start_count < end_count

But apparently the correct behaviour is still report the difference
instead of reporting 0.

devstat(9) describes that:

     start_count        Number of operations started.

     end_count          Number of operations completed.  The “busy_count” can
                        be calculated by subtracting end_count from
                        start_count.  (sequence0 and sequence1 are used to get
                        a consistent snapshot.)  This is the current number of
                        outstanding transactions for the device.  This should
                        never go below zero, and on an idle device it should
                        be zero.  If either one of these conditions is not
                        true, it indicates a problem.


So it looks like the conditional is not needed. libdevstat in FreeBSD
does not have it too [1].
I'll remove that in v2.

> > +
> > +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> > +{
> > +    return guest_get_diskstats(errp);
> >
> 
> Any reason for this wrapper?
> I see it in the Linux implementation, but not for other commands.

I followed the Linux implementation schema here. Apparently it is not
necessary. Will address in v2 as well.

1: https://cgit.freebsd.org/src/tree/lib/libdevstat/devstat.c#n1547
 

