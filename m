Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5028C07C79
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgm-00043s-BD; Fri, 19 Apr 2024 12:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001HP-GM
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqee-0001B9-BK
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so1530773f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542399; x=1714147199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3JoLPVQQvT5k1rWnbAuPJlJNM/iQBnM7RUlxuCBbcU=;
 b=QrjAZlgdKTOMz5j+Feqy1hH9c9e28jzzjaedF2IfvpHIBsAm4RhJ4XGfY1GGb5pluJ
 R8REHxE8cpUt+D51vnCOGU4hfksjYf9bb+BASIVTryz/7SJiT9QvkGm2+qasw5AjveKO
 877RXRJ3LwRsZN6zifIq/VkY/AT1PauQsroQpP/firmWmA2Nmhs3lwjgiPBfzOp7TmZB
 Z9pr7Qodj3I/BBg2te8zUdaCHUihzctWkSOv5bC+6PCJBzCeYv39WZFEvz8WopB+ijM1
 EamJ50ryI5+iIJjtgg36m+FvDlKcsm78GyJmE51zFIiW+mjhhuAUWM3XXvPTwwLUD19m
 Zjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542399; x=1714147199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3JoLPVQQvT5k1rWnbAuPJlJNM/iQBnM7RUlxuCBbcU=;
 b=vdYdyR4nMIc7WWrItEnsEJJ3mu2tG/SFl8w5vw4v3yfOHvGo6vB0zO/t0lGLFdfayR
 9K7CSeCQ4HZMrmXbSzMAl5BkYnGA5vSE6hcPzbFqx/bSX2+uf64jsXRJApU+MDQypgCN
 jX3CrE4M1kaFek/D+3wB4jmGnkLh10oKJWicefgvZ+fWfND8Xu9ZvEJ5nLvidiAS79EQ
 K23cnt9pM+oFAflD/AtaXoe76BAv4NfzobWHFlN+8QNgOcrRspO89ozj8EPdLm83eCy1
 3o0qgEia8P4rsA20tzW/hOIhpR3PrpwWaivGDKRsWRIrQj/JEaHWIAnFFlSE/jhSve5y
 2eTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU16t6pQhEBzwJc1zxchQ0NyO7K5y1iAghgnlVRNlSj8WkPDvTjThTLp8766C84Vebr6CObAts3fG0gdjMRsYVeJyVPwrg=
X-Gm-Message-State: AOJu0YzDUXcvA/WkC52R6vgQhnfcIsclGv67WO1ok4TCF6o4ixSJv/oh
 TA8k53I/VBG6RR79jZXuLz7rdXmU1BUpkvwRJLOhTg9JI0RnR9zlTvEfNlNBNQc=
X-Google-Smtp-Source: AGHT+IHnxptXvLJAPUL2didr1nfepWS4oCESmrqqIlU1k9RReNLLbvyLdOAWHLHwb9pBReExK6Cq2A==
X-Received: by 2002:a5d:628c:0:b0:349:cba9:572d with SMTP id
 k12-20020a5d628c000000b00349cba9572dmr1732749wru.54.1713542398799; 
 Fri, 19 Apr 2024 08:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 18/22] target/arm/kvm: Disable Realm reboot
Date: Fri, 19 Apr 2024 16:57:06 +0100
Message-ID: <20240419155709.318866-20-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

A realm cannot be reset, it must be recreated from scratch. The RMM
specification defines states of a Realm as NEW -> ACTIVE -> SYSTEM_OFF,
after which the Realm can only be destroyed. A PCSI_SYSTEM_RESET call,
which normally reboots the system, puts the Realm in SYSTEM_OFF state.

QEMU does not support recreating a VM. Normally, a reboot request by the
guest causes all devices to reset, which cannot work for a Realm.
Indeed, loading images into Realm memory and changing the PC is only
allowed for a Realm in NEW state. Resetting the images for a Realm in
SYSTEM_OFF state will cause QEMU to crash with a bus error.

Handle reboot requests by the guest more gracefully, by indicating to
runstate.c that the vCPUs of a Realm are not resettable, and that QEMU
should exit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9855cadb1b..60c2ef9388 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1694,7 +1694,8 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 
 bool kvm_arch_cpu_check_are_resettable(void)
 {
-    return true;
+    /* A Realm cannot be reset */
+    return !kvm_arm_rme_enabled();
 }
 
 static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
-- 
2.44.0


