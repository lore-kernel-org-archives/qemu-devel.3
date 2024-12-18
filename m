Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0E1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrUC-0006cg-Us; Wed, 18 Dec 2024 05:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNrU4-0006c5-AT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNrU2-0004Zn-NF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734518449;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKaQBmeMscbPGkSt6+59yS0LnqjCi+hV19H9OaPM1HU=;
 b=Rdw5VDl9qhGpYOUPJpRMilycxKKks9LsNPP8vzx3ZBiSxQ5iffSs9F6bqW9mmOzRfnNySX
 5zmFEkPqirO6ZpEat/7qXPMj0cH6u5hcRnZzUaaekzCG2B2VAYkZKarFGNQZtggVJJY/yG
 ePr+4KjAJ/tddze6DbR9AgwjZ7FLrN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-4L_Jc-xcNB-jgEsnDMxcAw-1; Wed,
 18 Dec 2024 05:40:45 -0500
X-MC-Unique: 4L_Jc-xcNB-jgEsnDMxcAw-1
X-Mimecast-MFC-AGG-ID: 4L_Jc-xcNB-jgEsnDMxcAw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6FB195608E; Wed, 18 Dec 2024 10:40:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A141956053; Wed, 18 Dec 2024 10:40:39 +0000 (UTC)
Date: Wed, 18 Dec 2024 10:40:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Lieven <pl@dlhnet.de>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] meson.build: Disallow libnfs v6 to fix the broken macOS
 build
Message-ID: <Z2Kmo_Kixrun1mAl@redhat.com>
References: <20241218065157.209020-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218065157.209020-1-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 07:51:57AM +0100, Thomas Huth wrote:
> The macOS build in our CI is currently broken since homebrew
> updated libnfs to version 6 - and that version apparently comes
> with a big API breakage. Disallow that version for now to get the
> broken CI job working again. Once somebody had enough time to
> adapt our code in block/nfs.c, we can revert this change again.

NB This isn't limited to macOS. We've already been broken by
this in Fedora:

  https://lists.nongnu.org/archive/html/qemu-block/2024-12/msg00151.html

other distros will no doubt break too soon enough.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/meson.build b/meson.build
> index 85f7485473..6149b50db2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1145,7 +1145,7 @@ endif
>  
>  libnfs = not_found
>  if not get_option('libnfs').auto() or have_block
> -  libnfs = dependency('libnfs', version: '>=1.9.3',
> +  libnfs = dependency('libnfs', version: ['>=1.9.3', '<6.0.0'],
>                        required: get_option('libnfs'),
>                        method: 'pkg-config')
>  endif
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


