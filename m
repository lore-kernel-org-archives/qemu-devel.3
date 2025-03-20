Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C9C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQd-0003Mh-Jr; Thu, 20 Mar 2025 18:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPO-0002Ri-1K
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP9-00077T-E5
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso26815805ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509818; x=1743114618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HMVcutgyuXMGRqprNJQ4jtFGs2OPO1Jy4KbSNXvsaY=;
 b=BUCTpJnjCxQ7ZSOIDp+0dAim6nSX7Tg88zJCdgov5KDeqOFd6u2eKzcwkNFBkbFzNO
 7TasKNVHJ068hQiESh3xEsnMQb2WBAudAd4ySLNL64tTmY82nbvuZGh/4I0UNrx2Jxf9
 F/Xf2wthc/q87aSuxiYWs/oy3HjzOn9SHTqog4sm6br+Y+Mik06gF9296veL5xC1zd8s
 nVFROMU8Q+xZVs5rLY714HPpCFYCp2JeW05U/rbCG+iAHG4S5NOgAgh9g+bX1O7EPBom
 LcZ9H8YQTfh0RppcwjQSDmQtPzAxNTDhYt+4S3YTYdb8X38m4KHWZg6kX0ya6WpELq7K
 utVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509818; x=1743114618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HMVcutgyuXMGRqprNJQ4jtFGs2OPO1Jy4KbSNXvsaY=;
 b=pIvD7odaKzJlOwiViQTO/VcnNPaAZ/rLgNRpjR1O4AGDY7R0dD3bWtKmIE/Spdk8qq
 YSCi9J+6fzXnYcDH5V+ZQeSa+e4GhTfHh7XGPJAVLxSGLnn9V0TiU9R/d8FzqWy7hUTy
 QCnerlzu1xFRoQk9GsJktxpnUOXw12Jag4wdacH4EXUopXFhcszr5858+MfAn78k6+ef
 mcXXFV2SNwo2QeG+vjfcOj70jGj2u8KCvrpfG2diqfa/l3wh0vI5tVRd7i51Py4px3Cj
 uNlhJlwmFTOjTBxu7EGJTeyVocmH+u63UGB1feWN+b8CV24hPanLbDVcUNbauy3xAb4g
 wLQw==
X-Gm-Message-State: AOJu0YwijtGIU1SEn/9Kev6GWy4M/8YVvrudRmUXOZyMM0mf33LLMgA+
 1jV4k3vbRZXGto7mrzyDtNiuYdwCK/7gZk1repmZztXYdYguVg5CfwGGanhHZ1MlFb+j1/cSrEj
 W
X-Gm-Gg: ASbGncu8FFMgn/r1EZ6f0CdAWS0e2go6GBplr49i7Hb9fBwx0jIg2Z7VJZYd3ZR5G9R
 V8McIgegs000G6V5/awqx0Rl/NSaazlLQXx2gx6C34zjAFDiA6AvMvSJDvfcYOq6qVI3uF5LzVN
 9QBa94XnQ0qtJo11wqUn6Rj9fZGOODq2yuzsen+JkZC8KW+kyVYUbQXMMwYamEd8k1n33H+MFeE
 igc5Fd/Qx3pvAG9Q4EhpizUqpuY+UVzjgHsPgeBl145y0LgGTu9a6fUDCZIwVDRTH9+SfcSXhPu
 z6uET0GEA2KhKrK6Y4k/AWIW07ZTsaKd1JDq0eQ0aqAx
X-Google-Smtp-Source: AGHT+IG6+hbG0wVW/t6Amtifybw7dZc7IOQNafgewk+tDppyXQ5h9nASpMX/jqywf9Wi/q7Dg4LTxQ==
X-Received: by 2002:a17:902:fc4b:b0:226:38ff:1d6a with SMTP id
 d9443c01a7336-22780c68a1amr17451725ad.7.1742509817869; 
 Thu, 20 Mar 2025 15:30:17 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/30] include/exec/cpu-all: move compile time check for
 CPUArchState to cpu-target.c
Date: Thu, 20 Mar 2025 15:29:36 -0700
Message-Id: <20250320223002.2915728-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 cpu-target.c           | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 74017a5ce7c..b1067259e6b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -34,8 +34,4 @@
 
 #include "cpu.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 #endif /* CPU_ALL_H */
diff --git a/cpu-target.c b/cpu-target.c
index 519b0f89005..587f24b34e5 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -29,6 +29,10 @@
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 char *cpu_model_from_type(const char *typename)
 {
     const char *suffix = "-" CPU_RESOLVING_TYPE;
-- 
2.39.5


