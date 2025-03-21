Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D59C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFS-00048J-Ny; Fri, 21 Mar 2025 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEV-0002jd-P0
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEU-00074U-3n
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cqHsfdkAuuLT5axwfe786tbbJbT6rXGioO14sbzrY0=;
 b=GxlqnzJOtELQp3ppUPJWPKPYPceMrv4q/xBXuxdvxgsi5vyRtPfKu3A/0Nr6gxL5R3crRw
 yozM/f/wcthtNhWjCmpe77/34PD3kXYRjczXyKAX8erYFJOrcKt/pmuVq1G0BY/PWGZo8p
 qsGrKGSFpd1CW+kk5EX8qQ+1vCO2AIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-lbt8mpTOO1-7Faj15FrYzA-1; Fri, 21 Mar 2025 14:36:32 -0400
X-MC-Unique: lbt8mpTOO1-7Faj15FrYzA-1
X-Mimecast-MFC-AGG-ID: lbt8mpTOO1-7Faj15FrYzA_1742582191
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso1270128f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582190; x=1743186990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cqHsfdkAuuLT5axwfe786tbbJbT6rXGioO14sbzrY0=;
 b=j1GHaV+h/bZiCATYejsFM413/1M8SKSTt3m1P1lXFaa3QPIjdk1pF8Kpg1zn15Ov3Q
 dALLNf62PcYAW5szDRgiCX+E9KISeBHmaYtGHtf5D6+cmIghiupN3ZMt+q3uCet+CWx2
 VRfGzkKJvD08JyGH2bCR2aQC1wN//zJ/92Y61TMHQjildR5I2HDTokspy9TXi8ieQ8R/
 1YFQUknDoCPxFnH9RKhxhTPE5nkjijC4qHmm/SBRtNl+vuLF70A9c9gEhJS+XdB9aFO4
 e84JWuoG7SZbsELMJzOJAgMMpcJijJBP2+SxayKpwg2k9Yowyx6Kn5y7UpaRwux0w0Tn
 ROtQ==
X-Gm-Message-State: AOJu0YyQnATgoki+x99Y+VAebFzz3dDlfnNw0iMz5J65Qrw4vn1FHKCx
 Cz3wSmSX6IcTCa3ua0cA7D5FFipD8/zdTNeuEJHroMCjo6kITiEi9vRfvo2oaYKu1kBuF7gOh0X
 lBk+OTmbfy/wS2FIh4mK4NMH48fYmxwObgFKozyBW/PlX2w6DvWRxwY96h9u5UV4IGuAblOcNJP
 rHFgazQmz0YKBBxugO0Rk0eLtWJ9AzZ8bKBOKi
X-Gm-Gg: ASbGncvFymUroBeWCdt7yZ53KquGfGc79qeoTF/mwzc+u2JcrraFF8vf+R6tutFPWN9
 onSG8tl3V6DZdIMQZ1ccW4qKczOyO/9uHkRioklmQkAoxbDFtjhzYNeUhkE5GyIAjD4EbKRYU8h
 eA1QBVDv56Qfso+hOPK1b/dxkOSWHEJywVejP6kbOFGPFtJeMVm5GoURv7trQ6igrhVYP/bXS4a
 Mu6+wW+RxH6oV8c1LU43dkwseVZji+UmjNe2jVnA5blyr4mgvEVc7JB8wl0Fi4JwavCmbxMZwsD
 SGTOMY70+qd+RBzHG+1A
X-Received: by 2002:a05:6000:400a:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-3997f8fc301mr5388188f8f.16.1742582190212; 
 Fri, 21 Mar 2025 11:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8d7QU7teNz4DARB4i3sE48DSlftgjQa9P+2f1sOKXWkmLlrygDpwf0BG8QCXuJyMdeZ8txg==
X-Received: by 2002:a05:6000:400a:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-3997f8fc301mr5388165f8f.16.1742582189663; 
 Fri, 21 Mar 2025 11:36:29 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6651sm3031201f8f.75.2025.03.21.11.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/24] rust/vmstate: Fix num field when varray flags are set
Date: Fri, 21 Mar 2025 19:35:43 +0100
Message-ID: <20250321183556.155097-12-pbonzini@redhat.com>
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

Array type vmstate has the VMStateField with `num` equals its length.

When the varray vmstate is built based a array type, the `num` field
should be cleaned to 0, because varray uses `num_offset` instead of
`num` to store elements number information.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9533b1250fa..e3233303f20 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -275,6 +275,7 @@ pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMSta
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
+        self.num = 0; // varray uses num_offset instead of num.
         self
     }
 
-- 
2.49.0


