Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7hr-0006oZ-Hm; Sun, 12 Jul 2026 23:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hp-0006nh-KA
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hn-0001LY-Ph
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:45 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so29386195ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914702; x=1784519502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jj4m/zER4YcebdRR1iHI7o6k2JeRUvyIhqyN0AekG4I=;
 b=JqzGvBcPYuomAoA+c/EeVtZQjhhWdjRI4lKDu4wZ9kIlTQ3ZS105kjBJR0i1yw7d/3
 SVCDTU+IvtGSsCvaOFJbSGhAD9shPLP9SI9Q9uBNrGXK4AxcMUGCz1z0SuVnWK8tb8vw
 YxjIK3RTik07ZrVHeCeh94rlDCB9a+mx26HpysHMN8OdaTK19hfiRLu8x+L+zwwyEVRt
 4k+zRdGvsYTpgHWXUa5IjdnaknBhEpeTVAXrjdcyHz7sIAMlxFGfhtgDae5084qtX+9v
 yDnR7tgrUi1Eq1WUW81IrtaKkWnk/MIlq+2/AF1uxVwA6h32Li/f5e9U3ph8fewshaxo
 WuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914702; x=1784519502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jj4m/zER4YcebdRR1iHI7o6k2JeRUvyIhqyN0AekG4I=;
 b=TolEoPmw9Js/wBSccGpS1SFSvG9gyOcFz7Vb8j1gWXX/6QEo5vRjUYhRcSgC4k6POK
 HWyx4ZkvkV6gDpzzNRYTpwTxEcJcYTTogLliAeCNMfv/qUV6iUZKMURPorWuw0mdaeto
 0UaF+0ivejnmDCX5ruusrxD+wU0D1R1cXkaFFTs3g6/MisDWGyKpbXM1hcHYOWfBfu9h
 iFDQ6kzM+RqRtA2NHDt5immkFJH10YXIDUOnxctXK8EbkAGqhgc6a0SjenlKUU3pwNQn
 LkJaMY7D44rp6pLlxmpjUBdysLNY1oBxNTh6SmGUoeNIsX3ydh3ugEK8nq0LsT9iG9pf
 nviw==
X-Gm-Message-State: AOJu0YwhJKWigv7ylDXHbb1S0j/4RIP+73NshQq/wLCg4CE+Uxfm6iPM
 u7KtRZYsst6rXnnKrvv/4LpnmdWGW8i+5kGgKCihCxEqPsq+3Xk34y9mFsittNisAOfMKKI4A+M
 MH6w0ociDDlxJd/1OjoMxbgvSEnBhFq+8aCiOfTu2BRjgxeRmBwdlZnrDFxloKEO7inDvHB7Mkb
 w9VFwxJxUqya2eJR2OqoGXvyYMlPLxEnggIKrpo7cMObzFW2B8
X-Gm-Gg: AfdE7cmTdtL5PwRKo0LHw4N2Wk0Fd6nJP/ME/9uO0N+rsfVXtVy4xXshW8DHskb3O47
 D2XDNc2cZCfoh0njXWN0DU1dZ1dbT7lDe0qo9wgrUPYXjsB5bEqwXRDGkPmtE4SuFyLGhLM13Dn
 ghX5x1rshoPN0N4pt4iH64grZTUZ4cbV/NV9kinSp5r4LAj5UNduG+IMiJERL2jPOxLS0g8t7wd
 8FpPaYmTdWFdZLErEPsErnIWUHSb2QpG5IkX+IuDEMcBkZG9Tez9pcJkcuNyoTFant5WNtucit1
 9coyAk2jk14mjWJpq75pINQq5JTV4/++NqNO9SJ6zpuriwR1zq8A2b1g3/8swwfQY0kE3vcduRC
 UEuv3tmvAQkBUC2oaVYBDsGwEO/sHSnjfO+yCEPE9GwvUHJbgQ+0CYoiTPXLUsYvkJqa4Wm6Q0V
 0XX92+EMb6VH/ioDgRmql1iw9tOTnlhND69rJGP8g=
X-Received: by 2002:a05:6a20:450f:b0:3c0:9c19:65a8 with SMTP id
 adf61e73a8af0-3c110a30fb2mr7832625637.64.1783914701427; 
 Sun, 12 Jul 2026 20:51:41 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d3csm7739884a12.18.2026.07.12.20.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 20:51:40 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 0/6] target/riscv: Support the true Zicclsm extension
Date: Mon, 13 Jul 2026 11:51:29 +0800
Message-ID: <20260713035135.3996990-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62b.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Support the true Zicclsm extension so that we can trap misaligned accesses
when Zicclsm is disabled.

To enable/disable Zicclsm, simply set zicclsm=[true|false], e.g.:
  -cpu rv64,zicclsm=[true|false]

QEMU will raise a misaligned load/store exception when executing misaligned
load/store instructions if Zicclsm is disabled.

Changelog:
  v6:
    * Reorder and squash Zicclsm CPU property and RVA22U64 profile patches to
      make every single commit to pass `make check`.
  v5:
    * Add Zicclsm to RVA22U64 profile explicitly.
    * Rebase to the latest riscv-to-apply.next.
  v4:
    * Align ROM reset vector data at 8-byte aligned offsets.
  v3:
    * Enable Zicclsm for the compatible CPUs.
    * Rebase to the latest riscv-to-apply.next.
  v2:
    * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
    * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
      vector load/store whole register instructions.

Frank Chang (6):
  target/riscv: Add Zicclsm CPU option
  target/riscv: Enable Zicclsm for the compatible CPUs
  hw/riscv: sifive_u: Align ROM reset vector data
  target/riscv: Support raising misaligned exceptions for scalar
    loads/stores
  target/riscv: Support raising misaligned exceptions for vector
    loads/stores
  target/riscv: Expose Zicclsm as a CPU property and update RVA22U64
    profile

 hw/riscv/sifive_u.c                         | 11 ++--
 target/riscv/cpu.c                          | 10 +++-
 target/riscv/cpu_cfg_fields.h.inc           |  2 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc |  6 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 18 +++++-
 target/riscv/tcg/vector_helper.c            | 65 ++++++++++++++++-----
 6 files changed, 88 insertions(+), 24 deletions(-)

--
2.43.0


