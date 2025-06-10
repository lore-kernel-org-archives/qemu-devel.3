Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABA5C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyb6-0000yw-Cm; Tue, 10 Jun 2025 09:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYj-000826-4k
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYf-0002jb-9u
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso3410812f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560306; x=1750165106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39EvlkRXXlcumPLuzzHWwFXfargkkijcg5vOQOsW2Dc=;
 b=uNYVrdpNbvP6T0MoLAIfRRYbjNKnfJ51qe5sbacAkVIE+cvyzQF5IzXNJWErby9L3l
 vxH1dzzO9H44O9bujYMmhkN716U0drq0NWeinEVxnWWjF0J+ChrtXM9JPN0tZZfBK3Mv
 y1zXYkm3hre2UcwlqCthsczEi0VA4xMdQH2wv/nGzkpAWaWxp1tNfWp32n/YUV+x7RDw
 km71I2kc7bZuAPUYR2ymrQwl2gM73yxwdK/NL6Hig3T3gsztC/BasqmmimQ07WOCt8iG
 Y6BBMekTsmHoq6dKHbJTzhrr4fyE3dUCL0dspcGPG50ziZxexvEvd6MiwwISAiddrRVQ
 UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560306; x=1750165106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39EvlkRXXlcumPLuzzHWwFXfargkkijcg5vOQOsW2Dc=;
 b=i97LZAZ0qUaiXK2dliQE+ryYk8Q5aFn3Gdquy2NF/BFtxwe2CgPgkJEw7V00PvBgu8
 c7Cv1vTM6eaAoT/GYuCIhDtj0gPu9TjRvt8QUAEhBS/GAXoo9vXcfgNN2QmWEmeKno85
 kB6yWIb4SMrQQmapPRe7bpgzidj9bA1KPZnWqwl/kou/1R0DkHIptSbZPGhs7l5+pvx3
 x2bjzsJ9amnsQQdwabZm1ZGEy8Hl5+LOoiuJEbD+2sAkYI89ASoUjEJzz/MegSf/09uw
 /n3Jhl+p+NWJLNjEXfM+r+XYR/wtIhLY/934f9BtXnRtu4sUj9QHpjlvOO6DY1OcpmSU
 RUdw==
X-Gm-Message-State: AOJu0YxFZD9u5FrHsUxX4D/SavGN+btk8UKdzheMQL82n/VGeF8GTTAP
 ruzFWWQ+LOAyHl1XUumNAshA0i2mCFH/AahkDj6JpgLS0V44VXd8uda83S36VLsp1N6gu1Ls4Wj
 BYAapDvw=
X-Gm-Gg: ASbGncvH0/Upc60UsLMKpHFhFtRr1Gg0tjfcd2MGuNfR6R0lEzO/K0Tu7dAj0u8yOCn
 clVcAcoeypVpKWFTP8GGiHtxO5sSBNh1fzYE2u1FuuS0mhlLg53cFuFpfcuoWJmb8xJJghyiN+E
 +tSupoByvwKlXokLbp9rTz1j/TaTSCX5FVNKRvqSOLPpxZosurpeavqKUL71F7SAIHXI+uphcf2
 g2sFQ6Gvze+n7KQe2WSxDVhhu3acsLNCNuRW8cQ1d/s3jWvjjDeknNeDK/xLZZdpIcriQEeFyrz
 HooXxyGOOMkwBt4yHyoh5CUOh1uyChb/Lea5BRjJYYMvtTuY+xFYSQVuND1xox4lLV+x+1SisKc
 hA1MtSk2/OSxyixfakFWX5hIyRbRJzio7nfkZ20FuIA==
X-Google-Smtp-Source: AGHT+IHpUki8lK6upCgEtIu6Ft7/2IvSPuvlA520CYTRMZLFhhPxHCeaF8fFIAO7C8jC82G4IYM3IQ==
X-Received: by 2002:a05:6000:4027:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3a5522bdeeamr2019374f8f.39.1749560305674; 
 Tue, 10 Jun 2025 05:58:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c7756sm138986805e9.33.2025.06.10.05.58.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/24] hw/net/i82596: Factor configure function out
Date: Tue, 10 Jun 2025 14:56:33 +0200
Message-ID: <20250610125633.24411-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>

Abstract the configure function.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250607152711.108914-2-soumyajyotisarkar23@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/i82596.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index fc33a00d498..c1ff3e6c564 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -177,6 +177,26 @@ static void set_individual_address(I82596State *s, uint32_t addr)
     trace_i82596_new_mac(nc->info_str);
 }
 
+static void i82596_configure(I82596State *s, uint32_t addr)
+{
+    uint8_t byte_cnt;
+    byte_cnt = get_byte(addr + 8) & 0x0f;
+
+    byte_cnt = MAX(byte_cnt, 4);
+    byte_cnt = MIN(byte_cnt, sizeof(s->config));
+    /* copy byte_cnt max. */
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
+    /* config byte according to page 35ff */
+    s->config[2] &= 0x82; /* mask valid bits */
+    s->config[2] |= 0x40;
+    s->config[7]  &= 0xf7; /* clear zero bit */
+    assert(I596_NOCRC_INS == 0); /* do CRC insertion */
+    s->config[10] = MAX(s->config[10], 5); /* min frame length */
+    s->config[12] &= 0x40; /* only full duplex field valid */
+    s->config[13] |= 0x3f; /* set ones in byte 13 */
+}
+
 static void set_multicast_list(I82596State *s, uint32_t addr)
 {
     uint16_t mc_count, i;
@@ -234,7 +254,6 @@ static void command_loop(I82596State *s)
 {
     uint16_t cmd;
     uint16_t status;
-    uint8_t byte_cnt;
 
     DBG(printf("STARTING COMMAND LOOP cmd_p=%08x\n", s->cmd_p));
 
@@ -254,20 +273,7 @@ static void command_loop(I82596State *s)
             set_individual_address(s, s->cmd_p);
             break;
         case CmdConfigure:
-            byte_cnt = get_byte(s->cmd_p + 8) & 0x0f;
-            byte_cnt = MAX(byte_cnt, 4);
-            byte_cnt = MIN(byte_cnt, sizeof(s->config));
-            /* copy byte_cnt max. */
-            address_space_read(&address_space_memory, s->cmd_p + 8,
-                               MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
-            /* config byte according to page 35ff */
-            s->config[2] &= 0x82; /* mask valid bits */
-            s->config[2] |= 0x40;
-            s->config[7]  &= 0xf7; /* clear zero bit */
-            assert(I596_NOCRC_INS == 0); /* do CRC insertion */
-            s->config[10] = MAX(s->config[10], 5); /* min frame length */
-            s->config[12] &= 0x40; /* only full duplex field valid */
-            s->config[13] |= 0x3f; /* set ones in byte 13 */
+            i82596_configure(s, s->cmd_p);
             break;
         case CmdTDR:
             /* get signal LINK */
-- 
2.49.0


