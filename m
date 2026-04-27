Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CA9FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLMt-0007fY-S3; Mon, 27 Apr 2026 08:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHEJq-0006NK-TB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 01:15:45 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHEJn-0003Zo-88
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 01:15:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso5556858b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777266934; x=1777871734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8YyWokDLuZFFmq5MmNvniHRIm4ZMOwR/uYJo4EgchQ=;
 b=sjEElzvBFARC/NN1AC4A66Thg1dp2lh6nTs1LjiY7UqaKhnEoEMEfuHXgbj2q5hAxS
 g+F1r5WnbeXrfR0dMH4TGUvoDNXHRAQdQEL36EpDWCJil8bspbv7ayUwab/r+ThRmy97
 /ijnKnjLQfxO8kZhX7XC2rpaz3qZc+AYRuxZcvTWLNIu4dEmYkBVzzL4bxDlcEvQ+ZSi
 BXhE3YmKN9XKf+DgmCq/maEsp6Afd+kyuA4bPUTsCrhPOMNYucwaKh3L5UnI5nmGM8Lt
 LJPgY1gQ3RCkMk3KXQSDg2WUzJYdJPxT7RaLoiuoNVrURiFD4lqFVXs/q/djxwrbm/Q8
 zbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777266934; x=1777871734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8YyWokDLuZFFmq5MmNvniHRIm4ZMOwR/uYJo4EgchQ=;
 b=aMEvaINYxdgtKZpEOf82rSWnCb2IxerOmJPexaqe9mJNsXV+23ViwM7NLnH/XV0sGn
 bO0U/BqUJk1tD6WLQ5aGhOttmaAMxPBYJEZQiJlr9jEmUs+aM7aWADf9LDF59pcN9IxD
 TG8OiYca4p92SX+8zxvco5zCdEkAmb4Qn0vi3g/VN0pGnb5J8OB5NAExGKYbBKPWteud
 VsVAtgYR/s6GKbdlLGPXt9IEKkDPk2L1u1+dzeneOjBrzWYUANaz8H98IYtndYcDtgbZ
 5A+KZABJO/zK5uqbk/lAeFSUqc2V6QXBGo78k4RzETqoAAnETDe843DQatxjdgl8l0+0
 S57A==
X-Gm-Message-State: AOJu0YwPbYT1eO617JdC7I+oGyr8wrBb6QbEOhqMlTJqeVvFnMOnLCsw
 0wwFwYFzDxEgddI3880xtqNMPCZ+nwTcAH7CU1lh5jC3zksiIV3hBzqOZGdKgans9N0=
X-Gm-Gg: AeBDieukTkHG/3lXrDYszEQnjCdb2zNeD2NOB+dN5QELYfaWB7168m/mqjeRWAQcxC7
 mNzNAw4N2Hk98LMBv2LZDV8xAIzkMJOBE6KVtsJcLP6FIYxqmM60oBwalcSetVU2O3uzlA1fMeV
 MwtvtTdoWGb/PSN62PnGiYuWI+PtD3iCl3ywa+5Ry4HSisZt84zq3l9w041UUIPdWjH+BNde4RW
 sE/Q5q6DpidVHfCWo0dys4zc4Ror7IZG2A/KOAmTL0UWChZg8vIQkONKHIUZYQOZfwDiwP/+lxu
 dyispjRSbDADPfLQ2tfiBr0GbigIJeZLb4ukxhrLviAxDNnCDKME6VCXj2Z2OiJjM4HjoHm5EX/
 5+irjx5az1N6KSqlJlUL6fs5em1RPHdWv4GmqyvU1AuMRR61HWuPxY3i6r04PAxNPBDTPVodhPR
 AtPZOCUWDRgzyl9rp8E2dK
X-Received: by 2002:a05:6a00:94e2:b0:82f:6cb3:645a with SMTP id
 d2e1a72fcca58-82f8b55537amr35448728b3a.31.1777266934338; 
 Sun, 26 Apr 2026 22:15:34 -0700 (PDT)
Received: from arch ([112.133.246.16]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9fbb85sm35349019b3a.22.2026.04.26.22.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 22:15:33 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH 1/1] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
Date: Mon, 27 Apr 2026 10:45:07 +0530
Message-ID: <20260427051507.727280-2-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427051507.727280-1-314abh@gmail.com>
References: <20260427051507.727280-1-314abh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:47:18 -0400
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

RISC-V Privileged Specification 3.1.8 (Machine Trap Delegation Registers
(medeleg and mideleg)) mentions:

"For exceptions that cannot occur in less privileged modes, the
corresponding medeleg bits should be read-only zero. In particular,
medeleg[11] is read-only zero."

QEMU incorrectly included RISCV_EXCP_M_ECALL in DELEGABLE_EXCPS. It
allowed the 11th bit to be written and read as set. Fixed by removing it
from the DELEGABLE_EXCPS mask, adhering to the specification.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/riscv/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a75281539..c9bf73dd7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1775,6 +1775,10 @@ static const uint64_t vs_delegable_ints =
     (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                                      HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
+/* 
+ * As per RSIC-V Privileged Spec Section 3.1.8, M-mode ecall should be a
+ * read-only zero. Therefore, medeleg[11] is set to zero below. 
+ */
 #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
                          (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
@@ -1786,7 +1790,6 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_U_ECALL)) | \
                          (1ULL << (RISCV_EXCP_S_ECALL)) | \
                          (1ULL << (RISCV_EXCP_VS_ECALL)) | \
-                         (1ULL << (RISCV_EXCP_M_ECALL)) | \
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
-- 
2.54.0


