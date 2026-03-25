Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF68FEA803
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GM5-0005du-S2; Wed, 25 Mar 2026 01:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GM0-0005Yi-9u
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:00:28 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GLx-00078T-AU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:00:26 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35a04d6aeb0so3463538a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774414823; x=1775019623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gH+6/OkYs+jyl5RnS5Ne7ida5C4VujMkacknoAGjFRA=;
 b=X7SJY0BtuALJ0f4VbOSo+Sxz1i4sz0nUNRsngc0jfuC09FBONDCukcIDpZzJxVrFEW
 33L9XrqXAfRYzzfiJe24gzLjyXFNJjce4T71I8tE0Vn3NTblWgAA2kp24p1iKiiRMKGG
 ptDErZOHzQ0Sevc7GeYSzYGztzUi28H2tXCiQTXQ5cMotWhRT1APAJ3V/yk8lbYZuz4d
 J7+1hnJBYrvhqAtdHi6K6RXvX/zV4nAo9VZUrgHjc8RxcsaW1vlmgcZzARWMIoivIMgO
 omVRmUQ9DaJETTTyNsEXymajGYjrGeWQX9/7gNcu8LH7xQGQ6ZwWA1oVuNrUjGpxpE9C
 QeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774414823; x=1775019623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gH+6/OkYs+jyl5RnS5Ne7ida5C4VujMkacknoAGjFRA=;
 b=hcJIZSa+s8IaRG05HhP3yJ9rXFAewL9RvpNikKGUythxxPqDhOoSM0QLLOw4LlKu3+
 d5VdDlV9MJqz/I1drk/tANjg4CG/PVYgNBjx2sxGMJ4Mtu5iX2WIpSPvsBqmTN4k0LYu
 dHA49oakmbekKWV2k3UgScTkPUbj1zem3o5JvU2PV9SSO6022bySTNrFjzRBUOX8sT/U
 yW4TzAyFWRLJJzY2qjjPDEXsLlcS/J3qkw/sWTK7M5KlXxZvM8Y11GhHqwGSBxdl5avw
 NVaV06gxVbCz6AIpAWhGPTGmBpbkY0onk98FFIYO43Gv3/7ZYLGFy8nfvRCLIpPr2Bzx
 YuTA==
X-Gm-Message-State: AOJu0Yw3Qmu/JvFa5OhaaGZIDGGEJ1/onGlgOHxSXfwSgWIjKtZvUbV3
 1rqTY7BWwijazu1lztanEwU09BG5HRqLBoDjIYcBVCnQkarCDuSKBXjuLEPHVtN0b1Bu3NtrKO/
 GvQ5TJWxxxFOePD2sjgwTa+DnRRL/MHU0d8pIeZ4tDHj9OLb4YBR9DUj9t1xe1ZlXNjW/kX1uSs
 ZK5tusCrbY5rZNIqD5BBFieu4gW1jwjJWTGw8KdU5qsoU=
X-Gm-Gg: ATEYQzxCkWx450+U97h4FHgOpLPJMfVeOg9lgKu0z7TBZGdbZct4a71771L4BvC1vC8
 P6GJoq1QMV6RLNP143//HFg51/pIuQLdz3tQqxbvtBnRJSPgkhQt0J3w1NURPKEE6TS9UZQ7fAS
 ppo2VCE7N6Zum3G/JvIRTgThecwDpo1pyBqtk8x9HfyPQkypawwJogpq9xIYls3uVFbf16RK1N8
 vuluu9K0F21nZnLBk4SfW1oaHKWOwq1b3+l1R0i0Gwtxf6pH9VV1Ee0FPxwl0ESN5ljW1dSbexf
 umaxwioyobeRyZDRsuU5Ua19ew6KYJAmEGsi64rDpak7/CSeFz1NC18eR6DcMUkLERP/VQrzFJ7
 VqaKABTksR4sMU9iSqeUXqhzu9/QeeT4g1XBWmi77LQqLaTRuJgWjEi6GTFiFf39Brcbd04i1CL
 +kiPdU70g4J7o18+eU7zGicgLe+ZdPuMcNsEgA+KkEHjrj1Vcbk9aLzCfwE7Zzag==
X-Received: by 2002:a17:90b:2e49:b0:35b:a8cf:7960 with SMTP id
 98e67ed59e1d1-35c0dc6276fmr1838065a91.3.1774414823330; 
 Tue, 24 Mar 2026 22:00:23 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c03149db2sm4218866a91.9.2026.03.24.22.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Mar 2026 22:00:22 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/2] hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left
 residual value bug
Date: Wed, 25 Mar 2026 13:00:10 +0800
Message-ID: <20260325050011.66722-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260325050011.66722-1-jay.chang@sifive.com>
References: <20260325050011.66722-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102c.google.com
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

Reset irq_overflow_left to 0 before setting up a new timer. Without
this fix, a stale irq_overflow_left value from a previous timer setup
could cause incorrect timer behavior.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/riscv-iommu-hpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index c5034bff79..e8d284ac8b 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -228,6 +228,7 @@ static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
     }
 
     overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
+    s->irq_overflow_left = 0;
 
     if (overflow_at > INT64_MAX) {
         s->irq_overflow_left = overflow_at - INT64_MAX;
-- 
2.48.1


