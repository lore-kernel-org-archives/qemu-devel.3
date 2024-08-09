Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A77C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scL4y-00046y-PG; Fri, 09 Aug 2024 04:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scL4v-00046M-A5
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scL4t-00017E-I1
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723192465;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s6c47Va45zUmUt5kt8WzGgrUGDsSIZtsQcvWFt2JwnQ=;
 b=W+GLpsbTQJ7A0Sa3sAyGwcHJ1EDAqF5QVGHmHIckC+DArqEPS3D5urQ2wdJjxda9QNPSfE
 brTfcmCRq93icDTxHfpNE8L0tTCEwgcF1c7nMWxbozfZFUraFVI9gJcNzr31v3a9PZYPg1
 lhu5juecjx34AUwiBErXjHksyjCIohs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-jFWvGbg-P3SargbAQlbP9w-1; Fri,
 09 Aug 2024 04:34:21 -0400
X-MC-Unique: jFWvGbg-P3SargbAQlbP9w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 260DA196CDCE; Fri,  9 Aug 2024 08:34:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09DF1956056; Fri,  9 Aug 2024 08:34:16 +0000 (UTC)
Date: Fri, 9 Aug 2024 09:34:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 2/5] tests/migration: Make initrd-stress.img built by
 default
Message-ID: <ZrXUhQjfwleNraRS@redhat.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
 <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 09, 2024 at 03:43:33PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> The initrd-stress.img was compiled by specifying the
> target, to make it easier for developers to play the
> guestperf tool, make it built by default.

If you're going to do this, then you will need to make sure it is only
built on a Linux host, and when glib static & sysprof are found. eg

  if host_os == 'linux' && glib_static.found() && sysprof.found()

> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  tests/migration/meson.build | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/migration/meson.build b/tests/migration/meson.build
> index a91aa61c65..393e401800 100644
> --- a/tests/migration/meson.build
> +++ b/tests/migration/meson.build
> @@ -7,12 +7,13 @@ stress = executable(
>    files('stress.c'),
>    dependencies: [glib_static, sysprof],
>    link_args: ['-static'],
> -  build_by_default: false,
> +  build_by_default: true,
>  )
>  
>  custom_target(
>    'initrd-stress.img',
>    output: 'initrd-stress.img',
>    input: stress,
> -  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@']
> +  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@'],
> +  build_by_default: true,
>  )
> -- 
> 2.11.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


