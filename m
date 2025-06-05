Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A32C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6CW-00079x-GC; Thu, 05 Jun 2025 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6C6-0006d0-O1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6C4-0008Gq-Vv
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIlkQgP8kNo3VJA5CH0STYG4gdXTHwYavjidWiOafdM=;
 b=DpFOQo/LJ/pvcI7nVLJuMdX456p2g4DtJAyWVa40FEjJqBaPJCuU1YXpiMrF9CT/iVKcTW
 j8L9cnNviN9hoxfWVpNZyslRl7ZCr6g62yVgQ2lcZO4BFY8yfYRxCMqlJkngaw9eNtb9os
 V7uNUOXG1f+7tW6pqYEAyPmz5mBTfEw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-yUwULTyTNRqaRcYXP9ZF0g-1; Thu,
 05 Jun 2025 04:43:17 -0400
X-MC-Unique: yUwULTyTNRqaRcYXP9ZF0g-1
X-Mimecast-MFC-AGG-ID: yUwULTyTNRqaRcYXP9ZF0g_1749112996
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CA9B180035E; Thu,  5 Jun 2025 08:43:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06BD1195E74A; Thu,  5 Jun 2025 08:43:12 +0000 (UTC)
Date: Thu, 5 Jun 2025 09:43:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Message-ID: <aEFYnTvaDQ6Kd0o4@redhat.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529051352.1409904-3-vivek.kasireddy@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:
> Giving users an option to choose a particular codec will enable
> them to make an appropriate decision based on their hardware and
> use-case.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  qemu-options.hx |  5 +++++
>  ui/spice-core.c | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7eb8e02b4b..fcddb583c9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
>      "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
>      "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
>      "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
> +    "       [,video-codecs=<encoder>:<codec>\n"
>      "       [,gl=[on|off]][,rendernode=<file>]\n"
>      "                enable spice\n"
>      "                at least one of {port, tls-port} is mandatory\n",
> @@ -2369,6 +2370,10 @@ SRST
>      ``seamless-migration=[on|off]``
>          Enable/disable spice seamless migration. Default is off.
>  
> +    ``video-codecs=<encoder>:<codec>``
> +        Provide the preferred codec the Spice server should use.
> +        Default would be spice:mjpeg.

This looks like two distinct settings overloaded into one command
line parameter, which is a design anti-pattern.

Why can't this be done as separate parameters

   video-encoder=<blah>
   video-codec=<blah>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


