Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A08C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jny-0002fe-8t; Thu, 17 Sep 2026 17:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnv-0002Yz-8Q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:03 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jns-0007eM-OV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91a931f66so606455ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681079; x=1790285879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nbkrPNI7QdSN8Q36rJi2OpsIut3mcOZdXJ/nndTyFE8=;
 b=flDj4HD3YpXEuUq8H+jcVZmOmhCWdRez7OdeVEC9zS19MR5MuHzJ/SF1mbrYGisnzK
 NRUZxF78VSkbCJG5gIN1hJmTUQ0ynFOtu1GgT6e4ZWgr8l6TmvquBCL2/z7aTTSjuOu6
 bpyh5WL9Uusl+4UsmRowg1hFyfBpKkL2fxPRVp/xR/46/jS/oHUUvZv6uwMIHa92Tn7U
 LJ/mKAR0JpN08t7AJF13rHQiP3lXAdiBowCx7KQhMOWl1iWDlj9Uow3qk700qP+eJZF3
 QHoRG/SWPGQjxjg5VMhaaZKsmqcbPR6AgB9BUSvRHzpPdCKpQHmbNfcllJfOCN71I3dO
 gYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681079; x=1790285879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbkrPNI7QdSN8Q36rJi2OpsIut3mcOZdXJ/nndTyFE8=;
 b=sDoxCtu57upIucM2gmPYV2iuR1DLzNQsBD5rJen+D85Rh0PLvbfC7m+0keq7l2DgRo
 IH95/4tKZ7C9YytifpY68gQvdF0Hd3Wio0dxd/eYopmW3ypYC9avni+fDprIq9bE63dS
 UpNP4DpLEPRUkZwmYTMEI/Btm52ixM5a2HDK8NuyBZMkMuBCgJo4FGDWTsm0/kuKN3T+
 3B0E9B+qi6OYyjQZBzbyK+8ibZDG3J4W6JaJYttvCOc6UHjkSiu7VeLRUDmiuE9XOmlv
 8rm8QpT7gKrpJ5HizXda1xZGsKiyndfnpRzT3R9QO6l/RytuOs53jMqMjjuzOZVp9YBy
 3bBw==
X-Gm-Message-State: AFuF++ksSgUsnw0iORPGyy40blHE9ABfwYJzymlIdwKF02+MQ+EnrpWd
 I6lwSDHEA7EEM69IaZ4aLbOrENndEKV49xFxRzWeRXxPR+TNB+k0MiyxaAuEgw3iBkAI4xKy+6X
 qanaJXgc=
X-Gm-Gg: AYBFou2y9ix5AsmAg0Pzl+a+vp5O7IX3JOxwdhXnKp50ysUMWhlr5oPc/q4Gv5mhbth
 rNGR3dd0b+LHM4QqC4gpW9Yksxe/7lJtCmEjgkxHqc25ERsjZT8OlzcZrJXlqldSQ4txycsTvPt
 KGaaZsOvWnuxCuIPEVLLDSJNzyMTT5vOfv5feo8WGAhN+0SvygK+HI4wH+ZQHXRhEOpArr6v27G
 GxMx7ady2flGh3NTrQ7Ck4NFS3ZnZ6uEQYUY8JHvHKx9SO4jXUpWeRmpDHsvlBhU30FEBZFX42U
 jJzpx3CFoHHqqE0DRO2d2iPY/MFse4QDhrN6wrGH5780FMLH8PMWrzFFp1qkYK0pNCbznmhAS7q
 O/g8GlJ39PCb4KKbuukrf9ibp3FDtCU+C0j9TMv6f5qaTk56gWxRlllipJeSrHNo33BnMGWXENI
 Mw2CKP4MM3Vaj42pvtzTmkFhvXp5BNAJZERQQTncaMN/0Ct9O+Zq/cuPDJrWC8N9oGQgygO03Hp
 fINqpEww+EjMcaf7Q==
X-Received: by 2002:a17:903:b10:b0:2d8:d4d3:3fbb with SMTP id
 d9443c01a7336-2ddb1b77ab7mr9297205ad.15.1789681079415; 
 Thu, 17 Sep 2026 14:37:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 06/15] target/s390x/tcg: Convert op_ld32u to op_ld
Date: Thu, 17 Sep 2026 11:37:40 -1000
Message-ID: <20260917213749.36756-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-7-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 69d5114f244..5853804f2d4 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -510,16 +510,16 @@
     D(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESW)
     D(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HIGH */
-    D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld32u, 0, 0)
+    D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BEUL)
 /* LOAG HIGH AND TRAP */
     C(0xe3c8, LFHAT,   RXY_a, LAT, 0, m2_32u, r1, 0, lfhat, 0)
 /* LOAD LOGICAL */
     C(0xb916, LLGFR,   RRE,   Z,   0, r2_32u, 0, r1, mov2, 0)
-    D(0xe316, LLGF,    RXY_a, Z,   0, a2, r1, 0, ld32u, 0, 0)
+    D(0xe316, LLGF,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUL)
 /* LOAD LOGICAL AND TRAP */
     C(0xe39d, LLGFAT,  RXY_a, LAT, 0, a2, r1, 0, llgfat, 0)
 /* LOAD LOGICAL RELATIVE LONG */
-    D(0xc40e, LLGFRL,  RIL_b, GIE, 0, ri2, r1, 0, ld32u, 0, MO_ALIGN)
+    D(0xc40e, LLGFRL,  RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUL | MO_ALIGN)
 /* LOAD LOGICAL CHARACTER */
     C(0xb994, LLCR,    RRE,   EI,  0, r2_8u, 0, r1_32, mov2, 0)
     C(0xb984, LLGCR,   RRE,   EI,  0, r2_8u, 0, r1, mov2, 0)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 42b208a3cad..607dc3a3af5 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BEUL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-- 
2.53.0


