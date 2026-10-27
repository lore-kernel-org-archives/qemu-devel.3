Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89626606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SljFxvJ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagh-0002Sq-94; Tue, 27 Oct 2026 02:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagQ-0002CS-LU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagM-0008Bx-HQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:16 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so2728574a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082551; x=1793687351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dld1zD6CbfPT0zZ4UkbwZCYnWfVGLMrgPncev2o0Wi8=;
 b=SljFxvJ6EnUjVude1MB3EwzA/L9TppUfCW2AilHoGK1eWplb4BSNpp4/Ng8DA8xDrc
 vYOeW9JfM77gMuOWyzOOB8D9ednIoUwQUkIjbJQZGGYmiAyB/JuOmHDemrA0moPgPIni
 nCq3rUy8NWFmf3B6ZM1VJJPpPK+01SWeQeacX8fnDuVByLS2DkC8ULOBC+DIAqZUwuys
 MouY07+Zl6F5aCXMYLmnSm3Bhq81P+nGmBC/XAMbibKEccdmXuUGpQvTxeEE9Dqvx6vf
 Rj4FWMlIfMkAcNbtgJtVMQJrOjSltlR1r4FtwowtRt5x3CXEu5nFE38W7ypRxKPecqzW
 2AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082551; x=1793687351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dld1zD6CbfPT0zZ4UkbwZCYnWfVGLMrgPncev2o0Wi8=;
 b=cDyTO37zSdmtpvAMioniYWU3CBQ8oUVLBO9k+4bkDjQ0AjYUAxW8Z6/RkBB/YRgsfK
 nOmCjaPDp4jgZgzLMwF/A2Eq/4gxQxPNNsmVBYX8JvuQUvwlcIqjSaA83BUNZUPPNTJU
 Qu4yy8TzM3wIfHpUFwMrCsl267NCipBDqQJeWQwFaBb7PS6T6f2zB6M2AXGpNohMekvC
 m1RBaEOrh5qX6nTAcms1VjXMa1o9sQ2dJiXgyRRaJjx87QRlGB9U+nhN3a42w21CdP5V
 RWynTOEEI5oAv3jAhqi/bYpvy3zGSgX3nYt9nRH7P2U16QFs6i3vSMd0nPpwdONRO5/L
 hQYA==
X-Gm-Message-State: AFq9FYKcWS/EfZZlp1zvfwZAX0JyMOCUXcC6Cz5ZUijdXBOfqNR5HSvZ
 WKcoLW1JJipTkLZ0zz04qfy5bCS7htZOPbi2S1mSJjP6wtIzvzy4vF15/RAXNQ==
X-Gm-Gg: AYBFou3EY9RzqrH1YRexi/VVIywvukGJ5xFt0qnUo8/HeLfXKOJUeQdiSsIKk3r/r+v
 NkNauV0adn8MBgjQ/a8RAbDiZ3Qgeb+swVTj+P/2iuPgHscE0uHi6qqvMvsnj531akTZ4Vgg2aT
 aBU89200AO8a7xi8ctdqn4KkJL+j0kHJkZu+SMniA7HIzDtzHMm3cwGpyjcRhkngudvcDav4klx
 1+4C3jemcHHNipdI7yNa75SiQvEcxH4NHX5t6ZocecATHkorROROKFDcxhQMMnTfS+bLN8nreZO
 mxvbgIPQHc07DJUkqUp8FL9/2/72mN1UFPNz6uIr1Q6ZQdOJ9HRHnONQH9TVR2KBSIl5iLT2L/G
 QxjRx8BgyPuOy//h08FgYmq9TR70CVwjafOudYw92QBQXqGkGNVHDS2vS1tR6vq7e98eCUmIFpO
 2GsEmKNUA9YC7hTHlJwFKwXpiTKBBkY7Nu5A8InoWygPw6cTiveEeZhFn0iuvWfCe2HjYOIvLID
 hcl94eJBScsKIWDj7fRDnEtdAkrjSinKaQOSVy10QjlHBZuiDnwEO35j6ouTXZKSbBOz1jZ1A==
X-Received: by 2002:a17:90b:4a81:b0:3ad:ce24:acfa with SMTP id
 98e67ed59e1d1-3adeaae632emr7093700a91.20.1793082550837; 
 Mon, 26 Oct 2026 23:29:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtaodtdt@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Tao Ding <dingtao0430@163.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/29] hw/dma: fix k230_gsdma integer handling issues
Date: Tue, 27 Oct 2026 16:27:53 +1000
Message-ID: <20261027062808.1995205-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Ding <dingtaodtdt@gmail.com>

Separate global and channel register handling to prevent unsigned address underflow
when calculating GSDMA channel offsets.

Resolves: Coverity CID 1685514

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20261018141006.16398-6-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/dma/k230_gsdma.c | 84 ++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
index 7635cd19e88e..bd6db9e64d29 100644
--- a/hw/dma/k230_gsdma.c
+++ b/hw/dma/k230_gsdma.c
@@ -304,54 +304,54 @@ static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
     hwaddr ch_off;
     uint64_t ret = 0;
 
-    switch (addr) {
-    case K230_GSDMA_DMA_CH_EN:
-        ret = s->dma_ch_en;
-        break;
-    case K230_GSDMA_DMA_INT_MASK:
-        ret = s->dma_int_mask;
-        break;
-    case K230_GSDMA_DMA_INT_STAT:
-        ret = s->dma_int_stat;
-        break;
-    case K230_GSDMA_DMA_CFG:
-        ret = s->dma_cfg;
-        break;
-    case K230_GSDMA_DMA_WEIGHT:
-        ret = s->dma_weight;
-        break;
-    default:
-        if (addr < K230_GSDMA_CH_BASE) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                        "%s: not implement gdma at offset 0x%" HWADDR_PRIx
-                        "\n", __func__, addr);
-        }
-        break;
-    }
-
-    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
-    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
-    if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
-        switch (ch_off) {
-        case K230_GSDMA_CH_CTL:
-            break;
-        case K230_GSDMA_CH_STATUS:
-            ret = s->channels[ch].status;
+    if (addr < K230_GSDMA_CH_BASE) {
+        switch (addr) {
+        case K230_GSDMA_DMA_CH_EN:
+            ret = s->dma_ch_en;
             break;
-        case K230_GSDMA_CH_CFG:
-            ret = s->channels[ch].cfg;
+        case K230_GSDMA_DMA_INT_MASK:
+            ret = s->dma_int_mask;
             break;
-        case K230_GSDMA_CH_USR_DATA:
-            ret = s->channels[ch].usr_data;
+        case K230_GSDMA_DMA_INT_STAT:
+            ret = s->dma_int_stat;
             break;
-        case K230_GSDMA_CH_LLT_SADDR:
-            ret = s->channels[ch].llt_saddr;
+        case K230_GSDMA_DMA_CFG:
+            ret = s->dma_cfg;
             break;
-        case K230_GSDMA_CH_CURRENT_LLT:
-            ret = s->channels[ch].current_llt;
+        case K230_GSDMA_DMA_WEIGHT:
+            ret = s->dma_weight;
             break;
         default:
-            break;
+            qemu_log_mask(LOG_GUEST_ERROR,
+                        "%s: not implement gdma at offset 0x%" HWADDR_PRIx
+                        "\n", __func__, addr);
+            return ret;
+        }
+    } else {
+        ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
+        ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
+        if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
+            switch (ch_off) {
+            case K230_GSDMA_CH_CTL:
+                break;
+            case K230_GSDMA_CH_STATUS:
+                ret = s->channels[ch].status;
+                break;
+            case K230_GSDMA_CH_CFG:
+                ret = s->channels[ch].cfg;
+                break;
+            case K230_GSDMA_CH_USR_DATA:
+                ret = s->channels[ch].usr_data;
+                break;
+            case K230_GSDMA_CH_LLT_SADDR:
+                ret = s->channels[ch].llt_saddr;
+                break;
+            case K230_GSDMA_CH_CURRENT_LLT:
+                ret = s->channels[ch].current_llt;
+                break;
+            default:
+                break;
+            }
         }
     }
 
-- 
2.55.0


