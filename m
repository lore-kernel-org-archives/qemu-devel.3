Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2W/hXjC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRMZ-0003id-G5; Thu, 29 Oct 2026 10:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMRMX-0003iS-Gg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMRMV-00087j-8Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793285054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkarqvwLDyEO2/KUFbXosq2zlWvQV4x3XVi40EkEa1U=;
 b=a2W/hXjC6tr685oFqkGvo17FFjeUDJPwpZ/uaVRJLcqzcsrh27IKjQJDJeKRULU8Un0rNU
 HvcQmnewm44G+QJKgE+AOvFnkh9JXYJv6nVzsodLhmYsY4Cf8vAJpig7Ja5lDtFS6WRIkP
 dsFXCglqR5pzkE/7nb4B2DfmTU4+fUQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-4Nd2JNKiPbCItdhXP0QPiA-1; Thu,
 29 Oct 2026 10:44:06 -0400
X-MC-Unique: 4Nd2JNKiPbCItdhXP0QPiA-1
X-Mimecast-MFC-AGG-ID: 4Nd2JNKiPbCItdhXP0QPiA_1793285045
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E68841800840
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 14:44:04 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C76D195608B; Thu, 29 Oct 2026 14:44:03 +0000 (UTC)
Date: Thu, 29 Oct 2026 14:44:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 7/8] qemu-options: document -compat insecure-input
 parameter
Message-ID: <auNbsWoszxqqngPD@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-8-berrange@redhat.com>
 <871p99gfrf.fsf@pond.sub.org> <auMmXsaXkKTzy4Mj@redhat.com>
 <87wlr0bnmo.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlr0bnmo.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 03:13:51PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Oct 29, 2026 at 07:52:36AM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > This adds documentation for the previously added 'insecure-input'
> >> > parameter to -compat, which controls policy for insecure
> >> > configuration requests.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  qemu-options.hx | 22 +++++++++++++++++++++-
> >> >  1 file changed, 21 insertions(+), 1 deletion(-)

> > If we put a check in qdev_realize(), then we need to add annotations
> > for *all* types, before the -compat insecure-input=....  option is
> > viable to use. That requires a much bigger effort to mark all types.
> >
> > In the 12.0 dev cycle, my intention is to
> >
> >  a) Expand ".secure = true" markers to all parents of leaf node types
> >     marked secure, and enforce them.
> >  b) Expand ".secure = true" markers to all built-in devices that are
> >     indirectly created by a leaf node type marked secure, when
> >     -nodefaults is present
> >
> > Once (b) is done, then qdev_realize() will likely be the better place
> > to put the policy check.
> 
> Let's see whether I got this.
> 
> * A type can be known to be secure, known to be insecure, or unknown.
>
> * Exactly the types known to be secure are marked secure.  Thus, the
>   policy check must treat known to be insecure and unknown the same,
>   which makes sense.

Yes, we're explicitly not distinguishing 'insecure' vs 'unknown' either
internally or externally. Something is either explicitly marked as secure,
otherwise it is insecure.

> * We start with all types unknown.

aka all types are insecure.

> * To move a type from unknown to known, we need to examine it.
>   Examining all types in time for the next release is infeasible.  Even
>   examining all types usable with a useful set of machines is
>   infeasible.  What is feasible is examining a useful set of types
>   available with certain user interfaces, so that's what we did.

Yes.

> * We check the policy in these interfaces only.  This lets users
>   restrict these interfaces to known secure types, which is useful.

Yes.

> * However, types created differently get a blanket exception.  Not
>   ideal, but no worse than before, unless the new policy creates a false
>   sense of security.  The best we can (and should) do about that is to
>   clearly document the policy's current limitations.
> 
> Right?

Yes.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


