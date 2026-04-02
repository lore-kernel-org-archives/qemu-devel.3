Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C2D3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILL-0008U9-Rp; Thu, 02 Apr 2026 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL3-0004lE-LH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:03 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXc-0008OE-8I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35c2fe0d90fso474238a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134371; x=1775739171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzAwWber/dJ9Rtdqx7paa1UM5LleVLjenLlZ9/kkQq4=;
 b=QY7ODIQLryAj/lJJ5xZLTAbfDkDDjzBJwiVz71WxUSqT5G1j4l7boNlgO4zoochCau
 sRGVV48pR7kvE5mS7nHH0ZCnD29bbNW0d/gNBkgoHIsIPcfLG6fWdX5swEoeZIPPJS4H
 4vg9VqY+NtuulBgkrBBgPQSVuwjZFpi3wm/WLlLqurCG/fjqhXfRJzubtk+cVrms0AiG
 mE7eg2f0FOLqdN8XLtXzwVz3F12fKCrptMD1XgL9H8QvLDoU2l4o+dVDdF9ZgDGt4yKr
 0jhNpcIGEZZVnzUz8uf/TdDH4HbXZK3z6Fe0MHEkvv7rcuwCvBSVKs4NkprMwrD26Yon
 l3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134371; x=1775739171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CzAwWber/dJ9Rtdqx7paa1UM5LleVLjenLlZ9/kkQq4=;
 b=HXfwhs/uwVt+yIrQSG5aNJJeRcaRVc3FhOOq7wXGevFXB8p28aEZ3WcABn6febgtzV
 fKbh+u3S5dAqnnCa4W2oHCQlybOK9vaKeHNi94ga2JZCSunenGMtrh3vaDACoOyydJHy
 leKkwHswCStm6J601fvimXHpb1ZSkF+zadSyXZWO3w5ggwvkoVs9vTazjlk6Uw1PEBDt
 Mk4Th1YRziiV0/TqFjE68fO74P+BUDFvPMZcXTkogfx2JOCXojW2boQYZ0P3avUxxAlR
 nDRjXPTdN7jT4MU9VZTz7o+6Br3iCHYFi0OpE7QrfjlNC0Pks1n0gKCD+5HCy6uos7lx
 ABQg==
X-Gm-Message-State: AOJu0YzgFDkSHW9Hfu4BWBD59TJ6aHzscBcjWmH5/9qtPPsy5ihOEjon
 qfuZNxw141fW6Uez+XN5kRx+z78luyxZ0QTDoKOuaAz1IGgfNNh89NA8gbEi/caCdoFer5bOJWn
 te4LuJ0+eQkrrUP5qVmaUTHW9xJmZfTpaP1xQ9cV0Gti9ysz8nHSKdncy9KJGLiAEUPi4gHW9z+
 fnqlw9SaCiE538sMIN0OqKcadoppLUbymg0Ds8FAw=
X-Gm-Gg: AeBDieslXunKUTTNacF5jrWstlfte17fmDW07SIAli9L01stUpRzCwmwu1PXQBRZz/s
 s4fvjSn8BIt7Rshi0vj2hyZvostxijhV0HLGYL5+4afKOoBknGVFxsmwm6Uh6JCdC3+iuoj3Gi1
 Gte+PcSzUekRvSGoplLBsD+g8kXwAFK6l2/a0q4rxts3vxbH6WdPytaQMLuGgmajaU3g+2UIf+T
 c0BlqzRCNBe2ER9DTMddx6Xa9uJmjT2Z5RvchM/Bhjj5l2zc7WvVhRwVKsmYzKwlI27w5muB3UN
 he6RrRPmhGltZ/8X0HfWPdjY7TVye9BzgQh24JOUdThcDyUgJPqmjIVZ0eM2UBK2AAH/SvfCNog
 oyxx+uSbFQVdsawerzJCZ2rg0adyuq7ytHkHRD9FaeEy+I/Nnmf2mD28QmdmjgDd/irFCx+TOm/
 1/JutZlIpQ9Pexqheu0TGQHyuuUSVeJGHkliUvD9Y+UY8W4IuC+7J1nunQkShcOSZSNiI004vvO
 XQBN+Rzv/R7jFqRY0pDctIhqvOWcR9Kx7at5A==
X-Received: by 2002:a17:90a:d450:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-35dd4025087mr3209993a91.7.1775134370454; 
 Thu, 02 Apr 2026 05:52:50 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:50 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 4/9] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Thu,  2 Apr 2026 20:52:29 +0800
Message-ID: <20260402125234.1371897-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the same vill reset flow by reset_ill_vtype function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 63ca6fe16b..1e0cce5ae5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     return reserved;
 }
 
+static inline void reset_ill_vtype(CPURISCVState *env)
+{
+    /* only set vill bit. */
+    env->vill = 1;
+    env->vtype = 0;
+    env->vl = 0;
+    env->vstart = 0;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
@@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
-- 
2.52.0


