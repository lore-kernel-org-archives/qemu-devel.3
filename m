Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5CCC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoP-0006oi-Tb; Fri, 20 Jun 2025 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoO-0006lE-4Y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoM-0000L4-L9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yl1rFXyPtvsbXYd9SVXPVaJzOj3OjnrKUbUoWlyChdo=;
 b=DBxFIuKIk0f7sL0WPAYpntPORfs4Q5kSuTSHnMSYOrgA2FPwq/Tlt/F2jYdleA03luJCR9
 w0npHDDmRrsqOfPBNeYqGgTsHnNuSwJ7IU7WarpXqrYan1fapjsu9Yb8106CkAlTxRRoWJ
 iHAlNOO7CJabn8zkpJkbO3mvhWpJkLk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-o8kDJDm4PjmjA0MWnuQc2w-1; Fri, 20 Jun 2025 12:41:52 -0400
X-MC-Unique: o8kDJDm4PjmjA0MWnuQc2w-1
X-Mimecast-MFC-AGG-ID: o8kDJDm4PjmjA0MWnuQc2w_1750437712
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-60724177a1fso2028539a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437711; x=1751042511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yl1rFXyPtvsbXYd9SVXPVaJzOj3OjnrKUbUoWlyChdo=;
 b=EphWi1Xx9WTQUAAITRFCK/QdqXKAGKE5F48Ox+qXk9SDmeI4lyL8UiBFahsSdI2aJP
 d2G0VGSlTTlXARcVrK/nhQ/EQDZeA6kjUqTDDTN5/Cxj7H3nnyaIq8qKQBP9mA6caIdX
 UJnx4UXOX2VLhiCKvOsLFPANpHdXCvcGwxHdnLv4rEwLTmi+hhZ08Wywc9xdDQ0vXTDi
 C/yVGcnVEnEox/YG9C/HTB4Zhagrz3Xx12JTeI7MZ8ZnRCrqi+8cCeGnlvPwHVWFuKyT
 wvUF/nTctrb4XagBbtQdbGByArDEaEuheGMaIboofIv3MO45MVtevfS6j9eVINFPOm2q
 QasQ==
X-Gm-Message-State: AOJu0YyGEtgQHf0W084QdmP1D6ORK6GDuhyL4gANmBueZvtCbefmGOoI
 tB5EYj/huo9XJ0HkxV3Lu/+1LPUHh/cUFqV0KdfyS+I1DaQYDbVzGYaQI0/vK9qCOblSePlZef/
 q+iWC4BAf38XV6Qf7/3Pe2YUZ3Xo8jvJpDikvf/x8Ut2fRk5qc9kevOWs2lABnXzrfL2tLWm02J
 vmt/afOJzauUYmr/9/ud30K2F0+O0WFrg599mDx1i0
X-Gm-Gg: ASbGncvIkAL/P1hBodYQ7ETy60xvydCPa4NHIBn9oG4zeP8fhO7gPo28iGobEvog9Pg
 UgV+UD8yu6pW279lhpBRuELmg1Y+5SAmjnRP7petEpD3EZPd/ekPIF+ZVrE4TV+j97w/aaXytKj
 48cxcB9AniSKUBv/+UFXiWUCAuacMs0ALnJ2nj5CLVyFGvAX/XsbsC6Zsq7tBjmuxnUYjBc+qzI
 UL/K2E0ws+5lz8Vqp004eusLa8g8BVveX3OAD0qfDW9ZgUkpcW//1/zSd96VQlxfcVKoSfZG9OJ
 2pvwvOuJXMDxjVIc1jLP88rI+Q==
X-Received: by 2002:a05:6402:26ca:b0:608:47ee:dc4 with SMTP id
 4fb4d7f45d1cf-60a1cd31b60mr3003099a12.23.1750437710577; 
 Fri, 20 Jun 2025 09:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQYOA+pZWoCsSHDbrPxRwqSYQOuWEAP/XL25oCkoRWsBmzZNi9YEneEICw1WM9dQMT5Bbd2Q==
X-Received: by 2002:a05:6402:26ca:b0:608:47ee:dc4 with SMTP id
 4fb4d7f45d1cf-60a1cd31b60mr3003079a12.23.1750437710111; 
 Fri, 20 Jun 2025 09:41:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a1857e8f9sm1641292a12.32.2025.06.20.09.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 20/24] i386/tdx: Fix the typo of the comment of struct TdxGuest
Date: Fri, 20 Jun 2025 18:40:48 +0200
Message-ID: <20250620164053.579416-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Change sha348 to sha384.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20250603050305.1704586-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 04b5afe199f..8dd66e90149 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -40,9 +40,9 @@ typedef struct TdxGuest {
     bool initialized;
     uint64_t attributes;    /* TD attributes */
     uint64_t xfam;
-    char *mrconfigid;       /* base64 encoded sha348 digest */
-    char *mrowner;          /* base64 encoded sha348 digest */
-    char *mrownerconfig;    /* base64 encoded sha348 digest */
+    char *mrconfigid;       /* base64 encoded sha384 digest */
+    char *mrowner;          /* base64 encoded sha384 digest */
+    char *mrownerconfig;    /* base64 encoded sha384 digest */
 
     MemoryRegion *tdvf_mr;
     TdxFirmware tdvf;
-- 
2.49.0


