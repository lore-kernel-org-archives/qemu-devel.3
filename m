Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968A9E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyY-0001eZ-Sg; Tue, 03 Feb 2026 10:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyL-0001Ds-2r
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyI-0001uq-4Y
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so63125195e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131140; x=1770735940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=US/2W/gseXtlseolfQna95tnYoLscjZYMx+/tGqLvqU=;
 b=leOmfx0myEan0rvJRfkjtc8sJTUiDgqeS7kSH6JRSZ8+X3ogOeAyR6IJ7FlcsQRxz7
 UH5R94HNGfbgWcVejprZKzKFDbXkr8CCmxIDhjxQ4EppoIiu1hCcDaWC6wmgUH6zPu9y
 L0DtgFcXpEX/Tiuo+InKT8tW9HA/3Ls7B+o+aFMMoCwafEt+ysP/fRuwQ3EnKHQfD3iG
 6aV7qTy3fFpSMxA65CEY6KqXBugDzDmGm2zEy6uACNmm2DzhOx5PqSMDAWeX14Mq0rNw
 yTS2Vt9ftFJkMFP/jOiEmlorZ3gMNtA/h4FYZIdRShrPZ4IvIrdJ2vMx7zuyD7xoXFZE
 pLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131140; x=1770735940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=US/2W/gseXtlseolfQna95tnYoLscjZYMx+/tGqLvqU=;
 b=swV5vhD93BPo6qwL/UAbPS6ai/A5ikADIPBImNn5DIIuUfIt4EsdoMTEBxLEehZbRJ
 wpYrR9z5yAOicjaS/8dU2v/HvZyAoWVaOvzC584MtuYcxqP91hrde4gYXQ1bFRE3u4jF
 rpotgOyXrzMEqdwyX/X0uHPczW0h+IjrMZqbtFnowkZ7iegrJauvMWnI51xhfeN3+iT5
 06qqGh2g1Py7/UYqYnmmSyCSQheYsAMNIcI8MC1tSPTDyb/UrN3RaLrud5EPhBkHlW8C
 v7L4snaub9IhyG1M9IN3JrRWshv2Mo3iRa1akO6Jd+oT0VxSGj1hHaTV+Grs76v1XWP2
 R+PQ==
X-Gm-Message-State: AOJu0Yy8SpcLaduFXpMstF7L3QGf5/081SNF99+Zb42rq/5Ob4tHdmdV
 BwTXNHppLYDYGBnEXklMc+sM022sWERVmXR4koXpC13bznlceH+I0qb7Vupt/84tbtToLdC5zxt
 PzWTSNTaXmQ==
X-Gm-Gg: AZuq6aKT+mM8QO/yc1OHPDC3y8LiX65EpINbyaXmo/pmqswYriZ7wxGAon/DE7iD8C8
 WQ21AHIQwxijkWbZQ7Mk69S1FHc6TyzK/WaWDMoqsrTZnmhjlvbNFjtO0r+dntRl1OVQD0AXIYJ
 AgPGHarOuQ1mVJD8HZE7Bdh+KDMe7plrOGwusFbj0pDje/82REEfUFIQSYcz7hFsEqaa8MZOD1U
 5WesxIG+1+OhoR7cMr2C3GRp788s8pnS8EII7Sh6aaHPXYAtX0WZun+2lz1OX+fEQ24XQklBgGX
 jGuRK41sVvWh4kvUnobdioZEHKGEOOReXjerz9ztRJ+P6QiHZa1X+sxIQvy6EeWk07npCzsexGx
 6M5DNS9wiPlIcEHh3w+odg0pIkBLsCttS6Qk0VWCa8qCLv5+5KlIWxOEH7ICtF4usjkf9shLi5d
 8pIy4gcpKvTwyNKWqXOkR+vvj46JNXQCKWqiJ9QD6N7mT76sRKA/0Hqc58IX/s
X-Received: by 2002:a05:600c:8207:b0:47f:b737:5ce0 with SMTP id
 5b1f17b1804b1-482db49239emr173929545e9.23.1770131139929; 
 Tue, 03 Feb 2026 07:05:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cefdsm53711959f8f.23.2026.02.03.07.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/30] target/ppc: Check endianness via env in
 ppc_disas_set_info()
Date: Tue,  3 Feb 2026 16:04:14 +0100
Message-ID: <20260203150436.71907-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

disas_set_info() shouldn't bother with env->hflags,
access env->msr directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-9-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 58816c51a74..0808284b722 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7456,7 +7456,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->hflags >> MSR_LE) & 1) {
+    if ((env->msr >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
     } else {
         info->endian = BFD_ENDIAN_BIG;
-- 
2.52.0


