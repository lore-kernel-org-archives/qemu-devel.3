Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCBDC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY26-0007xs-Sj; Fri, 23 Feb 2024 11:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjv-0006OY-BW; Fri, 23 Feb 2024 10:45:31 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjs-0006df-RN; Fri, 23 Feb 2024 10:45:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1db6e0996ceso7889225ad.2; 
 Fri, 23 Feb 2024 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703122; x=1709307922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ncHIEJMy4cYDbqfVJNjY8yl/TUUZBGM2GIItC5uR+8=;
 b=lryJRjz22gVl5BGU1a6Sg0Qtv8Tdpqsc3lrJEFgJWya2dqCUiw31Sw17sNHT1eJUrO
 dG1wqLhD5r+UJLYs7PTUmV3vB93ZYuNlRp+S5+/BgRQTqjxLZqT/WXADhnwr/HhLwTUq
 YNbCGHL3ONMhaNdEsOp2zgZ5fbQDsPUGanVx3/Rvb0+cpBl32hZU5RKb12CclBLwsw6v
 pgMLidm/55/YhO/yEACni6T0QjcBrweA5DcAnnHnifBBRELDMfR1dSaENZZE5w2YMOmC
 PGTXizl7glmOeN1PoSxMe+i80uhiXKCK7yk8DK1diIKckig9PGvgRxx2+Z5r2ow4Szco
 qQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703122; x=1709307922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ncHIEJMy4cYDbqfVJNjY8yl/TUUZBGM2GIItC5uR+8=;
 b=wxh76cE7tZNvj6JfcsO2l6jEFOCE5TQ8Fp+sxFLJOkdH4ekhpdbCMorNiitW10hkYr
 nQd2oViqxTYxn1KrqkIPdmyhI/5BbJ/YacX5uJHfDgot5fsOPCcXO1MKdepdAbmksfwP
 qSKHzNi7Hrx2zQC7Tj5qhiny3Ehzu4xofEVk7Gtm7oEtOjv4Kj9ECFf/athNly/E5m10
 wP8WyoEWTp1M/PjB4QYGobBnbG9ncz5TvXRs+b0jV3baQMOl3AjlJ1G6Jq0+yIfWoe/z
 L1AsT+A7fF6skho753LfZMuFOpT48de8hnuyWLVWgXJx5tY9mU7nupai8GzojQd0H/HT
 /48g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWvGYY6MWNvrtuCRKrwIPnwH/Vjw0KikeWh78pOV3e1zBesbG4kHWSsF/rz6t3PfxQYkOIs+Q5Bn3Lbt1pkNWudKX/
X-Gm-Message-State: AOJu0Yxfx8LhS+wsHBK/a6/9ibWhTI6rONvYsFf87KMvDSvpwdszZI6S
 5oYCBgugoC0OuYWHqHU6XTTuM3vJ646bv7AoE8oHGyYbcfgUbjFgGt7jlPB+
X-Google-Smtp-Source: AGHT+IEaalKABNvFq8hA5IDkWl0NW40bLXgL6uEkABdeFRg0fICeH725tSMKcNHWyqBMf6YTXhQ7Gw==
X-Received: by 2002:a17:902:eccc:b0:1dc:4649:43df with SMTP id
 a12-20020a170902eccc00b001dc464943dfmr240246plh.16.1708703120763; 
 Fri, 23 Feb 2024 07:45:20 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PULL 33/47] target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC,
 TB-L/U
Date: Sat, 24 Feb 2024 01:41:52 +1000
Message-ID: <20240223154211.1001692-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
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


