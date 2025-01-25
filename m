Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B05AC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiT-0006Xn-V9; Sat, 25 Jan 2025 11:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih3-0005Ar-MD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigx-0000o1-NP
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso3029461f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821242; x=1738426042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDsGnhplkgqT/f4agy456szrFVjRVVohKrpBFsRKCFM=;
 b=xCLG7wXNIxaAcdV4oUHmSbZE/aqhyt9/vHldPn3M9Wz+yvd+4f9shn9CcdMPRvNbhk
 +W9NT2SUjj6Z6Hz5ItCeHeC74SIpxZDTJLpfmwL3XqcrhK9naO4jZ9A5QtJI/Tav4hPb
 zF1/CXG56Na49s90dfeW2QSdPx7+H7ckXAWV7Qjry4CqJqQ32MWVMdY/7j6ZEBaeJ0bP
 KTLttgMtJl9X8N7zm4zqaQ+/9fBrnkHzFOO5zpfayNml09RldGPgdt8csVGUBb7992AY
 e4CqH/DPBaio/SokAMPWsC895q6SoPT7JVoEtfFgcgR1fUFaddnTv0sSqlTJq1p6VbvD
 X4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821242; x=1738426042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDsGnhplkgqT/f4agy456szrFVjRVVohKrpBFsRKCFM=;
 b=bBMkCe4UXqOZCYyMjrA0FPboKq/zV5rSbam/PL4DWQJ52JocV0cVuEcw9RAdPCfB3C
 Ox+VbDy+UCv+mJICa+G1Ehu356VyW+BaSIrNZJ5ixK0PNDcnc0wro5F/vkbMcJA7wM65
 LILwqzExSYtgQvpDY/nOcsbbKkwOI9Do0fXg6htggNGDC8lXa2IJuTQQJhj+cO4rQXhn
 t7uEKKqiB4is0VrLpNOijhem7nMk102+z/ZWvc560+KQD4unZjxxrbpHdp+O7X35UTSm
 M0t/3WHb2PXgkN7UwiQlffamx1jDXDOUoZ1DRNBQvONiVTYUZuQCx18D8tlXxft7juWi
 Sxfw==
X-Gm-Message-State: AOJu0Yy9RTHfB0VR/RBURU6w6D3Dyoor7DLlposnMoqgHGyEqcy8mZiH
 YAkiwP5KK7A0LQkdGeSblOoSJCTKb8Rb5+icMZbYfBkzLnTcBpCcg8IbIpdQpVfiqQq9LOldbvm
 d4yc=
X-Gm-Gg: ASbGncteRNB8fqnpooQMrXw13G5/Cy/wZRNx9g/twtqxsiElY0rpDJ02T/LiJKdk2Tf
 dPn/SgYYjXLvkTys0rn6gAsPpy+ArxK4fGdUIvoE0RWIBUBFEVRVEWH0Yt7CUGciRemZBlW7ne/
 FFgeHOGVO6ScNYY0Zdf6BdVR1yTY8xDCsWwHh5ecN+0kECTm03TwzNtBjxvh7Fcj1Ex/WiACWQC
 a+5KrlkYIg+6D3KJE+3HgXzwmJaE35UUXzXgl4iYUobr5ZztiEqqI1u4iIoGfAqfXsvJrQFloBC
 rrP0GFSxBYKi/MuBOV8kml36KgNYQtS6EYhwuNpj/LuZit+1AtdUwNCojqkV
X-Google-Smtp-Source: AGHT+IHgrXlWe0MpSqPY6pSVu0ECjDs95xLyN659PlZB+CQUMCn2qd09IWEKr84iEcsUwM41BkWLew==
X-Received: by 2002:a5d:648a:0:b0:385:fb8d:865b with SMTP id
 ffacd0b85a97d-38bf57be4a2mr37116557f8f.48.1737821242172; 
 Sat, 25 Jan 2025 08:07:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c3f5dsm6030927f8f.92.2025.01.25.08.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/24] target/s390x: Restrict I/O handler installers to
 system emulation
Date: Sat, 25 Jan 2025 17:05:46 +0100
Message-ID: <20250125160552.20546-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/s390x-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a750e7a343a..6e2c98de97a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -356,6 +356,7 @@ void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
+#ifndef CONFIG_USER_ONLY
 void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
@@ -373,6 +374,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* mem_helper.c */
-- 
2.47.1


