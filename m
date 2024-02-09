Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E1C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObg-00032K-Mo; Fri, 09 Feb 2024 05:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObd-0002kE-7a
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:41 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObb-0000JU-HN
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:40 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e1226b30ffso427222a34.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476378; x=1708081178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SH/MPhbggH4z6PFbdxlGS1PoYoIe5/dIBNiVpNq4DEQ=;
 b=F2XuqGYCT9JmfeJ+aaYFdv4RLOrMk+xFOIcIMy/BMGel/FN8L9ZuTpf4THRiAnzUqP
 Pr0/Z2ylvGYcIQrUuwJCkNgqKhKml4eoUDl6HWfJ+2IOsYdvhnhhJunocQB+kUFnlX+U
 C2djxSXkLf7UmlzqLngM8viRL7/29tA+Rh4iuAYmUoEsYepItNF6azKBKKm7Rl3yNvzk
 pHKBK32yDOkpa1qKIOkghB7maFN/KgkrNXuj2pHGnymRAbzzL/I1wtFMV3j9St5XVYMz
 3TD/iRjPdwGLG9yZqwe5gAe7aJVGMKLH0t0qpqTQobRdujgKaovcb5hJMNjSCebRkYDJ
 cLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476378; x=1708081178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SH/MPhbggH4z6PFbdxlGS1PoYoIe5/dIBNiVpNq4DEQ=;
 b=l3/vmoN3dE5JnOZoNxD3G3UZL9esieU3MUiG/d7DKUKMs/i6PVJV+tDSd33p//KrfH
 YDQzfe82cfHi7RHecQQctVLANtUZdaLjTYJne+f7r0LfGnoY/fzqoacIYhdXAduJe6uG
 Ijzuaju6sZEi/9rS2Ou3A2cPZYM/l1Z3qgBZStsCwfGeLkHicvEhxW1MAWG1Shjkw6jI
 91gNDDYs/6CqUJjIqlaCAv/+Ln/sppchVINYOISTPxTX19Y9riHtKsROOq9TqvDXd0e6
 y3AwUw5Wa3v24uxRTAxekQQ7h2kSFTeBd8ZJsxu0CV+Awbq/sqxsUz5I9wbLvoXFCann
 MCsw==
X-Gm-Message-State: AOJu0YywiAM2Pw/ABVSIOAP54WOuGg7oDNam4fkwjMMAkKDVhUinPV2V
 mT5R7Xv+Ji03JuFYaeQYe4HWWIjeizc6kVUpA8QQ3QrUCaBrbHWYcXuBEQOEEriFcA==
X-Google-Smtp-Source: AGHT+IGdCRwbY0jksoHnsEB8+OjdzgBXG57ay4YItaHeGljkPCllQLbva16Q+qxYfkmhoWfJVuizEg==
X-Received: by 2002:a05:6358:7e42:b0:176:8101:7573 with SMTP id
 p2-20020a0563587e4200b0017681017573mr1160460rwm.22.1707476378004; 
 Fri, 09 Feb 2024 02:59:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhDy7CN0cxNJ0RKrn4igr0GP6Yt9S8GVQCNjTw2rNoEAkJM8rRII6kJNE7u5D0pq3Y2wKkVXAp6VMmy6gjT4LXl3Cd2EP4iYQA56J1apFH9qgBedga9FzBsvVPb4p/mK1QWOYgoDqgsLxT03MqQEX4qnefNOerLBTNyXx6ZCKG3Vs=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/61] target/riscv: add 'vlenb' field in cpu->cfg
Date: Fri,  9 Feb 2024 20:57:34 +1000
Message-ID: <20240209105813.3590056-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Our usage of 'vlenb' is overwhelming superior than the use of 'vlen'.
We're using 'vlenb' most of the time, having to do 'vlen >> 3' or
'vlen / 8' in every instance.

In hindsight we would be better if the 'vlenb' property  was introduced
instead of 'vlen'. That's not what happened, and now we can't easily get
rid of it due to user scripts all around. What we can do, however, is to
change our internal representation to use 'vlenb'.

Add a 'vlenb' field in cpu->cfg. It'll be set via the existing 'vlen'
property, i.e. setting 'vlen' will also set 'vlenb'.

We'll replace all 'vlen >> 3' code to use 'vlenb' directly. Start with
the single instance we have in target/riscv/cpu.c.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fea14c275f..50479dd72f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -140,6 +140,7 @@ struct RISCVCPUConfig {
 
     uint32_t pmu_mask;
     uint16_t vlen;
+    uint16_t vlenb;
     uint16_t elen;
     uint16_t cbom_blocksize;
     uint16_t cbop_blocksize;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cce75aec3e..d34e87684d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -852,7 +852,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                              csr_ops[csrno].name, val);
             }
         }
-        uint16_t vlenb = cpu->cfg.vlen >> 3;
+        uint16_t vlenb = cpu->cfg.vlenb;
 
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s ", riscv_rvv_regnames[i]);
@@ -1325,6 +1325,7 @@ static void riscv_cpu_init(Object *obj)
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlen = 128;
+    cpu->cfg.vlenb = 128 >> 3;
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
@@ -1824,6 +1825,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
 
     cpu_option_add_user_setting(name, value);
     cpu->cfg.vlen = value;
+    cpu->cfg.vlenb = value >> 3;
 }
 
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
-- 
2.43.0


