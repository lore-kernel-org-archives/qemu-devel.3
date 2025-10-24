Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC97ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNRq-00061b-8P; Fri, 24 Oct 2025 15:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNRo-00060a-UO
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:27:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNRm-0000kS-AX
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:27:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so13991885e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334052; x=1761938852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRr6s/NgJvS1YxYxcoI/3ZRoDWUxn4NQSax9XkT8Jh0=;
 b=yr68Feu6nxvOjRVtK+m88hS3PWu+sbnJXzK6hQrmOGYsmkh38g3HPQhOH0uGF1zWxV
 cP1oNmChZzhrcZL2/rcir48SGaG2iSYUC8dv7RaI+FYeE74zPBDe+s1jQnN7ub3KU1VR
 2vb9a29r56xb5xx3/y2Bykxfnb/Eg+oK6mB/uEKbzpB9XYTIh9cUrrE6m2rsYu3RV9RO
 szzcg3ghtUQJ5XkGG5hU9LArtXXqAn4azNMarsOrRV+WNK1lQBxeaPYttGnWRq/GRMUK
 HtaSdQN3ncq332Div7iIq2t0vVg9B24GiZIygYgObVC4EnU9AuPnTEH0is8iaqoKSWkc
 OjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334052; x=1761938852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRr6s/NgJvS1YxYxcoI/3ZRoDWUxn4NQSax9XkT8Jh0=;
 b=vwhqT1VGi+b3RNUJeV7JKSeouda3uyEPjk4mGoJ8zOjfVtEBDW/uyRktVegelnJGkO
 gTE8lNgVbQXR6+ibSSNF+vAZyEjigmEWmUXOdCSwKW7VrT9VOpxL7gPeqOUO1C9aWCf+
 pznUaGihRfTAlp/716ZOEcwZpQFPqbO0/qROswvfY+gTEhanCsdVJghg7O3BP98u3N0f
 jTYIIuN5W5ebxmUFvvEkkGRSHxecEQ+bJ+zxmUkVmBjkqN/OHI0BTXIUOaXc0B06dGIh
 M3X0GATyGmiB+eg5alnYs1Q+rOjgWy32R4kJEchcYnj73Gnmf7b/x+fxOpoZkU7UTECO
 OGMg==
X-Gm-Message-State: AOJu0YzarB4JnR06JjMHbLMFl6itsbL79bZQJESaleWZSYaapvUsCBlH
 FWfY5o9kLHPcQQppJRtJ0CakHG6ZxgohWuAFXnP38WzOgE2wuLeGBe01cUib1TKY5n0XdsyM0CI
 mH/+R9A0=
X-Gm-Gg: ASbGncsi+leH8Tw3IMAoja33uyZGjzmMXctLsCpsY7SdTuTB3fStfhxztDvyBH+CDuu
 nquFtm+MHfxeiHt8u40vslrepUHzr3G6ZjujaUQKku9tOL6H86BBtGo/gSDkoyL+NIQsCI/nwGo
 Z5dTaq+t8773nv3rfgtDfnG2e2uElCIWUD9xMfR06OcV+1OIaQLcdjV/sSNE3+BMLcMeJbRaZ01
 KihJ/ndKHYjQ1s3FmJgEYee2Bdo8DjIKs74dE9h6sfYj8iYHGKZD/0VKqi/1jJAY2RXDrjHHtcL
 3IjGGfht2ohd1wEYVUZSOptl4xVSmmiO5YHd56NmngaTc13DU2bzpQxsX71pkkLyHVo3kocPG1Q
 bs6ubOqjSsheID6zm4bAf0LJBvHS+wZitwwlt693fGtSDZoAb8N6c6DIjIJOakaCowOBgCLbQJ/
 t33MeVAxyn8It2zfZ5ypiYGFkKDx3eVLz2AVK2PO353YPbxZ1Xzg==
X-Google-Smtp-Source: AGHT+IEJH9HIK6kSBuDnnvRqluhCJafija2xTj0gjgv2ujNy5AGIoNYwoO1veDzcJF6EF7ylgaCN8w==
X-Received: by 2002:a05:600d:4392:b0:475:d8f3:71c1 with SMTP id
 5b1f17b1804b1-475d8f37463mr11574525e9.27.1761334052556; 
 Fri, 24 Oct 2025 12:27:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm195951725e9.17.2025.10.24.12.27.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 15/27] hw/pci/pcihost: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:02 +0200
Message-ID: <20251024190416.8803-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  include/hw/pci/pci_host.h:42:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     42 |     MemoryRegion conf_mem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 954dd446fa4..d06d64f6cad 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -29,6 +29,7 @@
 #define PCI_HOST_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 #include "qom/object.h"
 
 #define PCI_HOST_BYPASS_IOMMU "bypass-iommu"
-- 
2.51.0


