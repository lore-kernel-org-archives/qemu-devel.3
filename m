Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF618C54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3FB-00041k-2j; Mon, 19 May 2025 12:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3F8-00040Q-Ts
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3F6-00048a-72
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747671688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdamgj5+B+dh0vmlthpTFu/+l6ROgjszWTALfade4F4=;
 b=d0ZxqbrqtWt55yQwph3q3OYrXM+xfM/xfnSY28FtcmTQZD5rTMV+62ZW19XbFP2G56EMXq
 g9FqE2Vdcti1EB/HJHSuF7N5oZZIecJKBMxiGpJWcFAccz9w8rynqI52+SZZCyHzlfVClc
 og4Z6WmSDyMA6qBZunCpBKPCZY0gIXg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-SIdPmtuwPBKGaZCQ2cnTxw-1; Mon,
 19 May 2025 12:21:24 -0400
X-MC-Unique: SIdPmtuwPBKGaZCQ2cnTxw-1
X-Mimecast-MFC-AGG-ID: SIdPmtuwPBKGaZCQ2cnTxw_1747671683
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D56F1800361; Mon, 19 May 2025 16:21:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A61651956095; Mon, 19 May 2025 16:21:21 +0000 (UTC)
Date: Mon, 19 May 2025 17:21:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 4/9] scripts/checkpatch: use new hook for ACPI test
 data check
Message-ID: <aCtafZzukG70C7Yh@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-5-berrange@redhat.com>
 <CAFEAcA-jicD=aatno+6Vv4HS4MA+j+rQPrO6wFrUM8fYsF_hVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-jicD=aatno+6Vv4HS4MA+j+rQPrO6wFrUM8fYsF_hVg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Mon, May 19, 2025 at 01:29:14PM +0100, Peter Maydell wrote:
> On Thu, 15 May 2025 at 14:59, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The ACPI test data check needs to analyse a list of all files in a
> > commit, so can use the new hook for processing the file list.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 61 ++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 32 deletions(-)
> 
> 
> 
> > @@ -1770,9 +1769,7 @@ sub process {
> >                      $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> >                      ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> >                       (defined($1) || defined($2)))) &&
> > -                      !(($realfile ne '') &&
> > -                        defined($acpi_testexpected) &&
> > -                        ($realfile eq $acpi_testexpected))) {
> > +                   $realfile !~ m#^tests/data/acpi/#) {
> 
> Is the indentation off on this line?

It looks like it from this diff, but it is actually correct, as it was
moved outside the inner two sets of brackets.

> 
> >                         $reported_maintainer_file = 1;
> >                         WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> >                 }
> > --
> 
> Otherwise
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


