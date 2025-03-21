Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C18C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFC-0003UX-AM; Fri, 21 Mar 2025 14:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhER-0002Vc-2q
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEP-000741-EM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+3mEWFo3Ciw+4x0yx2aFFWrzswVsxu+6KtQ7mPDXTc=;
 b=UbVf82Qj4wpNcVEShfq2DgC3X86BCsDU/oZ9NpSfc6ok+BF9uVZ0FDwo6y1EWrPWcCa0XP
 RJvIJnf3o8FJtiFv74M779ZzvmD+BPvU0TVmRYYHO0axahkyuSEkCA8KWtuZkWbmOpq/OC
 N+fkXMWg2ZxUn4sm23Q3nO57QW5CrLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-WhU5_diMOe2FFqLQOCE2-Q-1; Fri, 21 Mar 2025 14:36:31 -0400
X-MC-Unique: WhU5_diMOe2FFqLQOCE2-Q-1
X-Mimecast-MFC-AGG-ID: WhU5_diMOe2FFqLQOCE2-Q_1742582190
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b45so5509655e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582189; x=1743186989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+3mEWFo3Ciw+4x0yx2aFFWrzswVsxu+6KtQ7mPDXTc=;
 b=ivtbDfoiZR/j28QQNLuxDwDc3VKt9MzmxlYxA7cmMpMPO49dd+q8fQSwS6iTcO9sLK
 AmG4fxT4dDceZjJkITJq8lQHj+75bDiwr1x1N28P40z6fpB55pi6PfsK60ZPN+ywqv2Z
 0E91gXdfm17ITEKyYlZBB2gg5F//OcLm+yjSjyMwFeex74BYHWb60dbzBVU6iEGNrqlv
 ULxQrvkQPEWQxV7IlyOMLhYJbU9Lcj9/avFnmaStqG4vePQMpmiLpY3iIZwmT0DOEleD
 Mti2AxmFz9k/Og5k74ze5TipCt02SLMgK9IyR/aEKtsHL5EseJ0X80zVeG0SaxZMWKiU
 1NWg==
X-Gm-Message-State: AOJu0YyB2CXA3gZFt8WcPnRcz2n7Egf1YLjuMed0e2Tealg5ZzR2HGMe
 UxNULzRjs+K9ZxNAhW6jeOyPcuQH9EsbkLwLaZrQ7S98go6d2bCKbivTU/hVHQ9NUeCKGF68CMz
 kq9gH/7uDWgCKLuhUGs8LzPJmtZ8COBfjneQqSWr+wNIWF28ahpCdSBKbzqP0Vdj+NmRc8tE5Jj
 ZU48h+dVRJPWMnQnZHAf4xFeeU2E5NbeFTBpbY
X-Gm-Gg: ASbGncu0tN16Yb2bufoZGKcH0igB4S6J902/VGTpqZfpruALbShBV2S6UGfQTjQmGvE
 TlDlNnBHozOcntjpDgUyPbb8s4SGOzYYhWgAO+Jt/0BcAs7QAlG3H+HfenYchSA0zhq0ygiVBQg
 Pl9cx8BTzJGkaxaZtynWymYOEFFSDe7UjVMrPp7w4VcBJho5WOOfzSKaFK97FWwM6nfKfoahDab
 zpgW2E/YD+aeHEfEuO/Bet677/LpICBHgJEvTF91EsYpmhiTFTyyLYF1vdHDbrhpH5CV7o2ajKS
 DmS1Gu+ujYR03Mao5Vqj
X-Received: by 2002:a05:600c:3b9f:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43d509ea8e7mr42966085e9.10.1742582189042; 
 Fri, 21 Mar 2025 11:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJqNyRCkzfxPCIMKt/iaR0qyoOwkQqhjlp0pgJ7OF1urXv6qJChEHWZxUhKfDu746LgAHDlA==
X-Received: by 2002:a05:600c:3b9f:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43d509ea8e7mr42965865e9.10.1742582188586; 
 Fri, 21 Mar 2025 11:36:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm3023335f8f.9.2025.03.21.11.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/24] rust/vmstate: Fix num_offset in vmstate macros
Date: Fri, 21 Mar 2025 19:35:42 +0100
Message-ID: <20250321183556.155097-11-pbonzini@redhat.com>
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

`num_offset` is a member of `VMStateField`, and there's no need to use
"." to access this field in a `VMStateField` instance.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6698dfe7aeb..9533b1250fa 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -208,7 +208,7 @@ macro_rules! vmstate_of {
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             offset: $crate::offset_of!($struct_name, $field_name),
-            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(num_offset: $crate::offset_of!($struct_name, $num),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
             info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
@@ -440,7 +440,7 @@ macro_rules! vmstate_struct {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
-            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            $(num_offset: $crate::offset_of!($struct_name, $num),)?
             offset: {
                 $crate::assert_field_type!($struct_name, $field_name, $type);
                 $crate::offset_of!($struct_name, $field_name)
-- 
2.49.0


