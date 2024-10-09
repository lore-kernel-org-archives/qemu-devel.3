Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D6CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfnx-0006qd-BM; Wed, 09 Oct 2024 19:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnt-0006ow-3t
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:13 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnr-0000jJ-Fz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:12 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2a96b23e4so275403a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515350; x=1729120150;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lb97YCo8PMaDnRqrQoCvwMDNjIlFQjHaZLCUrwXXHsI=;
 b=kyCWk/m6s937XhFJrBNIhoKMS58aVFTzCK1ihvqeVYyFBDpWsrFsWLNzyKxNJBIMWX
 ix0BeKaYO0lVcRxQ765hRGHp2oqwQzPPmcVIvN/u70vPQMlZ6/AGnkP/HyR455dtZcJ/
 mqAcc22EuKEE1RcBmljtBWxncg/eAa/GV6VJxqtHCwNCBuDDOdMbCPLwaWYMWjoUcymN
 NPcTKTBoBFTIeUmmKKS3i5g3VchmLr3wiYncV6oyqMRKQ5Hs9PeGfXAvHKhjC1PwS41I
 yeZyMILZz4RvQdjnltZVhxhDfP4aIlfFtWlqC+sB00R5nBPmPMe+D3yXjdbWZz6qr/Ay
 BgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515350; x=1729120150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lb97YCo8PMaDnRqrQoCvwMDNjIlFQjHaZLCUrwXXHsI=;
 b=q2QSnqz8PfdkOdjuLyaoyvcSpzytkXqCNZvgbFPv3AdYTtqMj77oOE6dTibolZ87Wn
 tQs3PfRg7uucnL9MMAfKRsi28prnmTI5yDzNMO3EdZiyzyZTE3jLaWP3TBERkeBq7rRi
 OYgatFJeygU1Hu4kjQewgcA7b91Rq8TSUzo/9TSgiSbJCWS6oGXgEc2FsItCdYEn25l4
 YWJKk8jyisEmQjj9sLDPkl1RpAmwTylofVESuEaZwd+6Lraoe6biKMIwX4QbA89ee4pI
 KMFvfuHVTy3+UrwNvVI5XrentnPYg7BG6kJ3m6+UZvFLH0dTVqkQfBhp20Svz2TSDE7X
 oV6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFu6zP+syIdwRX2Q5sLe/a8/RW0/6DSA1hmVQE6c2IcM2qV09kYY1dQoxLamMAVzwL+VQPiFKv5aQl@nongnu.org
X-Gm-Message-State: AOJu0YxGy52z/hUltePyjvCGTu13mbMsC5YLZqZvhUc+sXZwz1T98C/9
 O46XNR9fJilqpUX+wj2HLFlTj86qBM/74HkRzVbhm14JaYLLwK0HSQGiaK4vNCLYVaQIcjwBkDN
 3
X-Google-Smtp-Source: AGHT+IGd4am5nLssTGqIfRsluvKElFYqfp/ur/w677nYIlxXGniWKNoVZJv114HF1B3IFUvgQMBZ/Q==
X-Received: by 2002:a17:90a:de83:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e2d3e21303mr70177a91.12.1728515350047; 
 Wed, 09 Oct 2024 16:09:10 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:09 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:04 -0700
Subject: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2ac391a7cf74..53426710f73e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
         uint64_t counter_virt_prev[2];
 } PMUFixedCtrState;
 
+typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
+typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
+typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType access_type);
+
+typedef struct PMUEventInfo {
+    /* Event ID (BIT [0:55] valid) */
+    uint64_t event_id;
+    /* Supported hpmcounters for this event */
+    uint32_t counter_mask;
+    /* Bitmask of valid event bits */
+    uint64_t event_mask;
+} PMUEventInfo;
+
+typedef struct PMUEventFunc {
+    /* Get the ID of the event that can monitor cycles */
+    PMU_EVENT_CYCLE_FUNC get_cycle_id;
+    /* Get the ID of the event that can monitor cycles */
+    PMU_EVENT_INSTRET_FUNC get_intstret_id;
+    /* Get the ID of the event that can monitor TLB events*/
+    PMU_EVENT_TLB_FUNC get_tlb_access_id;
+} PMUEventFunc;
+
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -386,6 +408,9 @@ struct CPUArchState {
     target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
 
     PMUFixedCtrState pmu_fixed_ctrs[2];
+    PMUEventInfo *pmu_events;
+    PMUEventFunc pmu_efuncs;
+    int num_pmu_events;
 
     target_ulong sscratch;
     target_ulong mscratch;

-- 
2.34.1


