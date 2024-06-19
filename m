Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397DBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 19:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1Bj-0000qF-BQ; Wed, 19 Jun 2024 15:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dDRzZgYKCuMKIZWXTLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--fdurso.bounces.google.com>)
 id 1sK1Bh-0000q5-GO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 15:41:45 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dDRzZgYKCuMKIZWXTLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--fdurso.bounces.google.com>)
 id 1sK1Bf-0004qX-Vt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 15:41:45 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-42183fdb37cso1187475e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718826101; x=1719430901; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=45aR8XKSAshFgZd0VPIUYMSxh9sFB0D+IHfcIJxI7tU=;
 b=rLiXlL4qLnRXLh6kwje6dc+t6nblxCX9hJHjSarlWDifsiekzQnl7WnS2eYREzNsTR
 03xstF6bU5RlbbrboB0QOLqhEryl1I4Yhc7p00VOjrCosV9gbiYbSCjTN9D7CfrEq/8S
 yWJSdadhiqT45IDyyrrZYy8iZ4YSjxXnN4OAzCmnee+UDyDPRVT68siR2VkquV5qyV2r
 PDiDmSsNvZAQzFQ0OSm7Jg/SGInqqZJnvM2rxmdLw3PfQGNwjpAcKoWsAcaa0rCQ6RQc
 iFwgfu6Zo4vMvXM3Ze78iQrfZK+Z+aAVKRAjni0o07Yp31a5oBIcWNJuchEWpYitM9iy
 bjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718826101; x=1719430901;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45aR8XKSAshFgZd0VPIUYMSxh9sFB0D+IHfcIJxI7tU=;
 b=HQxgkkK97GBkAOpyV6wkG07MFTNenSN11joB0uCMVLh1/qtcjYHM/6akf54+WWW0xC
 G56vglNhYiPwRuATzZqD2KKoqs3iI8TfGhwswY57xI2QkIsa1q+58SI11PcFFTV4yMML
 OJ4PYg0lTLRkpklcOwo73Tt0C7g+r8Lw625KtkDL2Lyrjz932N0QwkLhHO0OtV9AvgPO
 dErTuN14uUmJbB4kohQAyKbLouS2DAVMFrVOm7MZJt6EFqkp30ewX2nf65GCnf/EotVj
 nQq8h2hv1gOFsqR+7aPJSgin1JgMIHs1H9SBMSpZgP1escxujcgbH7ic1wFEScR/MWPH
 1Lbg==
X-Gm-Message-State: AOJu0YzuWUf73+EmRA2Ofnx332vp2gOChXjla9aE3QBalUrA9UhBh/zo
 cWoBFWW6+kkMqTdhjBW4J+fFStBl24j0rElEgW4rH8b/6vFmQ27grK3ijUMmqok1QGog8rHTCOK
 6d4WBKDYv9gw5bQC/szNHXPCZWeA3kaduUQPuEjkrskc9vQ4iDUfad25GUmcIb3A9ma2Qj1rw/B
 jJJCm1oDfbgmOxNLjs1mx118Mr2iGBbs8=
X-Google-Smtp-Source: AGHT+IGR5SefKD/4obORiw3HTAuPxsTkcPMe4Ly6xFGl6ski9HXsqQpqe17uivjKiuZYgx1lbUIfQqJN2Q0=
X-Received: from fdurso-c.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:24fd])
 (user=fdurso job=sendgmr) by 2002:a05:600c:3b0a:b0:421:8143:6217 with SMTP id
 5b1f17b1804b1-42475078052mr962905e9.1.1718826100809; Wed, 19 Jun 2024
 12:41:40 -0700 (PDT)
Date: Wed, 19 Jun 2024 21:41:09 +0200
Mime-Version: 1.0
Message-ID: <20240619194109.248066-1-fdurso@google.com>
Subject: [PATCH] linux-user: open_self_stat: Implement num_threads
From: "Fabio D'Urso" <fdurso@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Fabio D'Urso" <fdurso@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3dDRzZgYKCuMKIZWXTLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--fdurso.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The num_threads field reports the total number of threads in the
process. In QEMU, this is equal to the number of CPU instances.

Signed-off-by: Fabio D'Urso <fdurso@google.com>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9b5a387b3..a47b2eeb65 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8171,6 +8171,16 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
         } else if (i == 3) {
             /* ppid */
             g_string_printf(buf, FMT_pid " ", getppid());
+        } else if (i == 19) {
+            /* num_threads */
+            int cpus = 0;
+            WITH_RCU_READ_LOCK_GUARD() {
+                CPUState *cpu_iter;
+                CPU_FOREACH(cpu_iter) {
+                    cpus++;
+                }
+            }
+            g_string_printf(buf, "%d ", cpus);
         } else if (i == 21) {
             /* starttime */
             g_string_printf(buf, "%" PRIu64 " ", ts->start_boottime);
-- 
2.45.2.627.g7a2c4fd464-goog


