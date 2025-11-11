Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED876CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsIx-0008Mu-4R; Tue, 11 Nov 2025 12:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsIo-0008Dk-H7
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsIY-0007Jq-H0
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762882613;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxmFiQZs45mq5UoFL2St+rjGj1QfSKHRzlvmh1dhtRc=;
 b=ed+xeHbi1skdwRU17+km486CUyy3qvnazEjz3+1uuYygFqmaN79ds9TvLt6XurO9s/ZQIR
 F01V3Ifw8XDREw45vMqqShWvA/e5l7ffHBxtUBvmt+9x/zYBgGqq83KmJ/899s99RktljB
 ZamT2HX+z6KM0ZOQZfFOEk5zvtu48R8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-MpaHrEKfP5S4EQwBQx7opw-1; Tue,
 11 Nov 2025 12:36:48 -0500
X-MC-Unique: MpaHrEKfP5S4EQwBQx7opw-1
X-Mimecast-MFC-AGG-ID: MpaHrEKfP5S4EQwBQx7opw_1762882606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA1C51801321; Tue, 11 Nov 2025 17:36:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 762C130044E0; Tue, 11 Nov 2025 17:36:38 +0000 (UTC)
Date: Tue, 11 Nov 2025 17:36:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 04/16] tests/docker: add coreutils to the package list
Message-ID: <aRN0IrvQxSRTLOXb@redhat.com>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111171724.78201-5-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 11, 2025 at 05:17:11PM +0000, Alex Bennée wrote:
> We need coreutils to run the IO tests so we need to include it in the
> package list. Now we have the latest libvirt we can do that.

s/libvirt/libvirt-ci/

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
>  scripts/ci/setup/debian/debian-13-ppc64le.yaml        | 1 +
>  scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml      | 1 +
>  scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml        | 1 +
>  tests/docker/dockerfiles/alpine.docker                | 1 +
>  tests/docker/dockerfiles/centos9.docker               | 1 +
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
>  tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
>  tests/docker/dockerfiles/debian-riscv64-cross.docker  | 1 +
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
>  tests/docker/dockerfiles/debian.docker                | 1 +
>  tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
>  tests/docker/dockerfiles/fedora.docker                | 1 +
>  tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
>  tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
>  tests/lcitool/projects/qemu.yml                       | 1 +
>  tests/vm/generated/freebsd.json                       | 1 +
>  24 files changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


