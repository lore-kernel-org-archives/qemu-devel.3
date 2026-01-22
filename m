Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D6C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqzo-0005KA-8l; Thu, 22 Jan 2026 04:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viqzk-0005JM-OO
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viqzi-0001JQ-O1
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769074128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0jOG+YPBvaCOvd+Y8leO6cvLt/wJLd500IWopbxcG5w=;
 b=IoTIXJ8ihWDX2eno3hBKbteq/YkBHEa+Cr+ETlVaMsaar2pKK1eKZaeTpFOqb/wMjapG7R
 g7k2q2EbaYPUdEv56j616I+SnfVV4QM4Rt+6ToEK+DhJqvnjCRGOgJDfGK6AaS+YgMtCyp
 DPa3k5H7CgZmOIU3/Yv1SZwpNh8+AqY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-b4MmxChjNqu0pi5BU9DRlw-1; Thu,
 22 Jan 2026 04:28:45 -0500
X-MC-Unique: b4MmxChjNqu0pi5BU9DRlw-1
X-Mimecast-MFC-AGG-ID: b4MmxChjNqu0pi5BU9DRlw_1769074124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5C461955DB7; Thu, 22 Jan 2026 09:28:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344E11800993; Thu, 22 Jan 2026 09:28:39 +0000 (UTC)
Date: Thu, 22 Jan 2026 09:28:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
Message-ID: <aXHtxBfuIRsJ3P_M@redhat.com>
References: <20260122090352.9901-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122090352.9901-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We stopped supported 32-bit Windows hosts a while ago already, so
> let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> that this switch is not about 32-bit Windows anymore.
> 
> The patch has been created with a simple sed statement:
> 
>  sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build           |  2 +-
>  qapi/char.json        |  4 +--
>  qapi/misc.json        |  2 +-
>  qga/qapi-schema.json  | 76 +++++++++++++++++++++----------------------
>  include/qemu/futex.h  |  2 +-
>  include/qemu/xattr.h  |  2 +-
>  hw/usb/host-libusb.c  | 18 +++++-----
>  io/channel-watch.c    | 10 +++---
>  ui/gtk.c              |  2 +-
>  util/cacheflush.c     |  4 +--
>  util/sys_membarrier.c |  2 +-
>  scripts/checkpatch.pl |  2 +-
>  12 files changed, 63 insertions(+), 63 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a84f14258b0..01b9a5c22ce 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
>  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
>  config_host_data.set('CONFIG_LINUX', host_os == 'linux')
>  config_host_data.set('CONFIG_POSIX', host_os != 'windows')
> -config_host_data.set('CONFIG_WIN32', host_os == 'windows')
> +config_host_data.set('CONFIG_WIN64', host_os == 'windows')

While relevant to qapi file conditions, from a C code pov all of these
are redundant as the compiler has all these facts built-in

  #ifdef CONFIG_LINUX =>    #ifdef __linux__
  #ifdef CONFIG_POSIX =>    #if !defined(_WIN32) 
  #ifdef CONFIG_WIN32 =>    #ifdef _WIN32

NB,  _WIN32 *is* set on 64-bit Windows platforms too, so using
_WIN64 is only needed if you have a code path that is exclusively
64-bit only, so there's little need for us to use _WIN64.

And of course we are horribly inconsistent in what we use:

$ git grep -E '#if.*_WIN32' | wc -l
284

$ git grep -E '#if.*__linux__' | wc -l
90

$ git grep -E '#if.*CONFIG_LINUX' | wc -l
142
$ git grep -E '#if.*CONFIG_WIN' | wc -l
16

I'm inclined to posion all these from the C source though, and only
these them from non-C locations.

Also IMHO  CONFIG_WIN  or CONFIG_WINDOWS is preferrable - we don't
add '32' or '64' suffixes to CONFIG_LINUX or CONFIG_POSIX, so I don't
see a reason to keep doing it for Windows.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


