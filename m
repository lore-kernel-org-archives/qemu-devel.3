Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375BC48286
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsZe-0007p5-Tu; Thu, 25 Jan 2024 00:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZc-0007om-MQ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZb-0008BU-4D
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so69801065e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706161605; x=1706766405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlziz7lxiFfxqERLwu2Z/ykkuXDC5BV2AXyrO7ib6Qk=;
 b=VO4ZVAdV+T5IgDe7+YwXwH0qcmoZKow9WlwrquRaB/gTn0cpds4HehsmzHb5ij5pWQ
 XQYWw52OrqvA5ZTC3o+avpGha28q4ZITle4HWcAfPCJb/JwfmMsTrlUp9WlNn7BOlUC4
 2tcpdvubYecwWsyXDTxpEysM0avEQyREd4fRt3fSI/iEGKcqwK6eDHWu+mONXsj6+lbq
 qN52nVd0XDucGV+VD7GFFTBmkiKtHjRaHlCpIuWO/X+VqdjyHk2vyxxRhaE7P91iX1c/
 eVflRhV7A+ZjphldR1Oru38IiF4Uq8UY7dsDmxL9fsjK/m9nKAx7vNGsIh2qVhK37d93
 bapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706161605; x=1706766405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlziz7lxiFfxqERLwu2Z/ykkuXDC5BV2AXyrO7ib6Qk=;
 b=ocMgAA9bHxOghMlEfZbrZSRYq6wKB/LQu7K1goVfHlbds11wlS0G2bnxwsx3gwiI2Q
 f4YkM2SMfoAFevz61uZaErmDmhHtf0ETvpPmUPxycvnyNmP+ptN3TE1bZVhLM9tD9Udn
 3Z4dbnb+SEMvn+0v0OARFwKF0sGr0PMfFKbmbeLbq1aGxm3dh4ZfO7/etSrUf/JGk9O0
 gTQVyhoExLy4eFehttjs5+jVBpe28s/Z4fw60rEJ5iy+wHPCZrrteg7hS7D0tAO9LAV1
 /nih08wRRDQl5KbSLnRlffiZG9U2NGU2jQd99fLeEhqRZcgGalk4eaVnPY/htpXOXRCt
 J6iQ==
X-Gm-Message-State: AOJu0Yzm27rzMB1DAh7wqEycmcFnc2Zvz72y0m7BeDKHllKPV6rEkgak
 QZBNl+1xF9ALsAn9mbNWxz7Xi4znBSDi+k9yjD7FLgHS52sUxAiw/PtLDTL210BYAs0NPqduOif
 8
X-Google-Smtp-Source: AGHT+IF4WCFBQ6l9WC5f/mkJQDUcRKGWeUPKDHww6YOSibDWlKFwhzrzYsDCj/pawaPj4gAaW/T+UQ==
X-Received: by 2002:a05:600c:2196:b0:40e:71e7:b2e4 with SMTP id
 e22-20020a05600c219600b0040e71e7b2e4mr196531wme.60.1706161605577; 
 Wed, 24 Jan 2024 21:46:45 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 m33-20020a05600c3b2100b0040d81ca11casm1215329wms.28.2024.01.24.21.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:46:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/4] tcg: Make tb_cflags() usable from target-agnostic code
Date: Thu, 25 Jan 2024 06:46:28 +0100
Message-ID: <20240125054631.78867-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
References: <20240125054631.78867-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently tb_cflags() is defined in exec-all.h, which is not usable
from target-agnostic code. Move it to translation-block.h, which is.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-3-iii@linux.ibm.com>
---
 include/exec/exec-all.h          | 6 ------
 include/exec/translation-block.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df3d93a2e2..ce36bb10d4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -459,12 +459,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
 #endif
 
-/* Hide the qatomic_read to make code a little easier on the eyes */
-static inline uint32_t tb_cflags(const TranslationBlock *tb)
-{
-    return qatomic_read(&tb->cflags);
-}
-
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index e2b26e16da..48211c890a 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -145,4 +145,10 @@ struct TranslationBlock {
 /* The alignment given to TranslationBlock during allocation. */
 #define CODE_GEN_ALIGN  16
 
+/* Hide the qatomic_read to make code a little easier on the eyes */
+static inline uint32_t tb_cflags(const TranslationBlock *tb)
+{
+    return qatomic_read(&tb->cflags);
+}
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.41.0


