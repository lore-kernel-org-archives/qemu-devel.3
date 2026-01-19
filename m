Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7BAD29C28
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1u-0002jZ-Oa; Mon, 19 Jan 2026 09:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vhmS9-0000BR-2K; Mon, 19 Jan 2026 05:25:45 -0500
Received: from mwd01m.fhofhammer.de ([2a02:c207:3002:3725::1])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vhmS7-0000II-Gw; Mon, 19 Jan 2026 05:25:44 -0500
Message-ID: <018a86fd-b831-4fd6-b479-9d73e2e95ee0@fhofhammer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhofhammer.de;
 s=2023; t=1768818331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=KcTQnaxrkm4kdGKnfoHfDTipwHdRMY2Cf4qxbasUQWc=;
 b=bxOEQNXaMyeFkN8Xm846knVqPWA0++ibfhNbxz+pHZwni1njiY2ra4Xxy1BSYACaNhrX0Q
 7nH0VY0GFD8GVVKSvtNVUacVzCNBLvvdlZN4TA8w3idx9PLqdfd0dwbJzQq8XcOvmerPVX
 5+uo0yEDuVn78+odYZ/h2UOdUT+YBemJKzFXoAVyX1suOxgN2Te0xyAarlbUkY5nhD5V2z
 znDo5/EHUac/OOaLzr9dgHp9lRFDnbS26h+p/t+nzKGUv+mccXxW5nDa8AOyhWwERO5Cc9
 ZyohfzhqjZ63C9URxEFWPmy2XSkgsOCpdPJUg8d7byaZaIgt/NJIieLW7sMbZanzdCVR+M
 HqNin+U7D/Fnk1NbhwV99v7a7GCOr7LVph0lvkAb2aukatn/QGuBK5qy7hOmIGu2Q7hvMF
 vb7IwE6hKB/CUAq16bg5p81TO0EYjWD6QNon2lNG2qKiZOBJKGjDN9hn3d5OF4YKZQqqZ7
 H6OvnIp9NXQ/Z5zTBFDVSg9A7GRYseuWnKLRFaaXE7IAC6tLEgIniCMtG63S+pKxh4NBy+
 BwYbz3RvhWDs6Aa/5TamJLT1p3hBjcmCktjQifQg9MayfoMoADk2qE8q8Mujl3u2Qmyt7S
 p1AU/4PJsBgUWL+ZvPO7I8PiUIl7+fnPwk9EtFaIYeV5xun9NXbDs=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=florian.hofhammer@fhofhammer.de
 smtp.mailfrom=florian.hofhammer@fhofhammer.de
Date: Mon, 19 Jan 2026 11:25:30 +0100
MIME-Version: 1.0
From: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Subject: [PATCH trivial] configure: add ppc target back to container tests
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-trivial@nongnu.org
Autocrypt: addr=florian.hofhammer@fhofhammer.de; keydata=
 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
 /zEc5hMMZIzTI4AtIcgA3xe4Ew==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:c207:3002:3725::1;
 envelope-from=florian.hofhammer@fhofhammer.de; helo=mwd01m.fhofhammer.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:02 -0500
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

Commit 2ff8c9a298 removed support for 32-bit PPC hosts from the build
system. Unfortunately, the patch also removed the 32-bit PPC target for
containerized tests, which leads to an error when trying to run tests,
e.g., with "make check-tcg":
"make[1]: *** No rule to make target 'docker-image-debian-ppc-cross',
needed by 'build-tcg-tests-ppc-linux-user'.  Stop."

This patch adds the PPC target back for containerized tests.

Fixes: 2ff8c9a2984bb20e350ae52152812c5370b02e32
Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index e69b3e474e..1b0af0cf46 100755
--- a/configure
+++ b/configure
@@ -1451,7 +1451,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      ppc64|ppc64le)
+      ppc|ppc64|ppc64le)
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
-- 
2.51.0


