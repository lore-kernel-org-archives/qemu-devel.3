Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA50C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMa0J-0000ft-Sj; Wed, 26 Jun 2024 17:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KoV8ZgcKCmEUDMSTQDFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--venture.bounces.google.com>)
 id 1sMa0I-0000fg-EP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:16:34 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KoV8ZgcKCmEUDMSTQDFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--venture.bounces.google.com>)
 id 1sMa0D-0002CA-Ch
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 17:16:34 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-6c559235c6eso9318190a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719436586; x=1720041386; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=itDBadyiS8ipJvku8Ye2MDbtKB5QxB35THvZWt4WM88=;
 b=hMPSxX0HXUcmEcd49YrC+dDnQrF5xwNuZRefu13PBiqe3W/HMmm3yFHNUj8tHJGESa
 nTYvNUTX2N9rtSIy+a0tYC+mOG1eIuyoY5iU003u17/9kKawdcfFLbKKj+45QyQl2E26
 xNPV/arRru153ft1CNiYjKJpAxT72GxE0W2etfB4rV52CkrCLRcspsNn6h6WQiYZ/iL1
 R89UwakktXYKem3UWINS8bKkNaFzJnCtCCjLBSnJZvGpGQmMG5xYDD4vZVfzLztMIOzr
 3XvPb4W5m0Y3ms6hDHkALiZn8rvsfiOUH0fBFZJq/ntjwG16HgVbMFcv1ewZDP7JxH0a
 LRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719436586; x=1720041386;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itDBadyiS8ipJvku8Ye2MDbtKB5QxB35THvZWt4WM88=;
 b=V+6l+T+culTx45T5Pw09vgFca+bmOrTjc8oiBN2MoD8af5g9u9OLA9I9BY2m5UPnPQ
 yToJ4qCcRU/5NyaK2kNVX7SScFx/isD3TQZj3OAs5QJBjXtJRRUUJH2/jmiF6Vu1qqD6
 IlmjPTIJq0iPAbHG/R0V1Xf6aiKgrXVrSL0VYG3KTx0/J0Thr+6DRjoymaRpEgDdDDNJ
 vQxh7pSAypj6QzJgF/gBLVpZFyf2SJu+Ux5kC0bddY442do6M3oBMAYrsh0bKldVFvoP
 bpasIUkQLE+VZlI45qcKMBlUG0NE5wQ+yR+xyFkDQs1mMUh5G+vnZrex6pdGQeAypOqM
 OsdQ==
X-Gm-Message-State: AOJu0YwhBBbLILBzU54KUKJEm5XGU07Rb/idyddj6zkoSQ8sojPtnBTV
 UulZENZczXnF3xqGDKxHp3ElJrClHP1a1nFWB10gjoMh9q51hhfq6z0tYMIxs+h55Xz7ApUjmNd
 mMQ1/hg==
X-Google-Smtp-Source: AGHT+IH1AuYI0i41m3qFKQB5EscxHM8DwTwzOBrt6PtqZ5hZnYc598B/F8uIuXHapxXNARGCGcW46Lc9+eMc
X-Received: from venture.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:5c34])
 (user=venture job=sendgmr) by 2002:a05:6a02:5a1:b0:680:6ded:349e with SMTP id
 41be03b00d2f7-71b60bb521bmr35437a12.12.1719436586234; Wed, 26 Jun 2024
 14:16:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:16:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626211623.3510701-1-venture@google.com>
Subject: [PATCH] MAINTAINERS: Update my family name
From: Patrick Leis <venture@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Patrick Leis <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3KoV8ZgcKCmEUDMSTQDFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--venture.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

Signed-off-by: Patrick Leis <venture@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19f67dc5d2..13255d4a3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2496,7 +2496,7 @@ F: hw/net/tulip.c
 F: hw/net/tulip.h
 
 pca954x
-M: Patrick Venture <venture@google.com>
+M: Patrick Leis <venture@google.com>
 S: Maintained
 F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
-- 
2.45.2.741.gdbec12cfda-goog


