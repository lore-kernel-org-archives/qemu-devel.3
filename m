Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16790EA813B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq4a-0005Wh-54; Tue, 10 Feb 2026 10:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpq4R-0004wS-9h
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpq4L-0004cW-D1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770738867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Wk0Rqpp04tAX9GvVYz/FOCB+OkpJNBclkPPAQdxQE=;
 b=MhP5xling5hnuM/8b/o3gqV4r29/PcxY8sIO4IGj33qrcOjhWdZzuPq+9zAvhds3OreVrc
 oRiT6Ao3DcyLdbiI7ZrFF3XJ78gc6boEPs2++Mp41NRu/IJ8kNiwwAyE/83khW1yRokRD+
 tDKXYP+hRDJ1PM2vHWDd22KlwO5fx9E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-NU9pGOzfMB-HPx7OzOHKTw-1; Tue,
 10 Feb 2026 10:54:24 -0500
X-MC-Unique: NU9pGOzfMB-HPx7OzOHKTw-1
X-Mimecast-MFC-AGG-ID: NU9pGOzfMB-HPx7OzOHKTw_1770738863
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE0B318001F7; Tue, 10 Feb 2026 15:54:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8B81956053; Tue, 10 Feb 2026 15:54:20 +0000 (UTC)
Date: Tue, 10 Feb 2026 15:54:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] freebsd: FreeBSD 15 has native inotify
Message-ID: <aYtUqbgy_axpHfn2@redhat.com>
References: <20260210-freebsd-inotify-v1-1-009430118133@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210-freebsd-inotify-v1-1-009430118133@bsdimp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Feb 10, 2026 at 08:43:48AM -0700, Warner Losh wrote:
> Check to make sure that we have inotify in libc, before looking for it
> in libinotify.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> FreeBSD 15 and newer now has a native inotify implementation. Check for
> it before checking for the wrapper libinotify library which is needed in
> FreeBSD 14 and earlier. Make the check dependent on symbols, not host
> version.
> 
> Separate series because it's really independent of the two other
> patch series I have submitted and it is more important.
> ---
>  meson.build | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 2d114e9018..537f50283f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2662,13 +2662,15 @@ have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
>  have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
>  inotify = not_found
>  if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
> -  # libinotify-kqueue
> -  inotify = cc.find_library('inotify')
> -  if have_inotify_init
> -    have_inotify_init = inotify.found()
> -  endif
> -  if have_inotify_init1
> -    have_inotify_init1 = inotify.found()
> +  if not cc.has_function('inotify_init') and not cc.has_function('inotify_init1')
> +    inotify = cc.find_library('inotify')
> +    # libinotify-kqueue
> +    if have_inotify_init
> +      have_inotify_init = inotify.found()
> +    endif
> +    if have_inotify_init1
> +      have_inotify_init1 = inotify.found()
> +    endif
>    endif
>  endif
>  config_host_data.set('CONFIG_INOTIFY', have_inotify_init)

So this ends up woth 'inotify == not_found' with either Linux,
or latest FreeBSD 15.

Over in util/meson.build though we have

    freebsd_dep = []
    if host_os == 'freebsd'
      freebsd_dep = inotify
    endif
    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)

Which seems to be trying to avoid adding "not_found" to the dep list.

Either it is safe to add "not_found" to the dep list, and this code in
util/meson.build can be simplified to just:

    util_ss.add(files('filemonitor-inotify.c'), [inotify])

or it is unsafe, and this code needs to be modified to look more like:

    inotify_deps = []
    if inotify.found()
      inotify_deps = [inotify]
    endif
    util_ss.add(files('filemonitor-inotify.c'), inotify_deps)


Assuming you've tested your patch here successfully, then it seems like
the former case is valid, and we can simplify util/meson.dep to remove
the conditional ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


