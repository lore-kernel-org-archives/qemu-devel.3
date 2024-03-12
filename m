Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF52C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TL-0004eI-Dj; Tue, 12 Mar 2024 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5T6-0004YW-Tp; Tue, 12 Mar 2024 12:59:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5T4-0007ug-4t; Tue, 12 Mar 2024 12:59:12 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6a9fafacdso560625b3a.2; 
 Tue, 12 Mar 2024 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262748; x=1710867548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVLie48lBIC5AzjD7aKAS9bkmqBPGd9+Xi/qx49qlpw=;
 b=lezqaG75+25ck6m3g3SDed714nGhLZS2M/heiQf0j+ifOMBJQTZZ4CDU6APW92A7D9
 8Qp6fIbF05Z2MiUMMmeG9udS1FSl7J1Y/wLp5no71vRhfckC6OS5ANEk9aaxszCf7XPX
 JYWrrnhG1JRY00FsGJZn6dcRYd+fQvuDSzWFROKoo0JGh/A9J2reKzfD58Ze2Oc9SV/N
 wU8iX8OcaUwMFiIsgc3+yH/pXJibL6xixAknyYN45noCl1k690nCGCAc1tFRQYfnDOT2
 LUwYMQNcIK9E1ruFgUEt86Phh8ZWYWBr71QDML95q8G/qKJFka05QtnWHdBuEdHGoVDz
 2mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262748; x=1710867548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVLie48lBIC5AzjD7aKAS9bkmqBPGd9+Xi/qx49qlpw=;
 b=QcRshae4g+HVWxBUz0QjAcuKHcjYGpgIlM7ydEpswaUfogEOFiPnHT9YXd1ufegBEa
 Kl/Do4DiCU3W74c+ggPTGfgo/B+M/t1FaWW8YnLRClp5pXTawuBx33w6RpAjKoWl7iqt
 KbGbBgHfH/PfsWum/Xnu6GjtpWIl+3Ok2sXZpozyVIyKVMEVPfEfJKfY+f8qgifOoMyP
 qIBgSZTVs4gRBW7nCgpitclpbTHdYSiFwkxpPIpuSCtwaJHxYGUfJAwac6v+4BIux9Vj
 XVnH0+i2YxxnT+CYACFIiBYGSn1UcnH2f3u+FrVzngAYOd81KWWmqlwZre5RT3GNTfPU
 vc/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5HAkwPGOj20aTLtMOMYQOkQlKllsByM511SGkZKQ13ARzoCqr08DyPxR2sk0pZHswh2lqVevZ+S67BjBeQfsDSYCR
X-Gm-Message-State: AOJu0Ywismwtaeb3iZk8KUHtZ/YPd7BeaW1jStJIlyl9MI+FZqY52kad
 GUxfYbxwlR4IA3+1Jpb2LsKIoOoXL55fOvGVdQipP52XfyMIHrJoPYXD+Rp0oek=
X-Google-Smtp-Source: AGHT+IHhWglLuzxH6nmx7sh/7myZzdrDAM4wrIOPgfoKRBf1P9RDHyfLgSZTEanFlO1G9GnFXsw8gw==
X-Received: by 2002:a05:6a00:3a2a:b0:6e6:4705:a07f with SMTP id
 fj42-20020a056a003a2a00b006e64705a07fmr11329pfb.31.1710262748005; 
 Tue, 12 Mar 2024 09:59:08 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 01/38] target/ppc: Fix GDB SPR regnum indexing
Date: Wed, 13 Mar 2024 02:58:12 +1000
Message-ID: <20240312165851.2240242-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Fix an off by one bug.

Fixes: 1b53948ff8f70 ("target/ppc: Use GDBFeature for dynamic XML")
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 122ea9d0c0..80a2e7990b 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -324,6 +324,9 @@ static void gdb_gen_spr_feature(CPUState *cs)
             continue;
         }
 
+        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
+                                       TARGET_LONG_BITS, num_regs,
+                                       "int", "spr");
         /*
          * GDB identifies registers based on the order they are
          * presented in the XML. These ids will not match QEMU's
@@ -334,10 +337,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
          */
         spr->gdb_id = num_regs;
         num_regs++;
-
-        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
-                                       TARGET_LONG_BITS, num_regs,
-                                       "int", "spr");
     }
 
     gdb_feature_builder_end(&builder);
-- 
2.42.0


