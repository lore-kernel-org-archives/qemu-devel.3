Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABFFC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbB-0004qS-Vv; Mon, 24 Aug 2026 01:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZx-0003QT-AC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZu-0002UH-EH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so2591115a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550637; x=1788155437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVsDsTudT9XSJrI4vG0rDBo8u+xmKSjOUGQovOsJcVY=;
 b=XNiv7DOhxhmofmkHQ1/m20PdA1d/pIZwfReBkIoHShXh9sbvJnJcYRlkc5L9B/6Etl
 cy4xdBe7lROXM3kciYvPkr3r6abwgzAVhP/V14he8giW6qUPjalIiJZX5AH/1hwf2Fm2
 RX8ly3aBtXdPOJ5a27nOP8Ilt5bo08mug4ksDY52JNWmd276Dg5MyKu+eI3jvU8eoi+g
 SCR8LRDUsrsCUr3W+Ox7dak4ufXyiKWqXa0Ncd4qZyg9X7rZimkdyH5/fTCG2h7Dj5dH
 QP7inpH4aklYXHrnQGPZuiNOmgb6AkS5uzSDm3mEFNDh8EeqcycmFctUcFr+EuAFJ8GX
 uriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550637; x=1788155437;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVsDsTudT9XSJrI4vG0rDBo8u+xmKSjOUGQovOsJcVY=;
 b=P3AEmC3dcxj6/tBbbvksDRk7UEh1MmJFScCkhqeiGFrpy8pz9mmaM6HACxo66QihbZ
 HtZIxuSHISCtWEazUIAwajRLBvbaIBCMHeJMpQv3YIP8+q6+62Ihg2jgMLmLtuNi6dOc
 JkaNAGqgFRagyTrozGpKik/SUHV3LARlTIOHqevMlv/XzhHM7fGBX+xPa30EMsuKLZLZ
 ZMrNQI5zWUQlRJ2/cztqiqK+Opafs0XMkfes8R8UHEaBu47boItb+6dO4aDN95ruRcbK
 OWwoppu/wD3t1F40kg6G6AjjJaDQ4zWWIobsK1ZX1bAHbiCqptisEBq1HaDJNUHON2Bl
 Nqbw==
X-Gm-Message-State: AFuF++k3/8SMA+C8Ti5Ep7n94/FNOy/rp3NJ5qHUPrMWzWPWlcHdpPN2
 u3BYBRoFLoYDS01xrmhy9ylw2mJaUOzMHPym7n7LZ/GrpDfXSRlbcKMcaiEd9w==
X-Gm-Gg: AR+sD12ZtbbJhjutsK/h1/sTwKymCWhObHVH+g3xe26wGOqF14ByBKHLyg4zaqTeplH
 ogx9VpnesFOrgFT0f7GJi35YdYr5CB3Uizi+93TF/s5d6haBI8htNg6PF32eZH49CD7G3JqnW43
 0a6aWjDMlI2OOV6Gb77F0Sbrr+yJIYrU92zSJzm1pijVnNXpwsgrgAfrg6ync1WXXKex1Bj5efx
 xZoq9CvylyJL7/V/zMavDpk+uKoBGBscMs4qRrdNTYRePoKliUDKHt4XwRIBvQcS+zHvrj8hCCT
 B4r8+vAb3u7GGYLBysIrZngT/Uyfnex5bjY7ZUQFhrMKNG7pYPGgUYzJxrA1EkUQVoOm1EGOxmZ
 tB6UvFAC119OQMZ1A8cTSmmPbdFIuTW3yQWGvo6nSFXvqCpOTH5/3Cfj/6l34i9SPBbUtJwJkY6
 qdRi15pB2mi8PK2Zi9Zcfc40OArKcblTAqURaQaj9uMYqzfPjlH7VOqVJDmssnXATYc0ameP3T4
 zKK1w==
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr40078621a91.2.1787550637168; 
 Sun, 23 Aug 2026 22:50:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 44/96] disas/riscv: Drop useless const in structures
Date: Mon, 24 Aug 2026 15:47:14 +1000
Message-ID: <20260824054806.2790041-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Individual fields should not be const, only full structures.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-12-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index eabe193b4f..3325b7b4ef 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -174,19 +174,19 @@ typedef enum {
 /* structures */
 
 typedef struct {
-    const int op;
+    int op;
     const rvc_constraint *constraints;
 } rv_comp_data;
 
 typedef struct {
-    const char * const name;
-    const rv_codec codec;
-    const char * const format;
+    const char *name;
+    rv_codec codec;
+    const char *format;
     const rv_comp_data *pseudo;
-    const short decomp_rv32;
-    const short decomp_rv64;
-    const short decomp_rv128;
-    const short decomp_data;
+    short decomp_rv32;
+    short decomp_rv64;
+    short decomp_rv128;
+    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
-- 
2.54.0


