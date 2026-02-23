Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D55AEC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKh-0002Pw-NF; Mon, 23 Feb 2026 12:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKd-0002Jm-IS
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:51 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKb-0000Ez-Mb
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:51 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48069a48629so47254085e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866168; x=1772470968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2cboAhFeHVHRYQSjMCx5mj0gc79Tc2QBuh4TMC+EX3s=;
 b=Efg8Q+WVH1W77D5YMiu/m0qADogdR8LI1wEtu+TEHZKPOgQhXwJzYkJAj9shdf6rx3
 CNe7ccygdvatoKAbISHcH8TxPcysbvrLKrGBEhbezwIu5iJ8ATfMswrAWIJ5hBzP3S4s
 gxX+8oI8FKXR6rXJ2IacEex/VaaslSLaD+9Nm/IOgIRvI1QJIe0w5Aknew8paGpXuSiT
 D6RrOm2wmbE5Tb/SWS7vSwnnqowbf16HxenVZDqBHzEi/Gbd6bawqzce3oPfmR31DjHg
 qc9Abroy+6lVTBpmT2xsOeB6S0cew8YxdPkkkT74IEh4Gop3ZdXflYLz5OegCKJbl0qv
 vaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866168; x=1772470968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2cboAhFeHVHRYQSjMCx5mj0gc79Tc2QBuh4TMC+EX3s=;
 b=PMN3jib55ssSKGjl/b3yn4rDd/zyMQKTFE/JsCUNxxWJTjBR98Rg1RkFVGkRxx1hzB
 dRRtqP698Ejby0RS6/M2ER8OuGajI0xTRHLN/KV0FSeWHi1S2THgTtkcWqapTjyjagtI
 92mJ6SRrAbYSNQhixxY4mn9fx2VpMSfPbaseTyWZywa3NGGgQwz7w/XfZK3v1wRBCu40
 +eQi4L/EftYedIwmQy5ZELyt4Fj/m7mMrQEK71Vt/0+2OuLwmICd3gE6eCPCtvxERNY1
 pV4AIKY6QQo7+SOfEBXVek+jgWD4ULHnSk/eGl7JIcIe14awVCNvnlRiMjJENHq6xZuh
 7VMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUebxlx4TIDo/zKumH1Rz+wCtQ1g2ZsGhScejjWvTFOlln+T64SN6LHVcjhLZ24U42dVpPHVTY5KUy6@nongnu.org
X-Gm-Message-State: AOJu0YxUXPhlbOoSkp8jbuqBpXUsXHcW1UiU6qOe8RHccs2LLWxT8URr
 8pqBM0VGfWnaSbjv+0tFU6hYDKWdvbgM3Tn5BoP5HsyCDDMljNCGJFI44/1pfrp7xY4=
X-Gm-Gg: AZuq6aIokMJ4pNXb8VP9HRsdgn/ulxEZt7LU9ISoSw1uqTsushE0vstKh5ua1otW8bA
 IB3pl89lWA/Tb1RiNJ1dCoxVf8V+c6lwdKXgJPOXm+KBZfdHLfRprTIsFHrs/1k9d++0fM/Aco2
 J2g2VZFnRdJ7+chop8J+QhPMCSRcw65rg1UlX1KxArJUdx3NXradnJyy1EAJhJz2eP7I+rgMrkA
 re+5sFH6Ef+SkMFnjI3+sHdW1oDCtP4MUAL8rRMV+9M5Gs/+R0U4ONP8LZF/w5yySRkiv3Tzrp6
 E4E+C11txt5lJXBVWeGjAardP320ARuXjyeZBd9PT3oJtPVGh7NS2U+ir/CLwUzP2T249sujTk6
 R83pVFHqCXsR1Wd7D0yKz1cDsX2LW++olK2Xju66qUDfq9G2A3cJ5e3875fjOwfhLs9/u7MU+qV
 K7WB51fFZXaVr7c3XIZFdN9SeYOqLIcBgU1Wg21jurFqOF/3Ldewauxp6s8yxYGp+XR5qdfGhkO
 YH5mqlCUbNuEQfmpjandl5OTJVMuSAPC3KucJI18Q==
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr166518165e9.12.1771866167675; 
 Mon, 23 Feb 2026 09:02:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/65] hw/intc/arm_gicv5: Implement IRS_SYNCR and
 IRS_SYNC_STATUSR
Date: Mon, 23 Feb 2026 17:01:36 +0000
Message-ID: <20260223170212.441276-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The IRS_SYNCR register is used by software to request synchronization
of interrupt events.  This means that in-flight interrupt events are
guaranteed to have been delivered.

Since QEMU's implementation is entirely synchronous, syncs are a
no-op for us.  This means we can ignore writes to IRS_SYNCR and
always report "sync complete" via the IDLE bit in IRS_SYNC_STATUSR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 5f4c4158c4..d0ba8fe669 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1047,6 +1047,10 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         *data = cs->irs_cr1[domain];
         return true;
+    case A_IRS_SYNC_STATUSR:
+        /* Sync is a no-op for QEMU: we are always IDLE */
+        *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
+        return true;
     }
 
     return false;
@@ -1132,6 +1136,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         cs->irs_cr1[domain] = data;
         return true;
+    case A_IRS_SYNCR:
+        /* Sync is a no-op for QEMU: ignore write */
+        return true;
     }
     return false;
 }
-- 
2.43.0


