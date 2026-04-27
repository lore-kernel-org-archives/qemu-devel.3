Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53050FF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHF9a-00052W-4b; Mon, 27 Apr 2026 02:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHF9Y-000528-Mh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:08 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wHF9U-0000hu-Ko
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c79467f124dso3532217a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777270143; x=1777874943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8YyWokDLuZFFmq5MmNvniHRIm4ZMOwR/uYJo4EgchQ=;
 b=Qw0PQvuJ6o7zgSOXX/pfdLdBY8oIo6r3vUZ3agKk3iWNQAEIdmdudWMxmPt46BvByM
 rQxlLPM5ZWSCraSqrElbO02GnVxjUdUGeF3LM5KjBkUl7IRkbe31kGDijiCxV9NpX//D
 cW4vF6oxLxfyJezgk8ezi7aBakSIGLv1ZF9+A2UiXHppjxlduWI1AIfvUgFsQd6Kq5f4
 6q88LwMx/nhnOmpNmNEhpACJt7lgVT1yBx3DQvbWqKbPmwDnMPwFN/oPDdRiMdiMVw1r
 xjgqb2hJlqdjZKk9NzsyVZVYmGpEg9kWbcLg2z/t3DBCudD/ohMdN+P2jSsHDdlRdyrn
 zrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270143; x=1777874943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8YyWokDLuZFFmq5MmNvniHRIm4ZMOwR/uYJo4EgchQ=;
 b=a3GcprjER27NiYjy9HqB1Uxo3rhmO3tKW5OAj1ButSVJ+d8uxauslBcihVTk+KqyRC
 qKa1huysBtd5ESmTUYZbwZbi8vQq2u248ppmB4iK/IBIqXEZaI1kmb4h14Miz25ZZ+R0
 Ke1vStTpoQFIlA8S2L6v/brAggtfqIWVRHZ4TMBiSm+dIU5hJdIGjMJwdJJM16BxpuJw
 3TQY8201uVxHymzozpTAH8cHw8Gua1noyOayzIX5Hf+uKC77isFvkMe1bA817uh4dI/0
 9+viJPqARn4K2dP04oBhz+rNBYP3hYIPIWDdarVQIv6q96dTovlnskL6iO7scjvUn7PV
 uihQ==
X-Gm-Message-State: AOJu0YxQOT72m/ry0XWhlAPLX1cmXDLVTMJkEgvGyCoQb0+PlQ7G3Cpj
 ATz5ZGx34lgSiwROM/+mx45rJpTe/lwtG7YWfIz4nzEzZHZqGpYDQ4T07jwLHDKbChY=
X-Gm-Gg: AeBDieu6GvzxLr6FAUfhGqwh0h27srWpwzmEb0GmgluJWlqzMy8/T0dKxyPCNnskhhG
 nSqRmO+rq+pcP9rXy0nK0Br3SGPh+9sLYWvb6gILghAb1iyWELpooiHs99lT99EMAVi3p25Dyig
 osJQ83OcteMWvswV0CaOmqNs0RRWUS3uNrP/1BtAsK6Cn754y1rWJtiTbYYjyn0GuPdeKNH38Ur
 JwUXgfFbHlocZESrs43ZSkcbHXJEvZomayOxcjopX0ymnCLkrqwAFflbJsY6XEVs/XO6/ZeNvhJ
 p2Ak9thajrxj5bqfmr1TKYgEYqU5doiMStzWncXakWgFx+xGJ+qPgjTULsdm/RePHnhieOSBvwo
 7Ga714t/qRp0fQoTJR/E8ehMujeaWhN8sf723mTnGYght5RVcO3s8PB4VmtP35PG+YYvRmkydid
 qJZcSluZ2a6HhETlUcx50=
X-Received: by 2002:a05:6a20:3d09:b0:3a2:d68d:9e78 with SMTP id
 adf61e73a8af0-3a2d68dd17bmr33436956637.4.1777270143305; 
 Sun, 26 Apr 2026 23:09:03 -0700 (PDT)
Received: from arch ([112.133.246.7]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe41cfsm33847033b3a.43.2026.04.26.23.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:02 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH 1/1] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
Date: Mon, 27 Apr 2026 11:38:49 +0530
Message-ID: <20260427060849.749179-2-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427060849.749179-1-314abh@gmail.com>
References: <20260427060849.749179-1-314abh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=314abh@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


