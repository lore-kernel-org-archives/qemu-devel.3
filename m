Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C26606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=M01zoRFm;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=M01zoRFm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0uz-0004aU-Uh; Thu, 22 Oct 2026 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=I/bx=IM=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xK0ux-0004a0-JN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:05:47 -0400
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]
 helo=sonata.ens-lyon.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=I/bx=IM=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xK0uv-0001ya-G1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:05:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id D0943A1B15;
 Fri, 23 Oct 2026 00:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792706740; bh=m11GX5FQ5i4xyXRphJr/ZZBZdB05vzxuhD75z+5fptQ=;
 h=From:To:Cc:Subject:Date:From;
 b=M01zoRFmWgXl6OVHZKKDeEPRR3ScBOaADdUomvCGc9/MVlfdYklO8ajARNd7iJEX8
 X3IwsSOwY+lKRnvDE+A06FoSVNoHRSHGP1ZPAaIkJAtS0fJ+ATZthcBoy6ugO4M+bk
 FTd9BhVPVRQfELZe/V3O9ROwrann/wp2oAFbCFqXodlB435eNF+XYaR4jsYJ5RJeyn
 lImMbB/LiczIMpfRxVfg8qapvjJkE04htiQz1AiuyZcOmrpN9UVod9USJ2o54yQEGo
 UXr8oEF85KvlQRTbUc5OF+ixKlBV4ts4+KwOQSFnWBYn3AeTuRMnUcaObxxc+ZEuGR
 CBpxZx/mf15rA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54jZZ82yM9fB; Fri, 23 Oct 2026 00:05:40 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id A1515A1AAC;
 Fri, 23 Oct 2026 00:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792706740; bh=m11GX5FQ5i4xyXRphJr/ZZBZdB05vzxuhD75z+5fptQ=;
 h=From:To:Cc:Subject:Date:From;
 b=M01zoRFmWgXl6OVHZKKDeEPRR3ScBOaADdUomvCGc9/MVlfdYklO8ajARNd7iJEX8
 X3IwsSOwY+lKRnvDE+A06FoSVNoHRSHGP1ZPAaIkJAtS0fJ+ATZthcBoy6ugO4M+bk
 FTd9BhVPVRQfELZe/V3O9ROwrann/wp2oAFbCFqXodlB435eNF+XYaR4jsYJ5RJeyn
 lImMbB/LiczIMpfRxVfg8qapvjJkE04htiQz1AiuyZcOmrpN9UVod9USJ2o54yQEGo
 UXr8oEF85KvlQRTbUc5OF+ixKlBV4ts4+KwOQSFnWBYn3AeTuRMnUcaObxxc+ZEuGR
 CBpxZx/mf15rA==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xK0uq-0000000ABmw-0d9w; Fri, 23 Oct 2026 00:05:40 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: [PATCHv2] baum: send device identity and cell count on protocol off/on
Date: Fri, 23 Oct 2026 00:05:37 +0200
Message-ID: <20261022220537.2424009-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=I/bx=IM=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hardware devices do identify themselves when the driver turns the
protocol off and on again. NVDA expects to get it.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 chardev/baum.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 166d6f2f09..93775faf81 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -95,9 +95,12 @@ struct BaumChardev {
 
     brlapi_handle_t *brlapi;
     brlapi_fileDescriptor brlapi_fd;
+
+    /* Initialized in baum_deferred_init */
     unsigned int x, y;
     bool deferred_init;
 
+    bool protocol_on;
     uint8_t in_buf[BUF_SIZE];
     uint8_t in_buf_used;
     uint8_t out_buf[BUF_SIZE];
@@ -337,13 +340,27 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
     }
 }
 
+static void baum_send_cell_count(BaumChardev *baum)
+{
+    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
+    baum_write_packet(baum, cell_count, sizeof(cell_count));
+}
+
+static void baum_send_device_identity(BaumChardev *baum)
+{
+    uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
+        'B','a','u','m',' ','V','a','r','i','o' };
+    identity[11] = '0' + baum->x / 10;
+    identity[12] = '0' + baum->x % 10;
+    baum_write_packet(baum, identity, sizeof(identity));
+}
+
 /* Called when the other end seems to have a wrong idea of our display size */
 static void baum_cellCount_timer_cb(void *opaque)
 {
     BaumChardev *baum = BAUM_CHARDEV(opaque);
-    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
-    baum_write_packet(baum, cell_count, sizeof(cell_count));
+    baum_send_cell_count(baum);
 }
 
 /* Try to interpret a whole incoming packet */
@@ -441,17 +458,18 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
         uint8_t protocol;
         DPRINTF("SetProtocol\n");
         EAT(protocol);
-        /* ignore */
+        if (!baum->protocol_on && protocol) {
+            /* Switching on, answer with device identity and cell count */
+            baum_send_device_identity(baum);
+            baum_send_cell_count(baum);
+        }
+        baum->protocol_on = protocol;
         break;
     }
     case BAUM_REQ_GetDeviceIdentity:
     {
-        uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
-            'B','a','u','m',' ','V','a','r','i','o' };
         DPRINTF("GetDeviceIdentity\n");
-        identity[11] = '0' + baum->x / 10;
-        identity[12] = '0' + baum->x % 10;
-        baum_write_packet(baum, identity, sizeof(identity));
+        baum_send_device_identity(baum);
         break;
     }
     case BAUM_REQ_GetVersionNumber:
-- 
2.53.0


