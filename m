Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39F4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeK-0008SU-L5; Mon, 13 Jul 2026 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeA-0008QB-DQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe7-000169-Tz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so1793346f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956757; x=1784561557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N4As0Neyy8YrD6FVFm9+Tt3dYT2Qlni3lX7+Dk5wYWk=;
 b=pWW9u/Q4kZ5rgdKUZP/ozg5WRBCjv6xu2Xwaqf8MvvxyFR/cOAaEkZKQ2d5A/yQMly
 q85n63sytobUmOQuG/5VAPv4M9MJo3Os8/qMquz1P/Mf0ixMN8PyDK4eHQnQ+FqtGcZ5
 /ecA/F2SMROj+oiECPMAfepIECKWCDGmZloWFzEKeZDGiKeM4Qk8k9sX27xSzlHSouru
 N3dNL0VeNW085j3gU85EHZN3ffL3k/Q6ckLnWcEkeXaott7uMNzZ++prFFfYCfFkLTLz
 wLW+E8BLnOqoHFBxLqc8W4onn70Q1rdLHSbJfkAC3Qy4T2r3fme6zLd7MfcZ+K0u3Ts6
 Ai9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956757; x=1784561557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N4As0Neyy8YrD6FVFm9+Tt3dYT2Qlni3lX7+Dk5wYWk=;
 b=Ge4FbbEXC9Xbri8hJkbDW5FYMrG7KcfW5VvAU4Wu3KWJs8/R68HTAnjaFpoWdP9n7M
 pSQEoJqw4USkYKViFVwPdUSeaYFg7wHeufFEpTYbj0tE04onPC50zlkSD4iaVFBV9ugg
 /lc4JxjOHyi/fqS7gTJKZz4WHVngSOIMOogUDTmEJ6jUaOg/YOt4vJR6VoWGWdQafajU
 JQdq94dG3hV7ckqfKZXTrypB/q6ZWP8MRobAUwCvfy+S4brDw6MLstC2u942y9qT6d44
 ZsazIzSyDzd4A4Lb6pUr0ARlVNNOUJnPKjgXYr5cxtL+JDYR3ob8lDIIQ4BdmJNIqcxv
 c4CQ==
X-Gm-Message-State: AOJu0YxfBD82onA7UEujp5HxkP9jB1wW2piUqBUpBIv0VA6wBdRIhh75
 RPI+oO+O0hx22xqf5hRG30AUvJ03GRiI23jPIour7G7V8+J1yDcIfX3p6n04k1Sz+VTgU/qJaA+
 ZbhT8zHLGfQ==
X-Gm-Gg: AfdE7ckahksdLp4qeDZZBRLZAGFzkYhO/Mm8aNKz6eUgw3IEXMkWHJfhtnT4HEOiUiu
 /etnAXzxNh6IR97ZpbdDE2lRYixc2W61pKLnx98zw9LuJUGVwJC3anLndBZJ/cwdTP7U+byhzZu
 jS4BK+SwLeWQuKvj657omXz3ErVUAE0dWFZar9+6Zm0oA4J+KVeIkMDji74YLcGlkFn/oXbF0Qq
 km+PFph1Uuc9NPIqvPUcuWE9qw0JS4QSsrv6/L0evlGyQ4LnQYKHOThLGquyYCeOrr+pEkXo4in
 +pudOPHd7GKmRKxAmwwde1/Vi9p6NVPg7yb37RHW/W7ciU4Q9VHHdifqipY/T5cfNY4Cz648Jrg
 Q9Vj9FCRnx153hKoH1oad/ucsIPbG5Tri3BJcA4LvB07UuX9cGXTmZW05xp8239kLQqnOJRPxqr
 RT4HkscEKwswOimiMrwh0uznn9DDRuUmoWUSPZDHJxbe+81ELz+qmWKkbpndYDub/e1cAbbBCay
 oGo74aI9v4mO/tXCtMAZg==
X-Received: by 2002:a05:600c:348e:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-493f87dc629mr96515855e9.8.1783956757215; 
 Mon, 13 Jul 2026 08:32:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
Date: Mon, 13 Jul 2026 16:32:09 +0100
Message-ID: <20260713153233.3391818-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

When a guest hits a command error, the hardware sets GERROR and the guest
acknowledges it by writing GERRORN to match. These registers use toggle
semantics, and since GERROR is read-only, both GERROR and GERRORN may
remain set after an error has been handled. As long as they stay equal
there is no pending error, so a subsequent VM is unaffected.

When a new VM starts, QEMU allocates the hardware VCMDQ and flushes its
cached GERRORN of zero, while the hardware may still have both GERROR and
GERRORN set from an error the previous guest acknowledged. This makes them
differ again, so the hardware sees a pending error and stall the VCMDQ,
leading to CMD_SYNC timeouts.

Do not sync GERRORN when allocating a hardware VCMDQ.

Fixes: 1d0f77535417 ("hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0")
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260707112450.111178-1-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 7223aa9d1d9..273633e6293 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -212,7 +212,9 @@ static inline uint32_t *tegra241_cmdqv_vintf_lvcmdq_ptr(Tegra241CMDQV *cmdqv,
 /*
  * Flush cached register writes into the mmap'd host VINTF page0 after a
  * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
- * the cache-to-hardware transition.
+ * the cache-to-hardware transition. GERRORN is intentionally not synced,
+ * as overwriting it with the cached value could recreate a GERROR != GERRORN
+ * mismatch and stall the VCMDQ.
  */
 static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
@@ -229,9 +231,6 @@ static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
 
     ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
     *ptr = cmdqv->vcmdq_config[index];
-
-    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
-    *ptr = cmdqv->vcmdq_gerrorn[index];
 }
 
 /*
-- 
2.43.0


