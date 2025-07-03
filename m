Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D8FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHeA-0005Ln-Cp; Thu, 03 Jul 2025 06:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHc7-0003zg-VV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHc0-0000ps-3y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso31026515e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540174; x=1752144974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=pXSINChK9TaFOWL0YhjMZ0jBiN/ZU+G+W/3QZh4QfOTTSpx+9QiaHJw1jjVf/vvqqe
 VKmcSs8IllKYER3ikRmEK1tHjvQ0Dk2SnxrMv89hqaHpIo+qQDnUJUP+qY1+Avmk0+lY
 zmdt3UuQLCgXvESGAkXYvKPtdACl1Xt601u8uVRgWiHBxc9feNCftNXMQktcrJoqPRAD
 uu+jPuymtUBuMGWyeGDfnj5bs+bAa6iU6fE0fPgyQHnmbG+EZQL4OKaTTw8ENlROIOEY
 OuKtUDMYj/Kub++tIUwwOl/KGUS7hhuMZVj2LMQubSlU3B2vn//0gDuCPILr2JBBQmao
 HfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540174; x=1752144974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=iS7Dh+2V+J/XF5x34aGP2exxPu+RsKMs+ge0sgsYpgfxx1CZRz6pbN3jmOYZwYc/dO
 AO67DKQzMCc8U/dLjioV4BwXsWg6868b9eRhTLm2RNDJXgC/CLPziG066WjyO7pH6SJ0
 gRoyhvv3usrU3p0g46u6kK0yTeh1bgpqvbt7ZPITNNh764IkIIT8CXaSdv/6j8vatIOa
 1qQDv/b/baTu6nkPRHzvdwg/qBXRtwrGpxsegv+HHgYxGl4pu0zMT+0C4S36xZLI7nj7
 JImjK0DP+jqSHWm8NAdYRxtcDLddfT3Cff2ci/7JjRxclDxw1Pqc4tH0z2uA9+DRytE7
 9Fiw==
X-Gm-Message-State: AOJu0Yx0nZZc7zhLjNeW0e5lbvTnq7V4p7tTO397tnbMCWoSE8Y8fwLA
 bwoZ8zDYQV6oV9nL/wlDqGE/0KRONEvPzajmSecTr15D5ZlGQejBJ1GpHUtP1ebhMJZxbIyNPwZ
 ceDDVqo4=
X-Gm-Gg: ASbGnculUW8a5aUTZrybaKHm4rvH9bScXtP9LtCLAQXSnEve4KFoUe3jlZFYdvBRZWi
 fd515Uql0hTozKzCz9kunUKSkxfHVwFoYileXE0gJI8+jry5dGMl/OYAAp7mfjukXb9o4v4wTk1
 99edt4cI0MlAPXWkaONpDw74DuHf777g79c/AsHbUWAitWOBb/Su6AT7zMBSjGlKguGOI4HpKe1
 ZC2IAPqy/CWRDCJYI7qBnnP8Iw8ClPGuALYZOANXTF2aLi2DWy0rzmtQEe7MOF/3EHK3P3G85Tw
 Yvyq3hNl+L7dN3aASoYoQ90iWUcI9r0Mok3tmpLlvQZFxLKd9qkDkdcRtM+/vkAiy4qAYgYns5o
 fpa8JGTKHhkyZ0WeQZf9SRg==
X-Google-Smtp-Source: AGHT+IE8CQFMkrSZkVN5zYcmbJcCj+w55d08ptBKiApntCikejet06VTaL7qzyce9VIEA15pyWpTmQ==
X-Received: by 2002:a05:600c:3e0c:b0:442:d9f2:c6ef with SMTP id
 5b1f17b1804b1-454a9c8b12cmr36033545e9.2.1751540173782; 
 Thu, 03 Jul 2025 03:56:13 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcebd4sm23421365e9.26.2025.07.03.03.56.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/69] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Thu,  3 Jul 2025 12:54:32 +0200
Message-ID: <20250703105540.67664-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


