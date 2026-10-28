Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D9606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FDBCSIce
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aB-0006SU-C6; Wed, 28 Oct 2026 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a9-0006Rq-Ua
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:57 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a8-0007We-FH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:57 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-84d5e56f876so835668a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205175; x=1793809975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cxtaElL9F9ttpMHAYKb044rc1jgTHyP54xKHK7+98s8=;
 b=FDBCSIceuuKYBPS+fodO3isTMB7XAQqV+dLRPHkGsAEem5PuA19SlDS6iYwfy8g/4U
 3A63bZTuIqE6rMy7prr+vsHo9FyqOFJ1KxVMVjueQ++1hCBLFa7dr1iC68OCqeKvoA+U
 87jArMGlHfPzXQXeAyozVE/6DBpG51BWlM2tJH36vWBXB2RR+V12XEMzbpQBNsgYRngk
 PKHDKen50DpqOygUJLK5SyM6EIqLBlde2ATqEE1RjMGc4G00QaHpHjKmxYtXEd2TI0RL
 5z5I+svAkpXfMPDobBrQ9v7N2htp8IZTWhYHDWEScq3WNg++uzXoLpqxsPQu0zxXs8yT
 Zffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205175; x=1793809975;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cxtaElL9F9ttpMHAYKb044rc1jgTHyP54xKHK7+98s8=;
 b=pVJ9buCR/cPvQKzATm2Py5BGoqR0U716+QMcPVoLKRQLDNzAN7W3CHcd5pQtln2z9G
 f3WlQ0YYmHEpF0dn74XMbR7YMC9qhxXkaRgrDtjIcrbqNNzmux2heiXh7Xiz+1ZsbQwW
 GfHcxlS7J+CDrn1CcYoG5FpDSl0eoH8VWo++omAAPDFXLxwNLHhMwVvOJc1SYPOFaM+6
 7FGfdF9ZxJwnpX8nQqODPqjfVg8w+lefSKPVmUPaj4/3R5uMkkWT9zxOnsV4NAnZhA2n
 88um+CGj5mraOcpXPqprjWyU2VJNy5nkXtJSn5i1FdxKzhdnFku4JszywdLo3hUMgBna
 WirQ==
X-Gm-Message-State: AFq9FYLlF/Ym1z5rPCCsRSqGT8Es2FqHi0eMeGxHMHwaBwQL+84RFZO+
 dmI56/ik02jXV5PEqn4oKCo2dc2WZV2AwUS98o1IU27RqbIDyE1OZ9qWI1EYLNa1RiP+oLOyfCz
 UgSFE
X-Gm-Gg: AYBFou1MG2/Rdp1OOiuC6lOLgMJYtm4r+cnXt5c7M//Yv0Hdsx3XyOthjigK7G6Srun
 xdAEFYhhlFF0Lj+Fze0yovsouAJQTGf6YC0rAO63zERiqLdoVdwJX5f/QWR6K2StcG8QVvh4bat
 bb7F4JsPOkY6qhTEaTUI0TOWDbQ9TFwZYUXpS8d41p/0pqKxG9vp6B3li6V4AVhAwXgum83JLjZ
 /MJixeNuKnNoKcS7zQcP8UOF6QYcUqe18aig3MVd2DanPOxtR39z819W5fCnNbP73bFoWSchjtY
 KpKeZOUpU352vRr1J7k91qC3hX7sS2lTwjnkGSLndjlKmBAPNVlrQZjw7ADQaTJZjE3gwFQuj4N
 vw0ZiKABY/CVaDpL7zUX9CLKyGG9r9yUj0L4fXn+1zdXY+pSZTcPyJZRwicvHLLLCNkWO1RYVRO
 8QUyyLWopQpU/8tc0S0Y8BesjbZpFdP4oEq/70Adqu6VpERI13xlEanA5JX3q0sBGlyda3AZ+9W
 9XO9bHQEi5P9fFgB3xQY4v9XiP4zvc6MnYfJp9KEl5l7jmwXCfg8hVRiPelO15itPUFhxgFRjJs
 cBHosjN/JEM7HAefwFcdNpJEtK39xCTMveInuZXv+L4xNvI2ogk76TQ=
X-Received: by 2002:a05:6830:4103:b0:804:ca33:4aff with SMTP id
 46e09a7af769-85abf9642c4mr2344175a34.9.1793205175074; 
 Wed, 28 Oct 2026 09:32:55 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 06/16] target/mips: Use tcg_gen_lea() for [D]LSA and MXU
 S32LD*V opcodes
Date: Wed, 28 Oct 2026 11:32:35 -0500
Message-ID: <20261028163245.1031673-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260831062630.58771-1-philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c        | 3 +--
 target/mips/tcg/translate_addr_const.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index a38f4da12b..5361c94b34 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1596,8 +1596,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_i32(t1, t1, strd2);
-    tcg_gen_add_i32(t0, t0, t1);
+    tcg_gen_lea_i32(t0, t0, t1, strd2, 0);
 
     tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 1d140e918d..910177e43b 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,8 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
 }
@@ -47,7 +46,6 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     return true;
 }
-- 
2.53.0


