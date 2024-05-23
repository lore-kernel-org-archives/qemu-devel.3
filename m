Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28286C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wt-00083k-Dl; Thu, 23 May 2024 11:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wh-00073B-Db
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wf-0004tg-CR
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iN659yH09n/hdzOY/L+ozt0Io3bES4P00+IzSZFQwVs=;
 b=Ui8FY+rZQDHunnbxVJAX6txfbz4S0KL1tp4bQ7M4F+MYk/BTjSUXgCFGQi6U85sgkYds9b
 K+rETibc91dZhDCHSzNcOUB4EsjDt2gw1ClADSfcef/a7axPmzbRWbSRq7Y5xDHs6003W4
 k4c4MKApoSc2IzPiOYj6f5UA5mgCP1k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-ITCodQUfMRmEklpA3Qygbg-1; Thu, 23 May 2024 11:01:26 -0400
X-MC-Unique: ITCodQUfMRmEklpA3Qygbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so236264666b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476484; x=1717081284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iN659yH09n/hdzOY/L+ozt0Io3bES4P00+IzSZFQwVs=;
 b=qApHr08acf2dXq84KDY17D9m1mnk4hgKzUp+rN3Gut+2H6wjnAhrxNBMHw1rIx/GkB
 deLD7ppu2OBKSWRcI9aM2521UK7dPdlUZoneqvocZcLAr5w0NtYmc++XtHKqKzGMTB/l
 EWt2333qpTF7iJW2mNTwcfLo1taBqlkiVUPeRbs9RNUcQAAs1ypRIQkW7afpOZuJcL3T
 iAWwbdqk42DUYADKxOwhAJKAyXe0QjDx5IoM+Ge1b8KhVtpkjqvq+zAKk3LjJ3Eq1OJ/
 maejZ8rMUfZQcyTR9/YxRCGbdmOF2inZKP0ply0U1S3vTN8MkN/SX40QRRF2+M49AYDy
 H0hw==
X-Gm-Message-State: AOJu0YySXFbuuIkFtLg45bF16TiGFAp8yYVW65r8SexpSnxe5rUksgZq
 M/uMbu8nRWW2zSA8MJlODFy6kowNDA11gFoAupVsNPJpy/JpTgGcpGpXYCBoS/TTApXg9UjSGwM
 TJwI2a+ROZqS2DDkU3sjR9t/QesjrTLJ4Hc4VmCoe/y83j8Ijhr9kgW4kKaE6QIZaODwRhr20Nw
 mbEbHOmN27LhVeqUc2iK/AV1r27/0j2iY2wFPx
X-Received: by 2002:a17:906:3893:b0:a59:c345:17fb with SMTP id
 a640c23a62f3a-a623e6d52f1mr207773566b.5.1716476484726; 
 Thu, 23 May 2024 08:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfSB4TvWhr7kjL24Jog1Ht8TnS7hwBpxo9qw35Rx5Kd12/dhjfyQJw2D4Nj3qoOhHlZi6bYQ==
X-Received: by 2002:a17:906:3893:b0:a59:c345:17fb with SMTP id
 a640c23a62f3a-a623e6d52f1mr207771066b.5.1716476484356; 
 Thu, 23 May 2024 08:01:24 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17814sm1935303966b.206.2024.05.23.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 18/23] tests: Add test case of APIC ID for module level parsing
Date: Thu, 23 May 2024 17:00:31 +0200
Message-ID: <20240523150036.1050011-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

After i386 supports module level, it's time to add the test for module
level's parsing.

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240424154929.1487382-18-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/test-x86-topo.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
index f21b8a5d95c..55b731ccae5 100644
--- a/tests/unit/test-x86-topo.c
+++ b/tests/unit/test-x86-topo.c
@@ -37,6 +37,7 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
     topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
@@ -74,13 +75,22 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 6, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 7, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 8, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 3);
+    topo_info = (X86CPUTopoInfo) {1, 9, 30, 2};
+    g_assert_cmpuint(apicid_module_width(&topo_info), ==, 4);
+
+    topo_info = (X86CPUTopoInfo) {1, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 6, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -91,6 +101,7 @@ static void test_topo_bits(void)
     topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_module_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-- 
2.45.1


