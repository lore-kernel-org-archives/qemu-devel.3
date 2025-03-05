Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6671C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqa-0008H3-Ru; Wed, 05 Mar 2025 10:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqX-0008G7-BO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqU-0002F7-Jl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso45790905e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189180; x=1741793980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRaiRNOXt2Tm6E+k8ENfXrbiXjiTCdfFjZ148djIZfg=;
 b=xDHfivwDDiwiO7FJUWQqnp11QOdM9Ax6iO2AkT7Y2RQg3dOKa+IT1rKL0xoO2vUAaT
 c1ko9wzU1WurVmE+mSBt0GgPV93d2XO9AptizlktU6FPdRmO5KQpvMdcoEqdty+vAHUU
 bDEHXtiX4ICQSNYAwb7n1oGyXTiyLI9fmN0rSncFVw5eofxkvgqgSOuUhMN/Vf+6uyPa
 o8kUrbRs6F15MFY+SgEyyfKvum5RNlMxM8PrZwkjNsJMLGIGm5GEgaBqL/xZifFxOFxM
 kciwKZJCLRr8KM++Wl1d1vCr69NmKIavAO4LPx7bwZ4b8H8GbJ55iRFyNpf+7/GskNpx
 hPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189180; x=1741793980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRaiRNOXt2Tm6E+k8ENfXrbiXjiTCdfFjZ148djIZfg=;
 b=n7XFJVlPBcqWagQlSJljYHVWEkdvyAce+o0xWa/Aei7XCIbKM75FRR96hVJo2FW5ug
 4t00GLlt6HGoRZ/fom1IPnfAqYgRm31cckDKKbsrOLXeJWgFZa5q7DE/OBd+K8MzMAXD
 MSQDEXW0Oxjfk81dxn2OKCkCAAYfBnQV7mkTFcr7nd03ii4Pf1bX3sH7aBx9Y7kIlVQD
 zvNAWIyS2Gz4tHp3XNz6vV34xhaWvOQi3I7rCnNlPTOQ62y+qjOzW+0tMdWOjoothBfH
 S7jRj6TnVIOycl4wBr/OfjpVQIadE7/W+QPwBGNfJG8HjvbyMO1pg3xyP3MNuxGRKxl2
 x9eg==
X-Gm-Message-State: AOJu0YyJeoJpxF05G32m1XqSeG9k8m1Y63UIQ6IUfqm1RD/Y9fCuiL/5
 WOk4fxp0s4Yseba8ar9tsi2atuUKtZuZjE8LPsOk0EVKpUmwbL32iTjT7hwvACDC4JI5hIHTxCB
 buxQ=
X-Gm-Gg: ASbGnctC+aiV7zGGBjlmXhECsHphPR6kRvaeA8BO7tRDP86wHypDVTbpDA2x7vGhoCq
 fk88/4EiOVJp6mfLdEruXCnFhLv0tumXlx8cbs2TVJA6F8mOF8zAbKRL02/ZBrj5udjPcbj+7u0
 dUrJxoxGApTr6SlthWZAy7Zyv/23v02XDSL7SgDFGMJoo4gBGEDkOzsNMdAyXdYB+hcXdl+jYx7
 +18lbqT8QlU7draS4aq5dX2mHlCAVMIwC531uPTD7kNVdwaLiPQbVF2U9EX5FCXDhdW7i/jG05V
 zflb1lOld2bFT0DE6o52PxX/VFgHndXOvOT2XfFXDjqRPz3nVaaQso8D4Q1wClsZFB1MJ+nhIqs
 58RUB+jwt5apwyrmTbWs=
X-Google-Smtp-Source: AGHT+IF9Y3yTj3l4rEmYN8S7RWCl8soWh/hPSQQ5G9Ol+uEL+06GgwMED12RVVtncEVuqE5wz9RoVw==
X-Received: by 2002:a5d:6487:0:b0:38f:3b9b:6f91 with SMTP id
 ffacd0b85a97d-3911f74009fmr2711509f8f.12.1741189180465; 
 Wed, 05 Mar 2025 07:39:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391269f30f2sm1056060f8f.34.2025.03.05.07.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 02/18] hw/vfio/common: Get target page size using runtime
 helpers
Date: Wed,  5 Mar 2025 16:39:12 +0100
Message-ID: <20250305153929.43687-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Prefer runtime helpers to get target page size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7a4010ef4ee..d4c9e59173d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -30,6 +30,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
+#include "exec/target_page.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -395,10 +396,12 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
     VFIORamDiscardListener *vrdl;
 
     /* Ignore some corner cases not relevant in practice. */
-    g_assert(QEMU_IS_ALIGNED(section->offset_within_region, TARGET_PAGE_SIZE));
+    g_assert(QEMU_IS_ALIGNED(section->offset_within_region,
+                             qemu_target_page_size()));
     g_assert(QEMU_IS_ALIGNED(section->offset_within_address_space,
-                             TARGET_PAGE_SIZE));
-    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
+                             qemu_target_page_size()));
+    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size),
+                             qemu_target_page_size()));
 
     vrdl = g_new0(VFIORamDiscardListener, 1);
     vrdl->bcontainer = bcontainer;
-- 
2.47.1


