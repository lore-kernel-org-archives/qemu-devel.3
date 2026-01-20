Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FDBD2629C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 19:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viHk4-0007rg-MK; Tue, 20 Jan 2026 14:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viHk3-0007q4-3t
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viHjz-0008DR-OE
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768938614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3jjx0CIlBUPCqqzYjIepdIOMGu5t6mKIG7ztUv7WsA=;
 b=bvi0/0W+2Lc2cdOG41wDeZ2nujNcYnlSlobAmow3/uN3q3jvTvm/zFaqh5DUprV7jMyXmi
 kp5ZYMY/hREWkZHZHgomy3DG+0Y4Nt5Hhf0S9W/sQrqTSqJIuLCE9BE3GSxPOGqBwqFoIB
 +jdLMWMiKlvwkpav3CDur7MDWTD5yjU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-_fE27ExRO2m52Kqx1K8E_Q-1; Tue, 20 Jan 2026 14:50:12 -0500
X-MC-Unique: _fE27ExRO2m52Kqx1K8E_Q-1
X-Mimecast-MFC-AGG-ID: _fE27ExRO2m52Kqx1K8E_Q_1768938612
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8887c0d3074so149475406d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768938612; x=1769543412; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i3jjx0CIlBUPCqqzYjIepdIOMGu5t6mKIG7ztUv7WsA=;
 b=ZGXLsIvHtnbCzrR9R1ORn6q706dtgLxuvM1ctYl0qlVioNQCHtPevCasasqJ42jU5H
 RVjl7MjWPYsWjjq6tcWoq/9QC0KE2eXs1Hm9tXAhAEGNx9b8AnUp0YV8WUFtEiamhBLP
 K3nnV/w7qAkQiVEUR6EQ20+oF/Gtny4aCILRJXRxCmspg7N3x+GcKkO/udJXzvr+AABL
 fFaRLxxnGvqIMZCGw0907tMj96kzddSljT54Um6hSzf+jdwUVwX0OgqWxdZWhWU+WT4+
 J9dwnqG8/lt75XCfdGRrLKyYXS1Jp2ZSF7WIgtZwgZ/gwRLS1NZ/82Hc8rTl0I4n6xj3
 MWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938612; x=1769543412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3jjx0CIlBUPCqqzYjIepdIOMGu5t6mKIG7ztUv7WsA=;
 b=TR6G06uAl6xFuOrKCMgO1Cu6wU0icum86buzLGi0BqCCZ8OSDqdow+QWOXESojbd5I
 Q851SDopQBvvvmLfOilw4HkDhFG9lmM+ccBCcqRhmXcg0KMSsN7w8lfjXnQmlAKRoLqE
 bHcVMyJfvYCuu52J2mT6xIx61ewMtfa9Q2Pwq5bugZpDfe1x1ECAfNGqYs8WP3n7NfgE
 2CepdOUB0w0S+I2eZjRLPqIzxxg/xHwOFwWMYKXfHjL7mQnWZ9KXDXdx5BUIfLYWqAns
 SgjRuyfzQqwvQ8s9dDWaAWsWa4VmupqbOsYR5d58NqXKIdWvU9muxezciZ1NAGaU5NfN
 xeWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtW7FCCz8M4uEZ7z2LzlE+ONo6oeXM9jkSpUMe6rGlUgQxklnS8/huxDkwTX/LiI146SpK0LO90xFV@nongnu.org
X-Gm-Message-State: AOJu0Yxgbh/IUcRHTQYNWVE3ehx/yxFeDEivTePVQfmEfQuBwDyBEUEK
 EC9/opahB6EPCJ8fL3V7eFO0zqjJb3GJBA5StDBZhsp/94XAb/WdnG3Frrm6EjRwU12q1+eiB8m
 ILMnQzUBD4xS1OZpibQi/TashO+67Lnd0DiGOFdk2kFtQ2JUODhThS9En
X-Gm-Gg: AZuq6aLXryyK36M/44ei/O8hWCGYih618FJpzITfbgDEPZpjo41ZZndOh5xcaGf/pmH
 ekZ7E8ah6H5sUiTRk/kZf6+IoT1brG7DNmisk7H0yFWkTip+CMYy0iaXcFXXhz+L0qx6RmAHWmZ
 fc3Lee82T0HiuKAXblAq5qkEmbOlYfxAhWVvg5fsy0F9AOp1zg+di0xEN16Crkrk5DxFgptW9Iv
 irVv/nTr4Nw8QmZNo1rXw9I+mlBCN4/dNNRLn6oTmB8S60w4YbKncx8Qy3TzS5+jiXG7cz6SWtD
 jnAAnpxCTQ2dUceiTI1SJdGNWLFBhBwOJTd8LITianzssrdt+lUmjwMVepaYENvtsRRXhGvJpnQ
 hO3Q=
X-Received: by 2002:a05:6214:e65:b0:890:6603:f258 with SMTP id
 6a1803df08f44-89463837511mr41705406d6.12.1768938611772; 
 Tue, 20 Jan 2026 11:50:11 -0800 (PST)
X-Received: by 2002:a05:6214:e65:b0:890:6603:f258 with SMTP id
 6a1803df08f44-89463837511mr41704686d6.12.1768938610736; 
 Tue, 20 Jan 2026 11:50:10 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a725eb16sm1106643485a.36.2026.01.20.11.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:50:10 -0800 (PST)
Date: Tue, 20 Jan 2026 14:50:08 -0500
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
Message-ID: <aW_ccMSY4xJlRVn2@x1.local>
References: <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
 <aW6xNcsz3RIqHeE5@x1.local> <20260120110811.7df19a6c@penguin>
 <aW-mCye_eFmy5f4B@x1.local> <aW_Rqbc2Swg8vkXY@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aW_Rqbc2Swg8vkXY@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
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

On Tue, Jan 20, 2026 at 07:04:09PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Jan 20, 2026 at 12:48:47PM +0100, Lukas Straub wrote:
> > > On Mon, 19 Jan 2026 17:33:25 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > On Sat, Jan 17, 2026 at 08:49:13PM +0100, Lukas Straub wrote:
> > > > > On Thu, 15 Jan 2026 18:38:51 -0500
> > > > > Peter Xu <peterx@redhat.com> wrote:
> > > > >   
> > > > > > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:  
> > > > > > > * Peter Xu (peterx@redhat.com) wrote:    
> > > > > > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:    
> > > > > > > > > Nack.
> > > > > > > > > 
> > > > > > > > > This code has users, as explained in my other email:
> > > > > > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464    
> > > > > > > > 
> > > > > > > > Please then rework that series and consider include the following (I
> > > > > > > > believe I pointed out a long time ago somewhere..):
> > > > > > > >     
> > > > > > >     
> > > > > > > > - Some form of justification of why multifd needs to be enabled for COLO.
> > > > > > > >   For example, in your cluster deployment, using multifd can improve XXX
> > > > > > > >   by YYY.  Please describe the use case and improvements.    
> > > > > > > 
> > > > > > > That one is pretty easy; since COLO is regularly taking snapshots, the faster
> > > > > > > the snapshoting the less overhead there is.    
> > > > > > 
> > > > > > Thanks for chiming in, Dave.  I can explain why I want to request for some
> > > > > > numbers.
> > > > > > 
> > > > > > Firstly, numbers normally proves it's used in a real system.  It's at least
> > > > > > being used and seriously tested.
> > > > > > 
> > > > > > Secondly, per my very limited understanding to COLO... the two VMs in most
> > > > > > cases should be in-sync state already when both sides generate the same
> > > > > > network packets.
> > > > > > 
> > > > > > Another sync (where multifd can start to take effect) is only needed when
> > > > > > there're packets misalignments, but IIUC it should be rare.  I don't know
> > > > > > how rare it is, it would be good if Lukas could introduce some of those
> > > > > > numbers in his deployment to help us understand COLO better if we'll need
> > > > > > to keep it.  
> > > > > 
> > > > > It really depends on the workload and if you want to tune for
> > > > > throughput or latency.  
> > > > 
> > > > Thanks for all the answers from all of you.
> > > > 
> > > > If we decide to keep COLO, looks like I'll have no choice but understand it
> > > > better, as long as it still has anything to do with migration..  I'll leave
> > > > some more questions / comments at the end.
> > > > 
> > > > > 
> > > > > You need to do a checkpoint eventually and the more time passes between
> > > > > checkpoints the more dirty memory you have to transfer during the
> > > > > checkpoint.
> > > > > 
> > > > > Also keep in mind that the guest is stopped during checkpoints. Because
> > > > > even if we continue running the guest, we can not release the mismatched
> > > > > packets since that would expose a state of the guest to the outside
> > > > > world that is not yet replicated to the secondary.  
> > > > 
> > > > Yes this makes sense.  However it is also the very confusing part of COLO.
> > > > 
> > > > When I said "I was expecting migration to not be the hot path", one reason
> > > > is I believe COLO checkpoint (or say, when migration happens) will
> > > > introduce a larger downtime than normal migration, because this process
> > > > transfers RAM with both VMs stopped.
> > > > 
> > > > You helped explain why that large downtime is needed, thanks.  However then
> > > > it means either (1) packet misalignment, or (2) periodical timer kickoff,
> > > > either of them will kickoff checkpoint..
> > > 
> > > Yes, it could be optimized so we don't stop the guest for the periodical
> > > checkpoints.
> > 
> > Likely we must stop it at least to savevm on non-rams.  But I get your
> > point.  Yes, I think it might be good idea to try to keep in sync even
> > without an explicit checkpoint request, almost like what live precopy does
> > with RAM to shrink the downtime.
> > 
> > > 
> > > > 
> > > > I don't know if COLO services care about such relatively large downtime,
> > > > especially it is not happening once, but periodically for every tens of
> > > > seconds at least (assuming when periodically then packet misalignment is
> > > > rare).
> > > > 
> > > 
> > > If you want to tune for latency you go for like 500ms checkpoint
> > > interval.
> > > 
> > > 
> > > The alternative way to do fault tolerance is micro checkpointing where
> > > only the primary guest runs while you buffer all sent packets. Then
> > > every checkpoint you transfer all ram and device state to the secondary
> > > and only then release all network packets.
> > > So in this approach every packet is delayed by checkpoint interval +
> > > checkpoint downtime and you use a checkpoint interval of like 30-100ms.
> > > 
> > > Obviously, COLO is a much better approach because only few packets
> > > observe a delay.
> > > 
> > > > > 
> > > > > So the migration performance is actually the most important part in
> > > > > COLO to keep the checkpoints as short as possible.  
> > > > 
> > > > IIUC when a heartbeat will be lost on PVM _during_ sync checkpoints, then
> > > > SVM can only rollback to the last time checkpoint.  Would this be good
> > > > enough in reality?  It means if there's a TCP transaction then it may broke
> > > > anyway.  x-checkpoint-delay / periodic checkpoints definitely make this
> > > > more possible to happen.
> > > 
> > > We only release the mismatched packets after the ram and device state
> > > is fully sent to the secondary. Because then the secondary is in the
> > > state that generated these mismatched packets and can take over.
> > 
> > My question was more about how COLO failover works (or work at all?) if a
> > failure happens exactly during checkpointing (aka, migration happening).
> > 
> > First of all, if the failure happens on SVM, IIUC it's not a problem,
> > because PVM has all the latest data.
> > 
> > The problem lies more in the case where the failure happened in PVM. In
> > this case, SVM only contains the previous checkpoint results, maybe plus
> > something on top of that snapshot, as SVM kept running after the previous
> > checkpoint.
> > 
> > So the failure can happen at different spots:
> > 
> >   (1) Failure happens _before_ applying the new checkpoint, that is, while
> >       receiving the checkpoint from src and for example the PVM host is
> >       down, channel shutdown.
> > 
> >       This one looks "okay", IIUC what will happen is SVM will keep running
> >       but then as I described above it only contains the previous version
> >       of the PVM snapshot, plus something SVM updated which may not match
> >       with PVM's data:
> > 
> >            (1.a) if checkpoint triggered because of x-checkpoint-delay,
> >            lower risk, possibly still in sync with src
> > 
> >            (1.b) if checkpoint triggered by colo-compare notification of
> >            packet misalignment, I believe this may cause service
> >            interruptions and it means SVM will not be able to competely
> 
> No, that's ok - the colo-compare mismatch triggers the need for a checkpoint;
> but if the PVM dies during the creation of that checkpoint, it's the same as
> if the PVM had never started making the checkpoint; the SVM just takes over.
> But the important thing is that the packet that caused the micompare can't
> be released until after the hosts are in sync again.
> 
> > 
> >   (2) Failure happens _after_ applying the new checkpoint, but _before_ the
> >       whole checkpoint is applied.
> > 
> >       To be explicit, consider qemu_load_device_state() when the process of
> >       colo_incoming_process_checkpoint() failed.  It means SVM applied
> >       partial of PVM's checkpoint, I think it should mean PVM is completely
> >       corrupted.
> 
> As long as the SVM has got the entire checkpoint, then it *can* apply it all
> and carry on from that point.

Does it mean we assert() that qemu_load_device_state() will always success
for COLO syncs?

Logically post_load() can invoke anything and I'm not sure if something can
start to fail, but I confess I don't know an existing device that can
trigger it.

Lukas told me something was broken though with pc machine type, on
post_load() not re-entrant.  I think it might be possible though when
post_load() is relevant to some device states (that guest driver can change
between two checkpoint loads), but that's still only theoretical.  So maybe
we can indeed assert it here.

> 
> > Here either (1.b) or (2) seems fatal to me on the whole high level design.
> > Periodical syncs with x-checkpoint-delay can make this easier to happen, so
> > larger windows of critical failures.  That's also why I think it's
> > confusing COLO prefers more checkpoints - while it helps sync things up, it
> > enlarges high risk window and overall overhead.
> 
> No, there should be no point at which a failure leaves the SVM without a checkpoint
> that it can apply to take over.
> 
> > > > > I have quite a few more performance and cleanup patches on my hands,
> > > > > for example to transfer dirty memory between checkpoints.
> > > > >   
> > > > > > 
> > > > > > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > > > > > should be when heartbeat gets lost; that normally should happen when two
> > > > > > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > > > > > there's no migration happening, only the src recording what has changed.
> > > > > > Hence I think some number with description of the measurements may help us
> > > > > > understand how important multifd is to COLO.
> > > > > > 
> > > > > > Supporting multifd will cause new COLO functions to inject into core
> > > > > > migration code paths (even if not much..). I want to make sure such (new)
> > > > > > complexity is justified. I also want to avoid introducing a feature only
> > > > > > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > > > > > it'll be useful".  
> > > > > 
> > > > > What COLO needs from migration at the low level:
> > > > > 
> > > > > Primary/Outgoing side:
> > > > > 
> > > > > Not much actually, we just need a way to incrementally send the
> > > > > dirtied memory and the full device state.
> > > > > Also, we ensure that migration never actually finishes since we will
> > > > > never do a switchover. For example we never set
> > > > > RAMState::last_stage with COLO.
> > > > > 
> > > > > Secondary/Incoming side:
> > > > > 
> > > > > colo cache:
> > > > > Since the secondary always needs to be ready to take over (even during
> > > > > checkpointing), we can not write the received ram pages directly to
> > > > > the guest ram to prevent having half of the old and half of the new
> > > > > contents.
> > > > > So we redirect the received ram pages to the colo cache. This is
> > > > > basically a mirror of the primary side ram.
> > > > > It also simplifies the primary side since from it's point of view it's
> > > > > just a normal migration target. So primary side doesn't have to care
> > > > > about dirtied pages on the secondary for example.
> > > > > 
> > > > > Dirty Bitmap:
> > > > > With COLO we also need a dirty bitmap on the incoming side to track
> > > > > 1. pages dirtied by the secondary guest
> > > > > 2. pages dirtied by the primary guest (incoming ram pages)
> > > > > In the last step during the checkpointing, this bitmap is then used
> > > > > to overwrite the guest ram with the colo cache so the secondary guest
> > > > > is in sync with the primary guest.
> > > > > 
> > > > > All this individually is very little code as you can see from my
> > > > > multifd patch. Just something to keep in mind I guess.
> > > > > 
> > > > > 
> > > > > At the high level we have the COLO framework outgoing and incoming
> > > > > threads which just tell the migration code to:
> > > > > Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> > > > > paired with a qemu_loadvm_state_main on the incoming side.
> > > > > Send the device state (qemu_save_device_state()) paired with writing
> > > > > that stream to a buffer on the incoming side.
> > > > > And finally flusing the colo cache and loading the device state on the
> > > > > incoming side.
> > > > > 
> > > > > And of course we coordinate with the colo block replication and
> > > > > colo-compare.  
> > > > 
> > > > Thank you.  Maybe you should generalize some of the explanations and put it
> > > > into docs/devel/migration/ somewhere.  I think many of them are not
> > > > mentioned in the doc on how COLO works internally.
> > > > 
> > > > Let me ask some more questions while I'm reading COLO today:
> > > > 
> > > > - For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
> > > >   do the following:
> > > > 
> > > >     bql_lock()
> > > >     vm_stop_force_state(RUN_STATE_COLO)     # stop vm
> > > >     bql_unlock()
> > > > 
> > > >     ...
> > > >   
> > > >     bql_lock()
> > > >     qemu_save_device_state()                # into a temp buffer fb
> > > >     bql_unlock()
> > > > 
> > > >     ...
> > > > 
> > > >     qemu_savevm_state_complete_precopy()    # send RAM, directly to the wire
> > > >     qemu_put_buffer(fb)                     # push temp buffer fb to wire
> > > > 
> > > >     ...
> > > > 
> > > >     bql_lock()
> > > >     vm_start()                              # start vm
> > > >     bql_unlock()
> > > > 
> > > >   A few questions that I didn't ask previously:
> > > > 
> > > >   - If VM is stopped anyway, why putting the device states into a temp
> > > >     buffer, instead of using what we already have for precopy phase, or
> > > >     just push everything directly to the wire?
> > > 
> > > Actually we only do that to get the size of the device state and send
> > > the size out-of-band, since we can not use qemu_load_device_state()
> > > directly on the secondary side and look for the in-band EOF.
> > 
> > I also don't understand why the size is needed..
> > 
> > Currently the streaming protocol for COLO is:
> > 
> >   - ...
> >   - COLO_MESSAGE_VMSTATE_SEND
> >   - RAM data
> >   - EOF
> >   - COLO_MESSAGE_VMSTATE_SIZE
> >   - non-RAM data
> >   - EOF
> > 
> > My question is about, why can't we do this instead?
> > 
> >   - ...
> >   - COLO_MESSAGE_VMSTATE_SEND
> >   - RAM data

[1]

> >   - non-RAM data
> >   - EOF
> > 
> > If the VM is stoppped during the whole process anyway..
> > 
> > Here RAM/non-RAM data all are vmstates, and logically can also be loaded in
> > one shot of a vmstate load loop.
> 
> You might be able to; in that case you would have to stream the 
> entire thing into a buffer on the secondary rather than applying the
> RAM updates to the colo cache.

I thought the colo cache is already such a buffering when receiving at [1]
above?  Then we need to flush the colo cache (including scan the SVM bitmap
and only flush those pages in colo cache) like before.

If something went wrong (e.g. channel broken during receiving non-ram
device states), SVM can directly drop all colo cache as the latest
checkpoint isn't complete.

> 
> > 
> > > 
> > > > 
> > > >   - Above operation frequently releases BQL, why is it needed?  What
> > > >     happens if (within the window where BQL released) someone invoked QMP
> > > >     command "cont" and causing VM to start? Would COLO be broken with it?
> > > >     Should we take BQL for the whole process to avoid it?
> > > 
> > > We need to release the BQL because block replication on the secondary side and
> > > colo-compare and netfilters on the primary side need the main loop to
> > > make progress.
> > 
> > Do we need it to make progress before vm_start(), though?  If we take BQL
> > once and release it once only after vm_start(), would it work?
> > 
> > I didn't see anything being checked in colo_do_checkpoint_transaction(),
> > after vm_stop() + replication_do_checkpoint_all(), and before vm_start()..
> > 
> > > 
> > > Issuing a cont during a checkpoint will probably break it yes.
> > 
> > Feel free to send a patch if you think it's a concern.  Ok to me even if
> > without, if mgmt has full control of it, so I'll leave it to you to decide
> > as I'm not a colo user after all.
> > 
> > > 
> > > > 
> > > > - Does colo_cache has an limitation, or should we expect SVM to double
> > > >   consume the guest RAM size?  As I didn't see where colo_cache will be
> > > >   released during each sync (e.g. after colo_flush_ram_cache).  I am
> > > >   expecting over time SVM will have most of the pages touched, then the
> > > >   colo_cache can consume the same as guest mem on SVM.
> > > 
> > > Yes, the secondary side consumes twice the guest ram size. That is one
> > > disadvantage of this approach.
> > > 
> > > I guess we could do some kind of copy on write mapping for the
> > > secondary guest ram. But even then it's hard to make the ram overhead
> > > bounded in size.
> > 
> > It's ok, though this sounds also like something good to be documented, it's
> > a very high level knowledge an user should know when considering COLO as an
> > HA solution.
> 
> The thought of using userfaultfd-write had floated around at some time
> as ways to optimise this.

It's an interesting idea. Yes it looks working, but as Lukas said, it looks
still unbounded.

One idea to provide a strict bound:

  - admin sets a proper buffer to limit the extra pages to remember on SVM,
    should be much smaller than total guest mem, but admin should make sure
    in 99.99% cases it won't hit the limit with a proper x-checkpoint-delay,

  - if limit triggered, both VMs needs to pause (initiated by SVM), SVM
    needs to explicitly request a checkpoint to src,

  - VMs can only start again after two VMs sync again

Thanks,

-- 
Peter Xu


