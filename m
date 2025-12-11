Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EEBD41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgl-00038O-6B; Thu, 11 Dec 2025 11:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgj-00037U-HY
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:45 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgi-0003vy-3l
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29568d93e87so2611725ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471122; x=1766075922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGa2OReBRhkwkplSgIby1jlHjdvdP9VfQlGsI8OAwZE=;
 b=iEbtf+vmpfksH3WsuSRQyujfOLexaX1+h1EBsk7XydRIV0j3Ceu53T7i3h54owczqX
 sri9kCmxDF3VBIEkxh4HSAzITDpehfHH5Z08WD4uHU1gsFPSHDHChOl3OjCRODL6+t3K
 91tTUWGZCp6mpdU2gsM+icB70UQrW3a6MRrJ5zdk4z66nymzg3lD2i8mXymIS6mtFUvo
 UzwzvGyAcl41ZPyOrBhf92htNhcLnk1HPmWOlowrAeN9b2V0xlMRytE9ubQuLV4FE+TE
 M2gps8qO4K3H3FwQvmFQGO/yuJRy17UzOzYTuDQmsTI0rEVKneJx8LNLvvV9MPPi42Wh
 3HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471122; x=1766075922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qGa2OReBRhkwkplSgIby1jlHjdvdP9VfQlGsI8OAwZE=;
 b=M/xVBjhbDIJTOXiRYrMegbUDcVHLcHXR4uvBtXYyBg5HpWDbzI0u5rut+Mv1aLhC/0
 B4E6kQHpZVgqJUtWpT5GssdpZK3Zzl1IPKt3Bwk7wM3I8P6AipStAP+X14cBQXwB+XUn
 jQvEV7NKBRDzDlc3ufLm0vVKXNdarHaeP28rVeoqXgj0mwYhasxv5akOnE2G+ukeUysE
 H2XXc7vDudLIXgeqy4aB3axIge+soHUpWzZOxDWV9THkpfIOdbRERipPmijp5cSDBdN5
 HcjqaFcC7EfUtY1mtldt9Jb20odGBGo7mBgMfZhkjDry+X6Zaq5K3BDe2xnmzil23GwJ
 lq+g==
X-Gm-Message-State: AOJu0Yxk0GnduuUr6i0eT70XkxjAU34+/nPXNea+LHE1yNs5I6ZJQIvS
 PL4xJkP5u3Eoc1LT2ebprRJgFv4mQW3dWFyeaqf+DyrnSSGhVQak17sASyTQhxSIj+Y/KlY11jA
 dcA9aurXTxhBzcIHXHzWwwlYx4/qGR0oQ4ax59cOtpg4fz6DCBwgWhX3E+Uw9yLi5rkxMvQmmUK
 rzkI/aprLj+Cb/e+yeKqGVYVa9bx1cCfoj9AgCHswupb0=
X-Gm-Gg: AY/fxX6XbB99zLnDrPhzKS8UJX6TdJ6wLtXbyAeuels9vqolm81WSox2TE/6EMhSafz
 zknOQI6mK67ea+kaMxEHpGAScyzqXcPxBOcJcaNg6GHPCtzPqC1OBE+1as3CdbwQDOrXOtYdg6W
 1aSbXfKWUzuyNCbCGVJ3o6vCRlBxfwneHQRNQoFVj6r0TnxL3iHP3XmGvwSqSGcvjV0wdQKGGBW
 aK/0ji2JkLKs7zCDEIHaEthrgENEwal1Stog6+N4w2fAWHToaJrzXQePsI+1Xrfr+nwDAhEggMY
 mD0rtCKHhPcrW8bzezcQyReQUrtCqb0nGIevkYahvpsXQli+twhFHPupADOz/wsTjihcyi2mgPX
 Ph4lRh+GqlsvMpR/pp3v/bI0h22YtHb7mspDWTcAGkZKllHI462k/KzpsQ9NFA5XhfAsUcRi5FN
 XB/fMm+RJM0Mam/VBNDFLHruR59takIHW4C/Iufg==
X-Google-Smtp-Source: AGHT+IFNSY3kHjK/SFmRZ61MXmehHFMngla/5U6zKFs/VrxrASW6dOzVPpQjU57Ss99sF+Rjbn7IWA==
X-Received: by 2002:a17:902:e849:b0:29d:df04:fcc1 with SMTP id
 d9443c01a7336-29ec27d2be3mr69355345ad.53.1765471122075; 
 Thu, 11 Dec 2025 08:38:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:41 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 5/6] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
Date: Fri, 12 Dec 2025 00:38:24 +0800
Message-ID: <20251211163826.3998266-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm() to better
reflect its actual usage. This function is used when checking the PMM
field for virtual-machine load/store instructions (HLV.* and HSV.*),
rather than for VS/VU modes.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 2 +-
 target/riscv/internals.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f59052fe7dc..b4cf86e4f61 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -883,7 +883,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8f2a7234184..f6856a10bb5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,7 +214,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     int priv_mode;
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9b3f01144d2..b17b661e2a8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -190,7 +190,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     /* get pmm field depending on whether addr is */
     if (is_virt_addr) {
-        pmm = riscv_pm_get_virt_pmm(env);
+        pmm = riscv_pm_get_vm_ldst_pmm(env);
     } else {
         pmm = riscv_pm_get_pmm(env);
     }
-- 
2.43.0


