Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9z-0004h7-2O; Tue, 04 Nov 2025 12:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9L-0004Me-6o
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9J-0005ku-As
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso115309a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278530; x=1762883330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4m9XBKHrSokyQj4SZIgLFfxIj2nTWsT3jcVMG05ZVi8=;
 b=oWKGcH4n9lCs5pn/8kiPYAnht5B5KQi76HQ4HybGFnzEKVQKs5nTFC4aKOoSWb8aF6
 m1NcYOiFLPCe2uCry0Rn0ThWSTIZIhSbT+l2MqMxIDJvngMsU3HJ+8LrEeRX4afKALC3
 kjbz2TzuQyjANu21earY2osBPuoMIJCEMKREkDs7fwSfvnazrIL65M51W1KDLcaQ9u4d
 k3fIT72GbZYQLA0UkhhuPYC4HZrCzqURWBXeBSA+gtl79tA/As7aUgfY09CbmMha1fhI
 eV6B0IHW8o3prb25B2cpLJ5O9pbEr8MJy/jV2DaSjOtL19PVV2LKKCxim/BPKJ2Ylujd
 WdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278530; x=1762883330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4m9XBKHrSokyQj4SZIgLFfxIj2nTWsT3jcVMG05ZVi8=;
 b=ZAgC67jfVyY0hn9TUKuoDAQPX4TdvN2pRTXETOtItrplMVRkV9ST+U4F0Un02ZYQLG
 ZfY77v0EgdsXzATpzD5yHA1c78i/nZnSKMZh4pepCCjH1aFMxZD6ne1W56OmsRslYo7g
 V1GaEZw/xkyuhrN4BuxtL1OOf5zV6Tz0ycDO/NfqLo+U9p8a/uF2ShzZCwI7DTZcF3V7
 11HtLKl1yIzmFxN4ZEOncrAtVS4jiYw52zb5Itm/hc8Uf/hMYkxmYKbD4xXGH4igNYX0
 3cJSYt6gmC5Xqa8NEtNybptZuJZOUmg3TAhf0RdjqTLr2rNlLw9VHTnkhTvA2p+mk+b2
 P8ZA==
X-Gm-Message-State: AOJu0Yx1DTXFrfV2kbdVn3dFojIEzxbEBXm7Dg+T8wAsS9kpJrPmd7GJ
 Klov0O/CdCndcyICHpDPZz9fTPFDV0n5X3SQclAd15xlJ6Bl+GJuZs8WA2ln6TrMfFf+ZEryIXu
 vTXIZgT+VoA==
X-Gm-Gg: ASbGncvlnl13S30Axold73RV6Tob3f6tAWMlFPzxC4sOCZPhW4V+AwzFBi1CgNoYtN0
 NgYyVEScEiqlDOyPac2vnAN1i8WTnXl7UjJfr7T0tJztYAJFsaKqIuscgFI1QHsuUFayPyf1bs/
 qvHZO0zQ+Qli4WOHRZ4YwrxyC/ZeQBjrgtO6xeW+e3Vob678V//WXg9TjOqpsFvfSyh4s4GEyQR
 bU9OgnkHQC2tIlrYaiZfOiDjuu30Oojl572jM0gjsQAaXirvtQ0fdx7dakLme4ZvnKC8Wnlc+rk
 lukOCqxMHSGQ8evv0uYdh3+7IVB2RNCwMPCZzHqitT1gRYe2ziCrm/3bPWbNQ0ypQ7uYwCNnQEw
 pESUMIyWKbGCyZ7umGL4NAgp+u8cL1j1FtxJfy3/kX9IPJNV1QcGf3ac7feUOMfnXOkuz8+Ry4O
 HKmYzLoQ5f13Q7MmRf3yKzPOvKMqveV+TR
X-Google-Smtp-Source: AGHT+IG2Pn0B7yTrd5zKWx9RF7J4pT55eO69TFIWBC0uto8HgN8Bnf4AOTxzwglxASr1XeQBjy/ojQ==
X-Received: by 2002:a17:907:c28:b0:b6d:51d4:802 with SMTP id
 a640c23a62f3a-b721777986fmr440787066b.25.1762278530249; 
 Tue, 04 Nov 2025 09:48:50 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa0828dsm268129766b.50.2025.11.04.09.48.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] hw/sd/sdcard: Handle RPMB MAC field
Date: Tue,  4 Nov 2025 18:48:19 +0100
Message-ID: <20251104174823.92412-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Implement correct setting of the MAC field when passing RPMB frames back
to the guest. Also check the MAC on authenticated write requests.

This depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256 which is
always available via glib - assert this, just to be safe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <b6f5698c0ca017871d54834f0c7bd4b4b6316bbd.1762261430.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aa57c858cbb..9c86c016cc9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -51,6 +51,7 @@
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
+#include "crypto/hmac.h"
 
 //#define DEBUG_SD 1
 
@@ -121,6 +122,7 @@ typedef struct SDProto {
 #define RPMB_KEY_MAC_LEN    32
 #define RPMB_DATA_LEN       256     /* one RPMB block is half a sector */
 #define RPMB_NONCE_LEN      16
+#define RPMB_HASH_LEN       284
 
 typedef struct QEMU_PACKED {
     uint8_t stuff_bytes[RPMB_STUFF_LEN];
@@ -1128,6 +1130,67 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
+static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
+                           unsigned int num_blocks, uint8_t *mac)
+{
+    g_autoptr(QCryptoHmac) hmac = NULL;
+    size_t mac_len = RPMB_KEY_MAC_LEN;
+    bool success = true;
+    Error *err = NULL;
+    uint64_t offset;
+
+    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, sd->rpmb.key,
+                            RPMB_KEY_MAC_LEN, &err);
+    if (!hmac) {
+        error_report_err(err);
+        return false;
+    }
+
+    /*
+     * This implies a read request because we only support single-block write
+     * requests so far.
+     */
+    if (num_blocks > 1) {
+        /*
+         * Unfortunately, the underlying crypto libraries do not allow us to
+         * migrate an active QCryptoHmac state. Therefore, we have to calculate
+         * the HMAC in one run. To avoid buffering a complete read sequence in
+         * SDState, reconstruct all frames except for the last one.
+         */
+        void *buf = sd->data;
+
+        assert(RPMB_HASH_LEN <= sizeof(sd->data));
+
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
+               RPMB_HASH_LEN - RPMB_DATA_LEN);
+        offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
+        do {
+            if (blk_pread(sd->blk, offset, RPMB_DATA_LEN, buf, 0) < 0) {
+                error_report("sd_blk_read: read error on host side");
+                success = false;
+                break;
+            }
+            if (qcrypto_hmac_bytes(hmac, buf, RPMB_HASH_LEN, NULL, NULL,
+                                   &err) < 0) {
+                error_report_err(err);
+                success = false;
+                break;
+            }
+            offset += RPMB_DATA_LEN;
+        } while (--num_blocks > 1);
+    }
+
+    if (success &&
+        qcrypto_hmac_bytes(hmac, frame->data, RPMB_HASH_LEN, &mac,
+                           &mac_len, &err) < 0) {
+        error_report_err(err);
+        success = false;
+    }
+    assert(!success || mac_len == RPMB_KEY_MAC_LEN);
+
+    return success;
+}
+
 static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     uint16_t resp = lduw_be_p(&sd->rpmb.result.req_resp);
@@ -1152,6 +1215,17 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
                      RPMB_RESULT_READ_FAILURE
                      | (result & RPMB_RESULT_COUTER_EXPIRED));
         }
+        if (sd->multi_blk_cnt == 1 &&
+            !rpmb_calc_hmac(sd, &sd->rpmb.result,
+                            lduw_be_p(&sd->rpmb.result.block_count),
+                            sd->rpmb.result.key_mac)) {
+            memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
+        }
+    } else if (!rpmb_calc_hmac(sd, &sd->rpmb.result, 1,
+                               sd->rpmb.result.key_mac)) {
+        memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+        stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
     }
     memcpy(sd->data, &sd->rpmb.result, sizeof(sd->rpmb.result));
 
@@ -1163,6 +1237,7 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
     uint16_t req = lduw_be_p(&frame->req_resp);
+    uint8_t mac[RPMB_KEY_MAC_LEN];
 
     if (req == RPMB_REQ_READ_RESULT) {
         /* just return the current result register */
@@ -1200,6 +1275,11 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
             stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_WRITE_FAILURE);
             break;
         }
+        if (!rpmb_calc_hmac(sd, frame, 1, mac) ||
+            memcmp(frame->key_mac, mac, RPMB_KEY_MAC_LEN) != 0) {
+            stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_AUTH_FAILURE);
+            break;
+        }
         if (ldl_be_p(&frame->write_counter) != sd->rpmb.write_counter) {
             stw_be_p(&sd->rpmb.result.result, RPMB_RESULT_COUNTER_FAILURE);
             break;
@@ -3128,6 +3208,8 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
 
+    assert(qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256));
+
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-- 
2.51.0


