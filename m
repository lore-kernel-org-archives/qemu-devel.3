Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB84C52CDA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZX-0006q2-Ps; Mon, 29 Jul 2024 13:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZQ-0006Ig-Dc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZN-0000Pw-K0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:54:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d153fec2fso2795459b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275640; x=1722880440;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3J0a7Kk8VH78Rf/KPYKxAa9BurTiYRdK3RsGWQBTas=;
 b=15OOM8CmUf5KAi1dpp+tfOmy98Hx5hePLiiFc5oViD5ltC89qYrbT7WTPPyLT7M3sX
 xzjfgDFnQ4JcRlsCXSUJb0xUgAH3cAHG157CYtCf1i3urrRG9S1RnkcLyc4gUM8MSbMH
 WdtcnUo5N5JUg/nh/AUfWIan01Hn1T+UnkvU4aFKC2+6OPlK9qHuWTfFybRjQdzn7qpV
 qbwgiAsjsdc879CDp5aqMR/I8U5QGIlgiZOso6eVtZCFZw7lYYUxB0rGugB9zNtVP1VY
 hmqiZMHy/P4lIjAbGeYoWp2BC78ZBn0Jhm+O7Sqr0Q0aipgamOSE9eri9Arrl5+zZXR/
 xaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275640; x=1722880440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3J0a7Kk8VH78Rf/KPYKxAa9BurTiYRdK3RsGWQBTas=;
 b=He21e2qXFwZiEe6EZPXD7+/pB1XEK6okn0MYKDRutmiqgQoWuXsjMXUae8Bapb0Kcf
 L2HUZbTNhOZD82tAWh6kSUd1POel5UV96VOiC4WPXdwpBK8p/iGTyWb6NiconlBfreN3
 jDeFYEpsEVXoln4EepqUpAI2YoUXPrvDGnzWED5vWlmIQhjhFm7t5QYoCpV57rsCYsZY
 AfUWx95AKTfClaCdrzLyXeBaqyumAXAizYjkasPC+eiJTW4cuTXfXOq+h8xfaeKt3HOh
 U0NN30F6mRBWeXUL5lgZxpGbQ3+HXZef2xWfYu8p7PG7Hfr9Gy/Fs5Hi0LcU3ha5gpiX
 6xXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgvXEhALZ6EavGwqqIn4tynJL3XZFbG3oEWHlgJHWgwiZ4tjX8faDBHa3wygf9GOMNmyl2nnDwexHj+wiZ08Nov9Vank4=
X-Gm-Message-State: AOJu0YzoIS08vk+TDJH6RJqcX/2xYldQi0Tx4pX5L8byCdJzH+kmbFka
 Ncg2SRUtUiraednPKOOgVtrmLXQjivEtADfFghWZ5NsJaqG7ymSDvWZftXV3h0E=
X-Google-Smtp-Source: AGHT+IGyb7t92TbYrkmTmHHiKjTKiGmECLntJPWTfS8dwp20WJtnI+6yJJ/+mRyAHYGwBDukrI+9gg==
X-Received: by 2002:a05:6a21:9994:b0:1c0:f1ea:adf with SMTP id
 adf61e73a8af0-1c4a129d460mr11457487637.16.1722275640068; 
 Mon, 29 Jul 2024 10:54:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 24/24] linux-user/riscv: Adding zicfiss/lp extension in
 hwprobe syscall
Date: Mon, 29 Jul 2024 10:53:26 -0700
Message-ID: <20240729175327.73705-25-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42f.google.com
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


