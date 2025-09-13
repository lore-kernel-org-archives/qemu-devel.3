Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADCCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLN6-0001tE-Ie; Sat, 13 Sep 2025 04:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMn-00016w-Sr
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMm-0005FY-4U
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EApp4ovBiWyPxOCjCRzu1kr7T39LmQMZCfnyNBky3GQ=;
 b=PLffUqQgYrVI/nZ1Ne2mPdG5Nur3FRBEiF13iVwQC6UcCCLcRXiHPUcsegCPxDqyBpH9WH
 dxflRzzW4oKVL1MNY+ldFgiwhPKU4hAMYYlPTDauVC50hO8FOdjsztDENfVgahg895ly7k
 wB6vPBEXfrR09JQl2LIzMMVHPWrv5i8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-VgOccC89OFOcOqmiUs7BYg-1; Sat, 13 Sep 2025 04:12:11 -0400
X-MC-Unique: VgOccC89OFOcOqmiUs7BYg-1
X-Mimecast-MFC-AGG-ID: VgOccC89OFOcOqmiUs7BYg_1757751130
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dd9a66cfbso23972355e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751129; x=1758355929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EApp4ovBiWyPxOCjCRzu1kr7T39LmQMZCfnyNBky3GQ=;
 b=bJzHmjHqRTeTN0sPVwyY9+3RIILjjMbduBVslOiM0oxIamyZ6Sa9AV4P+r5wbFLtBl
 VE5P1kmP0T94kFm0TkMnk+XhkVFPtjpSQiprxe92cz/yeMupnG/9oWfGhhWOAGhLVfeG
 02CBZlB1OEHvrbRt8JeBE4GwyTI9SAK4hCIhhOIEtzc4moMHng5eftaKa/L+0KU9L1WH
 pFaaovSTMTwjXZyRi+fJizgu0wZ/jtyjJ0wa4oDUXEkpAorMOYTaJ9Z4KAL7mzmtCywt
 sm/WNHo3vdx6I+BgAICILYFkz5n62OkCfwHw06G8D6KvIOm1N2hZVtif3GsGEgmSmbNm
 UsVw==
X-Gm-Message-State: AOJu0YyVRL8jGh+lSMrRY3IqmYCobeedJ5tQd24SYhzAnMrInWMBGFTT
 q6rNb2J2Xa+bVMPCS6hUzRBlmJK1BYKG40yeRwzic9ScWmarcRBdB2HDq1D6fEDyKs76C5/j5C9
 AcsDFS7B46oXoHYszqK+ImgD+S+mnGJvvjsnO5Kv7vd1Eocw5GLnyMcA+2B7A9HTDQ1epU4Jiwl
 ejtsmfMvZA0JvDiC5v/CAHQ8lvNLJDmM8LfrE2DtXe
X-Gm-Gg: ASbGncvxJujszDoXWZMxTP1xTkx6Q/dHz0EwhyoeN1dGNTWi/wQ88jBOLqFYXYrnHpF
 pT59MJ17SatL6yH+ZTF2PGJg5drx+mxEqTnnBw3ysiMrdyLV4tHDgbxP5pRBB+uA3Bt5WuhTYdi
 C4+AM5UkEy/KtVtc0DpHceRIsCP5c6UasBqNTrMXq4Opyx1mYUDzWqfS1tF8XoTeqsZdAzaON4y
 q43hVd6d2xyRcnBAomJ6UC/K49e0qCRUdDWA6ZIQQrldnQ5vnRrFNhYxuk4KUpL1HL+c19u1wek
 VNSmjGz6OWuOCuopKiPu0IgiP8ke4rN30avuvWAtk9LjjqxiZMuNLlYxDbAGvjc4izjiP7/XJFC
 cmfqy8Mkw5ZHbNGSmxuD4LRk8aNGpXihAvWDizc5VsMU=
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id
 ffacd0b85a97d-3e765782b5fmr6380120f8f.5.1757751129401; 
 Sat, 13 Sep 2025 01:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvGOyAXBiVSRzDW698WECxpV6wbkkMYtpejitISc10Hmrt5mDtxcS26UMkMdwruekqqZyD6A==
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id
 ffacd0b85a97d-3e765782b5fmr6380093f8f.5.1757751128985; 
 Sat, 13 Sep 2025 01:12:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607d7c0dsm9563192f8f.47.2025.09.13.01.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 52/61] rust: do not inline do_init_io
Date: Sat, 13 Sep 2025 10:09:33 +0200
Message-ID: <20250913080943.11710-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This is now possible since the hwcore integration tests do not
link the system crate anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-34-pbonzini@redhat.com
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


