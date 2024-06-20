Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1C4C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 20:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKODd-0006Bg-4n; Thu, 20 Jun 2024 16:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Ro50ZgQKCm8eXVeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--rkir.bounces.google.com>)
 id 1sKODa-0006B6-OA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:17:14 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Ro50ZgQKCm8eXVeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--rkir.bounces.google.com>)
 id 1sKODZ-0004uS-41
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:17:14 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-63c08752872so24053787b3.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718914630; x=1719519430; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8n2UxX1gjpnCRLOUM68mlktH4IVD6wu5aMSgKQr0zZU=;
 b=AHb7SPZm83oqlZ0fmdPi0IvJteBRZlFC1Rx0gvEZCIuJXp0aqAm9QK9qaz7a6M+Rgk
 QMY91fjLmU4MVhhUNn7YNVKM+DSXRbIO4YXKFVTyQ9VsksoZ0JUWEoWC0BjSg2CYfwp6
 cuNeyzdOOeXBb0f1UP4s8lQbQ+MMtjyiLts2RpHLrGbIvYByn3dTuB9xKOS43oT1T22C
 cLWD3B+OQerIYJPR5Q/iQaLqyhBs+YgMw09S0Pifa04lh5I/p3l5HcbXJF2hcXOhkClw
 0WiqYHhRNWahlOOBuKAd48kWxFm7ubSH7tgAwJ0CG1N9Q2Cc6LQWUoBisE9TBfe2D2il
 Fzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718914630; x=1719519430;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8n2UxX1gjpnCRLOUM68mlktH4IVD6wu5aMSgKQr0zZU=;
 b=qdEkdtshOEFzazELlvE7xlzcDz7lv3WzSF7oax1qiEqkvPlwp8qWGHky6A01MSBlSB
 4b6r/41wpRB5N+1usIcsV/B07jgYLPzdIan4dh9UGCGUz6treYXoAH3Hywng4RO02WWB
 rBs/USvz+pZ3BAeEZRJTuZ7lKHjXbQkEgoJ8fziKILJDXpTkQhz86mnC8PnNbGIwKkH6
 5prGI4b90sEQeRzpWpmEz1IlCFlmVlvBE4LupqTOGKXlsOemxFSqyc7q8M5715/AAwI/
 dobCz0epaw5Nh4kNwwDRt4mgx+ZUeNrB31riKP+hTUKkGnXw5SVGOuJEyrsvC5giKocJ
 QzOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEuNvHdWigdMkWwpj+xvboHCKEOZUqu5LUqQ7OHc9IUqx8luO5m0fGSsRDT9bo/YJzkOZ1EArwnktVRaWMUohe0fy7SSc=
X-Gm-Message-State: AOJu0Yy0cHBu0TQ7Ix5jIi8YGb02a21hVpQN/tzzigZXEHZ73Azw+64p
 5Ovcvjzy1EZwaZ1wmSuorHft5KLQiFAYblNAVqnbnXY9ffE1/w/FBHA8tOabYJVcroDFGA==
X-Google-Smtp-Source: AGHT+IECIBUjzPkjAo4w7jy6kH3zMTvSFAoJYLFOZkC+9ry7HWPq46mAQkLYq5f+IMiT6BwGdnhQ2VEf
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:df4:7552:4ba4:9441])
 (user=rkir job=sendgmr) by 2002:a05:6902:1006:b0:dfe:1633:89e9 with SMTP id
 3f1490d57ef6-e02be16c56dmr1753419276.1.1718914630473; Thu, 20 Jun 2024
 13:17:10 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:16:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620201654.598024-1-rkir@google.com>
Subject: [PATCH v2] exec: don't use void* in pointer arithmetic in headers
From: Roman Kiryanov <rkir@google.com>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 alex.bennee@linaro.org, berrange@redhat.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3Ro50ZgQKCm8eXVeTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--rkir.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

void* pointer arithmetic is a GCC extentension
which could not be available in other build
tools (e.g. C++). This changes removes this
assumption.

Google-Bug-Id: 331190993
Change-Id: I5a064853429f627c17a9213910811dea4ced6174
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
v2: renamed from "use char* for pointer arithmetic"
    and removed all explicit extra cast with
    one typedef in memory.h.

 include/exec/memory.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index b1713f30b8..b616338f05 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2795,8 +2795,10 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst_phys.h.inc"
 
+typedef uint8_t *MemoryRegionCachePtr;
+
 struct MemoryRegionCache {
-    void *ptr;
+    MemoryRegionCachePtr ptr;
     hwaddr xlat;
     hwaddr len;
     FlatView *fv;
-- 
2.45.2.741.gdbec12cfda-goog


