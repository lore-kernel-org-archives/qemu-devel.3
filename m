Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07968606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j/WjEOH0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTU-0003qp-1C; Fri, 30 Oct 2026 09:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT4-0002rW-2h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:33 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT2-0005Ym-DT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:25 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-843a4ca671eso308389a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366182; x=1793970982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UYG7YseAeEwVr3rhaXK6Mt/QyGw+G8RGw3F7A/nr5iY=;
 b=j/WjEOH0KCrzwFVGCcfxpf0vv5wX3Hwyn2sy4gyAkbHDJcJlMEvLO2EJkglA80ST1Y
 gk2BNdyqULtBaiFT+J0HdbHlbqQqd9UuQpTQ06HLnv5J+aFYAy0G+TvdakVEIvQR1wmI
 GReJTnFP9kMtxkoI5r/iGJ4LVir59I37YmUO0m7kMiuLaVnj3ayswi2JRsE2sIYGQJ+N
 OigJbKx+ChPNJGc9z4xblkAMWI6MWbXVtifaRFn8uKFjJHGOOuHVNrj6kFojIqeN+IRM
 cN8G6J7FTM54OO/v0xzQFRrtsBBdR+7+h0tsodqTNZNQTubiFUE3MZfMdxAdS+mcydY7
 NwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366182; x=1793970982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UYG7YseAeEwVr3rhaXK6Mt/QyGw+G8RGw3F7A/nr5iY=;
 b=Gd5XZJ+3qljjTM39SbUwyAyJA2m6dP5dIZhvhcyZsYdkEsh62GY7xPIcB8k9K+mRo7
 jjSi2nYd8OEitC6lIsyNBu0hUnvmT98QGDDQWY9UcsxcB3ayfDW+vEerTHm7PGMytLUp
 exmMo8PMQYOTUksV7aDlb50bXCpqsJaaAI8/5EJZz/rJzJYH4PuhseaWVlZEl1c9ca35
 P+VRf+yc+tAQcy5NqjtekT/7sht8XdgAAMKQbvPC/u3nQL/Aes/A7KNtgepCp2jsgFzC
 ynXRD4aRCobMlxSv6M1T/oiW2Zl9XeY3JEM+7xgDQGkvq7htnReUYN3dZ1iPvGRBVd8J
 v2bQ==
X-Gm-Message-State: AFq9FYIOpNg5eHkdKEBNOmG+fdzbfjXl7/gvDSau/Q6Ac88xp6fhsZLr
 QtKsnfof5OYopn+i6wrE6Bbi+IYVqaXqKZOYGZ8rqqeRkGCzvy99GT+l8Ad7XriwlJ5JEQ77M+7
 ulSos
X-Gm-Gg: AYBFou3xDG2NgzNs2hG91bq9d+R9dbsEa9K97WzZYNw2vKZCwlMPxz1BWZipihme+Bx
 oBi2i9q204GHDAd0nUdu3hitNn9MbU+p/T+2xRyGtk7vHCXPH/81qQUfZNGiVt1Ma4Pcjor52Da
 O6dsjaC72S1nwv7b7GmREOFnbQMZ69XG6+pC0Wrf4TSu2bzbJ/RsBlF8JQ7fOfPLf/q/ZOUffeE
 SIIjrYUF8jPS/l3ypDctZPRJ3ciCImPz4hw9Oe5ChY25EeIWEDoguUuYiHCXI8feNoMbnBDPDI2
 t6x+6uKbMFsuS8iKs5LIPQYa1SyjIdHM4S2+lLHdXlZ1h+auzd3u7ewnhBn/Ue4qN1AS0ND/oBK
 w1ZXEYZUYmFHiXs1MHX7QSGPt9e372rqDjLMgSiUnuhopqvK1djchEtxU+o5XDGKOBk2YyCj53Z
 W4kgCLqJfEx5pUIK3wMRd/YQoLR8DlN4JgwMVNTFuR5JKRo4QaMIumCwDGlOTdhE7HFqFNmIUpf
 4jzGvgJvhnQAMQED5fQq8yCAAYvPJFv+MtfYmshCek0JJb7mwvsCNuRZuKHFmqwgGhCFF1YX9f6
 OzSg11myt1yQC2hBX7/GP5uSbYUdUg==
X-Received: by 2002:a05:6808:1a21:b0:4fc:248a:de3b with SMTP id
 5614622812f47-5640dc291femr1512103b6e.23.1793366182108; 
 Fri, 30 Oct 2026 06:16:22 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 17/19] tcg/aarch64: Implement INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:52 -0500
Message-ID: <20261030131554.41208-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 tcg/aarch64/tcg-target-has.h | 4 ++--
 tcg/aarch64/tcg-target.c.inc | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 86672b2eab..b0868e5827 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,7 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) < tcg_type_bits(type))
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index b601b19c7f..5c186156c0 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,8 +3081,15 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out_insn(s, addsub_realshift, ADD_LSL, type, a0, a1, a2, sh);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


