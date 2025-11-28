Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F94D116F5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxoN-0002M9-K6; Fri, 28 Nov 2025 07:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxo5-00027Y-8M
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:37 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxo3-00039C-4A
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:36 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5599b119b4aso455836e0c.0
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764333754; x=1764938554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6rMJ3udbgIpgAiy6d31R0Vx2kkWCqkcA13MTheL8sQ=;
 b=iSOV6Y5XrC7FZfRL0QtU7751OKv8dUjthFa3epUQJ/uQ6/o643RLX5REpuEFaEmc+f
 RqwW3X7kE3SCyhUDo0jLfXcZ4/Xv2rJcTBVXkhe08vQS0G8AN1ZkLl2jcD9V+NgC9qix
 3N9WF8HczJDp/Wql7ZYh1d4inu8EdfySQagvZRvK5zaq1MH775ZIpT6H88X1BV98KfCZ
 IAwBnp8wMrZ1JcdGf76K8pFUusstVcXMOD7vMlLo2nsjKNCD8Kmd2OW6Be72QzO8LA6h
 e9C6S18l1VKnYflHCuNrX4OFocHcVGEoLrWlq6/OUyDPbFIn2Cvb7fg4MN6OBCHmUUOk
 HV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764333754; x=1764938554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6rMJ3udbgIpgAiy6d31R0Vx2kkWCqkcA13MTheL8sQ=;
 b=n0wc4J/xJa61eb5eqBo2oVEbRl8t8L3kT7lSu68Ucx8pU2r699lLPHRev33KKTQFnm
 siqxdukr2qe94NNpqSwMnSd+B/huNNIonmU1nrEDDtwPCIzMzhTDK/0DD8mzTdYYc9Iz
 XPmkkBHdMlZ0u/xxP1KR7dxZ+REfwbbNencRBTqCRDhHtTEDQfOPrXUeQGe391EqxNYe
 tdmI/89vz44Cejo4xX+M1H9C3+gxOXdNk0BJ3iBM5OTjtZ/DwK1XrA0tXV7LZ7fwSYlp
 SWZLa55A3pDp1iCUNPwcmLV1fqspo1xRNKoslZp7BDJ5i5dE5QxHKORQDk2zuJBd1m5B
 ka2w==
X-Gm-Message-State: AOJu0YyCksmcoXaTDSIvIdQcYQK5EMMZGKFQgjGR6UVT1rI0mAxXF/wj
 IfYuo9/5xxNeZRhkgq5YSfHrXFlR7h6IjD/DyUGXtOd812/2z53PhiIxWrXmFEGTIciMjkZLHKH
 wn6V9
X-Gm-Gg: ASbGncvx+1PUeZ2mTwn3FThoHfgY+Law0NkK9iPrKRzmCE82OwOcrqy9HlQ5e/LDJNi
 vlObZanOQaVBlO8x8IhQQIcRJSRvUKptT1qZaSc8ong435Fbt9yD2+4yF0Q50/kV408aTQ6oEzI
 KUou1BFG9wnfBMfLnnEsS3FWYBv/TZ+3DeH908mZVbXkbt8+WFf8ZZRWlhmOSknavlTnee4NRCZ
 4qq0AkjQi/cROn9Y0drKzXPMEvjz4ikY7DI9Ylsu4gfgUS/ExgVBEXhUbQGeH20qQ+WVMJlCKhV
 QVHtZomxNTRNhXsD61n1WP2MpyPOPw2YdkSueLponKFo6FXheU5V0eZ/9gIvK+D0TTApQWjLXJ0
 i42BUD8bB3rnDoq+dxGpUgcs8O1xyaKa9avsZa0lNyoG29L3CBQPV/4p4lq1oLpsdszlfk3jFd8
 uD1sFBtbil7CSOl1E=
X-Google-Smtp-Source: AGHT+IEsb/oawwXBRNjapEzXqc75pUgGhNNk26dnwbq0ojjBMQeG+AWSNtLm+Pm7/YeOvu/HZ3rTSA==
X-Received: by 2002:a05:6122:7cc:b0:559:eef7:39f with SMTP id
 71dfb90a1353d-55b8d75c040mr8547626e0c.12.1764333753723; 
 Fri, 28 Nov 2025 04:42:33 -0800 (PST)
Received: from gromero0.. ([177.139.2.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55cf4e1d56asm1776930e0c.4.2025.11.28.04.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 04:42:33 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v1 5/6] target/i386: Add a _MAX sentinel to X86ASIdx enum
Date: Fri, 28 Nov 2025 12:41:09 +0000
Message-Id: <20251128124110.1272336-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128124110.1272336-1-gustavo.romero@linaro.org>
References: <20251128124110.1272336-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a sentinel to the X86ASIdx enum so it can be used when the total
number of address spaces is required.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..783ad66d74 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2600,6 +2600,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
     X86ASIdx_SMM = 1,
+    X86ASIdx_MAX
 } X86ASIdx;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


