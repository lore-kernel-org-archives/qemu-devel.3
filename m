Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718C8C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SWE-000085-0n; Thu, 17 Apr 2025 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SW1-0008T8-Qq
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVz-0003fZ-Vq
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so12822625e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908896; x=1745513696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuMPts4lp59PTenHXoFrRtrrX/gN06WnA+unwyU0N4c=;
 b=jJFx0GwIaPB09QYbMcjfLqNjuitfQTM/jPb2VzQlJFgFQlz0WD3k8TFMEADb3hdMR0
 7AFDeAQkwHr7dJqmsTQE97C0rPC4CvJ73iEOnYx7Gx9pvRZdQ0DsGZW3cRH1iYOsTy4s
 KaC2Xq3MUSbfHKD1l8Dam2pwbQ5QPzqZ4+gMZcROdlkT5/uVxKvsgqD20P3laEyepHrS
 hgiGe9zqtqRPDH/jC551JPWw90LkoXzcvW4L6nM/LD9HiTfkr+qJUYNHtTGD8N3LdMHI
 UEOaRejL7w/JnizMeAuEpfKCnfrtRnvWwt1Ze5Xjzai9NH4n5EZ24Bs4uAeO7XJMIrV7
 Ya9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908896; x=1745513696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuMPts4lp59PTenHXoFrRtrrX/gN06WnA+unwyU0N4c=;
 b=Ub5JJPsUFdX6vqRRLMerGJKpHqXoELINOUzln227KOd23X2N/EQ9XbqebomcgC4Hn2
 1qD9SlLdPcZ3A2ZNUhQMBxAuptqkw5LiPSKy97CWSfq3PDoD44YXBr/5aOdTofo1wScq
 FCBh39gSBJRVJeo0GsqlCDm7HYq8149CHliW3b7pwvqr6HbmfIRF1cBzb2slo8N61XOU
 KzzalkbUl75/soaldgZsb67C9LA8W/K8RGCj/IA0y+oS5xSYdkj4ZvcHXFAQwNBccGmu
 vJohAnVyESfQtpCZOsG1PcDkUuTI3+5+BaOu8zRaIc5+25ddABSvFsDZK9KIa5Xv5ig8
 +HxA==
X-Gm-Message-State: AOJu0YwS7HxVsMkKBgj9vMPdLvqw6VBlewBo0NT75d5GSPej8y4YrSNl
 V4VXbJMnO9qfU/9ArRDyrCkbXqkNbTqEkzX9jvSdb7ssrp7A53tielpHpbkXM0SwFx6U25uIdYu
 t
X-Gm-Gg: ASbGncs2KP6GuiatYPLPlbp98NZ75NHFIJ+t4RSmX958ornIwEYJ9AS79onwgBkhMSy
 uYq8PQadQK67dtJsYrV3UCqPThLhP0v8vsqaWQmj5/T0mJGw+nFL0EVpNOsCCVorA3EWj6apM6s
 AK5Iz1qyXyB4wWoDaDP01e2N55df66B16FPUlDyHROOnLFQLoBYc1kSONrHOf/cbIpVirLuEBq+
 Zbyci4g+LR5DSQ6nbtVAGa5Pz25Y+PcB/ySR16j4a/75zpk1H+6FaWEzXDtb5BuVLRd1n2rPONc
 hTDwWCWC/Ug6EHF/OFtw5B9mr0e0UwxaKSCDLVz4/rhMk+1MazSa0aQHx2NUCeBwYZwnrptWEoD
 s4J3kbee0wr+gmjc=
X-Google-Smtp-Source: AGHT+IF6l6MqC9OlU7MWRBm8/jilyNyCrD4Vt4zNw34eFnqTQdUeSJpxMCwQnmRmMigqZ2sNu/XjOA==
X-Received: by 2002:a05:6000:18a7:b0:39c:1efb:f7c4 with SMTP id
 ffacd0b85a97d-39ef9466f43mr524005f8f.25.1744908896196; 
 Thu, 17 Apr 2025 09:54:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440699d106csm4068305e9.34.2025.04.17.09.54.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 5/7] accel: Include missing 'qemu/accel.h' header in
 accel-internal.h
Date: Thu, 17 Apr 2025 18:54:28 +0200
Message-ID: <20250417165430.58213-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The "qemu/accel.h" header is implicitly pulled in. Include
it explicitly in order to avoid when refactoring unrelated
headers:

  accel/accel-internal.h:13:32: error: unknown type name 'AccelClass'
     13 | void accel_init_ops_interfaces(AccelClass *ac);
        |                                ^

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index 03426aa21ee..d3a4422cbf7 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -10,6 +10,8 @@
 #ifndef ACCEL_INTERNAL_H
 #define ACCEL_INTERNAL_H
 
+#include "qemu/accel.h"
+
 void accel_init_ops_interfaces(AccelClass *ac);
 
 #endif /* ACCEL_SYSTEM_H */
-- 
2.47.1


