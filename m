Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AC5C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKZy-0005x1-8Z; Fri, 09 Feb 2024 01:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZn-0005kn-Gn
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:32 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZl-0002OE-HY
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so918301a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707460888; x=1708065688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUtumchVWAjnFsnLqrfLNxKYwp3IzTxvepBmSvQHMis=;
 b=USnNRk/B5IDja+g17J+m/dD/Xk7l7RxMTxxANfYgv69tquNdeLLa1tSesk3dRJkD3A
 KbY5BeaRYI+wXV9haQVmNI4bqhwOJ75jztvdvQnDBv7Q91DWigz+NugdGMzkgSvTws6p
 TlVjmw1CgQVizz+EPPRKci4hwjbvkiQJFtH4BhIOPTZ35kDHuZKc23UCCNI2sn3680It
 PaBkLF3tYq66LtwQsjIL8QHejva6H74NCYtbX9bV6LAjhWPE1cFSp4gneZiA7KQUfv7A
 Oi2zgKUWH9axdyMi7QY3+Dijla2ItL4Ctm0prtovtG4ZDc2F/uFQzohWrIBVuvLkWyoS
 IQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707460888; x=1708065688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUtumchVWAjnFsnLqrfLNxKYwp3IzTxvepBmSvQHMis=;
 b=nHwBjo2rpaVcK62/ay4OnuFTzBHp3I0nI9vgtByY+Rj45fW3mABLvpmJwoIrUuNBzk
 FpzglVeqcYPT5cf/1nDGuuLcAblBrBWefazHPSj4sprerdUf1dgq1hWEBF1l+XFnpTt2
 e+h18imT5HcEPbAXf01yc8n6r1BnSP/H97T8s2EdsSvgzhMFbWi7RAtT4j0vF6x6fs75
 t8/yDw5k93kt5CTFMaiz+R9m7ubNN7VSUBoGOZyHLsS0mQkF6ojJfFSyJSXjkepkzc+w
 9/uAdJ5FPz5OVtq052GLLXFtnXz0nuPtmnf3/uC0K7CcsHeJAqcH7X4jsy9BDzzSS6jy
 EuEA==
X-Gm-Message-State: AOJu0YyKthsEuRYfN7wIkrpo2JVbuo9Jy32hcM+WS3cnMiZGV9onElCa
 DrHuQdI38RjsyeXkQx4aPitQjgXdGbu+cYFq4cleJEFK80NoHbzIQN8zXlRfVSk=
X-Google-Smtp-Source: AGHT+IGsK3WqE/n5HdtWollG/0f1PKEWUQcdsSUUHRmuIs1eIfzrw80IAhDLp9C+l4mUaBLJRqeiSQ==
X-Received: by 2002:a17:906:b2c9:b0:a37:76df:be40 with SMTP id
 cf9-20020a170906b2c900b00a3776dfbe40mr469668ejb.36.1707460887941; 
 Thu, 08 Feb 2024 22:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWmMnpgfP7SL9AMOeYk/4RPOp12RZO/c3RGu+ogxsjxT/R3WKCdoR2U6r0eKrwFHykbSSVctB0wHpjiQsbytjigZrYZ3ifQwbGm/9K6bl33U8UTUSM/lKaoLPbJVCNPmBnQrqHCpDpPBwkPM7LR0e6Xa593sWHnoscIDAc1MlEU82JfzACVm9SPJ+s6ISMCyjSuIa3kQ/Rb7Oo7UyudanXpaXYWhjh6gmKzVrHW6yyzMljVtHc6C/a8LdrHQ5aa3WK0dNF8/FMUB6B1AJruAFcJWUvC1SUSyCy2WblzBKoQF1Af5Vi0RJYFD+/ttLFdfGzjQfQMjmjQc7HZ5JIsHJxRn1pZQDHqNZrujw==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 vk9-20020a170907cbc900b00a36c499c935sm450575ejc.43.2024.02.08.22.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 22:41:27 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v2 2/4] linux-user/riscv: Add Ssdtso extension to hwprobe
Date: Fri,  9 Feb 2024 07:41:15 +0100
Message-ID: <20240209064117.2746701-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
References: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x533.google.com
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

This patch exposes Ssdtso via hwprobe in QEMU's user space emulator.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 24fa11d946..bf0d66b8a8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8829,6 +8829,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_SSDTSO	(1ULL << 36)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8947,6 +8948,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZACAS : 0;
             value |= cfg->ext_zicond ?
                      RISCV_HWPROBE_EXT_ZICOND : 0;
+            value |= cfg->ext_ssdtso ?
+                     RISCV_HWPROBE_EXT_SSDTSO : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.43.0


