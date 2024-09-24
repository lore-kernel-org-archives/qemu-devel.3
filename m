Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67DCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrd-0004HB-Dr; Tue, 24 Sep 2024 18:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrb-0004Bk-1y
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:31 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrZ-0001dY-Jf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so3904319a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216308; x=1727821108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xa9h2PzZFv3YrIHuXdWRrispjI/kDmtuk2RaDtDfx7g=;
 b=Mip1fkpWoW2bi9aQd7qt7MnxiLFRHPxjejnA60ngK5kJ4XELL02vks7jTN0UlMhQ9d
 rsOBjJBXfxSi3qpujMs/7V2inASKzvvWsilziynh3aerTVLE95C0XQDmkn8qp4tO6uJ+
 yLERBmxXKhpL2JXohaPOH+i4wtFgODxSx9JNWI7r0wPDhkli0uUbJscBOc8yxzY+P0rP
 MHlBV/xSl77HNXjOl/WZzACfIeJREVRPANc2yJlHtrmZFnlMVRGKOtogsvOrsUwypR9H
 hvirQ3uOKYUAYPLzyep4e7baa9XzD3btbyNJaROh4SGlMvZeoriS8RFqiVW0sf4JYECK
 oSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216308; x=1727821108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xa9h2PzZFv3YrIHuXdWRrispjI/kDmtuk2RaDtDfx7g=;
 b=FxPH/mnJFpJE2F7x+ze/oyP2YKk20yi5gikrF11MhCxouNyaibIFLUk5vUe8dZZYDE
 Bwbs5LTdIn/xBjITXa0WgM020nXuKYIkZbP2ABnceBUbhY/cge6z+19QqBLrBODcS8ox
 XU5qaUTVaDBOeC3n34Yse5D0Zr+/7U2zTt9ihhmLeyDl0fE/qNWUWhXn8ekmoNN4erHX
 LR88JdK1cxaUnzfVCVRFY+8prQsBRP6XfYO3EXkuGoHUWa2X3E9M40lJGLqgeBHnzREz
 rcvdKFDjFCluAjEilPzpxTNkp/EBdFphcbf1iNTNQJ7U/pdWueQCW8xPCpps1ojGbpsI
 PTWA==
X-Gm-Message-State: AOJu0YzXM5vw7w/XS2B2PZdiXCZZYsmXdJVzUjYU5PZHhpO/ZPFsLgzm
 IRLqOal5RQSM2u5gbqCcqMwPniGG6y44tMZpJuv+siLDmU6EJwXyo6pr8w==
X-Google-Smtp-Source: AGHT+IGHA0RQgFyVImdeoY3zN2r5UCWVMKWP3Wd0qAMweLTFwitrgHvJjLCgRQuI04b2TeNKuwWtmQ==
X-Received: by 2002:a05:6a20:9d8e:b0:1d0:2531:b2b9 with SMTP id
 adf61e73a8af0-1d4e0bbec01mr684509637.36.1727216307914; 
 Tue, 24 Sep 2024 15:18:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 09/47] target/riscv: Stop timer with infinite timecmp
Date: Wed, 25 Sep 2024 08:17:10 +1000
Message-ID: <20240924221751.2688389-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Andrew Jones <ajones@ventanamicro.com>

While the spec doesn't state it, setting timecmp to UINT64_MAX is
another way to stop a timer, as it's considered setting the next
timer event to occur at infinity. And, even if the time CSR does
eventually reach UINT64_MAX, the very next tick will bring it back to
zero, once again less than timecmp. For this reason
riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
previously set timecmp has not yet expired, then setting timecmp to
UINT64_MAX to disable / stop it would not work, as the special case
left the previous QEMU timer active, which would then still deliver
an interrupt at that previous timecmp time. Ensure the stopped timer
will not still deliver an interrupt by also deleting the QEMU timer
in the UINT64_MAX special case.

Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when timecmp == UINT64_MAX")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240829084002.1805006-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 8d245bed3a..bc0d9a0c4c 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
      * equals UINT64_MAX.
      */
     if (timecmp == UINT64_MAX) {
+        timer_del(timer);
         return;
     }
 
-- 
2.46.1


