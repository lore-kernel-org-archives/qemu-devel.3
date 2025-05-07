Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75474C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPm-0008NO-0r; Wed, 07 May 2025 19:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPd-00088Y-IX
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:55 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPb-0002SN-Qh
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:53 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so414040a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661370; x=1747266170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgtD9a+F/fV1o8g6sPaSIZoYXGKqR0qNW17PKpxFW74=;
 b=eXXUk4osx3knQqH9LIt9XKqiB1LrhaTlR7s0okWeFLhCOk1NSX6Jmd0Rwio8ZMVAhY
 Y+mYwCWp1DSJMqik+aLS7ofbBRkOAIkmugp/z4rLutIjIQwe+/GN9Mq6aaEpWXZlVZDI
 G735xBvqu3ujcNzq1gDs0NKhnFdc1/Q2ZWwcIt/HTeKfsC/lJfS9LZXBmQ9IEm/rgrQ3
 X2yjHzacePVL0S4ZjT8JIAblU0DU3TbhjfT+KTTj0k7Bp+37jgZBIron99qhv/1z+zBT
 F17yko+fQbAytuNh0TW5NI6y9+DU51EZPNFKPssezbqEmXpHIN6YisX9Noizg30X3aNn
 vjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661370; x=1747266170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgtD9a+F/fV1o8g6sPaSIZoYXGKqR0qNW17PKpxFW74=;
 b=NZvRB1bVAjRtbQpZ8ljmXE6mfD6zVX4hJ8zGRyV+RLW2lQhqx3UGHV5SbpZ+MO7sc9
 sZMkWGWYLxKOYCIhXTD6kSKd5yhG9cdjZbhYcSJU7hP/BEtMwTdTczp7FIAGB2qX7ttO
 JrQOZnixTgPuYBaAlcQ7wqY3RCQ4lBStvhzk6EQWDYOTssvUSyesNto7YC9t0hdE8Apb
 BCCGYnO65vSE5a7LNSaqWtzH3xtVRs8zY+Yex4+z1jsdzewkjTtsb6OOvOD4B2eOZi68
 moRUXxUt0qzP6dj8WGqPhkGA7kemjSiOBE+l+XwUPuNF/Ugq4vDr1PYu1helqXrlZJDu
 H6Zw==
X-Gm-Message-State: AOJu0YwVhj/cN1yRn5hZf+mps7GeqDB7CLtqy9RMWE4QsVB7dyyBQm9Y
 xacwZIwJS5P2qJvie5dboueReRaHkWL6KldetIfBnAfG0pnQM7zWjqsU6D8AwEnBpY589HAYldY
 I54wg4Q==
X-Gm-Gg: ASbGncvRxhuAK7PjQnO3gks2aNUeuwEUAoE83Z/V2s+EDZPfBtt15zQX+pQK3+dcZEw
 hqWgKML7Hb3K8k6Tu/IA2AuaHEAUnw5qOz7kMRtf9Uz6pBQSABpbfLBWXmWIOyKUJ7wTUPHxvtd
 BRVMNrIBGMyiB620F4SmL2LEKSVXwv1B6L+FUp56MIfezye0qOmoQf+qUT/n9XNuxXk+pp4YHOY
 G+d5GyJ2z/9B04EcAHfdHNc7puFSFMXiz8PRRtnRsLzyQWl1ZNbuoyUzquN6R7iL0hWszLYkn+z
 BO9sYMmGKWKfnjGpgGohGxSE732Vilbgz9zZ14C2
X-Google-Smtp-Source: AGHT+IFpfXF464QoGLu/+GuZuBU0TJX3a3vlbSAcU4c68XYKCA5Jxjh3FLDVc+LLIUs1T7RyGLYtfw==
X-Received: by 2002:a17:90b:5105:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-30aac183ba0mr7012520a91.3.1746661370425; 
 Wed, 07 May 2025 16:42:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 08/49] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Wed,  7 May 2025 16:41:59 -0700
Message-ID: <20250507234241.957746-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d062829ec14..b0eb02c88ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1171,7 +1172,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


