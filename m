Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA36ECC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4Z-0002Iz-Dp; Thu, 15 Oct 2026 06:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4X-0002IE-Se
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4W-0007pA-7k
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so44118075e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061546; x=1792666346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jNf29mw5unxQhmsuzci0zdkkF+rcJG9kmkx3vZJn9Xg=;
 b=XrP2Pv9VhF7eI2UqA25qFXqxw2OZRiO06MGowfN1bs+QLbQlBWri5GAbmVvZ6DxVir
 U/61dK/dd+l6drToNUYLU+6Nm2YKSyhcjzwdQkCRtvoH322H43gqz7Eg5EainecZiPKC
 XkBQvhEq0pue9Hdv0P64Xio/ZqgMOuzA0gD02phJIn4ALEC0TrF7vhlA9QE6MQHVwV75
 cHg4uwQr8FdWivqahU8PkWqaTH3+8zRoP/UyNmrvAFyZfNObYjRHgVZIAwxpLRhB/j0W
 2igqjjTS99221OPG9CTvgUJyIC7VnpTF7JgPC86KswNVqF9q3mMSusGteI+KNhQcSyaj
 +f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061546; x=1792666346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jNf29mw5unxQhmsuzci0zdkkF+rcJG9kmkx3vZJn9Xg=;
 b=k713BGhU4f29PrPlKlJp+SZ5rZoa1WGwwKnjklMA5ScdA+/nFxeVSoTcl5k9vmg3X5
 XtWlQBLMnkGjK0mXJlBlh2F5Wnya31NM0O5x7Id7YSjVeTxrw1LignEx+kB6CvvnGpZ5
 6/bybYxxCpBuZAG3yGxfRgFQnJTVLsHFq7DDzyKu2OnfWDsIoavRi0Qy4OXk0xzyFaQF
 fS3OqncWnAvmwHKf/8yVgb5N3Q1jkGUGxYk2pkGPA1GS8kKymssSmzbNwtTjaj3/2+hL
 nuskkBk7h/Dv5CtM6TAfww5c1fDNF31sHjvsL/NLaArnZNa1zZqmH32/VpNdpM/1JaO+
 NpIg==
X-Gm-Message-State: AFq9FYKOydW7NAEW9rgD49mpiQ7bt2rtDlKEgISrFLa6mybVfQTPmaS4
 QIEH6YWfaBgf52SVuRnYuZ5IwHYOIU22kZUwHlNot3pqbBv+LTPDcErWvxXjF5b3/ZtakLErh7c
 KFwL2pvA=
X-Gm-Gg: AYBFou3q9lKm40luWqLHQjxhTX7cz87tuILk2EfTgEMj8AYutHtkm3XYD0dwF2JWaqV
 whNtME2yELI9tT3yr0XachgXJjxavDqPoHN5c8fpdnH0qVWYwY37tkFCiPI8RMpfuxWxg8Whh9Q
 XV4FiXW7w9X4YSfRe+Eds4TZedSRc40mbtaV9V/zcuk3S7ydn+JG7AbCapVPrrZrgrblLEoQYRH
 j55Z8tv+rt3S9r3/NL2LK2511JMkIXqufIQ3DAqC6bbEU6DZLMrgTrEGujsNI/wffec7Jj8oggn
 tv1qeFL+rTRlgBJqBfYsSt79PwX26gju3c8/PPjgyTiSNsbEO7YzQ2KOSG+mjN2aJKsrWyBIv6m
 7khtazDisizEBUhKlfF7eSL7PLAf+x5H4gbDWMJX48MZZcghST/eHLdIgauwg334VTeTyFLMYTH
 GeuShS7h75CFCtvGLE53XdPe1+RSjiJ+v8MABW5hhWr3/51ZmYpONaW9gUOSlHPLyfZR+AzecZ5
 4UJiCshZ2r/11Cid6UI+IYO5FJGQ1GJYLgyo4vLo/2gpHRLcNs9mnn5vdi+8QhdGT34GaIC0ApV
 kaDa
X-Received: by 2002:a05:600c:674a:b0:49f:f0bd:1e40 with SMTP id
 5b1f17b1804b1-4a18e4afe9cmr348237945e9.23.1792061546462; 
 Thu, 15 Oct 2026 03:52:26 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 04/16] tcg/riscv64: Remove vector min/max ops with immediates
Date: Thu, 15 Oct 2026 12:51:56 +0200
Message-ID: <20261015105212.356392-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Aurelien Jarno <aurelien@aurel32.net>

RVV 1.0 only defines vmin, vminu, vmax and vmaxu instructions for the
vector-vector and vector-scalar case, not the for vector-immediate case.
Remove the immediate variant from TCG code generation.

Fixes: 1631f19b04fe ("tcg/riscv: Implement vector min/max ops")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261008181611.3015838-1-aurelien@aurel32.net>
---
 tcg/riscv64/tcg-target.c.inc | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index de9a3570b23..14a397117a2 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -306,13 +306,9 @@ typedef enum {
     OPC_VSSUBU_VI = 0x88000057 | V_OPIVI,
 
     OPC_VMAX_VV = 0x1c000057 | V_OPIVV,
-    OPC_VMAX_VI = 0x1c000057 | V_OPIVI,
     OPC_VMAXU_VV = 0x18000057 | V_OPIVV,
-    OPC_VMAXU_VI = 0x18000057 | V_OPIVI,
     OPC_VMIN_VV = 0x14000057 | V_OPIVV,
-    OPC_VMIN_VI = 0x14000057 | V_OPIVI,
     OPC_VMINU_VV = 0x10000057 | V_OPIVV,
-    OPC_VMINU_VI = 0x10000057 | V_OPIVI,
 
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
@@ -2810,19 +2806,19 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_smax_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMAX_VV, OPC_VMAX_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMAX_VV, a0, a1, a2);
         break;
     case INDEX_op_smin_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMIN_VV, OPC_VMIN_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMIN_VV, a0, a1, a2);
         break;
     case INDEX_op_umax_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMAXU_VV, OPC_VMAXU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMAXU_VV, a0, a1, a2);
         break;
     case INDEX_op_umin_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VMINU_VV, OPC_VMINU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VMINU_VV, a0, a1, a2);
         break;
     case INDEX_op_shls_vec:
         set_vtype_len_sew(s, type, vece);
@@ -2974,10 +2970,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
-    case INDEX_op_smax_vec:
-    case INDEX_op_smin_vec:
-    case INDEX_op_umax_vec:
-    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
@@ -2987,6 +2979,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sarv_vec:
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
-- 
2.53.0


