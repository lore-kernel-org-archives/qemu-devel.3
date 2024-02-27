Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sE-0006tu-CS; Tue, 27 Feb 2024 17:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FmHeZQcKCocvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1rf5sD-0006tM-3E
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:29 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FmHeZQcKCocvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1rf5sA-0008IS-IT
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:28 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-5dc91de351fso205518a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072664; x=1709677464; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oJDukn7jW1vPTXeJS7ppBd1/pnfVtWKCS5OuUBMJ9W8=;
 b=stNPHNeOUJytjz4xgYZRJWK3fzMjITnr3s9vu/bS8lAEWYxmdWNCbWqhncplYsuNfn
 pXyrjWlkTunl67hiLqy36WVKYnNAf6VUMH4mRFguPZGb07bhI9g0CYaMfODGdhu7CWsu
 8RdVu1tS9FMGgNoM7kav9OgZG6uIJhAcSYvGKifsoy1Eh1I6LJLCK8+jLugnUrs+o7hV
 dihbjTgC6BZKIFYvbMPA0KmmzEEngQOaoJTGPBVBhxnvp8xiLect+KQfBmYBAZanvl+G
 qMGcMU2iZGN24m3URw0wqGYWMi8/N0IxrHmUDqRz1FL1wcH0qz2olU7otptd2nB0mAvE
 pu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072664; x=1709677464;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oJDukn7jW1vPTXeJS7ppBd1/pnfVtWKCS5OuUBMJ9W8=;
 b=GXqKEmNsyvCjN70FAJ6umv/77ZUmdzCl43jUDmU4IG58hOKU9+xu+6IDa0AP+Zs8H2
 GyJZekYqwQ7YKwfBSUPAJwK3ySJXx9W95JayTFYRyzfRsy6dknxDF/wCTLKACAzDtMgE
 +itTxDvje0SJp9B/E23+i237UGEzYbql0emyZR1pNYCzWVKJbW0hhDXDLy+m2oiM60SR
 nVCGbC8A10AYS7PDPkMYGZVzFDDYb/eJZjmgqj1TvzdMmWJDohHVxRtZvSPXasTwAycp
 Z/tvv+S3It5POYQE1pCXPw7Y2EuGP96N63ESB4YzrwHFDByQoZmbn1ZFIeGSh0vZZS4g
 sWkA==
X-Gm-Message-State: AOJu0YzV2nQQvjBguDdkfCpA7wj06RnhfynOJdPhbJiUlDR47KLxJAwY
 +C7X35gF28xBfNOa5LFiEHz+Zyn/0OZZtCIRDbqNyW+gVLacNhl3jEItJQK9fCDU9F4FUlmy1HZ
 195XuAJw6EASv04bRcQEt72Ye3+m2iikOZkn3DUSF0DmtITH41q0YWf6ISf1UsTTeFi74xPvXTm
 rZVCe12WLjjFRPxBSn74O1i0gnFo9zxes51xAY
X-Google-Smtp-Source: AGHT+IErXylakRUR7HUDs3S+pqp50CQbxUZaWDGFRtWotdrZ4SwK1kkj4mavYgHJcx6+pAr1SXPphY27Di+O
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a65:6956:0:b0:5dc:36c7:6ceb with SMTP id
 w22-20020a656956000000b005dc36c76cebmr1761pgq.1.1709072662472; Tue, 27 Feb
 2024 14:24:22 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:14 +0000
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-3-komlodi@google.com>
Subject: [RFC PATCH 2/5] memattrs: Fix target_tlb_bit whitespace
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3FmHeZQcKCocvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

checkpatch.pl doesn't like these spaces around the colon, so we may as
well fix it up.

No functional change.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 include/exec/memattrs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d04170aa27..942b721be8 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -61,9 +61,9 @@ typedef struct MemTxAttrs {
      * and has unused bits.  These fields will be read by target-specific
      * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
      */
-    unsigned int target_tlb_bit0 : 1;
-    unsigned int target_tlb_bit1 : 1;
-    unsigned int target_tlb_bit2 : 1;
+    unsigned int target_tlb_bit0:1;
+    unsigned int target_tlb_bit1:1;
+    unsigned int target_tlb_bit2:1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.44.0.rc0.258.g7320e95886-goog


