Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485BC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8i-0002Wz-AI; Mon, 21 Sep 2026 06:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8f-0002WD-Q2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:45 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8d-0002gw-ER
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:44 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-81201ed7d35so715383a34.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986042; x=1790590842;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MU3j5DdojpDkUo+HWZbO22NdZmAOKpsWzCm5yMqrbpc=;
 b=SMdWJwx2YfD0NGDtgV/NgscTAsk7/RbO1e1SE7qfjBB2d2vANn8Y5yLltQGfx5KhEY
 1vyMr1gShsqjdqUzM6/7MwFWqMgHq8PJcUBrRPs484BbVA6I1bW8fPyvy13KDZfkGhWZ
 fTb/EjZwDcFsZHU7Hj3whqJodg8GZIKbsSAJTRTvDJ5Q57OVO+1nZ4pwWaJKijewKAWz
 tVe0Hjaq6pWcGacI3vXPYB1fxloWqGMZQzHifrxj/Xu8bXYcDWRxmombKo6diX4TY0fO
 FAHLeoks2V3w8y5yyT+iaQCuXrn2r1Dst5Y8Iq1XKOpVngSiOLUsa62J8NdtvllgT9tw
 klQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986042; x=1790590842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MU3j5DdojpDkUo+HWZbO22NdZmAOKpsWzCm5yMqrbpc=;
 b=VpJvpAsXL/tUJwJ7LJfsTqF+4xeLRM15sRPQAsOnI7ZeDQc1l+9MPZeFSfdLc6ga8w
 1vCk162YKRNenoPTwUqC/Zg34f52oHYujt4Ppg55AGYZgWzEfsJqaR5V5SKJFL8N+7Bd
 4Z9baxf/638nVIyYNKNb3wiUkh0fL74NgD0tA5/VrIu/c1/uxr4CGtTpsl456D+9Z8i9
 QlcEcvCAK99erxaUlKrXZSCeiledrBKa87ePTIWSlNPfLRSnt33enzGYdGnRlONTEMiS
 SJ4qdm80wDma2kHXO7e7eE1LjIphNhcGcHYzN96+O8v8eLkOJaRa8MSf71iJ6gWQCyGB
 HwaA==
X-Gm-Message-State: AFuF++mpwLkHUojr3Wb8T6D4KKdxmFag+/HIP15bLwYm1dkPsQaTdd1P
 nWiVXIem6wtC18UxWksZjw4Snwuqxs1LlPTeap64CSLJDZAy7EUGzPPhpmpcGi8/PRs=
X-Gm-Gg: AYBFou2d9/hfs93iIq5pdtZTPUEW9WGHRU0wG7eAbRwyrK4dehJh2QXTk/nj+u6M4tb
 aVSKTo9FTYiqDM46on+MAxg9XRg4GOu7SK44AfUCmmEptlSeSA+BFKa6AG5nwrB02Tp4EpBakO+
 v1cd1Jggf9hnYICgijapa3/NgT4wGrJHfkH/sGHNY+8vBnk++aIt9xbBRIpNQiBw8vfOXnPnu6b
 rSdvi5LhRfLe8jRT+UIF0CtXCSFsuKahK239v5UMJs8HdnkP01dAo7QE++nD9kuFJqnrf8XLtMX
 wbiDuVjljAbRFJE0KEFjaTXBL67IDqtcP6oSA+sdPfzhNB4bcthmQgNLgDwRSOvxwJAIt8Jigdd
 3FAQ0X9HJY78QaUugfUvYdX0VegdC5Gz7fY3rveaWiNt1FhCVp4oywYPO2IbD+jFjeheeJTYFeu
 fBJSAbA7bOBvbiSIikjxw5Ze+wrK7/nuv+iWnj+RM1LRkwC9vEaU8Fcjb/PQ==
X-Received: by 2002:a05:6830:43ac:b0:80d:8068:8930 with SMTP id
 46e09a7af769-80de20c370fmr10379623a34.20.1789986042400; 
 Mon, 21 Sep 2026 03:20:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:51 -0600
Subject: [PATCH v2 09/11] bsd-user: Eliminate unused regs arg in
 load_elf_binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-9-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Fpvf/ndW3E37GgGy7AIEbp5orFY1Ru4OJGAmXefIop4=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTe8cI6soK/+1f6RCXt+1UfSJiX5se9FWgDs
 YnmmpgWuu+JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAWfhAA3ZRsYrfgk7knPITv/e6XGzjgSB6C7QP
 Sn/QTiyeHdl0BN9Ht60czYgnKKNr34fuqPJlq4sKyBKLQUgDJ4SuJ6ugdwV4mjxSXK04C6gQmg5
 iLPPFj6dv4Pz6CMgv6aZDoU+zAZLLRiMOMIuJ1wxqv3tXcbPnLNCQDaT4OcUccCGATVUnxlLOgF
 KcPdKti3NFoBniP40URHGmcXFaSg4D2pBRL4wDVDibTZ6a4I0AOn5/2CD2bzEotAIRnZd3Q/+Wa
 AR4+yK3ZoKr/vdWXFxrK4X26OCwLaxQnwLUJanSCRWibEU2BMYEfBqJNd95J5FpWZbWFPLweMew
 k/qnwDJaV4Cx6qGxYd6ZD/raQwZQ1DB+5/9Xgtv3RFj+VPt2yq4YvpJtqf5gfeAF89Bq4SIvXrp
 1l3E1qPJHeKE8M2GeJkfqzHFjk/cak5GTlPMU/UQDAQVKz6yxDCG/+Isumr/QbBzab8usbbxEi4
 sXVx/+siMYAAT2qEBDffMDUcPu3HPQuZzvq2TI2cve21yN2DVbtg3rDM3yRWpnWeYlo8D8k0avY
 G8JpTa6ZYiAmv748zAk04qGwKnexDtQZ+HDAlh0nFf2IgtuBrvt78jRfl1WndnYsXlrl+gt4Bx9
 +zbbhku5LIJyrkPLDoh/isTp6hpuZrW+FSNGhpRfTx2BVcDuot3g=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsdload.c | 2 +-
 bsd-user/elfload.c | 3 +--
 bsd-user/qemu.h    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
index 5b3c061a45..dcf3ca14fc 100644
--- a/bsd-user/bsdload.c
+++ b/bsd-user/bsdload.c
@@ -193,7 +193,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 && bprm->buf[1] == 'E'
                 && bprm->buf[2] == 'L'
                 && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, regs, infop);
+            retval = load_elf_binary(bprm, infop);
         } else {
             fprintf(stderr, "Unknown binary format\n");
             return -1;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index a87a892eb8..295dad4643 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -598,8 +598,7 @@ load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
     return 0;
 }
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info)
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
 {
     struct elfhdr elf_ex;
     struct elfhdr interp_elf_ex;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 851b0c2c5f..5baaa333ed 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -167,8 +167,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 struct target_pt_regs *regs, struct image_info *infop,
                 struct bsd_binprm *bprm);
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info);
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
                     struct image_info *info);
 int is_target_elf_binary(int fd);

-- 
2.55.0


