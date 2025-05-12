Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264F5C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTe-0005mb-OJ; Mon, 12 May 2025 15:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTM-0005UL-H1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTK-0007WA-NC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcsCKBv6s0E+eFJ6qpqRFsRKmqbdvOjhgTl4jheLWXs=;
 b=L8NrvwTMoU8//7gVsJ7tRMgvoVyAUSLyHDshb7vo/78n1pPR2eaRzSiUkBbrNSvGJP7Pqx
 kMqyZ2kalm9PwBV7htceQ9lAy0Fabm2ZjlfPJThtkhXs9CEyzR0g04I4naOJH2uRmQPC5H
 nO5Lf2oOBr4bESwryhIrgNwdhVy/+Qg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-4cL16mIlN2imwtgbnW6uxQ-1; Mon, 12 May 2025 15:05:52 -0400
X-MC-Unique: 4cL16mIlN2imwtgbnW6uxQ-1
X-Mimecast-MFC-AGG-ID: 4cL16mIlN2imwtgbnW6uxQ_1747076751
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so20599995e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076751; x=1747681551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcsCKBv6s0E+eFJ6qpqRFsRKmqbdvOjhgTl4jheLWXs=;
 b=YOG8sSvGhG4ckff6GLh4LPW5UrcacE5ma2ie1TxMXerGzDiWSZ151fL37WonyGCNX8
 z+wqrcdKsjKZ2IF/XR2+gFHXQSHynDjhLY8ufLQwwtppUElyAVeZFsHaf0qqK4l0GYP9
 YovOKaWATe1Ys0R/NtvJuyINVvgTdtwaLW2qP6Vf3uJoKi3y01K0tSLqq/b/a2goSVGZ
 NlKGY9cV9iu2cCDBdW/iHkVLRNZyAYoUEgTYaDyjzhFdeMxEMHVb+imun/d2tcWF1DgI
 NgSATl6ZqouvBs4tMls9xUBpogynaRY9EXIe+EAJ7DOKmLJuinJC+cv5l6ZBj2r7zai8
 nMCw==
X-Gm-Message-State: AOJu0Ywbc5a0QYIIGtc8vKkC9cHMjcMaArLrXKSc/9BQvMxaTXlfIH8U
 2GT/d04LmSop/p1ccmY9cqfIICxDxMxe6EN9iTaAIsp9Nx/IsRCIkrpSaNf8vm1wTEJOFP9Fw+p
 J+ck4LOzc4bagMdzcmtO8heWckB5hnLz7foPrxHJAvEHHAwVlPKshc7xVtDlxYf/PGJ0b9hkEqD
 w904vfJhQPy9Gs/61sfcApVqN0LPyMWtONgFdR
X-Gm-Gg: ASbGncun9L/NbwzA+vwN+V43BEOXM8IvuvtF53CYtFbCDHlYrypEWeQiHl0BX+hjcBw
 dDQoELjKHLLz47xjajujTKdIyY2OKdQvZK3jJDFCicfFqcvegWoVABO3IHTlEqXqOi7vr6I7QFB
 34kotG72K08xXhdNtt1v+tzaLdkuu9xUDQ1Ds/2kcZ9wxSeglgVCLjiLipgu0Po1iX5zSLjrSSs
 ctBLi/ORGcBnu4V4uFKWPK4AlU+5N1dASucQJ/mo1Mg5IrL4gJbsU8u+3uyBe1PkBFtgndM3nEw
 4M3XAJUs0hSTLNA=
X-Received: by 2002:a05:600c:6090:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-442d6d18bfamr129435085e9.5.1747076750994; 
 Mon, 12 May 2025 12:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFHKGSlx8VVe8aiMl/QUDW5KAVb8jUF3yHiqL+RmROFltzM5ComA24djasdKhelczyH93C7Q==
X-Received: by 2002:a05:600c:6090:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-442d6d18bfamr129434895e9.5.1747076750479; 
 Mon, 12 May 2025 12:05:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a07sm13647653f8f.50.2025.05.12.12.05.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] target/i386: implement TSS trap bit
Date: Mon, 12 May 2025 21:05:18 +0200
Message-ID: <20250512190524.179419-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that we can do so after the error code has been pushed, raising
the #DB exception for task-switch traps is trivial.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index cb90ccd2adc..071f3fbd83d 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -473,10 +473,6 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
         new_segs[R_GS] = 0;
         new_trap = 0;
     }
-    /* XXX: avoid a compiler warning, see
-     http://support.amd.com/us/Processor_TechDocs/24593.pdf
-     chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
-    (void)new_trap;
 
     /* clear busy bit (it is restartable) */
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
@@ -622,6 +618,11 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
         }
         SET_ESP(sa.sp, sa.sp_mask);
     }
+
+    if (new_trap) {
+        env->dr[6] |= DR6_BT;
+        raise_exception_ra(env, EXCP01_DB, retaddr);
+    }
 }
 
 static void switch_tss(CPUX86State *env, int tss_selector,
-- 
2.49.0


