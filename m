Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30B5C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkO0K-0007st-Mo; Thu, 16 Jul 2026 11:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkNzu-0007s8-4y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkNzr-0007Of-4g
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784215653;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bl3Y/ejlltQjnawpu786sYmQvqKJ7oYaYibcLj90zvU=;
 b=Wl9FitChYSXb/iz0amMuC0rA5cNOaLWwgOKTbLxGiwS7j0pxNM+srvHAblrKTaEOJpvmn3
 Rw8rXRyg9JQy0dQtIVU2EezDTaT3BdXH8zMSrwX8zKGSAE5etV5wooHtaxlAZZQ7uiFVNU
 brKKn7L4uwSVgOT/aYZZx2FSAKKxRRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-PtY0_yxQOr2nAGD2mJAsTg-1; Thu,
 16 Jul 2026 11:27:30 -0400
X-MC-Unique: PtY0_yxQOr2nAGD2mJAsTg-1
X-Mimecast-MFC-AGG-ID: PtY0_yxQOr2nAGD2mJAsTg_1784215648
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E911955F2B; Thu, 16 Jul 2026 15:27:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CBED1956042; Thu, 16 Jul 2026 15:27:23 +0000 (UTC)
Date: Thu, 16 Jul 2026 16:27:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <alj4V6I__bCOjRTt@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyqv3u32.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:

> Assumptions:
> 
> A) The migration stream is assumed to be secured by TLS on a per-host
> basis.
> 
> B) For migration streams stored to file, including snapshots, it is
> assumed that the storage file is authentic, i.e. the files are owned by
> the party performing the live migration and have not been tampered with.

Can you clarify "the party performing the live migration" ?

Is that referring to the "guest owner" who initiates the migration,
or is that referring to the mgmt app control plane.

The risk I've always been concerned about is the guest owner
tampering with state files, though I'm increasing coming to
the view point that state files must *never* be allowed to be
modified by the guest owner. Mgmt apps must either prevent
that through storage permissions, or detect that by digitally
signing state files that are theoretically writable by guest
owners & validate sig before restore.


> C) The network ports used for migration are expected to be available
> only during migration. No long-standing listening destination QEMU
> process.

I wonder, does that make a difference to our risk ?

If we're concerned about an undesirable app/client conjnectnig to a
open network port, QEMU has that threat no matter how short the time
windows is that the ports are accepting incoming clients.  So I'm
not sure this point helps us.

> D) The network used for migration is expected to be adequately isolated.

Is that intended to be in additional to (A) or instead of (A) ?

If in addition to (A) then I'm wondering what benefits listing
this point brings - what risks are eliminated that TLS does not
already eliminate ?

> E) The migration source QEMU process is assumed to be secure. Compromise
> of the source QEMU process is nonetheless possible but exploiting the
> migration process is expected to grant no further privileges.

This is the tricky assumption.

Cnsider source host as 2 QEMU processes, one of tenant A and
one for tenant B.

If tenant A compromises their QEMU, and can wait until a live
migration for tenant B is initiating, potentially tenant A can
connect to a dest QEMU for tenant B. I would consider that to
be gaining privileges.

With TLS we lack fine grained authentication in common setups
today that rely on x509 certs configured per-host, not per-QEMU.

In current libvirt we're introducing oout of the box support for
TLS PSK, which means live migration sessions will be tied to
individual matched (src,dst) QEMU pairs, so even if tenant A is
compromised they would be able to do a TLS handshake for tenant
B's dst QEMU.

I'd like app mgmt apps to switch to PSK instad of x509 for
live migration, but that'll take along time.

None the less if we can assume the source QEMU is trusted,
then that eliminates a huge class of security vulnerabilities,
turning them all into hardening bugs, so I understand this is
very appealing to declare.

> For security consideration, the following are considered:
> 
> OUT OF SCOPE:
> 
> 1) Abort of destination QEMU process while migration is still in course.
> Rationale: the source virtual machine is not affected.

Ack.

> 
> 2) Migration failure.
> Rationale: eventual failed migrations are part of normal operation.

Ack.
 
> 3) Memory over-allocation issues in the destination QEMU process.
> Rationale: the destination host's operating system is expected to
> constrain resource usage. Process termination due to OOM falls under
> point 1 above.

Ack, that falls under our general exlclusion already too, though
we might finesse the language a bit more.

> IN SCOPE:
> 
> 1) Privilege escalation from the guest operating system into the
> destination QEMU process or host.
> 
> 2) Tampering or exfiltration of migration stream data by a third party
> at a lower privilege level than either QEMU processes involved in the
> migration.
> 
> 3) Termination of the source QEMU process by source virtual machine
> guest userspace, including by forcing host OS resource constraints to
> be reached.
> 
> 4) Other tampering or exfiltration of data from the source QEMU process
> if reached from migration code or migration stream manipulation.
> 
> 5) Causing source QEMU process to enter a state from which migration is
> not possible permanently.
> 
> The overall effect of this policy is that only legitimately produced
> migration data is considered for security implications, whether that
> data is malicious or buggy.

WIth this it seems like the only 2 scenarios where a migration security
flaw can be issued are:

 * Something goes wrong before/during the TLS handshake
 * A bug in source QEMU, somehow allows a guest OS user
   to set magic device data that turns into an exploitable
   VM state record.

Again, certainly appealing, but for the edge case that even with TLS,
we don't have fine grained access control, so we know the source is
a valid QEMU, but we don't know if it is the QEMU we expected.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


