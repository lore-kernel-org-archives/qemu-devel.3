Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78580C9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MGe-0007oU-Jz; Wed, 23 Sep 2026 08:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxw-0004FD-9H
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:49 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxt-00079q-NA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:48 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b79so713306e87.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166031; x=1790770831; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbSMQYfV4oSwdW07wpvflvXJXa0j9NRqniHs2+ZLYX4=;
 b=XpCVpi8YdeYhPay4olbLA5Dwqfon+O9D7/NbZi2mjUyEq0fc/7xJAjQOOlGJqRleTU
 vrt9KD80elKUuslNECUa17/MVRg2hFr/yCS366TMFaWyVPdM5iTTeURaUbskzGn5y3DP
 s4jPYH3XCKORtAYz2Tp3d7w5HKTNPNdLcCAXxqMwe7KC3qFfpzUHI8GtIzpo5A1S8rki
 I8AcH63HDTZLmuvg5fKsUJoWrDBqdtOOZf7yTiz6nnf2eOUTxJcbOcq7TjH2JIqIr4SG
 awYWch/UDzF4o8Ez3JBbCtrZn0Sh9a2BtU7AurDN0j9SCJUjXZ3kTMML/KoaR7/aJ1jL
 Khbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166031; x=1790770831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbSMQYfV4oSwdW07wpvflvXJXa0j9NRqniHs2+ZLYX4=;
 b=SdCsK+DmVuBsAJ7XVO1d8I/mYtav8jTKG2kc8FLFaS2MiYqDemAIy3M/NpFgvYufOl
 kNGF8HnWNIWXSoJ9rnubtsdQhnEtqhuDnh2bNtof0LWELVMv7iI27uBwkoiOUyZfA5LI
 qsYvXkZltFKCTM0rwoNvL9fvHDY4Zij2iudX73v4HDqHPIET2dV9xHVE8tfNFCh213+/
 ajS6doMcnRevEm5QGUsPLMK0wHeXp/1H5BIWiuVYV8y1wqtb+4zFSlqHplCdwOfRNcol
 7IMC2o9JJxnxUy3SSqmPAxQV0vfo+jqhaZrEg2LVJNCxC8/UH3+1s8xkmsp6f+G4fXhR
 z4lQ==
X-Gm-Message-State: AFuF++l24FmzQMxmjGPvPJ7v1CVESyUWmuQlFzJNAnvZeQu0G2uqwcBK
 O9Ea4eXkzdhGhEc0/a4FBFIIiJ8/tP8uD4w4LYF3NdEy625PlcB11EusPuGIKJbX
X-Gm-Gg: AYBFou3LLJ9MlavmSarGz7vAyGCA3LeJ8PXvNLm/TssDzPUYxIPy8XMqf3exOmvf3IV
 ZT5rqTW4/5MMv45M21QYCgJAEChNtkMRYh6CN7CRIWdEkAFGlhbqQ7b3WQaP/QDgZg1hj07Uq2p
 rDpK5I+O162hacIQzTc8AaRa6XXR+OFr2HNqfWfsIvuI+nkIeYI1m1ypyon8BgrFEYCPcSUMryb
 vGCkHKAR8GJzwi0HaWdv6ZAGBfS3Pf0DJYtciggGzETdXPXCagygP8j7TyqNY4zBhqljg5Yd/UZ
 zCTUgMIKaLl5jgMxKKlcoAbspe7LwtsqNpwb7XLcDk483BvH/KYlYZnvyBe+0UGeYnPN4QWXG8r
 A8H5X99LwEjqIQSXKkoQBFHcD9QsWAQ2yerRSFcanUkoWC/7UObWHDGgi0ScnGR00gB2W1Wwagk
 lcFF3mCA0McVl/YnWkbj6sJeev1/TAST7fOA09nnaqh6IFEr0FtBFpDgxgHD107dK8V3wjx/NNl
 HkElfgCRAzsSPx8kjUFpHqLa6s2vmY=
X-Received: by 2002:a05:6512:b91:b0:5b8:c147:f383 with SMTP id
 2adb3069b0e04-5b8d89bb962mr881610e87.53.1790166030753; 
 Wed, 23 Sep 2026 05:20:30 -0700 (PDT)
Received: from [127.0.0.2] (109-204-139-9.dhcp.ossk.fi. [109.204.139.9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d85897aesm552138e87.50.2026.09.23.05.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:30 -0700 (PDT)
From: =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Wed, 23 Sep 2026 15:20:03 +0300
Subject: [PATCH 2/3] hw/nvme: fix missed CQ updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nvme-intx-fixes-v1-2-fbf0e4e567a5@gmail.com>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
In-Reply-To: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790166028; l=1279;
 i=mankku@gmail.com; s=20260923; h=from:subject:message-id;
 bh=CTP+XSHdNzp3xOEiS66E3LXO4SZkOuNLWT8+MCyTqvg=;
 b=4EOP9K/EQ3aHdPkmf7UWxvdcKmz9IxNoJhD7Zmkzjw+el0JyEu7CZA6UHIcRszO7U+9UR2Qsi
 9KEKoiWLyeuCnzE/m8ooPJwSrG/lsFpXYwF3q9mKkhtEjk8KOLY4voS
X-Developer-Key: i=mankku@gmail.com; a=ed25519;
 pk=vdAiS3IZFixKCwRmc+wfwUSPQWpEMkFYPH8m9evJZPc=
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 08:40:05 -0400
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

When doorbell buffers are enabled, CQ head updates may race with
completion posting. When a CQ doorbell leaves pending completions, the
event index may become stale and cause the guest to suppress the next
MMIO doorbell write. QEMU may then fail to observe that the CQ has
been drained. With legacy INTx, this can leave the interrupt asserted
indefinitely and cause an interrupt storm.

Update the CQ event index as part of doorbell processing to ensure that
subsequent head updates notify QEMU.

Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
---
 hw/nvme/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2be4bab7eb5a..3545a3de236d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4788,6 +4788,7 @@ static void nvme_cq_notifier(EventNotifier *e)
         return;
     }
 
+    nvme_update_cq_eventidx(cq);
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
@@ -8623,6 +8624,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             }
 
             nvme_irq_deassert(n, cq);
+        } else if (n->dbbuf_enabled) {
+            nvme_update_cq_eventidx(cq);
         }
     } else {
         /* Submission queue doorbell write */

-- 
2.55.0


