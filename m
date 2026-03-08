Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B7EEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMjf-000461-2N; Sun, 08 Mar 2026 18:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjc-0003qR-VM
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjb-0003P4-CY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so17226185e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009385; x=1773614185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+yRRJgECb4/26rJHc/IeEtstl18ywy46YVHX8cCDbag=;
 b=J4mTI9NH3J9r4QbZlm4p2DZ1nnsnkkBOijrxH42Tmrh2bOIW7zdjmAtq50eVZCMjnk
 fkMPqMql+2EO36LFVrcH8i7gT7k1cuy0jSQPS7H+E1YOD+CQ2GNm0X2P3vSoYj6tzpsE
 ZzOUzUiGFDNfRlAgGvb+3/P+YZaGJDJcpTYqUAFDqfN0iyxkVnGmqv3CFiUZO7K2vF05
 UTAHr6OjvBlYGD3uJGoasam6hZp1lca2VGH7SndBDrfbUBDP2KT7L2DF2JReAt6DOtD8
 gfBFJ0Yyc/RGH2wqnZTz9qq8+yhYN9W5hTiL10VF/egBAEvkWx2Dk7l8d4WpDASqwxW1
 o8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009385; x=1773614185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+yRRJgECb4/26rJHc/IeEtstl18ywy46YVHX8cCDbag=;
 b=joO3zMsc2GEYwHpbgBex2HadEQ5qgk+zpRkSLw1jXRbCSb3TXFQf4GY/uKX3khlXOC
 PHlg5nHodxX3VtN0BF1LyzPzUJ0/ZMAdW1CLT34H7D2OiAia/7FlZ34J4gnh+Xgf2Ci9
 2z2wtnr/0d3mDPXap/wFRN7ZhI9pMHQElaZ+JP3oITuCowVhpE2krJcC1+6oaOLksaR/
 8XrnCMsfthyLNlnZ5qvjR7q0hS6bTzoZjXN0C6qu7xKhp79vfYq+GSIEZ4NoaAIV3aor
 lwKkvxAff8xhasRa2KYONmcaOwFs79Y1Sek0ZsPpx8014420jKl6U5LdMtMdYY9qPnnT
 eW7w==
X-Gm-Message-State: AOJu0YwsFjgpEAGZgakE1iBA7fwZ3CfIXXoimcsxdVUyraXg7vmFLnVc
 ooWakOyV5hmwQg6nlN2PawlJCrfXF7clywjuiBro8vJF9A/iWzuG8KUtaFDgp8mX6QDc3kCMsTo
 jJa3FE8g=
X-Gm-Gg: ATEYQzxFeBfX3UpbyvfhPqy+ujNc+Q8/92FDqOvh6Yr1poFsvOIT+AwdOfg/+VrFhGz
 CcMTeT9ubEkD75mMFfROvnHSLYN5sJmnQ2PhCjrWS3uqNBVGMSSvuZznTqU/6MQOnY4OTEarCaM
 VSM0m+8LzKB6J6baAmJsI9Q00CMjS1L/E3NbT1tWVyi6/cj4V8orIlRh6iDERpdAc7ZIL57IV5Q
 U3FcZOx/dnixJ3CmZbpN/vG+x0iqIniVla4ofARyQ/HBKKFGNflw9GWnehmt9pylyJzloh1R7hg
 iSgvhWK9q5sjnwHU2gCpZSjxv/cQA5qCRoWR1NsDwBBLW4uCbNf2e+toER5Rf/kqOHdgyKveVDP
 /qLsEvSXhVPlNRJwd01V9kMHEFi90tnaxd80tuX0n3aPhNWYYo0NqxsksnL1IynjyiDfRkCIAO+
 1GjhoaobWuPpScIVgT5jax3vTYN8S1BZhHiou/AJbmXsXYii+30HGnjvrbl+RrgevimmsS/3Djg
 4kFwg==
X-Received: by 2002:a05:600c:3b0c:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-48526918939mr162944205e9.7.1773009385444; 
 Sun, 08 Mar 2026 15:36:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a946978sm51844095e9.1.2026.03.08.15.36.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/49] hw/i386: drop unused PC_CPU_MODEL_IDS macro
Date: Sun,  8 Mar 2026 23:34:00 +0100
Message-ID: <20260308223433.25503-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This is redundant since the 2.4 machine types were dropped.

Fixes: 4c82e7b34b1bf35d97e026196f5bf10ea916512c
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260225165400.605941-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a38634e3577..052226baa57 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,15 +73,6 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
-/*
- * Helper for setting model-id for CPU models that changed model-id
- * depending on QEMU versions up to QEMU 2.4.
- */
-#define PC_CPU_MODEL_IDS(v) \
-    { "qemu32-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
-    { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
-    { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
-
 GlobalProperty pc_compat_10_2[] = {};
 const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
-- 
2.53.0


