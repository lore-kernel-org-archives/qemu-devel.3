Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F0B109024C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3FtW-0003pv-Uz; Thu, 19 Mar 2026 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Fsd-0003MJ-ME
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Fsa-0004By-Uy
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 12:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773936347;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gt70SwlVIJMsuC0fePi/qtq98hcZmQtmhHMBSfBuqRg=;
 b=b9tGhb2HVFVipp7ytW+pcOtQVfsDN+LkxOztfmvYuBSTmi130aimYZmhe/6jPCGo755KXa
 NQM0DwS7lcjk79zh7Dbu25sNecy44AdSty+xy7JG4SB/+dRXsSAnXrv7BqNMpt/aDc5xfQ
 bYkCIc817N7MBscWrKKhhb//+2GT34E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-UMxqv9rfO6yLkl9acow1-w-1; Thu,
 19 Mar 2026 12:05:41 -0400
X-MC-Unique: UMxqv9rfO6yLkl9acow1-w-1
X-Mimecast-MFC-AGG-ID: UMxqv9rfO6yLkl9acow1-w_1773936339
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1C4818002EE; Thu, 19 Mar 2026 16:05:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5AD1800107; Thu, 19 Mar 2026 16:05:35 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:05:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
Message-ID: <abweyyF6XIC4vvKV@redhat.com>
References: <20260318162951.1060969-1-pfalcato@suse.de>
 <abrY1aC1RjG7P2GR@redhat.com> <abrZsaFWDwnbWbKL@redhat.com>
 <fifhay3zi37f3gyngcgwhtlbhninwljokrqulwzeyxru6tizfn@eyl2uzcqqc3g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fifhay3zi37f3gyngcgwhtlbhninwljokrqulwzeyxru6tizfn@eyl2uzcqqc3g>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 18, 2026 at 05:24:58PM +0000, Pedro Falcato wrote:
> On Wed, Mar 18, 2026 at 04:58:25PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Mar 18, 2026 at 04:54:45PM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Mar 18, 2026 at 04:29:51PM +0000, Pedro Falcato wrote:
> > > > According to the ATA Command Set specification (and the SATA specification
> > > > too), SATA drives are supposed to set word 93 (which for PATA holds hardware
> > > > reset results) to 0. As such, clear it when ncq_queues > 0 (which is only true
> > > > for SATA drives).
> > > > 
> > > > Doing so fixes a quirk in Linux where it thinks the AHCI QEMU drive is PATA
> > > > over a SATA bridge, and thus limits maximum transfer sizes for individual IOs
> > > > with a:
> > > > [    1.632121] ata1.00: applying bridge limits
> > > > 
> > > > While at it, bump the device's firmware revision for IDENTIFY. This makes it
> > > > so Linux can avoid enabling a quirk for fixed QEMU releases.
> > > > 
> > > > Link: https://lore.kernel.org/linux-ide/20260303183337.1013474-1-pfalcato@suse.de/
> > > > Cc: qemu-stable@nongnu.org
> > > > Suggsted-by: Niklas Cassel <cassel@kernel.org>
> > > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > > ---
> > > > Note: I understand the version bump is vaguely controversial (particularly
> > > >  exposing the QEMU version in the string) but I don't have a much better
> > > >  idea. Logically, bumping it to 11.0 for stable releases doesn't make much
> > > >  sense.
> > > 
> > > Bumping the version string changes guest ABI, so such a change should
> > > normally be tied to a new machine type version, not unconditionally
> > > changed.  That would also in turn make it unsuitable for QEMU stable
> > > release branches which don't take changes which affect machine type
> > > ABI.
> > >
> 
> I don't understand (I don't usually hack on QEMU). What do you mean with
> guest ABI and machine type ABI?

QEMU  can save/restore the state of a running VM to disk, or through
Live migration between hosts, transfer state across two QEMU's. If
those two processes are running different QEMU releases, we need to
ensure the guest visible virtual hardware doesn't change its behaviour.
Guest OS are liable to misbehave if hardware changes behaviour while the
OS is running.

In QEMU we have machine types "pc" ( "i440fx") and "q35" which encode
which have versions associated with them. These are intended to encode
settings which ensure QEMU exposes consistent guest hardware features.

IOW, the machine 'pc-i440fx-10.0.0'  should operate the same regardless
of whether it is run from QEMU 10.0.0, or a later  QEMU 10.1.0.

Behaviour changes would only be introduced ina  newer 'pc-i440fx-10.1.0'

We generally refer to this overall situation as "fixed guest ABI" or
"fixed machine type ABI".

> > Having said that, possibly the functional fix itself might need to
> > be tied to the machine type too, given that it is triggering a
> > behavioural change in the emulation and guest driver ? If that's
> 
> There is no behavioural change on QEMU's side. QEMU has always been
> able to perform IO up to the controller interface's limit. Yes, it does
> change Linux's behavior.

Yes, I meant, we would be changing what features QEMU exposes to the
guest, and that changes the guest behaviour

> > the case, then the version could be changed at the same time.
> 
> I was skimming through https://www.qemu.org/docs/master/devel/migration/compatibility.html.
> So tying this to the machine type would mean (if I am not mistaken, but do
> correct me if I'm wrong) setting the device version (or an equivalent device
> property) in hw_compat_10_2 (in our case, since it's the last QEMU release).
> Is this correct?

Yes, something along those lines. We're about to make the QEMU 11.0.0
release, in a feew weeks and are in freeze now. We can take bug fix
patches in freeze, so 11.0 is still a possibility.

We might want a specific bool property 'x-sata-identify-fix'  to control
enablement of the fix that is added to hw_compat, parallel to the
version change.

> My only other concern would be how to expose firmware versions in a proper way.
> From my reading, it is clear that QEMU does not want to expose versions to
> guests. Perhaps some versioning scheme like "2.6.<revision>" or maybe even
> "2.5+<revision>" could be maximally backwards compatible whilst not exposing
> too much to the guest.

IIUC, we didn't want the version in the hardware to unconditionally
change every time the QEMU version changed. So back in the 2.5 release
we fixed the version at 2.5, such that future changes would need an
explicit decision. I think it is likely Ok to change the version
number to 11


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


