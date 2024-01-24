Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70078C47DDC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY7b-0001SU-3Q; Wed, 24 Jan 2024 02:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7W-0001SH-Sj
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:26 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7V-0005Sj-Bc
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:26 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so4390194a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082984; x=1706687784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Drmyx0qOiBJ43sKodMFw/w/dHE5bFgKE64dzRkcfNQ=;
 b=Ivr8NvxFdNyxe9zIYlg8y3HCo/4CYMAb04NjFJy5vssEC0rcuz63QH3zMNC9nU68sw
 jVtOAm3atgrfqlBwSb25S7aqoVHFU+rAA5l/yd1Dgco5IxVJn21JLwFqF8TVgW3LbWJp
 2l3Zzw6imSJQkQMInF2iM4MN32d7CpmyaZ6c1/ulK4xlh05wS2vUdU+7+3aWSHhrOzhr
 M9K7okqLwtlvHru+/UAd0sFK5harHx+5sNNlpw0quhYAIe0Fygu0a5lIDeRRpysI/nCp
 Ti8Y4Q5cnmJJCDmNJdLkRUq7PcNIHgT6rJs5axXv/oMB7MTx77f6YcvOvbYjjPAr9JK7
 YI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082984; x=1706687784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Drmyx0qOiBJ43sKodMFw/w/dHE5bFgKE64dzRkcfNQ=;
 b=IqekxSB3yCtAhGpE1bPIl0N3U0DjjaqIeCGf1mDy9z3KGqLOr68EOvmgx1OjpeD5pu
 sj9H0B/gkxi2J5NrBhJHoUT0vT4OGjosWpNnwXZz01zqSOpfqpIgcLSlwjebTckkQfNa
 rgwSaRLVPQhQbNmgFXIkhTbjZZmb2QaUWfUM5bXgKMstLn2f24wCBNTI7zp35Iw5xDES
 SOVGJ4cK+davsYqVYWu5v9p5gdtjQoBVeoAJXjqBbb/Lck4F1ye5AfANKrjRHdxyE5+o
 NAKxehjCiVg0hmnt+TL0/X3bj1UX4nCKoJf9uGm0lYS2XGM/eeU7yUxyEsrmCPPoumW7
 KXmg==
X-Gm-Message-State: AOJu0YygGjR3PUEJl41ghQ+s/qz8OXJ5RrpvS8byFJ+JNzJZZBg140cX
 XtawQ3d3kfg5vA8jvnKD/4uzMa1NBAHB+G9psUm1COsD/xkrKmtN/2z46DW7AqgIplyKc+cwrsH
 o
X-Google-Smtp-Source: AGHT+IGebS12DSjWa+nYFru1lwOfdASfEGoBpaQPtZfPqwqEelBkQFkV5JPj77pgp/db5u4iALMJ9A==
X-Received: by 2002:a17:907:8b95:b0:a31:10c3:ecae with SMTP id
 tb21-20020a1709078b9500b00a3110c3ecaemr233942ejc.64.1706082983578; 
 Tue, 23 Jan 2024 23:56:23 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906274d00b00a2b608ad048sm15118462ejd.28.2024.01.23.23.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:56:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/4] tcg: Make tb_cflags() usable from target-agnostic code
Date: Wed, 24 Jan 2024 08:56:07 +0100
Message-ID: <20240124075609.14756-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124075609.14756-1-philmd@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
Message-ID: <20231208003754.3688038-3-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


