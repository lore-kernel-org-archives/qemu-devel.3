Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DBEFCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu4-0003NB-P6; Mon, 09 Mar 2026 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTY-0000ur-Qf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:21 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTV-0002D1-TT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:18 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1273349c56bso14677661c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092956; x=1773697756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tuchCVVV/Puxk4LNxFCEHszeZBuFiHFk9yGxFArzvU=;
 b=lqmGNxqpZ16G7n2osLDmt+B9gD8fTBmAlOOJjUib8ii0whDmtdjd24hBJOv43fj/e6
 rflaqn5nsgX5obBztze9dGOupHOT4oRSXsuXNnapXX+8lPytOW2u0hjDq8TnQ9b2uf97
 SYSwKX6HWcI5NV1sGlwjBDW4NJCrirzoxX2dhXbjIAyFAwxNS5U2+anTs2jb4JYP3iMW
 82geekRIDBS5opLmW/rIS0AC83gqiaLqIh0DvbOLs294Sd/f5oll7cVjj2Vu1s3S1SmI
 CHM2e59a3pHB6Rcd0IkxyRXBnxTL2/14yhiBXeycpoy0sTS4eHphXL49qkkiYImpIaz7
 UEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092956; x=1773697756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tuchCVVV/Puxk4LNxFCEHszeZBuFiHFk9yGxFArzvU=;
 b=I3qkR0DkN4pE3Zn3P9dN32RWNq3cG7+SFP4hlOQAK0bO4ZSeI4XJG0XooLNsZkGxG4
 rZ0R7ngtYWUDfc/ISYK4PtgGgwzSAkDJZqfrQqtUpc1e+ZsluJ9bLSuEEjGS1xp6F6Fs
 i05oF5DX6BEYDjuE3nX2gN3WxXGPTOATcyvCAxsu8mbD6KP1MgeATkKTJbhnyf4s+twh
 1A/WHhP59ycTLTEy/4/OFJaCuRNxk93hDNXR4BM2pY673Mzb0V4VaRPqeDq4g4m62khV
 MjmSWL5Xc6Ce3/xm0To4AN9jHvhAb1B4CPdB53fQAPpbHgmsbA75ZQtT1UGFcWAFkR0w
 SQUQ==
X-Gm-Message-State: AOJu0YytXqkXx7EKWFOGw1cYS25Q5QP7oy96iHj1icCryNaRkp/t5F0b
 W2U/wvgzeOPSefQ6JtpNVVpupwChap0Ihjv4stVv9BAT1etI6dluoiFezmesWWJS
X-Gm-Gg: ATEYQzyl3nbz2/GbTUjSQMIcrCy5UfA9D4r0/8HmZUUNnMyJ03FCnsWMvhk/8UH6IrG
 /jDjt+ZG6rwkbSLfjJFG6r8XkJ46LrgazhPtw8ZdwuvPoZ9Xe38xkIZ2fc7Aq8l/teUVkrcowjP
 zsRxcnflw8pwFzrZBPRbhC0+qcMui5IeW6esmuUB5zkAv3v0C1cPIm6PzlxyFtp8MzpByAteeY9
 LoaTuFHG4xmtfMyFSlPW4EtuRv5RIQmaXY9G2KObmv1DR/Z13fYm+rY1MkfJb2mBs3u/BMysohI
 69Yy9+sQvezgh4sU3s6AK6FD5Iq88uzeVJQoxQrzxmPVISyxhW4+XpSEsP4DMwwLCdmfqmz1t2U
 pNEeJ+15rLCkDbizWKHXLBPqEAZr4qr+smgBnDP0S2mamrseIlKBonVBf1Q9dAwwNtEXwpnMvo/
 cgNrGLEILS3LGSUplYMu6w0T/vJ0He6P0lWzjV5fOFxhlokOpPHts=
X-Received: by 2002:a05:7022:661f:b0:128:ced9:9409 with SMTP id
 a92af1059eb24-128ced99529mr3422909c88.37.1773092955767; 
 Mon, 09 Mar 2026 14:49:15 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b1d3sm10821438eec.11.2026.03.09.14.49.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:15 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 2/2] target/arm/hvf: set 4KB IPA granule on macOS 26
Date: Mon,  9 Mar 2026 18:49:06 -0300
Message-ID: <20260309214906.92578-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214906.92578-1-lucaaamaral@gmail.com>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

macOS 26 introduces hv_vm_config_set_ipa_granule() which allows
configuring 4KB IPA granularity for HVF virtual machines.  This
enables hv_vm_map() to accept 4KB-aligned addresses, matching
the guest kernel's page size.

Without this, virtio-gpu blob BAR offsets that are 4KB-aligned but
not 16KB-aligned cannot be mapped into the guest, falling back to
slow MMIO emulation.

Gated behind MAC_OS_VERSION_26_0 compile-time and __builtin_available
runtime checks.  Falls back to the default 16KB granule on older
macOS versions.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/hvf/hvf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 87ddcdb..b71a98a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -960,6 +960,20 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+#ifdef MAC_OS_VERSION_26_0
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_26_0
+    if (__builtin_available(macOS 26, *)) {
+        ret = hv_vm_config_set_ipa_granule(config, HV_IPA_GRANULE_4KB);
+        if (ret != HV_SUCCESS) {
+            error_report("HVF: failed to set 4KB IPA granule: %s",
+                         hvf_return_string(ret));
+            goto cleanup;
+        }
+        hvf_set_map_granule(4096);
+    }
+#endif
+#endif
+
     ret = hv_vm_create(config);
 
 cleanup:
-- 
2.52.0


