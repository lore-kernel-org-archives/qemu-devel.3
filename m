Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729E606A335
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDszORGX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQxb4-00008z-CG; Tue, 10 Nov 2026 20:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xQxb1-00008N-Eo
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 20:57:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xQxaz-00011T-Tl
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 20:57:55 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2ed06b725fdso20148195ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 17:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794362272; x=1794967072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SsEUsH3Oxr3a8wty2rEP6OkK+JraO9ajomLeJyfG9x0=;
 b=aDszORGXZ9iP1gFwd4er0bgelvEEM+43ZUEdGKxTS2sCvyEqoOpPV43Z+SBScs23op
 PYHI3vOBy9UTj4Mj5kbmZOx3ben2YVIgruN1mTr3uLU93futiHzbjZv6tB7lqDxYQ2oP
 t/iZIARqYo1RdK+KgSW5w38P3VCaGkaOLZ+jq66ko4yjTyvE6q3PqmvJbT2Mr3hWg72c
 GNlYMf/fDq8xg0SmbH2cE5L/DbzXTsdEU/rXLu8fR0e5VGtYSlB7cByw8IvuTyOf1JPY
 zOZMIkjSgnNxa5vWffU9cGEUE8ZXBhPQbVl3toDDB8CSBYGtBrEIKBTJ01Ax374UkjE8
 myWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794362272; x=1794967072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SsEUsH3Oxr3a8wty2rEP6OkK+JraO9ajomLeJyfG9x0=;
 b=0Ethn41xopwyFZelzXLYasm84jZcvsluywrp8lWmuvlg0qieGJXQg+G2srGaf1/CAA
 yAeAfWrdPDARpZUbz5x+CYoCgrUVSh9vh5JblYM4ZCj9/t7bsTxSs658Za7RE7i0c0Jd
 MgQkjOmjq8Q964Ubt5RI+FNPeXFzstW0Je/IAmIFJXEX7HZTeYqGBzUYtQhxYjZ9/Mmx
 4ZlO8DAvaQ91UPbJOpOcs/gEB0tpvroarAaQSpzjjl0KFZ8MbS/ZBYAMnQGr2wDPBT3M
 +XWBf20ay4WK7/u0YbZQOKR409XsSPq4SdU0gDM8xdP+HoqviKOSFbN7gwVNAfvjSsKi
 rcjg==
X-Gm-Message-State: APuU4Z9P34auKxeamSJM5kds3AirV80VIcIkcClcabKac7QK5io9BAJ+
 wtH8LKGTGZidNxZkbxmTw8is/TI5rGi4OeowzBlI6W7sjuoEcIVjHECgOm0zufKFmlPvRw==
X-Gm-Gg: AYBFou0F96Z1DAOkowz6LGE5wuZdAbnR6o5fUiL0UuoiqXBxtmP7EJ4tss3eIhQ7CCM
 gD5YnHti0wqoRYx1wffdqwz91Bn+XVL83K8f0SSebir0d7SYtCVhNdcnVl0iSAUCRcRw03a0tCs
 WYPuwXJKFD4gnh0Qe9Cz/hijuiyBIV64F517A7WyjePYqdC/MQY7h9NLVeMzae6eEfrB/tPwWa+
 GZy0WXBJ6m25XwZQypKCv+aoFYaAc1RxVkYPIo+crPv5tUuWgf4apFJ/pjm8T549agvmC3xF9Tp
 GAc9LkbSI+IqewZON+FiTdpt5oDWt2YCaSgLXjVPrKSiyUiX/8LOsY0XDi7EYhMQaXn01c61jju
 liHU0sdibToqcJpVjaGLEo2kbrUKCZTlsFnFWTHgGL2zZmlDtOSbZdMpJwjUEZi/2sMMHun069N
 Wssm1M3jyBjWB3FVrahV4XaZ3T51ueAhvB5Co3RPrprK+IvcAUNEbRlQbNtwUmcMnDY34pQgCRQ
 kBMzcOS5uAnX4qawKw/sywQJ73yXHrnu9x85ARlCZIYnSLStzow/56vhQlHvZY1B5785Yji4UVO
 x870mtI26Iq/KHQhGroOPWXexCgm2KsIA3SHZRkAXYo/UQR8df1Q2tw=
X-Received: by 2002:a17:90b:4f4a:b0:3b0:92b2:2e71 with SMTP id
 98e67ed59e1d1-3b167ab4854mr3430933a91.9.1794362271435; 
 Tue, 10 Nov 2026 17:57:51 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([138.2.118.134])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d5eb471sm1258897a12.2.2026.11.10.17.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:57:50 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv/kvm: Limit SBI DBCN transfers to 4 KiB
Date: Wed, 11 Nov 2026 09:57:24 +0800
Message-ID: <20261111015724.47594-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DBCN console read and write use a guest-provided byte count directly as
the size of a g_malloc0() allocation. An oversized request can therefore
make QEMU allocate excessive host memory or terminate on allocation
failure.

Cap each bulk transfer at 4 KiB before allocating the buffer or calling
the character backend. DBCN permits partial transfers, so the existing
return path reports the actual progress and the caller can retry the
remainder. Zero-length requests and WRITE_BYTE are unchanged.

Choose 4 KiB as a bounded transfer size consistent with QEMU's memory
allocation guidelines for small allocations. Linux's DBCN read and
write helpers already limit each SBI request to the remainder of the
current page. For guests using 4 KiB base pages, this cap accommodates
the largest request issued by these helpers without additional
size-based truncation, while keeping the backend length within its
int range.

The 4 KiB cap is a QEMU implementation limit, not an SBI-defined
request-size restriction or a dependency on the host or guest page size.

Fixes: a6b53378f537 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4431
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/kvm/kvm-cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5beb602338..a301b584da 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1699,7 +1699,11 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
     switch (run->riscv_sbi.function_id) {
     case SBI_EXT_DBCN_CONSOLE_READ:
     case SBI_EXT_DBCN_CONSOLE_WRITE:
-        num_bytes = run->riscv_sbi.args[0];
+        /*
+         * DBCN allows partial transfers. Limit each call to 4 KiB so the
+         * guest cannot request an unbounded host allocation.
+         */
+        num_bytes = MIN(run->riscv_sbi.args[0], 4096);
 
         if (num_bytes == 0) {
             run->riscv_sbi.ret[0] = SBI_SUCCESS;
-- 
2.43.0


