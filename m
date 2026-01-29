Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F579D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXKE-0000xa-88; Thu, 29 Jan 2026 14:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WK97aQQKCvcqjhqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--rkir.bounces.google.com>)
 id 1vlXKC-0000wS-N8
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:05:04 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WK97aQQKCvcqjhqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--rkir.bounces.google.com>)
 id 1vlXK9-0001vj-FO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:05:04 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2a7d7b87977so11721385ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 11:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769713497; x=1770318297; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jZN+xAue/0WQh7ROD9dIfdA7rBuA6+EwxwBSz2DMGUo=;
 b=185dI89VrIohhRAhvXwgbcDJALPOCGJEzAhBsgFBsh0WnnB8XtPKJzuUJ58qlw0iy4
 QL2VsCv4tmlfn+ayejriHiB7nd1ERcwr6AFuQJl3y5jwW3bQiwCiuKa0mJcV0fGyFp5C
 HmIWLeZ2BCq/J9PIGo44FP0/9I5JS1jHQVBYSiE4s7tHJgK8ePGfegVcvnet6VSPGNjZ
 HI4hBz/yMfDk6xrLiHySaUXm8SDhjjXZCvAQ6YjwFdSUHtnSP9gFs1+OT/7rDo8X0C+e
 Keq3PONWIjx9cxJn3SifCFzFIm34xM4tyiMgBzw0QdZji0TVbkn18hNzKE47Xtp2u6VS
 hpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769713497; x=1770318297;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZN+xAue/0WQh7ROD9dIfdA7rBuA6+EwxwBSz2DMGUo=;
 b=Mh75I1dKeKLaMZmjrf+dRHyWyV75CIDpQAjpueaYe6psSKRcCq4ngciqIJSZIPcJpH
 261jiAKzcsLLtM5wmP+9hmn6K6Q03JjUrum9vGUwGOWWCk3M9VwkysaqvfaFU6EV0epi
 LOkzToHWIkH16wVe065rv5Jq80FxOeHd7wUyQYRax1WjjtH7eXPNw/pIe0uZgmt+RIPS
 BnyYQ/LdCGDYTR+o7mj47oU/CJ+uAZHzBrpNmZDuPEqFuheDUFU3jL27ebeO/sKje6XK
 9oLj/bO6dvFUYca6dx60hk8G2o5a9wpinfY+5xIu2odSD1F+U5dFvEzTWMIHYFXWfAUk
 F21w==
X-Gm-Message-State: AOJu0YxcNyqcNgq/T20oF5J80TnEryfmUHcRpbbNDJI6zVivt3MY9rHe
 oKYL1v+eO4X6UjfV96cPEz2Nrs3imce4PwOYdfH/6Fp6QXvHCKP4sjt54u8qXX5cnh77n275lXx
 7jQenafnZhQoL7iIBdnkr8lsCD4Cu7qM9ReZ1DDcd1TPdR/dKKizmwuHgNxOkagcQ6fEiz/qsgu
 z3AxY3I6CQJy9brN/ACElwdbcZ
X-Received: from pllh8.prod.google.com ([2002:a17:902:7488:b0:29f:25b4:4dc4])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3b8f:b0:2a5:8d30:58f7
 with SMTP id d9443c01a7336-2a8d7edc348mr3417685ad.17.1769713496818; Thu, 29
 Jan 2026 11:04:56 -0800 (PST)
Date: Thu, 29 Jan 2026 19:04:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129190444.225306-1-rkir@google.com>
Subject: [PATCH] ui/kbd-state.h: Make the header C++ compatible
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3WK97aQQKCvcqjhqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--rkir.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch fixes the C++ compilation error:

ISO C++ forbids forward references to 'enum' types

Signed-off-by: Will Hollins <whollins@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/ui/kbd-state.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index 1f37b932eb..3522ebe51b 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -9,9 +9,7 @@
 
 #include "qapi/qapi-types-ui.h"
 
-typedef enum QKbdModifier QKbdModifier;
-
-enum QKbdModifier {
+typedef enum QKbdModifier {
     QKBD_MOD_NONE = 0,
 
     QKBD_MOD_SHIFT,
@@ -23,7 +21,7 @@ enum QKbdModifier {
     QKBD_MOD_CAPSLOCK,
 
     QKBD_MOD__MAX
-};
+} QKbdModifier;
 
 typedef struct QKbdState QKbdState;
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


