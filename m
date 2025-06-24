Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9191C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTzbc-0002th-65; Tue, 24 Jun 2025 05:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uTzbM-0002sw-TL
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uTzbK-0005A7-Qt
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750755956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSPfIiDu643dlZeSzOOP4nQan6lK/PDb2RE1Gb4Rm90=;
 b=EOSX7gP54bT/BAmHQW9NeTSkM3F8VBlKMZc+6A475Zbu8zMejCfIm7fL7b8YR3EM4RdLy6
 oQ4kKTSLMmIu9Jv5EOfgeIVMvm7SPIs5Nupth8EIX2GfXpkggF+Qn8+pkNiqzefHWSdkbZ
 rVTztJxB4woRNv9nkIalKyrmvOYQ0ew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-1NqCK5vvONe3Fe6nU4ukCQ-1; Tue,
 24 Jun 2025 05:05:51 -0400
X-MC-Unique: 1NqCK5vvONe3Fe6nU4ukCQ-1
X-Mimecast-MFC-AGG-ID: 1NqCK5vvONe3Fe6nU4ukCQ_1750755950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF511956089; Tue, 24 Jun 2025 09:05:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5802E180035E; Tue, 24 Jun 2025 09:05:47 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:05:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: add license tag to some files
Message-ID: <aFpqaC8HGEK5A7dV@redhat.com>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 24, 2025 at 10:34:40AM +0200, Cédric Le Goater wrote:
> + Daniel
> 
> On 6/23/25 11:30, John Levon wrote:
> > Add SPDX-License-Identifier to some files missing it in hw/vfio/.
> > 
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >   hw/vfio/trace.h      | 3 +++
> >   hw/vfio/Kconfig      | 2 ++
> >   hw/vfio/meson.build  | 2 ++
> >   hw/vfio/trace-events | 2 ++
> >   4 files changed, 9 insertions(+)
> 
> I think that's OK to add a GPL-2.0-or-later SPDX tag on these files
> because they are simple infrastructure files, and we know when they
> come from. How useful it is ? that I don't know.
> 
> For other source files, without a license, if we have any, I think
> the answer would be much more complex.
> 
> Daniel, What would be our position on such files ?

The only hard requirement we have stated is that all /newly/ created
files ("new" as in git patch reports it as a new file) must have the
SPDX tag, and must NOT have license boilerplate. This is enforced by
checkpatch.

We are NOT expecting SPDX tags to be added to existing files in
general, whether they have a license boilerplate or not.

Adding SPDX tags to existing files without any boilerplate text
at all is likely the more interesting & beneficial scenario
though.

If adding SPDX tags to existing files, you must do due diligence
over the history of the file, in order to validate the implicit
license it would have had based on QEMU's rules when the file was
first created. We can't just blindly assume it was GPL-2.0-or-later,
as it might have been copied from elsewhere when first created and
thus inherit terms from another file.

For the specific 4 files in this patch, I think it is unlikely there
will be any surprises in their license history though. They all post-date
our top level  statement that new contributions are implicitly
GPL2.0-or-later, and also won't have been copied from elsewhere.

TL;DR: this patch looks reasonable, and we might as well take it, but
there is no expectation that people need to extend this work across the
code tree unless they love doing historical code tracing :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


