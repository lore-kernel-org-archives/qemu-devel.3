Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412CBC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtm-0005mc-He; Mon, 26 Jan 2026 02:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg6-0003AB-PL
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:34 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfu-0004Pv-CI
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:20 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82318702afbso2961030b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411146; x=1770015946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XETmM2o4EihK8AYeDPsdnFJxfC4XHKe6S6lQlmdsixE=;
 b=eYHahDfWFF4r920hK66ZPecCEIXyRcDI5s1whq8qu54ogaLduvag3CjyQVEjBipGoE
 vv8ZmNSh8AA6Bo1HYvjg67r+eAKrp3YxS9TavRgA+myrVwo7tL8lY5F7mBBOojD8Z6zM
 kSJUZREkqquwEvbcGm4PwShfuCzLfCW1nGO8aNuFSn8NCO2jz5EtyuMVbW8gl+4SxPYy
 ZcuGQ/vHhQrm6zsbEdd21riRKwqMIIFtQFRA6yk/cSG4tmYUYVsUCLBkQ1fD/b6B1R4F
 ub8E0RkjS2+PhTrnsEtsHBHyu/4IIQlL36MF8ZlHTIqtbSmpNS/qFZVfW/Cqt67ej5RJ
 imGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411146; x=1770015946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XETmM2o4EihK8AYeDPsdnFJxfC4XHKe6S6lQlmdsixE=;
 b=HRphmgJqot/xpEr2rrhsQMFWlmiF07eIASuh2/y2CE1kFOi+GB/zVf4V1D1mCklh3j
 +IFhIGeBGiY7LQ9CDuZcWPxorngttvvkYw0al8jmYHFjJZG106K7WqGGtbKyVCCgH+s9
 WUBMbgV598ZnuRG7yyB0GjhjCNxb+kITzl9onu5xLf4829szPeyzYT/pJy8OZjLCh5PO
 Y/lLEJ1zkZMicuXgSON29bkJn+IVWyGSYbcD2UXTnVAo7LIU8MaoVALVmmxbDyOWOBUw
 ewXUtI3KztecAFCU2K0h3mwrckaJbkp1wGxcd2EaK03+HN7V5s6nnOol7J+S3ZFp+F0U
 Se5w==
X-Gm-Message-State: AOJu0YxTwerd+CrgV2NrbEQCW3p8cGOrsFUOZmsUHLE/28h3ux8qvyVz
 BmI30dDpQh7dtswO5wYLZSYu/3oJHpuL6+3CThx/5gwx7yzL65Hk8KNlbh7IVCCz
X-Gm-Gg: AZuq6aJ/y7e60FeOWdsiYo8R5Q1SbnL2N/nV5Kk1Qfe5Np1b94zRhkPJa74Bi8oD8oY
 CNmvoGMHHYQakhCzrGsfPvSIQPYQHw3eZBItYPf/305KZtvi85rVPViRDOncw0BCDJzHscJjgpX
 GGJdHn1ov8P8i/eEVyuG4HTEcUxuLQBj6ZABjeXJ+mDoZ11xhJx9hTuhI8H6t0XiW9gu/z72l/w
 7nww2kaKolCI+xIk3yb6WAyrnQkhEfjSb3kk2OPPJKnYUCP7oI5Iils3oBkIR0mz7UoXPj6Shy7
 LqxK2oXDDZ44qFqwdZy68k84p6Sp3jglohOg6o371VK04Vc4pHN+H49qtTBW7GCw91OayZzSxSg
 V15sTTyDf5l8vVwL/CoTsHoJwu71H1uMGLZT2o9qOua7AN/xvj1R8Je1MiDo3m3VHK7KUE6LNR6
 OCREeTOGRxVfbu8r+/GkJcalTXWITVkzUfBqXeFN1LFA==
X-Received: by 2002:aa7:9067:0:b0:823:d04:dee1 with SMTP id
 d2e1a72fcca58-823412a2f70mr3586480b3a.32.1769411146200; 
 Sun, 25 Jan 2026 23:05:46 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:45 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 22/33] tcg/wasm64: Add initialization of fundamental
 registers
Date: Mon, 26 Jan 2026 07:03:35 +0000
Message-ID: <abadf9d96d33b10b17748f4ac3b8e43ad0607583.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This commit adds initialization of TCG_AREG0 and TCG_REG_CALL_STACK at the
beginning of each TB. The CPUArchState struct and the stack array are passed
from the caller via the WasmContext structure. The BLOCK_IDX variable is
initialized to 0 as TB execution begins at the first block.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.h                | 10 ++++++++++
 tcg/wasm64/tcg-target.c.inc | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tcg/wasm64.h b/tcg/wasm64.h
index a3631b34a8..f2b67c1099 100644
--- a/tcg/wasm64.h
+++ b/tcg/wasm64.h
@@ -20,6 +20,16 @@ struct WasmContext {
      * Buffer to store 128bit return value on call.
      */
     void *buf128;
+
+    /*
+     * Pointer to the CPUArchState struct.
+     */
+    CPUArchState *env;
+
+    /*
+     * Pointer to a stack array.
+     */
+    uint64_t *stack;
 };
 
 #endif
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index bab69b00ca..f5d4cb4139 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -2081,11 +2081,30 @@ static void tcg_out_set_carry(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    intptr_t ofs;
+
     init_sub_buf();
     init_blocks();
     init_label_info();
     init_helpers();
 
+    /* Initialize fundamental registers */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op(s, OPC_I64_EQZ);
+    tcg_wasm_out_op_block(s, OPC_IF, BLOCK_NORET);
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(env));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_AREG0));
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(stack));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_CALL_STACK));
+    tcg_wasm_out_op(s, OPC_END);
+
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, BLOCK_IDX);
+
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
     tcg_wasm_out_op(s, OPC_I64_EQZ);
-- 
2.43.0


