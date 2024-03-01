Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D32AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg86v-0007VZ-OZ; Fri, 01 Mar 2024 13:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86u-0007UT-26
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86s-0004L6-JI
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412c780464dso7503865e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319593; x=1709924393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rt0/+i2C3VmFBjnLzoqxPp8QQxKL3HX9E43/9vQY3SM=;
 b=WqYLV6gdGU2zcNc6Dt4ee/o59z0oZDrNV7Y0k7CMgNmstLdOWityJrvrwCeAJ8vQ3N
 FZwEXag8vDF1e5EeKwfUy0uZZggKnHFDj+HntSjrAcWV8N97Rw2ShJugyiukyBunvfYo
 L6wZYCpotuRturtV4bPlXtiy1GX6yTbkrbyO4abo0W74BthqjW0EDGD5MS+jGlKgAwCh
 7lh9950/sQsCHDa4/YloEL1FTOotH7yPU+pBtAHyAS8uFdzazle/8hAxIVNLKNVWztmo
 d04PjsR2WR2oBQ5fXkRUUGCU+ahX6aeyCefcHu+BLuHO2jqhxV8Rf/AibICNy9+oX6NH
 K1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319593; x=1709924393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt0/+i2C3VmFBjnLzoqxPp8QQxKL3HX9E43/9vQY3SM=;
 b=DMien0SgipfHR9OlalTCr4FTUGNU3AXR4DUzDLXfl/3wtzqT3lZy+/NgnkwgjlD9b1
 RCZIjJnYEnoD9WzX1a+sy5v8e8qmi5LWzffRVc+fHXvHu673setmea/o4NJzotO1c8oK
 /1qBcKdxPvdcauyqBMCaFzPq7O1bwvg6RCTOvL1wyiT3YsGP5ULh4piVXjdGbYxODpvU
 XmH5P3qglmBRG9d1acL3fx8j3/BqDqGbydTL/1/dC40ebYwsxAcbeRGk9q9mqk3H4/ch
 31Wn0VPGMfbrK3/IR4OXLKqGFTwioM70BBa34hISmXd6+PvnTPQUFRRGiSFDLbk7arU7
 ZMCg==
X-Gm-Message-State: AOJu0Yyfzrq0mDdzGFuW3v0GSNl8BqOAIJ6FKVF67rrXxYplHSYRHynJ
 WNySW/JHaATxCaos75bvqBGWAfOZyFYzj+DcFDqEEbg+op6caQST+aFNpuaPCU5Br87Y34JO1Np
 f+hJs2w==
X-Google-Smtp-Source: AGHT+IGvaXDi+W8Dat1kgEcLY0xbWi9HVkLMzqqxhq6aWQJHJu3OYubjGDM0osbVBEy7S2Z3nPgiwA==
X-Received: by 2002:a05:600c:350a:b0:412:cb58:6b20 with SMTP id
 h10-20020a05600c350a00b00412cb586b20mr1079044wmq.7.1709319592896; 
 Fri, 01 Mar 2024 10:59:52 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 dx14-20020a05600c63ce00b004129f28e2cdsm9185881wmb.3.2024.03.01.10.59.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Mar 2024 10:59:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/i386/pc: Use generated NotifyVmexitOption_str()
Date: Fri,  1 Mar 2024 19:59:34 +0100
Message-ID: <20240301185936.95175-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301185936.95175-1-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

NotifyVmexitOption_str() is QAPI-generated in
"qapi/qapi-types-run-state.h", which "sysemu/runstate.h"
already includes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce6aad758d..0e688ed655 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -60,6 +60,7 @@
 #include "hw/xen/xen.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
+#include "sysemu/runstate.h"
 #include "sysemu/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
@@ -382,9 +383,6 @@ static const QEnumLookup PCSouthBridgeOption_lookup = {
     .size = PC_SOUTH_BRIDGE_OPTION_MAX
 };
 
-#define NotifyVmexitOption_str(val) \
-    qapi_enum_lookup(&NotifyVmexitOption_lookup, (val))
-
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-- 
2.41.0


