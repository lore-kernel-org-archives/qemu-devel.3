Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B81D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qlh-0001bo-DZ; Mon, 28 Oct 2024 10:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkg-0000A7-RA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkd-0003hi-Dd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=EI9CXy9K1ZztLesE7kIdQSq5M7KgVSRLnhgt57LRqbu2Fxmsi0/YtkJwOYAxI/RBGgofhc
 NMNkMMABY4AVeLvGY1KMm7PVG6kxnxZi3hT+bGkJKyrbeYFNuOQVVry7Gi7fGqCYFLfYta
 lpbEhJ/7G2fQwwxVYHYYELysrcRxbgo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-mUwID2gbO6-Iy4HjarRLRg-1; Mon, 28 Oct 2024 10:29:45 -0400
X-MC-Unique: mUwID2gbO6-Iy4HjarRLRg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so31636605e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125783; x=1730730583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leQodRwO8cbwBZJdEKIZ8FGqkROJiM0fBvAauKBAI60=;
 b=a24cv3zEJ+brBZul1zavwcnxHbSU/ENlDEXATD0v5jP7gbfc3glk/SVGO0TIIt5U3p
 hhcuKbREH+UJ1n9B6lbsQ2EXSHLz2vHMTcjD9Q7bcyz4BughxQb+nYo+snK3xVo2IXR1
 6rzpSc2oOrfee3QyntPynqCJOXoE8ZIZHKUzZPWNgjcyj+Qfkfo/YSMNxXpeceNhH711
 Zqy53lSIsJL3+4RfhV7c8Pq1fNIFsML7B5STrw5DdCdk6OMliLb+Qu91XddZtPm0VNRR
 naMRok3N/JHfWbaKLXwAPtO0zqJtFdEOcoUtLtAI+ktP7W5cIwCUP7G4TLqaGUP2xtje
 UbYA==
X-Gm-Message-State: AOJu0Ywjqs9jr/bc7ydVMcEEk1cX9kr6/R8Cj1Ncnq0B8UVZKTy95Va+
 Du4Zoyjrzv5VtFIZvGqznwfkA954cAiZlO1NYSbja7E/MCuPgjcTeDz31ypkKIGzmdtxpTxB0mu
 ABMNdxf3tcqAXMA7tgXzMpLDtmvIyNg5iy13CphII42R1EZkEwnWF+AP969TNOm4iRJbr+VjR1R
 TIal4R93IHLQ9Od5SpeQ04Yx9UVkvuh5d/lTpfdfU=
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr75564295e9.5.1730125783434; 
 Mon, 28 Oct 2024 07:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkqOiMteeZAG64gjpGhsiJtC9EI5wFxYF1p8Igk1vRJ9aTYtoaYTiu/+o6406SpoT5m7bYAg==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr75564005e9.5.1730125782859; 
 Mon, 28 Oct 2024 07:29:42 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f719sm140140155e9.15.2024.10.28.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	qemu-stable@nongnu.org
Subject: [PULL 04/24] target/i386: fix CPUID check for LFENCE and SFENCE
Date: Mon, 28 Oct 2024 15:29:11 +0100
Message-ID: <20241028142932.363687-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

LFENCE and SFENCE were introduced with the original SSE instruction set;
marking them incorrectly as cpuid(SSE2) causes failures for CPU models
that lack SSE2, for example pentium3.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f193716468..48bf730cd3e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
         [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
         [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
         [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
     };
 
     static const X86OpEntry group15_mem[8] = {
-- 
2.47.0


