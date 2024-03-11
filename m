Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E447BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjk5X-0004yv-PH; Mon, 11 Mar 2024 14:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4d-0004oD-QW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjk4b-0004HG-Qt
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:08:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29bf9bd1907so947136a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710180507; x=1710785307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ov6rySqM2fYlrkg97PbmbHbkAA2FwOYsS7BQ+puwQd4=;
 b=g6VJKE1VLFAVzzh4tQzfu5H781y3Cp2ad1JEnfPjn1+mO4tqfjKNFCQmaVCQM/zhv0
 8DGPBswRZsZFNqVSYubZ8axaIaCtxBq565PRCiPQqVTkohqlCOMVsEmXw5e8MlzBca6J
 llVP5fks21MA6YTAWZ/YhvLoqySA0MBA9uRbJMReTe3NKCENjwUHM3MknMj4U/Gdi+Gh
 Quug6stBaCKlD46WgBUTMbErBFso7fcRZ6tQkBdtBo8uYAWS6Un6whCBApEcz1Sdpntd
 CkJgfM5OkLmIiybJRAi3sbWpkdUNDLfi6yopl8+NpHmMaqjNrlBqdE5gbuiFQFb6Mmqu
 5jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710180507; x=1710785307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ov6rySqM2fYlrkg97PbmbHbkAA2FwOYsS7BQ+puwQd4=;
 b=k7R2A5s07wpS8cTqRR5UIU051ZRHwAjA27wVwk30Q6dIiVOgPXtUFnsuc9ZIm9xi4z
 1uPiqOK5rHFAn8mq458+gT7AUejElzggpQWsS3mKjKJ7epZH79JEH3dyP5OASgA4k+1P
 sf6DRun2a96anLaB2uzCeY07eM9PD0gKZPud17PcMkeyzwcJqIwGkzAR2IIrF8aHojn7
 rRLQ5Sh4ptpU3pqdVaWe3vOruZweFXgzw4gPFLx0O5RqsJXMydtvyiBJICb/i3Wua/sx
 Cnxe4RjG3CFrxGQTUm/hctmT3I0d4VcJ1RqK5BYSO34TJ+S4itOqBIPNm7w50SEFCiFk
 ycxw==
X-Gm-Message-State: AOJu0YyX9W9jGYE9gCgnE4Ix7YQViu3RMItxMR8hrPR4wHnFyym/Ssfl
 yF/Q6z7fEhLgR8B3WIU39bhLVUyqIro1Hv0i+CWXKHYTCaWTOOKsz9Fy5EVwyZ4c5WiUDe1lCw4
 +
X-Google-Smtp-Source: AGHT+IHzuPkIDNUerHKgPFtxK/uwdROwitle00GUZx0e+UCYqmK7Ua8wjqhMCCZA/hHkeGPYgnQf7g==
X-Received: by 2002:a17:90a:6047:b0:29b:789:802a with SMTP id
 h7-20020a17090a604700b0029b0789802amr6095530pjm.31.1710180507611; 
 Mon, 11 Mar 2024 11:08:27 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 hk13-20020a17090b224d00b0029c2794d3f7sm525810pjb.7.2024.03.11.11.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:08:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v12 0/7] riscv: set vstart_eq_zero on vector insns
Date: Mon, 11 Mar 2024 15:08:14 -0300
Message-ID: <20240311180821.250469-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

In this new version we reworked the commit message of patch 4, as
suggested by Richard, since the solution we went for in patch 3
trivialized the removal of 'brcond' since we're doing an early exit if
vstart >= vl.

No other changes made. Patches based on master.

All patches acked.

Changes from v11:
- patch 4:
  - commit msg rewritten taking VSTART_CHECK_EARLY_EXIT() into
    consideration
- v11 link: https://lore.kernel.org/qemu-riscv/20240311135855.225578-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (6):
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: set vstart = 0 in int scalar move insns
  target/riscv/vector_helpers: do early exit when vstart >= vl
  target/riscv: remove 'over' brconds from vector trans
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/vector_helper.c: optimize loops in ldst helpers

Ivan Klokov (1):
  target/riscv: enable 'vstart_eq_zero' in the end of insns

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 198 +++++----------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +---
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  32 ++++
 target/riscv/vector_helper.c               |  97 +++++++++-
 target/riscv/vector_internals.c            |   4 +
 target/riscv/vector_internals.h            |   9 +
 8 files changed, 202 insertions(+), 192 deletions(-)

-- 
2.43.2


