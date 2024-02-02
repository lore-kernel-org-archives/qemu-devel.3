Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B11C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSf-0001O0-UK; Fri, 02 Feb 2024 00:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSQ-0001Fp-01
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:22 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSN-0001nN-5A
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:20 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so1213673b6e.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853078; x=1707457878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpvGm1ZOSIrRSWyUglC1Pj/o+FPeCdOCNoH6m6RTCKg=;
 b=fCBi/Tm4Sv9Tdp44IbojyCcYZDBxh30cQhQ4YcotWfDeR6y5yolyFnmY8aCbQCnXe3
 Z7e1L8KSUWjnpLsvxhV509uwm/7rxCyxUoQS6SPxzp1TEW69SEMzhBSjydFkNhUqrCY/
 kDzwQtysn4FD6Pt5tEtY29BfHzWgsG8/JBhueQzPjKpmcu3ZzLn/DvbhDWPs9cxr4IMh
 /tbA7O7AL1gh1PNstcbR61BCxHJCdpLvXMImK5AydJebSORvkNpPMVPm41NhPFzsQ3fh
 m+uhUe24hEN9fVvZ0GdAi4RDS3WeBm44elHoX/OSWxD2TphiZsk2uFPkA/JnGfOAiqoJ
 dfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853078; x=1707457878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpvGm1ZOSIrRSWyUglC1Pj/o+FPeCdOCNoH6m6RTCKg=;
 b=KH1EXYIaKFeFIubmECuI6a+ZHK5WCi5/8WoP1HQIZ3Bjawh/9BUus3EGFiFu+qUebN
 a+fbDi/Nfhqq7SD6/G2DGAfFOj0jnoE3iJ95LvjizbzxM1iXhseudd76iYqLVOhst7Dq
 lkEam9bTMLxQEu2T3u4u6L/3iI5goHssUn0rwZs90uiUGeJJ23HmxwGAeqzmf9FWcLbj
 qnhNk+mxhaL1f3Ms6L9fM2mDqufudfjHaLGGDqqEMYQbuvR5PUTkLYIXRyX1t2YIbISN
 b+8tgmLetq37tBOd2LSyemc14wrPYB04qicbTjq6xyPkH0H6ThBmd0wlLNmaJjJBN1mC
 P5vw==
X-Gm-Message-State: AOJu0Yw2O4tJyqarqJrvGpRAd5VDN3Htatm53JeTRQbvLoQAMz3jM2LO
 oBz07bd9DvkqvzmT4W/WbrXEqv52+byiSLWa/ef1zPvRMinmQIf0yYBhkJjmToDLRjZ2qmYizVP
 Z+fA=
X-Google-Smtp-Source: AGHT+IFBg0QNUlNuV7DCmrQ9zTlYyUF1YXIIEUMjmvI8jh/SZWoGp3no3Qdm3rfhfDf566kcMYjIpw==
X-Received: by 2002:a05:6808:13d3:b0:3bf:78b4:8c66 with SMTP id
 d19-20020a05680813d300b003bf78b48c66mr4822462oiw.40.1706853078104; 
 Thu, 01 Feb 2024 21:51:18 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/57] target/mips: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:56 +1000
Message-Id: <20240202055036.684176-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index df544ab39b..d644adbc77 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -182,6 +182,11 @@ static bool mips_cpu_has_work(CPUState *cs)
     return has_work;
 }
 
+static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return mips_env_mmu_index(cpu_env(cs));
+}
+
 #include "cpu-defs.c.inc"
 
 static void mips_cpu_reset_hold(Object *obj)
@@ -579,6 +584,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
+    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.34.1


