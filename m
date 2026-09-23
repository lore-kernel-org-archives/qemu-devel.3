Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E1C9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9N06-0004Xg-Sx; Wed, 23 Sep 2026 09:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MwJ-0005eB-9U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:11 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MwG-0007pK-PA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:10 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-3396cec93b6so976986eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169777; x=1790774577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P+y3C9rGVvFAkdWFKio2TWsWiPkrJ96pOnUImryyekQ=;
 b=HN28NEllUrLRUWNkECo56HH/SWgxWa25ygdQBwJSK+GpU5z9YztmyQKc0BvfrattzR
 3vsCB7toaFflkv26PDclwdSMy7luPzZTV5tuNj82dy6p+N4D0bKrOC2hvT9MkHv28RIq
 Aeh9CgWBhxKwxCC0Jkh77e+4vgUvchIE30JVJ7ZrnXDf8sR4pfXk33Ei2Uq8vGAmuZfA
 j+z0eFqX9Z+Pf/bkQmYse0CQFPJESLQy5MyYOwIZjxnQTcHknBQ5EjM5mzstAfJuXLP0
 bwOv6+1ZkAE+INy2T+hq23ft4t/c20O2TqtR69ti/dJQtjZwVG5tduvM+CQsfZuyb0LL
 qWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169777; x=1790774577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P+y3C9rGVvFAkdWFKio2TWsWiPkrJ96pOnUImryyekQ=;
 b=F05W3Fn+VerXcKCTqY/lWPx6NGcEUhCygt2yKOqUBWrUKnhYljaSaFd3sq+4f05ykX
 05z2bt7qkjQbUavri4pJM6ZOEjtA1ZRea5WmI5LIDNkw2dUvzoXPN15AoSa9s3E2RYiZ
 RJVLNutu0Jpnz6X3PrbsO96H2yqWlyAmiVj3hpoFXIF57atj/7gwwKtILRemwXTVNr+I
 Ez/xFwsdMKb9mz2x3pP6SX2R2/dO192GctL0AfJsbqMmenckYeWrfdOSXFP5nelvLqAp
 tXPZq/I/IJgUcfsw1OBEWM6FyETh868sueHBhR0VKkobAJOiMRDdFUKieI7prbyc3N7i
 4ZaQ==
X-Gm-Message-State: AFuF++ky4MM5++epbLJIz9dz+WrYYnEFzWwht8PsI10zQ6lbPIHllT0V
 EiwDsTHz+iwMTUGrwtezRnz8P038tD28khG1aTeoCw4iMDPUhaaguO4L6Ce7UwADwGQ=
X-Gm-Gg: AYBFou2GYu3gyGdZrcoOi99zKFFmXTP8T6zSClPTiOwOiwIuYKn0U2DN/o0zpUSIzPJ
 aHuDldLpSwLakvnJ4XtWt0ZV12Je0nJPEdmG+emeisZmsbMETY6zbCHy/x42PFw6TCk2T5ZKDk/
 hqfSgPtefK+6O0xQOcQR3z6QN/1Cni3/cykfKBFW/yQhVi4U09QK9lUAf69Epc53qGcCClYHMx5
 ow8QFcCimw8R5335vWRQ6b+uZNZFCFi8HYKHERZQS9ZEMR9SGUM1ITgQXB4yzwWqairSm3b6Gcx
 F0bl82cEas5vr9nxJNTvvVTnKy9e33BT2plBnUTAYwRjDjbVkhBVH58fEFrEKaFOlrb8FL6XEgO
 7yxq69iDnnOX20EETjgZ97Y0Fc80Abn7hftg/9vAGbEdy4tj9WqzT4YscnkKH3LDYD+5xIJnqSZ
 liYZrCpJ54lLlYm3uvAMd2gQ0afZimrwAe3V/0zT+1qg9RleuvknyrtY0vQAv+o/jkwwBabwZks
 ibaG672SDwLWIvcTc/E6SS9Tlueikg=
X-Received: by 2002:a05:7300:311a:b0:339:7357:b225 with SMTP id
 5a478bee46e88-33e905f47cbmr2532490eec.16.1790169776667; 
 Wed, 23 Sep 2026 06:22:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:55 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 037/114] target/riscv: replace TARGET_* macros in CSR
 helpers
Date: Wed, 23 Sep 2026 21:15:11 +0800
Message-ID: <20260923131635.1894-38-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Use target_long_bits() instead of TARGET_LONG_BITS for the CSR
  write mask.
- Use target_riscv64() instead of TARGET_RISCV64 for MISA RV64 and
  the PMP address mask.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/csr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77b..0b96fff6b96 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
@@ -2143,17 +2144,18 @@ static RISCVException read_misa_i128(CPURISCVState *env, int csrno,
 static RISCVException read_misa(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    target_ulong misa;
+    uint64_t misa;
 
     switch (env->misa_mxl) {
     case MXL_RV32:
-        misa = (target_ulong)MXL_RV32 << 30;
+        misa = (uint64_t)MXL_RV32 << 30;
         break;
-#ifdef TARGET_RISCV64
     case MXL_RV64:
-        misa = (target_ulong)MXL_RV64 << 62;
+        if (!target_riscv64()) {
+            g_assert_not_reached();
+        }
+        misa = (uint64_t)MXL_RV64 << 62;
         break;
-#endif
     default:
         g_assert_not_reached();
     }
@@ -5430,13 +5432,11 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
      * here to avoid complaints about masking bits 0-53
      * of a potential 32 bit target_ulong '*var'.
      */
-#ifdef TARGET_RISCV64
-    if (env->misa_mxl == MXL_RV64
+    if (target_riscv64() && env->misa_mxl == MXL_RV64
         && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
-        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        uint64_t read_mask = MAKE_64BIT_MASK(0, 54);
         *val &= read_mask;
     }
-#endif
     return RISCV_EXCP_NONE;
 }
 
@@ -5755,7 +5755,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
 RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
 {
     return riscv_csrrw(env, csrno, NULL, val,
-                       MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+                       MAKE_64BIT_MASK(0, target_long_bits()), 0);
 }
 
 RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
-- 
2.52.0.windows.1


