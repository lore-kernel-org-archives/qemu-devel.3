Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B7DC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs4S-0000Yf-7h; Wed, 04 Jun 2025 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs4N-0000VE-8f
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs4I-0003F4-O4
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-234d366e5f2so1366815ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749058705; x=1749663505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/inJLdqRw7rg486G2EiAHTU/fa/iBHR1d8alEest9FU=;
 b=Rh6kj34+nR0bYYy5tR1dWSdKZeirhSIMVxAELLrpm3ZUJumF/vjzF8UJHYr4E4SvYZ
 wdratgfpMN5Sgi6ibO1ux+LOdNlITT6Gdai7GPxLgln/m1kNCb/4WsXS/glbiHhMQAtF
 ShbX9pHIEW+4etZHwewWlzL+mQIeR3HoF1W5FxXvdvloZqW3obGGfH1NqvebBcH+DIRE
 RQ1oOIoMS3wiseVgA29dtoImE/DbojqRp1ta2G9IKjlgqppcMQgPFxrD1Ry4yLnzbDtA
 ED3NJsIgRLXOKLlE6CxgfcKBlLMa0zyzMPkhojeppRiCHGVpisiXuY4PO8h56UIg9vEY
 Vwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749058705; x=1749663505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/inJLdqRw7rg486G2EiAHTU/fa/iBHR1d8alEest9FU=;
 b=FjjD+1folEWce76CW0PM2BPz1h3yP8NmEUnMQT43fU0u6nNqjjcLRNdk9oAxuqWki/
 MeuYZRi7WZpGyR6u0G25nPXWrsC6JgZnDGmBOjaB00wK0+v3ZC66VVB3X+yALScKiYld
 b4SMmHy0Zuksa3X5NuNpL75qmxrYGaHo6AbJ7WpotdyewLGOZZ0dIrXpCaK3wMOQhbIt
 8Af33kEWkBKTuETPzyDAQECYD8AkCaWCIMQUWxwvlxuBXxmAQirf1SxrvI7HYzUaVOqw
 d35+dngud7KLXafQj+HntnNRtOFglqyEzbD2SKCF7WBOe9zFvSre3X+zTHDXI3d6F3qs
 xYlQ==
X-Gm-Message-State: AOJu0YyYIlDwhGdilRTJnnday54g09cwOKvAni+wkxR+AeYmguz6WXXG
 vUrQWi5d3PqaWOHuyTyJm2LCYtvc2DSr7NAXz64vgGd7WkTh/7EZFPipi+gOgtcAl/2xfQJR+1n
 EhaGC9RU=
X-Gm-Gg: ASbGncu0iWapVgGr2AzpkQ9GDCusmuM0MoxAhOFJV5kLE+ZXomOAMVKjQLHUI8+/GdF
 9QEV6Wso1XbzMeVLP32qAGHxQchtkCzu7qFeBqRvggURhBtSI+IhfUMQX+Pm7d2QV66p5wzKtjG
 Oh2u3Ty+a43VTwCB44asfjaan0G4pixHNQGow0t6kvHPi/QMqe9aoIkpovjWXqRantCWakUoFkp
 GAGqNBANepctOUfLBtizD/Bodv2KvYDExn1Bfqh7Tc2QYyXWPE/YovQZnG59mRYQ1itN+hKUMRQ
 eMAXjVFyxVLiFDTw8bZocCOJeZKJnwwhL1n6r0AEGhVsRvZ4fVfVH/58z49Eq6UuPoo7RlfMcoZ
 gBkJy
X-Google-Smtp-Source: AGHT+IHgEcgjeO28JkK26X3cX1iHeOaWIHRqqIs2ZZGv7gZGqSOS8V4Ig629SsRCS9vpu2jiRl4RaQ==
X-Received: by 2002:a17:902:f603:b0:235:a9b:21e7 with SMTP id
 d9443c01a7336-235e120005bmr59632635ad.48.1749058705046; 
 Wed, 04 Jun 2025 10:38:25 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cfcbb9sm106913215ad.208.2025.06.04.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:38:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/3] target/riscv/cpu.c: do better with 'named features' doc
Date: Wed,  4 Jun 2025 14:38:00 -0300
Message-ID: <20250604173800.1147364-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
References: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Most of the named features are added directly in isa_edata_arr[], some
of them are also added in riscv_cpu_named_features(). There is a reason
for that, and the existing docs can do better explaining it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250529202315.1684198-4-dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c1bcf60988..758f254c15 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1378,13 +1378,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
  * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state. They have riscv,isa strings
- * and priv_ver like regular extensions.
+ * the resulting CPU state.
+ *
+ * Some of them are always enabled depending on priv version
+ * of the CPU and are declared directly in isa_edata_arr[].
+ * The ones listed here have special checks during finalize()
+ * time and require their own flags like regular extensions.
+ * See riscv_cpu_update_named_features() for more info.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+
+    /*
+     * 'ziccrse' has its own flag because the KVM driver
+     * wants to enable/disable it on its own accord.
+     */
     MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
-- 
2.49.0


