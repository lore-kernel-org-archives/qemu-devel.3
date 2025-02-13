Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BF0C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibet-0000wg-0c; Thu, 13 Feb 2025 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeW-0000r1-So
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeU-0005TU-JS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBfwZaRGoXfvVuthcliDjzbUe37ctGojDr1s126k8vs=;
 b=Op26xkEnLRNgCuQvfXPYYldZmAZUb/yVSh1wUbuaxDPuM1Hk75aCWWChHvVIOFgbSvS6oc
 Iu0FFMdik8JIKu6Lkv0ycuL8bC4TVaoAxympqTd6z0UvaxNQoMA1RtfwMWcToNy/1GmHLu
 i1wGgaRYKBUpRKjJ076N0q+fvKpt86Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-2jVJbnYvPT6KolWcah_PzA-1; Thu, 13 Feb 2025 11:01:19 -0500
X-MC-Unique: 2jVJbnYvPT6KolWcah_PzA-1
X-Mimecast-MFC-AGG-ID: 2jVJbnYvPT6KolWcah_PzA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so8455865e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462477; x=1740067277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBfwZaRGoXfvVuthcliDjzbUe37ctGojDr1s126k8vs=;
 b=GMDYnTx8JFHfo9+yFTRHPWR1AndHasUZy1t47XaS1un8+GYcoB9LC1mOBcmdVVKXD2
 CVRZC7k5i2RhA8DBjqhdYbElNnCBYGLYLkjfOqZLTc0IMr1AbV9mQ1oek1l3tbldpglk
 E868+E8eS+9fyjqjn8Su/BlxRPq+/kV99syJbRx44IYOUrQtzqIiwi8RIBr9COz/J1M5
 YdWGpgBNPPbqqv/5kpFrE8+hTww1DF2HRJzI8rF0qj+sE/rei3GH4PzoPnTyybHZS0k7
 V4SMyEjDUDbjxDqamohwu1quaDuCO9YALBhWv8/9aIh4PDuG7uDZKTntZ16rBziKFzYc
 r1Hg==
X-Gm-Message-State: AOJu0YwKiGzdWSfpBHAgJMsNL/cSdC9awtJPvzAzuTrGscLL5kg0kAyG
 Yl7JbcgmGbiAVHjmSj3NAzYr/CUNHqaRZ5kK5Pvi6Hjyw2R3b7DPhwKZ5XnrlFnByuocEROUwXb
 PXVc4CyHxWyvrGxwFvYDNWQCm9+y8IUXEDIeuPjMByj9L9a6WGOWm9yNtnnhaPiWIC0ZrJN+EME
 zsydyHMetdLk1vsifmk8euVYoSE3haxHouWBNcpy4=
X-Gm-Gg: ASbGncuBmTuYr3oq7fpVvE41UNsyxWe9SIik6kS5sT0VqHMAtB45xqQT8TlFHS1D+6P
 TG2dIDWPOcuiLKrQyzFPDk00VgXNT3JWzgm3N++tBY9W9iN0u1K2cNi/JU0VHnQdU0xRB5SGV+S
 MFKHi/QIUorTjtmVCkP11vRE/RXiDZY0hQm+tdPmNieI69JOjuNJ29ECCJqAWo+7cJ51RFCjSxO
 3Edkemqs3GJkR4JQ41aW87if1FW6wumBlkPTdo6B5mIJG+CkbK9XcmG1nTpBeoBQNpncpLy99fg
 rFQlbC1pu+xhEST/V1tWbtir+pVXcz7YWrLIWEHlkOmdZA==
X-Received: by 2002:a05:600c:4710:b0:439:3e9e:929a with SMTP id
 5b1f17b1804b1-439581b1d5cmr82746735e9.24.1739462477349; 
 Thu, 13 Feb 2025 08:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFACEKZpCfHplS5eVb49/yLPM4PLR132kFx+SfkXcxWtBlsWsmPZ3pOin1yz6YQlax/3r/Rqw==
X-Received: by 2002:a05:600c:4710:b0:439:3e9e:929a with SMTP id
 5b1f17b1804b1-439581b1d5cmr82745875e9.24.1739462476498; 
 Thu, 13 Feb 2025 08:01:16 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b83a3sm51981295e9.33.2025.02.13.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/27] rust: qdev: make ObjectImpl a supertrait of DeviceImpl
Date: Thu, 13 Feb 2025 17:00:34 +0100
Message-ID: <20250213160054.3937012-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

In practice it has to be implemented always in order to access an
implementation of ClassInitImpl<ObjectClass>.  Make the relationship
explicit in the code.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 176c69a5600..34d24da4b63 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -17,12 +17,12 @@
     callbacks::FnCall,
     cell::bql_locked,
     prelude::*,
-    qom::{ClassInitImpl, ObjectClass, Owned},
+    qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
 };
 
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl {
+pub trait DeviceImpl: ObjectImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
-- 
2.48.1


