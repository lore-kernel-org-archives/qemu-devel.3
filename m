Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0207CDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcppU-0003JY-17; Thu, 25 Jun 2026 15:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcppL-0003Hz-75
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcppJ-0000xD-MK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782416007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h/SmY6yVvNmqusFF/LfBaJsLaHgoY2vneNH16wzA4hM=;
 b=cm9oA5yWrRtJHu5qxEyXQ6fTgU1god16NCeOJ8uLT9ifVlzKK2p58FtOLw5sRFJC0DDHY+
 Ff1DBoSQMC6J44U2gpZBY/E8sYDpUAqi8tWYA+lZD2ntakt3ZrLvdMEakbaUHFSgNa7GJT
 zzRYKH5iiZrOX2nEaZlcIrk39E22AOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-NA9i-zPlP82ws_0InOywFg-1; Thu,
 25 Jun 2026 15:33:26 -0400
X-MC-Unique: NA9i-zPlP82ws_0InOywFg-1
X-Mimecast-MFC-AGG-ID: NA9i-zPlP82ws_0InOywFg_1782416003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A17ED18001DE; Thu, 25 Jun 2026 19:33:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.255])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E07518001D2; Thu, 25 Jun 2026 19:33:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] tests/docker: bump emsdk-wasm64-cross zlib version to 1.3.2
Date: Thu, 25 Jun 2026 15:33:20 -0400
Message-ID: <20260625193320.260312-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Container image builds have started failing because zlib.net no longer
hosts the 1.3.1 tarball. Move to the 1.3.2 release from February 17,
2026.

  $ make docker-image-emsdk-wasm64-cross
  changing dir to build for make "docker-image-emsdk-wasm64-cross"...
  make[1]: Entering directory 'qemu/build'
    BUILD   emsdk-wasm64-cross
  ...
  xz: (stdin): File format not recognized
  tar: Child returned status 1
  tar: Error is not recoverable: exiting now
  Error: building at STEP "RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz |     tar xJC /zlib --strip-components=1": while running runtime: exit status 2
  make[1]: *** [qemu/tests/docker/Makefile.include:43: docker-image-emsdk-wasm64-cross] Error 2
  make[1]: Leaving directory 'qemu/build'
  make: *** [GNUmakefile:6: build] Error 2

Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
index 8a924816f92..cbe20c7193e 100644
--- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
@@ -1,7 +1,7 @@
 # syntax = docker/dockerfile:1.5
 
 ARG EMSDK_VERSION_QEMU=4.0.10
-ARG ZLIB_VERSION=1.3.1
+ARG ZLIB_VERSION=1.3.2
 ARG GLIB_MINOR_VERSION=2.84
 ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=0.44.2
-- 
2.54.0


