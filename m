Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD824C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WR-0000oK-9E; Tue, 12 Mar 2024 13:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UB-0005dn-Kn; Tue, 12 Mar 2024 13:00:19 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UA-0008Im-05; Tue, 12 Mar 2024 13:00:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6a6d486d6so20497b3a.1; 
 Tue, 12 Mar 2024 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262815; x=1710867615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVnACJjCRHkL5fGbYyOvVToKgvTOItd5ebsk72DNyJw=;
 b=aHir01ygjt6ycDGebkiouKscHOWAZAW/zxM9+7s2j7C+FQZM/KSFVAcSuxnw9LovSH
 92cZRIRFLC+59xWwZdHWwGPEqkkW526ohb5XSodU/Q/GIfUmDIKrLRqWwEyMQGaSSE3J
 XJis1A6/SP6QUHj9uYkGqj7AIxt50P1myyupeMSV0D3lyW3PY6dum4MElYUub+RruyCy
 Ngsiq8OFDkmUcp4V3lAJn/WAzwOd6Gspa5S2p6wyiuEN9XNYPDCtof7uz1JHxMSo6VTj
 OaK8J6uKR8fToY2jiCH0eOK7pcEs4zMkMJrk5jjtxVd0eRthHCejcsJBrcJIa++zpUJv
 SnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262815; x=1710867615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVnACJjCRHkL5fGbYyOvVToKgvTOItd5ebsk72DNyJw=;
 b=nwbkhvLqeEKVu5hHkfnMlKgLOVCxsvVbG4tTlO6Vgfs3R5SJx++Sa+7WEOEqHngcCi
 1I7aD4Jf8ntyRyLvKbFSmQJalkpmovuM/bVw6tms/t/hGFDRUrp+hPZwWAJu34G/C/Lg
 EZcw7rhQiNW9OMRNj2vWdahAE9VlclLZi5EuNg7bf/A78ThrzGDny2yPFeUfPBWwjnNk
 NdscNkI+ULJmLZPcJvjaYgu2Eu5Bua+giHr6ZNGJFCR/HI9rR80/vEGRkiygkKBeAXd9
 yLS4p9A9Yq4VET7m23h/0xs5IOareRVtYz3MoR7BjO/hnZp+bLsUKNt4P6PiRy2Ip63u
 jlBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC8QniCW0LZN9CQR6TlQNfzf232/PdKLqtsjE9reyqO3Lj4tloKfLk5WTLy/hAGTt61CXXn4AKnmtfNmJ9oEunBLbB
X-Gm-Message-State: AOJu0Yx3OwSWYzJWphevAwDNgsBd6yR8mwuyYJqkh15FByeTmqDOkkMp
 6nj/oUKbxBez4oms4kk5Xkd1E/mOkS5ps4z/731TaaP5EX7TzZozB0k3WufJFuc=
X-Google-Smtp-Source: AGHT+IFw/3ol6LlkhBy0/BVHrEW/tGMUp0I+6GhEnueXhHcUM4yn8kJ9cpOGtiVzhdVTdYXoM6GhbQ==
X-Received: by 2002:a05:6a21:a598:b0:1a3:124d:3e8b with SMTP id
 gd24-20020a056a21a59800b001a3124d3e8bmr204944pzc.16.1710262814800; 
 Tue, 12 Mar 2024 10:00:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 20/38] target/ppc: Add gen_exception_err_nip() function
Date: Wed, 13 Mar 2024 02:58:31 +1000
Message-ID: <20240312165851.2240242-21-npiggin@gmail.com>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add gen_exception_err_nip() that does the same as gen_exception_err()
but takes the nip as a parameter to allow specifying it instead of
using the current instruction address then change gen_exception_err()
to use it.

The gen_exception() and gen_exception_nip() functions are similar so
remove code duplication from those too while at it.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4f6f7dcd89..93ffec787c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -296,33 +296,26 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_nip, nip);
 }
 
-static void gen_exception_err(DisasContext *ctx, uint32_t excp, uint32_t error)
+static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
+                                  uint32_t error, target_ulong nip)
 {
     TCGv_i32 t0, t1;
 
-    /*
-     * These are all synchronous exceptions, we set the PC back to the
-     * faulting instruction
-     */
-    gen_update_nip(ctx, ctx->cia);
+    gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
     t1 = tcg_constant_i32(error);
     gen_helper_raise_exception_err(tcg_env, t0, t1);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception(DisasContext *ctx, uint32_t excp)
+static inline void gen_exception_err(DisasContext *ctx, uint32_t excp,
+                                     uint32_t error)
 {
-    TCGv_i32 t0;
-
     /*
      * These are all synchronous exceptions, we set the PC back to the
      * faulting instruction
      */
-    gen_update_nip(ctx, ctx->cia);
-    t0 = tcg_constant_i32(excp);
-    gen_helper_raise_exception(tcg_env, t0);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_exception_err_nip(ctx, excp, error, ctx->cia);
 }
 
 static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
@@ -336,6 +329,15 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
+static inline void gen_exception(DisasContext *ctx, uint32_t excp)
+{
+    /*
+     * These are all synchronous exceptions, we set the PC back to the
+     * faulting instruction
+     */
+    gen_exception_nip(ctx, excp, ctx->cia);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void gen_ppc_maybe_interrupt(DisasContext *ctx)
 {
-- 
2.42.0


