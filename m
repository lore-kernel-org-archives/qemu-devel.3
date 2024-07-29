Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B520AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZQ-0006Kx-TJ; Mon, 29 Jul 2024 13:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZK-0005iG-3e
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZF-0000Mw-HL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so2645446b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275632; x=1722880432;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=266neMCz6T2Ay7h8fQ0tNZU+3Glrf37EuuzFIpKJGMw=;
 b=HCGbyKxE9FFEQvNdzpFPKAE88ncFNl/LNfTsO3kK41dYG36nXbscHLrJN5pc88DVZ4
 dP6K5Ffd+1kiNmWMb5HmueL3rslkbXpRz/d0Xjjr2ZIGzFraVztU3E0ruSUCaqaheZNB
 bOKg2yjjHHybXSAwGJZco8CWFIy16W0pYn3QLF3KkjGM0bUd37UhseC920eetN8eU92z
 V83vr+1V+H42iWF3NJz6mibrmN4ZMv7zA8ik50KznbhQ4G6n3+1KpUHyF5XEhq3w+Bhc
 IMkPYFBKO66G6s1rPrSZXv5t5PWIgSym0lgVoJKSpvY2NjjNzpkv2uqrAlGfGP4dFCRF
 Y0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275632; x=1722880432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=266neMCz6T2Ay7h8fQ0tNZU+3Glrf37EuuzFIpKJGMw=;
 b=PxnVfs95QhXm/XzWI318tgfe/Oqu0uauuDkR3mhniJ1qMmUFrn8qAv6wfJMRPTuAb8
 jw5j5Ja5ksKEBZHTLgsc0VkTqyIL4RyFp8aHeV+SSWU4U4PfthwVHeZGAgpWOJ94NvUj
 d5/ILivwnBdJiUZ3QbWGp5gX/cqH7/1SqZlhsSGsFDRPt61Xujz4aW63I6Tz83XOABoN
 xphGrDvRJZGR91Gw+LVweLpehBhsRg8bYdwe7iVqqQMqrzPWmsgL8jRwvdSefnnksBGg
 VW0WnLe2lQOfbuISgEBs7y4uSE0mSQyXv63L8teCaF5z5Gxq+HksRjWkqlg3IAIrQLNx
 81Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf/pszmgSUthPS+lW8rHM2sK3TdvymkkMe6+hi5HWjFSFsNIpkqhhi2y/y4GVQCsiXGo4fp4V0i9CLgDQ7gyhvmvQtEDw=
X-Gm-Message-State: AOJu0YzdT1z6S7Kbu05XYUtnAHbpgUFY1ZVBYnXvn+DQT2v3v7vuShpy
 tbfOcuC2Tzb4iTFTMwF4a8lsN1O4WTiCTgr5JrSdfEkyOBsrKfsZrWLsJABvr40=
X-Google-Smtp-Source: AGHT+IFx72l730eObtC5wCFPHMYisC4e3PrRHeYk+dbkU8nvDbg3ayBrCCXHMzd7PJVRE2cWHKZqzw==
X-Received: by 2002:a05:6a20:3d89:b0:1c4:8824:24cb with SMTP id
 adf61e73a8af0-1c4a129cc6dmr7385290637.12.1722275631920; 
 Mon, 29 Jul 2024 10:53:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 17/24] linux-user/syscall: introduce prctl for shadow stack
 enable/disable
Date: Mon, 29 Jul 2024 10:53:19 -0700
Message-ID: <20240729175327.73705-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Each application enables shadow stack for itself via prctl. Using prctl
codes as proposed in riscv cfi patches on kernel mailing list [1]

[1] - https://lore.kernel.org/all/20240403234054.2020347-1-debug@rivosinc.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
---
 linux-user/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ec157c1088..f879be7cfe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6295,6 +6295,18 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
 
+#ifndef PR_GET_SHADOW_STACK_STATUS
+# define PR_GET_SHADOW_STACK_STATUS     71
+#endif
+#ifndef PR_SET_SHADOW_STACK_STATUS
+# define PR_SET_SHADOW_STACK_STATUS     72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE          (1UL << 1)
+# define PR_SHADOW_STACK_PUSH           (1UL << 2)
+#endif
+#ifndef PR_LOCK_SHADOW_STACK_STATUS
+# define PR_LOCK_SHADOW_STACK_STATUS    73
+#endif
 #ifndef PR_GET_INDIR_BR_LP_STATUS
 # define PR_GET_INDIR_BR_LP_STATUS      74
 #endif
@@ -6488,6 +6500,9 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_TSC:
         /* Disable to prevent the target disabling stuff we need. */
         return -TARGET_EINVAL;
+    case PR_GET_SHADOW_STACK_STATUS:
+    case PR_SET_SHADOW_STACK_STATUS:
+    case PR_LOCK_SHADOW_STACK_STATUS:
     case PR_GET_INDIR_BR_LP_STATUS:
     case PR_SET_INDIR_BR_LP_STATUS:
     case PR_LOCK_INDIR_BR_LP_STATUS:
-- 
2.44.0


