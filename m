Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67477C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNXXs-0003jU-4E; Sat, 29 Jun 2024 08:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXp-0003hk-1V
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:09 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXm-0006vD-Is
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-71910dfb8c0so888277a12.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719665465; x=1720270265;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p3Ff167L5PnEkX8Hjv5zeODUS2Rm0iaQ73J60qa2lyQ=;
 b=Y2FyUvxafM1bnRKsHx++CjP5C2v5O3QApX5R8wOWS9CMmgsmpWdyVS8nVVlUe0cCou
 7WLcWrhBx6nWI3FXtugjY/BsBuv0RspVEp7gn9J4mCr1P1rfW7alVfjA/x5HTnbIiIm7
 lb3qqi7WRn2TdA6Li6nsw+tV3YcmFPnO42VhvNrj9GOe9DOFfe+8i7mkxLArrVxXrnmR
 2Pw6jKIMha5Si85vZkbYQBai7lXbzK15QZhRgGZx6GS7HVnutOMMm67arXUGuAe0E/bA
 m+7YEQYFIGJxHQtqUpoy2Y63QvtUQjtonhi2E5kwa/IQo4U/LvWzD9ZpfPM21eR6Yl6B
 rbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719665465; x=1720270265;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3Ff167L5PnEkX8Hjv5zeODUS2Rm0iaQ73J60qa2lyQ=;
 b=qXwT8BJwBR7xcoUnqN2lb0qnY+V2CD1Ny62SHBt+QXK0UWoPGQpyd20j1H+4/bjT3m
 s0MyX68E7WK7T1wlFvYpCww6+FQJPRhqWPDBL50FCHk663PUAblVdmroeQOWHG8TJZA1
 E24Qjmqi1PWAuSPOxzbSvMqbnRVVS/bCgMlpgZEx0V04k6t9y47VxyLJqXwV/ygbdjl2
 daD/88jgUOvveipM9d0lZ2WM9I03LoKLy3Ff63U0qWY3ortA2Q1mWXxqKBGIyJfdTeSM
 7NKSrE/CsCn1TeMs+z6lOhuiysoTuduxNDuUjB1TJO7ETqrfxbkGmRDN6u61bRe2ait3
 XF0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5g5fguk+G+Y8Ufdz4ueyFhWrwJ0Tpq3fQgTrtr58j+zN1y1LDQ5zJizdwlLi32NcvucHbIuOCYamn7H302dJ5YRPnxgc=
X-Gm-Message-State: AOJu0Ywl529esgJXTT2tpF5KElKa5bo1kenv67cABIgEII04uC4yRv7k
 +M7nTl0rWb8Jso908nK3lLRR1jZ/qqEoGy4bTuQaQqDtn/UErlIol3U2Vt0KQEY=
X-Google-Smtp-Source: AGHT+IFCiPS0/8zesPRbyIYow94YbPB6IyyS94I3YzDOLPGWwQAW7sXt9gryc2zlfG/1uWsWHnbXag==
X-Received: by 2002:a05:6a20:78a6:b0:1bd:2f6:e400 with SMTP id
 adf61e73a8af0-1bef624626bmr760352637.47.1719665464771; 
 Sat, 29 Jun 2024 05:51:04 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac1535b6esm31432145ad.156.2024.06.29.05.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 05:51:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 21:50:33 +0900
Subject: [PATCH 2/3] target/arm: Always add pmu property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-pmu-v1-2-7269123b88a4@daynix.com>
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
In-Reply-To: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property too.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b98..0da72c12a5bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1770,9 +1770,10 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 
+    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+
     /*
      * Allow user to turn off VFP and Neon support, but only for TCG --
      * KVM does not currently allow us to lie to the guest about its

-- 
2.45.2


