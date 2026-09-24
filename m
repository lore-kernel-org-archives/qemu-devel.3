Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F5C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fGZ-00071l-L8; Thu, 24 Sep 2026 04:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9fGX-00071N-S4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 04:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9fGW-0008Ee-4Y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 04:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240234;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucZvTJfxlED+A400UR1dT82ILDT8r+iwF+YnwooPwZM=;
 b=EUZAIjt/bq1KacooW0HTaGbJ4bbebGmrPYflQS6iGOoa1mO9l4a55VaipfHbrZh6NL2Rle
 VfjNGXb9038ZdWKH1KdyiaFBaOed/vvbDbUUhGzOx+UDy0Ee8+LXbnD2+6uNTiW15SDVfX
 C3mRzpbDk8vXDFXy9+3MG5ODg00+yjI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-37DdVdeoM6ar3bSakMa1wA-1; Thu,
 24 Sep 2026 04:57:10 -0400
X-MC-Unique: 37DdVdeoM6ar3bSakMa1wA-1
X-Mimecast-MFC-AGG-ID: 37DdVdeoM6ar3bSakMa1wA_1790240228
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 973431955DD0; Thu, 24 Sep 2026 08:57:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 350EA3000229; Thu, 24 Sep 2026 08:57:07 +0000 (UTC)
Date: Thu, 24 Sep 2026 09:57:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@oss.qualcomm.com, alex.bennee@linaro.org
Subject: Re: [PATCH v2 2/6] tests/lcitool/refresh: generate dockerfiles using
 --host-arch x86_64
Message-ID: <arTl4BnGkCAKiXWR@redhat.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
 <20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923185725.863311-3-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, Sep 23, 2026 at 11:57:21AM -0700, Pierrick Bouvier wrote:
> To ensure refresh output is consistent on any host architecture, we need
> to specify which host arch it's supposed to target.
> Indeed, by default, package list will depend on host architecture, which
> means that output will depend on which machine runs refresh command.
> For example, on aarch64 host, refresh removes libpmem-dev package since
> it's not available.
> 
> Also, update lcitool submodule: It now uses arch specific images by
> default. Thus we update all images at the same time.
> https://gitlab.com/libvirt/libvirt-ci/-/commit/f34cd57eb892259c26600187bc35cc4152f932cf
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/alpine.docker                | 2 +-
>  tests/docker/dockerfiles/centos9.docker               | 2 +-
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++--
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++--
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++--
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++--
>  tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++--
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++--
>  tests/docker/dockerfiles/debian-riscv64-cross.docker  | 4 ++--
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++--
>  tests/docker/dockerfiles/debian.docker                | 4 ++--
>  tests/docker/dockerfiles/fedora-rust-nightly.docker   | 2 +-
>  tests/docker/dockerfiles/fedora-win64-cross.docker    | 2 +-
>  tests/docker/dockerfiles/fedora.docker                | 2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker         | 2 +-
>  tests/docker/dockerfiles/ubuntu2404.docker            | 2 +-
>  tests/lcitool/libvirt-ci                              | 2 +-
>  tests/lcitool/refresh                                 | 2 +-
>  18 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


