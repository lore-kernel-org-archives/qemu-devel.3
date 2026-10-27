Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE833606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NT1xullX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLago-00033E-0S; Tue, 27 Oct 2026 02:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagf-0002SO-3I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagd-0008DT-Ez
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so2783845a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082569; x=1793687369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a5W+tZ8s9CCZD8xi0fns/rEUgjkiM/xgO9Z99eRivP8=;
 b=NT1xullXOLm3yJMZTyVLNdYX0hKTdf6BIPSNbKixAm8ldJoCKba5w0gJALKd29BOR2
 SlLs9yOQRtLD6G3JUCgIeVClS0NFL63YVxt2EG5ZS7ldlcI//uwlgLtIczcbTAiSg1Re
 RJOZBGO2FgWy8WCEvnoJaFO8RnFm9qQagoTZDPH+3+b8Iy/Lb6dic+m8cWtZwBywQmdl
 D3u6GR/N0Z1/w8ZN84+kHBTddE3lp48NpVvxb7tUcb7fxKKPErqZbXU3ynMWsRAH99uQ
 Vfku0QtrsuqnDjkVQpCXhKcCqIcnzqwodFzeGoKMiKpcikVDhyuVk20QiX5o5MXR5PuT
 jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082569; x=1793687369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a5W+tZ8s9CCZD8xi0fns/rEUgjkiM/xgO9Z99eRivP8=;
 b=MfLAb9mHtJDk+hFgvC1de+kXN0W1j8LwZMLeNhUglFRzS47AdT3T5zvvU/n8Wzr+un
 dTKI6TnQBkw71Rn9ffa0huJ/lsRvHhXzqjksm737StEURKrVJNqQ4gKYVe4C7aFOYjVL
 nofQ22HvyX5ETZVBYEH1iaHD1h9xt/E51k9rXVjECTp/LI7G3kKIvyIDOe4gpOvyC5ki
 jSt4WVQS6P1F+ahYd4h1/FvS4+891ZplwxG8j5Cb8Q0w5xry7OXaf8ADvo9yB0Ua6i90
 PkG/Ja34kgrRjVhHfwz6o46i69cklXMuli6HugKeujlJwSs0wnHbeVYsU7++L2OBF5ar
 4ORw==
X-Gm-Message-State: AFq9FYJJLTwXHM+OsmKQWSjr6rheeu02vBCeu+iEmmOz7VDa+rUlr/sI
 ouDKHHCTI84rhHo7+y0YJoxWw8kwb/PuVx9T3yxPE4BOitVs9mmFtmRuLXSJBQ==
X-Gm-Gg: AYBFou0YuTY2vzZ/7EGbxgCDYHVbu8orrlt30hW+0nl1byn+SZW0mACjQl1q/AKzC0l
 Zx3UuxgEaLdMYutLd9505MYMVZyogAlxLBuOnHALOVMavRppxInuyLFEy9cUzcM/4Ydt2KAeTsA
 pP+3I2JYR1qnJaxhX+Bs3rlh5t36XrFXERQqANXU6cadnvhiKG1h+MnUeYAJp84mM9JDtnZTxYF
 A8JgQ/KzFKpbYBKgzcNbdk3XO3F40cXBuRX2no4V7xim4dWHo7ePffIODqjD3rF1AlBOed6VPr/
 XE4DBZ2orcNJX5+2jdrPVVUkMWedN3WdOrI/Hb769N2PWR/IvbSfeQx5jfUJc/cjF45jKRwi5ZO
 kkI6RN29ZqFcnHd946SQfdb0C5PFp/JJPLJZepnUuvk3qTL03dzOZwEFkb3ZXGacoqc+3dIVi4K
 kWROIK7VilaeePqhbIZJO4qz+esnU1xvsiboSY2iYb/xXoovu17ZlRk5Q9Nhg0Sj+wh7l4ghI6V
 Tbqw19a5igrFpR+HvtL88TGKaGshFDOWo1bw1QsekknpDllKqh0JBYohcQHmpM0JXO+TpkvzUb4
 ZBQS2WqbevBCmxDoqw0RHXaHtcKh9QgmUDcaXbaDiuMi51E=
X-Received: by 2002:a17:90b:4c85:b0:3a0:9c9d:eb18 with SMTP id
 98e67ed59e1d1-3adeb10fe82mr8078423a91.54.1793082569354; 
 Mon, 26 Oct 2026 23:29:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/29] target/riscv: make mnstatus.MNPELP writable with Zicfilp
Date: Tue, 27 Oct 2026 16:27:59 +1000
Message-ID: <20261027062808.1995205-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

Zicfilp adds MNPELP to mnstatus, and MNRET consumes it when restoring ELP.
Include the field in write_mnstatus() when Zicfilp is implemented.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4222
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <6AD0895A.0F1C22.05843@cstnet.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index e6d25e5c4e74..242f5caa0d68 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5766,6 +5766,10 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
         mask |= MNSTATUS_MNPV;
     }
 
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        mask |= MNSTATUS_MNPELP;
+    }
+
     /* mnstatus.mnie can only be cleared by hardware. */
     env->mnstatus = (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
     return RISCV_EXCP_NONE;
-- 
2.55.0


