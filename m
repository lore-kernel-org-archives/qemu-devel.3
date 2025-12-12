Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2487D4337F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 08:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTyJd-0007Uw-9t; Fri, 12 Dec 2025 03:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTyJU-0007UR-9c
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 03:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTyJS-0002NP-EL
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 03:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765527340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlKBsI4iENKcLDg7B52bhTVdF22tUEXdzYWdOCMb9oE=;
 b=WJiZfUQjCUKBo/vOs1lKZLACMA8C/sso1o8e6vifNTLd2/BnDFeO/+GZnCliKdysx504Hb
 xEYM78aUVcybjP7vLDO0SdySskS/0Dx7ZTzYFu0MLtye7guPkEseYybIM5z33ewBQgqlWi
 ioN/OGq01zCbocObGuO3YWqO3HN3iDc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-KY0nArC1ObutgwjEyxKnHA-1; Fri,
 12 Dec 2025 03:15:34 -0500
X-MC-Unique: KY0nArC1ObutgwjEyxKnHA-1
X-Mimecast-MFC-AGG-ID: KY0nArC1ObutgwjEyxKnHA_1765527333
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3446B18001D6; Fri, 12 Dec 2025 08:15:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B6F319560B4; Fri, 12 Dec 2025 08:15:31 +0000 (UTC)
Date: Fri, 12 Dec 2025 08:15:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
Message-ID: <aTvPDXZjfp4_egTa@redhat.com>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 06:01:23PM +0000, Alex Bennée wrote:
> *incomplete
> 
> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
> slightly at figuring out what I would need to change in the perl
> script to cleanly handle it.
> 
> While we imported the perl script from the kernel I'm fairly sure we
> don't use half the features it has and as us grey beards age out less
> people will be willing to tweak it. Consider this a proof-of-concept
> for discussion about if it is worth perusing this path.
> 
> It only supports the two main forms:
> 
>   ./scripts/get_maintainer.py -f path/to/file
>   ./scripts/get_maintainer.py path/to/patch1 path/to/patch2 ...
> 
> But who needs more?

the $QEMU/.gitpublish file contains

cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null

And the .b4-config file contains the same:

send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback


Is trawling the git history to guess at maintainers useful
for regular usage, while undesirable for sending patches,
or should we just pick a behaviour use it unconditionally?

> 
> Future improvements could include some more detailed analysis in
> conjugation with the repo to analysis:
> 
>   - missing areas of coverage
>   - maintainer stats
> 
> Who knows maybe the kernel guys will want to import our script one day
> ;-)
> 
> Alex.
> 
> Alex Bennée (9):
>   MAINTAINERS: fix missing names
>   MAINTAINERS: fix libvirt entry
>   MAINTAINERS: regularise the status fields
>   scripts/get_maintainer.py: minimal argument parsing
>   scripts/get_maintainer.py: resolve the source path
>   scripts/get_maintainer.py: initial parsing of MAINTAINERS
>   scripts/get_maintainer.py: add support for -f
>   scripts/get_maintainer.py: add support reading patch files
>   gitlab: add a check-maintainers task
> 
>  MAINTAINERS                    |  10 +-
>  .gitlab-ci.d/static_checks.yml |   9 +
>  scripts/get_maintainer.py      | 356 +++++++++++++++++++++++++++++++++
>  3 files changed, 370 insertions(+), 5 deletions(-)
>  create mode 100755 scripts/get_maintainer.py
> 
> -- 
> 2.47.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


