Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1642C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJM-0002oa-Oi; Sat, 02 Aug 2025 19:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJI-0002Zs-G8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:41 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJG-0001Ag-Tu
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:40 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ffa1b10918so1982348fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175997; x=1754780797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyBW6oXpw96252KnNIM84sqTDSbPQVUWR0A1KOUJqIw=;
 b=MoRn1J7yPMvWcXH+y5ExO5plVBy72l0wpMwIMzKhC/WZuu8xret5tCevDPDmpVvWDD
 riJSqt34UY98waR6X2cf7WLgWqhCW5Cb2UTyStUWS6TH/fEmwewUjUHKGYydiUtDeh9G
 2DEk6l1zfn7qc4HN3UOtles7jqZWYKQ7HjMGjGvxRkcrYp/bKmkw9NZVO7IQbSE1YpS+
 hf/D3X9rwxCzL/fSo50O6Iq80leSFkk1koE779GcGkD18ZjZaNUrc6pX7FpEKxvHIE9O
 /YU/H7neKezOuqIHxV+CmtULqY+1kw1R0Xumyr4XJ8rGNdsKFfmwCGDiIwBlS6oL/yci
 G9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175997; x=1754780797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyBW6oXpw96252KnNIM84sqTDSbPQVUWR0A1KOUJqIw=;
 b=VKepoGvmcNUBFwwrbmCuzPx3NuiIXfbmleHRm/7l+pPI+wHVZT6hp3NL+IU2sRRhcd
 GUkopS8nHtsIOJhwVBzRTDcPKTRM9fy0XbjR0UAgSMyJSiJW97iE7Q2Z7EBqd6Yk7kT/
 Ctwfbs8dJK3VwGQCx7QgZBiKl1nwoTzyOKYwIz5j5oUPTDrFH82HY6jOdFSEUBXj7Ced
 K7WaFbHXB3I77NVNAbxsoMN0Jc2M0Kd0PeyYxXjJ/PN07Ig7OFafROao0RJ2w2vJG3u2
 pRWmwEBkx5G/qUwuto1tnUwiHdjWUk+LI4cmU8KnKbymfcjx6OCFZYWU/Og5Fz38jwvL
 Bq2A==
X-Gm-Message-State: AOJu0YwJj9K6ktn1SXWueZiMYKwdnGEVqY7saMN3HJK+zVIwr+zVBGzm
 3xGuFV6zsrpSkPehnoCxnQFl8pBKYOLnrrg0UFb5ONj/r7vRx5dcMzn3to87vJt22HckA82Q/+x
 F5js2pHw=
X-Gm-Gg: ASbGncsqEKDzvfWcRV8MOULgfGZMb6FeOkNsJZt+5Cbt3jey9yLjfuw6az20wMLCTfo
 7hZOdRgYzwIYgkOzYrbV/kH9WhrA0HeAr25FeoAepgS/Vi999wnvRGeznSfnqt+yftPrQc+iwrN
 e7olpMn8r+PuhNKwP1ptcvVwFyyKeoqgNlkSSQNGbX2dIOoH9WdePsSFMGef1dHLks6r2cpauZ3
 FH2KM0KJT+SD1xgShi9/LdKPFs/68aw8I1KE4ZP5gL7V4+jtMeQjRNrcKi1Jzf5NczUEKTm+Yiy
 fVIlAVgKHFMitbuuSyFFjWXoHpAKwPby4PsqSDITPCJz6MnezBsKykBzhhA81ffeFBZMR8DeNDz
 gnhMajI9jKaOOk8XSHLl0ytcnYABl30JyY3XGG9VMjcPIElG1q/ab
X-Google-Smtp-Source: AGHT+IGljwQNlNsF3k3qkNil95OeFOTXvGRoLYtOdaEXlibDqIJaDPF5gEQiIdyWKYl38siRLExibA==
X-Received: by 2002:a05:6820:1e84:b0:619:a34b:3e25 with SMTP id
 006d021491bc7-619a34b4276mr756035eaf.6.1754175997605; 
 Sat, 02 Aug 2025 16:06:37 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 24/95] linux-user: Move target_cpu_copy_regs decl to qemu.h
Date: Sun,  3 Aug 2025 09:03:48 +1000
Message-ID: <20250802230459.412251-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

The function is not used by bsd-user, so placement
within include/user/cpu_loop.h is not ideal.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 4 ----
 linux-user/qemu.h       | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index ad8a1d711f..346e37ede8 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -81,8 +81,4 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-typedef struct target_pt_regs target_pt_regs;
-
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
-
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4d6fad28c6..0c3cfe93a1 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -359,4 +359,7 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
+typedef struct target_pt_regs target_pt_regs;
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif /* QEMU_H */
-- 
2.43.0


