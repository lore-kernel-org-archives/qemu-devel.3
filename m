Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucM1Y-0007fs-SW; Thu, 17 Jul 2025 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucM1S-0007cy-BX
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucM1L-0001Om-H3
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752748761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zcxoJjXc12xb3kFZ3uf+dexponMwVxD9EuwP0V2RT7w=;
 b=fA6d00yV5uTWY4sUMBrDqKzQBRxMtYwth9WV2SpHL2STb8GBZ0pXLcuHqtu6bjOPbRXJXm
 981cJatvMISbGMKpikabz2M+baliZnBhyeiE39HdIEMSu9y7HsWSoq6Eo2K7aRF8XUkaEK
 9vcJVFWx2QpxIBDkYkdCb9ssJMwT8EE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-1rx--LIJMACurvPoToM0JQ-1; Thu, 17 Jul 2025 06:39:19 -0400
X-MC-Unique: 1rx--LIJMACurvPoToM0JQ-1
X-Mimecast-MFC-AGG-ID: 1rx--LIJMACurvPoToM0JQ_1752748759
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6085b0265c5so675260a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748758; x=1753353558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zcxoJjXc12xb3kFZ3uf+dexponMwVxD9EuwP0V2RT7w=;
 b=wp3aKV2IAUz9HCyY6bs+y8iDSIaofmx3LyvIqT4XO1/M8aw+UpB+AhEjdwJLgQrpV5
 m1bZvyNNis6Z9O/jy16FSix+bRf1FHPlVQwbnHzZjZoiWgf0AxAI+7xtLRzLBPt9alKZ
 wyqx2mftBoGuG/oT64CCrgQalL7ZK+2FZYuC1/z36u7DDznrSKSDrvU2eZ7G9CaG7GOu
 W7TzRGJvmpoqteP39If3dwC8rTYPausdZt47bOBacLBrFpjfAFHWK36xToF4cGq6WpJx
 GHiWd913iKLxGSLbORKqvcVZrEOC8Fd6NuxkN5D3NT1INULxa9dABTC239uRrrqF2h0i
 2XeQ==
X-Gm-Message-State: AOJu0YwO5Q892/IDnlB4KvTkAKOKvWVLxcFHzRsObSW8bL9BVht3sm7P
 /lnYXxTFb8e4ObJGgMFEzjLvpHjUAYhnX7Vbu5cDUPfh/4td3KOQe1gbZ5KuM6V71uI5SD4MpJ0
 AJRSjzzkBFmlf6zX2Pq0JLj3/nuDuQQQ1sp0lsMlr59m1MXTCQRjutCAncU1rf2XokMIxYw2kLy
 J1ahxySLYD3cxgOff8OBvrejw1igpuP0GNOkvok2gE
X-Gm-Gg: ASbGncv1g1sQCT4g20nqO91e1C/XI7UW2YHWdjWm63IghFQQrb2Z0UIhbl7w+XnHaDQ
 +d3HkPc9q7kz2a7MbvMA1J5UXJjllGMTjttwXRuUt+zdJgAnZp2N+cmQuSjfuVnGdeBgsCGUVWA
 8AwqHTtQQg8Z9CRMomzq/4caeSKbfsPMsLfkEgdLNL3sPESBt0a6xt9CGqWUATGD0VXVtJimDlJ
 YrU0EA+79RrgcNn5wgjbSgZHn9KgUsabt87N0PFZQ3cc+fYMbJMMomuGMDCI8YUkV9pLjDm+Nyx
 lv2lQEdTHRjJdHAylKz0CMVB3IbbERZPsVA/LO3eSog=
X-Received: by 2002:a17:907:97c1:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae9c9a105b7mr732285566b.27.1752748757873; 
 Thu, 17 Jul 2025 03:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtB2d6svKo/6A9mUZ2rEDG5uMzzawkofraPZqfK7RZcuvhyM4JVgEqjKykykasje38y8u/xw==
X-Received: by 2002:a17:907:97c1:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae9c9a105b7mr732283166b.27.1752748757296; 
 Thu, 17 Jul 2025 03:39:17 -0700 (PDT)
Received: from [10.131.45.123] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8291bb2sm1333374666b.113.2025.07.17.03.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:39:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] target/i386: tdx: fix locking for interrupt injection
Date: Thu, 17 Jul 2025 12:39:15 +0200
Message-ID: <20250717103915.331309-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Take tdx_guest->lock when injecting the event notification interrupt into
the guest.

Fixes CID 1612364.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7d69d6d7b06..7dcf2f75026 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1126,10 +1126,15 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
-static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
+static void tdx_inject_interrupt(TdxGuest *tdx_guest)
 {
     int ret;
+    uint32_t apicid, vector;
 
+    qemu_mutex_lock(&tdx_guest->lock);
+    vector = tdx_guest->event_notify_vector;
+    apicid = tdx_guest->event_notify_apicid;
+    qemu_mutex_unlock(&tdx_guest->lock);
     if (vector < 32 || vector > 255) {
         return;
     }
@@ -1179,8 +1184,7 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
         error_report("TDX: get-quote: failed to update GetQuote header.");
     }
 
-    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
-                         tdx_guest->event_notify_vector);
+    tdx_inject_interrupt(tdx);
 
     g_free(task->send_data);
     g_free(task->receive_buf);
-- 
2.50.1


