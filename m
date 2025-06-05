Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0129CC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6uL-0004lk-L0; Thu, 05 Jun 2025 05:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6uB-0004iB-JG
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:28:59 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN6u9-0003QF-RZ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:28:59 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-51eb1a714bfso598135e0c.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749115736; x=1749720536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO8YHAQpU75qaVczSmo9gZy5vhtvQPuq/Qr64lHtiOM=;
 b=l503K6OIPNVBmdq0EJY455zNeB9xHH8rWJEQqv2LF36u5q74VVBKGVQLcRTH1ZjPZr
 KRoGkAEDW8rkjuu6yp8YeLvOtA4ug/ZwSkvMjcjqtZErk3WiOqI8QZuRKDIaFPO0Czxc
 mGk1C8LwoS5zrQmdxhFHTddryYde+0EpEjnn4DlhzS+79ebPnl6tMNfpWY9mF7Yn5q7m
 C7Fh23wvkz1VDxgsTxNdPZHGlqMCVa9zb9BhRP9t7byh14fnDzpksyrRaVE6SPvuU2Mx
 Mp+SME2q0M+zdXsegLXXgJU7NHSkC9+WWhK68Pwn4hEW8BZc1XsUYddgSpJSYeFb5c2O
 vdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749115736; x=1749720536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DO8YHAQpU75qaVczSmo9gZy5vhtvQPuq/Qr64lHtiOM=;
 b=rDtbMw3b8EFkQO5TkueVMEVBmbQHxmqRqJSUgmQ06xHyv1qPB678BO+6PlcNvpE+wa
 +qLXIZeteINaUXWgHZsI/zGQIUETjjUbJQl9eTQmnZcBpLZ9SRBvc5FpJZ6fkAGCKgJL
 2r+e+PAcfBkxNvV6162doBE20hMYbrfli4v7msyieyv6K5mdUTQKfrPlSu5D8JSWmNPy
 JdO8O8Wx3h0/GiEUFCXip3MDp8P3hYn5Wq9AkoAxxWnr40rggaqJkOSrATfl48xBb4SK
 5EzDCLKtc9YnqXNxj6STO/z3E8Eo+1HEhHyuDDI92hgg8EaF/she4YDsGwq88MwWo3Kc
 Qbew==
X-Gm-Message-State: AOJu0YwUGhoQIl8F2zyU09pfiaOGT8A0zP/OZn9Nn4DLgg8j/UWICL0O
 QHtE4Qv0BrfmBu6GjoIABcOpfaZzNFYybzYGcGkxrdrWT8SepP+V4f99cHJLIC6wpHiOzR2bB6B
 V55yaNyA=
X-Gm-Gg: ASbGncutP3eW1bStiPOvZ2z0YbdCLB0iiaIkHWUdUAgITgKEssRjInrgXHpeOzSF9Fu
 dQAKD42/C2o5dw/+QO0ctlquIcHqzWD1E7TAJA8DEF7TiD2TIoYo6pSdXu9ovtQySGP9ErQKgSU
 Of2uabYlKvoMbjnzwMtad4MHBk0rnnc+gKf0oEoSr+GgvLXollR+LLSUMMTqTh442AoXd6CBrap
 8FtFmwdsEyIzIVXxJVhYH0SBlZfRox1ioozdIn/V+Rm89l9oOx1F08mjWJt97UhNkvsFhD8XbB+
 kR906FTj40ViuV/xWJfsYmsjBwRI9w8HvcVag8pIxYCDPQSy0SotpFcXVngnFjZlJGGzugJj2Na
 TGN4w628qsZ0xB0o=
X-Google-Smtp-Source: AGHT+IEjwhYAY9lxGzRrEDiKcxrhweRLC1jsYzWm4xu5oTWBYgG4A4riYOTo0xpmEjK9asBcymYJaw==
X-Received: by 2002:a05:6122:3193:b0:530:819b:9a3c with SMTP id
 71dfb90a1353d-530c72540f6mr5469480e0c.5.1749115736203; 
 Thu, 05 Jun 2025 02:28:56 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074bf86b1sm12311772e0c.36.2025.06.05.02.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:28:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/3] target/riscv/cpu.c: do better with 'named features' doc
Date: Thu,  5 Jun 2025 06:28:36 -0300
Message-ID: <20250605092836.1383882-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605092836.1383882-1-dbarboza@ventanamicro.com>
References: <20250605092836.1383882-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Most of the named features are added directly in isa_edata_arr[], some
of them are also added in riscv_cpu_named_features(). There is a reason
for that, and the existing docs can do better explaining it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 058387ac48..798bfed6b7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1377,13 +1377,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * 'Named features' is the name we give to extensions that we
  * don't want to expose to users. They are either immutable
  * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state. They have riscv,isa strings
- * and priv_ver like regular extensions.
+ * the resulting CPU state.
+ *
+ * Some of them are always enabled depending on priv version
+ * of the CPU and are declared directly in isa_edata_arr[].
+ * The ones listed here have special checks during finalize()
+ * time and require their own flags like regular extensions.
+ * See riscv_cpu_update_named_features() for more info.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+
+    /*
+     * 'ziccrse' has its own flag because the KVM driver
+     * wants to enable/disable it on its own accord.
+     */
     MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
-- 
2.49.0


