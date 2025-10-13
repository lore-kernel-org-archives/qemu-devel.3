Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839C8CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8L9e-0008B0-9i; Mon, 13 Oct 2025 12:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8L9b-0008AT-IW
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8L9W-0002ry-Dv
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760371918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7LaTCLPgKKjGavJRvr3DnJWvkR1ugzT97eWXFy7H3+8=;
 b=iPF7EWhSHacqGUxHDVSMfXgK9/bapmp4a8A2n7GIEkmdhjYIEvCt7P/x0iMgb3qayEk9+p
 0Uw4JE30DTTXu/DjfwWs0wV/ubj4XDbMI0tvM5OeSl12bx3XZCMSoKZz0NmKMNkRSejMHZ
 SkVxyHptZFXVAvSyzwsh1fLcZcLJcZo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-65xDIi7XOpac47_IVVVI4g-1; Mon, 13 Oct 2025 12:11:56 -0400
X-MC-Unique: 65xDIi7XOpac47_IVVVI4g-1
X-Mimecast-MFC-AGG-ID: 65xDIi7XOpac47_IVVVI4g_1760371915
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so2664012f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760371914; x=1760976714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7LaTCLPgKKjGavJRvr3DnJWvkR1ugzT97eWXFy7H3+8=;
 b=VcMSwCNQxCd3CqMmEpg9/oxxOOhCH6cp+vYwPXw/Zs0grqoXYXnH0/Lles1IqVUJju
 Rf2bzBlyvNjzB+HUxGWbVQT1UZWawtm8GrjR0HQEynbL+TEKS+Gl67pAbsIn5GNEZlbk
 4WgsoLfupZdd1BHsIwC5ZBG+XC5mX3lipwgh1CfQdvZa6gPmADq9pgCkBHxReJ1jAX6W
 5VA1/HUIZdtDLYm3J1cHfiZ1kwq9DtnWR2MUUmpfUMNvyX78xPL+ez1RMXm/J6S3LCYD
 2vShSCFkWKfL5Lsby8n3vt0G2ZYKbe3UKiPCy1bxibYzho2iv6MvePIonH6PtsDR0Bct
 HOog==
X-Gm-Message-State: AOJu0YzEwLAm2Q3bPL3XKVd2KWu6HgPuTt6ex//lhaezNMZj4TY7JSZE
 D7Dc8hycnVIuCgTfbsh9LHEoAiNkeVB3h238f5iO1hNfMyTg6KbhRpLs9LoeiJCzFvA7FiVCdHJ
 IzMyzYOUsZnkLQz/kL6SBcp5jwSJTJrSFXP6DmiP4o/Yz3wsk3pvh6Xv1D+GfDYQAYwsqsjFCzc
 EC82iUlo3hght7VJNqkCP7WN9AFlLieaxVF1ymYc1z
X-Gm-Gg: ASbGncuViCtau4zCjr9e/ez7SD53iRAUlcz6nMY38j/5l8TUhQgST1gGuxE1+R30tdK
 Z69SLadbiYD3TMmDeFQ6AfSRmuOoifMBkYrG2+X4tQ9GWscwGyZiiNqj07NArL0jm4GC1++ygwz
 /cg4BfqFGCR5SeyA+PtR3advik9rHMmjZEMe54fwTDW84EnFrLVBgv/F3tIumKx2bR8tLaPWEix
 KYAb8QkNr5KoVuQ27CXT32CO0FQGd4p3WSQWg4brI9X4haXJ3tUB8w/fzqJzvjVxOmVIwnYxAsH
 lLZQZTrDMMsAk6roOSvJuiivDoGZzaoBG7vNty0UkQfs1pvg1PqKCE7qUs45DMqNivXtTt58jFQ
 bh0PmTm6FIOFQHLGi2m7txaLo4yolIl179CpuHlrnYZs=
X-Received: by 2002:a05:6000:40da:b0:403:8cc:db6b with SMTP id
 ffacd0b85a97d-4266e7d93b4mr15058022f8f.35.1760371914261; 
 Mon, 13 Oct 2025 09:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYqD0y1/yl+sfxjk73wH4KSGeI3867pODAPCfAC2RRpp+YRWbcqjyy6ng/31PHcoRUW2dNzQ==
X-Received: by 2002:a05:6000:40da:b0:403:8cc:db6b with SMTP id
 ffacd0b85a97d-4266e7d93b4mr15058001f8f.35.1760371913881; 
 Mon, 13 Oct 2025 09:11:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce589b3dsm19485383f8f.24.2025.10.13.09.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:11:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] target/i386: fix access to the T bit of the TSS
Date: Mon, 13 Oct 2025 18:11:52 +0200
Message-ID: <20251013161152.992880-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The T bit is bit 0 of the 16-bit word at offset 100 of the TSS.  However,
accessing it with a 32-bit word is not really correct, because bytes
102-103 contain the I/O map base address (relative to the base of the
TSS) and bits 1-15 are reserved.  In particular, any task switch to a TSS that
has a nonzero I/O map base address is broken.

This fixes the eventinj and taskswitch tests in kvm-unit-tests.

Cc: qemu-stable@nongnu.org
Fixes: ad441b8b791 ("target/i386: implement TSS trap bit", 2025-05-12)
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 071f3fbd83d..f49fe851cdf 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -456,7 +456,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
             new_segs[i] = access_ldw(&new, tss_base + (0x48 + i * 4));
         }
         new_ldt = access_ldw(&new, tss_base + 0x60);
-        new_trap = access_ldl(&new, tss_base + 0x64);
+        new_trap = access_ldw(&new, tss_base + 0x64) & 1;
     } else {
         /* 16 bit */
         new_cr3 = 0;
-- 
2.51.0


