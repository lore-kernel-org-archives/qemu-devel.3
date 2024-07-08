Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB10C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsvf-0000Hz-9B; Mon, 08 Jul 2024 14:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Li2MZgQKCvMmfdmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--rkir.bounces.google.com>)
 id 1sQsvT-0000G1-Et
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:17:25 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Li2MZgQKCvMmfdmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--rkir.bounces.google.com>)
 id 1sQsvR-0007lS-8Y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:17:22 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1fb1c206242so23364545ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720462639; x=1721067439; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x7WKQQyf8wJkSh4fVo92NZZlk10ujnu8nvBeDte5ucM=;
 b=jrtOJpmh9+8irXRASypXuhyy9dC49c0A2S9VDCPGknMuzJKB0z1YYIM+OpcTQDy7ku
 r8FcO58a7+R/FDPrXCTxfNaQIi4YNCj6nALPsgRLVN4r8VvRUOo9p65NCcLgZJyQT1XO
 5d4rq5oQTl/Y54sr53ExeGoay41BxiZVP40fsSO+qUcyUyERxMHSIopqdzL1aYHW0G/F
 9OcUo3yElyN4jU+y6WdHCcYA6qC2m+oW+UBsg2/kPhqtsQWaKuwo2zkeje62b0BQRpFm
 eD3T00YRFyEXKBc4804LV31+iW6ztAXCrW+3Fw+gg4Dq6TmPVRC133iuBcGP0s+SXQZ5
 wVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720462639; x=1721067439;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x7WKQQyf8wJkSh4fVo92NZZlk10ujnu8nvBeDte5ucM=;
 b=HOm2PN08K3pFqYKNt/DCNUUtReOiD4qySUj0inQADVpoZ7d2yb6lCsbg265KCdweM4
 Sa0AgSK8i07nwSW/0SfLkeAot1wBpRRKPzPha801fKZNEutm0Ygg7u5bta6WKJ6JXHmv
 6vk9U/AWRPAzMO3MRHnZAAs1HEM0ety0MoKTJ3+Xl39oYrzryMPQNZgDWbGm35lEmjFZ
 rRpdSfcNXbuOU99X8waVd93wYMHGRuba9gNcu1IX6qtmgK78+qQ5n8yyF4pyN4xPefaa
 9SI+N1qFgpIWeNnGKbxxQBWrRi5iZTI6xaYC8vToDXDSlFtxH1MKHtpNmTuFlL22CVv/
 AMaA==
X-Gm-Message-State: AOJu0YwmqKMYuz3MtJrC7Th0bx27/dzCIe/pBFfbe3VC2e0EdCOYSBS9
 Ch9dXfotVsxmtwdSgG3vAApvQR82K63PKFAJL+imNdXGFU8ZvA8P8RF7KWsKhjqo6+UkSWlDZSR
 daLl+2vwJeR+ac0uaJeTQ1g+thYjtiimJWGSkzayc5EIY+WXoOi39OCr3AhRClzEPCQtOhNuR+u
 Gd9AcBTdpggGaWg/zpSe30
X-Google-Smtp-Source: AGHT+IHzVIkzvSTHWQDvdPMX+N4Tkjx6k7yLAbBbTzyWs+BtUK7bfFGDc0TARnHpslCyczVHEjjIWTL+
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:4965:5b2b:1fbf:b9e2])
 (user=rkir job=sendgmr) by 2002:a17:902:ea0a:b0:1fb:325d:2b62 with SMTP id
 d9443c01a7336-1fbb6d541b3mr7105ad.10.1720462638817; Mon, 08 Jul 2024 11:17:18
 -0700 (PDT)
Date: Mon,  8 Jul 2024 11:17:09 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708181709.27410-1-rkir@google.com>
Subject: [PATCH] iov: don't use void* in pointer arithmetic in headers
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 pbonzini@redhat.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3Li2MZgQKCvMmfdmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--rkir.bounces.google.com;
 helo=mail-pl1-x649.google.com
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
which could not be available in other build tools
(e.g. C++). This changes removes this assumption.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/qemu/iov.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 63a1c01965..57afab370c 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -43,7 +43,7 @@ iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
 {
     if (__builtin_constant_p(bytes) && iov_cnt &&
         offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
-        memcpy(iov[0].iov_base + offset, buf, bytes);
+        memcpy((char *)iov[0].iov_base + offset, buf, bytes);
         return bytes;
     } else {
         return iov_from_buf_full(iov, iov_cnt, offset, buf, bytes);
@@ -56,7 +56,7 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
 {
     if (__builtin_constant_p(bytes) && iov_cnt &&
         offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
-        memcpy(buf, iov[0].iov_base + offset, bytes);
+        memcpy(buf, (const char *)iov[0].iov_base + offset, bytes);
         return bytes;
     } else {
         return iov_to_buf_full(iov, iov_cnt, offset, buf, bytes);
-- 
2.45.2.803.g4e1b14247a-goog


