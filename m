Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D75C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0eFn-0003wv-CV; Fri, 04 Apr 2025 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1u0eFX-0003wD-6J
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:26:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1u0eFV-0002E7-2P
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:26:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so341962866b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743762367; x=1744367167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SWG+87yurGrfc0u6pBf7gKgwAYM8PyLICW+shUtPocY=;
 b=NtmrL4H9PZVul0CK5Tw1ihkB4FZCBuMmhoHLFIXcW5c1h9rAhfkCcfAbzi75eZCEcT
 AUFGixEvfXI9MSsOOoTMUWkibvITnXyEVqWmk1ks6vewaA9+TJCb0z9UudCUuaUd8Pl9
 t2nhYst6KcLXB1seYGk2puFYW7pXWlwsSe39/J8+btqxwkdcaHkRVm1dQsHtO3m330ua
 kEUO4k0muBIVr+L2yrbMmQrzuKw+vn9r6luUyuknOLLYBvTOygiUGIWfD9CBlpYZaeei
 4K7b9ZRTs+h6h0ghTYMv3UBe0q0W+lSeD5r0AIpF9BWodUYuwHrn1VB7fQAGEICO+Muv
 +v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743762367; x=1744367167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SWG+87yurGrfc0u6pBf7gKgwAYM8PyLICW+shUtPocY=;
 b=WF09IAdvSDJMJi0Dg0LnnP6udBVA2fxEyPBRiRO479zk7O0Omh1gX5rKe3yFBV6kIP
 UqMeyzUX297GQR8YGsebrvjIGapPOnWdR6Tkvyh5fTnTzOsxSqZvhc0IPS2KdcDbHBRP
 HegMfFlAJBK1TlRRjFHZPJC/XFuPM2xbhqRPg8zfq+x77ptjYBKNc9ZGTGDW9cM3LJOC
 EkYIAk7CJE6HaeeQQtMIM4jzDKRA76ZLohOO/W6t4cEVhVqMgNfgQsCkx9kpf6zbUeXe
 PlseBPXDxL7h++PCw7yOaQg1IhY0Av8ebnPjF9NUFERHE2WYFeM/AbPQwkGrBxpiafuO
 xmyA==
X-Gm-Message-State: AOJu0YwB1/F0ZRLyc2OTrm4S9qIy/f6LKXSYHflAgNn8z57/FC0miIqg
 jEIQOhFJVFK0HHmMsDK7T/3xS7vxHm5CC+Aq7KNlxNpqefAwNDWDq4Zeaavpn3k=
X-Gm-Gg: ASbGncsqUulJUMERtf8PWr70P/ao3aJskze7YemdEF1EePwGOl4/hVBPwF+5lQ02OLM
 D1/Ui8BeS//ZAc3G6WM8lk8c7Md+l52OZ5dWsNU4pKgqPwd4+8W4OKyoD0lvPSAK+rZ8omBb11N
 kwo0U11gR0xxxljNOdSJMHX6Z0jcXdIsPBvG/133JDRHpyW06q5dEPA6t/6XOwqP9PHHXr9uotW
 hV9X9F7PkdT1b4rcK+niQjOgnIMVpmyUzWG+O94ujyAaHIctjdpPJRB+LKnpnPEBhAnKEuqj7zz
 XtqRiquXlDZpl7c7rC/A13aXX53hFuxLvRlDIlL/C6iImLgpCr5LQxpMVsZ2fOExfuZAobi3Anc
 AXNU=
X-Google-Smtp-Source: AGHT+IGBoyLfFXW9J50jXlV0WNnuiyGsTCLlmGEcL+5219Ymwq+h5h6tZPYtY6AFCQ747WUyBhhTyA==
X-Received: by 2002:a17:907:94cf:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ac7d19a566bmr229188066b.36.1743762366376; 
 Fri, 04 Apr 2025 03:26:06 -0700 (PDT)
Received: from localhost.localdomain ([91.90.187.210])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0186250sm225882066b.155.2025.04.04.03.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 03:26:05 -0700 (PDT)
From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, gustavo.romero@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 manos.pitsidianakis@linaro.org,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: [PATCH] gdbstub: Implement qqemu.Pid packet
Date: Fri,  4 Apr 2025 12:26:03 +0200
Message-Id: <20250404102603.59936-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ej1-x636.google.com
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

This patch adds support for the `qqemu.Pid` packet to the qemu
gdbstub which can be used by clients to get the QEMU process PID.

This is useful for plugins like Pwndbg [0] or gdb-pt-dump in order to
inspect the QEMU process memory through the /proc/self/{maps,mem}
interfaces. Without this feature, they have to rely on doing an
unreliable pgrep/ps output processing.

This patch has been developed by Patryk, who I included in the
Co-authored-by and who asked me to send the patch.

[0] https://github.com/pwndbg/pwndbg
[1] https://github.com/martinradev/gdb-pt-dump

Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
---
 gdbstub/gdbstub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163..a077c2c5ed 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1746,6 +1746,12 @@ static void handle_query_qemu_supported(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
+static void handle_query_qemu_pid(GArray *params, void *user_ctx)
+{
+    g_string_printf(gdbserver_state.str_buf, "F%x", getpid());
+    gdb_put_strbuf();
+}
+
 static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -1902,6 +1908,10 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_supported,
         .cmd = "qemu.Supported",
     },
+    {
+        .handler = handle_query_qemu_pid,
+        .cmd = "qemu.Pid",
+    },
 #ifndef CONFIG_USER_ONLY
     {
         .handler = gdb_handle_query_qemu_phy_mem_mode,
-- 
2.30.2


