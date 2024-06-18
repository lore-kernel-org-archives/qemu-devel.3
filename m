Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141C9C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhaH-0001y9-0j; Tue, 18 Jun 2024 18:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FQ5yZgQKCjQhaYhWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--rkir.bounces.google.com>)
 id 1sJhaF-0001xh-BD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:45:47 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FQ5yZgQKCjQhaYhWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--rkir.bounces.google.com>)
 id 1sJhaD-0000sp-SA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:45:47 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2c7a8949243so815625a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718750741; x=1719355541; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sLRZ+W5a1GgYaQElKB7uBWALvxAWVGcbEd0ESEwZBlI=;
 b=ypbp9fD72T5SxFmu3G4OflCfOKiOB5lThEcIgcN3hbqxdMMHTTy8PQQKSfLUZT8tkI
 QXjqQKmT9N++qwtlSzhyHhQ8lLUSDJ7VUECCsj9c4lSX553LUk6XRjZsV9jsNw1zZ3d2
 jy+0PVoffoESpD1cw0w+kACWEXE00yHSZCCTRsHYH1UsCIkHNI77TuD3tA/q3FqsTUts
 wx6lp3HNuqnCiASaCMMB0J+i0l5wtgNtPC0P/QKxyK3XFmU2eF+GLCyRSN/hwobl6cuH
 gY2Z+ICn+EsP9++sM/xowWJiq6TH8rEjuCZ34l7qDT9hFDsEzLNSfu3y42STlNeIXt+y
 /YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718750741; x=1719355541;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLRZ+W5a1GgYaQElKB7uBWALvxAWVGcbEd0ESEwZBlI=;
 b=I6JmSq36QaIwBqSwWOrHTxKqPHdxVkXCjoAp88FBb5UZGioYJ1/ww9MpI6Ay5HzSwo
 pt0m5lZlilqG6wl428E15f9P9wfWFA9HZUSkR+Jn2TD1GNfXGAiRAnMdCjYgdmc7kWiN
 g+OgwPfXuNH7lIxQ/gyS0c+SQYi8w1DX43KsuJZzQ4BlnFePGXT0uqog8vVugtQsh0Iq
 d688tsqY4Nd8JIZiTt4G+K7oMadqW3kJS7fwETXRkONKnMUW9IFyWFYCWz2PkB1biqXY
 Zu+q9SArGvrTbpc23BW+hWKiu9h5PLtpVouk4zzU8lWwvlzPmawP2PE1rhBjgnFZRRXH
 2ccw==
X-Gm-Message-State: AOJu0YzmWLpwjV93mbwXT1Rhl/1+RbTx+nMmVBR09ij+WEMgmjz79tE2
 n5xqFl2if4o9iLL4ngvroTXIqKLVjackzYv67rTZV9dzfuf08om1avPHECHCS5X/x0SsHqNuXLw
 PazTri0EIkorB79Y36fuy5F/9PuZRhlf/FNQwk50TXZx37eKqEm5CzavFkhDsq8lInsbM+zhaYq
 1TPvOk6vBvpTlIbek+EqLj
X-Google-Smtp-Source: AGHT+IGLtYi0LS25uAEXiWPSxFOgSMMG/cYtXpu3vPw17ZqxYNTXIx8tgtjLhWA2bOWjYhiASwKb4AZb
X-Received: from rkir98.kir.corp.google.com
 ([2620:15c:7d:4:fddf:5bf:9eb2:410e])
 (user=rkir job=sendgmr) by 2002:a17:902:d2c5:b0:1f9:a0f5:7ec5 with SMTP id
 d9443c01a7336-1f9aa484e01mr344175ad.11.1718750741376; Tue, 18 Jun 2024
 15:45:41 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:45:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618224528.878425-1-rkir@google.com>
Subject: [PATCH 1/3] exec: Make the MemOp enum cast explicit
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com, 
 Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3FQ5yZgQKCjQhaYhWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--rkir.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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
Change-Id: I785f2e65d192287f1f964d2840131b653755648c
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/exec/memop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 06417ff361..f881fe7af4 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -161,7 +161,7 @@ static inline MemOp size_memop(unsigned size)
     /* Power of 2 up to 8.  */
     assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
 #endif
-    return ctz32(size);
+    return (MemOp)ctz32(size);
 }
 
 /* Big endianness from MemOp.  */
-- 
2.45.2.627.g7a2c4fd464-goog


