Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E4ACCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 11:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wImC3-0003fN-MH; Fri, 01 May 2026 07:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wImC1-0003eL-SK
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wImC0-0004i4-2w
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777635477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fi/BnHEBuV++gRvn5bhWIZb+uewOnahMhmLCl+TtdGk=;
 b=Mzi7/nKvlceaeLAhIIec9vi7jaBHFGhEb9OzYKS4epyg9Ry+T6X5iBVveerJGsvRnmmVDx
 4ZZBkWKiooCvjFwVgkWDiWetRpRk2+y5+TTx+3WyBA3cjBqZMEOyFsm/8xj0bqNKA0m5G/
 rGcfzo60QmnLD2sGuSdrYIZ02h1jl3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-z-4CHzrzP3uwBHtSfnVy8Q-1; Fri, 01 May 2026 07:37:56 -0400
X-MC-Unique: z-4CHzrzP3uwBHtSfnVy8Q-1
X-Mimecast-MFC-AGG-ID: z-4CHzrzP3uwBHtSfnVy8Q_1777635475
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48919890a95so12844385e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777635475; x=1778240275; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fi/BnHEBuV++gRvn5bhWIZb+uewOnahMhmLCl+TtdGk=;
 b=leT2VhCMjSm39ulVhVj6pV5XhlK71yAt5hm9/js8abtlLGj8IdyxU5Zv4yN3ZIWiDy
 RMh0knaBk5622niJ99cDc3rtx48l0RTLKS6cCNgfrPWa1sHQ7Yrytk7pvZfwwKxrbGzX
 FpdepvLgt2/iqZW48GTWIfcHkHkZYnPsSihkzfu6bktYSOpfjYx/ZTToRpXqeICNbaDA
 pgHe+Jjtiydmtz3cmrvXgGQogCC+iD/+630uTNuNCGnr4wO3i4LUwBDNIoMSmJ+HTaYG
 MT1ddTpi5dYVU7xB6uH02wXy06uH5oxG1/zKKD+s+WUPfB2zzc6A/QCXfi3Ay8rqU/MG
 MyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777635475; x=1778240275;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fi/BnHEBuV++gRvn5bhWIZb+uewOnahMhmLCl+TtdGk=;
 b=L1avvSH6TED23i8lZYE3xneg4i2zyPcEtb87OFZe/LEQbN4d7zpP2YXf42ueP8g6UW
 RE26lm17210Lm+neW8Dpir5FW7KFc/IRnGysMnUsavG8wxRrDF0LdhG03/oubYq/KqSl
 K5N+le+znW3rc1/bafh6cNfJXy5gJOgJiHFQhc0HzRf56sYOJMfZNHvJ/uKBMsDVcRQz
 21NRDzRUtT9k2JI4jOrXWfmat4R3FPtaSrhdV67UMYrE2EomKjc6bkjgAaXx81ORkhAa
 9lginDFV9w3D+UDRhZqXKlopJJhdGglS1hv5nDKCrxJ+IiSG5Vb0d2KpFKSJ+Jx5Qovg
 x6wQ==
X-Gm-Message-State: AOJu0Yx3nzr+t9qbVNuO5UZZFcruzbBOh9n+q4g7Vc+Rs7TPxYprZojj
 sUYkNQFL8GpAIFdq3ovs12kfn63h/wcXQxoTpGeVQB5uEfcUJhDa82HZEouMuC5dVOHJIRI/jQB
 ZSf58Kcm8JwdxQtdqx3VqmpKuSopcdsHoww7o/5VAZXMoDKu0tbTP7gPE
X-Gm-Gg: AeBDievbshti+abq9Gl0wZmxu9FDCaM0lXhQMWCTbvo4FRYwgWS5uZcsbL5pL9cxxqq
 SrI54a6QABsqa+gu5f5d4QKqcHojg9eqwX9cFs8L9475Fcd99jHPQixSLNh4c14IdJhTSRALcja
 weEXrPXJlQjprB0S5gAbmL6skbWekOH2KlP0sHEsaVN+H7pO03hp0lHSEiLIHeVnfAun0sMFvui
 ogciSl+7KHczvcVVP0QFo0fk4efrKjKdW/SFSDONAqEsTYrzv97i9IQkBrDoWn0Oc4ZGPgahKf0
 aWVuL7f8FevgBw+z0wfgKiXpYWIheCKubW8m1Ojdvg4Fv1oLaqrGyYWY7yvpP46i8DBrAW24wXM
 YIKpq6B7PvFAzNu8/NkyEHIvtYRrNyCStgsf9P9RKmi4zoEF5ZwcjN0eA
X-Received: by 2002:a05:600c:a310:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48a84460fcbmr85423425e9.29.1777635475259; 
 Fri, 01 May 2026 04:37:55 -0700 (PDT)
X-Received: by 2002:a05:600c:a310:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48a84460fcbmr85423065e9.29.1777635474738; 
 Fri, 01 May 2026 04:37:54 -0700 (PDT)
Received: from fedora (193-179-61-20.customers.tmcz.cz. [193.179.61.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fea7de6sm11535775e9.12.2026.05.01.04.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 04:37:54 -0700 (PDT)
Date: Fri, 1 May 2026 13:37:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH] migration: Synchronize CPUs sooner in postcopy
 switchover phase
Message-ID: <afSPcy_9WZfpOztU@fedora>
References: <20260423154525.10292-1-jmarcin@redhat.com>
 <afJg6VzsaslzZQW1@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afJg6VzsaslzZQW1@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter,

On 2026-04-29 15:50, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 05:45:20PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Previously, the post init CPU synchronization with the accelerator, like
> > KVM, was performed in the bottom half of the POSTCOPY_RUN command
> > handler. However, this causes several problems.
> > 
> > First issue is that if CPU synchronization fails, the destination QEMU
> > crashes. However, it is too late to recover the source side as the
> > response to special PING has been already sent, and both sides are
> > already in the POSTCOPY_ACTIVE state.
> > 
> > By moving synchronization before responding, if the machine crashes, the
> > response is never sent and the source side can resume from the
> > POSTCOPY_DEVICE state.
> > 
> > Second issue is caused when migration is paused due to a network
> > failure or user command right after transitioning to the POSTCOPY_ACTIVE
> > state and the CPU synchronization causes a page fault. This page fault
> > blocks the CPU and the main QEMU threads and cannot be resolved until
> > postcopy migration is recovered. However, as libvirt also tries to
> > execute 'cont' QMP command at this time (destination side transitions
> > from POSTCOPY_DEVICE to POSTCOPY_ACTIVE), it will also halt waiting for
> > the response from the blocked main QEMU thread, unaware of the fact that
> > the migration is paused and needs to be recovered. Thus, it will wait
> > indefinitely and never report postcopy migration error.
> > 
> > When the CPU synchronization happens sooner, and the network fails
> > during it, the source side can transition from POSTCOPY_DEVICE to FAILED
> > state and resume safely. If migration is paused later, the main thread
> > won't be blocked by CPU synchronization and can respond to libvirt.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> > I am posting this as RFC to discuss the point at which the CPU
> > synchronization should happen.
> > 
> > For the POSTCOPY_DEVICE state to be effective, this synchronization must
> > happen before the destination machine responds to the special PING
> > command. This leaves us with 2 options:
> > 
> > 1) In the PING command handler before responding to the specific
> >    request, as proposed in this patch.
> > 
> > 2) After loading CPU VMSD, for example in the post_load hook.
> > 
> > The first solution limits the number of places where synchronization
> > needs to happen, however, having it in the PING command handler feels
> > somewhat hacky.
> 
> Yes.
> 
> > 
> > I have also tested the second solution, and while it seems natural to
> > synchronize the CPU after its data is loaded in the post_load, there are
> > multiple CPU types and VMSDs and each one would need to call
> > synchronization in its post_load hook. This would basically revert Jan
> > Kiszka's commit [1] which refactored CPU synchronization and united it
> > to one place.
> 
> What I was thinking is not reverting all of it, but only removing the
> migration relevant paths for post_init().
> 
> For example, we have different reasons to sync CPU, and we have two
> directions to do that (from/to kernel, in KVM's context). For migration,
> what used to be confusing is why we need to have CPU specific post_init()
> hooks when each CPU has VMSD and post_load() on its own.
> 
> The other one is on savevm side (cpu_synchronize_all_states()) and we can
> at least keep it as-is for now, simplify the discussion.
> 
> So if we want to move this into any of such post_load(), it means removal
> of three call sites of post_init() only in migration/savevm.c, then do
> per-CPU's post_init() in its post_load() hook.
> 
> I don't know the real answer of this one; I recall you tried it out but hit
> some ARM specific issue.  Just to want to make sure we're on the same page
> on what you have experimented.

I thought I did, however, that ARM issue in the CI turned out to be
unrelated.

> 
> Said that, I do see some complexity over such a change already.  For
> example, cpu_vmstate_register() seems to be able to register more than one
> VMSDs for each vCPU.  I don't know if it means at least we can't simply put
> it into post_load() of vmstate_cpu_common, as when reaching there it is not
> guaranteed that all vCPUs' registers are uptodate..
> 
> Besides..
> 
> I do have another thought, though, to avoid the hacky part of this patch
> and looks pretty safe: dest QEMU does not reply directly to the
> QEMU_VM_PING_PACKAGED_LOADED ping, instead it sets a flag. Then we move the
> conditional PONG into loadvm_postcopy_handle_run().
> 
> With that, we can move post_init() into loadvm_postcopy_handle_run()
> altogether.
> 
>   loadvm_postcopy_handle_run():
>     ...
>     cpu_synchronize_all_post_init();
>     if (package_loaded_ping_received) {
>         send_pong();
>     }
>     migrate_set_state(POSTCOPY_DEVICE, POSTCOPY_ACTIVE);
>     migration_bh_schedule(mis);
> 
> Would this work?

Interesting idea, I think it should work, but I am a bit unsure about
delaying the PONG response in such way, if it could potentially break
anything.

Thank you!

Best regards,

Juraj Marcin

> 
> -- 
> Peter Xu
> 


