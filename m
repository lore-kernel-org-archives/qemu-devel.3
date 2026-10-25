Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267A606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ydwidkBZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZz-0007GD-NG; Sun, 25 Oct 2026 03:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-0006f6-OK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZj-000485-Rp
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso21351405e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913005; x=1793517805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YgXD07TM0Z+WIZcXgCMknv6F4Y9tWidiAFH+R68S4xo=;
 b=ydwidkBZHR4JYXMUC8bpKPFK6a3NuRgXocspGd3/f5HJ21uH5qWMX7Mq2DXYoZrACE
 T5caGkTCKR6Fl1DPRmXMOUdbMgaEbjPGGy3t9H8EDlBHzuys2Y076QNmhB3JU2/HnzJd
 7gpfwFZN/j+QVN7YSJra6X9T3Zstfv/iqUn39IQY7CtrruZWX5jC1mC5J2WwOtruzrNJ
 aYaSte26LJ0DvIqiWzNQnwR+qQPl5iTmrQHJ1k533XyMqbKaVXl8AwVcYgClEBoFmwpM
 +EiDSC4BghGW7D8rdyd3IbBCckG8JwiG8I48m3h0GT/nWrWShxE2gfVy9doHTNiLsfJr
 79Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913005; x=1793517805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YgXD07TM0Z+WIZcXgCMknv6F4Y9tWidiAFH+R68S4xo=;
 b=OdiZnvneUqRXC4yF5XucvB3Suhn5qlsgEsH1Pqrqb0cz94s4p/RGTVVaak0F6yF0X4
 N7Qil8SGZ87motutRqgCXIKvTswTtCoW6GUcOSb7zppY0u5Z0G5drljtRj0mshtyr+bY
 wH+qLJ8IaCLyOFogeDcHiOJPiIZBSsoT/c5b6Tei8si3j5FWi95vKf3EEHMpBw2LuQy0
 RZDcMdJ8UmfbO8L4FAaNTGHqW4nTutSEyEMsHIGX1FMxzdRQcUZP+ViGOoCqhsB38ZPQ
 5DS0Eyb54J3Dt3l4hzAN56ukCxyIs7WAumE5zx5h6P1romRfQIKmxRASp2rvvYNPWGhz
 wkqA==
X-Gm-Message-State: AFq9FYJaXSpRBy0Sz9mI2mINURXLZARL2HZiqh5wwVhRaQp07+ODUpT5
 qrDHmUW4JOFAV3tY4cKUtmnlASsegZYG4yUQHyFG/8E6vwt1PLIUf8YK5o1TE3FHCNsM0iB3eaS
 2OR9zl+U=
X-Gm-Gg: AYBFou1BoqzV9kEmeHxp3j5AU1ujTT1Z4mDrEBayVMna36gzLlmbYZrqaruO9QaTuGy
 wQ67GjGE1NT6rF+vGvpnibO72UYVEr8ypyQpT7G4O3QeOok4eh2NYozp6/soYRTuGaqYb0RjOR0
 aKLqwMNy6V3x9/V1WzO9eNM1nJt84KhTT2E614DmdZTNfn2B8aNnCmC1435yfGWXR6rTbbIiQIt
 DKGGy47vMhqYDxel/OgCd4NrFIPp1+P126EHTBqfGbDvzmGVRfuAn0fYN0/lvEjTXHOewrT+0m8
 qWVgB/T29gIQduDyjAl0IjpcmA9brf1s3/UBD6q+7ieQincx6t2J7fkApXBSU2wHKdH4+iM7++E
 /AaGwuBiVJq4JEan+bK+6gORMjHXQtyiYUC5AbcO/PtbuP2B0ip//E63k/LWlvRAlPG2s+XToLq
 n6Xv01gozQHaL7sn5lZ7NArOE784waWK+O6z36eh+U9LvHXaAoEc1h7Wwg7LuUa65Kb7douDVMI
 uM5Qdv0XMjoNw4eYn26qmjeGNSgQiYaGxNqD6WPND4CE1lDwJMOIhk8fK0=
X-Received: by 2002:a05:600c:6217:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a35aae5c3amr56452275e9.0.1792913005184; 
 Sun, 25 Oct 2026 00:23:25 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 065/100] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Sun, 25 Oct 2026 08:18:40 +0100
Message-ID: <20261025071915.1123867-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 85af0d4b6c..f2e69a21e1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -187,7 +186,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 88e87ebc2f..a5b2bdcb43 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF2(ext8s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1d154fc12d..3c1e1fa958 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -599,6 +599,11 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1164,11 +1169,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1470,11 +1470,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0


