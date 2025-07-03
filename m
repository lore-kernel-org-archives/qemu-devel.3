Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D7FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiY-0004F4-I1; Thu, 03 Jul 2025 07:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfg-0006mE-Sw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfP-0003WH-IT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so5259653f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540385; x=1752145185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvjGPIKQGEYeURH3HTUPhcPT6ROyPPS2REI2o53ZBAU=;
 b=WPzVFm1m6yvORFtx0yuO+rw87zuhrHJXvdITstmzoC7u4e3UCKnarF8I6Lzwbsq2k5
 DJUntm9ZnRosrJ0GK0v7MR6eu/JVxL4PPSeEGmCW+AiZ8fVdS9jKZtWHC7vJTGCKj7K3
 /2CGcEc5kjuJ1uxgrNTJr3t27i7FFMVR5C0yunPgHkg6SZ2N1BSGH4o8mYfx5ESBX5A5
 5TM9JRZkUCYwXKHDbYmDCUTavI7+c3h9AGhqtKk5nwvOKav37Ut2SdIv/FnOQ+r7bUiJ
 eQdzmyJFtMhNkiD/dxh0MV4ibDUv5tl3RubVqpVSGSNun4RiWcZrO8HVAatZBgpy9tKC
 hIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540385; x=1752145185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvjGPIKQGEYeURH3HTUPhcPT6ROyPPS2REI2o53ZBAU=;
 b=JWDmAIBnVyI3GlKg6ToXmyhIsTGDbR/NQxsBiOE06tM6l/Mv3hrEVneC5gEBINLNf3
 HJ9+qfNh9LbOlZuAuZN4BkzdPF1M+IXC7/OKP7AeVf2mNe9GMVLMRDptKan0WpzRIgwB
 TC+kQeTFkl8cOa6nlqVOz3d/0i0Y4OIh4Kk8UF0v93xQEVwE5+ga3NP6D/7exL2WBGMZ
 klh9zMQ0W7ixVNqHUBfbAigKrAMFLaF15sL/mtPv3pR6Um+YPnE5JWmafG+Cn7uok7Fu
 W4fvCfDy6NzWwfrE53Q/Bte/ahVv4A95T6FaBdLCcw+MXii8eniOtwo5RpRgNSe3v1eJ
 iPrg==
X-Gm-Message-State: AOJu0YxW+J5ifCSHT836vhvy6Sxh7gR9H6gz3fg74ZJL10blaY2tEfkJ
 G+CmVFfLfgo6OxsPF+AT9KlC0xFGSj5w8VjWHag9tXmSb7EdkP6ZM8ipz/0H4DYxUX7HgUfo/ik
 6mE7mkoM=
X-Gm-Gg: ASbGncu8G6AABgRoKXtVFNujP/5Wv8H6ItYrqjllAPedPBv3NWHnvHiIA6Z7T1CF8zc
 0xmHQ2vjtyyqvzi6FRkaBa4OY/+zUFOf+DjLVYlgd4csTdUpbUlr79NOYbf/R2vZuUUfjUODI71
 7Va+nxBhWIqH6uKfSz9DVEPw10vk/EWW9FPzju0U9YlhiwDrwYjtV/8PIcUNSh405UCND77lUQY
 ZR2uu+N/PohGKqPJ6fr+lDBNDB1oL70nBgVLjle9Ev1g9IWx48GAmaHQZ+LCueHNLMk2yXg4Krg
 rwJ0ayyl1iSkv265PjP0GORwVr2Q8H4Z41vQv3FTA9bZMmZubWvILGoR7Y0N//NubbZWQlKs8OJ
 6q1I9azcNAZxConFoPLLwVw==
X-Google-Smtp-Source: AGHT+IFFe1vpP0h0GeInGGctD4CBQmH2oRt74qF+x5fBthfRdo/V9+4qQpVqJEAS4Y6Z8oDf+L/60g==
X-Received: by 2002:a05:6000:4028:b0:3a5:287b:da02 with SMTP id
 ffacd0b85a97d-3b200b4657bmr5027241f8f.40.1751540385416; 
 Thu, 03 Jul 2025 03:59:45 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e72b6sm18614690f8f.15.2025.07.03.03.59.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 46/69] accel/system: Introduce hwaccel_enabled() helper
Date: Thu,  3 Jul 2025 12:55:12 +0200
Message-ID: <20250703105540.67664-47-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

hwaccel_enabled() return whether any hardware accelerator
is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2d..49556b026e0 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -39,4 +39,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


