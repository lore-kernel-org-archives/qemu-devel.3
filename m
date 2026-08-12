Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C0BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8p5-0007uz-CN; Wed, 12 Aug 2026 09:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8lI-0003nb-Vd; Wed, 12 Aug 2026 09:12:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8lE-0006Wa-Qm; Wed, 12 Aug 2026 09:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=MKn2ZR/R8lF/nHQOOCgJ12cs+ZEPufekBK83OaQgVDY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fSJpp5lCk4bkgqU4VYatd53cnYJtzuPtWiZxAqKYKDrlDs5CiXfLOL6+ogSW/2qG5
 l7Lb4uQHPuC7JA2qOR41uww6PfV7N1nd0G7edmjhVG4sMh2ovOfZ5CkYLJuuBprJ+s
 9aAKusTaL17Ea08oJFUeFXDCLrH4cefUKAyzdp/pin4+jcLQ4lkus4TqCuSaG7X0gF
 lYWk+9AHNraKXuLd2bN5e6zPir2BMPugl2L0zSvwIgf6TjOafzBpdT20Q5t6o9Cyuh
 CJZNSqASDzUlZGagnApC8OAkR8oG+ZR4tDhWdrxlFRyzvRqmhhFb1/PZi8hxLr4RCi
 wV8bvHu2UG3JQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D38721CA4E2;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 151A8409BC5;
 Wed, 12 Aug 2026 16:03:16 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D45362F95A; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 099/102] gitlab: disable provenance attestations to
 work around CI bug
Date: Wed, 12 Aug 2026 16:02:14 +0300
Message-ID: <20260812130233.621965-99-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

QEMU's CI pipeline involves building container images that will be used
to run builds and tests. A recent Docker change triggered the following
error:

  $ docker push "$TAG"
  ...
  error from registry: blob unknown to registry - sha256:4401f6f779caf8841cafd5f483e642fcac56a23a4e4a59523231e101c890dad9

https://gitlab.com/qemu-project/qemu/-/jobs/15701875927#L2372

This happens because Docker now pushes out-of-order and the GitLab
Container Registry rejects due to an unknown reference:
https://forum.gitlab.com/t/started-yesterday-docker-push-error-from-registry-blob-unknown-to-registry/134733/5

It is unclear at this point whether GitLab will modify the behavior of
Container Registry or whether Docker will ship a fix.

The current workaround is to disable the provenance attestation that is
involved in this issue. QEMU's CI pipeline container images are used
internally for testing and are not widely distributed. Provenance
attestation can be disabled as there are no external consumers of these
images. Expect to revert this commit in the future when GitLab or Docker
have released their own fixes.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260804165414.480435-1-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 9232220004434db1f3be5b2c8b1bba935b043acd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383d..ef22cf819fb 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -14,7 +14,7 @@
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
     - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
-      --build-arg BUILDKIT_INLINE_CACHE=1
+      --build-arg BUILDKIT_INLINE_CACHE=1 --provenance=false
       -f "tests/docker/dockerfiles/$NAME.docker" "."
     - docker push "$TAG"
   after_script:
-- 
2.47.3


