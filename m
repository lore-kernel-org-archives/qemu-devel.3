Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836C606A32F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjHiCLCs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3Tq-000777-IB; Thu, 05 Nov 2026 14:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3Tb-00073Y-Jv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:23 -0500
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP3TZ-00024L-I9
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:23 -0500
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1438d9363fbso818309c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908220; x=1794513020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WCuKVbiV8jkOh+eIzjYMJHPHCpTsJrz9kcbtXR7lnvQ=;
 b=wjHiCLCsoeipRXcW4pJ1Whl+ny4z86Tlw3HkSa8tV19KmDh/PbGG6tgnFlkx1qVmDS
 05aWhMnHrqTIkkKPG/8VD0TgKjgwhF+PU6+EUbXt/aEORyVsANEVHdjsxjIw3PecPFpK
 +AFOdckFLw6oyEeXZ6EpwduBdiS/8j7gOQ4fMWjjuD+Kz3ii8ZZIc+PdfLEiqZm9GmpU
 A+GdgQweKWgZfi1mXULSp8o8d6xO9fjfbuqRmBqq/ylwUaE5cOoWkZ2uTsLcyzk31Vh/
 pPffZmwUql+Zmv8Go3q6BVFTFIeSr9VkYLotRervufPCabSerCenUNXnUoqB/z+9V0jD
 sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908220; x=1794513020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCuKVbiV8jkOh+eIzjYMJHPHCpTsJrz9kcbtXR7lnvQ=;
 b=AJEtlIUEAElozs/ZEf8LZLiY4YNJ7R+z5tdNERJa46e7OkOmoo/VrJPiXQS9FFfl/X
 BE7IHolOf2pGQrWiQNJrpuEwJCYITNQ6Ih5V9yZ2B4XZvFoISToBH+hzrSk36tDpKTef
 p5AazzJdup29n/r9o0cpEcKTno8O6p0QsF/lT2VaxTUzPaT1a6ngBQwCNWVo4ZIyCtFG
 krrAyjy3QzyhKHzhzDFShyzvLYp6XA5YunsdLBWB1lpyHau7dmf3dqhYTb1CaH/CQCeT
 IHus/F1sofNoDBSEtCR6vIw/ju/A5nTBEHrmOb3/yeH6Wu6y1nBHLYhKT7pj6xpxHGB+
 obag==
X-Gm-Message-State: APuU4Z8I5J2XKkb7Gy1xz88YqVRPt5MUvTPxKlnDTeg/5PXd3F8DILIc
 gmkIS9nncJ34KAwNlyCh5HfB0lL04HIMGFeiWMdX9ikEn3SDnpGq1bNwnkYgE0gwCqc=
X-Gm-Gg: AYBFou2yGJ/oAe4b719gMscTF+ui5FeBo3GYmMW3bEuhMfJ65sluZyFIGdQugk5K0UV
 etSIuevXdxLirMakAidtokGncRyHbGuSkAX3V8ydT4J2ZkIbPmHWaX13PDUlgGV90DsBSLOfUZH
 GitP95KxCmn8gBpBe1GdiOB/udvmFI0PQWX8RL71rMnGpa1N9a5mIuEHGMi9kNEHBEWgbok1trB
 VJbPHdI2QpPkr5kUC1vqdwMtYPcqUxEwO+Uc8VXb4LUGb1Q0h22bU+GIGqePCl2mkhjl3VBMjHG
 e22eqbnrwy2r6TJNj+IKZFg/nvoCk+RgCU4Zg1Cs8maeWWg6qSZv7bmWM7jwZuHGU+xoD+VVYJG
 yzfw0NPL8IixIF40090HFhBQWR8GnxsxcvlsmG2iiym1hqNA3/PmAsUYsDzbxYXjBoLX9Xj1Fqf
 6hyF0+i4dX3KAga0j/UfIt1JDSB1jI1s+CToprdJMNMGwZwXaizlgGQaf5SfHG7YJ/X6GDDp5n4
 SAltFGbQBr+kNb4DiyKBxWk3XQD+FsX6PEWCI9V/i3ncaX24mmF8yuIYnK9VfjPu2vHWyzVubJi
 WKNuEYKBI90XmJ0UziT1U+H/DfmvrW27MDGGJ3Ee0acrGN98
X-Received: by 2002:a05:7022:f107:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-1b25d3399c6mr14075c88.20.1793908219746; 
 Thu, 05 Nov 2026 11:50:19 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c1c283sm19459875c88.4.2026.11.05.11.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:50:19 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org
Subject: [PATCH v2 1/4] hw/pci: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Fri,  6 Nov 2026 03:49:54 +0800
Message-ID: <20261105194958.1117-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105194958.1117-1-luoyonggang@gmail.com>
References: <20261105194958.1117-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the multi-target work, the goal is to move to a single
unified QOM tree that applies universally across all targets.
This complements the migration away from instance level
properties to class level properties, which again aims to
ensure a fixed QOM object model for each class.

This requires that properties are either unconditionally
registered in the class, with invalid options rejected
at runtime (for example, during realize()), or that distinct
subclasses are used for specialized use cases that need a
distinct impl for some targets.

It is harmless to have the 'loadparm' property registered
unconditionally so take the simple option.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/pci/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d8b117799f..3204939469 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2889,6 +2889,11 @@ static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
 {
     void *lp_str;
 
+    if (!target_s390x()) {
+        error_setg(errp, "'loadparm' is only supported on s390x");
+        return;
+    }
+
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
         return;
@@ -2906,14 +2911,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      pci_qdev_property_get_loadparm,
-                                      pci_qdev_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  pci_qdev_property_get_loadparm,
+                                  pci_qdev_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 MemoryRegion *pci_address_space(PCIDevice *dev)
-- 
2.55.0.windows.3


