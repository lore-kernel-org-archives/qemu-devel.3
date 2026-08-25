Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF6EC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6a-0000fK-KE; Tue, 25 Aug 2026 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6Z-0000ar-AY; Tue, 25 Aug 2026 07:14:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6X-0008GM-KK; Tue, 25 Aug 2026 07:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=8jW0uobWqgGMEEAWxQjaGDT7qpTehZlHMBF0QdRKTN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gfxAEKzLk0Iz1z9w8c1P8IEZBj0+MMzgoG06LWG8JlpmSBOsfXWuumT3XcRxCe56S
 6ShhXESljMfxWfJOcJ+0PaIr/hi1cHBVEoeZ14tJTB0IRcxpyypOcmWcjQEwmuoV9E
 9r+rYnuwjjBqxvNRLwp1H3MInEt/16hwi8OhbyGv/rtH6MVP2BSCvFFekywRbFp/yu
 uYyOU0aq/Jekq0DKg6iIvhKNS3UXhICMj8Uc2+U3g8/E1SBsl3YlivlGfo5OTdc1qc
 z+BX/EdqIR4ryXrLM3eJC1yDhmSBfsQQuTyLHeP8w85GpsEpSdNPUDIZVvz+IOU/W6
 QucqAjyEDWYjQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2C1C41CE4AC;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 452BF416278;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7BEFF3259B; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 144/166] meson: make linker warnings non-fatal on
 Linux
Date: Tue, 25 Aug 2026 14:11:40 +0300
Message-ID: <20260825111206.482723-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

These cause a werror=true build to fail with Meson 1.12.0, as it now
makes linker warnings fatal as well.

Cc: qemu-stable@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 501187d0bc62a46628acc25e0ea0187094f04246)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index f94d84e2d31..9cadd636f74 100644
--- a/meson.build
+++ b/meson.build
@@ -612,6 +612,11 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-seh', '-Wl,--nxcompat')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
+if host_os == 'linux' and get_option('werror') and get_option('prefer_static')
+  # On glibc systems, glib causes warnings about getpwuid, getpwuid_r
+  # and getpwnam_r not being supported with static linking
+  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-fatal-warnings')
+endif
 
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
-- 
2.47.3


