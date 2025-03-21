Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77540C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFs-0006fc-VC; Fri, 21 Mar 2025 14:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEf-0003CA-7H
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEd-000768-Dt
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVdKkjeQhfHMzxEC6hOIsA32MGrKnUfZiumo0Q4dgjU=;
 b=NONNGcdy3SUUHbFzCfG6Kh7+0lR9+KJBgIEMilqbwtIWz6q+0JSdfGNi2ODHYejCIRoHUC
 1QXFwMzrfaYfuuF23aIcV3sUGJlQ3nsPbUuHWp5E9RDnaiTCHnQ30CUn/SER0B8WHEC4R/
 cHsX/f5zHuy1zKbYk32F0PAJgMvr+LA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-vTuxltroNt2fXJMvY0dOCA-1; Fri, 21 Mar 2025 14:36:44 -0400
X-MC-Unique: vTuxltroNt2fXJMvY0dOCA-1
X-Mimecast-MFC-AGG-ID: vTuxltroNt2fXJMvY0dOCA_1742582203
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1023510f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582203; x=1743187003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVdKkjeQhfHMzxEC6hOIsA32MGrKnUfZiumo0Q4dgjU=;
 b=WRkT0xNMJKZSrjNxGX7AY3tY4rNo4ducDugQeV4Unc+bnLw4K5UZgHjc74yQFx5Lgx
 3Yvhah+iCv/W733YNXQaoR4TRq9vHA4za0i0VORCZPV5zYNZQyARdYQThLiehQeYR2uH
 zkC1+IELrZF7//WoaF4xGhmc4gdR1SgYTE2uvSrb6lqI8R2vZbNmKypIfg0scSffTY2M
 wj+VXgmE22H5Rf2sJ6PU4yMF7fwCg3SpYz21f6a9H7G7ys4Md2ethbWg4qFrUVGRSNGB
 BO/EoIYveHGVLkIyfOSxPnXhcQYhu++uUAYWelrorgTWBMTi2EvMntidumUqJTrVXUxC
 wUSQ==
X-Gm-Message-State: AOJu0YydFhgiYbdCrFJ1b4cZGprnmFKufjvRZQaGjQwodYijf8wJwWYk
 xC8JCckz+UKPdJ8nvh+lhPyzjYBvXHxmNY7pt2VnMqIP0PeACOJe/5qxIUMclTLZNbTPaj1wFuv
 LWiJjW7z4x33XeFRf3aU9MBrodIYdhb90CW8hbe4vuAjOHF/s3vT993ByjPaWhAMGVQNMLAgOuF
 ESVPuOAQRZ0LjVAYdJNBhmJaHtcLiQ378LbZnA
X-Gm-Gg: ASbGncvpgP4Pn1xOVdXxt4Pxh1SD+2jnrccrub4SIDN34C8bVCkQbt9V8r6dekanAhQ
 RFKLEzEdCFquu8fkb6WWlXoDd8Sc56c8lb1vkq/AS0MdtLS6FZTAAp7IABEPJoVPQicvHOwmi5G
 tUzYzVWI3JB+8pAUVgWFrTI24vgfQ8oI6q1nCvMZgt5OOPY2atgykqg0R5HmmXawh/liyif7zye
 Dkjan8OM0SWbQBZkefQdEPqhHsjZbLETg26sPDCC9PivAw1QPpUzLC61gjlboFy7F8qQzqFt6LE
 sjH5DG3spboLvZKdiVo1
X-Received: by 2002:a05:6000:2cd:b0:391:39fb:59c8 with SMTP id
 ffacd0b85a97d-3997f90d929mr5686312f8f.25.1742582202592; 
 Fri, 21 Mar 2025 11:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTzXCE825xF4rRIMIWWoNHokGnDq05qU0TW5F6W8/u0Bhk5Cf91sJA9t45XRzdOE5iUkGJGg==
X-Received: by 2002:a05:6000:2cd:b0:391:39fb:59c8 with SMTP id
 ffacd0b85a97d-3997f90d929mr5686288f8f.25.1742582202048; 
 Fri, 21 Mar 2025 11:36:42 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6651sm3031627f8f.75.2025.03.21.11.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/24] rust/vmstate: Relax array check when build varray in
 vmstate_struct
Date: Fri, 21 Mar 2025 19:35:48 +0100
Message-ID: <20250321183556.155097-17-pbonzini@redhat.com>
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

The varry of structure created by vmstate_struct is different with
vmstate_of. This is because vmstate_struct uses the `vmsd` to traverse
the vmstates of structure's fields, rather than treating the structure
directly as a well-defined vmstate.

Therefore, there's no need to check array flag when building varray by
vmstate_struct.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 792a74fdfc0..0b5af1c90b1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,14 +275,20 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMStateField {
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
         self.num = 0; // varray uses num_offset instead of num.
         self
     }
 
+    #[must_use]
+    #[allow(unused_mut)]
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+        self.with_varray_flag_unchecked(flag)
+    }
+
     #[must_use]
     pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
         assert!(num <= 0x7FFF_FFFFu32);
@@ -454,7 +460,7 @@ macro_rules! vmstate_struct {
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
             ..$crate::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag(
+         } $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
                       $crate::vmstate::vmstate_varray_flag,
                       $struct_name,
-- 
2.49.0


