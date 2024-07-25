Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B4C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Al-0001Yl-C2; Thu, 25 Jul 2024 19:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Aj-0001SJ-Sc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ai-0005RN-BW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so380856b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951215; x=1722556015;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3J0a7Kk8VH78Rf/KPYKxAa9BurTiYRdK3RsGWQBTas=;
 b=KDft8ywDUmfAdVLgDqkQFaXE2UIA0e/5k80nTz48axenhr2TKZ9jHjR6XS4Z+mIwik
 AtEHCqs9LY4HQcfZPjxE77CPXAwQw2w7Vv2g3uQk/3R9yIJq90E/XTL1LOSDAyCZhi44
 GUwgZPlmIKTyDD42X0HXCcrNfFI9ItbseQ+OkW1J8H6mC+X4/ZmYzILgYrmWX25rgzPl
 5l3NWgIi2m/ws+hP6P1YzWHDLDN4FxfaTYsifIgDmt56DVqme122tP3kptyg+6Xa39m1
 Ga7Tv5U51+8emzguAzkkPf0UpxO5dyPsyZRTL4ZE6RLBxK3YhehsbI2z0dXacutbW5Hx
 uIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951215; x=1722556015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3J0a7Kk8VH78Rf/KPYKxAa9BurTiYRdK3RsGWQBTas=;
 b=EEib/jEOyR2NgiMRJ2CZSfYxQeZT18rlq6pjcORq1PIcrIxM6uAGpFgtSVpojVffjX
 R++nUB3+eyQrjCNn6wF+gB9Bu6Z960umU8GY7RiILOETpdPLlX9sscYDpxNXRlrRUd7c
 xMO32f3BstuPSvBvV0Pzn0OfcUD2WB2eyLQR4ZM+xndU8zthCdmfy55Q1Xd+ousSGsdY
 tRKs0TrYBFMdjmqy4P5hjL7F7G19Xr7a/Nessf4wCo7vY6JxWdQRzwCv5z7Q+KDYkobm
 XqW+QHrUtcCKZuGhb+cSO7J5Ctf+C9GVqrmL3T6SDxMfZxUPeP0vA/Y3BfUQGewW21DD
 HSxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDpBKxb6hUdc2Lyy6xFag+yOfINk8FB5P/Kkqkp8dS5FnjXxpNl8hEHufmO4zrTvG5/6j+DrgAFQ+JNKcq91i2FeIQ23Y=
X-Gm-Message-State: AOJu0YyeRV/1X3LYbe+5Fdd/xckX/efk07lnmALdv4IjFHDIDM8NHSFx
 XDzTjBl/Sd8XTQ8qdNp13YpBZrU4Mg658pp8XOZoN2JiDM0dwbgSwW8x6UiSiHk=
X-Google-Smtp-Source: AGHT+IE6fe7ud2CzHt6R4CiQKeHUQrgDRpPpp6tLebVMZb6di1NmrdU/7LPVB4BVPsJCShBbFwyxlQ==
X-Received: by 2002:a05:6a00:66e4:b0:706:3580:ac4c with SMTP id
 d2e1a72fcca58-70eaa887cc0mr5009740b3a.17.1721951215014; 
 Thu, 25 Jul 2024 16:46:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 24/24] linux-user/riscv: Adding zicfiss/lp extension in
 hwprobe syscall
Date: Thu, 25 Jul 2024 16:46:13 -0700
Message-ID: <20240725234614.3850142-25-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x434.google.com
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

Add zicfiss/lp extensions in the ext0 key of hwprobe syscall.
It is aligned with Linux CFI patchset.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f879be7cfe..f2f2164ee5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8882,6 +8882,8 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
 #define     RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
+#define     RISCV_HWPROBE_EXT_ZICFILP       (1ULL << 36)
+#define     RISCV_HWPROBE_EXT_ZICFISS       (1ULL << 37)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -9000,6 +9002,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZACAS : 0;
             value |= cfg->ext_zicond ?
                      RISCV_HWPROBE_EXT_ZICOND : 0;
+            value |= cfg->ext_zicfilp ?
+                     RISCV_HWPROBE_EXT_ZICFILP : 0;
+            value |= cfg->ext_zicfiss ?
+                     RISCV_HWPROBE_EXT_ZICFISS : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.44.0


