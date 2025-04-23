Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB86DC369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Yzg-0007s2-FK; Wed, 23 Apr 2025 08:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7YzZ-0007rE-Cc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7YzX-0001Qz-HO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745410453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mwmOtEohNS47ANpUkUzuIv3skDJ44yoDQByEMqwaVtM=;
 b=drvXJ29zC1yF8UF9RrT7YJmAzoEgYbmoehvxq4h7OxZGn2w7GzI2eTik4PEwVKL5rtIajt
 HZZACDz8tzLnnjfNcRJ6P0M/4UVPHqRruZExnwqvHBOAROmrYJDEMqp/o/ztf0a+P0nfl5
 wq7hk0CKw6kLf1EeO+I9crE82fQapfE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-31EkkG9-OPyH2CUcMRFNwA-1; Wed,
 23 Apr 2025 08:14:11 -0400
X-MC-Unique: 31EkkG9-OPyH2CUcMRFNwA-1
X-Mimecast-MFC-AGG-ID: 31EkkG9-OPyH2CUcMRFNwA_1745410450
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF151800877; Wed, 23 Apr 2025 12:14:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 977E619560A3; Wed, 23 Apr 2025 12:14:04 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:14:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/9] new configure option to enable gstreamer
Message-ID: <aAjZiO8o2Ijhl_25@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-2-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-2-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Fri, Apr 18, 2025 at 01:29:45PM +0200, Dietmar Maurer wrote:
> GStreamer is required to implement H264 encoding for VNC. Please note
> that QEMU already depends on this library when you enable Spice.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  meson.build                   | 10 ++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  5 ++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)


> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 3e8e00852b..b0c273d61e 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -229,6 +229,7 @@ meson_options_help() {
>    printf "%s\n" '                  Xen PCI passthrough support'
>    printf "%s\n" '  xkbcommon       xkbcommon support'
>    printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  gstreamer       gstreamer support (H264 for VNC)'
>  }
>  _meson_option_parse() {
>    case $1 in
> @@ -581,6 +582,8 @@ _meson_option_parse() {
>      --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
>      --enable-zstd) printf "%s" -Dzstd=enabled ;;
>      --disable-zstd) printf "%s" -Dzstd=disabled ;;
> -    *) return 1 ;;
> +    --enable-gstreamer) printf "%s" -Dgstreamer=enabled ;;
> +    --disable-gstreamer) printf "%s" -Dgstreamer=disabled ;;
> +   *) return 1 ;;

This has broken the indent of the existing code.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


