Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CD2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78lx-0005ei-8N; Fri, 10 Oct 2025 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78lv-0005eL-9u
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78ls-0002fm-L4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760085997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IKOq++wEKoMyzTQJBrM58Mp6NLyJoDaqf9CbrRpyHw=;
 b=cHxywZ/h46e5jRZ4RxUk/q4495+y8+vvZXAPaZnqWL3munyw0QoEUJSZxn0WaA9de2Lg7z
 gTmHFhI7pL/3QCpDE74A+EWKgGWrBEfX/qNfLt6YoocRbZ2yMtFzRp3hxCezmfmiKu+MNw
 J2o/3O7RWbriYG3XTjJCNVxQXHzA9hA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-GYLyXGrXOo66CwQV2-VWKA-1; Fri,
 10 Oct 2025 04:46:30 -0400
X-MC-Unique: GYLyXGrXOo66CwQV2-VWKA-1
X-Mimecast-MFC-AGG-ID: GYLyXGrXOo66CwQV2-VWKA_1760085987
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A766180057F; Fri, 10 Oct 2025 08:46:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC6B180035E; Fri, 10 Oct 2025 08:46:20 +0000 (UTC)
Date: Fri, 10 Oct 2025 09:46:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v2 7/7] buildsys: Remove support for 32-bit MIPS hosts
Message-ID: <aOjH2b5YbeyBmiZS@redhat.com>
References: <20251009195210.33161-1-philmd@linaro.org>
 <20251009195210.33161-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009195210.33161-8-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 09, 2025 at 09:52:10PM +0200, Philippe Mathieu-Daudé wrote:
> Stop detecting 32-bit MIPS host as supported, update the
> deprecation document. See previous commit for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       | 13 +++++--------
>  docs/about/removed-features.rst |  6 ++++++
>  configure                       |  7 -------
>  3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 67e527740c0..79cc34cfeb6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -172,17 +172,14 @@ This argument has always been ignored.
>  Host Architectures
>  ------------------
>  
> -Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0

Did 'Big endian MIPS' refer to 32-bit, or both 32 & 64-bit ?  I'm guessing
it was only 32-bit BE, given the heading of your removed-features.txt
change.

But then did "MIPS since 11.0" refer to 64-bit little endian only, or
both big & little endian for 64-bit ?

Given the wide variety of things all ambiguously called "MIPS",
its worth being explicit....

> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +MIPS (since 11.0)
> +'''''''''''''''''

...so if this is 64-bit MIPS, big & little endian, lets say so

>  
> -As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
> -MIPS moved out of support making it hard to maintain our
> -cross-compilation CI tests of the architecture. As we no longer have
> -CI coverage support may bitrot away before the deprecation process
> +MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
> +maintain our cross-compilation CI tests of the architecture. As we no longer
> +have CI coverage support may bitrot away before the deprecation process
>  completes.
>  
> -Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
> -
>  System emulation on 32-bit x86 hosts (since 8.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a5338e44c24..53829f59e65 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -896,6 +896,12 @@ work around the atomicity issues in system mode by running all vCPUs
>  in a single thread context; in user mode atomicity was simply broken.
>  From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>  
> +32-bit MIPS (since 11.0)
> +''''''''''''''''''''''''
> +
> +Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
> +maintain our cross-compilation CI tests of the architecture.
> +
>  Guest Emulator ISAs
>  -------------------
>  
> diff --git a/configure b/configure
> index 6a633ac2b16..8236f43e8f9 100755
> --- a/configure
> +++ b/configure
> @@ -404,8 +404,6 @@ elif check_define _ARCH_PPC ; then
>  elif check_define __mips__ ; then
>    if check_define __mips64 ; then
>      cpu="mips64"
> -  else
> -    cpu="mips"
>    fi
>  elif check_define __s390__ ; then
>    if check_define __s390x__ ; then
> @@ -473,11 +471,6 @@ case "$cpu" in
>      host_arch=mips
>      linux_arch=mips
>      ;;
> -  mips*)
> -    cpu=mips
> -    host_arch=mips
> -    linux_arch=mips
> -    ;;
>  
>    ppc)
>      host_arch=ppc
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


