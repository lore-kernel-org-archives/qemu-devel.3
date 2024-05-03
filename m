Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04157C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s304w-0006vk-BX; Fri, 03 May 2024 17:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s304u-0006v7-Mq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s304s-0002zj-EV
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714770261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjJewk+eC3qv1XSr6DKHL8+8we9DGhFCiQvPMz+iNIs=;
 b=aXnBNPkr+FO3oFi6WTYvPVlS3JhyowtgoaQ4kPn/TGdEehRRHM2CzvwIVWNkR7vSPdvkKp
 6FIvYxXeh2G54qPdkM8T9GOnuFlfKIGP+fZ6Xdx8Oxnxm07+F5SzixrGDd1okqYXBEhYF2
 YOAuDH/iKi0YFBB6sxQz5qO1sYyJOfQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-5vy3Y9T4NOK6-v6_ls6m3Q-1; Fri, 03 May 2024 17:04:19 -0400
X-MC-Unique: 5vy3Y9T4NOK6-v6_ls6m3Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b36899b6ccso53710a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714770258; x=1715375058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yjJewk+eC3qv1XSr6DKHL8+8we9DGhFCiQvPMz+iNIs=;
 b=O/Bn4nRyysWdNcerLK1MTzObI9IsPaybNcPdMxkzOeavNfBMCsBADHX4SkJA+rpbw8
 3eFi4jiBMVTJFjprFtNhNT5jnaI0Mjb0/dmoZsl7qacKc0uX4TiNDARRKjYQ4qeGtyle
 jlG0Fvg8zNSjTeu/yb4Fnr08zPQy2IEXngDfzMXkcGnXrf7KBVEJEFkYE1QztNxHCKUu
 Uvod84h/oFhlRrczHn1BmDuR0GQ3A+rizzD0HaDCVgACnGfT/tKHSkFT4RjwTDti07Gx
 VpNSOGeEiuYuVsiQvl6U7Qgm7ZYs7pDwn48EVnlOH9X2TuRdRAMnJG51lvxN/9vcjC+O
 Xceg==
X-Gm-Message-State: AOJu0Ywj0Zd8bXxxyH/J7gNrLmtL9axbJGwFRVignghUT4g+lnDwiPvD
 dnzF89y2+ZNREnhZ7JUR1K+CGGogljtYoeA+Yz3InZEcZ7YpelpH4Yb9gTguRYilK7PyUx+pKTg
 zGU2ZovENimlUw/38w8ivHwHGArFVuw4NFYaz60ADf3iB7GG4vOH34GZwIyu1
X-Received: by 2002:a05:6a20:564c:b0:1af:5385:3aff with SMTP id
 is12-20020a056a20564c00b001af53853affmr3703265pzc.3.1714770258075; 
 Fri, 03 May 2024 14:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVLtpO0d8uzTQffgFrV+QI2hSmzaKVQ+XbBJrNZWYxgsz0OSWatawtS5GESnJxbO27g2t9Pg==
X-Received: by 2002:a05:6a20:564c:b0:1af:5385:3aff with SMTP id
 is12-20020a056a20564c00b001af53853affmr3703221pzc.3.1714770257130; 
 Fri, 03 May 2024 14:04:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u90-20020a17090a51e300b002af2bf7082fsm3866799pjh.39.2024.05.03.14.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:04:16 -0700 (PDT)
Date: Fri, 3 May 2024 17:04:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
Message-ID: <ZjVRS6yT6n7_wb0V@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de> <ZjUPl6XwB3Zt3cKR@x1n>
 <87a5l6oejr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5l6oejr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 03, 2024 at 04:56:08PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
> >> When the migration using the "file:" URI was implemented, I don't
> >> think any of us noticed that if you pass in a file name with the
> >> format "/dev/fdset/N", this allows a file descriptor to be passed in
> >> to QEMU and that behaves just like the "fd:" URI. So the "file:"
> >> support has been added without regard for the fdset part and we got
> >> some things wrong.
> >> 
> >> The first issue is that we should not truncate the migration file if
> >> we're allowing an fd + offset. We need to leave the file contents
> >> untouched.
> >
> > I'm wondering whether we can use fallocate() instead on the ranges so that
> > we always don't open() with O_TRUNC.  Before that..  could you remind me
> > why do we need to truncate in the first place?  I definitely missed
> > something else here too.
> 
> AFAIK, just to avoid any issues if the file is pre-existing. I don't see
> the difference between O_TRUNC and fallocate in this case.

Then, shall we avoid truncations at all, leaving all the feasibility to
user (also errors prone to make)?

> 
> >
> >> 
> >> The second issue is that there's an expectation that QEMU removes the
> >> fd after the migration has finished. That's what the "fd:" code
> >> does. Otherwise a second migration on the same VM could attempt to
> >> provide an fdset with the same name and QEMU would reject it.
> >
> > Let me check what we do when with "fd:" and when migration completes or
> > cancels.
> >
> > IIUC it's qio_channel_file_close() that does the final cleanup work on
> > e.g. to_dst_file, right?  Then there's qemu_close(), and it has:
> >
> >     /* Close fd that was dup'd from an fdset */
> >     fdset_id = monitor_fdset_dup_fd_find(fd);
> >     if (fdset_id != -1) {
> >         int ret;
> >
> >         ret = close(fd);
> >         if (ret == 0) {
> >             monitor_fdset_dup_fd_remove(fd);
> >         }
> >
> >         return ret;
> >     }
> >
> > Shouldn't this done the work already?
> 
> That removes the mon_fdset_fd_dup->fd, we want to remove the
> mon_fdset_fd->fd.

What I read so far is when we are removing the dup-fds, we'll do one more
thing:

monitor_fdset_dup_fd_find_remove():
                    if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
                        monitor_fdset_cleanup(mon_fdset);
                    }

It means if we removed all the dup-fds correctly, we should also remove the
whole fdset, which includes the ->fds, IIUC.

> 
> >
> > Off topic: I think this code is over complicated too, maybe I missed
> > something, but afaict we don't need monitor_fdset_dup_fd_find at all.. we
> > simply walk the list and remove stuff..  I attach a patch at the end that I
> > tried to clean that up, just in case there's early comments.  But we can
> > ignore that so we don't get side-tracked, and focus on the direct-io
> > issues.
> 
> Well, I'm not confident touching this code. This is more than a decade
> old, I have no idea what the original motivations were. The possible
> interactions with the user via command-line (-add-fd), QMP (add-fd) and
> the monitor lifetime make me confused. Not to mention the fdset part
> being plumbed into the guts of a widely used qemu_open_internal() that
> very misleadingly presents itself as just a wrapper for open().

If to make QEMU long live, we'll probably need to touch it at some
point.. or at least discuss about it and figure things out. We pay tech
debts like this when there's no good comment / docs to refer in this case,
then the earlier, perhaps also the better.. to try taking the stab, imho.

Definitely not a request to clean everything up. :) Let's see whether
others can chim in with better knowledge of the history.

> 
> >
> > Thanks,
> >
> > =======
> >
> > From 2f6b6d1224486d8ee830a7afe34738a07003b863 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Fri, 3 May 2024 11:27:20 -0400
> > Subject: [PATCH] monitor: Drop monitor_fdset_dup_fd_add()
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > This function is not needed, one remove function should already work.
> > Clean it up.
> >
> > Here the code doesn't really care about whether we need to keep that dupfd
> > around if close() failed: when that happens something got very wrong,
> > keeping the dup_fd around the fdsets may not help that situation so far.
> >
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/monitor/monitor.h |  1 -
> >  monitor/fds.c             | 27 +++++----------------------
> >  stubs/fdset.c             |  5 -----
> >  util/osdep.c              | 15 +--------------
> >  4 files changed, 6 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 965f5d5450..fd9b3f538c 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -53,7 +53,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >                                  const char *opaque, Error **errp);
> >  int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
> >  void monitor_fdset_dup_fd_remove(int dup_fd);
> > -int64_t monitor_fdset_dup_fd_find(int dup_fd);
> >  
> >  void monitor_register_hmp(const char *name, bool info,
> >                            void (*cmd)(Monitor *mon, const QDict *qdict));
> > diff --git a/monitor/fds.c b/monitor/fds.c
> > index d86c2c674c..d5aecfb70e 100644
> > --- a/monitor/fds.c
> > +++ b/monitor/fds.c
> > @@ -458,7 +458,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> >  #endif
> >  }
> >  
> > -static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> > +void monitor_fdset_dup_fd_remove(int dup_fd)
> >  {
> >      MonFdset *mon_fdset;
> >      MonFdsetFd *mon_fdset_fd_dup;
> > @@ -467,31 +467,14 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
> >              if (mon_fdset_fd_dup->fd == dup_fd) {
> > -                if (remove) {
> > -                    QLIST_REMOVE(mon_fdset_fd_dup, next);
> > -                    g_free(mon_fdset_fd_dup);
> > -                    if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> > -                        monitor_fdset_cleanup(mon_fdset);
> > -                    }
> > -                    return -1;
> > -                } else {
> > -                    return mon_fdset->id;
> > +                QLIST_REMOVE(mon_fdset_fd_dup, next);
> > +                g_free(mon_fdset_fd_dup);
> > +                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> > +                    monitor_fdset_cleanup(mon_fdset);
> >                  }
> >              }
> >          }
> >      }
> > -
> > -    return -1;
> > -}
> > -
> > -int64_t monitor_fdset_dup_fd_find(int dup_fd)
> > -{
> > -    return monitor_fdset_dup_fd_find_remove(dup_fd, false);
> > -}
> > -
> > -void monitor_fdset_dup_fd_remove(int dup_fd)
> > -{
> > -    monitor_fdset_dup_fd_find_remove(dup_fd, true);
> >  }
> >  
> >  int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
> > diff --git a/stubs/fdset.c b/stubs/fdset.c
> > index d7c39a28ac..389e368a29 100644
> > --- a/stubs/fdset.c
> > +++ b/stubs/fdset.c
> > @@ -9,11 +9,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> >      return -1;
> >  }
> >  
> > -int64_t monitor_fdset_dup_fd_find(int dup_fd)
> > -{
> > -    return -1;
> > -}
> > -
> >  void monitor_fdset_dup_fd_remove(int dupfd)
> >  {
> >  }
> > diff --git a/util/osdep.c b/util/osdep.c
> > index e996c4744a..2d9749d060 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -393,21 +393,8 @@ int qemu_open_old(const char *name, int flags, ...)
> >  
> >  int qemu_close(int fd)
> >  {
> > -    int64_t fdset_id;
> > -
> >      /* Close fd that was dup'd from an fdset */
> > -    fdset_id = monitor_fdset_dup_fd_find(fd);
> > -    if (fdset_id != -1) {
> > -        int ret;
> > -
> > -        ret = close(fd);
> > -        if (ret == 0) {
> > -            monitor_fdset_dup_fd_remove(fd);
> > -        }
> > -
> > -        return ret;
> > -    }
> > -
> > +    monitor_fdset_dup_fd_remove(fd);
> >      return close(fd);
> >  }
> >  
> > -- 
> > 2.44.0
> 

-- 
Peter Xu


