Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E2C88E57
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGl2-0004xE-H8; Mon, 26 Jan 2026 02:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeH-0002kL-Oz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeD-000455-Bb
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:32 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8230d228372so1748636b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411066; x=1770015866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXBe1C9rFr756wJ0chsOZMSPb6pQczF5N8rNcYW9UcE=;
 b=ACr9kHGodA8V2izDC5ZduCGynnnEsnfpGsFM9g/zYNSMfqnbw+ENsKhuJShI3nBdQt
 oGpcfYmDJQjP0+Z29JhfjmybUsc2HxhdrKGw0ndymNa+UzRgu81boGj05qbjzisDOUSI
 G76pp/35bSyelTmR8rG4AVH/iV+iTNKs1bOeMaW+A+vbOJgS1W7JbZ7zKyoCYIc2FluD
 ffz/+k8OxQa7sIgEld3iCqP+sxgq6Yon3CIZ5wmC6XcATlavQRutS579mT9NgNQbnpsd
 9FyzE1+IG2X7YtiUNXd3l3Gfa7a+LRa1OA1Tae+UQoPUO9FbwjXzdZwPOOaRqP8MmfLi
 c2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411066; x=1770015866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TXBe1C9rFr756wJ0chsOZMSPb6pQczF5N8rNcYW9UcE=;
 b=T1WIRAeynI2FOsUsGuPUpFouyvj6/mOTC/5bZJnQnCEic+TrXtHcAEEyrsK9DFPXfa
 s94XEwgMdGtTTLPz1EKwchT+DxmTjhpJXMyeOZqiJyGGZp3CjCE67gW7vMQdNgpkXK2p
 b57WTGGSfgpe+6Dzoiz6/43sJ6z0w8RFgcMuiZc3tb3mDaTEx/6RdTQwquyNO94gJXdS
 +wikvd4A2owsQvC9UYnm9r1DzxQHkBbqn3Y8TegK3PXoI6czoVo4Y7jSs2EylMdit7/7
 AOnj3vUUEoetV8yEPudHS2KdSeP2NLwty7S2CnW7nctj5O6v0Zk9MPeMQYkftBDy6RCy
 nw+w==
X-Gm-Message-State: AOJu0YwtvjDPXweOrZpDNBPhDr3Vow6OlXjPwsW2OR78q7DyOpoKX976
 jkmFrNXBXsvw/+ahZCHhdS2/eqAtSMt/b2vqrzZo/fvLxwSTfYCbn4W8xrkxgEun
X-Gm-Gg: AZuq6aIuit/waEZgJZPwmoO7TpuIERPJFykp9e85w6Jr6RrKj/svkjnoujTffLQOQMy
 szJqSSFzYF3sIExoCMKr03msZABbChdpEyZmwsYIm4Yt9Z4dyoDizlBxi16Cj1WTmK7Uf2yKV7A
 4hTG7jmCkboC/udDio1/XrZY5r/k7lw+Vj7l1x5oUqib1+HLeJTNlUKLJFjNOTIPvPXp5+iXyYN
 t1mAS0G53rWgTH5gKkTGaVv8+mxtwaezm8EMBOr2/wOBgj3T4dKlDEyuOIJzeE0GHwWvNr2Gj6S
 u6ZRkYqSilomwmS/FJnnKJPBwzxdCHr4tOpDoIabu7KfKMitG9exZrgs9x5uELlnkt/zArJo7yi
 28u1jxpKJ7AAUKSWJk8/p6wLzilCcJDQW/EztY3mj1iZCtA6FcGWiC9vezYxmpjzDrSf4TAKbZf
 Kafy0u4ROtXSRTGoKal3XGQ2qzGtVxyWu5sGtZIU3Iyw==
X-Received: by 2002:a05:6a00:1494:b0:821:7ee2:b692 with SMTP id
 d2e1a72fcca58-8234120a841mr3317785b3a.2.1769411065767; 
 Sun, 25 Jan 2026 23:04:25 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:25 -0800 (PST)
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
Subject: [PATCH v4 04/33] tcg/wasm64: Add relocation callbacks
Date: Mon, 26 Jan 2026 07:03:17 +0000
Message-ID: <777003050525eac85580bd75bb5473777c278c87.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Relocation callbacks are used for the TCI instructions to preserve the
original logic of the TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64/tcg-target.c.inc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 0b12c4ea03..4bcb594360 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -88,3 +88,24 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     return ct & TCG_CT_CONST;
 }
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, sizeof(*p) * count);
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    intptr_t diff = value - (intptr_t)(code_ptr + 4);
+
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(type == 20);
+
+    if (diff == sextract32(diff, 0, type)) {
+        tcg_patch32(code_ptr,
+                    deposit32(*(uint32_t *)code_ptr, 32 - type, type, diff));
+        return true;
+    }
+    return false;
+}
-- 
2.43.0


