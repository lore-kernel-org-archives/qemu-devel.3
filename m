Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66346E9B25A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFb-0005dD-Qd; Tue, 24 Feb 2026 07:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFF-0005Yt-LU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:31 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFA-0005st-DO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:28 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8f86167d39so690915366b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935020; x=1772539820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mslQWctujhKO4cq/0uIEWyDzG5wEJ39Nyk5AzFm6SR4=;
 b=vbv07YUcp4BEn4Or2kT9qExpfpFomTR2giRhVenVfZ73R6CiHuos9mULhLw6N0UieL
 b51g/pa4fmQVK1ienWNMPCvWaaYTH61biAz/671FwhJgTMRFSA2DXTv/i9gLS9/8WhCp
 Ic4thASJvzAMzkJkoA56GZq5u2jv+KHfPV434c1nXKtckUeWg5KIYQfGGodPZZb0fI5i
 lHPUgekYVhKntGo4/Z2IEzK/wc+owB6Qoiu5zaKSsrgsXxTZmeuJT6nE3WNPCdZJJK3h
 tJ+9i7G457Bemf+YecJJjZ114YY9waNG2pYRprI8U+n0ny67xUv/2NDz27lkNfuDfFp5
 M8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935020; x=1772539820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mslQWctujhKO4cq/0uIEWyDzG5wEJ39Nyk5AzFm6SR4=;
 b=c2SQaXg9DUcE2tHoHSyDeJpKCEAxJzXjX+r0c5AqvuJxl07+13V02eDaDoEA3EPC7+
 qeLjIDzKHlqc0eU9FHoPLV3ir371dtdG6PtPj5XYdKrw8c/BslAomRrRCqqFtVUC4tku
 jY00Ap8d4tjjOrDo44CJMUy3iyti4/j6L6Y7bzYgQET4uNyL1T9py/FNUSvk/4wDm4J+
 3gfnWbSW0sGuLngKF7timQE5QBL08/FqXGG0d/3ZWFCROcCOrj6guDvCRp/E+EIZrifR
 73E5k3PswD4wMYQlAP7eUqmr6PlMKVzKrRWj8cRki0CM6YNKkx0f88Z7jOCdytcR/ued
 vShQ==
X-Gm-Message-State: AOJu0YxihvHYy1XOGYNjHs8apl3rz+DY0+ri3VfcdGwCou/0zZ0PJ0j/
 0+ujPbo3CmrrnsQDsXsKNMUA/DV2A9dDV06k1lMPgtoFfZuYaA9NleZkykw0rd3ufbc=
X-Gm-Gg: ATEYQzyggUN8JIWe7oXUYmk7KNzgWsVH2WvAxQFtlXwxc1YR1Ui7u3Y9qdc9oiUkOTC
 TFKWwr3BsOQKSZXnfkeuzt/an10chwFMiGx4z8oEwPA/Sb2UwQ+BM83vGjizvQZ6HuKNpH20GWG
 fyeGWl7o8qVZenQfn3jH/2XUmL5a3w1lgX/sJAXuVHzwnYt9D2XM2dj5WkRfwTM8Oyuc38LlpBl
 VCnhiUw/PKUpkjayMwdt2O/OC41iyVQIpH60gkeXJlbBeAQzPBuZcGI8A8H2MUdy61lTo0LlqK3
 zu7G6sSfGHhuptc0sgxxuPTqWHb660L/lHHd6Kb6K4uAD8AQgv3TbkkkwG6GwNATDUslY6TQrOu
 yyyknPW52B1H8DuAQvu4l5CV22CFQFu8J4aExtwdOdSvAeqaP5KASzqihbeY39sz2h73JCPOPYP
 CUJWq94UVaJQa9in0EAcXM1IM=
X-Received: by 2002:a17:907:3d4f:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b9081b3e5e0mr787844966b.31.1771935019992; 
 Tue, 24 Feb 2026 04:10:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084cad856sm409913566b.24.2026.02.24.04.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 598075F8D8;
 Tue, 24 Feb 2026 12:10:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 8/8] target/arm: fixes for WFx[T] support
Date: Tue, 24 Feb 2026 12:10:14 +0000
Message-ID: <20260224121014.279248-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These are the bits I needed to fix manually on top of what the model
had done.

  - ensure the SEV instruction is enabled for aa64
  - remove the FEATURE_M check for aa32
  - add an exit block so WFE can fall through

On the last change I see the DISAS_WFI does tcg_gen_exit_tb to ensure
we check for interrupts. However for yield and wfe we should just be
able to roll into the next instruction. We could probably rationalise
DISAS cases for all of these into a common handling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +--
 target/arm/tcg/translate-a64.c | 10 ++++++++++
 target/arm/tcg/translate.c     |  4 +---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38be..d5b65d79da1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -237,8 +237,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     YIELD       1101 0101 0000 0011 0010 0000 001 11111
     WFE         1101 0101 0000 0011 0010 0000 010 11111
     WFI         1101 0101 0000 0011 0010 0000 011 11111
-    # We implement WFE to never block, so our SEV/SEVL are NOPs
-    # SEV       1101 0101 0000 0011 0010 0000 100 11111
+    SEV         1101 0101 0000 0011 0010 0000 100 11111
     # SEVL      1101 0101 0000 0011 0010 0000 101 11111
     # Our DGL is a NOP because we don't merge memory accesses anyway.
     # DGL       1101 0101 0000 0011 0010 0000 110 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f76a00d1329..4714bedd01c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2032,6 +2032,14 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_sev(tcg_env);
+#endif
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
     /*
@@ -10918,6 +10926,8 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            gen_goto_tb(dc, 1, 4);
+            /* tcg_gen_exit_tb(NULL, 0); */
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..78ba7d2fde5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3248,9 +3248,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
      * For system-mode M-profile, it sets the event register.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_helper_sev(tcg_env);
-    }
+    gen_helper_sev(tcg_env);
 #endif
     return true;
 }
-- 
2.47.3


