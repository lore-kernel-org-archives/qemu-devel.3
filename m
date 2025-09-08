Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F6ACAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTZ-000766-Sl; Mon, 08 Sep 2025 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTW-0006yA-69
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTF-0006De-4T
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bwUAhVdBpUgtCk8obIBmX7qJCOAFnmbxJSlC0/B1XI=;
 b=Dcni/ExFgt8UTmv36rr4NgN9lgX0WRtHLZv3FQxrUwyW6Xt+8q2koBtJ8ap+XDZI33JLKV
 ifVo97KI2GCecxhEePtAoydOcRz5oTSz6vZQwcUmD9CbtGOak0nn9niJXZg9nF2Kfz6KvN
 pbH8YUu4b94Fr4pJqz8LQtkxbfx+5pA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-qhpIGAunPWOagF0u16yNPg-1; Mon, 08 Sep 2025 06:51:27 -0400
X-MC-Unique: qhpIGAunPWOagF0u16yNPg-1
X-Mimecast-MFC-AGG-ID: qhpIGAunPWOagF0u16yNPg_1757328686
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45cb604427fso21860245e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328686; x=1757933486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bwUAhVdBpUgtCk8obIBmX7qJCOAFnmbxJSlC0/B1XI=;
 b=syoj1RVb1Lg3fLTYVpkz15kmpz/YOWCCJ/biTvp/jhO4wqfXnO/d6piTviNQFOxXzo
 dNBbug62TNuq4vJwSXJtooUAQyGkRcyb+OSyj8F/g3TP8FK3ZAWd8vkPg14TyjwY5hoC
 kPKC5yn0J4eUk08KOp+b1X5cEJLIh7n7Ar3+kowHJoY4FULSI8DnYpTwUk5Rk/LGB6V8
 s7Tp8DVwWCgy/DI1KfkQxD4G4QoIdZVzCnwjXhs2f4c4JZZT6mt2ZLP4vX2PJhA2IXnA
 L9BKKGLljTz6xsIwxS2Tb2l4FK73+LejdKNzxdMp+arPcs5Iez+UdWNryHAH8fFObqJu
 Znsg==
X-Gm-Message-State: AOJu0YyWkzvgdepMEyB2onA3vpyH4xI7HRkRMtDUrr7h+vylV45Co8Fo
 6Mlj7yHTUOgmyk3oPMN3pHwH7JNmw/ZY9NHgbQ0MMRZncmn7bI8QvLONEm58R8VBBI/0lbWXljz
 HmL4gz0jB2zx8uJI+bR0UeCL4QmFLNU4mYDN60TfOYoGZ7YU9Dtkp/e8itP3JYN/NyVCRsQiAhA
 q2ulvX7gyngAMmkSQUdsrJF428i0KtkT/r+UG3ZQ3i
X-Gm-Gg: ASbGncuroEBK6S/xSQCDa3Ma163pklUavWmvK4OVOgdbpmA9f6JsIJjdwnIX191AYE+
 KmsKfRBY+I1wcOt82VduAbpjEg1/Wiyhg4tDrX6g1FDdJnpI3ZBqWk8bx+AmPKsbYmVYylmN+ab
 Bo4/Or4c3yEEZWT7n7RtS1HW5s9+rSrNjbsBUYmLSLlvXlviQ6Kdaf+zZQEN6eIeP9jKTGyfJi1
 Af4QsZXmVGnajf9i7LZO2nmikr4mEDKAhvB/kTOeNCzES9ErTZGOJ8h0k8PV/fbnHPdh59CL44Y
 4wopHR0DS29aBVIwPDXLZJnxXpyZ7w8kqzeXkiEYkCNxFEev7W3ehdhZbC/GTzZVZX4e6iHNQic
 h1R7N6hxGIJnmJ++6q7gvqgRWMDpWdXdyi1mhA8Cds+k=
X-Received: by 2002:a05:600c:c8f:b0:45c:b55f:466a with SMTP id
 5b1f17b1804b1-45ddde9295dmr66872925e9.15.1757328685753; 
 Mon, 08 Sep 2025 03:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaUX12ZIOON5mvp6JhJf5fvkGq2Qm/GoQi0bVUFt09FE5o2wdB3lJDmALoddcN5Q1H+MttqQ==
X-Received: by 2002:a05:600c:c8f:b0:45c:b55f:466a with SMTP id
 5b1f17b1804b1-45ddde9295dmr66872505e9.15.1757328685260; 
 Mon, 08 Sep 2025 03:51:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e2a6515c45sm13515151f8f.55.2025.09.08.03.51.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/33] rust: do not inline do_init_io
Date: Mon,  8 Sep 2025 12:50:05 +0200
Message-ID: <20250908105005.2119297-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is now possible since the hwcore integration tests do not
link the system crate anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/system/src/memory.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 02aa3af7b13..4b3316bf767 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -136,11 +136,6 @@ unsafe impl Send for MemoryRegion {}
 unsafe impl Sync for MemoryRegion {}
 
 impl MemoryRegion {
-    // inline to ensure that it is not included in tests, which only
-    // link to hwcore and qom.  FIXME: inlining is actually the opposite
-    // of what we want, since this is the type-erased version of the
-    // init_io function below.  Look into splitting the qemu_api crate.
-    #[inline(always)]
     unsafe fn do_init_io(
         slot: *mut bindings::MemoryRegion,
         owner: *mut bindings::Object,
-- 
2.51.0


