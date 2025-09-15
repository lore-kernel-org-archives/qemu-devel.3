Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32207CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy8AL-0004Ep-Ix; Mon, 15 Sep 2025 08:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy8A9-0004Ct-I5
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy89z-0007LJ-SO
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757938690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ci/R9IJjk4Vjwf1Nx32s0S2ne+aAgFbM0xpmhza3j9s=;
 b=CHKZLVyB/rEUtkYuvQuoz7Gfox/wX4eZAfsPeTYZANMIzqvGOGWe5M8y4iBNwgOr/fuv29
 rmmxRtw6zjAtGByZpRL4wjlg5I1TtaWiUZsL3s5xh4ARGpdNX9uySWAQ4Jhx7HPMDdndNM
 DWSyXC0VamxMOHdEIoJ4y6RbHex0CRM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-bklWP3LgMlOVCynctYs6hg-1; Mon,
 15 Sep 2025 08:18:06 -0400
X-MC-Unique: bklWP3LgMlOVCynctYs6hg-1
X-Mimecast-MFC-AGG-ID: bklWP3LgMlOVCynctYs6hg_1757938686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE39619774FA; Mon, 15 Sep 2025 12:18:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9E7A180035E; Mon, 15 Sep 2025 12:18:01 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:17:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] .gitmodules: move u-boot mirrors to qemu-project-mirrors
Message-ID: <aMgD83wAjZMurYnI@redhat.com>
References: <20250908141911.2546063-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908141911.2546063-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Sep 08, 2025 at 03:19:11PM +0100, Alex Bennée wrote:
> To continue our GitLab Open Source Program license we need to pass an
> automated license check for all repos under qemu-project. While U-Boot
> is clearly GPLv2 rather than fight with the automated validation
> script just move the mirror across to a separate project.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Cc: qemu-stable@nongnu.org
> ---
>  .gitmodules | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index 73cae4cd4da..e27dfe8c2c1 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -15,7 +15,7 @@
>  	url = https://gitlab.com/qemu-project/qemu-palcode.git
>  [submodule "roms/u-boot"]
>  	path = roms/u-boot
> -	url = https://gitlab.com/qemu-project/u-boot.git
> +	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
>  [submodule "roms/skiboot"]
>  	path = roms/skiboot
>  	url = https://gitlab.com/qemu-project/skiboot.git
> @@ -27,7 +27,7 @@
>  	url = https://gitlab.com/qemu-project/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path = roms/u-boot-sam460ex
> -	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
> +	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
>  [submodule "roms/edk2"]
>  	path = roms/edk2
>  	url = https://gitlab.com/qemu-project/edk2.git

Are these the only 2 repos that are still blocking the OSS program
approval checks we need ?

This is pretty ugly, but unless upstream u-boot is willing to add a COPYING
file very quickly, I'm not seeing better options, given that GitLab's OSS
Program approval is driven off entirely automated processing of the
COPYING/LICENSE file contents.

If upstream u-boot.git added a good COPYING file, we would have to handle
the u-boot-sam460ex fork by pulling all of u-boot.git modern histry into
u-boot-sam460ex.git and ensuring the primary branch was master so GitLab
sees the COPYING file. The QEMU sub-module would still point to the
original old commit with the sam640ex changes we need, lacking a COPYING
file but that won't be a problem.


My only comment is that if we go down the route of this patch, I think we
should aim to move all read-only mirrored 3rd party stuff under the new
/qemu-project-mirrors group, so that /qemu is exclusively for code which
we actively maintain ourselves (and thus have control over licensing)


Every single active stable branch will need this change too, otherwise
they'll be unable to find the submodules we moved.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


