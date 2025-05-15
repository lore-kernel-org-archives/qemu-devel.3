Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B007C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbZh-00055g-0R; Thu, 15 May 2025 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFbZP-00053i-8d
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFbZL-0004N6-O7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747326985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUtzErQcFZYL276xJXtCuYGZ4TdheGVbanZopLufcZ4=;
 b=LXvulSpMHNv8+CVd5ZvfJAC1M6+wE0RPwYJ7wo2McJIeWK/SvCCJ2SO4GiqCucw9MesJgo
 nHH8GU/QB+3Ln8oa3ENztc42ehicd8F1gh8SrayF2OkXLaJyDxRQ++AT3TZDLS15qL5+ZH
 GNYY766UkgCOpr+lEKX46M1GGeHvM2U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-zEaYaVieN4itZxSI-aESdA-1; Thu,
 15 May 2025 12:36:21 -0400
X-MC-Unique: zEaYaVieN4itZxSI-aESdA-1
X-Mimecast-MFC-AGG-ID: zEaYaVieN4itZxSI-aESdA_1747326980
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18161800876; Thu, 15 May 2025 16:36:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 404AE18003FC; Thu, 15 May 2025 16:36:18 +0000 (UTC)
Date: Thu, 15 May 2025 17:36:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on
 new files
Message-ID: <aCYX_97dN6n27y9Z@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-10-berrange@redhat.com>
 <aCYQtA4cU2xPyvPo@redhat.com>
 <353e8a52-b03c-438c-8236-8f5b6968acf4@redhat.com>
 <74571c3c-2a0e-465f-ac19-d9ca5504bee1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74571c3c-2a0e-465f-ac19-d9ca5504bee1@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Thu, May 15, 2025 at 06:19:45PM +0200, Cédric Le Goater wrote:
> On 5/15/25 18:06, Cédric Le Goater wrote:
> > On 5/15/25 18:05, Daniel P. Berrangé wrote:
> > > On Thu, May 15, 2025 at 02:59:36PM +0100, Daniel P. Berrangé wrote:
> > > > The previous commit mandates use of SPDX-License-Identifier on common
> > > > source files, and encourages it on all other files.
> > > > 
> > > > Some contributors are none the less still also including the license
> > > > boilerplate text. This is redundant and will potentially cause
> > > > trouble if inconsistent with the SPDX declaration.
> > > > 
> > > > Match common boilerplate text blurbs and report them as invalid,
> > > > for newly added files.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >   scripts/checkpatch.pl | 16 ++++++++++++++++
> > > >   1 file changed, 16 insertions(+)


> It is now catching valid errors on :
> 
> 
> * https://lore.kernel.org/qemu-devel/20250512180230.50129-5-rreyes@linux.ibm.com/
>   ERROR: New file 'hw/s390x/ap-stub.c' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   total: 1 errors, 0 warnings, 67 lines checked
> 
> * https://lore.kernel.org/qemu-devel/1747063973-124548-7-git-send-email-steven.sistare@oracle.com/
>   ERROR: New file 'hw/vfio/cpr-legacy.c' requires 'SPDX-License-Identifier'
>   ERROR: New file 'hw/vfio/cpr-legacy.c' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   WARNING: added, moved or deleted file(s):
> 
> * https://lore.kernel.org/qemu-devel/1747063973-124548-36-git-send-email-steven.sistare@oracle.com/
>   ERROR: New file 'hw/vfio/cpr-iommufd.c' requires 'SPDX-License-Identifier'
>   ERROR: New file 'hw/vfio/cpr-iommufd.c' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   WARNING: added, moved or deleted file(s):
>     hw/vfio/cpr-iommufd.c
>   Does MAINTAINERS need updating?
>   total: 2 errors, 1 warnings, 161 lines checked
> 
> * https://lore.kernel.org/qemu-devel/20250515154413.210315-1-john.levon@nutanix.com
>   ERROR: New file 'hw/vfio-user/container.h' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   ERROR: New file 'hw/vfio-user/container.c' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   ERROR: New file 'hw/vfio-user/pci.c' must not have license boilerplate header text unless this file is copied from existing code with such text already present.
>   WARNING: Does new file 'hw/vfio-user/meson.build' need 'SPDX-License-Identifier'?
>   total: 3 errors, 1 warnings, 490 lines checked
> 
> 
> and more.

That nicely demonstrates the value of this extra check :-)

> 
> 
> Tested-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


