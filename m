Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34754CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbq9-0007jk-47; Fri, 19 Sep 2025 10:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbq6-0007hy-Rg
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbq1-00072g-2f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758291105;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fb6UmpRgtPjSo3PPjJcPOSJF6HMNCeVXdh1aW7PSr1k=;
 b=i1MxxF2XoP07pwIy+fBGvQyTikj4wfRggD1h3JI2Z/Xu2R1v2glO/l8VNbAizZnBu24wt+
 RPiegTZz8m1Yk0rs4U2JJNGX2xAtDthNDF6CbSKV9yn75zmq1Noi/BY0PZnb4n/ZDI3W9f
 IErY9WPLUcfQzssFKC2pIw0mDy9LFiU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-2nuw3mJrPemIwK6K_x3vkQ-1; Fri,
 19 Sep 2025 10:11:40 -0400
X-MC-Unique: 2nuw3mJrPemIwK6K_x3vkQ-1
X-Mimecast-MFC-AGG-ID: 2nuw3mJrPemIwK6K_x3vkQ_1758291098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A734A180028C; Fri, 19 Sep 2025 14:11:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45FBD1800579; Fri, 19 Sep 2025 14:11:35 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:11:31 +0100
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
Subject: Re: [PATCH 13/24] tests/lcitool: add missing rust-std dep
Message-ID: <aM1kk9lUmGlxkFiL@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919133320.240145-14-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

On Fri, Sep 19, 2025 at 05:33:07PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Some distros/targets may pull it by default, but some don't.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
>  tests/docker/dockerfiles/centos9.docker               | 1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian.docker                | 1 +
>  tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 ++-
>  tests/docker/dockerfiles/fedora.docker                | 1 +
>  tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
>  tests/lcitool/projects/qemu.yml                       | 1 +
>  17 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


