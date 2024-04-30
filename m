Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10C4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kDM-000428-Tu; Tue, 30 Apr 2024 05:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kDG-0003z5-09
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kDC-0008Cj-Ts
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0W/IXaYxqHRtZC4KnnJtCdf+TXWLaEz5NbLVH4JP+kE=;
 b=HU8PXvWAl/l/+2Km5ItvYzWYYclQRsXiJfb7Er0xGwPeXwW2nyp+1BtZOwFuYCZVF76/bh
 odbTTMmLJ4E+t2XZPLFnseUEfiW90crkAIdqPHADsZlPsWhCl9vnuv6aH15Tj1b7wrsjTO
 PeFaUKGMpz0M3AzE+xdCfVG0N3vGi70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-sLhIWVSVMVyl_LnQM-YW1w-1; Tue,
 30 Apr 2024 05:55:42 -0400
X-MC-Unique: sLhIWVSVMVyl_LnQM-YW1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EB363806738;
 Tue, 30 Apr 2024 09:55:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F119151BF;
 Tue, 30 Apr 2024 09:55:39 +0000 (UTC)
Date: Tue, 30 Apr 2024 10:55:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
Message-ID: <ZjDAGuONZ_Zem3fL@redhat.com>
References: <20240430064529.411699-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430064529.411699-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 30, 2024 at 08:45:29AM +0200, Thomas Huth wrote:
> Old machine types often have bugs or work-arounds that affect our
> possibilities to move forward with the QEMU code base (see for example
> https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
> cannot be fixed without breaking live migration with old machine types,
> or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
> commit ea985d235b86). So instead of going through the process of manually
> deprecating old machine types again and again, let's rather add an entry
> that can stay, which declares that machine types older than 6 years are
> considered as deprecated automatically. Six years should be sufficient to
> support the release cycles of most Linux distributions.

Reading this again, I think we're mixing two concepts here.

With this 6 year cut off, we're declaring the actual *removal* date,
not the deprecation date.

A deprecation is something that happens prior to removal normally,
to give people a warning of /future/ removal, as a suggestion
that they stop using it.

If we never set the 'deprecation_reason' on a machine type, then
unless someone reads this doc, they'll never realize they are on
a deprecated machine.

When it comes to machine types, I see deprecation as a way to tell
people they should not deploy a /new/ VM on a machine type, only
use it for back compat (incoming migration / restore from saved
image) with existing deployed VMs.

If we delete a machine on the 6 year anniversary, then users
don't want to be deploying /new/ VMs using that on the
5 year anniversary as it only gives a 1 year upgrade window.

So how long far back do we consider it reasonable for a user
to deploy a /new/ VM on an old machine type ? 1 year, 2 years,
3 years ?


How about picking the half way point ?  3 years ?

ie, set deprecation_reason for any machine that is 3 years
old, but declare that our deprecation cycle lasts for
3 years, instead of the normal 1 year, when applied to
machine types.

This would give a strong hint that users should get off the
old machine type, several years before its finally deleted.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 6d595de3b6..fe69e2d44c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -220,6 +220,17 @@ is a chance the code will bitrot without anyone noticing.
>  System emulator machines
>  ------------------------
>  
> +Versioned machine types older than 6 years
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Starting with the release of QEMU 10.0, versioned machine types older than
> +6 years will automatically be considered as deprecated and might be due to
> +removal without furthor notice. For example, this affects machine types like
> +pc-i440fx-X.Y, pc-q35-X.Y, pseries-X.Y, s390-ccw-virtio-X.Y or virt-X.Y where
> +X is the major number and Y is the minor number of the old QEMU version.
> +If you are still using machine types from QEMU versions older than 6 years,
> +please update your setting to use a newer versioned machine type instead.
> +
>  Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> -- 
> 2.44.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


