Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BA3CDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgnq-00062C-Qa; Mon, 22 Jun 2026 11:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wbfrT-0006g7-9w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:42:55 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wbfrR-0002W7-Fi
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:42:55 -0400
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso28468295ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139372; x=1782744172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLCOumI8xlezF9WytHpWj4JZYwGJnn+HP3QxVV+wd00=;
 b=ctT/k9+UudHvexzS90AFThu6o2SyVFmbRol5Jc1rF4OzRuXVx6hYqBsn0VIHAbUzrM
 T9wHfwjavghkXDk3014Vgmkjf4HGo1xFkG3anvjk8Suxl365Fl3CSQKwYwc7Wk+nqHvI
 ky780jmmDAUQ464yHsjW9t5YMvOPvY5/3Vcn+iODMZ39MQawAchKmpuCty1990FScqwS
 MSpD1+xIWy1c+CpdnRwLlzNy3U005dYg75bb9hRSObtiGfFXg2LY453cOhKAQum2JqFU
 Bz9IAeP6uSEo+JuVKc8q50mb6vheZBdYSws5AlC6aQTrlpn4UM4LKjL7WvT3OzGtwgsz
 0obA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf0yCVlqMcqNhKkN7LDHHhF+4EzzkybVQyl7mA+zvcsmsKe/jgw8D3ZlspremF1kYu93XbrJglB5Br@nongnu.org
X-Gm-Message-State: AOJu0Yyg4h1Nsgi9v5J0cGYQ3r8JUsm+5uNrenIGeSVeABvHZp4f7QwD
 tdd5UJ9YZutmB5A8gCP/x/mjxCJcTjEi/jYO5DwGxqc0BKD4qZMd+jjQ
X-Gm-Gg: AfdE7cntniRe2b1DcwRaAXSSA9SIKbYNGwexScAkTw3ACXn0GH+bQHfmamBRXhJFDOc
 k16zI2ekfoixuIw3zCV0ztXb6BSpyJUgiUgg9vuwbsZgYb6WPToUrXG7NeuaO79BZm3wxQvWDQ3
 kLaaN/O+khHyJTEVQGgO0Zzqrel/rcB7jn7hOqelvyQFLn36/Lvb69XnBttoTgJFRVMWlZyyTfl
 BdImSZrjQMpbatS4mrpJzQE9lcq2NdI1DvqB5TZw0MdBCldKWqVdPk0eW/k+0Q9BD3ulumEjwvf
 LK8YH+/qZc2VSxEucsvVzu5rAUfJpEHoIiPL/0H93nWQM04tLFFC/KbGvrfHeEEileh02SSTB+c
 bjnF3Voh8HyK7D/iDDnBeGoBaW5M9mJa4EGuycG3weFo6TtikpaftuEGwRgsTUpHDTF0fU6Zyj1
 mg4ZStVR0AArmECoz9eYFQ4DlVEh9Nkot04EObE3dKpq75QQ==
X-Received: by 2002:a17:903:ac7:b0:2c7:9b17:668d with SMTP id
 d9443c01a7336-2c79b176c3cmr39962755ad.2.1782139372004; 
 Mon, 22 Jun 2026 07:42:52 -0700 (PDT)
Received: from localhost.localdomain ([1.213.237.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f8cfbsm78955285ad.45.2026.06.22.07.42.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jun 2026 07:42:51 -0700 (PDT)
From: Leesoo Ahn <lsahn@ooseel.net>
To: agraf@csgraf.de,
	peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Leesoo Ahn <lsahn@ooseel.net>
Subject: [PATCH] arm/hvf: panic the guest if an unhandled exception occurs in
 el1
Date: Mon, 22 Jun 2026 23:42:45 +0900
Message-ID: <20260622144245.55013-1-lsahn@ooseel.net>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.171;
 envelope-from=yisooan.dev@gmail.com; helo=mail-pl1-f171.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jun 2026 11:43:04 -0400
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

It's better to clean up any resources that the guest taking and quit
if an exception in el1 could not be resolved.

Otherwise, the guest would get in the infinite-loop black-hole by
unmodified pc.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c6882..4358cf90e8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         cpu_synchronize_state(cpu);
         trace_hvf_exit(syndrome, ec, env->pc);
         error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
+        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
     }
 
     /* flush any changed cpu state back to HVF */
-- 
2.50.1 (Apple Git-155)


