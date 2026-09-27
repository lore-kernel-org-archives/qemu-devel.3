Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4CC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpQ-000842-4V; Sun, 27 Sep 2026 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoC-0005Io-4k
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:32 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko8-0007gR-QB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:31 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78dd54610so635004a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499865; x=1791104665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Op7/yEllLBSmqqPA2pToawPC2qhFBYign9kv4qyczIU=;
 b=HFvkRZuM22hjTH2sWvjXze9ZEbyUk2w0EDKJNihW3DGg17nrlEiwB6JnNNj4FydHci
 J3Sx2Zgw+Zn/qkL8y3/YBx3AqgLOcL6G5DyIO4h26Hg3uoV1RB6VwvgW/7bpRt7CNFJq
 ck+RglN2SL4KW6t45KJmKJhR84KQGzd3hTAggG+7ydOyoMYzu2hNYxW9EwCWXczqCzyX
 UuMSaBCL6/ZqFZhKsWRiKJE7OlD8VjYfI8ppDtGWua1/GxwEHkwelv38W1ZVgPvtYwui
 xg0uPAZUNmKvLMWdgnleBbJqP4AKMVeE0VhMX0uAa0Sbd7l7evPDBn7WccAKSTzn0Jg8
 DaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499865; x=1791104665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Op7/yEllLBSmqqPA2pToawPC2qhFBYign9kv4qyczIU=;
 b=g1NjgutJTzn53WLXneqlqzfzDfnoYUD8wgPPDCzyKw9kc1vZ5/BJcMUMYHRlWDwvv6
 tFI8ZQiXSbmvu24YPt6fnuN631oD7VJ3DKEl1fs/27getF0xOfzqE9CQe+ZTDGlsRNi3
 k3C9eInwsgTLTl0QBMC9iI3ECs2jbZ2jyk22C2AzxDVfYRtjK+/fGGtWlCkXqHyWNP8G
 PYyW/I6MY4Po/zavCrbyz4iOau3UnmhPpzr6ppWkWNS3IKi/Po392aN/wxp2mV1CNlaS
 TsfbE6zTs40Vtd/KWs5Hi7Y17fog24RkQIizmgM4lgz2rvtEFImh3MLBaifxWckEXLXM
 kPoA==
X-Gm-Message-State: AFq9FYLbjrHWMh5VH7Q0QY2y+lwhQ4rGK6+P1e1cK+DYAYVlMisjK4Sp
 WgQxl0MibKslIyHS7vsU0w3l85RxRKLTubjNBdlGlqk689iM7TScb0EBPaUlrZQfnzhoEmj6bEW
 fozJ6
X-Gm-Gg: AYBFou38642cwF+vZOB3Q3BGROnm8vWLw0sEdhXNu2MFZXUTEvPnfROThYXHhPA134u
 VmETOQF/TWT0U1FWYaYdpep6g1GbbgG6twX1VNDg0I1aZWTZRUCpZsJ9we9486RU7ByQ2GD8aob
 QGy5fLVHNf2Fm9tVNIiEyYGbAt9gO1GautJ4I554ED+vic1swYJmj/RPUp4bj+2Wre6TDTXhnRC
 /QHNSU82WIB2fchTgez0Mx8mn9/pXd0po75Cdfm2thVnQRccCrl0shh15p4RTkyW9s7TCBLZEKg
 ni3VLg7ufmjlN3ifrcTc7A9/eCOHxNesdXY1Koqn2MVWBfU74JGmcojaKR41mC8204waoFc+YBZ
 2i3aQarmwe8H8BJtel75g4sncRPtV7FCAtiVaniZNnw4gIQzoOXcFDFLA3tm5BIgqyOZ6Zvquqm
 qRZpoUaypKCVlihazQZe1EiKN457mc8qchXQ9XyAG++vNnuMRBBHREIT3I8W88TuDndoNJLSJEj
 I8Y7XWuZb/pqM5fGAZoIcU1EkDmhhU=
X-Received: by 2002:a17:90b:53d0:b0:3a2:590c:a85f with SMTP id
 98e67ed59e1d1-3a2590cb587mr1122856a91.21.1790499865153; 
 Sun, 27 Sep 2026 02:04:25 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 067/101] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Sun, 27 Sep 2026 01:59:37 -0700
Message-ID: <20260927090011.10724-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 52752db2655..260f65f3305 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -188,7 +187,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a5b2bdcb432..1cdcf3aeeca 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
+DEF2(ext8u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6dbe396afc1..60a4f1c196b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -605,6 +605,11 @@ void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1176,11 +1181,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1482,11 +1482,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 16);
-- 
2.53.0


