Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2418CC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vibdH-00017J-4L; Wed, 21 Jan 2026 12:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vibcZ-0000jm-Ko
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vibcV-0007PD-3D
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769015029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmB+3iDGL6sluAIJYig+j1M0Ob/rKc+ILTgUgmoKvW8=;
 b=OamPYwtNG80xth8aauyY1nYhoZJTWn+pzYNUesCc8HUEwR7aOetzVw5Se/esbVxunVNub6
 PuakxHUm/7KF44Eyz7j1PaweO/l4/PHGF8Y35YfIpphd5wZxA4QJwD/tY77+oIDN0CMhEm
 LbXcgLZumCm18ZU1zqMRYr3Ddzw3vq0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-mYDLLOq1ND2uEuyRFbbMqg-1; Wed, 21 Jan 2026 12:03:47 -0500
X-MC-Unique: mYDLLOq1ND2uEuyRFbbMqg-1
X-Mimecast-MFC-AGG-ID: mYDLLOq1ND2uEuyRFbbMqg_1769015027
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-894766748f9so4268656d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769015027; x=1769619827; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RmB+3iDGL6sluAIJYig+j1M0Ob/rKc+ILTgUgmoKvW8=;
 b=Xg9jicPjKfXJzNEnHTk/MXN9E4PwSL7c9m/97Or5J92p4zevL2ay7oPEMXjL1R8eYq
 x5CZL4qVz1kBlXF5eaWHyS2q09wYhIx8uL/3o6X3KqbcVuJU8ChIs03PxUDu+RveotJR
 OKVhYkoXJRo2wEUBv4LKD5tUXoAs9c2+e8TYzK3q81ZrEKbXJpg1Y/fKj+DU5N6Drp6l
 8mV/WbfgtzwbqO5ER2v5Se87om5/pPJhSYkW5xaQQGetcv4AwUSoIZBcQPtCSiQ3rcOS
 eSkU7EUQ9fkLR4MTxIEoz1RYaqpRsup+V3YAZB1E6awMxGgXoDq91HpeiWbEvkybhmlE
 B4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015027; x=1769619827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmB+3iDGL6sluAIJYig+j1M0Ob/rKc+ILTgUgmoKvW8=;
 b=opxHT2Kby1kcv2T7DLlPljFB9MhFyGwJgAV8DWSnADt8FWMBGFQhJj6BEa4x6l2k+v
 yTc5U/oG5VLiak6l6N6/WYXfd+K93gQCQGUXC6JUjt8kp6MwvwO9wOPyRPmKDQ6Edu4g
 a58IZh50WoXx8iCwgwtKgEHnMPaMu6xHXnAVyblRYe63qjUbN/rWFH0u6Eejsg61roLX
 njvMdn12ehHg1Y0avBuEmWZ4qEXT8Jqd2fKi9AtjwaYlCCEmh3zHBVKRnYTt83A02Jbc
 Cx/F6Ebh+0WFSF1w6GGJTVY2izbFA47XEheoNdrhHlPK5oz2WYkDLVFSwWgn3qS8zV2m
 wiQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWc5DswZrXrzB/kBF6cmL6xb/klqwUp0+OzmI5TCXhjrAy0RKOUT+EwvDYVBIB2URtEafPqer/hoV@nongnu.org
X-Gm-Message-State: AOJu0YxUlkY4BveVmTGK7QMJSUVFucVfuRNXqrSguRtR8aQuuWeI/yLb
 9N6Z2lfBa9yWBOxjstnNdyNX4SNx1KhXu40y/FNmjdYXMikQO0ccmPwUTby6esitpYDhF1mjaIW
 4uWDnbsDHN9Sr5igcdFpyonRUvW6Xm4niEDKrb180GaOjVUCP/raWEV1Y
X-Gm-Gg: AZuq6aLvYkcUzvEEVgCp0cKcwiIR/IPlKDl/fOuUSsiqSRNHrHcroVKhvRC1PN+XbQg
 0fObYsGvUziZMHuSJeyHwavsLaAVSY+mUd0n4/BTT8xaOLT4aDVC6xCSh55p5/X5+HOBgpNBfFT
 MwLhEKzW5hCxOWWkIW518053fExoMau5jPVVUeTVdDvJYDvQWJCMY7ffnG7w73QedrUjZZI5fcG
 /C0bZLerLvE+BlvtE4k5SV1Ux/mc+tHBkD/Gx3jQt/HDt/nyo4dcQOpTDRfE3Vw1pFYNBlYIyKg
 Eu3YQXn3iZjrXTRIRRtxVsyusQoVxh/nP9OKyF0nxDWnyYZnwW7N92hBTFjHGUexTrML7nLu/nG
 EQfQ=
X-Received: by 2002:a05:6214:2689:b0:880:54e2:3517 with SMTP id
 6a1803df08f44-8942e420d10mr256154446d6.12.1769015026449; 
 Wed, 21 Jan 2026 09:03:46 -0800 (PST)
X-Received: by 2002:a05:6214:2689:b0:880:54e2:3517 with SMTP id
 6a1803df08f44-8942e420d10mr256153616d6.12.1769015025708; 
 Wed, 21 Jan 2026 09:03:45 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1d9f4b9sm117808411cf.9.2026.01.21.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:03:45 -0800 (PST)
Date: Wed, 21 Jan 2026 12:03:43 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aXEG73I8tJyhpn69@x1.local>
References: <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
 <aW6xNcsz3RIqHeE5@x1.local> <20260120110811.7df19a6c@penguin>
 <aW-mCye_eFmy5f4B@x1.local> <aW_Rqbc2Swg8vkXY@gallifrey>
 <aW_ccMSY4xJlRVn2@x1.local> <aXArDHMRAohmUt51@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXArDHMRAohmUt51@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 21, 2026 at 01:25:32AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Jan 20, 2026 at 07:04:09PM +0000, Dr. David Alan Gilbert wrote:
> 
> <snip>
> 
> > > >   (2) Failure happens _after_ applying the new checkpoint, but _before_ the
> > > >       whole checkpoint is applied.
> > > > 
> > > >       To be explicit, consider qemu_load_device_state() when the process of
> > > >       colo_incoming_process_checkpoint() failed.  It means SVM applied
> > > >       partial of PVM's checkpoint, I think it should mean PVM is completely
> > > >       corrupted.
> > > 
> > > As long as the SVM has got the entire checkpoint, then it *can* apply it all
> > > and carry on from that point.
> > 
> > Does it mean we assert() that qemu_load_device_state() will always success
> > for COLO syncs?
> 
> Not sure; I'd expect if that load fails then the SVM fails; if that happens
> on a periodic checkpoint then the PVM should carry on.

Hmm right, if qemu_load_device_state() failed, likely PVM is still alive.

> 
> > Logically post_load() can invoke anything and I'm not sure if something can
> > start to fail, but I confess I don't know an existing device that can
> > trigger it.
> 
> Like a postcopy, it shouldn't fail unless there's an underlying failure
> (e.g. storage died)

Postcopy can definitely fail at post_load()..  Actually Juraj just fixed it
for 10.2 here so postcopy can now fail properly while save/load device
states (we used to hang):

https://lore.kernel.org/r/20251103183301.3840862-1-jmarcin@redhat.com

The two major causes that can fail postcopy vmstate load that I hit (while
looking at bugs after you left; I wished you are still here!):

(1) KVM put() failures due to kernel version mismatch, or,

(2) virtio post_load() failures due to e.g. virtio feature unsupported.

Both of them fall into "unsupported dest kernel version" realm, though, so
indeed it may not affect COLO, as I expect COLO should have two hosts to
run the same kernel.

> 
> > Lukas told me something was broken though with pc machine type, on
> > post_load() not re-entrant.  I think it might be possible though when
> > post_load() is relevant to some device states (that guest driver can change
> > between two checkpoint loads), but that's still only theoretical.  So maybe
> > we can indeed assert it here.
> 
> I don't understand that non re-entrant bit?

It may not be the exact wording, the message is here:

https://lore.kernel.org/r/20260115233500.26fd1628@penguin

        There is a bug in the emulated ahci disk controller which crashes
        when it's vmstate is loaded more than once.

I was expecting it's a post_load() because normal scalar vmstates should be
fine to be loaded more than once.  I didn't look deeper.

> 
> > > 
> > > > Here either (1.b) or (2) seems fatal to me on the whole high level design.
> > > > Periodical syncs with x-checkpoint-delay can make this easier to happen, so
> > > > larger windows of critical failures.  That's also why I think it's
> > > > confusing COLO prefers more checkpoints - while it helps sync things up, it
> > > > enlarges high risk window and overall overhead.
> > > 
> > > No, there should be no point at which a failure leaves the SVM without a checkpoint
> > > that it can apply to take over.
> > > 
> > > > > > > I have quite a few more performance and cleanup patches on my hands,
> > > > > > > for example to transfer dirty memory between checkpoints.
> > > > > > >   
> > > > > > > > 
> > > > > > > > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > > > > > > > should be when heartbeat gets lost; that normally should happen when two
> > > > > > > > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > > > > > > > there's no migration happening, only the src recording what has changed.
> > > > > > > > Hence I think some number with description of the measurements may help us
> > > > > > > > understand how important multifd is to COLO.
> > > > > > > > 
> > > > > > > > Supporting multifd will cause new COLO functions to inject into core
> > > > > > > > migration code paths (even if not much..). I want to make sure such (new)
> > > > > > > > complexity is justified. I also want to avoid introducing a feature only
> > > > > > > > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > > > > > > > it'll be useful".  
> > > > > > > 
> > > > > > > What COLO needs from migration at the low level:
> > > > > > > 
> > > > > > > Primary/Outgoing side:
> > > > > > > 
> > > > > > > Not much actually, we just need a way to incrementally send the
> > > > > > > dirtied memory and the full device state.
> > > > > > > Also, we ensure that migration never actually finishes since we will
> > > > > > > never do a switchover. For example we never set
> > > > > > > RAMState::last_stage with COLO.
> > > > > > > 
> > > > > > > Secondary/Incoming side:
> > > > > > > 
> > > > > > > colo cache:
> > > > > > > Since the secondary always needs to be ready to take over (even during
> > > > > > > checkpointing), we can not write the received ram pages directly to
> > > > > > > the guest ram to prevent having half of the old and half of the new
> > > > > > > contents.
> > > > > > > So we redirect the received ram pages to the colo cache. This is
> > > > > > > basically a mirror of the primary side ram.
> > > > > > > It also simplifies the primary side since from it's point of view it's
> > > > > > > just a normal migration target. So primary side doesn't have to care
> > > > > > > about dirtied pages on the secondary for example.
> > > > > > > 
> > > > > > > Dirty Bitmap:
> > > > > > > With COLO we also need a dirty bitmap on the incoming side to track
> > > > > > > 1. pages dirtied by the secondary guest
> > > > > > > 2. pages dirtied by the primary guest (incoming ram pages)
> > > > > > > In the last step during the checkpointing, this bitmap is then used
> > > > > > > to overwrite the guest ram with the colo cache so the secondary guest
> > > > > > > is in sync with the primary guest.
> > > > > > > 
> > > > > > > All this individually is very little code as you can see from my
> > > > > > > multifd patch. Just something to keep in mind I guess.
> > > > > > > 
> > > > > > > 
> > > > > > > At the high level we have the COLO framework outgoing and incoming
> > > > > > > threads which just tell the migration code to:
> > > > > > > Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> > > > > > > paired with a qemu_loadvm_state_main on the incoming side.
> > > > > > > Send the device state (qemu_save_device_state()) paired with writing
> > > > > > > that stream to a buffer on the incoming side.
> > > > > > > And finally flusing the colo cache and loading the device state on the
> > > > > > > incoming side.
> > > > > > > 
> > > > > > > And of course we coordinate with the colo block replication and
> > > > > > > colo-compare.  
> > > > > > 
> > > > > > Thank you.  Maybe you should generalize some of the explanations and put it
> > > > > > into docs/devel/migration/ somewhere.  I think many of them are not
> > > > > > mentioned in the doc on how COLO works internally.
> > > > > > 
> > > > > > Let me ask some more questions while I'm reading COLO today:
> > > > > > 
> > > > > > - For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
> > > > > >   do the following:
> > > > > > 
> > > > > >     bql_lock()
> > > > > >     vm_stop_force_state(RUN_STATE_COLO)     # stop vm
> > > > > >     bql_unlock()
> > > > > > 
> > > > > >     ...
> > > > > >   
> > > > > >     bql_lock()
> > > > > >     qemu_save_device_state()                # into a temp buffer fb
> > > > > >     bql_unlock()
> > > > > > 
> > > > > >     ...
> > > > > > 
> > > > > >     qemu_savevm_state_complete_precopy()    # send RAM, directly to the wire
> > > > > >     qemu_put_buffer(fb)                     # push temp buffer fb to wire
> > > > > > 
> > > > > >     ...
> > > > > > 
> > > > > >     bql_lock()
> > > > > >     vm_start()                              # start vm
> > > > > >     bql_unlock()
> > > > > > 
> > > > > >   A few questions that I didn't ask previously:
> > > > > > 
> > > > > >   - If VM is stopped anyway, why putting the device states into a temp
> > > > > >     buffer, instead of using what we already have for precopy phase, or
> > > > > >     just push everything directly to the wire?
> > > > > 
> > > > > Actually we only do that to get the size of the device state and send
> > > > > the size out-of-band, since we can not use qemu_load_device_state()
> > > > > directly on the secondary side and look for the in-band EOF.
> > > > 
> > > > I also don't understand why the size is needed..
> > > > 
> > > > Currently the streaming protocol for COLO is:
> > > > 
> > > >   - ...
> > > >   - COLO_MESSAGE_VMSTATE_SEND
> > > >   - RAM data
> > > >   - EOF
> > > >   - COLO_MESSAGE_VMSTATE_SIZE
> > > >   - non-RAM data
> > > >   - EOF
> > > > 
> > > > My question is about, why can't we do this instead?
> > > > 
> > > >   - ...
> > > >   - COLO_MESSAGE_VMSTATE_SEND
> > > >   - RAM data
> > 
> > [1]
> > 
> > > >   - non-RAM data
> > > >   - EOF
> > > > 
> > > > If the VM is stoppped during the whole process anyway..
> > > > 
> > > > Here RAM/non-RAM data all are vmstates, and logically can also be loaded in
> > > > one shot of a vmstate load loop.
> > > 
> > > You might be able to; in that case you would have to stream the 
> > > entire thing into a buffer on the secondary rather than applying the
> > > RAM updates to the colo cache.
> > 
> > I thought the colo cache is already such a buffering when receiving at [1]
> > above?  Then we need to flush the colo cache (including scan the SVM bitmap
> > and only flush those pages in colo cache) like before.
> > 
> > If something went wrong (e.g. channel broken during receiving non-ram
> > device states), SVM can directly drop all colo cache as the latest
> > checkpoint isn't complete.
> 
> Oh, I think I've remembered why it's necessary to split it into RAM and non-RAM;
> you can't parse a non-RAM stream and know when you've got an EOF flag in the stream;
> especially for stuff that's open coded (like some of virtio);   so there's

Shouldn't customized get()/put() will at least still be wrapped with a
QEMU_VM_SECTION_FULL section?

> no way to write a 'load until EOF' into a simple RAM buffer; you need to be
> given an explicit size to know how much to expect.
> 
> You could do it for the RAM, but you'd need to write a protocol parser
> to follow the stream to watch for the EOF.  It's actuallly harder with multifd;
> how would you make a temporary buffer with multiple streams like that?

My understanding is postcopy must need a buffer because postcopy needs page
request to work even during loading vmstates.  I don't see it required for
COLO, though..

I'll try to see if I can change COLO to use the generic precopy way of
dumping vmstate, then I'll know if I missed something, and what I've
missed..

Thanks,

-- 
Peter Xu


