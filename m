Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D37C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOXM-0001tT-6A; Fri, 09 May 2025 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDOXJ-0001qU-LO
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDOXH-0006RP-DX
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746800229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4B/XRA3ocdR5CZSQRjgZduhbbk16fc1DfTg9T0hXso=;
 b=bFhAnlhktMeUMsvIntE5+VUoTsysjLzk2KtnbNZoEg075b+R9z/7vFellZ/eHYp4IMqAA0
 I3DIUUzUakoj+GCo+tKJFCN60oWjrfuDQPiPm7L6gxreEJBmhdi98suXRfPtwZWhLAwAGk
 9aLbwY/D28VGoZ0yz2qq97SZi0fSPFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-03Ebc8mUMoeTXrxfgtJcmQ-1; Fri,
 09 May 2025 10:17:07 -0400
X-MC-Unique: 03Ebc8mUMoeTXrxfgtJcmQ-1
X-Mimecast-MFC-AGG-ID: 03Ebc8mUMoeTXrxfgtJcmQ_1746800227
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA5D91800370; Fri,  9 May 2025 14:17:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9283918008DC; Fri,  9 May 2025 14:17:05 +0000 (UTC)
Date: Fri, 9 May 2025 15:17:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] scripts/checkpatch: reimplement
 SPDX-License-Identifier detection
Message-ID: <aB4OXRm39r_pGQTf@redhat.com>
References: <20250508170100.876374-1-berrange@redhat.com>
 <20250508170100.876374-3-berrange@redhat.com>
 <CAFEAcA92ozQyydi6ZKc6+-bZ+-ArXDksnWtb7KJb53hmD7BKAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA92ozQyydi6ZKc6+-bZ+-ArXDksnWtb7KJb53hmD7BKAQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 09, 2025 at 02:01:32PM +0100, Peter Maydell wrote:
> On Thu, 8 May 2025 at 18:01, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The new attempt at detecting missing SPDX-License-Identifier in
> > new files is using the following logic
> >
> >  * When seeing a line starting 'diff --git ...' it indicates
> >    the start of a file in the patch. This must trigger reporting
> >    of violations in the previous file (if any).
> >
> >    It must reset the validation state, since this may now be a
> >    pre-existing file being changed. This will be resolved by
> >    the next rule.
> >
> >  * When seeing a line starting 'new file mode...' it indicates
> >    a newly created file and must enable SPDX validation.
> >
> >  * When seeing EOF, it must trigger reporting of violations in
> >    the last new file in the patch, if any.
> 
> > @@ -1442,6 +1457,8 @@ sub process {
> >         my $in_imported_file = 0;
> >         my $in_no_imported_file = 0;
> >         my $non_utf8_charset = 0;
> > +       my $expect_spdx = 0;
> > +       my $expect_spdx_file;
> >
> >         our @report = ();
> >         our $cnt_lines = 0;
> > @@ -1679,9 +1696,38 @@ sub process {
> >                         WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> >                 }
> >
> > +# All new files should have a SPDX-License-Identifier tag
> > +               if ($line =~ /^diff --git/) {
> > +                   # Start of file diff marker, report last file if it failed
> > +                   # SPDX validation
> > +                   if (defined $expect_spdx_file) {
> > +                       &check_spdx_present($expect_spdx_file);
> > +                   }
> > +
> > +                   # Reset state ready to find new file
> > +                   $expect_spdx = 0;
> > +                   $expect_spdx_file = undef;
> 
> 
> We already have a point in the code where we say "ah, this looks
> like the start of a new file" (under the comment "extract the
> filename as it passes"), and it looks for two possible regexes,
> not just "diff --git". Maybe we should combine these so that
> we have something like
> 
>                 if ($line =~ /^diff --git.*?(\S+)$/) {
>                         handle_end_of_file($realfile) if $realfile ne '';
>                         $realfile = $1;
>                         $realfile =~ s@^([^/]*)/@@ if (!$file);
>                         handle_start_of_file($realfile);
>                 } elsif ($line =~ /^\+\+\+\s+(\S+)/) {
>                         handle_end_of_file($realfile) if $realfile ne '';
>                         $realfile = $1;
>                         $realfile =~ s@^([^/]*)/@@ if (!$file);
>                         handle_start_of_file($realfile);
> 
>                         $p1_prefix = $1;
>                         if (!$file && $tree && $p1_prefix ne '' &&
>                             -e "$root/$p1_prefix") {
>                                 WARN("patch prefix '$p1_prefix'
> exists, appears to be a -p0 patch\n");
>                         }
> 
>                         next;
> 
> (side note: seems odd that we have 'next' here but not in the
> previous half of this if()...)
> 
>                 }
> 
> and move checkfilename() to inside handle_start_of_file(),
> and have the spdx check handling done inside
> handle_start_of_file() and handle_end_of_file() ?
> 
> > +       # End of diff, report last file block if it failed
> 
> and we would call
>           handle_end_of_file($realfile) if $realfile ne '';

Yeah, having standlone handle_start_of_file/handle_end_of_file
methods would make it easier to understand what's going on, as
this method with all the check rules is insanely long and hard
to follow.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


