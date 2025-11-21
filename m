Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC2CFA471
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJKA-0006Hz-FN; Fri, 21 Nov 2025 00:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJy-00069O-FW
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJw-0006oy-5d
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-297e982506fso22050555ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701469; x=1764306269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+qfbZQ+LM2ZIXAyRAEmu54btDTIb/g6gYHrgwx2V5I=;
 b=gjHYoVgovhkLdU57gh7XNW1fCLV/U+PKcfsrO3H0HQ3auOP6zP7QR5g+/ty5Q9CfmR
 w5TnMof0n5+TC3SdMsvHxjAmufamc+BopNvF54vrYqYnm3jZP6BgxGN0Ao2ir38TAaIy
 Hy7by36L71XmCoLR7WZfnrT06GfF1XHP7/4Lx67WSMtXqpVu8ThY2x0UKiADm59y3O2f
 q9HiJhlZB52u5gGi2hy//menILbKp5hFZpWWSMSz+d0XPx61npcnAk2E/xvnpVlwFFuG
 KR91MPsj4873brrR7bD5gqCiO3wwERUXjeWBwGfkOreUcQPkX3j6rHWxz0xLd7jpdWxc
 V7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701469; x=1764306269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+qfbZQ+LM2ZIXAyRAEmu54btDTIb/g6gYHrgwx2V5I=;
 b=rYfIlb/WEip272h8SoO8BxGuVsAVEZ40ZEqANzjhzARvTLzwteJns+kjhK5YI8WX01
 BldNWp8yGGwKG7G02f7AhL/+U52WBRP5IuUf/lsgPML0/a66cFmkTmTdrAMQAsnH5yYH
 XNg63OqDR9ywimBmfmGz/ta0905AkO7Tq1eHlcQvu59XVPUGI+9/ILLtiGqCdwI4Pjn1
 5jZm7eB7X8FRv1vjWA4U4Hz0MyqH254IWJ8ltshuhOCO8WZYHUnZ57IoYovRPngseMXg
 aw9y9FeSqBxZQl1yHI7bfrZoLmCsblIbqj7uwcSmgbGRIefQ9onxKP7EKpgKSo4w4i5j
 kqmQ==
X-Gm-Message-State: AOJu0Yzo1eZNtXK67NWxSxroFJFGcyr9GRxUNax55/iW3RXbNe9kVhXR
 4QsagTdzB4A7NWz0wqsJuU45XXpH4h8qd2GJEpouq8HM+84w/lQm5+qJE+qPVQN8RDNd1jhjeW7
 3bUqSvWQ7Rh4StMUgO0QgzRfy181TWC/DuqM0q2+o7Ccdq+ihbCNx42P3zX0HZLsqz7TlV7xyJO
 3ZhPGQjO73r5il0yjsTWP62UicSPDhjKsKUr0Q22Nhmys=
X-Gm-Gg: ASbGncuD69sk2aOLkoUIbZptlZTk9omCgihqBfhZQRtcNY3Qnh34xr/n1S5ckfCj63h
 3jJfL+BOYu1ybCpqsiyr3If/DrHU5fooMnJH7SVk/pP5CgMcm/SGP4KewlQwuESk2b5znzPqMJc
 q2NT+tu7VQ2wAWcl8ZnJ46VItAo0hkBHu4BDmWQgwpeDI33hgQlToCI5xVrkvwgFTp+ICBmkJbK
 tycyyJBfbtttfAmzbVK6Nit71ZKrSFljKLQ62ApKH/6eOTgUEVG0ARGyMAj0puQ+Gs8c+DluzHJ
 XibdT2CVwP0aqF9DXtanPtWLg42z1vWMc3PMuJB3ZVgWkl+uMzVKzrYZY+XYbrcycpiUQaAoodL
 GZzltnD1aIw/2XZ1evHdO4SB8ABW0xKVMtbcEDCPG3voHCX2ssUPe1YSS2XGW3dekLuw6iO2GCb
 DN6hndpiRBx7nd0jLcKxxMw8fxFC6amK2Tamb6xw==
X-Google-Smtp-Source: AGHT+IHlx6ub8IXShKcw3APValCsZ0rsVa0izJWSlRPVW/qwPRZusH9uMQwni9Gi5kfPtpQktRqQHg==
X-Received: by 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id
 d9443c01a7336-29b6bec4961mr14163685ad.19.1763701469381; 
 Thu, 20 Nov 2025 21:04:29 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fed2sm43384525ad.69.2025.11.20.21.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 21:04:29 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 5/6] target/riscv: Rename riscv_pm_get_virt_pmm() to
 riscv_pm_get_vm_ldst_pmm()
Date: Fri, 21 Nov 2025 13:04:12 +0800
Message-ID: <20251121050413.3718427-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121050413.3718427-1-frank.chang@sifive.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
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
index ab285d7a6d1..9ba01b9f90a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -847,7 +847,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bf747834dcc..958b05aaa32 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -258,7 +258,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
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


