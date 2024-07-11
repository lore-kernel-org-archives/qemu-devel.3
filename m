Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31090C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KH-0000UQ-4U; Thu, 11 Jul 2024 18:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KF-0000OW-CG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KD-0001ai-GY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fbe6f83957so8388685ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737099; x=1721341899;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lf1t63bHbu23XIWS2dR1/nNg3lRwXNctcRaYNnDIm2I=;
 b=naphpA/Xs9MpHiw4Bopm+nSf1gIWWEBagOskzJqKzT5upaSv2HM0bZnrf8ax8UBxhG
 HZsljDY7uUvMg2xxXPa2QYNOIJUJE0bakjZoTAbiZNc3dewRnVTDJ6IxqTAXSZ3x6g6K
 +rkH9ZVbfFrsKrROz8/aWUzsYOILXbR6Db9TLrcsS+DqEAoWACSl7TXTbtw9U9Emw0St
 6IM6Xz8c3lZp1+Xcv8PlBkgterRZEjx2haKIjLRTWkDmNwWvneT9BlfsjylLEdgXGMWg
 sww9oq8+pE/rGR2ZLtwHRaDU+NV1Qorx/M797zA10M8nGTjhn7GC5mXE5FZPTjNt2/q7
 cjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737099; x=1721341899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lf1t63bHbu23XIWS2dR1/nNg3lRwXNctcRaYNnDIm2I=;
 b=FhQiElAguYeVoYHEFBQg5LAMcNluV5pYylaaD5k7vzQpO8WxoCqbFeQzNjjrOfzJAx
 1WfYQsLgdbvb/GojVWcz/ZPn2h9TfDb0zJhrBcNfOw08g67D/CdYp8ZOkkWqXVmMJlvg
 +HMLgK3snBotRxH1M4NqWK0TS+wOgxA4TacFpi/lat2fMFuZHS9kqENj2c1r710diSrm
 xTkjKLGSf5Tzt5ozodRSMAkrWBBp/Hp70JlG+sO7U/gQvbgmSqXs/aKE70v5es6uCydz
 oARlt3OshglOWFw+oyifbcAcmTaCTUVKelz85EoSGAt9t3m0gM3l1nNE+heLvurSL7Gd
 C4UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu+uryykmWmn01mdoZ0SIwGyOGzCfW1NHYbT9i5uzFidvcvBwAUYd2swnxaCZxjR0eq+cFHiXQ/eC08sCIjgHivQOxptI=
X-Gm-Message-State: AOJu0Yw+3u+G8u7PiAWcON4G6hK/Ytqf2MCe+VWoj3Myv/80XN7S9v4r
 sHOW45MhICjeh5w7vffJRNvzwnBLJFN80mAaNpy9Al2lJLsPBXxknaAQGYXGNdM=
X-Google-Smtp-Source: AGHT+IFRSkpeavxOw81jP1BJryBOo/9V41KKV/ZC8ei83uNk1AsxhmEDTGo3taDLpLos3SaRcTLzyQ==
X-Received: by 2002:a17:902:d4d0:b0:1fb:779e:4fd0 with SMTP id
 d9443c01a7336-1fbb6d3d176mr94074165ad.24.1720737099073; 
 Thu, 11 Jul 2024 15:31:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:38 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:09 -0700
Subject: [PATCH v8 06/13] target/riscv: Only set INH fields if priv mode is
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-6-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently, the INH fields are set in mhpmevent uncoditionally
without checking if a particular priv mode is supported or not.

Suggested-by: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b814d176cbb8..121996edab4b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -967,13 +967,24 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val = val;
-
-    env->mhpmevent_val[evt_index] = val;
+    uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
+        env->mhpmevent_val[evt_index] = val;
         mhpmevt_val = mhpmevt_val |
                       ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+    } else {
+        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
+        inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
+        inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENT_BIT_SINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVU)) ? MHPMEVENT_BIT_VUINH : 0;
+        inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                           riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
+        mhpmevt_val = val & inh_avail_mask;
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
     }
+
     riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
 
     return RISCV_EXCP_NONE;
@@ -993,11 +1004,21 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
-    uint64_t mhpmevth_val = val;
+    uint64_t mhpmevth_val;
     uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+                                                  MHPMEVENTH_BIT_MINH);
+
+    inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
+    inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVU)) ? MHPMEVENTH_BIT_VUINH : 0;
+    inh_avail_mask |= (riscv_has_ext(env, RVH) &&
+                       riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
+    mhpmevth_val = val & inh_avail_mask;
     mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-    env->mhpmeventh_val[evt_index] = val;
+    env->mhpmeventh_val[evt_index] = mhpmevth_val;
 
     riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
 

-- 
2.34.1


