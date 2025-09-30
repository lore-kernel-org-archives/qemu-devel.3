Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F936CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VBW-0000NY-FL; Tue, 30 Sep 2025 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v3VBV-0000Mu-3O
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v3VBL-0007SQ-TN
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdLejUKwWGxVPAtWypAED5fIEriSJVjqGXnsm6Nq5v8=;
 b=HBv9WYeiMKDQDfRvuouGvQ8aOY+6U52CsHs/8BJ01oxkujCpBNQ3X34qzV/G1H/TK4c9yq
 UjwILo6iKPfEGrQLroYdKbx6VfDluVVeup+tIFLUmI3lxAneknlqX5/lUTOo6lSh/4otWn
 XL+PjrDfx/m1+nf07+LUK5Z6QmwNpC4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-mNSCz7PGODa_RDyxuZllUA-1; Tue,
 30 Sep 2025 03:53:47 -0400
X-MC-Unique: mNSCz7PGODa_RDyxuZllUA-1
X-Mimecast-MFC-AGG-ID: mNSCz7PGODa_RDyxuZllUA_1759218826
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D41D196A967; Tue, 30 Sep 2025 07:53:33 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9140519560B4; Tue, 30 Sep 2025 07:53:32 +0000 (UTC)
Date: Tue, 30 Sep 2025 09:53:31 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNWITu36f_DlhZo1@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > Currently, when postcopy starts, the source VM starts switchover and
> > > sends a package containing the state of all non-postcopiable devices.
> > > When the destination loads this package, the switchover is complete and
> > > the destination VM starts. However, if the device state load fails or
> > > the destination side crashes, the source side is already in
> > > POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> > > up-to-date machine state as the destination has not yet started.
> > > 
> > > This patch introduces a new POSTCOPY_DEVICE state which is active
> > > while the destination machine is loading the device state, is not yet
> > > running, and the source side can be resumed in case of a migration
> > > failure.
> > > 
> > > To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> > > side uses a PONG message that is a response to a PING message processed
> > > just before the POSTCOPY_RUN command that starts the destination VM.
> > > Thus, this change does not require any changes on the destination side
> > > and is effective even with older destination versions.
> > 
> > Thanks, this will help libvirt as we think that the migration can be
> > safely aborted unless we successfully called "cont" and thus we just
> > kill QEMU on the destination. But since QEMU on the source already
> > entered postcopy-active, we can't cancel the migration and the result is
> > a paused VM with no way of recovering it.
> > 
> > This series will make the situation better as the source will stay in
> > postcopy-device until the destination successfully loads device data.
> > There's still room for some enhancement though. Depending on how fast
> > this loading is libvirt may issue cont before device data is loaded (the
> > destination is already in postcopy-active at this point), which always
> > succeeds as it only marks the domain to be autostarted, but the actual
> > start may fail later. When discussing this with Juraj we agreed on
> > introducing the new postcopy-device state on the destination as well to
> 
> I used to think and define postcopy-active be the state we should never be
> able to cancel it anymore, implying that the real postcopy process is in
> progress, and also implying the state where we need to start assume the
> latest VM pages are spread on both sides, not one anymore.  Cancellation or
> killing either side means crashing VM then.

Right, although it's unfortunately not the case now as the source is in
postcopy-active even though the complete state is still on the source.

> It could be a good thing indeed to have postcopy-device on dest too from
> that regard, because having postcopy-device on dest can mark out the small
> initial window when dest qemu hasn't yet start to generate new data but
> only applying old data (device data, which src also owns a copy).  From
> that POV, that indeed does not belong to the point if we define
> postcopy-active as above.
> 
> IOW, also with such definition, setting postcopy-active on dest QEMU right
> at the entry of ram load thread (what we do right now..) is too early.
> 
> > make sure libvirt will only call cont once device data was successfully
> > loaded so that we always get a proper result when running cont. But it
> 
> Do we know an estimate of how much extra downtime this would introduce?
> 
> We should have discussed this in a previous thread, the issue is if we cont
> only after device loaded, then dest QEMU may need to wait a while until it
> receives the cont from libvirt, that will contribute to the downtime.  It
> would best be avoided, or if it's negligible then it's fine too but I'm not
> sure whether it's guaranteed to be negligible..

We start QEMU with -S so it always needs to wait for cont from libvirt.
We wait for postcopy-active on the destination before sending cont. So
currently it can arrive while QEMU is still loading device state or when
this is already done. I was just suggesting to always wait for the
device state to be loaded before sending cont. So in some cases it would
arrive a bit later while in other cases nothing would change. It's just
a matter of waking up a thread waiting for postcopy-active and sending
the command back to QEMU. There's no communication with the other host
at this point so I'd expect the difference to be negligible. And as I
said depending on how fast device state loading vs transferring
migration control from libvirt on the source to the destination we may
already be sending cont when QEMU is done.

But anyway, this would only be helpful if there's a way to actually
cancel migration on the source when cont fails.

> If the goal is to make sure libvirt knows what is happening, can it still
> relies on the event emitted, in this case, RESUME?  We can also reorg how
> postcopy-device and postcopy-active states will be reported on dest, then
> they'll help if RESUME is too coarse grained.

The main goal is to make sure we don't end up with vCPUs paused on both
sides during a postcopy migration that can't be recovered nor canceled
thus effectively crashing the VM.

> So far, dest QEMU will try to resume the VM after getting RUN command, that
> is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> do vm_start(), at the end of which RESUME event will be generated.  So
> RESUME currently implies both disk activation success, and vm start worked.
> 
> > may still fail when locking disks fails (not sure if this is the only
> > way cont may fail). In this case we cannot cancel the migration on the
> 
> Is there any known issue with locking disks that dest would fail?  This
> really sound like we should have the admin taking a look.

Oh definitely, it would be some kind of an storage access issue on the
destination. But we'd like to give the admin an option to actually do
anything else than just killing the VM :-) Either by automatically
canceling the migration or allowing recovery once storage issues are
solved.

> I recall Juraj mentioned off list that drive lock sometimes will stop
> working.  Is that relevant here?

I think this was more a case of drive lock succeeding on both sides at
the end of precopy migration. If we're thinking about the same thing :-)
This is a separate issue that needs to be handled on libvirt side.

Jirka


