Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00A9C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbifo-0004IQ-UV; Sat, 25 Jan 2025 11:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifm-0004I7-F4
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifk-0000c1-SW
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso32235675e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821170; x=1738425970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YoTq/Kw8BFNJbd5udCtM6rehNhaZvqVSckhQj9fm84=;
 b=wMDHUySxNc/jdwJQSdsfaazG08wfO4dBlH28e33m/Q24uh2ySJGVL/Es3a8/zxfHl+
 sOYAtY70BgYCz8vcozlI7KUpnnds7LKaYEqbiC02ljK0lil80ugJpcIdqT5ptdvUmWvU
 VQNhntcKi/J2yNIvEYLvUOzEIx1ovMp+9Ct8N9FANJjgGXtquv/yb9DZUURNa1T/sHVp
 A3URdZbAE3tqYMBkc0RT9ZNrI1zvBUp/Xnq5sLn5KUTGa3ePDkQYzy5qdBMJGXnNosve
 K7F98VDqIW+K3OYYXJqmrMpdMttN/o3Za/1dgefoKDcOdgXJXDnsOJlww+iVAbQCNjds
 yAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821170; x=1738425970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YoTq/Kw8BFNJbd5udCtM6rehNhaZvqVSckhQj9fm84=;
 b=Rpeu9mkxxcED5jGQaKCY1GT39neITJANujSKy4yI6BkBst+FVFLkSZ0qdaON+yzQmH
 +nrR3smrLauqDla26LvL9UQlB843goeQhDddjEeRGh7oSbWIO0+5PdvGZFCizjzz8ywP
 ZW8Z1ZfVJ7Wz66Q77wdN3wJbpzP0QP4b76AOqo8J12RD8+uRjsfvPNap3z+v8Y5ThWnq
 NIA8jsX+YYkdbaH7qFZWDlL1pKfoTA7SMaIEjgQaiET9l5jeT2PCkAEL1XdZDsz8+O6w
 SuYuZrMsjeC9QibSuMc5WSAVdfy76rV0opIxOXa3stjKxU1StVH/o2PuJq/ppJdv8NXy
 msiw==
X-Gm-Message-State: AOJu0YxcnWpuUg3KqM9hVu+dsMbrGVwGCsp4KAGAOJeKBFtYh9QCzGap
 dIcfKcRpSWBJeguLNpojrRaZr0mTOIsKykwYQZdutZcC6MOhY0ulz3HZoWgZY2scDFEpK7KVNep
 EYT4=
X-Gm-Gg: ASbGnctshzzWMakCGWEnlLLIkxRizZmLPBZ8nutWvIzBZspx3QQFiAa3VsD+vIEvgVH
 kdLmJbqe9eSTGidFDgKxscRS/MdHPgUAbWgjb05UUTfOz96EUmuvmSzo5skxzKL7Z9U9vYGts62
 NZDLubseSfdBae+nPasxZExShzos5IWHT4y25bbfT0GGwZmatm10hXxF0KlBNFtObhrWddB6/rE
 XM+q73z+saxDBAv87CpTcPGchDTKkpqPTTIbfS4DhYtqoH4N45Ji6aloiXAuv9fJU140ONtLxyN
 1iEHF083ic2VtIaLxqV3LzGiwnOQitI6+f0RSaSE9s+AAvByD7wn07mqXPGd
X-Google-Smtp-Source: AGHT+IFq7hqygNk4iEUDU8X67GVCsaQ4kRPaRr3yMIVEjjtDJXqKhU3bVpcjZV7Lan+5bsV8KmeHcA==
X-Received: by 2002:a05:600c:3acd:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-438c18c5b00mr44668995e9.31.1737821170008; 
 Sat, 25 Jan 2025 08:06:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0ecsm66090525e9.30.2025.01.25.08.06.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/24] cpus: Introduce SysemuCPUOps::has_work() handler
Date: Sat, 25 Jan 2025 17:05:31 +0100
Message-ID: <20250125160552.20546-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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

SysemuCPUOps::has_work() is similar to CPUClass::has_work(),
but only exposed on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++++
 include/hw/core/tcg-cpu-ops.h    | 2 +-
 hw/core/cpu-system.c             | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0df5b058f50..dee8a62ca98 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -16,6 +16,10 @@
  * struct SysemuCPUOps: System operations specific to a CPU class
  */
 typedef struct SysemuCPUOps {
+    /**
+     * @has_work: Callback for checking if there is work to do.
+     */
+    bool (*has_work)(CPUState *cpu);
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 2e3f1690f12..f60e5303f21 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -141,7 +141,7 @@ struct TCGCPUOps {
      *
      * This method must be provided. If the target does not need to
      * do anything special for halt, the same function used for its
-     * CPUClass::has_work method can be used here, as they have the
+     * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16d5efee12d..7b16bda2250 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,6 +25,10 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
+    if (cpu->cc->sysemu_ops->has_work) {
+        return cpu->cc->sysemu_ops->has_work(cpu);
+    }
+
     g_assert(cpu->cc->has_work);
     return cpu->cc->has_work(cpu);
 }
-- 
2.47.1


