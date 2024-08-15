Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A84C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1secrm-0006N6-Bx; Thu, 15 Aug 2024 11:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1secrj-0006MG-Fx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1secrg-00027c-Mn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723737493;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=h0RvMeIJoP5e75MmnqhCQQ5H+VRwioJy9ycWzkN2BnA=;
 b=VjnOC3wVJQEL97Dgx8BE7qA5Wvfl7e9NXgrgdjRVSjwMGq7JcMkY1DJ2gjsamSExckkbjQ
 fSCZDOYCXd3HcQDz5ipI/4+nHKAKuTkR7IdQA5pGJh9rJ4oCGV78n392P6qhzGgyOQlgUA
 m+UKdCzlqItWIkVDK0OBTvm7180KGYU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-WAH5C_PwPWmV7PLuY_1c5Q-1; Thu,
 15 Aug 2024 11:58:09 -0400
X-MC-Unique: WAH5C_PwPWmV7PLuY_1c5Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682941955BFC; Thu, 15 Aug 2024 15:58:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ED2D1955F1B; Thu, 15 Aug 2024 15:58:04 +0000 (UTC)
Date: Thu, 15 Aug 2024 16:58:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] meson: add 'qemuutil' dependency for block.c
Message-ID: <Zr4liA5Kr7qV8aj3@redhat.com>
References: <20240814100052.263060-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814100052.263060-1-f.ebner@proxmox.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 14, 2024 at 12:00:52PM +0200, Fiona Ebner wrote:
> The macro block_module_load() used by block.c is a wrapper around
> module_load(), which is implemented in util/module.c.
> 
> Fixes linking for a future binary or downstream binary that does not
> depend on 'qemuutil' directly, but does depend on 'block'.

Such a scenario is impossible surely, even in future. Every file in
QEMU pulls in osdep.h, and as a result effectively gets a dep on
on qemuutil, not to mention the block layer using countless APIs
present in qemuutil

> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 81ecd4bae7..efa0ac8d0b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3555,7 +3555,7 @@ if have_block
>      'blockjob.c',
>      'job.c',
>      'qemu-io-cmds.c',
> -  ))
> +  ), qemuutil)
>    if config_host_data.get('CONFIG_REPLICATION')
>      block_ss.add(files('replication.c'))
>    endif
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


