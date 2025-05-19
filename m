Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35211C54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3jI-0003tD-N5; Mon, 19 May 2025 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3jG-0003sr-5H
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3jE-0007op-65
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747673558;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDqWAODbn3c/wdhBgzf7IetH2wliYZw6w0UMf7jjzZc=;
 b=UZMAimfTBTuxm8RyAsdjfzMDSOlVGOBMDEptgwO8USCwAoq4TxM/EPSyM+dL/pRyfLOrnH
 DBi63zLt0lIa2vrjKWyLSmi9Lem8TJpBIdBAKUsqw7EKugwPtmmwJ1IiqpeqMvID6XqmS7
 nUjX4yb8hvlfy0gQ6j03dVqCC4u58ZA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-CGK-ruVpN-yQH0UjXapd6g-1; Mon,
 19 May 2025 12:52:33 -0400
X-MC-Unique: CGK-ruVpN-yQH0UjXapd6g-1
X-Mimecast-MFC-AGG-ID: CGK-ruVpN-yQH0UjXapd6g_1747673552
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11E2C1956086; Mon, 19 May 2025 16:52:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F1EF1956096; Mon, 19 May 2025 16:52:30 +0000 (UTC)
Date: Mon, 19 May 2025 17:52:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 9/9] scripts/checkpatch: reject license boilerplate on
 new files
Message-ID: <aCthyqrQG8SaV1bg@redhat.com>
References: <20250519163721.347322-1-berrange@redhat.com>
 <20250519163721.347322-10-berrange@redhat.com>
 <CAFEAcA8e4YN03Z7H5bCoWuk5vGXpxEstRqbjjiUSuVx8XZkzcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8e4YN03Z7H5bCoWuk5vGXpxEstRqbjjiUSuVx8XZkzcQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 19, 2025 at 05:44:51PM +0100, Peter Maydell wrote:
> On Mon, 19 May 2025 at 17:37, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The previous commit mandates use of SPDX-License-Identifier on common
> > source files, and encourages it on all other files.
> >
> > Some contributors are none the less still also including the license
> > boilerplate text. This is redundant and will potentially cause
> > trouble if inconsistent with the SPDX declaration.
> >
> > Match common boilerplate text blurbs and report them as invalid,
> > for newly added files.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index dc2c3e6aa1..691c267a8c 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -365,6 +365,17 @@ our @typeList = (
> >         qr{guintptr},
> >  );
> >
> > +# Match text found in common license boilerplate comments:
> > +# for new files the SPDX-License-Identifier line is sufficient.
> > +our $LICENSE_BOILERPLATE = qr{
> > +    licensed under the terms of the GNU GPL|
> > +    under the terms of the GNU General Public License|
> > +    under the terms of the GNU Lesser General Public|
> > +    Permission is hereby granted, free of charge|
> > +    GNU GPL, version 2 or later|
> > +    See the COPYING file
> > +}x;
> > +
> >  # Load common spelling mistakes and build regular expression list.
> >  my $misspellings;
> >  my %spelling_fix;
> > @@ -1497,6 +1508,13 @@ sub process_end_of_file {
> >                              "' need 'SPDX-License-Identifier'?");
> >                 }
> >         }
> > +       if ($fileinfo->{action} eq "new" &&
> > +           !exists $fileinfo->{facts}->{sawboilerplate}) {
> 
> Looks like you still forgot to remove the "!" ?

Sigh, yes. Also the $LICENSE_BOILERPLATE var content is simply not matching
at all either, so the two problems made it look like it was working


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


