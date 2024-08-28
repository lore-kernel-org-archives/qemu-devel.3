Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA408C5B54A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKhA-00080r-Ny; Wed, 28 Aug 2024 11:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjKh8-0007tF-Px
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjKh7-0006Jf-4p
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724859288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZYd1BuCxj0W7R0QTc3JEcr3xYyHUAODZ+WYa5VMRrg=;
 b=dfcKcOGP3gKFB2NXr5ogat4elIRj0pA51pdU6gzfigf+SLbRMB8PE25jJThYXfn9EenWL7
 xpt+vTYRxXhcGlArdYiboYRWedSRzb1LI0GYYZX0tvcpYBBm2dGW2F3a3pidQG7ODJfnub
 fgNTDBbAWkgC4A3fYzSAk4VsOpdwxEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-8SsUxVBdNUOGIWJpoL0lng-1; Wed,
 28 Aug 2024 11:34:45 -0400
X-MC-Unique: 8SsUxVBdNUOGIWJpoL0lng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A591954B02; Wed, 28 Aug 2024 15:34:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DD5D19560A3; Wed, 28 Aug 2024 15:34:37 +0000 (UTC)
Date: Wed, 28 Aug 2024 16:34:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v5 4/8] tests/lcitool: Update libvirt-ci and add libcbor
 dependency
Message-ID: <Zs9DifxxypqR_SoI@redhat.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-5-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822150849.21759-5-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 22, 2024 at 09:08:45PM +0600, Dorjoy Chowdhury wrote:
> libcbor dependecy is necessary for adding virtio-nsm and nitro-enclave
> machine support in the following commits. libvirt-ci has already been
> updated with the dependency upstream and this commit updates libvirt-ci
> submodule in QEMU to latest upstream. Also the libcbor dependency has
> been added to tests/lcitool/projects/qemu.yml.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
>  tests/docker/dockerfiles/alpine.docker                | 1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian.docker                | 1 +
>  tests/docker/dockerfiles/fedora.docker                | 1 +
>  tests/docker/dockerfiles/opensuse-leap.docker         | 3 ++-
>  tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
>  tests/lcitool/libvirt-ci                              | 2 +-
>  tests/lcitool/projects/qemu.yml                       | 1 +
>  20 files changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


