Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D3EE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX5-0002hD-EL; Tue, 17 Feb 2026 16:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX3-0002fQ-T2
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:57 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX2-0002Ic-Ap
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:57 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f04f1348cso3112265b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363375; x=1771968175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVOAx9naukSVP3+UH3cDLb9De+dQpHzBI3+W6aRDKDk=;
 b=YFWg7zoJexfvpgqBwTiHL0MBaCAxvI99zMO8CaZ3WYem2CLIfgbLa/SJC076QC7z63
 lllaqjrqJV+FUhn4iS3DDHfxUl3Q0gpxWepDHSbRS0pyTyUpQ1uBRp1FGdEjOjvxpgiz
 jqa7dclq1poUIaRayoZFSSC352hs/wPy3DSEDE5b1uieiWmszaye054cetHn3UyAEYBg
 VM6POiT749Chnu885I7/fbEV7EwCEA3ftbFlCVNKgt0lcHvd5gGFjzjrHbY1IuZbDfGk
 E6QWsNqBk0m4mjSpmlVmBnGyWEfwlYhmAZ1SQ4lkpE6ZMrxLrwiqGDCVJhSzecIurEZn
 bfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363375; x=1771968175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVOAx9naukSVP3+UH3cDLb9De+dQpHzBI3+W6aRDKDk=;
 b=ot6BCXHOdRk7FG7BlHQXL748E/dS2eOtD2BBbKlaxLLlj4Yil7Qvj+5gBHrI2gs4hH
 MQDamlJfPoOiYd77ZkxzRcUeD6NOJ0D3C2yM1SsJ0s8gSgv6oaZrRVLvzYNrw6J+mtQS
 oBfNxP6JlTxs+GtKJJ51ZsCdTVx3eACxDNYlm4IDmLp31j3R6LIdozmOKFDGkjKEzpJq
 VPTZGsSgIBzz0wZMi+mnvQmKJ1/mfj2msJn+obCI6z2UPYXng2oHujJBQ0oIrIvY7dmA
 qm+WVvV3uJCRx2xM7HgQEePlVyUpiD3mL2FFTo1P28tVihVR+zkuBa/O5hZ0PMTJNv51
 RpDQ==
X-Gm-Message-State: AOJu0YyUlfQY98PHfAn6UstWlLpSFaQUglkdaGJs8L1kF9eOOL3OQLCo
 hCyMBMIE6r9Mis0wRDvfKHgNDVcGvgfJWONCVSExlD5pfc+3jRKM/2WkfX74wQ==
X-Gm-Gg: AZuq6aKrkciJDeFr+1coFxPZJ+Jq6Ley4UvsEzyVeJeh1lkh7+QPr/AKNKjxdUpN7Tm
 jdt+20wo4YpOhDWQzsNdjwNgdC9SLqbENOhN/WJ9qOXei7i6z3bcWJHHIfKcRX5wAqggSOK5nKt
 cDeX0pOJgjkV25raCh1NZVX17N4n3KdvyiWWNc6GLNJzF37X0vJDfzechp1MVOie/SZZOzAAMV9
 SaatCq0Tk1Bl5eabw0OlEu4le/sVd1ES97K29hpV/4FkjbESoOMF8QNpmx8X8ovdQWp8RHhlSku
 MdBfeEZuxuBTXHWSZZqV0U9BSeZHDbjd3T5t3fEyv2L0h4mdpYjw3dGmqvzEtR8QjcN5nI5/9x+
 3CxupoLsQTbZ0lCPdQAbh2flySPjuqSN13/J0SjzBfFnafKer8F2n4AVVJOI5HJ8SNSwp6yY98E
 zM4ZsANLQLmT+s8JnI85ERcwmBcWFNsAcX1485dR0Vd8Kd1DR2iZlBp4EGHCf6Yp467iRKUBI4t
 cnNVfc09joowOMw
X-Received: by 2002:a05:6808:3a0e:b0:45f:a12:5c88 with SMTP id
 5614622812f47-463b422c6abmr7256133b6e.49.1771363374987; 
 Tue, 17 Feb 2026 13:22:54 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:54 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 5/8] Hexagon (target/hexagon) Check each opcode against
 current CPU definition
Date: Tue, 17 Feb 2026 14:22:42 -0700
Message-ID: <20260217212245.95321-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

During decoding, check that the opcode is supported in the current
Hexagon CPU definition

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/decode.h |  2 ++
 target/hexagon/decode.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/hexagon/decode.h b/target/hexagon/decode.h
index 3f3012b978..d4b049961e 100644
--- a/target/hexagon/decode.h
+++ b/target/hexagon/decode.h
@@ -30,4 +30,6 @@ void decode_send_insn_to(Packet *packet, int start, int newloc);
 int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
                   Packet *pkt, bool disas_only);
 
+bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def);
+
 #endif
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..b8a1cd5b12 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -647,6 +647,22 @@ decode_set_slot_number(Packet *pkt)
     return has_valid_slot_assignment(pkt);
 }
 
+bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def)
+{
+    HexagonVersion hex_version = hex_def->hex_version;
+#include "tag_rev_info.c.inc"
+
+    struct tag_rev_info info = tag_rev_info[opcode];
+    if (hex_version == HEX_VER_ANY) {
+        return true;
+    }
+    if ((info.introduced != HEX_VER_NONE && hex_version < info.introduced) ||
+        (info.removed != HEX_VER_NONE && hex_version >= info.removed)) {
+        return false;
+    }
+    return true;
+}
+
 /*
  * Check for GPR write conflicts in the packet.
  * A conflict exists when a register is written by more than one instruction
@@ -746,6 +762,17 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
         /* Ran out of words! */
         return 0;
     }
+
+    /*
+     * Check that all the opcodes are supported in this Hexagon definition
+     * If not, return decode error
+     */
+    for (i = 0; i < num_insns; i++) {
+        if (!opcode_supported(pkt->insn[i].opcode, ctx->hex_def)) {
+            return 0;
+        }
+    }
+
     pkt->encod_pkt_size_in_bytes = words_read * 4;
     pkt->pkt_has_hvx = false;
     for (i = 0; i < num_insns; i++) {
-- 
2.43.0


