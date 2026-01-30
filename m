Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C7D73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlf45-0006fK-Kw; Thu, 29 Jan 2026 22:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf43-0006ew-G4; Thu, 29 Jan 2026 22:20:55 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3w-0002Ud-2b; Thu, 29 Jan 2026 22:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769743229; x=1770002429;
 bh=kzUUR2QYb5BHyWwd+ng6OUyhVFYjakkzLpOlG2A7BQE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=1FXjvc31jIkqGlFwyWOSSAtKc1MUa7gtOxScMNoABXjW0DwIG3Bd5bsid7/ha5nrA
 lEA60dAZotwOVPV0XuTW3wMldguQrE01QaNE9Sra6/o8DLsCqiSjSFm4EDCg7i3zEJ
 4xvG3lJtK4GrclSQcfRc2Oir9y3dIFr8O76WvFNrlxAeH8SDK9lRIbEYhS19iosvsG
 b0j+C5WETxOyr+xYGpdrPF3xqLdo3j6A/jOpcReJUpPrfMwjfJ4npzhGwCPtHpa0+D
 i1j/8EFvTi2s2JawkXlzCbm/JQqacVWkxXpBh3tNeihaBbv1FIpF3jvcSHmJ0bDKbj
 qaJUo7ZgSkzKg==
Date: Fri, 30 Jan 2026 03:20:26 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v3 2/4 qemu] Add GNU/Hurd host_os=gnu
Message-ID: <20260130031954.1661880-3-damien@zamaudio.com>
In-Reply-To: <20260130031954.1661880-1-damien@zamaudio.com>
References: <20260130031954.1661880-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: 586449f9b91c96d7527242c2c179205708f5ef9c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=damien@zamaudio.com;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use same value for host_os as meson for GNU/Hurd.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 4b61fd3bbf..fae4d06352 100755
--- a/configure
+++ b/configure
@@ -372,6 +372,8 @@ elif check_define __APPLE__; then
 elif check_define EMSCRIPTEN ; then
   host_os=3Demscripten
   cross_compile=3D"yes"
+elif check_define __GNU__; then
+  host_os=3Dgnu
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
--=20
2.51.0



