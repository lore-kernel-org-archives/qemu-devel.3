Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F36606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RhqOY5O1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp3M-00057M-R6; Fri, 27 Nov 2026 01:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1g-0003F2-5g; Fri, 27 Nov 2026 01:01:42 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1L-0005mZ-J1; Fri, 27 Nov 2026 01:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=cH2x/+3Ljp3dISf6dGGgz/+PbOitfvj4OPgaBeJtFpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RhqOY5O1KHxD0Es2HNQOwUAdF4atsXA3/0pCvtbs5Xn2lDUnq/X/p/Qp5bfkD+blb
 U6BarlTTLr/6HEGHh11YqKw8Sj1NB/2wqgRa9TXpuq1au2poUDYefinQXV9zHMmN7g
 1a4yxbWJ2ZZugVro4Zep7cwrIhBGuLrtgu3Bf0jNO0oDEbWpJ+4noCLpT38f95maZg
 /cmxftbHexpl++AnDJ7O9lG+/1tY8xUKt353LErOhGOgyifv48TKA2VkMxRsfyF9gO
 HtkroJR02vHsWBZv2zSgOXosnTSXBtwMzNgYOvpAvu7NoOHRilV7zWICtvKMtnh5Wt
 MBkATABVJY6nA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CC07D1EA30F;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C9E7846994F;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A35C2CF29E; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 132/140] hw/display/vmware_vga: Zero-initialize
 scratch space
Date: Fri, 27 Nov 2026 08:53:58 +0300
Message-ID: <20261127055421.39015-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The vmware_vga device has a set of scratch registers which the guest
can use for anything it likes; we implement these by backing them
with a lump of memory pointed to by s->scratch. However, we allocate
it with g_malloc(), which means they start out with uninitialized
contents. We should zero this memory so that we don't potentially
leak host memory contents to the guest, and so that the guest will
always see deterministic values.

Since s->scratch has type "uint32_t *" and s->scratch_size is its
size in 32-bit words, prefer g_new0() over g_malloc0() for this.

Cc: qemu-stable@nongnu.org
Fixes: d34cab9f49bc3 ("VMware SVGA II emulation, by Andrzej Zaborowski.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4519
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit fe8c3c714990779540660acc403a7ca03f988fce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index fda3965ca3c..54532d6f08d 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1255,7 +1255,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                         MemoryRegion *address_space, MemoryRegion *io)
 {
     s->scratch_size = SVGA_SCRATCH_SIZE;
-    s->scratch = g_malloc(s->scratch_size * 4);
+    s->scratch = g_new0(uint32_t, s->scratch_size);
 
     s->vga.con = graphic_console_init(dev, 0, &vmsvga_ops, s);
 
-- 
2.47.3


