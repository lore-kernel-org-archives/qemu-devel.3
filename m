Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5AAC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 23:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYYuv-0005vn-0o; Thu, 16 Jan 2025 18:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYut-0005vP-3J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYur-0004xs-Fk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1202166f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068684; x=1737673484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLjAfEesdApASDyVsAST+uy4KXHzjDdggJGXjuSffuw=;
 b=cd2eACeMmBeD5o7k/NuSiehHU/jHI7jfjmz2v0QOB44X3A2HWBC+XQabqTltDVgtx3
 ZZYA8KWsoCpU2KoUviauY+TqfGErtzMTirg59OBtlc3EcEAkupAfYa1C20FielgaDKGz
 1N563iup0W97wutj5z6U3cIQgolpQxxWBTMHZ0GxC3RYghWMHLDhnEFU6akNqYidicdI
 FUQwvvmxVJ3WxuBsETniy0m3bLgbwkBAKTA+c0S7/iJEA1mnog03rVNMtvFS0JTgvOrK
 HCquYQwlnhSua7W8jIxe3JPuXLgsonAwiYf6L46yjS5+4d+wPpso9rg1OaHx/wYudCbo
 Sxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068684; x=1737673484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLjAfEesdApASDyVsAST+uy4KXHzjDdggJGXjuSffuw=;
 b=hjmB+T686x6mBvuw5ib/sRW1JTZzCDK8l1xN5ygl8X0RJR19gx0N0tKgUSJiMJWrLk
 +KFt87BvYCtWu5uLyPVqN7NIvn573B2lDgwDl7+CAABlsXpp5XEvAI9rxmG9aVtJ8nCw
 omxUqBq5SyJc0PydM27gKqJnTKmLy9GNYXGA23zeZ4cgVm9y4yC72OBXWMtFR+dpZcRz
 fzDPW1V0ziaOHw6+byfrn7tyQXwSaXW7dBOSFXOD5lshfaPPD5gfTf3RG6TA50XuR0n2
 MXblnEaiXP+5ZP5lAUC8u5/PldjcYLNbMRhAh6R4Wemoau3a05S6f2upcb+5OJ2TIKxT
 +PPQ==
X-Gm-Message-State: AOJu0YwbEjMnBPL7CVH7oTZxmYRD9iHrgCkrrs4kRL2yfEomPpzp9mm6
 Zqx11u2Br8mdxNfTl4d+sQbGk/k6eovg+VMH/VgiDMBhY02dXBLKye2m18bzQAvMP8LGuzN9eYS
 sp4k=
X-Gm-Gg: ASbGncsYhWzYhs7MlyTnnpDtLbq8kSvCJLAsvq/OFnWnWrrvTrT26yjqZSzdKmAT+MM
 HLl04cKU2dOfrnzjJFWGHLeyX2VVe1LnTrOIb4tSsdHbSbf3j1xe4MVHZkWgWUDnJaLfinTgYb5
 6FC6V4Ht8pGc0Fcnx4GFrpiTPO53YWy0ot0DcUKwNo1H/Nn8SE9NPmox1VJSsZAclAGf7Siy/Vm
 I07xQPZAZvOG18f1d4lXgm6fECB//sDEpdlyP8DEfro+NDOSgwPuqydp4roG8Y6ZfgL7stwOoyp
 OZPFplPmmECRGl6voD4nJTComu0TfDY=
X-Google-Smtp-Source: AGHT+IGhjTugVyMuVVwIEtirXSVUO7G45R1rLYAYuF6AuwFyONi/aB8WDZMv3X/rtJKqVClbvw7PEQ==
X-Received: by 2002:a5d:64a1:0:b0:385:f44a:a53 with SMTP id
 ffacd0b85a97d-38bf5655b07mr267507f8f.4.1737068683638; 
 Thu, 16 Jan 2025 15:04:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327dee3sm922535f8f.86.2025.01.16.15.04.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 15:04:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 1/2] cpus: Introduce const_cpu_env() and
 const_env_archcpu()
Date: Fri, 17 Jan 2025 00:04:34 +0100
Message-ID: <20250116230435.87580-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116230435.87580-1-philmd@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

const_cpu_env() is similar to cpu_env() but return a const
CPU 'env' state.
Same for const_env_archcpu() w.r.t. env_archcpu().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 5 +++++
 include/hw/core/cpu.h     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b1d76d69850..f765e97a973 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -250,6 +250,11 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
+static inline const ArchCPU *const_env_archcpu(const CPUArchState *env)
+{
+    return (const void *)env - sizeof(CPUState);
+}
+
 /**
  * env_cpu_const(env)
  * @env: The architecture environment
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..ecb31221b26 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -588,6 +588,12 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
     return (CPUArchState *)(cpu + 1);
 }
 
+static inline const CPUArchState *const_cpu_env(const CPUState *cpu)
+{
+    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
+    return (const CPUArchState *)(cpu + 1);
+}
+
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus_queue;
 
-- 
2.47.1


