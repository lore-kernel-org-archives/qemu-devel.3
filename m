Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A2EC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhF8-0003Q0-Oz; Fri, 21 Mar 2025 14:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEZ-000342-Bo
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEX-000751-JO
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReqKjgFzNUJo0s5zSYwcl94ZW9nD5xC2C+v/UzPjG/k=;
 b=B4s8oKAh02M+kxI7UuMYNj7A46dPuDwxo0Xjz5MaWDVa7lKfuCQ659mI2fSb6trdx/HXFB
 B2JrhP5ZkC+uWkh1bzh/92KccJN4TSIAcqY4b3pjx/p3BCR+IE+5L2P1/1W0s+w03buro8
 JC2F1QOH/GxsHXUyk3idqWRS7g05JDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-iKGvHK2INPSyG3p_ukGWMw-1; Fri, 21 Mar 2025 14:36:38 -0400
X-MC-Unique: iKGvHK2INPSyG3p_ukGWMw-1
X-Mimecast-MFC-AGG-ID: iKGvHK2INPSyG3p_ukGWMw_1742582198
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so1171817f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582197; x=1743186997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReqKjgFzNUJo0s5zSYwcl94ZW9nD5xC2C+v/UzPjG/k=;
 b=tTNQcMdIoFeeEmqWWv8hATsXy8+NrW5Z6IKVghMIUiqSQDDzIDSU4QwPDShqGFaBrt
 tc6FusNBwouiFVle5zh5punFyiJ2ZGiCyS1qf31N+D9rG6nsxX4fiIYYmGincilrZAyy
 4YcPdz6WyqmQ9JeJSwj0JuJ4swuAdvhLYg8POkvAw9nGUqtwLDj23GYXwfTMU616CMzB
 2LdHHIopTuxaeD72HQsmsgQlOeRuWxdKieQDYHJOLPhbV1jRb62jfJdEHErcLzsSllJJ
 zRZJ4zLVpzZWDTTc0YI5lhzIFlEQPoi9oAv8QXfrrnhbR6awRhxlsXrI1y7BpmcJVAdT
 HQTQ==
X-Gm-Message-State: AOJu0YzDBEA7dzcJUIVtVL7VMtFKh4TMIb7GjcGRa82WT+1r8y8TxL5B
 FtVjmsJ900wNvV5iatrbrodVuGSogoapMGFeuO/qCS+bXEMRIME9wo38V/4LLgFVNb5yeIgnmyF
 6KZTuSg3r+NPuc3OilnlAEjoWO1H2bl9bwLG39U4VnhrjtItyMrmD9mtxclBcekEcxKZLNl8DGv
 iiynIXiBVU8EL9UItoErTodjSZPG1E7HXmqFdy
X-Gm-Gg: ASbGncv/omqkqUoHL9TMKSiqx00PxjACljt1fv31IJNhVw4zqSOPjc2Y2kpIR76O46s
 6FuI+oWcdt+IzBTMKQ8Qd/8sQtjZs9gW5XswbwlpZF9jaaRVDJmllsX+aRZjCONcKRLzWXRa2rn
 X6Kf+2JdqUaitdWiSe/KkRwWbRO5Zy6WvgKQqEEi/l7qm1flpJpaeX7kAKvu3CQE6Zs2J/ZsHmF
 BBjesO1iawioVjgY7/AA66EM528Aa78Eq+556chek5WvtDDd+Q//Vrjbgw3M5Q+XBB1j62qs5bT
 tYj9rCms5a+vwvBBL2wS
X-Received: by 2002:a5d:6c67:0:b0:391:4835:d8a8 with SMTP id
 ffacd0b85a97d-3997f8f97ecmr4924347f8f.1.1742582196599; 
 Fri, 21 Mar 2025 11:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXbFNu7+7WzN5HaI+juy3znczCMs8jaXuwkAZypqcJjzSl/0H/4JvhWXj+AWKF2WBsBdUdRg==
X-Received: by 2002:a5d:6c67:0:b0:391:4835:d8a8 with SMTP id
 ffacd0b85a97d-3997f8f97ecmr4924328f8f.1.1742582196128; 
 Fri, 21 Mar 2025 11:36:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdac9dsm84409445e9.30.2025.03.21.11.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/24] rust/vmstate: Fix "cannot infer type" error in
 vmstate_struct
Date: Fri, 21 Mar 2025 19:35:46 +0100
Message-ID: <20250321183556.155097-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rust cannot infer the type (it should be VMStateField) after
Zeroable::ZERO, which cause the compiling error.

To fix this error, call with_varray_flag() after VMStateField's
initialization.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9d9cdda993c..3be3a7260fe 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -453,13 +453,15 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
-            ..$crate::zeroable::Zeroable::ZERO $(
-                .with_varray_flag($crate::call_func_with_field!(
-                    $crate::vmstate::vmstate_varray_flag,
-                    $struct_name,
-                    $num))
-               $(.with_varray_multiply($factor))?)?
-        }
+            ..$crate::zeroable::Zeroable::ZERO
+         } $(.with_varray_flag(
+                  $crate::call_func_with_field!(
+                      $crate::vmstate::vmstate_varray_flag,
+                      $struct_name,
+                      $num
+                  )
+              )
+           $(.with_varray_multiply($factor))?)?
     };
 }
 
-- 
2.49.0


