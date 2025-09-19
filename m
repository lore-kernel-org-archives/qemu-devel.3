Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF10ECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbzZ-0002A7-Kx; Fri, 19 Sep 2025 10:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbzX-00026T-6R
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbzO-00038N-UJ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758291684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdatEib4iT9ZiMLxGxJKlGrFlfO13oftToXEyw9AJJc=;
 b=Z26rN244iU9+XgDwmHzQornkefIVgP1L6/mxtGH4e6bv3/0v8ybTrAjlkFf4LvvzaOEZfI
 zXfrZIpVWn6sBlorRyZDMiR6bgbV0uoJML5gvvBavRslz7TYOci0KVn1f0KLuWHyNDi/c8
 bWlczxCGKTZ7Hs2OqjlemlWLCS9tjiE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-FTNwUkZZM_WVxHQtli40OQ-1; Fri,
 19 Sep 2025 10:21:20 -0400
X-MC-Unique: FTNwUkZZM_WVxHQtli40OQ-1
X-Mimecast-MFC-AGG-ID: FTNwUkZZM_WVxHQtli40OQ_1758291679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 304AF1800576; Fri, 19 Sep 2025 14:21:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34B0730002C5; Fri, 19 Sep 2025 14:21:14 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:21:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
Message-ID: <aM1m13xBnM9WU_E3@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919133320.240145-15-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 05:33:08PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> We are updating debian which dropped support for it:
> https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed

If Debian 13 has dropped it, why aren't we just keeping the mips
dockerfiles on 12 ?

The debian-legacy-test-cross a manually written dockerfile that
has almost none of our deps installed, and is still on 11 which
is outside our support matrix now. So I don't think we should
be expanding use of debian-legacy-test-cross, ideally it would
be removed entirely.


> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 7a92fe388f..9da20ff7c3 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 7a92fe388f55d1bbc33e639e3484533f88c542ec
> +Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853

This shouldn't be here.

> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 6f98a91277..917ff4abfb 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -215,16 +215,6 @@ try:
>                                              "x86_64-linux-user,"
>                                              "i386-softmmu,i386-linux-user"))
>  
> -    generate_dockerfile("debian-mips64el-cross", "debian-12",
> -                        cross="mips64el",
> -                        trailer=cross_build("mips64el-linux-gnuabi64-",
> -                                            "mips64el-softmmu,mips64el-linux-user"))
> -
> -    generate_dockerfile("debian-mipsel-cross", "debian-12",
> -                        cross="mipsel",
> -                        trailer=cross_build("mipsel-linux-gnu-",
> -                                            "mipsel-softmmu,mipsel-linux-user"))
> -

I'm not seeing the need to remove these, when they could just
stay on -12, when the next commit updates the other arches
to -13.

>      generate_dockerfile("debian-ppc64el-cross", "debian-12",
>                          cross="ppc64le",
>                          trailer=cross_build("powerpc64le-linux-gnu-",
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


