Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EECC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RNU-0000p7-P2; Thu, 03 Apr 2025 16:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RNI-0000c5-6y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RND-00057B-Kg
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso7894005e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712873; x=1744317673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1ud80T7n6XBN/Vt1w60MmBJZWVmW7lhw8QbR2LN0sI=;
 b=jVaWe86fgsmIvWn+/TpVJEMqk2sRsRSyTMw5iTrjf/RtTnQag3Rx2HLsf0RoUC7UDG
 u+K4oswtlyOl4AWsA5yEKMWJF1DXWnIrnA1S3rOK01qE4GTHW7bQ68l9lRDzpucdghRZ
 FPwZMCyf0L1NHH4mAW3p1asgRMMqNF4IB7HbR/GZwKqM27nC6++mNOb6lB7rsgIeXbX1
 7XA62rmn24M4izH3FPFNyguGhS9xd27Z04JLHGPhqbu7I4ueMhM/W3Aze59eE1sWxwuj
 ekO1fQ2dy55mtObdmXhI0ymTNXfDF4mVGQBADzfOe/VjoWiL0TMeaTWG9n1F7aHXvdKh
 JkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712873; x=1744317673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1ud80T7n6XBN/Vt1w60MmBJZWVmW7lhw8QbR2LN0sI=;
 b=kgzQ+y3HxPMnCzpMuoAxuX6MyXPQeJPH2wvKzghuljyKHEm85Ri0zaTqzb225a0Uu6
 RjWpRfS9JbklkDkv/4l2mBL7+xEfS3ej9YcLhrxXvUg5LKVTqFHyfUGnU+oBCSORq4MN
 nbJNdI3iYZ1pxTHGT7EboFArdYecbTEzubCG5T/rO5vgSUyN2m4w5qhh82tIwLMqpqd7
 VCjNMFp9OyQ/buuITw4jZotQ92FlAHE0oHTfb/6sLEXr9UKFFv4qHwwTBmKItnq+nWhy
 a3/kiQ4Vi1nUtfAbQqbcnFVsGyyRNgsEQAbFV5OFj8mWQtBeiVdfPI52QIdqdPZpUFdd
 leiA==
X-Gm-Message-State: AOJu0Yyqx6Mea6iA/PCn4gWQkRfvVKdgQLZso2z7bQhFKzYSU+vzC3K9
 bEdXXrkZP3qtRQPaCnu/Ek1ggL2JLKC/pUl26P09o6doszF9L3Gg7J7yaZRj3agV2Y85vFj5tY4
 U
X-Gm-Gg: ASbGnctaX5C8UDqkFhS+SbkmW++ROvH9s3sJ9+F5wFCXwNb1V7P0foKPh+FTqStNJ1n
 aj+beHTjMHUnfP1t/0wRCOycIH1jEl/8PhZ9bMVU3y7p2BBj/nVhMai1FCJB5Js8qlI7BFuDaCB
 2Xe7BT7X7fAb08gA28l9WurWfcGRHeZjcj9e6kN0QyylktoAeOpyTmoVvSU+kvSxfFtaVLZ/DxY
 xPS46C+/OJi1l/9x930qX154DChk0aTn8NyJyLg/bgbHcjouNHqlHFdwhJTEvmllR/Czw9qoswA
 MEwG2CYVsXv72oh+6R/Pl1K4izddMdlfkZlu8JmixrXXWL8JgQ8SanIu4Tatc4mKO5eccdUf9Q7
 cJOdyIzi5f7o7C7oBpzDfmGyS
X-Google-Smtp-Source: AGHT+IEU+UhUNAfd9zMk+eAeD58yweIdBZ4ugK4h46Ifvyvwj/FZT0/mzLLDu94w+ivy3mHLgSMRbA==
X-Received: by 2002:a5d:6d8b:0:b0:391:ab2:9e71 with SMTP id
 ffacd0b85a97d-39cb35bd8bfmr546809f8f.20.1743712873478; 
 Thu, 03 Apr 2025 13:41:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a7615sm27325625e9.9.2025.04.03.13.41.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:41:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v3 8/9] hw/arm/virt-acpi: Do not advertise disabled
 GIC ITS
Date: Thu,  3 Apr 2025 22:40:28 +0200
Message-ID: <20250403204029.47958-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
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

GIC ITS can be disabled at runtime using '-M its=off',
which sets VirtMachineState::its = false. Check this
field to avoid advertising the ITS in the MADT table.

Reported-by: Udo Steinberg <udo@hypervisor.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e7e27951cb9..38a9e6fe0c5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
-    return !vmc->no_its;
+    return !vmc->no_its && vms->its;
 }
 
 /*
-- 
2.47.1


