Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4127CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 06:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0wvE-00068K-RK; Tue, 23 Sep 2025 02:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0wvA-00066g-LL
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 02:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0wv3-0005f3-4X
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 02:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758610469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRGjtKa2aYhw/fegHA0yQnsua5Mm0Eisp6ikVFJdhsM=;
 b=QM/tuD+iYiXNi4Nn+kJ7TOq+0coOFBAxnFqCvlC3WqwKiLEpnWS8jAAZZO9jp/QnOQiQR5
 svwkjmvMSs31hV/qJhVs6wvJyvU2yXlcOTByz9anvU6DH6T+HDnjBPz5p0m1lA6y+qSNHb
 7EaG19d1mxYWV4roeIKO9VxZ51oFjUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-bVhmYLfhNEuCu1pwgBfeNQ-1; Tue,
 23 Sep 2025 02:54:20 -0400
X-MC-Unique: bVhmYLfhNEuCu1pwgBfeNQ-1
X-Mimecast-MFC-AGG-ID: bVhmYLfhNEuCu1pwgBfeNQ_1758610459
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A00A1956096; Tue, 23 Sep 2025 06:54:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AD893000198; Tue, 23 Sep 2025 06:54:17 +0000 (UTC)
Date: Tue, 23 Sep 2025 07:54:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] .gitmodules: Update URLs for the u-boot submodules
Message-ID: <aNJD-OXimJj9KZkS@redhat.com>
References: <20250922220401.74802-1-erick.shepherd@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922220401.74802-1-erick.shepherd@ni.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 05:04:01PM -0500, Erick Shepherd wrote:
> The u-boot and u-boot-sam460ex submodule repositories were moved to new
> locations. Update .gitmodules to use the new URLs.
> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

You need to update your git tree, as this change was already done when
the modules were moved:

  commit a11d1847d5ef8a7db58e6d4e44f36fec708f0981
  Author: Alex Bennée <alex.bennee@linaro.org>
  Date:   Mon Sep 8 15:19:11 2025 +0100

    .gitmodules: move u-boot mirrors to qemu-project-mirrors


> ---
>  .gitmodules | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index 73cae4cd4d..e27dfe8c2c 100644
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
> -- 
> 2.50.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


