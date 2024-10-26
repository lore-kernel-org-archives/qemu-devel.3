Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1591AD10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzQ-0008QP-6o; Sat, 26 Oct 2024 13:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzO-0008Q3-0C
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzL-0003lw-Rx
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso2322412b3a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965250; x=1730570050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUXo3gWo9LQ++O+bqUolSjJXO8UGvTh+04+/9wrBtPo=;
 b=woda/0xHGTgQ+NyZvItHWiCHsDBUhcrxifMMriP8b/PNZ7k8o0nG/+seKWmyeHA0jk
 NsbXZ9e/7f9hdcg6RP2iAMyv9QNrdvU+F9r9eSNYhceK5im6CA+i/bOq83C52MEY//vg
 TU+2Tf58xYGPd9hzkrOlVw6xoinnfTlHVwdiVsTlVkqBYRTjjuMCY+iwlTW5M3w6Ny7I
 dc1KD7IOzH4kDlw76GnxaGoxjGUW78X/siCnb0Hv/xzf+dGUCRSezbwqreg8JuEkDiAe
 M83zzb6zQxhAMONwSLsPTVNjA0/cFBjVbpOi+g7VDIOtROydx6xytWOvu7CAjqnKjd3O
 ooRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965250; x=1730570050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUXo3gWo9LQ++O+bqUolSjJXO8UGvTh+04+/9wrBtPo=;
 b=pcRILLe9lZFFMpgKLCUF+YmzB5fyRnF7vOVw1APoTsj2NKV1ECxsWBH9TmWZsqQwmZ
 sGLprOg9w+qnifCaKGmIDWX2k8HdeQfWfxtXC/0DME0CeFiBVGv8VjGMB8u2BXYkYcAf
 ikW8n4z0z5+BoTRkNYL90EXw8mZvckC9tLkul7pM2kiU9sy6FUhD6qFbVFQCGAK7OjX3
 K4Q9q8UHjUNlbu78a26e5iWWSNYng9mhi9mFdt21Nr/TCrHpguSl9eZb+8FkeQbSgMuz
 UV/gBWV4NQo2v1BosRucVDzAfe4LLN1LRMSQQH3BuQAVjOULFb7hXrCIdUBt4KDy5La7
 NGpw==
X-Gm-Message-State: AOJu0YwxwjTdjymvVJBDM6h2Qx17Pn49V7U7BdJYzkZdKKsp6SB/oUhh
 ZnqPwsuAFKKvO8IK7/tFth8Blc9pRyaQY3Az8vpMKHg/Hf8NZZo3x1qIoPmCvbSf/j5ZxbJoJZV
 y
X-Google-Smtp-Source: AGHT+IHbUzSa+Nj+UgwNAjqL13Pr5jjQ3Af9zwm51m/fKPmu5s6qzgviFUFyYabD6Ob0/hhUT49l+g==
X-Received: by 2002:a05:6a00:2389:b0:71e:8049:4730 with SMTP id
 d2e1a72fcca58-72062f85458mr5161984b3a.3.1729965250369; 
 Sat, 26 Oct 2024 10:54:10 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc86a8b37sm3029998a12.56.2024.10.26.10.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/9] target/mips: Simplify Loongson MULTU.G opcode
Date: Sat, 26 Oct 2024 14:53:42 -0300
Message-ID: <20241026175349.84523-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since MULTU opcodes don't record the most significant bits
of the infinite result, sign-extending the sources make no
difference in the result.

Once we remove the sign extension of source registers, MULT
and MULTU are identical (as are DMULT and DMULTU).

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6c881af5618..6d7e913263e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -3615,8 +3615,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_MULTU_G_2E:
     case OPC_MULTU_G_2F:
-        tcg_gen_ext32u_tl(t0, t0);
-        tcg_gen_ext32u_tl(t1, t1);
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-- 
2.45.2


