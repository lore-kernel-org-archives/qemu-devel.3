Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326DEC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3k-0001rV-5Q; Mon, 19 Feb 2024 03:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3i-0001Ya-5H; Mon, 19 Feb 2024 03:31:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3g-0002Lu-KK; Mon, 19 Feb 2024 03:31:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1da0cd9c0e5so37034685ad.0; 
 Mon, 19 Feb 2024 00:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331486; x=1708936286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNkOh3VPNtlgospyMybpdwKaxmKzTmiXNUjVZD0tHkg=;
 b=J0y0tVndEy00dEKNYWfog+85/L04ueKhX5h+kKYWq3y04bqfCvcmn5spawyEwBUVVu
 Me9MdhCj2e7IcgTgTWldwNEX2pz8HiJWcxRsUj9hvfTTT6KrpzcGV03ZWcV6jazn3XBS
 Hb/b9J3CFPqtbRPHIIvJ1rp6nf/fKwOoGiq1j1r42iENlFfyHOmcrGT2QbrBeHVbEbne
 9dzjjTu8vuQqD2n2B/NTu+48B9WoG8Qk5gI+YwILjWN2slvLccUHQM/cRYED9HJPwpOr
 nFmJWNKuxRvBwqfA2Q7E/Wms+YEHvwAYXe4tNPpgxgIV1A1BuplY5jx1pht8NYzfCT42
 ujSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331486; x=1708936286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNkOh3VPNtlgospyMybpdwKaxmKzTmiXNUjVZD0tHkg=;
 b=e59hhDcWSO/+231YORc6wdLlk+y4kmp3hqs1REgQyxl1ZX6TqbWlqwNjY1BoRU+h7i
 EyHqrboNNaDxg65xtgW3TXGZlK9bXF8EyKail2sW38HG4yaZpguLVmCt+yglmXrN6yph
 sh8tzCKKAINrriPWrmPXaBXXOReEpJmVIb/qEFL5OWbe7xGACbw0KWUf4XzYoz9W1DDq
 h1c/rsv3l1BtTJJTy/FUCFOTGELMRpzj6b7/6v7wEPeUvq/dLqOG+foUnxvhmID76Os9
 sQUky86pW9ecQI7syHRpjrjMOqC3QIIR4wP5fkNf5O7b5SN6ChSZUOylUiEQnLTRuH63
 MMvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXq0oKaXnXVFQtRRFFv1JAJ+CbbfUjRwLegNcP+BK/BZKfG3t7mkTCXuLIO5EyHPq/rJfySwNmkNicztQ5UGxGR+Nq
X-Gm-Message-State: AOJu0Ywpy5Ob/GXlkMCXgEtvcaaadMAGIQutDU/XTldLjkiMWBxL8OjO
 z9aUWNQ4xFzBJIO69HdaAgOPa6pa6ifCcLBpFnJOmvz/Hz6AF/w7i8njhMdk
X-Google-Smtp-Source: AGHT+IEKw5+57KmnK40iYFImqxbNwg5k7IHpuUePsV0Tim2BpyyzsilmvRp2AEqnYMn5zJ06ILAvKg==
X-Received: by 2002:a17:902:7c8c:b0:1db:47bb:671b with SMTP id
 y12-20020a1709027c8c00b001db47bb671bmr15850399pll.19.1708331486159; 
 Mon, 19 Feb 2024 00:31:26 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 19/49] ppc/spapr: change pseries machine default to POWER10 CPU
Date: Mon, 19 Feb 2024 18:29:08 +1000
Message-ID: <20240219082938.238302-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

POWER10 is the latest pseries CPU.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0028ce0b67..b442d18317 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4664,7 +4664,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
-- 
2.42.0


