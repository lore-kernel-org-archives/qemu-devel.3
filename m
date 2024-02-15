Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ED0C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabma-0003dL-LY; Thu, 15 Feb 2024 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raWc5-0007Ft-JP; Thu, 15 Feb 2024 02:56:57 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raWc4-00065w-4p; Thu, 15 Feb 2024 02:56:57 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so522838a91.1; 
 Wed, 14 Feb 2024 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707983814; x=1708588614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gA0GCY4expU+6cwe4Nn5TA7UnNJnbdY1NTOPVj+gmpA=;
 b=kQc9lfKBUqNKeBzIurP+oEooPbDw3AFrnovqUZwOButdLiLKTvoG45sRTHr2GHLFyb
 KoSo3n/BgVv2LbJNMTTVlBjYdFxZqBu6yL5anaCsQiwDPCizZBCisrzY5gmUxkrWYwR3
 4FkhrkYkoVuwtIraogB+6flPxjI3d74ayJianvlAvoJV+PL9JxQ+kTUAKMElX3teN4JJ
 TQsBTSfJYojYotQ+KmEUhILaVmYkE0jIDHsD22UsRL2Vt0L8iODCE8hXLLmKcpv8Vc3Q
 0Ek3gwB0SEI9zkG0F1DhQRfZxT3ishUiY8FjBzkzzuBgevEBKMLlf4ic67ZhroWae2Oi
 VPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707983814; x=1708588614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gA0GCY4expU+6cwe4Nn5TA7UnNJnbdY1NTOPVj+gmpA=;
 b=D5RNbZ/wibNfvag2+0a55rzElOdfCxg/ADvablHD4E4+++IpIYKOK6OB/FaISR6+1u
 1jsMg4Nqk9znJ4z2R4tmXlZdN8h0w2XFO/zac3X5gneOkwFBWQy/M2yBYcGZ1kl7e+M4
 sWlyhKCQt0nindYKOtjzp56TEwxSy2eCawfh50c/ITMgmiPKH4gtAG5eIablix3LI6LQ
 11ngurK56xKds12i0VIwurmmhxFAJzc0UpYXsgSPUuCXMXg8NFb40cQDFfdGrJoWvkDS
 Xa3NUzdIAP/i6Qch6KF90YUx23CUgw/eyzHYnW5Gf8GFOrYhY/3pZn1f+cWSHVKYqvpL
 L1CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4w4OYQTiBmoNJS/SZmvNZ1Iyj4FNEjaxc/6keNUL469GFimb7GoY58RqQeM36td0XcdOjdN+fDeE/sj8vCt1ZjGDUCDM2A==
X-Gm-Message-State: AOJu0Yw4i0LaLciPcPbU79dv8zjNOKs4/BNbiIE81lKvBY0CIv5PjU9C
 M/EJ4HtI0TdC74KhVad+0gj/GmBkugb4k1Kz/e1v9ZxDISNiAnX7H+BFFWjYDk4=
X-Google-Smtp-Source: AGHT+IFDMI0ggjSptWtXy9gmuFwmhY+2LTqc4b2BSi/KrcknTjoTxfFW8Dydtl4/LzQ24P8zssSU6g==
X-Received: by 2002:a17:90b:30d8:b0:297:139a:6ff8 with SMTP id
 hi24-20020a17090b30d800b00297139a6ff8mr980891pjb.8.1707983813985; 
 Wed, 14 Feb 2024 23:56:53 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 sc7-20020a17090b510700b00296fcb4e668sm2721604pjb.25.2024.02.14.23.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 23:56:53 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/1] Generate an illegal opcode exception on cmp instructions
 with lock prefix
Date: Thu, 15 Feb 2024 15:56:14 +0800
Message-Id: <20240215075613.567351-2-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215075613.567351-1-ziqiaokong@gmail.com>
References: <20240215075613.567351-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 08:28:07 -0500
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

target/i386/tcg: As specified by Intel Manual Vol2 3-180, cmp instructions
are not allowed to have lock prefix and a `UD` should be raised. Without
this patch, s1->T0 will be uninitialized and used in the case OP_CMPL.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
---
 target/i386/tcg/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 10cba16256..07f642dc9e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1507,12 +1507,13 @@ static bool check_iopl(DisasContext *s)
 /* if d == OR_TMP0, it means memory operand (address in A0) */
 static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
 {
+    /* Invalid lock prefix when destination is not memory or OP_CMPL. */
+    if ((d != OR_TMP0 || op == OP_CMPL) && s1->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s1);
+        return;
+    }
+
     if (d != OR_TMP0) {
-        if (s1->prefix & PREFIX_LOCK) {
-            /* Lock prefix when destination is not memory.  */
-            gen_illegal_opcode(s1);
-            return;
-        }
         gen_op_mov_v_reg(s1, ot, s1->T0, d);
     } else if (!(s1->prefix & PREFIX_LOCK)) {
         gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-- 
2.40.1


