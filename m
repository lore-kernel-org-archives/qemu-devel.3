Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143FDC04FF9
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 17:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwPsF-0003fq-7s; Mon, 15 Apr 2024 13:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwPs9-0003f5-9E
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwPs7-0000cn-KR
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713201118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c+5MMQ1af1qYngnm+i0shoAyyPaHc8tS0h2nmHgGoo=;
 b=GUffRd43cbo0wLwLIFj2//dCDyT1eG9JVyEtQlqj1cdVrX/WpX2rlutLrGv7KH4ek2BZU/
 IF8W6wEOKQxAPCmymCZMa5SZWWip8vu4uq9EFW34qcgti8aJUNqSODIfJMhGIikNz/kv8S
 YeJf4D93yhrRAtCGEBDDXc0+2G0tO40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-eaEK2t2lNgW-MYUhrMn4Gg-1; Mon,
 15 Apr 2024 13:11:55 -0400
X-MC-Unique: eaEK2t2lNgW-MYUhrMn4Gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D48F329AA394;
 Mon, 15 Apr 2024 17:11:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3589E40C6DAE;
 Mon, 15 Apr 2024 17:11:53 +0000 (UTC)
Date: Mon, 15 Apr 2024 18:11:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 03/13] tests/docker/dockerfiles: Run lcitool-refresh
 after the lcitool update
Message-ID: <Zh1fw3vWYJmcCfjW@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412132415.282354-4-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 12, 2024 at 03:24:05PM +0200, Thomas Huth wrote:
> This update adds the removing of the EXTERNALLY-MANAGED marker files
> that has been added to the lcitool recently.

For those who don't know, python now commonly blocks the ability to
run 'pip install' outside of a venv. This generally makes sense for
a precious installation environment. Our containers are disposable
though, so a venv has no benefit. Removing the 'EXTERNALLY-MANAGED'
allows the historical arbitrary use of 'pip' outside a venv.
lcitool just does this unconditionally given the containers are
not precious.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/alpine.docker                | 3 ++-
>  tests/docker/dockerfiles/centos8.docker               | 1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 3 ++-
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 3 ++-
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 3 ++-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 3 ++-
>  tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ++-
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/debian.docker                | 1 +
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/fedora.docker                | 1 +
>  tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
>  tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
>  17 files changed, 29 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


