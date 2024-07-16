Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBD5C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdY7-00060H-0i; Tue, 16 Jul 2024 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdY5-0005yF-Vo
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:38 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdY1-000200-Ks
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-75cda3719efso3005460a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118512; x=1721723312;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UCgdSp5pdNZ1XKq3c5okiNiCxhoyMDPUd6RYSX/QMYw=;
 b=MGAyWALEFzy5i0ZruckUoeIvN5q/xNfwaPCgJi6tNR4YVJV4t/gbSR95W6Qg08yZd0
 qtL1M7XBrk+xPnuhgWvP/STy5JX8NqWH4RyrLCuzCrzunTW06vlXrMFDGJzLGpg+burk
 72sqkdTOkJ4gSZSCqtFqWvkX9vju9RwttQTmtZBkegWS153CP8HhNjDrQS5ru/5xg0UB
 RKdSlVabKSfrmhCZ8TrtnTfCb03BLG2D57WZEDU6pcJDEuou/POHgJDVHr++94cK/Y2Q
 mZFbO4BabJDcaQM4V6c2y65FZcio41MhHCEy4imfkqbyg5JmWOiG/c6zq6Z0b+A3fxVf
 X5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118512; x=1721723312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCgdSp5pdNZ1XKq3c5okiNiCxhoyMDPUd6RYSX/QMYw=;
 b=emYGC97ROb48X5U2rsrmUMS6I+CTK3PLtHF6JJA0AytSGrDGQAzRQ6fraAe6a0qfUO
 ZmDe6TE9SUFVe6mNfrbhp7OUQNtHFTN5fk/6vXHOnyxzUNjyDvanBGNI7PRSsnih1ftK
 eke6JmrRK7jDmGAqfuTnxn2Fc5gKBrEDG8JzkwVl5Lq7AuRs4XDckmEhpwvlK1ijNaTF
 wq8WANJYsSy/qwQIwOl5p8vqrU/UGom5qrfBGGT9L4VmhCfmCZFKFub3NxDNEpQB/YRA
 hrPQ4R/Ukhk8qs+6UkTPobPjk3Os9yJdwThWHok0rtK/2GqEMnUZUvhVqHWb6Dyxdxe8
 L8bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX04GRIFCjDRCZRLYuzco1/ZnFkemutf9+C50zLlTUaBS/D1wgEvDLfeKRtHgxXg+mOSbfdCWlTx+xE5M2D/gG7Q9K9KRk=
X-Gm-Message-State: AOJu0YxUj4CNu9SToHjrvQhCNZB1T/NEqbdH6WWD28PEnpMrSBQIaxbK
 yurlQHddQub0q6CW8Px0HU0QLLU11U3Wk1ZJyOXA7yuBGqhmAi3D5HGi1bl/Kg6n4tnm4ehDXvP
 sGaA=
X-Google-Smtp-Source: AGHT+IG8ytNrN8j4Va7eZKqyNgFYDSFIbUseO3QJ7+TSFiRHQD01HvT+TL46FEhGt6SylN1T0a/n4g==
X-Received: by 2002:a05:6a21:99a5:b0:1c2:88ad:b26d with SMTP id
 adf61e73a8af0-1c3f129e50bmr1720884637.48.1721118512001; 
 Tue, 16 Jul 2024 01:28:32 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2caedbdb745sm5712692a91.7.2024.07.16.01.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 17:28:15 +0900
Subject: [PATCH v2 3/5] target/arm: Do not allow setting 'pmu' for hvf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v2-3-f3e3e4b2d3d5@daynix.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

hvf currently does not support PMU.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8c180c679ce2..9e1d15701468 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1603,6 +1603,10 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     }
 
     if (value) {
+        if (hvf_enabled()) {
+            error_setg(errp, "'pmu' feature not suported by hvf");
+            return;
+        }
         if (kvm_enabled() && !kvm_arm_pmu_supported()) {
             error_setg(errp, "'pmu' feature not supported by KVM on this host");
             return;

-- 
2.45.2


