Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB38ACD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7f-0005JN-Fm; Thu, 28 Mar 2024 11:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7d-0005ER-Jz
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7c-0002b0-3S
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a474c4faf5eso131227066b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641414; x=1712246214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAY/yw6dYKkUP/WFLvpvljjwD9mQwkPWyyzr0cq0w+A=;
 b=JNDl9J4SJDqRbZFQoGQNMvd+BkAqhAFqoy3Updafh0XZhndsPEsNvvJ92i3A1GANz9
 2IaxJYrPLm/XIOop51q5ng/aF41/Ss1+CUbIjxqNX1W+Tex3R0tX9842dgQyrWJhU5dU
 bIxi1GkxYKHGcglj+dr96Qej8sunG5uNpeUZ3d57NydIe6pQRQnEzm4GXTW9x1nh+aTO
 5qwQd2GzxIH5eAlrlHMlRPa5bHpVuNryDKsRziqerpWRxIOeFVUFRHMO+Lojqdj0bIfn
 mKL+Q/T4RWsZuPf5gqSfQ5SdUJXXiGSlonrgbW4FCkZIJTXnV4Wvp4+IWQs/Hd8K6Ct6
 GmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641414; x=1712246214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAY/yw6dYKkUP/WFLvpvljjwD9mQwkPWyyzr0cq0w+A=;
 b=DG8BllfpBT9cCqXNeaUiJrjM/+CY07/SJHI3OhyuEiMvyuLARbQvztCtpmgeUVRBIU
 sUrDJlpPYH6g4WjkNrHdMeDsNIBsJLtkAHdH0LqxYdJbPuuLCXKOB3wFIglhX7LwqY+J
 TvX2z+cCpPt5vV8PHYOg/B66xRT649Luwhj8kCVwmrC5wX9RvMIEbhpBylbbr57fDryE
 4Xqo6mz9cYDAAZgib+/KTLUnf+lKsiprTeiJpYMEDod+9vxqGbVRaGrWJTLSPmQmAErk
 2cAz0k9ueSVEkmmlR90Z3fAidw9p0UlwSzzUsmXgwocYIIexVspubtGKnLEIdMrHNir+
 rpJA==
X-Gm-Message-State: AOJu0YwLxf7un0NdYT3DuWtH1vpDQk8JhN7ICN4nsUPFad4CkpdQnZiT
 bBiQcGwbJFy7dvcl3EXZRs0Qlchj0ERkFll1u9VQFsZmGfT7Vw8Rpx4eIDzoQY0NolJmQ/8rFlt
 t
X-Google-Smtp-Source: AGHT+IHHCjINc+B1WA7YTf9CDPOy43wJYCQL0voBiUNztEKWZkyjgtHiZiJjx/du9sQyScNWeJj6tg==
X-Received: by 2002:a17:906:35d0:b0:a47:11a9:9038 with SMTP id
 p16-20020a17090635d000b00a4711a99038mr2127429ejb.58.1711641414401; 
 Thu, 28 Mar 2024 08:56:54 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 x16-20020a170906135000b00a46ee3c31afsm884227ejb.154.2024.03.28.08.56.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 21/29] hw/i386/fw_cfg: Include missing
 'qapi-types-machine.h' header
Date: Thu, 28 Mar 2024 16:54:29 +0100
Message-ID: <20240328155439.58719-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

"fw_cfg.h" declares fw_cfg_build_smbios() which use
SmbiosEntryPointType, itself declared in "qapi-types-machine.h".

  void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                           SmbiosEntryPointType ep_type);
                           ^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 92e310f5fd..7a426119f8 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -12,6 +12,7 @@
 #include "hw/boards.h"
 #include "hw/i386/pc.h"
 #include "hw/nvram/fw_cfg.h"
+#include "qapi/qapi-types-machine.h"
 
 #define FW_CFG_IO_BASE     0x510
 
-- 
2.41.0


