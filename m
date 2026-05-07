Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867EACD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtOg-0005Ar-MZ; Thu, 07 May 2026 03:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wKtOC-00057v-28
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wKtO9-0007iZ-E9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778139794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7UykGouzgr8ZqkkrLE9v+Xz1Z88tEpYgnKW272WBR8=;
 b=ZJBN39i5dL0jEzW4FtQB8xYDxh7OLJ9OYDngKXnNkP+enrUsaegA4gUxMUEYx4H3tDRgDd
 dvXZSnL+F1esTuLW3ikAONQnzjFKs67XSNeTPqNh1rVbGoQF6aRYn2DhWD7nkvSFyyX1+0
 MVEbVsXcebTf9kqJ9/PFnNgnxUbZQK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-oiqYNDbsMJOORgdQxJwLwA-1; Thu,
 07 May 2026 03:43:11 -0400
X-MC-Unique: oiqYNDbsMJOORgdQxJwLwA-1
X-Mimecast-MFC-AGG-ID: oiqYNDbsMJOORgdQxJwLwA_1778139790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86BB0180034E; Thu,  7 May 2026 07:43:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.115])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3984F180034E; Thu,  7 May 2026 07:43:05 +0000 (UTC)
Date: Thu, 7 May 2026 09:43:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 devel@lists.libvirt.org, integration@gluster.org,
 Nir Soffer <nirsof@gmail.com>, Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH] Remove the deprecated glusterfs block driver
Message-ID: <afxCh6JcPEefhF5o@redhat.com>
References: <20260507051639.2784590-1-thuth@redhat.com>
 <08637f36-ae2b-4191-b668-93e59e283c92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08637f36-ae2b-4191-b668-93e59e283c92@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 07.05.2026 um 08:08 hat Philippe Mathieu-Daudé geschrieben:
> On 7/5/26 07:16, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > Glusterfs has been marked as deprecated since QEMU v9.2, and as far
> > as I know, nobody spoke up 'til today that it should be kept.
> > The listed e-mail address integration@gluster.org in our MAINTAINERS
> > file seems to be bouncing nowadays, and looking at their website
> > https://www.gluster.org/ the most recent news are from 2020 / 2021 ...
> > so it seems like there is really hardly any interest in Glusterfs
> > anymore. Thus it's time to remove the code now from QEMU.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   MAINTAINERS                                   |    6 -
> >   docs/about/deprecated.rst                     |    8 -
> >   docs/about/removed-features.rst               |    7 +
> >   docs/system/device-url-syntax.rst.inc         |   39 -
> >   docs/system/qemu-block-drivers.rst.inc        |   84 -
> >   meson.build                                   |   47 -
> >   qapi/block-core.json                          |   52 -
> >   block/gluster.c                               | 1644 -----------------
> >   tests/qtest/modules-test.c                    |    3 -
> >   block/meson.build                             |    1 -
> >   meson_options.txt                             |    2 -
> >   .../ci/setup/debian/debian-13-ppc64le.yaml    |    1 -
> >   .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |    1 -
> >   .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |    1 -
> >   scripts/coverity-scan/coverity-scan.docker    |    1 -
> >   scripts/coverity-scan/run-coverity-scan       |    2 +-
> >   scripts/meson-buildoptions.sh                 |    3 -
> >   .../dockerfiles/debian-amd64-cross.docker     |    1 -
> >   .../dockerfiles/debian-arm64-cross.docker     |    1 -
> >   .../dockerfiles/debian-mips64el-cross.docker  |    1 -
> >   .../dockerfiles/debian-mipsel-cross.docker    |    1 -
> >   .../dockerfiles/debian-ppc64el-cross.docker   |    1 -
> >   .../dockerfiles/debian-riscv64-cross.docker   |    1 -
> >   .../dockerfiles/debian-s390x-cross.docker     |    1 -
> >   tests/docker/dockerfiles/debian.docker        |    1 -
> >   .../dockerfiles/fedora-rust-nightly.docker    |    1 -
> >   tests/docker/dockerfiles/fedora.docker        |    1 -
> >   tests/docker/dockerfiles/opensuse-leap.docker |    1 -
> >   tests/docker/dockerfiles/ubuntu2204.docker    |    1 -
> >   tests/lcitool/projects/qemu.yml               |    1 -
> >   30 files changed, 8 insertions(+), 1907 deletions(-)
> >   delete mode 100644 block/gluster.c
> 
> Need a rebase on top of commit f168046842c ("cocci: Do not
> initialize variable used by QLIST_FOREACH macro").
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Apparently we could now revert commits a6b257a08e3 ("file-posix:
> Handle undetectable alignment") and 3a20013fbb2 ("block: posix:
> Always allocate the first block"). Not sure if that could be
> useful for other backends or harmless. Cc'ing Nir.

I haven't looked at the specific code changes, but if it's file-posix,
it's unrelated to the builtin gluster block driver in QEMU, but a file
on a glusterfs mount on the host. We still need to behave correctly for
that. (And if it can happen with glusterfs, it probably can happen with
other filesystems, too.)

Kevin


