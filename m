Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619DEC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 19:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sICcN-0008Q7-Gc; Fri, 14 Jun 2024 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JppsZgQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com>)
 id 1sICcL-0008Nf-Ux
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 15:29:45 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JppsZgQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com>)
 id 1sICcK-0001es-9j
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 15:29:45 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6313189f622so39197357b3.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718393382; x=1718998182; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TtK1C8YlLW0pbgXYspCN1hMQKNtzaDRkikncqCvQKRM=;
 b=TMPuvFQD+b+ZX5uTEcZOonVVSoHP97nr5jhwyegPzs3QdnvWogEWamYhg7sOgTu7n1
 lQG8MrlqjC3Qls3m1U5C1SsDiEMmowX0oiPL6eDUCEXjsx3jT4D9YbZYrfX1uWU32R6o
 liYjimA87vNnRlVb2fjxYwug+iRKmWnKISnL7GkcdRsMfMJJDD9AX9KZR5+ssUzE+VU+
 vAIpvtJNiEgOxNWxhb3MMU2BTGmz/3l52dgal8ImQrZWudsIBVspiW0uNPzv/cWVCVk2
 tE+A+KOBkHY7kpHRwuPeTTIHu06hwAtEFAu4kCPpAU0zulq2dCykJTBwBwMu8T3YjHeX
 fdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718393382; x=1718998182;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TtK1C8YlLW0pbgXYspCN1hMQKNtzaDRkikncqCvQKRM=;
 b=nESSE0ZK8BsQVIC12ssl2oyxD+I53+9jl/qWED5AaUtQTmyt+UJSfy+4K7oVnhvidW
 exVHXJjqXyo11POKcAYFH7gQr5UOe59UHFy/O99Ow1JfNaIgU0J3D7ZdGabbsMY1n3nN
 +N1AoGPG509g2uZ6kDNHnZP24zdTq7810hQcb2dyX0nT3gSsJqTzWGKOeAAmxDgkcHS6
 AjsW2IRK9Ke5+D/dLOq84+6c9Mk2FtSwkp+c5sl5k4OjB/NLj6K7gmrbZrn5ZnPZjJv1
 TINjEsNrirgq7IuEKpB4ncFvL1RMHO5I/zQw0s2MiGW9JfwDlyqR1srXqiHICqqPdd5m
 NgpQ==
X-Gm-Message-State: AOJu0YxwVTUOoe1VZVvSXoVQeWhD2gGo3a69HXHQKVF4rA45vVtMMUCZ
 1oUtinQ7fbdtCP1dw8KPkwKrEll+tDA2VCdLSKag8vZ35JTmzf034x6jynL6EysqMqNwp3dwzOl
 FvA/lkk6wCuxDpdBAYzGZrOKA5nF93pRIup6Gkob1pMRWo8HrNnfZ5Z4wzTMOsGFPwQuqpQXHCh
 MYYdZT3y8G3lPz1B7wEXco
X-Google-Smtp-Source: AGHT+IEYEKVE92+46WTtQRpWE85vzRAcQ46cbipvhhgbRZ/Ra0wlObPUMlvx0uZGnIDMNASPXt6mMNv9
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:cd17:b746:5266:1aa9])
 (user=rkir job=sendgmr) by 2002:a05:6902:2b0a:b0:dff:83e:b259 with SMTP id
 3f1490d57ef6-dff1538b16bmr1009711276.6.1718393382011; Fri, 14 Jun 2024
 12:29:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:29:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614192938.1690188-1-rkir@google.com>
Subject: [PATCH] Make TARGET_PAGE_MASK typed as target_ulong
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3JppsZgQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

this fixes the build warnings like

accel/tcg/cputlb.c:416:13: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
    mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
            ^~~~~~~~~~~~~~~~
include/exec/cpu-all.h:169:45: note: expanded from macro 'TARGET_PAGE_MASK'
                            ~~~~~~~~~~~~~~~ ^

also this fixes the inconsitency in the return
type of qemu_target_page_mask (int could be
shorter than target_long).

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/exec/cpu-all.h     | 4 ++--
 include/exec/target_page.h | 2 +-
 page-target.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6f09b86e7f..238a847eca 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -152,8 +152,8 @@ extern const TargetPageBits target_page;
 # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
 #else
 # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
-# define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
-# define TARGET_PAGE_MASK    ((target_long)-1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_SIZE    ((target_ulong)1 << TARGET_PAGE_BITS)
+# define TARGET_PAGE_MASK    ((target_ulong)-1 << TARGET_PAGE_BITS)
 #endif
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 98ffbb5c23..57d60f2b06 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -15,7 +15,7 @@
 #define EXEC_TARGET_PAGE_H
 
 size_t qemu_target_page_size(void);
-int qemu_target_page_mask(void);
+target_ulong qemu_target_page_mask(void);
 int qemu_target_page_bits(void);
 int qemu_target_page_bits_min(void);
 
diff --git a/page-target.c b/page-target.c
index 82211c8593..7176c29555 100644
--- a/page-target.c
+++ b/page-target.c
@@ -17,7 +17,7 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
-int qemu_target_page_mask(void)
+target_ulong qemu_target_page_mask(void)
 {
     return TARGET_PAGE_MASK;
 }
-- 
2.45.2.627.g7a2c4fd464-goog


