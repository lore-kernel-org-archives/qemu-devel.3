Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A787C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1j-0000L9-DM; Wed, 01 Jul 2026 06:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1f-0000IC-T2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:41 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1e-0004eO-Ch
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:39 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-13b355fbb1aso1329039c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901117; x=1783505917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcIRkGhhyBAlMl+YVxltb7+6Up2QH7Eq1tUIuaL2RG4=;
 b=loi43g23UbzOU825qPZretB2byPYHzy/qY0IspgVXr1Awmtdz7fY7jYOwI8HtriqWc
 zZw0ygcPTXLv5gQJOviQLlLyMja1D7N/PcKUeifUtLzTbx4fRbdW6GS72/iFRozWqG3w
 uVv0adyV2hx5Qk8Wwr10LyWomJLH0uVlubNh3B7tR2ViORXd+HE94VrMzxYK0z70+M8+
 /9Cybg94d+DTBLLzHaYOPwmyl3C3OLTTqWBh/nSUqABWbd/5jK5o4Whq6t+2yprT73JN
 dHrc/ini9uZ9YlbY+JAmjeREovcYnmOfNc8giz+4X52DG9TlmYZ71/16gKx/ZtrqIeTN
 rdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901117; x=1783505917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zcIRkGhhyBAlMl+YVxltb7+6Up2QH7Eq1tUIuaL2RG4=;
 b=nZSVpIINoLzjDoAsPX6PAVxdLJkG9cpdb5PUIdFDztJbZ9xlRTSKuj6HsbQW1lQaIi
 /I+ML5MbURT4zR/1tDinE02hqjXwPMTdwqQJ8UiDgN4Y2Bd6rHoONpDCuxj0hCmIqN+4
 RWceXVniemA1oRQXnb8nwRD6CAIe2KbeZp4E0UtrAG/10KFwgNzZiEbF9iLlbeAmrYQZ
 Eq6E/mRIVgbXOt3YTz1NHBFJfGKhTdzNunzmX8zTUobMEeuLR6wFo5BHDd6kpvUpRiAx
 JqiFlIF4NUGx8K+Sh2ER7jfvKmjYc5/F4W1xNNadnaREiQKrXkEwBxQUOG9pGN9dx7oi
 wq/A==
X-Gm-Message-State: AOJu0Yw2u3NDabciex7iUCd5R9i7Pbki/uhlvyXIREwvhQkXPWMEtz3r
 YNOQIVKUJKUkV8eLqlpSbr6xlFhMnUg7HjKL2HxwopnvEui6NVesenbI77ihVg==
X-Gm-Gg: AfdE7cklgKCBZ7rWq8WFLYVolBj/eCS+8hVjxmfVm2i5PpipMofnM7GujHuTu6YrCv0
 gstPX9a3n1hW19nRIbovSD0Pblm9/VUk62alet/cw5XqA9pHH2lsdFhgdvH1RElyoc8fZyZdSku
 A+dOXocm7WjVoVRQqRy7JBJ/ghgBBznTNxUU7qJv9Wuf/uObZsAQ6eNxJeBbsl6HKkEFozgqNCM
 qteh6zFAQMp4cDf9uPcbk9Vm4JgosirEbu9DAD+EZ3gGZayzPMzF9OCu0Jw9siuymsvF36E6eyM
 cQI5AZqLAs6/z4aKGSHIHmIDrmt3e/419zul4MyzKWVRA1VEYJNecyvcWQ+87pUWzVq5XUQ92oI
 vZGDaV3m7ko+rebtnwTmlVisq0XwH+1sV6VprmEty4IsRBTqFhehA8EC5tqsrpSVblPnTUBwTMT
 KL+mS+nym6QuSTOiiiYDctO2DfRtihOUc=
X-Received: by 2002:a05:7022:698d:b0:139:ed5d:3aa with SMTP id
 a92af1059eb24-13b3914bfe3mr189618c88.47.1782901116817; 
 Wed, 01 Jul 2026 03:18:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/39] target/riscv: avoid abort when reading vtype before
 env->xl is set
Date: Wed,  1 Jul 2026 20:17:22 +1000
Message-ID: <20260701101752.2522962-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122b.google.com
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

From: ZhengXiang Qin <qinzhengxiang@foxmail.com>

TCG plugins may read registers from the vcpu_init_cb() callback.  For
vtype, this reaches read_vtype() before env->xl has been initialized.

In that case read_vtype() currently hits g_assert_not_reached() because
env->xl is zero.  Fall back to the CPU's maximum XLEN only for this
early-init case.

Fixes: 638181a180bd ("core/cpu-common: initialise plugin state before thread creation")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3545
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <tencent_FB929239B227F05F30D62745E38BA01D4307@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a60a796725..7fb0ad5bc1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -949,7 +949,16 @@ static RISCVException read_vtype(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     uint64_t vill;
-    switch (env->xl) {
+    int xl = env->xl;
+    /*
+     * TCG plugins can read registers before env->xl is initialized.
+     * Fall back to the CPU's maximum XLEN in that early-init case.
+     */
+    if (xl == 0) {
+        xl = riscv_cpu_mxl(env);
+    }
+
+    switch (xl) {
     case MXL_RV32:
         vill = (uint32_t)env->vill << 31;
         break;
-- 
2.54.0


