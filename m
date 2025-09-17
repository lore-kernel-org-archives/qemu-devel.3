Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDE4CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuxB-0001jG-UD; Wed, 17 Sep 2025 12:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyuxA-0001hk-Mw
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyux8-0001pI-BE
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758126256;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRHnJN82Q6neblgjJaj1n38gOYaPkcpyNi//Z7okooI=;
 b=WdtdQZiCMXZmluN+92rpQsAyfswPoP9zyoFojEm8e7QrgxT1q3Zha9AEsxqhTSfQIMHbGm
 VeVf5jrcTIrMm2hFnddIPsrLsgsh7smaOao1f2vo0Ogsxws96U0oNQLAaXZEJdMXcDefjm
 Dky6kH601Zx2zvl8V1dz+scu0MZCAqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-8yPemAi5M9WBjl7Vjl5Hrg-1; Wed,
 17 Sep 2025 12:24:13 -0400
X-MC-Unique: 8yPemAi5M9WBjl7Vjl5Hrg-1
X-Mimecast-MFC-AGG-ID: 8yPemAi5M9WBjl7Vjl5Hrg_1758126252
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5065A18002C3; Wed, 17 Sep 2025 16:24:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0F6319560B1; Wed, 17 Sep 2025 16:24:08 +0000 (UTC)
Date: Wed, 17 Sep 2025 17:24:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
Message-ID: <aMrgo5p8_i7ANrez@redhat.com>
References: <20250916165928.10048-1-nabihestefan@google.com>
 <aMp-MzBE19NORy4Y@redhat.com>
 <CA+QoejWaM+K895k=WcRndq=BNe1kNfJ4L5APKyk4+GHhmQLD0g@mail.gmail.com>
 <aMrcTg0J-dQuPkhI@redhat.com>
 <CA+QoejUbyre_ePvhDZ=t7hnLkrHrSAJPBRjfob22dx-DOO_u-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+QoejUbyre_ePvhDZ=t7hnLkrHrSAJPBRjfob22dx-DOO_u-g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 17, 2025 at 09:17:57AM -0700, Nabih Estefan wrote:
> On Wed, Sep 17, 2025 at 9:05 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 08:16:53AM -0700, Nabih Estefan wrote:
> > > We ran it against an internal patch that we were updating, so I can't
> > > show you the patch.
> >
> > If you can't share that private patch, perhaps you can create a
> > dummy patch with the same type of diff structure that shows the
> > problem ?
> >
> The patch looks something like the following:

snip

> It's just changing the file from an invalid  to a valid one, nothing else is
> being done, which is why I'm confused how it's triggering this.

Ahhh, I was getting confused about which SPDX check was being
triggered.

The one that runs against "new" files only is a check for the
existence of a SPDX tag.

The one that runs against all files is a check for the declared
license check.

So yes, your patch here is correct & required so

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> > > However, the difference on it being affected might be in how we're
> > > running it? To check
> > > against just the changes being done in the specific patch, instead of
> > > the whole file, we
> > > trigger it by running `./scripts/checkpatch.pl --branch HEAD...HEAD^`.
> > > Could that be
> > > why it's triggering against existing files?
> >
> > I don't think that's a problem. It is just a different way ot getting
> > a list of git commit hashes to analyse - it'll still operate against
> > a patch diff IIUC.
> >
> > FWIW, I use   'checkpatch.pl master..' and/or 'git show| checkpatch.pl -'
> >
> > >
> > > Thanks,
> > > Nabih
> > >
> > > On Wed, Sep 17, 2025 at 2:24 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 04:59:28PM +0000, Nabih Estefan wrote:
> > > > > When running the license check, if we are updating a license it is
> > > > > possible for the checkpatch script to test against old license lines
> > > > > instead of newer ones, since the removal lines appear before the
> > > > > addition lines in a .patch file.
> > > >
> > > > While we match the "SPDX-License-Identifier" text in any context,
> > > > the "file must have SDPX" validation is only performed against
> > > > files that are entirely new:
> > > >
> > > >   # Called at the end of processing a diff hunk for a file
> > > >   sub process_end_of_file {
> > > >         my $fileinfo = shift;
> > > >
> > > >         if ($fileinfo->{action} eq "new" &&
> > > >             !exists $fileinfo->{facts}->{sawspdx}) {
> > > >              ...raise error ....
> > > >
> > > > > Fix this by skipping over lines that start with "-" in the checkpatch
> > > > > script.
> > > >
> > > > A new file cannot have any "-" lines present, so there isn't any
> > > > bug that needs fixing AFAICT.  Can you show any patch or commit
> > > > where this would have made a difference to what checkpatch.pl
> > > > reports ?
> > > >
> > > > >
> > > > > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > > > > ---
> > > > >  scripts/checkpatch.pl | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > index 833f20f555..c57a423f9f 100755
> > > > > --- a/scripts/checkpatch.pl
> > > > > +++ b/scripts/checkpatch.pl
> > > > > @@ -1813,7 +1813,8 @@ sub process {
> > > > >               }
> > > > >
> > > > >  # Check SPDX-License-Identifier references a permitted license
> > > > > -             if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
> > > > > +             if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
> > > > > +                     $rawline !~ /^-/) {
> > > > >                       $fileinfo->{facts}->{sawspdx} = 1;
> > > > >                       &checkspdx($realfile, $1);
> > > > >               }
> > > > > --
> > > > > 2.51.0.384.g4c02a37b29-goog
> > > > >
> > > >
> > > > With regards,
> > > > Daniel
> > > > --
> > > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > > > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > > >
> > >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


