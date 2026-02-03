Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56094E8B365
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 21:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNpi-0008Dw-6Y; Tue, 03 Feb 2026 16:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnNpg-0008CW-Hn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnNpe-0000jY-Tf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 16:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770153670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H48VXdnFPMaJHa2Hnzwv0sSihlYCUWwyyUap/SYFKQs=;
 b=YmnrfbK4o21/7YOnFx0eA54/uQbpul+tifCMsj/lc1HFRq8JUGKS5EmWDaTVKcLONO3fsd
 I2mTHrqG8szfvadT3eaQylXis1oTHCp6YaSBtAqFd7OzGq842imGgb4fdobuyczZOAZ/Tt
 9JddhOkRDHFv1lASL71UADqIe/TlB60=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-P5Xtw60rPpGtqgCHYhuFKA-1; Tue, 03 Feb 2026 16:21:08 -0500
X-MC-Unique: P5Xtw60rPpGtqgCHYhuFKA-1
X-Mimecast-MFC-AGG-ID: P5Xtw60rPpGtqgCHYhuFKA_1770153668
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso235343736d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770153668; x=1770758468; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H48VXdnFPMaJHa2Hnzwv0sSihlYCUWwyyUap/SYFKQs=;
 b=KPLVow+VQwvWXBsVC81dkZI2tuTa+1HoL0QyP9mJggznCV1EyXiNjdQbQNQKKsyZTw
 SMqH3dIBoOnnySP4HX7G/J2YtnY2Gr1U5hG9zqT6rni5a2vLcpkVnDjjoFZcs9a4LiGP
 avwYFl+IFRwIUfYIvlRQ+RecM5ROUg6a2M7hDae/CH1D0CFFKSJ9+gvmlkFLlJZBBhLL
 uO5fE19hOMCpSDaK8KvpA+1UIsvVi/ImTk0TX5eEtOQ4CaSb4fUe81S66aSOk8gWrNt/
 nTTGUDlwZ58JKbbl+fJiUAo9I/tjWOT2Z2Pvont2q7pIiHnw7ps2exEwsA+PD2X5V+Rm
 E2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153668; x=1770758468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H48VXdnFPMaJHa2Hnzwv0sSihlYCUWwyyUap/SYFKQs=;
 b=pZtCtAV0M7iZ16qkvaB16LlY2JOVJX0fez3LwM6TQ0F0gA+N5dVX/MBjBednXB3Khn
 1+Teffz5JaFpZXYbDG3FksYwDQmbuAnz4ftr6+dgmc3oUjBtjYvwwcXPzC/HNa7uuhJz
 iDyalRCCDRKI+MXFdrFaS30zsoGNRSVGJs/M2UKgzqL42DcZ1OBO/6RBmfVQ/SjSK9Ns
 zSFK6SGnZ1A+iLLO8kv/pqLBZDggTmmn+wX83xJq0wfIr9L3bdkAEqRYXPnOS8QNl9TP
 RCTtJzxu43bxH+k5uwU/7yS1hcBpAVKPYsG3X7W4wo+7ejDsbKVPtit0XbfwUDuzfoar
 ehIw==
X-Gm-Message-State: AOJu0Yw9aMG4zA5Lxwpy4tgEBNIqfJGNBU5dQHaX0f6bFV8ncEbHSSMf
 wIXkSuxbEknB/ghpBHoh9tA3MjwFmnndt5TkDcPfvRTpQ+EjTklEvaiEbrBADRo+O9ITHqsOwDp
 j9uS3T/JYliqyWvDg0GTvRa6mYnDpatGVlxKJNwps31yd3i3BwB2sn/Zc
X-Gm-Gg: AZuq6aKTj1/79JbXXV4hfVBw4KkrzPWMe1vFDL8Dal8KqppMpoyw4Yn/4MsAiloYy0z
 clrqEKpqgy7X3O2q8oD+B4lC4TricOY43juI0apQn9uvi65+DQSqug6lHrSTfON7Cs/t93/AaV8
 UawisV412QisDVoO0OuIuVgiAOK4soiIfI3PUt2jHGDKDIE4Zw6YUV0zmex/dxuJtvTuC49UDDN
 1eRAETHW6R7ZDAzXqKZ+gVK9msH2yzJ7cDjiLrnH8zFelKuSv3TZ+SE6DoVrYZVXl7Liy3Ch7Jc
 s1IKqFoLJDdZsfVsIuZd4HuAx8zSePrsvs8WZvBrCy8l9Iemr4Pk5aB4Wjv8nNhWUhU/NrBGaHZ
 UaoQ=
X-Received: by 2002:ad4:5cab:0:b0:892:69de:236e with SMTP id
 6a1803df08f44-8952212ee62mr14092966d6.22.1770153667775; 
 Tue, 03 Feb 2026 13:21:07 -0800 (PST)
X-Received: by 2002:ad4:5cab:0:b0:892:69de:236e with SMTP id
 6a1803df08f44-8952212ee62mr14092546d6.22.1770153667280; 
 Tue, 03 Feb 2026 13:21:07 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521d1338fsm5441876d6.41.2026.02.03.13.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:21:06 -0800 (PST)
Date: Tue, 3 Feb 2026 16:21:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <aYJmwfQgw0dD7CjD@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
 <aXkk22x1M0k4qZoo@x1.local> <20260130112402.2c008707@penguin>
 <aYCz_se6Ji2g5d_L@x1.local> <20260203101822.00eeeb0f@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203101822.00eeeb0f@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 03, 2026 at 10:18:22AM +0100, Lukas Straub wrote:
> On Mon, 2 Feb 2026 09:26:06 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Jan 30, 2026 at 11:24:02AM +0100, Lukas Straub wrote:
> > > On Tue, 27 Jan 2026 15:49:31 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > >   
> > > > On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote:  
> > > > > +void migration_test_add_colo(MigrationTestEnv *env)
> > > > > +{
> > > > > +    if (!env->has_kvm) {
> > > > > +        g_test_skip("COLO requires KVM accelerator");
> > > > > +        return;
> > > > > +    }    
> > > > 
> > > > I'm OK if you want to explicitly bypass others, but could you explanation
> > > > why?
> > > > 
> > > > Thanks,
> > > >   
> > > 
> > > It used to hang with TCG. Now it crashes, since
> > > migration_bitmap_sync_precopy assumes bql is held. Something for later.  
> > 
> > If we want to keep COLO around and be serious, let's try to make COLO the
> > same standard we target for migration in general whenever possible.  We
> > shouldn't randomly workaround bugs.  We should fix it.
> > 
> > It looks to me there's some locking issue instead.
> > 
> > Iterator's complete() requires BQL.  Would a patch like below makes sense
> > to you?
> > 
> > diff --git a/migration/colo.c b/migration/colo.c
> > index db783f6fa7..b3ea137120 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -458,8 +458,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> >      /* Note: device state is saved into buffer */
> >      ret = qemu_save_device_state(fb);
> >  
> > -    bql_unlock();
> >      if (ret < 0) {
> > +        bql_unlock();
> >          goto out;
> >      }
> >  
> > @@ -473,6 +473,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> >       */
> >      qemu_savevm_live_state(s->to_dst_file);
> >  
> > +    /* Save live state requires BQL */
> > +    bql_unlock();
> > +
> >      qemu_fflush(fb);
> >  
> >      /*
> 
> I already tested that and it works. However, we have to be very careful
> around the locking here and I don't think it is safe to take the bql on
> the primary here:
> 
> The secondary has the bql held at this point:

This is definitely an interesting piece of code... one question:

> 
>     colo_receive_check_message(mis->from_src_file,
>                        COLO_MESSAGE_VMSTATE_SEND, &local_err);
>     ...
>     bql_lock();
>     cpu_synchronize_all_states();

Why this is needed at all? ^^^^^^^^^^^^^^^

The qemu_loadvm_state_main() line right below should only load RAM.  I
don't see how it has anything to do with CPU register states..

>     ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
>     bql_unlock();
> 
> On the primary there is a filter-mirror mirroring incoming packets to
> the secondary filter-redirector. However since the secondary migration
> holds bql the receiving filter is blocked and will not receive anything
> from the socket. Thus filter-mirror on the primary also may get blocked
> during send and block the mainloop (It uses blocking IO).

Hmm... could you explain why a blocking IO operation to mirror some packets
require holding BQL?  This sounds wrong on its own.

> 
> Now if the primary migration thread wants to take the bql it will
> deadlock.
> 
> So I think this is something to fix in a separate series since it is
> more involved.

Yes it might be involved, but this is really not something like "let's make
it simple for now and improve it later".  This is "OK this function
_requires_ this lock, but let's not take this lock and leave it for
later".  It's not something we can put aside, afaiu.  We should really fix
it.

How far do you think we can fix it?  Could you explain the problem better?

It might be helpful if you can reproduce the hang, then attach the logs
from both QEMU on a full thread backtrace dump.  I'll see what I can help.

Thanks,

-- 
Peter Xu


