Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F57C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WdX-0001gh-7V; Wed, 23 Apr 2025 05:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wca-0006BX-Sj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcY-0008R3-J9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqeKYtmD/3cS14SfmlP9amKWqLAFVBdD07WL7so9K3w=;
 b=YX0hSRrXAfKyx+kuRwV0DoqbkmrF7sYNhs5YfTZnOzNj+8TJ1UlktqMw/pL6RMuXsWX+za
 gs2B/cwJMngNpLHVXLkOOLaWMlQMfKelEc8JZvoV9q0Ua2dWPea3UNVI2HZBkf3LZ8YMD0
 5iKL7UnigCInAK2yp3b0CxMeZU/a5qY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-nLUaF0mmP123m4l4E4eOew-1; Wed, 23 Apr 2025 05:42:20 -0400
X-MC-Unique: nLUaF0mmP123m4l4E4eOew-1
X-Mimecast-MFC-AGG-ID: nLUaF0mmP123m4l4E4eOew_1745401339
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e5d9682f6eso5664825a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401338; x=1746006138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqeKYtmD/3cS14SfmlP9amKWqLAFVBdD07WL7so9K3w=;
 b=BPbjLPgFBpORfdJp1jdd5FkfApL4kP61P2+HwgKq8UErzumjSXt2tO87/ZEYfd8/bN
 rWgF85uSGHEt6Jcov1DQimNx7OcBc82W3XSMzvfCwmd8VxXnfXfgGDJBj1t+XnJx91VP
 vTkheoNDCTRZXbo79kX3ecL9TUbZ8so1Ta0B7wSExov4IghZ2MxByX+YSpMpvz9OaVlP
 K3pUanZj2YMe2HbG19KA8LuO4aUi1JvRGS04juqaB3qBcQkk9v7opiImNYCvn3R7+qSL
 of+dTlPhWAWe9d/RmmjL1EdUSv7a9io6B7NUbs/VGeBgACXQOLUfZRS7Glq5vB8s5By9
 t2fQ==
X-Gm-Message-State: AOJu0YxzA1g24KSo5FVJ1+ZJd1iZbr5Qr6GD+0bKgMLFctqXa+anFVag
 wMVAuq7B7l+JS9vYcwidneg0R59WWCIYdz4VM/JMAEqTyvf9+NWwfYWFq7twfkoZEflER8x0Gn6
 ii3FUpnRemwOSMBPMDz1f6XajPrLeMDjD9z2cox0jBbqaHgNOCtS8qYRxHY0db2+oi8BFd632TJ
 Gm3orhSmsdQNwrlMpPHGCnASuxqKusbOZPGzGm
X-Gm-Gg: ASbGncvzvto+dBCYe7N8bLeJ9TPg7F1CudvlExoz+Q6DW9lTAymOsq8kNjLrf9BfFsH
 EqV677anfnQGrrhpVEC9SXTHHTtusf5ulNasxh8f9G6DXnPg631IjlMo2VJbENzvLJCpOIddR/o
 ERA8M4f7pyjecdQGhqd9yCvh8qHybvZCCi01T+SsGvrbv/3Fkp+YV55O/ZUgXFnY2R1F61MoKqP
 dIdKGK+kUrfXFuAok3r8sScsFfe1s1y54aNmzyDj9IMm4LrcGkRp9noz/3nMfAGNndFwzG3O8f9
 7agWFie01E3zdSeu
X-Received: by 2002:a05:6402:4402:b0:5ed:5554:7c3b with SMTP id
 4fb4d7f45d1cf-5f6285eca1amr16149996a12.32.1745401337929; 
 Wed, 23 Apr 2025 02:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeySuAmObRK2EFser6E5KhuY1QofSvAa2LMR5gzE93aNUvKEymdXQA8Yu8v803qZIxP4U/Jg==
X-Received: by 2002:a05:6402:4402:b0:5ed:5554:7c3b with SMTP id
 4fb4d7f45d1cf-5f6285eca1amr16149973a12.32.1745401337481; 
 Wed, 23 Apr 2025 02:42:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625833a6esm7224199a12.53.2025.04.23.02.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/34] rust/vmstate_test: Fix typo in
 test_vmstate_macro_array_of_pointer_wrapped()
Date: Wed, 23 Apr 2025 11:41:02 +0200
Message-ID: <20250423094105.40692-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Zhao Liu <zhao1.liu@intel.com>

test_vmstate_macro_array_of_pointer_wrapped() tests the 3rd element, so
fix the index.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index b8d8b45b19d..8b93492a689 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -383,12 +383,12 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
     );
     assert_eq!(foo_fields[3].offset, (FOO_ARRAY_MAX + 2) * PTR_SIZE);
     assert_eq!(foo_fields[3].num_offset, 0);
-    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_uint8 });
     assert_eq!(foo_fields[3].version_id, 0);
     assert_eq!(foo_fields[3].size, PTR_SIZE);
     assert_eq!(foo_fields[3].num, FOO_ARRAY_MAX as i32);
     assert_eq!(
-        foo_fields[2].flags.0,
+        foo_fields[3].flags.0,
         VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
     );
     assert!(foo_fields[3].vmsd.is_null());
-- 
2.49.0


