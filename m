Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19722C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QD-00082o-4V; Sun, 26 Jul 2026 17:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QB-0007xv-6d
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q9-0004YP-LF
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=Of1ptuQB43k4UDmBpwq8VAsL2uy12G/MLsxYEx8kTpwZwwGx4hyaf4BJJS+K3eievWrs+i
 L0FzuP+Iisw5m09kfYg3TNGsQuYrmS6QdMZ2O18hbd5KLecJg2exh1Ts3PEvuRpcS5YdJ6
 aywILEUvcNmS9W8HSA9bUL80cUiCeZs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-utgpxWj1PkSlhKbeuJVurg-1; Sun, 26 Jul 2026 17:30:02 -0400
X-MC-Unique: utgpxWj1PkSlhKbeuJVurg-1
X-Mimecast-MFC-AGG-ID: utgpxWj1PkSlhKbeuJVurg_1785101401
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1235912f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101401; x=1785706201; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=AMrPiXUV/CzpAuVmJGMkK/BjywPiIuF2D3K7CpQY4j49bXmpNVPUapfSiBjVc9FZuF
 w9CqWlk5TwHikGDuyuETGcka8+qBpuOOjPN86WLBYOGzOBWbqFwszVX3Um5yUk6UxpKp
 6JllXFJznCek4ucCmMAGVJOKSdDU/YkbUjEHoNMyTkJ9bwz6AtO9oEWeOW+bj6NcJw8F
 uRE5IAEn0Tmyga179nMcwReV2DbMLqD9RKgG5HhuuYuD9ZZMmhYUWR3s+pOlKORwIAvj
 tbMtzzyx8e1ips0kXBR8KJrQ3vGzjw5132fBUlGNqNszWb3iEjtF14P7f5+tlL8TW9W4
 DBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101401; x=1785706201;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=Y+RvXQu8F8XOPgn5L4fzT+Z0DK3FzIM7YTEHrG53DCM/HSlamJ8JuX2Oa1yBX9C/vc
 ssEHVUd1rnmXZ3x6YW61ZXhb/ZYvrxuKCvK9+XYDKCGb1GnZer3gIiWrAeb81DIlXvCj
 i3WjmE3jl/3Nk+HCRldIq5PwsWn8CKUBXS9AcDv2iEbj4x1f98anDPBRInoqnVCqltjM
 Bn8mDsj30Aaaz6AhuosgPpBkwak5Mxo46/FBcV8NhguPOEN5bMv0HSBEt73vd9trqTTy
 UOE+lGhOG+ZyykJ9nUUjOggohuU8Azb2fvF0elTA2+HdtzZEYCIWLGtatemMt2FaAp0J
 necg==
X-Gm-Message-State: AOJu0Yxz7g3fK5Vx6tpPgXnRf//RfbJ9QH06E8rUAW17XEDk3IQdW4wG
 GiNddpTWwGZW309jPJfvEkaaR1CNcyEPt4+a3SpEXXDWuQVzhYr/HusB0LksCMD15heaOhBvCew
 qkFtfZ3aEv/L3yc4+XYZfnHc9DzOfGyOQd96HEWsiyW3Ym8wC5Ef2aWF1oRNPRmpazkNc+mSVhJ
 a3CYRRMpz0lQRpspdO9jqLG9+jPw8+eGzGBg==
X-Gm-Gg: AR+sD12by2Seh+WR3jB5mB6v7f0z583fLu6xAxvtRUzKJxAYAWWqtBj+h1Na+WRi0yC
 LQrz8+VxmAQdWopLZoidEMZwS1s9lLbu1xliYGl3cu+In5WESHRp4jZI5S06LFMwVVwGOxMWMsP
 QMSn4+/eYFqTKxbHbDuX+xC9xXuBtcvhRMJi0FWdVPpOxZ8qmp7unvajWLFQ+xtcuIVO4obi3z3
 xuR/dtIhBiBSF66Z4lMYdHTvwdue54YvMc1vwZrTaazOrYAvOvTev7lRJztdpnHWwJkdidorBIB
 pHt8bCk6eI1P3c/ROmNh7DZCwhdSmu2uZm0Frl9yUCrq8DgFwqXaT9TQYw9QUnJ4TeehiKEuhwi
 /OVfksybUkJq5kuGCR7FD2Q==
X-Received: by 2002:a05:6000:25c1:b0:47b:5f25:7c59 with SMTP id
 ffacd0b85a97d-47f9fea2b4bmr6958819f8f.38.1785101400933; 
 Sun, 26 Jul 2026 14:30:00 -0700 (PDT)
X-Received: by 2002:a05:6000:25c1:b0:47b:5f25:7c59 with SMTP id
 ffacd0b85a97d-47f9fea2b4bmr6958794f8f.38.1785101400365; 
 Sun, 26 Jul 2026 14:30:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6ef25sm39741334f8f.36.2026.07.26.14.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:00 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 24/30] hw/pci-host/q35.c: Avoid early return in
 mch_write_config()
Message-ID: <dfb076e14c455aa441d2a71b6714b414a4876a1b.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In mch_write_config() we return early if has_smm_ranges is false.
This is slightly bug-prone because it leaves the door open to somebody
later adding non-SMM-specific code at the bottom of the function.

This case isn't as bad as the one in realize, because the function is
a lot shorter.  But putting the handling of the three SMM specific
ranges into an if() rather than having an early return seems better.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-4-peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e42b84b978..f4556ad03a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -485,22 +485,20 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
+    if (mch->has_smm_ranges) {
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
+                           MCH_HOST_BRIDGE_SMRAM_SIZE)) {
+            mch_update_smram(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
-                       MCH_HOST_BRIDGE_SMRAM_SIZE)) {
-        mch_update_smram(mch);
-    }
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                           MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
+            mch_update_ext_tseg_mbytes(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
-        mch_update_ext_tseg_mbytes(mch);
-    }
-
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
-        mch_update_smbase_smram(mch);
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+            mch_update_smbase_smram(mch);
+        }
     }
 }
 
-- 
MST


