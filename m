Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FEDC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW4-0004e1-6a; Wed, 12 Mar 2025 23:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVz-0004bQ-5E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0007mC-So
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22185cddbffso29883575ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837536; x=1742442336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nxieto2+9TW/aE0FZvdhZYD7j3/lIlQUa7JFk2JIa6U=;
 b=ECQoBqdCdYwJUoiDZbVf97XDRNxxB+4I++QMjWWpMuh8Bh1Ldxo/zlQuqEH97Qa4YM
 8CMaXnlvcrAwMf3LfzFAvXwtEBdkhag3r8VFuC1rlQBuu3dmJPV1D5KVZ7AGOODnKboC
 Xp2K+w2Xnr6MS1kypU0Te8bjvXMhnvHpkaIyA43SHoYdG2bmmWpVoa5gbST/kRuVlgUJ
 kfWCJTDxg3vtHdCgDjYIXboRtVBkrjyOdHBEBQd5VQbw8xwLLv/+pvmKxbwA+uxQFxBW
 iQxrqsKAapQzyMAL1yxZnMQnbAx3pBavLUWQ4DkfefaRWeyyOUqWacBuTD+me4KETmuQ
 94Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837536; x=1742442336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nxieto2+9TW/aE0FZvdhZYD7j3/lIlQUa7JFk2JIa6U=;
 b=xSzXYRjHzId0xeFX0piRmoKElisI9Kcs/w9ziQUd9mialGb5cqQF1ybdSJap6vuVUk
 UIwXn3tn0pnQC53/VlRtfvj42r3CBS6vCZWtHr+sIDu2b4eRByTW37i1ecofu0en86AF
 coZw0scQfy1j3RjKxaILPO2r2tKqkULwv4HWH8Me8eNxlOsH5bU+ZCUWmsli3I7YmgFn
 ixY0wBeP8d99vQxJ4CYVg9FlFEIBCCYVkuIx3pBk9bU6PnZjlUl1+ad4MFCF47XpMiqa
 JuCV781fAcRU9R6MFGtktbNi/gCvBxAPnhOp5Olw3VEIzRZ4Nf+ZHJRDJuL4PkEgWj4s
 FSjw==
X-Gm-Message-State: AOJu0Yw3TBu3WYtA72ESXFC9YEMlA1eKzqrFMgB1Gh4ERoCGuJ7Vn/rI
 HYwMvZlJlLNYX9S7TmhuuYuYM7knwjqRGHTAHPpRWagsJ+H3qN5gXJufKBdLSGVG62Vzk1HJfOu
 7
X-Gm-Gg: ASbGncv4ImcOZIiMPul5b3FH5bBTQ+cPf1Tq2HyjB0NVkq4yGp1+B7YAwxzoch9QlEh
 eO6Zv51t5ucWekfvB2r/m+KDjmAlDwGGNt6bitcbCFEBSpNtNmUEAg11fjNDcnvU+maLSoW6SxM
 gmopp2934TlhVLtMoRtBqYpCpHycWQ71JqAf+0XzaayWGvr2w7X80EoDqKGfbK8zvQN1v074Mew
 4MvJMTFfE+q0Kflms9wo2HPIXzfekVGLL3d4nojCFrMMUTIMTgh8deg0sv3Af+MEIGNe94kbnBq
 57UWOCviPxWkYVYZd1SMiRb10aZEeMu0t/uoA6yprxIMM2zdfs9F+9VQjc9QcUdLb7kKblN1FcL
 3
X-Google-Smtp-Source: AGHT+IHeT+r5WfgUZYg963gqzrI/Qn7lMIuS044dSSzdyitgqs65vl4+Yr/Tk7R24H5fNIZKeymBWw==
X-Received: by 2002:a05:6a00:893:b0:725:4a1b:38ec with SMTP id
 d2e1a72fcca58-737106d1c9dmr1767299b3a.3.1741837535631; 
 Wed, 12 Mar 2025 20:45:35 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 12/37] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
Date: Wed, 12 Mar 2025 20:44:52 -0700
Message-ID: <20250313034524.3069690-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The mmap_lock is user-only, whereas watchpoint.c
is only compiled for system mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/watchpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 65b21884ce..cfb37a49e7 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -124,17 +124,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             }
             cpu->watchpoint_hit = wp;
 
-            mmap_lock();
             /* This call also restores vCPU state */
             tb_check_watchpoint(cpu, ra);
             if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                 cpu->exception_index = EXCP_DEBUG;
-                mmap_unlock();
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
                 cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
         } else {
-- 
2.43.0


