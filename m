Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B326CFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqvP-00040b-9k; Mon, 07 Oct 2024 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxqvG-00040D-UI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxqvF-0001hv-5k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728319763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGRyBWHIwZqg96fn/eepaCq3cwJw9gO6H3WK60kAjOg=;
 b=Pk6SalK+gPOzizPlC4uZV5F0WrMLOI8xzhRuGh2DCHGf0T8TnphHCxMIVmpWxx16Oi85ij
 aA9ZSnMsFmKFzlKEUYM99S2Y3DQGoTVR/3ky0RhAex95+YYRVHc9l/w8JGSZ/ryz5NIV8A
 nBXh++ntfRzfI7m6xQvP/O/hwDrkH3k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-mPEuz9tZPMGZjJwRz89sqw-1; Mon,
 07 Oct 2024 12:49:20 -0400
X-MC-Unique: mPEuz9tZPMGZjJwRz89sqw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77F2C1955EA5; Mon,  7 Oct 2024 16:49:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA4E1956088; Mon,  7 Oct 2024 16:49:17 +0000 (UTC)
Date: Mon, 7 Oct 2024 17:49:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] scripts: validate SPDX license choices
Message-ID: <ZwQRCi-orF8FXXsU@redhat.com>
References: <20241007154548.1144961-1-berrange@redhat.com>
 <20241007154548.1144961-3-berrange@redhat.com>
 <0ac9546e-2b0d-46f1-8c5c-fc75529aa682@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ac9546e-2b0d-46f1-8c5c-fc75529aa682@quicinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Mon, Oct 07, 2024 at 11:19:15AM -0500, Brian Cain wrote:
> 
> On 10/7/2024 10:45 AM, Daniel P. Berrangé wrote:
> > We expect all new code to be contributed with the "GPL-2.0-or-later"
> > license tag. Divergance is permitted if the new file is derived from
> > pre-existing code under a different license, whether from elsewhere
> > in QEMU codebase, or outside.
> > 
> > Issue a warning if the declared license is not "GPL-2.0-or-later",
> > and an error if the license is not one of the handful of the
> > expected licenses to prevent unintended proliferation.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 66 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index cc266abdcd..cd1ed90f4c 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1353,6 +1353,67 @@ sub checkfilename {
> >   	}
> >   }
> > +sub checkspdx {
> > +    my ($file, $expr) = @_;
> > +
> > +    # Imported Linux headers probably have SPDX tags, but if they
> > +    # don't we're not requiring contributors to fix this
> > +    if ($file =~ m,include/standard-headers, ||
> > +	$file =~ m,linux-headers,) {
> > +	return;
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
> > +	LGPL-2.0-or-later
> > +	LGPL-2.1-or-later
> > +	GPL-2.0-only
> > +	LGPL-2.0-only
> > +	LGPL-2.0-only
> > +	BSD-2-Clause
> > +	BSD-3-Clause
> > +	MIT
> > +	);
> > +
> > +    my $nonpreferred = 0;
> > +    my @unknown = ();
> > +    foreach my $bit (@bits) {
> > +	if ($bit eq $prefer) {
> > +	    next;
> > +	}
> > +	if (grep /^$bit$/, @valid) {
> > +	    $nonpreferred = 1;
> > +	} else {
> > +	    push @unknown, $bit;
> > +	}
> > +    }
> > +    if (@unknown) {
> > +	ERROR("Saw unacceptable licenses '" . join(',', @unknown) .
> > +	      "', valid choices for QEMU are:\n" . join("\n", $prefer, @valid));
> > +    }
> > +
> > +    if ($nonpreferred) {
> > +	WARN("Saw acceptable license '$origexpr' but note '$prefer' is preferred " .
> > +	     "for new files unless the code is derived from a source with an" .
> > +	     "existed declared license that must be followed.");
> 
> Is it not preferred to contribute code under the BSD-3-clause? Based on
> other items in the project, I was expecting we could make contributions for
> hexagon w/BSD.  But those are exceptional cases and not to be followed in
> the general case?

I'm not saying people can't contribute under BSD, but if that is required,
a explanation of why is desired.

IMHO we don't want contributors choosing an non-GPL-2.0-or-later license
merely out of personal (or corporate) preferences.

We want GPL-2.0-or-later to be used for everything, unless there is a
compelling reason to diverge. The need to remain compliant with existing
code that has been incorporated is the most common & obvious reason for
this.

Other reasons likely exist - which could be explained in the commit
message, to aid reviewers who are likely to see the checkpatch warnings
about the unusal license choices.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


