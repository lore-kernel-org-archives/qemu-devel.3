Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0724ECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIS04-0001eW-Lm; Sun, 18 Oct 2026 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.tseng.cs@gmail.com>)
 id 1xIQaV-0007Zo-5t
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:06:07 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alan.tseng.cs@gmail.com>)
 id 1xIQaT-0008Jh-IQ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:06:06 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-353804b591eso2274049eec.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792328763; x=1792933563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9tMR+olXMdJCCJ+hyk5RR8TVmNNqbZbzp05S7KrdxMQ=;
 b=fmnpmtrSYL1VUpR9TQ7+PLk2ZD9XdFBgkPFNVkoEnbP1dKPAknb1mUXQKGEriRQjj4
 NnTOQZH5gBvwwUmEac4tI/Enl7HHPKoxsvHVAhPVSrSHjNZW0Am8UxjOmf0Cu/OdyiSa
 JeCJaq2srDAskeHq4zHVvKqNEpmh+MSsUXbTwxI+qEqKemQwzC/g+JW5iL0NhYrbfVg+
 Qw6MOAOTnhimhgLCMUdNuIMTqHrOzWyIiNP9+LD/ORZ+3a8aArvu+QpxESE87zCmfYJi
 Pj6m3snsIMtLNy3VArTcNnHuKJBBMd1YfWw3Nc7iBxKo+izRaQ+zBtx+23Wpliw3oiYu
 Hcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328763; x=1792933563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9tMR+olXMdJCCJ+hyk5RR8TVmNNqbZbzp05S7KrdxMQ=;
 b=Ai2imTRhsHKcRVonUYTLDHQh9zj9fNTOUHwfr/Ssyhws2bQkM6iFvEHQXSG5rnMF3S
 KLUYyPQE9vF9hzxWE+a5BqH/RwJe22qk0a3+gw1wVAfwHDaTiDBavEP7Q7aK5pj9uz7N
 D7A4F90Am4pSrp31L7cxTFo6Jp9vDiQQyI608QBtA5N+MzExZAXp6RP3IUQ1T/dv4S9S
 qpxPKe0CBBm5bef2Dp4V/uskJWQPvDsZSbK1AnvvjJm/cftdc5U+ztIiu3i+VbZ01vt4
 8ozJnSOa4NOAtJvzJ/9lTFA8kzR/YOTh1aRopGPrxnLUix/33iVbuukCM9Jl2h5/cHI1
 x6AQ==
X-Gm-Message-State: AFq9FYIIGkCi4ctHdOoCDOq81IIXmp8x0GlXayau6iyrSc+gpsO1MupK
 dqz7uNcsCq67YOx51f2q1pgN9nUy+eHiqbd249W+3VHNgcRPW0rfzIMfA0k1J4Fa
X-Gm-Gg: AYBFou0yjnhLwxa18ru2icw7JXjvdRn3kklwdulLVb9X2fSxPwbqHiNfdQahEChMYeT
 h+ulTKGah6qV4PHhTWaPOqPpfIvgZxyo6vPvdlJSU0BU4hvdBtuSsDHvBg3Lh81PnMID1n9Vln6
 IztXOwbnXZUk+19JZDNN2IWxONNoPcUH3sSeq6NmLsrYQX3tix3DgTuVwkAdKQa2oIoFNioXPYd
 WIyip8oR2y50Qdv/6r0aGF7MKslzo1xDidBtCwnezZerNsrR/tJBORwbyu916CWgYiseZkfFxsR
 uw92N5VXXwojFa6ANIMib5e8bOCmock3txvez0W/FPoY6mbiGRrVLIMacLA2vj1vR2XyoicArph
 RA9T9iYKHRsxZ/YFF5r1N8P1CYx0Nb1dz8h7nHoWjkeW3f4FjX3UVh8C5Rgf5ulC93ns8bHEql5
 V+hBEuvIKJqB9LIJioCnY1KibVuoph9mVPM2qaKe2N68RllcD29dkpjHcRMFlyrmIi85NuR15j9
 5xVf914PcJEtNWYcMMtor1GrRb8oh9a4pjd68C/Tu8ZieuuTP+mhsW5IBrxJR5Rd2j/jt6yBysg
 CO3pKVgd2kqz3c+lYLG5aZmnxaidpHLToTrwheSU/7lHcAN92W979w==
X-Received: by 2002:a05:693c:6312:b0:353:7f17:4358 with SMTP id
 5a478bee46e88-361a1c4888dmr8184023eec.24.1792328763136; 
 Sun, 18 Oct 2026 06:06:03 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0cc23sm28259553eec.2.2026.10.18.06.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:06:02 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	philmd@oss.qualcomm.com,
	bmeng.cn@gmail.com
Subject: [PATCH] hw/sd: sdhci: Add Auto CMD23
Date: Sun, 18 Oct 2026 21:06:00 +0800
Message-ID: <20261018130600.1611094-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=alan.tseng.cs@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 18 Oct 2026 10:36:28 -0400
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

When Linux uses eMMC on SDHCI v3, multi-block write will fail and cause
"Card stuck being busy". This is because the mask of Transfer Mode
filters out the Auto CMD23 bit, and QEMU does not send CMD23
automatically.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 2116995dcc..0fca664217 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -47,6 +47,7 @@
 #define SDHC_TRNS_READ                 0x0010
 #define SDHC_TRNS_MULTI                0x0020
 #define SDHC_TRNMOD_MASK               0x0037
+#define SDHC_TRNMOD_CMD23_MASK         0x003F
 
 /* R/W Command Register 0x0 */
 #define SDHC_CMDREG                    0x0E
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f72..27bebf336d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -361,6 +361,21 @@ static void sdhci_send_command(SDHCIState *s)
 
     s->errintsts = 0;
     s->acmd12errsts = 0;
+    if ((s->trnmod & SDHC_TRNS_ACMD23) &&
+            (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
+            (s->trnmod & SDHC_TRNS_MULTI)) {
+        if ((s->trnmod & SDHC_TRNS_DMA) &&
+                SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: guest enables Auto CMD23 in SDMA mode\n",
+                    __func__);
+        }
+        request.cmd = 0x17;
+        request.arg = s->sdmasysad;
+        trace_sdhci_send_command(request.cmd, request.arg);
+        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
+        s->rspreg[3] = ldl_be_p(response);
+    }
     request.cmd = s->cmdreg >> 8;
     request.arg = s->argument;
 
@@ -370,7 +385,7 @@ static void sdhci_send_command(SDHCIState *s)
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
         if (rlen == 4) {
             s->rspreg[0] = ldl_be_p(response);
-            s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
+            s->rspreg[1] = s->rspreg[2] = 0;
             trace_sdhci_response4(s->rspreg[0]);
         } else if (rlen == 16) {
             s->rspreg[0] = ldl_be_p(&response[11]);
@@ -1324,7 +1339,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             mask |= 0xffff;
         }
 
-        MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
+        if (s->sd_spec_version >= 3) {
+            MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_CMD23_MASK);
+        } else {
+            MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
+        }
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
 
         /* Writing to the upper byte of CMDREG triggers SD command generation */
-- 
2.43.0


