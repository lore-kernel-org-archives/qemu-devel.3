Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06432C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqwlR-000245-VW; Mon, 03 Aug 2026 13:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wqwlP-00023b-Mc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wqwlO-0008Po-6h
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 13:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785779264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WDqkx5QyPIeT6k7qWGOIIv+6UP61S7BFz5FbaJVqxBI=;
 b=WeGv7GmJDqWXlKsm1qVXSQd5AFh0pjfAfoONTJla4YYrsiRviK9T5heLO6fS5HFA7Y/N/b
 4wGteP8PAIoxVbxK+7KHx+Xn3E1zSLkwyDU7f3Car7fGnJ1Tf3wMNMVKguw7A/ZJ0NAn6D
 eBtOKOW/+IQZluahwJg4I8l8dOjmckg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-MAjjTXSZM3Olnwky72nJuw-1; Mon,
 03 Aug 2026 13:47:41 -0400
X-MC-Unique: MAjjTXSZM3Olnwky72nJuw-1
X-Mimecast-MFC-AGG-ID: MAjjTXSZM3Olnwky72nJuw_1785779259
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C42F18002E2; Mon,  3 Aug 2026 17:47:39 +0000 (UTC)
Received: from localhost (unknown [10.2.17.42])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15F0341C; Mon,  3 Aug 2026 17:47:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/docker: use stable URLs for zlib tarballs
Date: Mon,  3 Aug 2026 13:47:35 -0400
Message-ID: <20260803174735.362574-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The tarballs at https://zlib.net/zlib-X.Y.Z.tar.xz become unavailable
when a new release is made. This breaks the emsdk-wasm64-cross.docker
file that fetches the tarball and builds zlib from source.

There is actually an archive available with a stable URL. Use that
instead. This does require switching from bzip2 to gzip since bzip2
tarballs are not available in the archive.

The upshot is that the emsdk-wasm64-cross Docker image build will
continue working into the future without causing CI breakage when the
zlib project makes a new release.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
index c04a741b0e5..4f26ce7a269 100644
--- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
@@ -56,8 +56,8 @@ EOF
 FROM build-base AS zlib-dev
 ARG ZLIB_VERSION
 RUN mkdir -p /zlib
-RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
-    tar xJC /zlib --strip-components=1
+RUN curl -Ls https://zlib.net/fossils/zlib-$ZLIB_VERSION.tar.gz | \
+    tar xzC /zlib --strip-components=1
 WORKDIR /zlib
 RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
-- 
2.55.0


