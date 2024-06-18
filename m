Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BAEC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhaV-00022M-PV; Tue, 18 Jun 2024 18:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JQ5yZgQKCkQxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com>)
 id 1sJhaT-00021d-Ny
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:46:01 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JQ5yZgQKCkQxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com>)
 id 1sJhaS-0000vH-CE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:46:01 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-627f43bec13so114787557b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718750757; x=1719355557; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/FsgzP5gOq3lw1ZO8OOACBPPIdQdCifFEE2A6QE7Gg8=;
 b=dQ9lS3S8xEkUyax+mjsinP+JUNN9cUzcRNcFHwTMHRbOiltBl1HTG0mc9+GUboZkvr
 Rpkar9LEaTSBxeHEW5gGk1IRfKKay1m5HBCVVdhABNce5Vp8rcBZmsztKJGSN7q31CgW
 AtOqqdchynXcErrIeY2ioTD6VC2wHZe05vTp12VuBtZrxZd3zlhklW5E5Ki0v1h8AQv1
 SeDSCtSso5e5gW5mFie00WcdgUZZ1F/3ei/HeY6TQMo/ihFfRwytmnlS2Wh+mWkpjtY4
 IgSJp4ECzxxAmv/m11m93Ig5E63As++MXaOES41cxJez0DeDXd5VD4NBeFpTcvf0P+b5
 BkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750757; x=1719355557;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/FsgzP5gOq3lw1ZO8OOACBPPIdQdCifFEE2A6QE7Gg8=;
 b=K0qIGy+/25gm74OrLlmp4FsJ0ebJZ0RCH1QXvFsjlxJRhtMCOpwbithIc0KQqdzElc
 ZapEIUrd3AWtBl22RmtwLRkIcNrkv0BMChchYov9HEp/wUbVng21dYms1HSaHR1zyHlF
 raTA48sUnbNVzAKpQX985XSL2LnizTN8NwnPBCH/NhvgV0kvBgf78cJuBAS15C5kCGar
 qmd15SeNgkht+DxMH0tVCv5C7cd/eUNENMkZSU0CCuJ4HOEpYiPEY6w5xrAoK3Eu3IQB
 cQgSrm6AHvENpKB1d8bmNPY1QdeeUrTNmlFsV9vhiYdFHJ9KsAX8A7KJNAWLOkbSLHft
 dVaQ==
X-Gm-Message-State: AOJu0YzOEOpUay5lNDZc8a3YP9a+MDS5Oa4+UruNHbljzcYkbaZkEO9n
 xLqCGEm1Shbto/XoJU/01hq/sLNH6Tc7VRf6VXqlqNQWInN7RGr7hnL6SxQSW9fN9QBQsbgQLzN
 qHfbzqmxqFeiVcnDI8J05oyoVFf0CpwM24NtUBlFT+H4qIDPELejVyHRcFH5K3I1oIfkIEZqh6f
 CqZ55mly2jh34hthvqh+4b
X-Google-Smtp-Source: AGHT+IGoeVeUfBrRoep4gm7CX9XFk9vIuYtfidl4od3BeszhDQ4FKilmZO01SB6tnV9yQ9yEfhHsDn0b
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:fddf:5bf:9eb2:410e])
 (user=rkir job=sendgmr) by 2002:a05:690c:b91:b0:62c:f6fd:5414 with SMTP id
 00721157ae682-63a8e1dad55mr2579827b3.3.1718750757082; Tue, 18 Jun 2024
 15:45:57 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:45:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618224553.878869-1-rkir@google.com>
Subject: [PATCH 2/3] exec: avoid using C++ keywords in function parameters
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3JQ5yZgQKCkQxqoxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--rkir.bounces.google.com;
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

to use the QEMU headers with a C++ compiler.

Google-Bug-Id: 331190993
Change-Id: Ic4e49b9c791616bb22c973922772b0494706092c
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c..d7591a60d9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -945,7 +945,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
-                      int old, int new);
+                      int old_val, int new_val);
 
     /**
      * @log_stop:
@@ -964,7 +964,7 @@ struct MemoryListener {
      * the current transaction.
      */
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
-                     int old, int new);
+                     int old_val, int new_val);
 
     /**
      * @log_sync:
-- 
2.45.2.627.g7a2c4fd464-goog


