Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE55C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkXSK-0002N1-8P; Wed, 13 Mar 2024 18:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXS2-0002Jq-NW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:52:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkXS0-0004HJ-AS
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:51:58 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so283160a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710370315; x=1710975115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6aglnROJwkY+5hRbPbUV1QnS5K81iLfR/yfvt3Y7ig=;
 b=BJEuGdmWu+/PL4i0GjXHfbti/YVoEX0umjbV0r1LxOz119N0BEmKUYl5D0eltQwM5P
 Y/QNeQUYXyRgogK+bX/qRelGmztxq0E59Vi5rJfyppmyliKuDToce0buHYpDdfl4ZVaY
 pNuMTQjr+YvPtzmu92RXNbZW8EO/b8UvpM2lrKfZ9bG201icmHkIXyqL6VD1BSKlPv4y
 kciqr/GhV5MUaRKmuaIgvbWX4fYbT4bIB5NK1T1SrFkCwIIs2JFry7b+mrIxKQtwqfPb
 oOZYLtCffK2WJDJ/U901+OaspeNe0/RRzpndsv15JV0C6pH0zJZYSpBRxT3bpED1IzDz
 /b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710370315; x=1710975115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6aglnROJwkY+5hRbPbUV1QnS5K81iLfR/yfvt3Y7ig=;
 b=K9ZTgjystZ+zVlqsVfhAcAdoJoKpipkuswBzKWmK58d+NgvHFJAGu05WHSEVrjVB0P
 1YTD6S4LwpIh9ksiVv6N38tpmAWpO6POo6x6o7cv0ODXdE5cMyqpcsTCZ6jwo5+Ju7pc
 lUYpksZE4CIPckfCrS0JNr6KZErs91nTlGEYIo+XYKsrQovjfAvC9pG5Xd+T1l8VuAg7
 3qNABPC5jd3a3/BjmFV4lfdzGVdKOy1PY7OSBX4y2P5XBPkoCbdRp3AvZLNTtTlqaxke
 +FCjL+MpfstAU3OH9MrDzJY1msB7Hcak5Hfn5TTlVj29GSGEjwxSgaEZ7dbTBjEvT1eM
 LraQ==
X-Gm-Message-State: AOJu0YxeLHfyGLVObykMYKBoeodGLU/T/r3Yfs0rPrS80TGzI4O1nOar
 cb5WgA1gNWqi30wKRU1ytvQ/7UuQ61yj9OPE3msO0objNzWL2Vu3C9664JBtX703jgmhTq4d58Z
 y
X-Google-Smtp-Source: AGHT+IGDv1bJpMmO1X+ZPlFU5SEaitu59Qy/sh9OgMT9//qOSwQIAxdOKLg0hhILOaAyjRanBN/e9Q==
X-Received: by 2002:a17:902:e852:b0:1dd:b45f:4d02 with SMTP id
 t18-20020a170902e85200b001ddb45f4d02mr235219plg.22.1710370315013; 
 Wed, 13 Mar 2024 15:51:55 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm137269plx.75.2024.03.13.15.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:51:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 3/3] target/hppa: Fix assemble_12a insns for wide mode
Date: Wed, 13 Mar 2024 12:51:40 -1000
Message-Id: <20240313225140.812202-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313225140.812202-1-richard.henderson@linaro.org>
References: <20240313225140.812202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 27 ++++++++++++++++-----------
 target/hppa/translate.c  | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9c6f92444c..5412ff9836 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -26,7 +26,7 @@
 
 %assemble_11a   4:12 0:1             !function=expand_11a
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
-%assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_12a   3:13 0:1             !function=expand_12a
 %assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
@@ -314,8 +314,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 @ldstim14m      ...... b:5 t:5 ................          \
                 &ldst sp=%assemble_sp disp=%assemble_16  \
                 x=0 scale=0 m=%neg_to_m
-@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
+@ldstim12m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_12a \
+                x=0 scale=0 m=%pos_to_m
 
 # LDB, LDH, LDW, LDWM
 ld              010000 ..... ..... .. ..............    @ldstim14  size=0
@@ -331,15 +332,19 @@ st              011010 ..... ..... .. ..............    @ldstim14  size=2
 st              011011 ..... ..... .. ..............    @ldstim14m size=2
 st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
 
-fldw            010110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fldw            010111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fldw            010110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fldw            010111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
-fstw            011110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fstw            011111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fstw            011110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fstw            011111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
 ld              010100 ..... ..... .. ............0.    @ldstim11
 fldd            010100 ..... ..... .. ............1.    @ldstim11
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 40b9ff6d59..be0b0494d0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -155,6 +155,23 @@ static int expand_11a(DisasContext *ctx, int val)
     return i;
 }
 
+/* Expander for assemble_16a(s,im11a,i). */
+static int expand_12a(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bit 0 and bits [3:15].
+     * Swizzle thing around depending on PSW.W.
+     */
+    int im11a = extract32(val, 1, 11);
+    int s = extract32(val, 12, 2);
+    int i = (-(val & 1) << 13) | (im11a << 2);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
 /* Expander for assemble_16(s,im14). */
 static int expand_16(DisasContext *ctx, int val)
 {
-- 
2.34.1


