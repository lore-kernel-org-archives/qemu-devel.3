Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1ACCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNI-0001Zf-Ha; Thu, 21 May 2026 20:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNB-0001Z8-Vt
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNA-0003Jh-5o
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so46067385ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408255; x=1780013055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CcHQOvtc7Umj1MITx3VnehHvaArbjRWX5RBL4Qa01Q=;
 b=Yw8pmnOeKYgyLw/pBRLy45vAOgR3/j7GZ7G16ATon/emRyQnTsJm/tOmbBFHFAhXRF
 fSvIW/z3cnWJin0n9BcUugNou/l9GlWH2IxGHyQ3+dLyCO/JwHomvIp6u1aFSYv2L0tR
 pyOoMK7UKwpOgsYIFlOtcaPhyWQdB4KEz38BJtyaEmBpQaiRCt8SCQibIZCVbhIuZt6J
 PViNgOwvr0mtj3qSqALtHksQaRUNjdG9siSaFnbQHMClPfbS30Y2WkAWeevhiTFb5At1
 fb35Vi3is425vPm0kyd49uEofYSAnQoElvWCzMHnlx2JzuBreXAGWBGh4Ll22EBuw7UI
 LrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408255; x=1780013055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/CcHQOvtc7Umj1MITx3VnehHvaArbjRWX5RBL4Qa01Q=;
 b=rWEcH/7wYks+btoDZdLLHRtU2E6z501917WLEMt9NUlXYrJRaNI02O1a5ClDyOsioW
 XpOUSHb1+EITG1QERPvfXGR4gXfJ8vqpLmB4vBwyA/rXJimrfXdcO34gIo4eK2E7OHzE
 tTPYKG8xt2EJFnbJgq8CmapoSh5cO07lLFkZoCovUlj+TlDS1CQTq4zielozfQsj+T03
 6S4xrJIjzpJP7ES7fCMo81jwr8WgTqZM+fFn1/nO6CNy03vDJiLQDHDg+OUilX3JcOdQ
 lFvFxDlE5VdOBCrkQOKDka4tr1TODT9DSMG50oGDHnA9XfuZ3aEofHexd/E6ssa49gmy
 AhPQ==
X-Gm-Message-State: AOJu0Yx3ZDQTZ9qgoBzMjWqbOViaRB7r20KNigUcTFt6JsoFL1Mos1E7
 sWnOsL/29uncMVrv9vZ4IasKWRrynwEa72JGS59Du4FNk+FwjkFNeTM49ib8TUHv
X-Gm-Gg: Acq92OHzSKXtXRkGtRmfOeSz7VrFnWwgoDs4CJH15iXsIseEo+yQxZyVxEY3Vv2Z1zk
 8tdy2qoBE3oEmRFojKbbs1+yi9mGhz+c5v6c2NW4lB8sKILohq7oBHb2JwK1g5Z/KcVqDj4pGSm
 YzAhDWlAebmYia1X0txXOUT6AS5YfkoHuUKlg1/0qJqbmJTjYiye3CrungL5vF2VnLekPmyIS+p
 ItBadiFypeqibZ+9qkcsz3DnMc9Tbr58HQXY4asaVLJCt6fP0BSgmdwEPiWOoCuYc8pLg/l0Bz5
 flClLq3WwFiWWSp3eyhwHtDNXJYUSKCm/7l2lkiykW2cCLm851N/7tU5OC1YT0TsfsxuaQY2hLJ
 5LLZnBAwmqbxEJvDDkxEb2/pNjOmJLviZdjLUi6DhAs3uNC/A6YfnZvzKR6H+wuH64Pb4uIzKok
 qUbdWvnqJ3silogtCqR75Bh7AVBFR1oHKtc33b37rakw==
X-Received: by 2002:a17:902:ce8f:b0:2bd:5ae4:26d1 with SMTP id
 d9443c01a7336-2bea229cbc2mr46152785ad.17.1779408254602; 
 Thu, 21 May 2026 17:04:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/48] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
Date: Fri, 22 May 2026 10:02:48 +1000
Message-ID: <20260522000324.23255-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Abhigyan Kumar <314abh@gmail.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260427060849.749179-2-314abh@gmail.com>
[ Changes by AF:
 - Remove comment
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e1cd4a299c..60ac307012 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1802,7 +1802,6 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_U_ECALL)) | \
                          (1ULL << (RISCV_EXCP_S_ECALL)) | \
                          (1ULL << (RISCV_EXCP_VS_ECALL)) | \
-                         (1ULL << (RISCV_EXCP_M_ECALL)) | \
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
-- 
2.53.0


