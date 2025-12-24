Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83494E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQaG-0002ib-2W; Wed, 24 Dec 2025 10:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZU-0002P9-8i
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:47 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZQ-00032j-5h
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:38 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so8195403a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589273; x=1767194073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6czcg4YEy9kYV7FGDATJvxic4KWfkb63MhDB1kPUCEg=;
 b=syySrKazDNfLc2fR/wkjT9y/YOqKD8A47xANkpgS3U0ShZ/9cVK+VEAu9WqJBKIzqd
 3N5xGOr918zQCKJiD3re3V4sPXHZLsDqhkNyyHk6wmFK2I3yt1Tp0AeOKRa/U0v78E4N
 OUKprpe+IWBdx9J/cNJCC0dhKnqDagv/i+FZVT+G1pP7Fu19sIRtlMA+Z5ylJo8u9DS3
 MekdJueCLXGVLH4MY6WMlPgaRz5m20mGNwz2obVmcGSBm4XeS1qrBVt44OMcx3V4aidd
 bPW+MGrqPAUH0gewNZgmrpSsqQbeORe8oMPU55XoZn6DvJ4MtaK3PKrpzRfy/zZsHt2x
 1MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589273; x=1767194073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6czcg4YEy9kYV7FGDATJvxic4KWfkb63MhDB1kPUCEg=;
 b=ZLVcerVY0xdDyIBT8GKxocN13oKsZkFxN/8fxkrQ7Rpl6gZQlPBLu42IGPqeVOjY59
 VZt5/EiNZzTp0EJ8QBLn/CKroqHKlZw1nL8FWUZUodisv0LQmxkFOYiCfrwnN9uTtnU+
 EqoDb6Bv5adu8jyKYm6G+t3mZ26kIt19Y1fycnOT4+bsthOkN2hy8dz/Y77751j5OsSo
 Y06M7F6p/kwBeY9Kq4V8iZOQhgTnFZdONN9VAnAgW6NHEFM/L+LDFVR07mZcMmHq1iqT
 ZC5vl9Z9rlHXZGWHAFwpphlooiEVIS2sE03erhGQtDj0abd7vqvNT4yfw22t9NK/0rLu
 gC4A==
X-Gm-Message-State: AOJu0YzOaIEg+wKCSqnXmExg4mWD3lssC1c3LnSGrbRIkYtwld/Dfvpd
 MaavDOMmSAgSUrXLZmZUf55kOamKNYo7fbp5KoQ7fYFrmT+0ubNlmE5YhUFcQbOXnSQxUxvzgwx
 wzLm1grs=
X-Gm-Gg: AY/fxX5uI04pj+khsLaLOE41exhh5KdLkBy6+MRbmAVZ7XfbagQ3Sn37oWGHMdz9Fwb
 gz2io/V1J0WJtS9I3rA/JqB5eXCMu4uETfLTbFrrt3VFrUdp65r9PY5Fsv2hByx4jd5K4CoP4ZZ
 GQzchsBoJZuD8X5X3sBa5niJnpvFqNpinY49BWaOakOMvanBVFyObJo+B+2rUoGhK2Xz/yOwtAS
 CbBU9v54uySrs0kQ9Xog+4hlmkaVP2cPjmPyJQrEaOT+3YBM4AC4U+pbtv7jLGicLmRFHGpmiAu
 YhClXMkOrIIHHqyMPkrBSm0CO18gAIXul2awqUJetvUNqUeoWbMgqCODS7M5YaiQ5L0Yji7LFDJ
 7tO4oNWvhUIgqr5RM33RTbrBVsXqWPcG0Qi2v/U/Pb2MbLQ8EMXVnrOz9QOHzBVzOpqoJBKvi8N
 YCFFn7ArkElUt0BQP4cGjXhN7iOZYgydh+3DbQQeDSeW3QFIX6dDlzZJw=
X-Google-Smtp-Source: AGHT+IEZ6623R2+01ciEXyPbiMtLcHJfs6LH1TiIh6bn+03hNr67fwVO3Fd1S7EXbLpmsJkizry3ig==
X-Received: by 2002:a17:907:6eac:b0:b80:333e:faf6 with SMTP id
 a640c23a62f3a-b8036f0d7b7mr1994176166b.14.1766589273357; 
 Wed, 24 Dec 2025 07:14:33 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b9159a6d0sm17137152a12.28.2025.12.24.07.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:14:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/9] hw/arm: Avoid address_space_stl_notdirty() when
 generating bootloader
Date: Wed, 24 Dec 2025 16:13:44 +0100
Message-ID: <20251224151351.86733-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

When using the '-kernel' command line option, a bootloader is
emitted, calling address_space_stl_notdirty().

The _notdirty() variant is supposed to /not/ mark the updated
CODE page as dirty, to not re-translate it. However this code
is only used with the '-kernel' CLI option after the machine
is created and /before/ the vCPUs run, and *only* during the
first (cold) reset; not during following (hot) resets. The
optimisation is totally not justified, since we haven't
translated any guest code yet.
Replace by the normal address_space_stl() helper.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/aspeed.c | 4 ++--
 hw/arm/boot.c   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3a5071a3841..e3cd1519a81 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -77,8 +77,8 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     CPUState *cs = CPU(cpu);
 
     /* info->smp_bootreg_addr */
-    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b91660208f5..de22b8adf56 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -266,8 +266,8 @@ static void default_reset_secondary(ARMCPU *cpu,
     AddressSpace *as = arm_boot_address_space(cpu, info);
     CPUState *cs = CPU(cpu);
 
-    address_space_stl_notdirty(as, info->smp_bootreg_addr,
-                               0, MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl(as, info->smp_bootreg_addr,
+                         0, MEMTXATTRS_UNSPECIFIED, NULL);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
@@ -277,8 +277,8 @@ static inline bool have_dtb(const struct arm_boot_info *info)
 }
 
 #define WRITE_WORD(p, value) do { \
-    address_space_stl_notdirty(as, p, value, \
-                               MEMTXATTRS_UNSPECIFIED, NULL);  \
+    address_space_stl(as, p, value, \
+                         MEMTXATTRS_UNSPECIFIED, NULL);  \
     p += 4;                       \
 } while (0)
 
-- 
2.52.0


