Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D456D216A9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iFq-0002Vj-4p; Tue, 15 Oct 2024 10:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iFi-0002T7-Ke
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:10:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0iFd-0002Rc-Pa
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:10:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c693b68f5so55686515ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729001416; x=1729606216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V8j0Rike8mx3oALBmIjgS0UXvfO46DQYU32URIbOQzc=;
 b=TLzut0ZXNJKzCiEug39/vuSz/18dh/OuOVFkYhZW8D5OEj7iUuZrtaVXdRc5z7qfnT
 EMxnQ+vLCETee4MONPKIyFNyRg4rXVOgDQ/jVie3xjDZfPcrjV6LMdQjDNrZfXfR1uij
 Gug4QHIJ2P8yit3ah0a0JEDgzKPIGLuLqYmukCVjs1vXcbY/eOVSBSzL6T3FoH3ASMW1
 x3ObWE969UdSS2daeouWRIm/F/nX14jnkXop2NlhJDdFod8pt2dzTIPNZZbgwEdJRKEH
 kIiiqrfdxjNOwsyYcpQufowObcl5JFv0u3KlhXCZZ/tnyC3x8sGQoOVWmT7JV5Qtc8sk
 KiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001416; x=1729606216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8j0Rike8mx3oALBmIjgS0UXvfO46DQYU32URIbOQzc=;
 b=t+AY78pqYtBwQ6aK4WxoOy0mjwW28vJa8ZpCsDA+T1Rl/gtrQbu6X3Zo4pRkEm8mxq
 YRHW4XMX1w3Zh9TtU7MyuU0KazP/x7Uzz8eixezsjbaogmQSgZr/3c8V805QgXVfrOA1
 IAYrJDb6665uY/0CryzE/87kS3DTj8VvP84gNNJmueZekAe0FJpQXD9wVPMxciiChjqG
 4v7VYT2MdFqr7X1WHMcpdUSEAI7c0UJGLz43zGdWVLukiYQpL2SoUKak1tm8Ou2jq54W
 bNVnWYN3PZWwXVTwwc5mQ/GSGtam3MoM8dE8EWsU46FnzueZSxxaHA4+hKCFmayW4iWj
 UZiQ==
X-Gm-Message-State: AOJu0YzRA7K39KWBsH+YhNx6q5QXZ4j7W+pjMwspkqVUEq381IkfeGvL
 H16gTEpymMh0GjctQj3acE3zOZ6dA5Ty6EjDLEyorQASqlDQLvphUhb8aPHbOe8Vottl1GnxiRM
 7Jp4=
X-Google-Smtp-Source: AGHT+IEALZ4lGRwPsu3vbePyV8V1wLJjXDq7v9M2q30mzEvviUWVCQM7hG15ng6KFtEua0gCF5nJlQ==
X-Received: by 2002:a17:903:2b0c:b0:20b:9379:f1f7 with SMTP id
 d9443c01a7336-20ca169e6b5mr210364835ad.40.1729001415628; 
 Tue, 15 Oct 2024 07:10:15 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:3301:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1805cb21sm12308745ad.263.2024.10.15.07.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:10:15 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH] hw/acpi/acpi_dev_interface: Clean up remains of madt_cpu
Date: Tue, 15 Oct 2024 14:09:57 +0000
Message-Id: <20241015140957.385491-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
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

Commit c461f3e382 ("Remove now unused madt_cpu virtual method") removed
madt_cpu virtual method but didn't remove the text about it in the
header file. Thus, remove it now.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 include/hw/acpi/acpi_dev_interface.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..2f5ab5c1b1 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -34,10 +34,6 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
  * ospm_status: returns status of ACPI device objects, reported
  *              via _OST method if device supports it.
  * send_event: inject a specified event into guest
- * madt_cpu: fills @entry with Interrupt Controller Structure
- *           for CPU indexed by @uid in @apic_ids array,
- *           returned structure types are:
- *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
  *
  * Interface is designed for providing unified interface
  * to generic ACPI functionality that could be used without
-- 
2.34.1


