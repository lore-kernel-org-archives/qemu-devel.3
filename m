Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGcD-0007kX-8p; Wed, 17 Jul 2024 22:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcB-0007ZS-12
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:27 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGc9-0003Vq-54
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-78512d44a17so167573a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268683; x=1721873483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdc/I8LtrpkDDrx0Z/pqIF5D/A/4rqxNRUUv4RHnxis=;
 b=U7ItC4oAWGcZBZ/ygqB2xjadPkBD6Y7q7NrVqikm9CahcIXuo7B5WNBsA4I+ue9XWn
 EQD8d7dWVhMTk2IpwlfI5TO2EIyzDZKriBv2clVt3HXu5WEt0wFLDEPNUXsb/Le8RErL
 1JgQQ0ZocnWm07eJi+jv7yhTqcn1d0gsGNqduvhOgAE3G4bcEyh0+sIzWUS2+8yFZreZ
 NBNx2HrthS38pVWWdsL9M0U8aEDEYwn4fT6E5k8hCDE6VWfC0DcFpDwtrig5gNBIzpCS
 E+3pIVkGY6C6rxHP7eMzYV1XuUZZySGNz2OxR99GPlBACXIpXZ3f1OADbMCJGePO3umh
 7Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268683; x=1721873483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdc/I8LtrpkDDrx0Z/pqIF5D/A/4rqxNRUUv4RHnxis=;
 b=NcWsvlPr0DWtp2Qs4SRDNHpBo8UcwlCmRPMebzn9Vmt7oOWfTvak0VnRsfJ/G1p06C
 Nk6UXbWTHheBE3YNW5Ihxv0F7xFNBNV0t3x6QIGtaD3zMsM4AdRVzh54OP/KAiu9CkKp
 cbdZIuQx6RfOUl0vAG5gsz9v99whQw6FsLTXBj+6kUmCZP4SqpXNgQ0w/6arH/ft1r/0
 kr+HKbCxD50jfgNfmI1z2KWzOGZEh2xSvL2aokd9VDBbEIm3jA4GTXMuKg6AZFvmoseN
 wysQguWM0lvZeWY2s6ZqWudgV192uNKh5S/B31/M/wH11jGEZuDJiRMsmE9KhI1w5QDO
 7gCQ==
X-Gm-Message-State: AOJu0YzkfvQYorlTMzcw1KG81DWPno0nMX6yAYiLxEirDs3wERvyomXQ
 Ifsz+2xjqQzupmjfpEbR4hJvNoweCv8N0DtNk75voZWxPEmB5/1k3o1j2ZR/
X-Google-Smtp-Source: AGHT+IFlXoQ0Juf0dVPpUAUmt0uINNoRpA9deWFgQDTWINueLhdq2hG1ZyRKLbTa6ht3F1eNxxnUng==
X-Received: by 2002:a05:6a20:9191:b0:1be:c43c:e1cc with SMTP id
 adf61e73a8af0-1c3fdcc000fmr5189033637.10.1721268683544; 
 Wed, 17 Jul 2024 19:11:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/30] target/riscv: Only set INH fields if priv mode is
 available
Date: Thu, 18 Jul 2024 12:10:02 +1000
Message-ID: <20240718021012.2057986-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Atish Patra <atishp@rivosinc.com>

Currently, the INH fields are set in mhpmevent uncoditionally
without checking if a particular priv mode is supported or not.

Suggested-by: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-6-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8831d4f5ec..364583dc03 100644
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
2.45.2


