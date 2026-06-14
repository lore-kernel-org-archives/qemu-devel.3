Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52820CD98E1
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDd-00016x-5f; Sun, 14 Jun 2026 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDc-00014t-3N
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDa-0002m5-6e
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/C87857Tl8XFyJTpzE0YZrg6mxeNYh3lpIo3oiRAqwg=;
 b=WrombQG7wXQugfXPuMYCRGtMffMG8qzjFqQ3mXY7pR50dN9ZjY71VvdZAp5JAKdNTczwwY
 XuGFVRZ3TX6iyHUZfcvccr8fZ19/2/pAJSj/fDVJm47CoAClV3JNgCv/D6TcvzL/aXXbD9
 rNDtNPW0aIihzE4U2wohOkWyn7Y93r8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-PmFCdWNTN62okruGxTWWfw-1; Sun, 14 Jun 2026 15:10:00 -0400
X-MC-Unique: PmFCdWNTN62okruGxTWWfw-1
X-Mimecast-MFC-AGG-ID: PmFCdWNTN62okruGxTWWfw_1781464199
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46010392f89so2480661f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464199; x=1782068999; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/C87857Tl8XFyJTpzE0YZrg6mxeNYh3lpIo3oiRAqwg=;
 b=Qzycom121/45XhcnGV2EFXTE4Ymc8Qv2fyIFxKqdJH6Seo+Yy4lVF9B6k/tTZsiIzK
 PY+fkbeITl7aRjlreodg8+LfgJOLx+7VNT0l/lchGQjqbpVVJrbm/9FhCr/qjjmrcaNx
 X1rCNaovzRLoLO/sheAbf36kd5G81afdCnz2KNS3M46eN3qPwPE3XN6Fj/T45w08TJAd
 EkIR+NCjQ/rJYdTVt7I78ZHUyteJR0tXC+Z+v8Z9kDKbHud8UXCCqi4ui+Ed0WPLRaVR
 wIUUJ8bM3JpTUA+b63R3J6/pcumnm6FQ1Gbi5KidEL8d8nMliv95ciwixVayO6tCTDwn
 PMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464199; x=1782068999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C87857Tl8XFyJTpzE0YZrg6mxeNYh3lpIo3oiRAqwg=;
 b=P5Ecs3159baW55NnNjJe1NhTGDOKe8MzbSWPUZ5jjGJuNT2+pReAmJYS+1UEvbkPdQ
 UeSv8DA6oAPT74xJlgDS2yrHyUAMHK67SJQs1oQD2N9Ns3H3Yj6XnnEPjqBlH5pgWUt4
 OjUIZaNYWVeXLHEUVP+NCZGltJ8Co51cZ5c5Ye2AygjINImxVN7Qv5TCxeFodh1NPd+5
 aZWFWkuqktwXhkkah7oXXekwYShVxNEvyYqaBnv75+WL2cPXYP+38dl+6P/7IkBEm53i
 6sAsGH82xJMm6lmrx+eZTjCPDbu+IGPtx37ly35kuxxA3jU/QO6b3J2AmhLDpTUOwdzK
 GlYQ==
X-Gm-Message-State: AOJu0Yy+BWwUHjBHQYqg+unncAxP+FFCQZx57Ndnobk5goBehxWnxlrz
 UXZi2+f7iF24SVh6fQrphc8ZbfuTSu1SF9cxDKaUfsTHXiC0Zz0lUtoIk9FNp+LdWr6oJWCEhz2
 3qUY3x7VCuRsbtPXKg84YkonoryeUw14pECYjC3jQkVjItoVvkgTmcL4pmKtk04LY7W5rWTlWY8
 qFbu7TnnB0BkVqJ22hJgeGHatEXCKAsgaSuw==
X-Gm-Gg: Acq92OG1xkLV86l5ik5d4bgv2xY+tX3w0w+IM0NIgxyPT10hN0nlFF2mcmAep21US0p
 YIIQmDsMVlxSyp6goOLDhg2NPs9dG2QUpehtqV58dPiGxM85kPNnIr0NNv1qI2wgzo4/rxy1/UT
 ptw+RQqfRp5D1BaHbARsZyUjeWoaKx9t/JVwXSUjLtufay4jyf5MlHMkv6YRbGBMdWI2W+z9sV5
 9d8PBf2LL+ibNcv8FpJnE8vUhrSpfUfnbHfeX2UXIJOo/XA659S+tH08NZfJw8QqYw/Z/0ww92R
 UAge2fOfVrOTbV9FZ00UYKoOWWpU8w68bCAPtkMjl6iNGHfEFIoGvzCPyXBfFUQNrokbL9/YgLu
 JpcX3dqPWLSEyHpWdrZJ3iQTO29xo56493eCBckSToHQ=
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-4606dbdf91emr14863227f8f.20.1781464198613; 
 Sun, 14 Jun 2026 12:09:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-4606dbdf91emr14863187f8f.20.1781464197925; 
 Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm28020996f8f.1.2026.06.14.12.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Gregory Price <gourry@gourry.net>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 102/106] hw/cxl: Allow cxl_cfmws_find_device() to filter on
 whether interleaved paths are accepted
Message-ID: <57d96c7b8527d60bca37c742ebe418040dbb2fcd.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alireza Sanaee via qemu development <qemu-devel@nongnu.org>

Extend cxl_cfmws_find_device() with a parameter that filters on whether the
address lies in an interleaved range. For now all callers accept
interleave configurations so no functional changes.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260318171918.146-3-alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..2dc9f77007 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -104,7 +104,7 @@ void cxl_fmws_link_targets(Error **errp)
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
-                                uint8_t *target)
+                                uint8_t *target, bool *interleaved)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     unsigned int hdm_count;
@@ -138,6 +138,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
         found = true;
         ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
         iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (interleaved) {
+            *interleaved = iw_enc != 0;
+        }
+
         target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
 
         if (target_idx < 4) {
@@ -157,7 +162,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     return found;
 }
 
-static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
+static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
+                                        bool allow_interleave)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
     PCIHostState *hb;
@@ -165,9 +171,13 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     int rb_index;
     uint32_t *cache_mem;
     uint8_t target;
-    bool target_found;
+    bool target_found, interleaved;
     PCIDevice *rp, *d;
 
+    if ((fw->num_targets > 1) && !allow_interleave) {
+        return NULL;
+    }
+
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -187,11 +197,16 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
         cache_mem = hb_cstate->crb.cache_mem_registers;
 
-        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
+                                           &interleaved);
         if (!target_found) {
             return NULL;
         }
 
+        if (interleaved && !allow_interleave) {
+            return NULL;
+        }
+
         rp = pcie_find_port_by_pn(hb->bus, target);
         if (!rp) {
             return NULL;
@@ -223,11 +238,15 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
     cache_mem = usp_cstate->crb.cache_mem_registers;
 
-    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+    target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
     if (!target_found) {
         return NULL;
     }
 
+    if (interleaved && !allow_interleave) {
+        return NULL;
+    }
+
     d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
     if (!d) {
         return NULL;
@@ -251,7 +270,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -268,7 +287,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr + fw->base);
+    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
MST


