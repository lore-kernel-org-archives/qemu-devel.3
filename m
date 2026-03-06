Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E6AFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWem-0003xS-DO; Fri, 06 Mar 2026 10:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWek-0003tj-RI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWej-0002Lc-9i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso77579185e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809196; x=1773413996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxoBstFzbbLu25I1sKHVFqACJTEwFMHaflSQvDtLx5I=;
 b=XnK99CH4QlaBdBhnrb+F+fCw5s7yuGnbnx5AcSiGQlmP7TYv/UQ77oPQ5adkWVOhqd
 ux8JhWaM5m7dm1/BggwPUUpHtkjRshHLHcGW2Y5yJ4t40oPG8/5Qpe42o0LPhKW6/yqG
 CRN9udRyy1KuU6AH5WqXj4A/+0qvvS/3fa4UDcPJy26DgLLAmu6QE3gebXAuPeMyigy+
 1bck604PRYYqYuJjQvzIw7lLAWrywLlCX6zZdXeNBVNwiW6RSvRUK7gFhUCR5o18RkaD
 yaU09aBiKIAxo0aXt39UesgBD5l4JaKVScmadoUFhE4wS4s/88GogwZjS63pkDHPZA0Q
 IpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809196; x=1773413996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wxoBstFzbbLu25I1sKHVFqACJTEwFMHaflSQvDtLx5I=;
 b=wPAcgx7wMLjihywHBzfo8RWkiNR1HfQN6EsUoBQja2ts4zA+7LzX0PgGhv76eaXwZ4
 hHzis+JqsW5dlMLl3C9Ey+jY5GUzC8d/XS1rPbWIpYRqmg4rt/BkhOaQzjUcqP5IKARq
 zQs3cm6tz2Ot7c4F+dk7114kqTfnE2gTx7ByIzTVFdssfLBVnDv7uTFxKi3C8kL6cBOb
 ZwLp5xaPwSKyMzLsFPnNcyC4/zj9S0FdoI3j44X8ysneK26+35EeovTMx4olu0SHOe1p
 PNibT9L70xFQMZlKOaPyA+J/5bTR+7xSCRj2jN5GDciTmJl48X/Dy4fQnlscgFrAoQeo
 Llag==
X-Gm-Message-State: AOJu0Yyc1T6u+zd57E2yyJlkyhE0DSRJO6BQMLi7SdIe+E/q1uc2QUzI
 m+fQXP2orwG0KNgugmGCH3PxQh3ieCC8qCdmaVrVLV4W1ZwrMu6bdk2V+pWO0kYhlfVCEh7E/D7
 qFDmF
X-Gm-Gg: ATEYQzw6CpTb69KgcIUGmqwi63F5TISNgWspB5DjsbPJrKspEY27YUuQZFmcuBQO/yZ
 ta1GvZEW7sC8ua6JYQh99I4kxUn87WIZB8yIiqze8l5hXrthPR7t4rwCKM/rvoXcWJu7XHo7C35
 DfJnbc2wmE4polLR7dWVLTmg2JnKtS+eGhFgTXPV0n+BiAlx327+SBI2g+YIBJHatAdboeWTXIb
 Jai5tItuxOKk6pERkxJ8xPx7XvosstiiDv1K7j2ENWo6PMbQ6qvO1vKR4G+Gf5e8RUIs7lOfL9D
 l9wv8i4GZTCq2T5WbD1dnopf9jmwZJem2d1I7EygBUQxo60mbpC7Z1B7xTdwTiVb4XmVU7PIZPA
 Q5lqLU6E1Hc5y09raKnWNYr8NAmQw/WelE92UVroEXAgHrgBPo0vgV24uSt5PXhbWfE6xfBLP91
 OZhJmXrxD2R8UkVVymujtqJla99UQV91KBOlwB2bcgWQtZhTCA4KCf+wSnZ6AjifvrrdQl9Yl/y
 U8afhobEx390uhcfojfAIgtnlUfCJc=
X-Received: by 2002:a05:600c:620b:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-4852696d451mr37899765e9.31.1772809195884; 
 Fri, 06 Mar 2026 06:59:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/49] target/arm/kvm: Export kvm_print_register_name()
Date: Fri,  6 Mar 2026 14:59:06 +0000
Message-ID: <20260306145939.2162189-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We want to use kvm_print_register_name() in machine.c so
let's export the helper and implement a stub when kvm
is not enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 2 +-
 target/arm/kvm_arm.h  | 9 +++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 169ef5f206..88cbe8d85c 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -114,3 +114,8 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     g_assert_not_reached();
 }
+
+char *kvm_print_register_name(uint64_t regidx)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 555083e7aa..11f6f2dff0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -970,7 +970,7 @@ static gchar *kvm_print_sve_register_name(uint64_t regidx)
     }
 }
 
-static gchar *kvm_print_register_name(uint64_t regidx)
+char *kvm_print_register_name(uint64_t regidx)
 {
         switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
         case KVM_REG_ARM_CORE:
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 82ac2aae46..e7c40fb003 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -231,4 +231,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
 void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
 
+/*
+ * kvm_print_register_name:
+ * @regidx: register KVM index
+ *
+ * Returns a human-readable string representing this register
+ * The caller must free the string with g_free().
+ */
+char *kvm_print_register_name(uint64_t regidx);
+
 #endif
-- 
2.43.0


