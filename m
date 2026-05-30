Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023FBCD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 05:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTCJ9-0003H1-LD; Sat, 30 May 2026 01:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wTCJ0-0003GA-W8
 for qemu-devel@nongnu.org; Sat, 30 May 2026 01:32:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wTCIy-0007G1-8b
 for qemu-devel@nongnu.org; Sat, 30 May 2026 01:32:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bf30d530bdso8830215ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780119134; x=1780723934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BLEpb1qVJQlLoIKuGkWEWOKI1hjsxY8cabZ5Za7MGU=;
 b=Tn9zYzl5Q+J9NWEJHosEL9QGdyLgNa/bl5cBjdYRnp+e0ltDz9grwT59390Y04v6+T
 cDRfwpSUFVVfzFYncNWXVTrfzAmv7AF4GaiN0q0adNC7JOWv9watSSMKvBssL8yJGo7f
 wmJSVhJKyrDwVgfYdMTneR/qY3w6hwH7/gL93WgvirPRXxxipwJZv45m9Oc417kKStHc
 ihu8xhwe0vDTktBdnDua+lHcysG5f4TFxWqnRbla+3kbOCxr9jWSDyNUbUrl5UzkHWQN
 d3DcB/RDhUkGu40ThrDuw43hW6nyI5/bpqFUN9nqroNBy5LP1wkUDSAPFtsuna0bG8to
 cdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780119134; x=1780723934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BLEpb1qVJQlLoIKuGkWEWOKI1hjsxY8cabZ5Za7MGU=;
 b=XHprSDs/DUN49nSYM/c6Gw8lAG5dmQmFP5d5XfsFy/yjvgT3XljXJFpfGEcZlZS0P6
 hSJzM9mpcoPMb2k1JCjRLYdzVTC0E4duyYCQE6ETub6/zOLUX5rIQf/KNiQTiwBhkJCq
 aInYr/9Ddupcrh24nYaLlal9hRcQ9PgXeLTVNl/ktDrU5G6vVC2bVZr+EAxh4Y6h0R61
 +8WyEnRFj3j2/xeciDPLcflxqVmUw9H1RHIEACmhS7CTgrg/1AxX9DIlmhJX2DA7Z8nY
 D8iNrDDvUQBvOVEmTUBvfjnboed8hFWmmZ8/kOCNFVQwXbQ0hegsw1uQgNlgI759DpPq
 qkRQ==
X-Gm-Message-State: AOJu0Yx9xmaFebKYE4OdWhJ7K0/b14bJZ3TL+8ORWURRPpQQLnZBuRLy
 regkeOWIsZi3kA3iRLJ0lM+/qYQ4aaWSDZLymmwNRMHDY7joJKKaFU4EAVfbBQ==
X-Gm-Gg: Acq92OEMQBmmxHOX3fysxGFVZ0tIczt9ZnD8+gcKn/8qHd/KRRwvphpRzwMdqw+2uw4
 1eb4RZMnOazTvuWZYYQhJD2uDOX0DoX0HZTCrVPZ+xh9z2t/jU+ppxou/fPK5DWWUa+mq7KeI+B
 ntPZxi3OSqbcD6nYen2CbbFNtyzcxfUk+yCu/FpCOnhHf/26yFzqiEluKZPyHWDwGgkjoorT9/e
 ZntKCQH1VffP9q45pvZUg14GMEzTRuqvqB+Ue69M1C1DlzMsshvQLhXqdRvahI0Z/Rr6V5Wpj6O
 l9502DMhN6+PEC6SBVmdkr6/XMqCU3PCk01AJE7hygYnSuPQ+S5gyYv5GrbrpISoabhqaaZfawu
 55d7BLdf45zb/Mi7U/vxPJ8HQOpZ19OeBKcmZL7O1PgMyV2aTs8BkKE2+ksqkJBmkqmMtsNZSi0
 NHJ9LYnI/O4jUnoRMrk7gVOZp7etZX8A==
X-Received: by 2002:a17:903:1a87:b0:2bc:90b6:3e6f with SMTP id
 d9443c01a7336-2bf36779dabmr32233225ad.4.1780119134536; 
 Fri, 29 May 2026 22:32:14 -0700 (PDT)
Received: from arch ([112.133.246.2]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e5d78sm37216385ad.12.2026.05.29.22.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 22:32:12 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/riscv: fix invalid sstc predicate in gdbstub
Date: Sat, 30 May 2026 11:02:00 +0530
Message-ID: <20260530053200.902591-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=314abh@gmail.com; helo=mail-pl1-x633.google.com
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

sstc function incorrectly checks for avaibility of env->rdtime_fn.
This causes it to fail each time it's called because rdtime_fn is setup
later in the procedure (when timer devices are created). This prevents
stimecmp's addition to gdb.

This change ensures only the riscv_cpu_cfg(env) check is done. rdtime_fn
will always be NULL otherwise and fail.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f5b0895fd..d72df945f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -590,7 +590,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
 {
     bool hmode_check = false;
 
-    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
+    if (!riscv_cpu_cfg(env)->ext_sstc) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-- 
2.54.0


