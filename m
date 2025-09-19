Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E2CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzX5W-0005hE-Dp; Fri, 19 Sep 2025 05:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzX5U-0005g1-Lp
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzX5P-0004xb-9T
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmEAg3lJJaFnUmh9L4qOAkxkOgEpOZXQW1Rnmlo/87M=;
 b=CxoG+cfquuZ5ewPdRY0MTXgR2SaNByPTQeKtOQUXmtsQUfoUtF/lgwVrxCK0MYg5dkkKgs
 Xu3M8STW1syIOVQlCMILqXLxsWmmOTIS6d8l0xR4AXdJhedVdFQoXSmasAINaRc+bWExGC
 BbYAthb9khbF4Wyc7lllzTtRPdu8JCQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Lbt0oip2PxKUf6VpKREAAA-1; Fri,
 19 Sep 2025 05:07:17 -0400
X-MC-Unique: Lbt0oip2PxKUf6VpKREAAA-1
X-Mimecast-MFC-AGG-ID: Lbt0oip2PxKUf6VpKREAAA_1758272836
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A1D119560AD
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 09:07:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69F2A19560BB; Fri, 19 Sep 2025 09:07:15 +0000 (UTC)
Date: Fri, 19 Sep 2025 10:07:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: use the pyvenv version of Meson
Message-ID: <aM0dPwlABhxqsT8Q@redhat.com>
References: <20250919083621.86615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919083621.86615-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 19, 2025 at 10:36:21AM +0200, Paolo Bonzini wrote:
> The version in the system might be too old for QEMU; this will be
> especially true if Rust is going to be enabled by default.
> 
> Adjust the docs to suggest using pyvenv/bin/meson.

I presume this is essentially changing the docs to match
what our "make" wrappers will be running internally ?

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/build-system.rst | 2 +-
>  docs/devel/rust.rst         | 2 +-
>  docs/system/devices/igb.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 2c884197a20..6204aa6a72e 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -450,7 +450,7 @@ are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
>  with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
>  tests for all targets.
>  
> -If desired, it is also possible to use ``ninja`` and ``meson test``,
> +If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
>  respectively to build emulators and run tests defined in meson.build.
>  The main difference is that ``make`` needs the ``-jN`` flag in order to
>  enable parallel builds or tests.
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index 13a20e86a16..2f0ab2e2821 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -66,7 +66,7 @@ __ https://mesonbuild.com/Commands.html#devenv
>  As shown above, you can use the ``--tests`` option as usual to operate on test
>  code.  Note however that you cannot *build* or run tests via ``cargo``, because
>  they need support C code from QEMU that Cargo does not know about.  Tests can
> -be run via ``meson test`` or ``make``::
> +be run via Meson (``pyvenv/bin/meson test``) or ``make``::
>  
>     make check-rust
>  
> diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
> index 71f31cb1160..50f625fd77e 100644
> --- a/docs/system/devices/igb.rst
> +++ b/docs/system/devices/igb.rst
> @@ -54,7 +54,7 @@ directory:
>  
>  .. code-block:: shell
>  
> -  meson test qtest-x86_64/qos-test
> +  pyvenv/bin/meson test qtest-x86_64/qos-test
>  
>  ethtool can test register accesses, interrupts, etc. It is automated as an
>  functional test and can be run from the build directory with the following
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


