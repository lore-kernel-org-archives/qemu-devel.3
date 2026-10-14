Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F4CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvNy-0005Wx-Nt; Wed, 14 Oct 2026 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNU-0005Fa-Sh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:29 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNS-0000e7-BF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:28 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-33c2520ad38so8984294eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970464; x=1792575264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9grlkE7NcjVbWKGA44KZGoN8QKYGDpltY5XgCndOBEc=;
 b=fNCZQ4CW5mkFHAmC8cvNK7yLan2cTBOQGi5w1n+GG7mDV8Z7b4NfSN7PGg/r6wgv5+
 aLI10V3ItNXCc2FgHRxsStGnFbcq5IHHMf4LceP77JSgaqdtWYQt0LTPutowmb1YQVlx
 N6kIGwWyJ9tjnhiNtGchtjDJ96bO4t8dgygnJcUiWQbGKSgvAspjHcXBHrmbxJNITDik
 2Znvt9FCYgefOcHsS/b3TlkwRDXFLPvicOAJcN+oGD7kw/1t7R8lUyXVdzO+lmSnQqTC
 YFvDVqD4K/U8uSkZCWx4mlAp8N/WRX/tkpQm6u/C3hsL3/sNHTGTZicbJpB6C11ldeX0
 h86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970464; x=1792575264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9grlkE7NcjVbWKGA44KZGoN8QKYGDpltY5XgCndOBEc=;
 b=Ze121zXWIY1CEVHTP/PIog/RtR5G5fh+Xj+9helhlFaNm3zcEC8Z2t0yEJsBsDDDZx
 sficS7vswsrigG7GT63tXZrRtc1km+3WstLuQzcXZCFT1sJunqucDy7Rhmj2acFE/vQS
 WDvDPwewCrR92oa3x75GEAEQBQWYtpElx903yiZgUfyFzwC2C79r8RMszztbpubR8sbF
 5/MPAQAEcRIUyUntieAqPbMroGuIgtdDyHLKvi1jvtZCAApY/eZdN3bTNapKSVbIa8SN
 /vJK0RbMn/1KEuSjxQFvR756GMOprepDnvBKfqmB58XZTe4O5UU8QNcY5Ke05ao/VCig
 iYJw==
X-Gm-Message-State: AFq9FYLrdJYZi9SDOQkduzfunv13bE926PBcuCBV71/8sY5STxCg3X0k
 I7K/4CnGpeyYM7ixUVzU2d1ZIdAwwgqubM/pU5rzPIFdUG8q564BPl4ru/xQDh57bnQ=
X-Gm-Gg: AYBFou03XNyo+tSCeN7binPAssuMBVsGF9hMxXkJKUgLfVGvGLx5BYPn3+AZwM4LQie
 6ey8UACoji1sNqIhMP8Z9TVfxtRRkVrwX/HMRAaJOrk1N6Ds4siQ6Inq15eEOeY997ZoX5OCCOI
 j5OCRdPx8cPAZ7OT+n+nJbkHCLSB/mzZ6Yz/A5dFd5tyJ1wXwx7TIfiNteCMOFQRBTVrQH1hl4+
 HAwfmhM/csO4R4phjMVX5pU7sEzDVjRM+WkXnz6B8Ri8NT2wxOVjNn/ATQq2FVtOUr7nKsVEhUE
 Nb43VLaGn+tfEfLsK5ivFJqqPGswe1tTbvz3k9ZtiXaDgDzx99403jF4ulDqLbcXSMqDNHOWTSo
 5h5UwMIAAq/hcs7Y3BKxv5Pf3Abb3yK/C1VcYwSw4WWE24L56gyqv4sQ90+onWkFyS2F+PTEUwR
 fQkUj9+IpavFr+RVrzAL1A7DbbraU4W5y1Z0l8rZW7MEEfPNK8lb7Eovk3+jYXBDJcwOEFCtkD0
 YHrm88rsoi/qAUGbw==
X-Received: by 2002:a05:701b:4583:20b0:151:ece6:b171 with SMTP id
 a92af1059eb24-16a5dcf6262mr21092743c88.14.1791970464295; 
 Wed, 14 Oct 2026 02:34:24 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:34:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 14/34] hw/pci: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Wed, 14 Oct 2026 17:31:24 +0800
Message-ID: <20261014093152.834-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is for avoid call target_info() in class_init.
Now we directly guard in pci_qdev_property_set_loadparm instead.
Don't know if its an API break, but the smallest change.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/pci/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb0..9d3dcd52942 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2878,6 +2878,11 @@ static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
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
@@ -2895,14 +2900,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
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


