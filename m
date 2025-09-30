Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C4BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gb9-0003is-72; Tue, 30 Sep 2025 16:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3gb7-0003hl-78
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3gav-0000TP-QP
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759262701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQ6j4nXJoFORqJisgQVrzLf0gFhAEJPBcCqjzomqS4U=;
 b=O/LGIxQoKw9m29hZfSy/ruJTmqYXsnW89daMF2s9s7J+O2Mklml2WVF2iwdJHR7hAennds
 SHZIzSIkrU0NYHbi8dY6uvq5XAVzh1ooz9U8qgaKXlFkBt8JyI2TrKKaamUppxsPs3DqQ8
 EPr0OcS3GEPjXHa5QroHAZ1Zh5+8o9k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-7ZSQRNfkNiu8q74auGY0zw-1; Tue, 30 Sep 2025 16:04:58 -0400
X-MC-Unique: 7ZSQRNfkNiu8q74auGY0zw-1
X-Mimecast-MFC-AGG-ID: 7ZSQRNfkNiu8q74auGY0zw_1759262697
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso121585536d6.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759262697; x=1759867497;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQ6j4nXJoFORqJisgQVrzLf0gFhAEJPBcCqjzomqS4U=;
 b=SnU12+xkwvnHOYdO1KadN6SXYjA5aFBewP5Z/bgo9SGyHHtl8Sr4JaciuTVQtNT8XB
 0E7kR7sJxsbfXsiIWf+fetJCMe66f1FYzMKGEZdaAhc2SVZ1cU1iA6xqtkWP2dudZ2Cr
 9TabEZJ5zspiafRgPjlWarUOTbNTTvA+qvTub+b0ALvZVc8Gz/V4Y6+JYkeZ5zeMusnw
 Dk83Wrn/CNvcGpbeuywq48QhELcOO6cmXhZQc972LDH4mDlvoj2/JIiYruTr+jBb5bUq
 sepSNDlvxDz/cLn8l9MbC2uQR00XsRpZJKVLgYZMcRzIb/YAlgFlCZKjjOTRZtnzEMJu
 nayg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE7JP+6NN9yK5pBdJPrLFNTlB1sbL0e+t+zckeuwK9zig3dPTJvQX934JXD+7fHrgO9PYwRGvZV10L@nongnu.org
X-Gm-Message-State: AOJu0YxZt8niBrfvskpq6WeGTWCRLWk5uuYGKxwgnTj256AQT3ksJI14
 +CbtZEY1FnTj54JRrxQzwHINcB1Gdt/BCAfWJHaPKZQp6qE7btBxaNTZty/Xv16BAlQvuihPbt8
 cLF4CyyRvMQwF5l5EZ4y06164d6f7BS9Q4+JcbcjDiwWSh++/r9bLZU1A
X-Gm-Gg: ASbGncsJO/bGDIsXBkEKvZkeW0rzR7xnyw1BNDB2fXwnYpm4xhv3Xl1L3vJdTzi0Joa
 BWJAuhZwNfb0Qx91uF65bsFrNy09ZkAr3tYJAjNY+dLgi5I0fi/9sNxWiWUXjwBc7J8CO3HfCOl
 46BYDZiAmIU/Um6Q7MwIwqSS+tQHwBM7Q+b+f+D2TOKEeH9Ch7lKy9t0tiZQE1DTw/XDUHJoHeP
 b9TSbl0qBpDxa69RGg63yONvv/IPc/Frgpm9eP293hYluWQ+tbpeHOQ+UVzHbbpyI4l6fXdYKSM
 aFSSMj5s4wacKsLJGHmMPm7mhjtlem6G4VXMqw==
X-Received: by 2002:a05:6214:23c9:b0:7cd:91ff:6215 with SMTP id
 6a1803df08f44-873a8c1cce8mr11925176d6.61.1759262697295; 
 Tue, 30 Sep 2025 13:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOAAOZwUo81TeWK7B7lwLE3V45SkvjRLeZCqhnhZUT+Htd/2+EdZMH6Iu3Dvehj3K5i/VAkw==
X-Received: by 2002:a05:6214:23c9:b0:7cd:91ff:6215 with SMTP id
 6a1803df08f44-873a8c1cce8mr11924506d6.61.1759262696567; 
 Tue, 30 Sep 2025 13:04:56 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-86bb66572aesm23016466d6.32.2025.09.30.13.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 13:04:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:04:54 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNw35iWaNDnYXOz7@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > 
> > > > Currently, when postcopy starts, the source VM starts switchover and
> > > > sends a package containing the state of all non-postcopiable devices.
> > > > When the destination loads this package, the switchover is complete and
> > > > the destination VM starts. However, if the device state load fails or
> > > > the destination side crashes, the source side is already in
> > > > POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> > > > up-to-date machine state as the destination has not yet started.
> > > > 
> > > > This patch introduces a new POSTCOPY_DEVICE state which is active
> > > > while the destination machine is loading the device state, is not yet
> > > > running, and the source side can be resumed in case of a migration
> > > > failure.
> > > > 
> > > > To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> > > > side uses a PONG message that is a response to a PING message processed
> > > > just before the POSTCOPY_RUN command that starts the destination VM.
> > > > Thus, this change does not require any changes on the destination side
> > > > and is effective even with older destination versions.
> > > 
> > > Thanks, this will help libvirt as we think that the migration can be
> > > safely aborted unless we successfully called "cont" and thus we just
> > > kill QEMU on the destination. But since QEMU on the source already
> > > entered postcopy-active, we can't cancel the migration and the result is
> > > a paused VM with no way of recovering it.
> > > 
> > > This series will make the situation better as the source will stay in
> > > postcopy-device until the destination successfully loads device data.
> > > There's still room for some enhancement though. Depending on how fast
> > > this loading is libvirt may issue cont before device data is loaded (the
> > > destination is already in postcopy-active at this point), which always
> > > succeeds as it only marks the domain to be autostarted, but the actual
> > > start may fail later. When discussing this with Juraj we agreed on
> > > introducing the new postcopy-device state on the destination as well to
> > 
> > I used to think and define postcopy-active be the state we should never be
> > able to cancel it anymore, implying that the real postcopy process is in
> > progress, and also implying the state where we need to start assume the
> > latest VM pages are spread on both sides, not one anymore.  Cancellation or
> > killing either side means crashing VM then.
> 
> Right, although it's unfortunately not the case now as the source is in
> postcopy-active even though the complete state is still on the source.
> 
> > It could be a good thing indeed to have postcopy-device on dest too from
> > that regard, because having postcopy-device on dest can mark out the small
> > initial window when dest qemu hasn't yet start to generate new data but
> > only applying old data (device data, which src also owns a copy).  From
> > that POV, that indeed does not belong to the point if we define
> > postcopy-active as above.
> > 
> > IOW, also with such definition, setting postcopy-active on dest QEMU right
> > at the entry of ram load thread (what we do right now..) is too early.
> > 
> > > make sure libvirt will only call cont once device data was successfully
> > > loaded so that we always get a proper result when running cont. But it
> > 
> > Do we know an estimate of how much extra downtime this would introduce?
> > 
> > We should have discussed this in a previous thread, the issue is if we cont
> > only after device loaded, then dest QEMU may need to wait a while until it
> > receives the cont from libvirt, that will contribute to the downtime.  It
> > would best be avoided, or if it's negligible then it's fine too but I'm not
> > sure whether it's guaranteed to be negligible..
> 
> We start QEMU with -S so it always needs to wait for cont from libvirt.
> We wait for postcopy-active on the destination before sending cont. So
> currently it can arrive while QEMU is still loading device state or when
> this is already done. I was just suggesting to always wait for the
> device state to be loaded before sending cont. So in some cases it would
> arrive a bit later while in other cases nothing would change. It's just
> a matter of waking up a thread waiting for postcopy-active and sending
> the command back to QEMU. There's no communication with the other host
> at this point so I'd expect the difference to be negligible. And as I
> said depending on how fast device state loading vs transferring
> migration control from libvirt on the source to the destination we may
> already be sending cont when QEMU is done.

Ah OK, I think this is not a major concern, until it is justified to.

> 
> But anyway, this would only be helpful if there's a way to actually
> cancel migration on the source when cont fails.
> 
> > If the goal is to make sure libvirt knows what is happening, can it still
> > relies on the event emitted, in this case, RESUME?  We can also reorg how
> > postcopy-device and postcopy-active states will be reported on dest, then
> > they'll help if RESUME is too coarse grained.
> 
> The main goal is to make sure we don't end up with vCPUs paused on both
> sides during a postcopy migration that can't be recovered nor canceled
> thus effectively crashing the VM.

Right, I assume that's what Juraj's series is trying to fix.  After this
series lands, I don't see why it would happen.  But indeed I'm still
expecting the block drive (including their locks) to behave all fine.

> 
> > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > do vm_start(), at the end of which RESUME event will be generated.  So
> > RESUME currently implies both disk activation success, and vm start worked.
> > 
> > > may still fail when locking disks fails (not sure if this is the only
> > > way cont may fail). In this case we cannot cancel the migration on the
> > 
> > Is there any known issue with locking disks that dest would fail?  This
> > really sound like we should have the admin taking a look.
> 
> Oh definitely, it would be some kind of an storage access issue on the
> destination. But we'd like to give the admin an option to actually do
> anything else than just killing the VM :-) Either by automatically
> canceling the migration or allowing recovery once storage issues are
> solved.

The problem is, if the storage locking stopped working properly, then how
to guarantee the shared storage itself is working properly?

When I was replying previously, I was expecting the admin taking a look to
fix the storage, I didn't expect the VM can still be recovered anymore if
there's no confidence that the block devices will work all fine.  The
locking errors to me may imply a block corruption already, or should I not
see it like that?

Fundamentally, "crashing the VM" doesn't lose anything from the block POV
because it's always persistent when synced.  It's almost only about RAM
that is getting lost, alongside it's about task status, service
availability, and the part of storage that was not flushed to backends.

Do we really want to add anything more complex when shared storage has
locking issues?  Maybe there's known issues on locking that we're 100% sure
the storage is fine, but only the locking went wrong?

IIUC, the hope is after this series lands we should close the gap for
almost all the rest paths that may cause both sides to HALT for a postcopy,
except for a storage issue with lockings.  But I'm not sure if I missed
something.

Thanks,

-- 
Peter Xu


