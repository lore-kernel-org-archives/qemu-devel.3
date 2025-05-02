Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7784AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyDB-0000lI-3g; Fri, 02 May 2025 17:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyDA-0000l6-8C
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:24 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyD8-0003Xe-Ns
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:24 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso467642766b.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222380; x=1746827180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsDN4bksGI+t6Ajgx6lEwHOduZigzfyenP30N9rjdOI=;
 b=RLC2spLKgwcop4kB/u1cqoTkwAsPI5BI4Yp8fyUTKurk5ZH5iePqpsKujvutBXQyyC
 mhlrc7wszYMRT/qAAcfGnZ9PRepi9cIzzTq8EGx1APeUw8cXN0xzdSpLLUaoJ3M2NvbR
 RiKaet4AhOezzy/P5p/3TVd/gaIY5WWhDTNtWnqMPqNP1ld9n6b+fpDcXMy9PUva89AQ
 Hk64nDz5LWvgfQd1Tv1jEuD+xItgksHTC7OnCPe5ojS60Uxo7RYAuOu9jFKIIWIgBLXY
 2SKtx5T4NNJSAx1b+OXavEyF+wqAqyDoXAuOCjbATnGmtthhza+gesWSksmf8J0oYX4p
 qQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222380; x=1746827180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsDN4bksGI+t6Ajgx6lEwHOduZigzfyenP30N9rjdOI=;
 b=CdCiwGI+1Sk72xS4EacbkfCus1WsPa9JQyoqAXcUcH6nBeSSFmry+u0hSYPKqm2NTA
 O400hYVifAVSyyT70Itk5dcpHkJ/+1LezzSTG6aNwdyf+cKYVpG/oHFPewRUb7XgcC8G
 n3RimzgG8EnpHxWn3yc64E07adlBXOoQYMXkxEz2bPrrjbqahBgfwtYe4VOCd4zjwCsK
 okut3jCyr069uAE20L1vjBhSlZMqyAyOVImhx2CZDbQLNj4BBEimf8/1nBsAH3e8YH+3
 0p25t2OCgURI2mSUk63eZdhjYYJGv1VOP/sWTfepn6wtMiGhEfb70zILFGLb7+WsHdZE
 /hMw==
X-Gm-Message-State: AOJu0Yy//pBtYQNHXqJACfInHTnK5M/cL+6GsDakwMA1SMM41p6/rtMv
 7lTasTjFxMjc7ixmeotGQM8+fW0mO0S4eRQ822TEyayzoQcQ+YtSeqVgKuq9e2pnubIhRBvDn/b
 G
X-Gm-Gg: ASbGnctPqZ9Q4VwptN560JAlhlHM3BEQIJP1QGF5w2SzkY/4IQ2SF44ExKTOtoneRXk
 7cEAWhtFvYLi1ZcFVuFZVj0AtexV3I866/qjZCuZflduCckfYsRSGMhvKgacfhrOwql5YHTnmC7
 KD9MibtiITxWXqMxNRBSpN24Iv2EeOEeaFGj3Hp6S4ubRnYn3oBaAAlge0KyrVgMJjtokfqodA/
 F5VdKuZi1ZJARepXWJ0KQehcY1toFilXsLmAZ40kYUIY1EED5PlAasrQaLw42smm/CCfuEIYG6D
 +VX8ONNGx4wkpPn6TBm1x3eU6xnn64u1IaOxQgzPB/Gk0gSNTRqiV1f5KcMsZ0aUuZy0ex1phmU
 63YaN6kAIAZk+T2g=
X-Google-Smtp-Source: AGHT+IEYBcX/pI3wzQen51X21dbxGKuxteaaxZGI6zLLmUuNwiDzk46eWWBSMsdiidXDbkWZqLpSgw==
X-Received: by 2002:a17:907:3f88:b0:ace:d811:db25 with SMTP id
 a640c23a62f3a-ad17b01fe1dmr425125466b.60.1746222380468; 
 Fri, 02 May 2025 14:46:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895402c7sm100535466b.164.2025.05.02.14.46.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:46:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 5/5] hw/virtio: Compile virtio-mem.c once
Date: Fri,  2 May 2025 23:45:51 +0200
Message-ID: <20250502214551.80401-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Remove unused "system/ram_addr.h" header. This file doesn't
use any target specific definitions anymore, compile it once
by moving it to system_virtio_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 1 -
 hw/virtio/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 4234396f774..f4882c6901b 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,7 +25,6 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "system/ram_addr.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 164f6fd995a..525679954ee 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -56,7 +56,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
-- 
2.47.1


