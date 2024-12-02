Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2036BD78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9hH-0003S9-QN; Mon, 02 Dec 2024 11:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI9hF-0003Rk-LI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI9hD-0007bu-V7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733158490;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjvByZRhwo02fiZJGa8ZK6AH3zJ1cEqVr97haE5IKJQ=;
 b=d1pysHDO6Iz1jNHSTiaY0fB1qit7s3mDLHmnXEJLKELwGx8ZBX2lmQJ+L/DH4Kyr3bGhbb
 zjbP/TVn+e5c4S1N2CcWYCt67ysoHbiYYWw5HPOnd4WH/uzt7zQs4Bt2NvZgbKBQm9icMY
 CEwinDqHpMzEZwGF43xhMe5fXmncUYo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-EC7g2KchMrSY4UMWFfqffw-1; Mon,
 02 Dec 2024 11:54:44 -0500
X-MC-Unique: EC7g2KchMrSY4UMWFfqffw-1
X-Mimecast-MFC-AGG-ID: EC7g2KchMrSY4UMWFfqffw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D6EC1955DD1; Mon,  2 Dec 2024 16:54:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E8581955EA7; Mon,  2 Dec 2024 16:54:41 +0000 (UTC)
Date: Mon, 2 Dec 2024 16:54:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/3] scripts: validate SPDX license choices
Message-ID: <Z03mTZVxCrYVXKDy@redhat.com>
References: <20241119112903.1010350-1-berrange@redhat.com>
 <20241119112903.1010350-3-berrange@redhat.com>
 <CAFEAcA9osyiBuFNz6i=WwbJqgg_Gby3OALCvXdhoG1tJJnZLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9osyiBuFNz6i=WwbJqgg_Gby3OALCvXdhoG1tJJnZLLw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 02, 2024 at 04:41:48PM +0000, Peter Maydell wrote:
> On Tue, 19 Nov 2024 at 11:29, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > We expect all new code to be contributed with the "GPL-2.0-or-later"
> > license tag. Divergance is permitted if the new file is derived from
> 
> "divergence"
> 
> > pre-existing code under a different license, whether from elsewhere
> > in QEMU codebase, or outside.
> >
> > Issue a warning if the declared license is not "GPL-2.0-or-later",
> > and an error if the license is not one of the handful of the
> > expected licenses to prevent unintended proliferation. The warning
> > asks users to explain their unusual choice of license in the commit
> > message.
> 
> Should we update LICENSE (or something under docs/devel ?) to
> state our policy ?

Yeah, we really ought to, i'll have a look at it.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 68 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index d946121b8e..b507da8e2b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1353,6 +1353,69 @@ sub checkfilename {
> >         }
> >  }
> >
> > +sub checkspdx {
> > +    my ($file, $expr) = @_;
> > +
> > +    # Imported Linux headers probably have SPDX tags, but if they
> > +    # don't we're not requiring contributors to fix this, as these
> > +    # files are not expected to be modified locally in QEMU
> > +    if ($file =~ m,include/standard-headers, ||
> > +       $file =~ m,linux-headers,) {
> > +       return;
> > +    }
> > +
> > +    my $origexpr = $expr;
> > +
> > +    # Flatten sub-expressions
> > +    $expr =~ s/\(|\)/ /g;
> > +    $expr =~ s/OR|AND/ /g;
> > +
> > +    # Merge WITH exceptions to the license
> > +    $expr =~ s/\s+WITH\s+/-WITH-/g;
> > +
> > +    # Cull more leading/trailing whitespace
> > +    $expr =~ s/^\s*//g;
> > +    $expr =~ s/\s*$//g;
> > +
> > +    my @bits = split / +/, $expr;
> > +
> > +    my $prefer = "GPL-2.0-or-later";
> > +    my @valid = qw(
> > +       LGPL-2.0-or-later
> > +       LGPL-2.1-or-later
> > +       GPL-2.0-only
> > +       LGPL-2.0-only
> > +       LGPL-2.0-only
> 
> Lists LGPL-2.0-only twice ? I'm guessing the second should be 2.1.

Opps, indeed 2.1

> I'm not sure we really want to allow more LGPL-2.0-only
> code...we don't have a reason like we do with GPL-2.0-only
> where the reason is "code from the kernel", and I feel like
> LGPL-2.0-only is quite rare anyway, and at least sometimes
> a mistake where the author meant LGPL-2.1-only or GPL-2.0-only.
> But maybe this list should be generous enough to only warn,
> not error, for code copied within QEMU.

Reliably identifying that a patch is merely "copying code within
QEMU" is a non-trivial task. I'm not sure its worth the effort,
given that we always have the option of ignoring the script's
advice if a human knows better.

> AFAICT the only code we have that is LGPL-2.0-only is
> util/error.c. But that also refers to our COPYING.LIB,
> which is LGPL2.1. In 2011, 12 years after the publication
> of LGPL2.1, did Anthony Liguori *really* mean to use
> LGPL2.0 only? Answers on a postcard :-)

I'm fine dropping LGPL2.0-or-later and LGPL2.0-only,
for the very reasons you state.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


