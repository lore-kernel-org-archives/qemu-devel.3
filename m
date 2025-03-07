Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DC0C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdVy-0000xU-0V; Fri, 07 Mar 2025 14:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVj-0000ur-Nc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVf-0007Wb-Fr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:30 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so1438601a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376246; x=1741981046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=glPlM0CLgdTTJzCYQSUqfKBKnnU7jFXVlQ0jeBOhtK6NI6SnIaPEaJbtK8NwCI/42v
 l/BQbSKp+sO6s9169Z0MrpcaUwSKxdKpW1nq/EFFe/6auZnqemh9ch5vMSCq9z2SyzB+
 kx7BgFh20ETGlh1TYPAenceOTKWTog9nTwyYeVujlmtiMMnI6ZAS+IyrGUBLzCKfzE/W
 Kp7beFu5DJKFXSR2UO3fuQ24ZdMSRpeSmHpiRG8mZ5RlfNbFhFbUMFj4ITCdzcJVSyq6
 Gs6th6AuJMaUIfOgOS4zvu9L8n+IJjo67MQLSfA6AO9UVWi3p+n2uKlRHxBc80oIe0lv
 TyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376246; x=1741981046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUvuEjETtAwgjY+HHVzD3fRoYrhNXj1rMDKPunM+tus=;
 b=HeA2KVy0cO1JjLgQdoZViTwLkZ2f62FDAr3cSmK9kub78NRR7Z4Ok1z5AWno9m7OCw
 HVhQdFFkVufmU+UZgdCj2EhcxgEH/wcY1GlykoIXHqEW7a8pag8j0aNJrUbXIP/Mt7JQ
 G3w3wgbVvvNeIeHVDSALcAqW4yjcMknEqSzg5WOYukgmD9bWrLkQ1afj3NVah+XLodUD
 n5egiWD8PG3ulHjlkvgJ0kLi7kEYk0uEWYl0p+GFBEqcihj4a+ZCuZWp5g0ZE1YDRVM7
 hAWTfTSDg3OOb4pWhzS2/IoTw7Rg0li73YOfzqVVbJyzwiUdE7oZk2BAlBtLNS4ufNkz
 bXog==
X-Gm-Message-State: AOJu0YyhB1lXGwv+oHcyKCeQ6oBF1zzNcrFXH4/0uouj4BPIbXWsgJjr
 ydkZeUuuYl/9+xmtghhVF0TSJmvoLm6WvKLvCDLB2ehESiwNX1bLECCScCJkZMjyG+XOw/K6hrX
 f
X-Gm-Gg: ASbGnctG3TDlPrmhpuSWw28USg1+ROEPUxk0nhY/EovoL/k80QacBTeXJ4vt9bgZgTc
 pWBRek3Ud2kDwqpXFxmn5TfABavKijUe3Onu/uAS7nLk2KTUtQDfmSgDzgVpl2w3acufuUXrHq/
 OqCxKsloK6xrsUZo0Wq/YF7AsVDSs5zdiWoffWCU+SwUlZjnpjgbiSAUSDGK5/yC8nqXa7xrOcf
 IWimzLTMma3hkLuP/m+TtkOyCRiEvon8q+/GchokvN0GGKcX5f6YMCc29nX1MKPWnwd5H+vQIy2
 ZvXBicLwEzesxI3jRGdgCBXzNYu3EkYkNVp4gGmXsVCb
X-Google-Smtp-Source: AGHT+IHZK5ChSqOaMo09JMNQrhVS25wP/pkCSoEVH4/5AzuwGO5vlGkUiG7MGthTlS3QETr7obULIA==
X-Received: by 2002:a17:90b:180e:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-2ffbc1ee5aemr1105732a91.16.1741376246136; 
 Fri, 07 Mar 2025 11:37:26 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition from
 target/i386
Date: Fri,  7 Mar 2025 11:37:09 -0800
Message-Id: <20250307193712.261415-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Allows them to be available for common compilation units.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
 target/i386/kvm/hyperv-proto.h   | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 4a2297307b0..fffc5ce342f 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -61,6 +61,18 @@
 #define HV_MESSAGE_X64_APIC_EOI               0x80010004
 #define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
 
+/*
+ * Hyper-V Synthetic debug options MSR
+ */
+#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
+#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
+#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
+#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
+#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
+#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
+
+#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
+
 /*
  * Message flags
  */
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 464fbf09e35..a9f056f2f3e 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -151,18 +151,6 @@
 #define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT                0x400000B7
 
-/*
- * Hyper-V Synthetic debug options MSR
- */
-#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
-#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
-#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
-#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
-#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
-#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
-
-#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
-
 /*
  * Guest crash notification MSRs
  */
-- 
2.39.5


