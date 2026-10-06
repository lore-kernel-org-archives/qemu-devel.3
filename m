Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F540CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwO-0005WA-At; Wed, 07 Oct 2026 04:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHL0-0003Fk-F1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:25:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHKr-0007pf-Js
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:24:55 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2e3846d1caso179046566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791339644; x=1791944444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=woCGK0xgaNA3qhNiS3PzZJahdF7mNwl1idZ90g/lgvU=;
 b=cob0S/dzD+ueeUe7PfX/pkCp4/HaoqhiAnSjsmHA8rFNz6OvNqg+GNOfLK5ocnMtTB
 ymrSVfhUiz+m0udRy+0ITc3vO2/Ec1+v0G6lhQgHRyD8yE7vChgpYsCHeiTUyLyk4qKC
 lvnN+rdQXSACn8+XM3KmUJfEkJDNnHI4A1qpnBZui+fguv7iwAAY9fxM/KlnURkDQYHe
 OH+PRe0IgI5T8LgH2jDynBAhpQrUFczqO4+KH9Bak0xV2gaAOLattO7fX7tg0Hzpc5HQ
 ShwgfkoonhduO+LKVS6Ck/Rc7Dwx3Yq46N1X5/ug+V56MyFT55XM/QxMqtJ+z+kDfS7i
 uecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339644; x=1791944444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=woCGK0xgaNA3qhNiS3PzZJahdF7mNwl1idZ90g/lgvU=;
 b=GpBLggfJ2+VcdnLTjwnGeGAisxokS3KK2IClNwilA1P3ONJ8UstrzakglSMqU8XO/2
 QwvQM4c+UmjCwmy0Wh+DLuvKz2tHEdVMzJsEzH/jfyYC9XBvzbTUzAIsmrm49po+yGbF
 QiaEPONrflGA0FEyuMPvMWt9w7RK75RtyDxnCT+aI5q7fOQZnQ4UBa7d+1tMf4xcQf45
 vplhGr7fL/MLN97vfcAWAQWCaVPR8KkzpK7hSwXOiCnqDFbzG9e9U69b7X2ae4she/g5
 iy5qun72Ju7U1xp9z1mNIiQ9uZhCzGkJr2KKYs1m1zdaNc6cTbQz2DVcWVl3zZti19u3
 aJVQ==
X-Gm-Message-State: AFuF++kJMSCq7skxuVbXECksJBAOk2Y4ya90kzHkgzh7GDsAa7bGXnUo
 wtQrPZabSSTYAgiF1fNHRIaF0cCbsQEkkxY4dDZkyCr9jSwnGPSk8Aoj/sCUcA==
X-Gm-Gg: AYBFou3jQ5UkxyWcGeL8lzYogiSYSwdLtZKkb54MsfytMSP3/W7CIN+W+cE3NnesN60
 JTp+uK0BdCPYK7Kyr0o83rt8hLrF8JHB/jXyZLcrD0M1KHq9IpYlBD7qUoZnKoLDIlFhYrKcGYK
 7uMP5WVwRhk1T+0/9Miz2DLh1gjri9FWbjHBxeqSsctXVm2DeVHZXGLTjw4gWrzXabxs/LKeBu3
 NksRhN4UARBQPAZZsdcl2NH4hsOiYjCFrJW28r772QCBdGynXLXxZpf44CKcvNX2bAviVXFBRLr
 lnEV1p5svgE548KVJcFPoCbs75mVqZevO9G6t3AYMgQSYkAlT8P2zN0ImuCCw0MmOU3iGH0rr4A
 2kI10i9Me22N7fIgnayLqb1BDNUmd1K6MtoCEFbWmhtnCFSbuXW40DG3olI+qToMkno2oPoun++
 Xmcnzc1fNIPVzI4WLruaOuhb8arSCkxyPOPTBSp3xgjmGauawzuTprPVwr0CxzHLbIxcyEGTfKn
 LJTLmnPAKT6nkNMOO8pEMqujTfmU8lYAB7RvA==
X-Received: by 2002:a5d:5e07:0:b0:488:8850:50ec with SMTP id
 ffacd0b85a97d-48c6d1a5c67mr1541939f8f.46.1791279906636; 
 Tue, 06 Oct 2026 02:45:06 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:06 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 2/8] hw/sd/sd: Add buffer argument to sd_blk_{read,write}
Date: Tue,  6 Oct 2026 11:44:41 +0200
Message-ID: <20261006094447.43491-3-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The next patch offers to skip the s->data bounce buffer for CMD18 and
CMD25. Prepare for that by adding a buffer parameter.

Rather than introducing two new wrapper functions, as in the inspiring
commit, the additional argument is added at all call sites. This reduces
the number of helper functions and matches existing code where multiple
sd->* arguments are passed to sd_blk_{read,write}.

This patch is inspired by: https://lore.kernel.org/qemu-devel/20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de/

Inspired-by: Christian Speich <c.speich@avm.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 759db66e3d..bccb839ce6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1113,20 +1113,22 @@ static const VMStateDescription sd_vmstate = {
     },
 };
 
-static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_read(SDState *sd, void* buf, uint64_t addr,
+                        uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pread(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
 }
 
-static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
+static void sd_blk_write(SDState *sd, const void *buf, uint64_t addr,
+                         uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
     addr += sd_part_offset(sd);
-    if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
+    if (!sd->blk || blk_pwrite(sd->blk, addr, len, buf, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
 }
@@ -1364,7 +1366,7 @@ static void sd_erase(SDState *sd)
                 continue;
             }
         }
-        sd_blk_write(sd, erase_addr, erase_len);
+        sd_blk_write(sd, sd->data, erase_addr, erase_len);
     }
 }
 
@@ -1985,7 +1987,7 @@ static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
         return sd_r1;
     }
 
-    sd_blk_read(sd, addr, sd->blk_len);
+    sd_blk_read(sd, sd->data, addr, sd->blk_len);
     return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 }
 
@@ -2685,7 +2687,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         if (sd_generic_write_data(sd, buf, &length)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            sd_blk_write(sd, sd->data_start, sd->data_offset);
+            sd_blk_write(sd, sd->data, sd->data_start, sd->data_offset);
             sd->blk_written ++;
             sd->csd[14] |= 0x40;
             /* Bzzzzzzztt .... Operation complete.  */
@@ -2720,7 +2722,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
                 emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
             } else {
-                sd_blk_write(sd, sd->data_start, sd->data_offset);
+                sd_blk_write(sd, sd->data, sd->data_start, sd->data_offset);
             }
             sd->blk_written++;
             sd->data_start += sd->blk_len;
@@ -2858,7 +2860,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
                 emmc_rpmb_blk_read(sd, sd->data_start, io_len);
             } else {
-                sd_blk_read(sd, sd->data_start, io_len);
+                sd_blk_read(sd, sd->data, sd->data_start, io_len);
             }
         }
 
-- 
2.56.0


