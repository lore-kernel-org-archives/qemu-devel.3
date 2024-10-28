Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC6FD3E2A0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5V4x-0002iy-Uo; Mon, 28 Oct 2024 15:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5V4v-0002ij-Vi
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5V4t-0008KA-V7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730142418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wa/EtqaDOqMkhpy5tkbQ2tsM3r69rgDwe+lLmDvwiYo=;
 b=JKzG8sPuoZe0t1s1Qfff87IWVknA8j4q5S4bhdqw7evgNS65gchFSjSSn+JmUuz2ukOyeD
 jEnf2Ene2AU6UrBleFHIrKdp1bFIFQfQ+Gqx+P1vxnuFl5Vw0KehUDUr/x6cRu5PJpIgNH
 MI8yvz51KcoAHivViWG5fytS84ze3MQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-6-93lWKpNHW1uVBbxyspUA-1; Mon, 28 Oct 2024 15:06:57 -0400
X-MC-Unique: 6-93lWKpNHW1uVBbxyspUA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b15659b098so732122685a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 12:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142416; x=1730747216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa/EtqaDOqMkhpy5tkbQ2tsM3r69rgDwe+lLmDvwiYo=;
 b=IhC26jVaIhkXmO46Sosd0pCEEd9qmrgN1UhDo8JF0HpgOq9/4sv7CPJsdc4LoB3wix
 NHcOf74CApyWP9Mtv/FnAvecXSO8wKlb2FLn6l3WxGdctS0uyV9O/DKBAS5ANCKcEtug
 JNxRmTi5lMRcEKEmHRf0nyX76kd0zAD3D+bquyz4avIobpmmomxkCI6Vr9ynoXb5QU8K
 2DjKL7PYsMf3U3PUlYNo95f8yEzMgQ37R64TeowCxLKgMzxkdlWZsBzL4MdNoNhOlGOf
 wYHiO+BqitFdQN43I0ElSFXRWpdcJuqONukOlRAD9NfakGcUg3VrPFZQDfe9FsaFJNac
 k/yw==
X-Gm-Message-State: AOJu0YxyElyYEknm2y2IPSJsU6/Cphy+2iS7Hx14LuGOTrp/gpYZuJZK
 DffHLeV3uJfDlKhMO/DRjsWSwMT8O4D+d7GMvKUHK+ax5Zfg2lynECBschmSzBYLdjK5RuGGs1i
 kLuSrqZrNVnUF/GWYmX1SHKoKKTimQICFBbwOpSXnmMAXF/i7WUux
X-Received: by 2002:a05:620a:2a11:b0:79f:15ca:b782 with SMTP id
 af79cd13be357-7b193eff6aemr1202977185a.35.1730142416312; 
 Mon, 28 Oct 2024 12:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8lorQ+S4cUfo5/S1tgWMogj+DhEm2us7XRJBYRg0/OjY+gv8iuGEUB2jpXX4vTPXt4y23ig==
X-Received: by 2002:a05:620a:2a11:b0:79f:15ca:b782 with SMTP id
 af79cd13be357-7b193eff6aemr1202974685a.35.1730142415939; 
 Mon, 28 Oct 2024 12:06:55 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d27a9ffsm349503185a.23.2024.10.28.12.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 12:06:55 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:06:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
Message-ID: <Zx_gzdJ549ApAiBp@x1n>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com>
 <Zx-xpZzYG_1KuCQu@x1n>
 <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com>
 <Zx_C0hrRZK34qc7I@x1n>
 <a96a8f31-ef8d-48b5-999c-8ca8a917f3c1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a96a8f31-ef8d-48b5-999c-8ca8a917f3c1@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 07:20:27PM +0200, Avihai Horon wrote:
> 
> On 28/10/2024 18:58, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:
> > > On 28/10/2024 17:45, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
> > > > > On 25/10/2024 0:30, Peter Xu wrote:
> > > > > > External email: Use caution opening links or attachments
> > > > > > 
> > > > > > 
> > > > > > We have two outside users of this API, so it's exported.
> > > > > > 
> > > > > > Is it really necessary?  Does it matter whether it must be
> > > > > > ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
> > > > > Actually for VFIO it does matter, because we don't want VFIO to do DPT
> > > > > log_sync in SETUP stage when DPT might not have been started yet.
> > > > > See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
> > > > > SETUP state").
> > > > This seems to be a known issue for migration in general, rather than VFIO
> > > > specific.  Hyman has a patch for it, not yet reviewed..
> > > > 
> > > > https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com
> > > > 
> > > > That corresponds to your comment here:
> > > > 
> > > >       Redundant -- all RAM is marked dirty in migration SETUP state and is
> > > >       transferred only after migration is set to ACTIVE state, so doing
> > > >       log_sync during migration SETUP is pointless.
> > > > 
> > > > So I wonder whether it's only VFIO that should skip it, or log_sync()
> > > > simply shouldn't be called at all during SETUP, because of its redundancy.
> > > Not sure why this sync was there in the first place, but if its only purpose
> > > was to sync dirty pages then yes, I guess it be dropped.
> > > 
> > > > The other thing you mentioned here:
> > > > 
> > > >       Can fail -- there is a time window, between setting migration state to
> > > >       SETUP and starting dirty tracking by RAM save_live_setup handler, during
> > > >       which dirty tracking is still not started. Any VFIO log_sync call that
> > > >       is issued during this time window will fail. For example, this error can
> > > >       be triggered by migrating a VM when a GUI is active, which constantly
> > > >       calls log_sync.
> > > > 
> > > > This is VFIO specific.  Why this can fail even if global tracking is
> > > > started already?
> > > It can fail if global tracking is *not* started yet.
> > > As mentioned in the commit message, there is a time window where migration
> > > is in SETUP state but global tracking is not started yet.
> > Hmm, I'm totally confused now..
> > 
> > The only thing that can kickoff the sync during SETUP, AFAICT, is:
> > 
> >              ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
> >              if (!ret) {
> >                  goto out_unlock;
> >              }
> >              migration_bitmap_sync_precopy(false);   <------------- here
> > 
> > I need to confess this may not be the right place to invoke it in ram.c (I
> > think we probably should move it out at some point.. into generic migration
> > code).  However I don't yet see why log_start() is not called first in your
> > case before log_sync().
> > 
> > Could you elaborate?
> 
> Indeed, in the above code log_start is called before log_sync.
> 
> I was referring to the case where some other code path triggers log_sync.
> E.g., if you open a VNC to the guest then it constantly calls log_sync to
> refresh the graphics. In that case, one of these log_syncs can happen
> between "migration status is set to SETUP" and "global tracking is started".

I see.  That's unfortunate..

Though this is also the case where it shouldn't be VFIO's problem alone.
See some other users of log_sync():

vhost_sync_dirty_bitmap():
    if (!dev->log_enabled || !dev->started) {
        return 0;
    }

kvm_slot_get_dirty_log():
    if (ret == -ENOENT) {
        /* kernel does not have dirty bitmap in this slot */
        ret = 0;
    }

And I didn't further look.

In short, IMHO looks like VFIO still shouldn't be special on differeciating
and make migration export the SETUP phase just for this..  as VFIO has
log_start() like all the rest, so VFIO can also know whether tracking is
enabled at all, then it can silently no-op the log_sync() like all the rest
of the users.

If you agree, I'd prefer we keep this patch - it'll be nice we only ever
expose migration_is_running() for migration status checks, without exposing
SETUP only for this VFIO use case even if it could have followed what other
modules are doing.

If you would like to propose a patch for VFIO, I'd be happy to include your
patch before this patch (just in case this patch could land some day) to
make sure VFIO works as before.  Since I don't have VFIO HW to test, it'll
be challenging for me to propose and test such patch otherwise.

Thanks,

-- 
Peter Xu


