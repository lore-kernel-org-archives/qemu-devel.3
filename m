Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16510C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUt-0006qJ-TW; Thu, 03 Apr 2025 20:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUo-0006cc-JR
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUm-00037M-Hi
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso10274005e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724875; x=1744329675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWPNe4+0o3jNGntGTD/pqvwzUx9TsuQYTh/1799akw8=;
 b=c56lhAZg3en+4gKw4ZlKwG/8Sde1uafQTK8QldJwQ0S77QlgYynjspBa8DQQ2sMuCi
 Z/6qjDUFKo4A8YGkd6ijRvzj6POOxID8HVRIi2zLil9LEVh/MZRMplS0zg64KtBRl6Hi
 8lAklcitrWQsBjgpV74GLnpKjnOXhbRYjxGJ7LgwKX3dtkVb9H/xwGQZrrKZ22YFPUxx
 4CuEa1dfFXP90AjWMBOF0qEwywnSFGa2FlKMt7H2fUxP+K26QxJQ3nJVmUY3klRllJI9
 N9OBkGeTBVo79Uqn5+FjEaT9LQn5h3/9tBuTdMIowKYJbK0RF3/oOqUWqsJ66ov7Vg6B
 UVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724875; x=1744329675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWPNe4+0o3jNGntGTD/pqvwzUx9TsuQYTh/1799akw8=;
 b=M4/5eNA7Ms3zGMpZ/7hd4qVTnE/eqqvQWI53lomZZNN3UsDJ9WoSZ2bnib7qNyWqvG
 Zl0Zz1i6U9POlRB4bTwVp3TZxixzAM7Yeu5PLoUBSTOPziI+Kyb+hHPDIcuaIS+mS/E+
 0yAOo6a4jdBq5SnHq4UaafrpT+mUeyIP9p0ohetmdbqCvxrky+VJ7X55dbuaQNYmLxnD
 scEuVT5g1sec6acCVDxHou5m8bfTnBY6ePESx8zSL+0wQhBXykqpeq7UxsdkPIQ87uWf
 iS+HyCrGLrUyHqSHQIDSjPPYhFdcglCV8EYPoq7qcpjh6vOrz+grBIakdaFUHN6PsHg2
 oVIg==
X-Gm-Message-State: AOJu0YwrIEt2fb5nrTR9tCP7bZcJvNobWWymLwVBZ7yx5RPp9VAsQFBX
 mfkUHHqKvdeAJLARREZ5PpDakSi8hgLVn+aDng2on/LVwgToEG9rcrHM18zFi/VuHz4SsGVxFSQ
 v
X-Gm-Gg: ASbGncu3KuKBIzkxHc0W69j6G+GrSHwGGVEILaTOcaAPTpBcdiMlZfJvObtEzg0V+H9
 Phbcyk0sQy3ohnB35QilMb7vnnTsuAaTV1tW/zOLYecp5Rce6QdWVzlCBrGP0Gb1ObIIE4tzavl
 9JCvyHQcPOTnjrkfYGcJI28EuxsTOpPwr4BSADdxPyJK09rNQM0FaZ/5BfjzNSANlq4bL3Ki2y9
 D2hei6Ya3Mplz60+/hymRJS9Jv3GMRevvH3ERWbW0wbT7FqZCzMY00SN2ZbkjDUT7IurQINUveK
 ocQZhFIG3qEMlKBEPgeHWrHumVBBWfAUFHUz0BL4k0rLkcMACzxahuaKDro6mVHISbpWQDp/oiw
 pahwkvjG1wIA2Nj82NLkf2u2kbE7fhA==
X-Google-Smtp-Source: AGHT+IF/zRKYnBNIIkfCINSCIQ0U4uDAq1IY8mpKDphwFHO5m+SyAMnh2nl9+pv5shFPKaRuuFoORw==
X-Received: by 2002:a05:600c:4f0e:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-43ecf9c3e53mr5270745e9.22.1743724874635; 
 Thu, 03 Apr 2025 17:01:14 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d943sm3004749f8f.74.2025.04.03.17.01.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 26/39] system/hvf: Avoid including 'cpu.h'
Date: Fri,  4 Apr 2025 01:58:08 +0200
Message-ID: <20250403235821.9909-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

"system/hvf.h" doesn't need to include a full "cpu.h",
only "exec/vaddr.h" and "qemu/queue.h" are required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf.h     | 3 ++-
 include/system/hvf_int.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..d50049e1a1a 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -14,10 +14,11 @@
 #define HVF_H
 
 #include "qemu/accel.h"
+#include "qemu/queue.h"
+#include "exec/vaddr.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 
 #ifdef CONFIG_HVF
 extern bool hvf_allowed;
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 42ae18433f0..8c8b84012d9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -11,6 +11,8 @@
 #ifndef HVF_INT_H
 #define HVF_INT_H
 
+#include "qemu/queue.h"
+
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
 typedef hv_vcpu_t hvf_vcpuid;
-- 
2.47.1


