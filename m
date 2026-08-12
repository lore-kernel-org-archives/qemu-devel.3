Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44804C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuANA-0003mH-1Z; Wed, 12 Aug 2026 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALK-00085V-Lq; Wed, 12 Aug 2026 10:54:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALI-0007MX-Se; Wed, 12 Aug 2026 10:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=pOMgOKRM4rbRq8fDbVj/Zk8bGiWSVevgV5ZiXr+IC+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B8/eSNtivrf2JUa31wlQDqt5Rwt28QnSoFCnX8l2VcgiBR7YJRjLewxHZUl0xwxcq
 chl+3ifsfyppJwV5AWpqsPG186aQzoXClhB/zxPpBDOz5xuQIb6x26ZgAmwdunr/84
 jcdd9se/XjkrS0xaE+mbcnyBGd5ZSxQM/LMg1TqmpNtCo9vDU761dvfqEGqPzR0VBO
 5kndCBXAQeVitZWdiQ2oDgsVsGiDX3XQEtG7lJf0AG/3BHaF2nPL4wNbkUQcwPgQ1d
 iadLaquf99vUC06hvZEBvUWbnj6GMkwv15OG2GthDHtPRZe7GmrrNnGNIfzbNWQoJY
 LYTkC/MyK3Gzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DED2D1CA62F;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 45A53409D71;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A3FC72F9B9; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 043/120] hw/display/virtio-gpu: drop redundant
 node->value NULL checks
Date: Wed, 12 Aug 2026 17:48:26 +0300
Message-ID: <20260812144955.649205-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

QAPI-generated list visitors guarantee that node->value is never NULL:
the input visitor allocates it via g_malloc0() in visit_start_struct(),
and on failure the entire list parse is aborted and freed.

Remove the unnecessary NULL checks from both callsites iterating
g->conf.outputs.

Resolves: Coverity CID 1664272
Fixes: 8dc8449a678f ("hw/display/virtio-gpu: Avoid leaking migration blocker")
Fixes: 3e6cdc204e33 in 11.0.x
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260730114751.3515083-1-marcandre.lureau@redhat.com>
(cherry picked from commit 555d0a1eba204085e20421cd93a55276a21b8e5f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index e32c1932af0..2e7c6d5f50c 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -69,7 +69,7 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
 
     for (output_idx = 0, node = g->conf.outputs;
          output_idx <= scanout && node; output_idx++, node = node->next) {
-        if (output_idx == scanout && node->value && node->value->name) {
+        if (output_idx == scanout && node->value->name) {
             info.name = node->value->name;
             break;
         }
@@ -205,7 +205,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
             return false;
         }
-        if (node->value && node->value->name &&
+        if (node->value->name &&
             strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
             error_setg(errp, "invalid output name '%s' > %d",
                        node->value->name, EDID_NAME_MAX_LENGTH);
-- 
2.47.3


