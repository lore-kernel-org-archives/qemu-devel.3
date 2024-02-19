Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E85C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5R-0007WS-Aa; Mon, 19 Feb 2024 03:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz51-0006Fh-OJ; Mon, 19 Feb 2024 03:32:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4s-0002gL-5v; Mon, 19 Feb 2024 03:32:50 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d94323d547so25675145ad.3; 
 Mon, 19 Feb 2024 00:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331554; x=1708936354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIGwAEv7tWfbm8LJIqYCxKyeigVfLO6vfUaQ1pCq2VE=;
 b=ZPEFEJkZhXotcOq3Yk/ExyGMap1WFA1iN5wMXQWkOiGjUzkIm0BzKgNhSWc3UVNrLa
 VqUQVMPkS1vw+8qnhyRms98SmkAYB79LTKcYNh/HQspUIgykD+TOy70SFrDDPSv198Yw
 g0F12XpqWwMEPUi9bLofU7bIRkeXbqjoQKL2REFZ61/pGviGzzhcFz6WuDbVYeAcz/0N
 nun9zBcreIDMPZtvrVIFMTHvOMPe+hLAjgfbFrCJq97vBM8vvYStZY+RVfjr/QMjdK6k
 xvRlUqq5AT5w/UQctJywnGkgC9yo03eKG0XJgMPtUL2ipDGBP2pLP6IfxczbUuoguJuy
 5axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331554; x=1708936354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIGwAEv7tWfbm8LJIqYCxKyeigVfLO6vfUaQ1pCq2VE=;
 b=Fnw8cgxagIVl0R2ZleI4vyGl3yuJdkiF4Ex72ve5lT3GhcYa89C3mR2ISn9lnQUAyN
 wfhY1NJpA9OGgajp7HONKd9/ITcV0HuXUq/mqM7+A5cByn2nnl7wT1uC3SXtw+W/bpwg
 lW46HFd/MfwK3Tbyp7mvb4g78J0eu4JSxd68jU7pO2KtnrlBluwsszSdXbPX/5ShTVPg
 KFPz5mZhLz0J5UNJ/3sUupnPH5e18OGUP8kckrzLVFe6VYjJ2eA/usSIN6EE8em4ba9S
 8XvJD6dYguySMXLJtW1kvtly3S116AQXHTLsB+u13S6U1Es0wvlnMxxLsSEq0GPctZ+K
 1ZXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZUYyW9NbtrrEobKvzGCfmyAlvUKf+78j9XDinWzSBIS53+ewvhgF43/QF8txV+4hnSmnTzABVslLcKGTaShSA/3Bx
X-Gm-Message-State: AOJu0YxQmar1J11tA8s3NeNhb5KsEpEPZoAuw+2vKjf7OAVyoKXgdroc
 Qcv2LxvgIE8cxaO/dWZW0PlcWqkEu32LsIvexB+5XJgPBUPwHmdInS6fwpQC
X-Google-Smtp-Source: AGHT+IGLpnObq3dScUhG5qouR/fHBDV/6MQhHinUHhejCalQqTOOnR9qgcx4lj7fsTM9kFOJHyKchg==
X-Received: by 2002:a17:902:ce01:b0:1db:8eb2:9a11 with SMTP id
 k1-20020a170902ce0100b001db8eb29a11mr12907330plg.53.1708331554376; 
 Mon, 19 Feb 2024 00:32:34 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PULL 35/49] target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC,
 TB-L/U
Date: Mon, 19 Feb 2024 18:29:24 +1000
Message-ID: <20240219082938.238302-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

SPR's CFAR, DEC, HDEC, TB-L/U are not implemented as part of CPUPPCState.
Hence, gdbstub is not able to access them using (CPUPPCState *)env->spr[] array.
Update gdb_get_spr_reg() method to handle these SPR's specifically.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ec5731e5d6..dfe31d0f47 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -394,7 +394,32 @@ static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
     }
 
     len = TARGET_LONG_SIZE;
-    gdb_get_regl(buf, env->spr[reg]);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val;
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        val = env->cfar;
+        break;
+#endif
+    case SPR_HDEC:
+        val = cpu_ppc_load_hdecr(env);
+        break;
+    case SPR_TBL:
+        val = cpu_ppc_load_tbl(env);
+        break;
+    case SPR_TBU:
+        val = cpu_ppc_load_tbu(env);
+        break;
+    case SPR_DECR:
+        val = cpu_ppc_load_decr(env);
+        break;
+    default:
+        val = env->spr[reg];
+    }
+    gdb_get_regl(buf, val);
+
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
 }
@@ -411,7 +436,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 
     len = TARGET_LONG_SIZE;
     ppc_maybe_bswap_register(env, mem_buf, len);
-    env->spr[reg] = ldn_p(mem_buf, len);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val = ldn_p(mem_buf, len);
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        env->cfar = val;
+        break;
+#endif
+    default:
+        env->spr[reg] = val;
+    }
 
     return len;
 }
-- 
2.42.0


