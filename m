Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2499C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvMn-0008KO-Tr; Fri, 02 Feb 2024 10:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMl-0008Je-TD
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMk-0004Tg-BU
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7858a469aso16966455ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887324; x=1707492124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1eBy9OUF1KhxciHsZoO2+9UUkK89QSvYzrFDbFxj1A=;
 b=MqY74xdAJkrwp1IsTNc0rWFs7/PnlLDDZh7gTxVOsLMNICG8dVWlhVnuveAusAIKw4
 tzuRPQ4iHfdr6BhUZuDilLNPhfqik5YRwIJQngbC9oH2c9CVUtnfMkIkch+GX1N/8cDd
 /GT+8S/zmQkWW55SQ3eyE7+c3Ca/lzqUpazqov0sdh+9v6V77Dh9sSZDSUAxzd0kDsmn
 shfj0ukugVwrJKzWo7WfvJLrWloQClytdYVMcPZrUOMCNUxaMhObwjR5aP2yRMZn7UFV
 QxLQq/Y5+IZ/Oq+qXmaMsO26PKUxdvKAiN2mSJif7xi+xBghDTP2OEBFXyJ41rA5pZj+
 sFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887324; x=1707492124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1eBy9OUF1KhxciHsZoO2+9UUkK89QSvYzrFDbFxj1A=;
 b=oi4gz/CxYCXr/j+XZd9kCb8cnqHnGqj5gIwh/OPkK8Eux4ge2XmA8RojA9S41xVR6Z
 N2dVmJdvuUJLD7NM6Ga0oNdSPypQAzOPHJh/jcovUM0HN4SPPbV1X8ApYMMeEooejURc
 ynYpFUmUlUa4elh6jR80C9avotFVTWbnDab2nnXzarec1br3MPgB6Vav9It2eVNUxxEf
 u1VVNl2u1ktDYNtDZP7FC2KN8/VfsM7cnPKfrTnItInj8K9rBqppwC0BplhE5APn0ouz
 qpMeX5KmQoHCHkCcF0TXotSob8axrVGcYzb9g21Ri7Rm1auVfWDRNmUgXkEL3yjAMhZw
 N/mA==
X-Gm-Message-State: AOJu0YxixX1ZQGk5uG0Qe+270km1eGCBawjl10rTnd0fyP1xhOyh/raw
 HJruJtNp9jZpNry0ItlcsI1RiHjIeLLm0HZ5yVhlY8dU30ot5SHqMX1MbLt0iwHnJQgO0HLgjj1
 Z
X-Google-Smtp-Source: AGHT+IHHgc10WU5KDxEajZP2C4XS3CdWqS/shyT+hcGqzPWu9BtiGVQEJlNFSg4Wb0QKeGGDRIzx1g==
X-Received: by 2002:a17:902:f811:b0:1d9:5038:f116 with SMTP id
 ix17-20020a170902f81100b001d95038f116mr5246635plb.34.1706887324130; 
 Fri, 02 Feb 2024 07:22:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUY+b4a9Uob9vNELTmeFd1bTRPJJ2SJ1QH2j/1JhSUCxCWhj33RQ39TC7JNJ8T7y+R7sGXhVTXqcPtfGo7iRK6yfQMWGOHiqc3qSkuuOhmvaSsfdOv2F1cjdeaTUuCPs9BNg3N21RLFkH/+Zvyg6sGTIpk87z9g5zNus70cO/fLVarGegZuEXif0CgjJbX2XO7PJAm94DDCNwZqiJTV7zEx52EwCGUzOU8RanlCg7vp57SBnCiqr5eXJMKfKuCYFG66KeRag1EQFCB9Ngut/YEORLoK0Gq7KA==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:03 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
Date: Fri,  2 Feb 2024 12:21:49 -0300
Message-ID: <20240202152154.773253-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Recent changes in options handling removed the 'mmu' default the bare
CPUs had, meaning that we must enable 'mmu' by hand when using the
rva22s64 profile CPU.

Given that this profile is setting a satp mode, it already implies that
we need a 'mmu'. Enable the 'mmu' in this case.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index da437975b4..88f92d1c7d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1107,6 +1107,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        object_property_set_bool(obj, "mmu", true, NULL);
         const char *satp_prop = satp_mode_str(profile->satp_mode,
                                               riscv_cpu_is_32bit(cpu));
         object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-- 
2.43.0


