Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE852606A333
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMj7NtQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPG8q-00056N-RG; Fri, 06 Nov 2026 04:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPG8p-00055x-Ba
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPG8n-0004YZ-LG
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 04:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793956904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=O/TdazM9p37pcwtRbKjLbShsrIeXr2NmA7Ax+YssGes=;
 b=XMj7NtQPsJOBF0VkH37PcO4l1kG/zqecQCiL9ZCEPZwsJM+753lSHCnIs7C7PJL5cgaO+1
 KFZzz3tnJfsF/PWqZUa7urUHjQlugOCIGebbdsXNCOf0cP+V2J8dgGcmsHLkPMpzexmj6a
 VA2uztesFsxTNtj8pibT+oiix4ZKALs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-3bFfw7j3P4W-H_hOOz5jPg-1; Fri,
 06 Nov 2026 04:21:38 -0500
X-MC-Unique: 3bFfw7j3P4W-H_hOOz5jPg-1
X-Mimecast-MFC-AGG-ID: 3bFfw7j3P4W-H_hOOz5jPg_1793956897
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63E5C1955F78; Fri,  6 Nov 2026 09:21:36 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB8871800347; Fri,  6 Nov 2026 09:21:33 +0000 (UTC)
Date: Fri, 6 Nov 2026 09:21:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Oleg Drokin <green@linuxhacker.ru>, qemu-devel <qemu-devel@nongnu.org>,
 QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: fixes for stable qemu series
Message-ID: <au2cGqMNssHcxCXd@redhat.com>
References: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 12:15:06PM +0300, Michael Tokarev wrote:
> Hi!
> 
> What's the way you use to find these patches, with security impact or not?
> 
> I usually quickly screen all new commits in the master branch, and often
> catch things which aren't marked for-stable, - not everything of interest
> is marked as such.  I also tend to remind the maintainers about these
> markings.  But my resources here are limited, I can't try to understand
> every patch, even description of it.
> 
> How do you perform a security review?

FWIW, with our new security triage process, we should be fairly
reliably getting issues in gitlab tagged with CVE::Assigned, if
they have been accepted as an in-scope security issue and had a
CVE assigned.

Those issues should include a link to the mailing list with posted
patches, and also get auto-linked to a merged commit by gitlab.

So if you want to sanity check stable branch content for missing
security fixes, I'd sugest following the CVE::Assigned labels.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


