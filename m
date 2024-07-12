Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDCC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 10:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSDGN-0000vZ-Ab; Fri, 12 Jul 2024 06:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSDGI-0000uR-RH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSDGG-0003ZZ-FQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 06:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720779137;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ao5mHWeXizI2Yhl2gR8A3hoMh+vjvSHXnGnd0RjGp0=;
 b=H0AJKA+iJ7KtM5ibUwSA3boGqJZzjDf90WDcPjF/79KLKeR17fvdSZz+zZID9u+kvB9g9I
 j8KCEf/42WR1XhojPgxAUYUKBggdKARbrUFqniW1+Ucj/U/PGUPSCDiN4qHn4qF8XDKTPC
 lEx7p9pv2BAO10gYYQHMVW1G12ASGYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-JUHzR6XWMDSYHFrFO0c4Bw-1; Fri,
 12 Jul 2024 06:12:14 -0400
X-MC-Unique: JUHzR6XWMDSYHFrFO0c4Bw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C72A91955F66; Fri, 12 Jul 2024 10:12:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D6C1956046; Fri, 12 Jul 2024 10:12:09 +0000 (UTC)
Date: Fri, 12 Jul 2024 11:12:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH] build deps: update lcitool to include rust bits
Message-ID: <ZpEBds6AUnPsVCY4@redhat.com>
References: <20240710154335.2510260-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710154335.2510260-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 04:43:35PM +0100, Alex Bennée wrote:
> For rust development we need cargo, rustc and bindgen in our various
> development environments. Update the libvirt-ci project to (!495) and
> regenerate the containers and other dependency lists.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> NB:
>   - this is currently waiting on the upstream MR, but if you manually
>   add the remote
>   https://gitlab.com/stsquad/libvirt-ci/-/tree/more-rust-mappings the
>   submodule update will work.
> ---
>  .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
>  .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 3 +++
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 3 +++
>  tests/docker/dockerfiles/alpine.docker                | 3 +++
>  tests/docker/dockerfiles/centos9.docker               | 3 +++
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++++
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++++
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ++++
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++++
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++++
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++++
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++++
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++++
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++++
>  tests/docker/dockerfiles/debian.docker                | 3 +++
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 +++
>  tests/docker/dockerfiles/fedora.docker                | 3 +++
>  tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
>  tests/docker/dockerfiles/ubuntu2204.docker            | 3 +++
>  tests/lcitool/libvirt-ci                              | 2 +-
>  tests/lcitool/projects/qemu.yml                       | 3 +++
>  tests/vm/generated/freebsd.json                       | 2 ++
>  24 files changed, 71 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


