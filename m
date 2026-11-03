Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F06606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEqENu0Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOLSW-00057v-4Y; Tue, 03 Nov 2026 15:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mondalankush9851@gmail.com>)
 id 1xOKAQ-0003jf-RM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:27:36 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mondalankush9851@gmail.com>)
 id 1xOKAO-0000Mo-Cz
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:27:33 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3b08cf16decso10677a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793734050; x=1794338850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZS9GbglRB1XX/ocgLzwYWilpJbVwnylXKn8D7GOyweI=;
 b=qEqENu0Q5MJ5KCckOrNHUvkN98ybGB3RzvQW20UBQUXo4Agu0bGJVzMOaL6q/LLg35
 2QSuffTO6KrwTiAK3e7D/qZ46CTMf5etc7VW/vWd6ElHQxNGvLWjO1/89qLQx6pugdol
 U09zJ2L6akbnqRWnUAHPvr1TUBjWIMZZyy32wNGfoz+81ZL+zvFl+ebLvclEwKZ/S5fn
 TyrD53w2KFaL3Sh3osXnMu61H600X+OpBEx2szvwV8O7TEh/kTEuYlVzx1FZlzICuXvm
 UalcpH5booBdjPL30hELDUTBcWueZlv/NTyd1a2audCF3u/otS9w8t0q6wYmKmkO3roK
 B8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734050; x=1794338850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZS9GbglRB1XX/ocgLzwYWilpJbVwnylXKn8D7GOyweI=;
 b=MaMhgPbX3gQlkfg9sWeuujH0iqV4m+PDJAVEvj6+jcxy9h0dwirWSIC9U/B4UEvVOl
 2KnzuUqIDZUa57gPTkUvHdKFRafrNe6+8j1CG9Dxfd/zReY44z4ovNtnYdpsHKicH1Wc
 L08xsmm/aeOwRBhjNbJvnFb1J9HQC0TEainP29X07w2ceZC/2y9ejPMJEajtP/yG9mux
 b1O5bpGFx/sqftuUNCdECizazdZal12cQ8URh3NpPvd8RFyopHsz0bhLGVhRz6nHhFpq
 rT3b/U/UnYYk93Vw4taNpNyzkrD8vuR1OXxAer/+Pi0lbtorPYTnTZDBNnUOT/op0kf5
 Q9wg==
X-Gm-Message-State: APuU4Z9AWM6YdXznsdHWbDvrK6UU1R1PPiZq00XCYjxLpG8HelSYWNeM
 p/ge7j5XLQHCWua8L92LOvUKb4pCaLhMH/p6u6d3GmgsoSovGz7E5zt4pTUohxm7S2g=
X-Gm-Gg: AYBFou1MOy4QE46E6tqcgDsrnOWXLHQ93bhELyW247PFVvZp0MOd/Hhsofu4I6aqkTT
 ORQAM95AYet9cqGk7iaPt7h+usFeazIwtGjDt/G0mLx6e6Ka2CPH1lLAqybaQbVLsfmoMMuAX79
 idkEV/KHVv7eXvItfaLWj1KB1lVHoHwXWaJFfm3eV23A7BHAZvnnAwFMaBEwTrHWmIpk/SBsSdy
 us/55F0S77kkGqvftzYwZRJZuxIiVLLgGsPogBh9nT9PVA2T82Zo0bTLCCV/urVdB2Y9Nf8eX65
 IfHn6qkIP8aXfSsydFVzTqJfbubACy32kifQUxpWGhG+HYFLxs/F2gbMCrQTqTcqRJAHV6qRGyo
 S3ha3tviOIKzqna/kzF2qsUwHntGkDs6vzWOskX+RCQfDDM09AepqQFHQJ5A49EQLC88bScFTQv
 GryNqXy8zBuBBiFAGLizXXsUoa71Z0oGsNgFcCY4BajnYIcKOo3yJUTsIIlw1fR6PGkFIIXDJ2o
 Hk3YLLzhVeziOzNcEZJOUFZS1HNwHIJYIf8LxFDx/h5/1rOUdmtHzdbKurk4QA8WhfuZj3H3w6n
 ZoYiLNdjB3evNIqYCbRBGsSocfsmfpAMxtE3LuIdvUlLJufmOg4a6ob4BRAXWrcfJTYjZSwmsjV
 bhnw=
X-Received: by 2002:a17:90b:4c52:b0:3ac:4e18:237c with SMTP id
 98e67ed59e1d1-3ae8916c919mr11364036a91.0.1793734049920; 
 Tue, 03 Nov 2026 11:27:29 -0800 (PST)
Received: from cognitive.local ([2402:3a80:1c8c:8c5a:bb3e:c5a3:7c91:f2f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b094d70a60sm126340a91.1.2026.11.03.11.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:27:29 -0800 (PST)
From: Ankush <mondalankush9851@gmail.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, thuth@redhat.com,
 Ankush <mondalankush9851@gmail.com>
Subject: [PATCH] disas/sparc: Use unsigned long for shift operation
Date: Wed,  4 Nov 2026 00:55:59 +0530
Message-Id: <20261103192559.297757-1-mondalankush9851@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=mondalankush9851@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Nov 2026 15:49:56 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shift expression uses an integer constant of type int.
When i is 31, the result sets the sign bit, and its
conversion to int does not portably preserve the intended
mask value.

Use an unsigned long constant (1ul) for the left operand
to ensure that the shift is performed using unsigned long.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618

Signed-off-by: Ankush <mondalankush9851@gmail.com>
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..40c1164554 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
      another, it is important to order the opcodes in the right order.  */
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (match0 & x) != 0;
       int x1 = (match1 & x) != 0;
 
@@ -2525,7 +2525,7 @@ compare_opcodes (const void * a, const void * b)
 
   for (i = 0; i < 32; ++i)
     {
-      unsigned long int x = 1 << i;
+      unsigned long int x = 1ul << i;
       int x0 = (lose0 & x) != 0;
       int x1 = (lose1 & x) != 0;
 
-- 
2.34.1


