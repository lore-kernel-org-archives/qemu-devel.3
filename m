Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B251CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGM-0005fs-T9; Sun, 05 Oct 2025 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFk-0004Nd-UG
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFd-0006ev-Le
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqvqByI4LKiqbM55WODj4LD+2eo55Kp0F3DJM0/qKGQ=;
 b=g2Ab/zaFfLgZONTm2/OsoR8YQyqkHoX7sTVXd9Rqq745LHQwecjzcIrgBWEdbON+GpJ1T7
 cVKtnA+cRdb1XAh/AaYAnCPtDJHyqM/IJx+9oXFts9v72Dr+DolNdz5q+mUlhdtd5qpY2e
 wsS6wb+Y4BJE31RfuPvMDFewG32y0q8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-yW7lBNAaP6-T4LcDL2dA9w-1; Sun, 05 Oct 2025 15:18:30 -0400
X-MC-Unique: yW7lBNAaP6-T4LcDL2dA9w-1
X-Mimecast-MFC-AGG-ID: yW7lBNAaP6-T4LcDL2dA9w_1759691909
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3ef2dd66so20873185e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691908; x=1760296708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqvqByI4LKiqbM55WODj4LD+2eo55Kp0F3DJM0/qKGQ=;
 b=IbFz2m/4qWOtuAXamFMXOJ4zTCizfI41SvvShqWDPPDyvpwaM5XRFwNZfGE0LsCPDE
 6Z8unqFR+iWu5LDxO5VN/p18ipGbBex5yki5/Qtu4e9DY46mcKZIbcdSB4zE58rzl2q2
 jBaokJ0jzmtvjmuyh15Q+pm0bMHBqGXHn5tqNgAK3YDDQMg8epEmU0QqhQ1efjtHq9IN
 43LD3qkeoyEl3rJssNSEzgxl/Q39lionXcOgIucy4SkND7sE6VaVO1VwgoHbbbidxxhb
 UWCuaAu4PqaYp6QIrlzdGLqjjPqamaxOyLl69/zHGFq9W3YA1MCFEQ7BXAguyxN7tRgx
 P+OA==
X-Gm-Message-State: AOJu0Yz581xXs6WoIZfacO+/YtkIm+PMJ4H4bhPlprUt1YydYmgFQnVx
 UlZIIGOmwqCt6vnyMA2MqUrZ05xylrBNs2t1z5HRwjmFe2E/5nZXSIp+U72hUuDh2tP/JpbehG4
 D0PsizE8dazvYr52PDU2MA+chFD8E4Dry1U9ycOdTmfBBKcXqMpMR5QNuymRbTTPltvAoUcAfbL
 tvBXBx0ssmhzZLe1kror1cpRFuYx0uxjD7vQ==
X-Gm-Gg: ASbGncv/6VxskMaJ42/g/aKPFc+Tps37R9blr1uojAwRG/T5BrbTWPLPDw3ON9AR4e/
 nvrt+g0jbVDLdp+Orz2KjooE5IfJGSm8yJSgsK96s+1wR1j3xu5PaqTRz39l/NrlYymZw5HDyHo
 95YN3tKupKR8Rht8Qb1B61g7yncNxBA1MmtUdpi3D0ixcQEnQbyR4jP1FM6dtsWcE3pj3Pr/FSi
 23455WmKTxDZoaULPDW4TRAhYy5by6f+1YS4TPn+nZ34bKecnetg+Xes1xPrJee4HER9x3nivYu
 P0iss46iJl/tJEXZ6AheRtYj/spAWHyRKQbNBLQ=
X-Received: by 2002:a05:600d:108:20b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e71033bf4mr55338325e9.2.1759691908542; 
 Sun, 05 Oct 2025 12:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXM5ThzT9F3Bt0Kyl4IRRYPnCi1ex6cMqqDPYtHiGoMR9y45az16Yu2GgKAfLKMuYF8rzygg==
X-Received: by 2002:a05:600d:108:20b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e71033bf4mr55338175e9.2.1759691907934; 
 Sun, 05 Oct 2025 12:18:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c396esm221391005e9.8.2025.10.05.12.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:27 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 65/75] amd_iommu: Set all address spaces to use passthrough
 mode on reset
Message-ID: <42d1e7b5d2ec3eacb121138a9b5201b0ed4ee5ae.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

On reset, restore the default address translation mode (passthrough) for all
the address spaces managed by the vIOMMU.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-17-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 67a26f5247..e9ce7b46e8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1001,6 +1001,35 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
     }
 }
 
+/*
+ * For all existing address spaces managed by the IOMMU, enable/disable the
+ * corresponding memory regions to reset the address translation mode and
+ * use passthrough by default.
+ */
+static void amdvi_reset_address_translation_all(AMDVIState *s)
+{
+    AMDVIAddressSpace **iommu_as;
+
+    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+
+        /* Nothing to do if there are no devices on the current bus */
+        if (!s->address_spaces[bus_num]) {
+            continue;
+        }
+        iommu_as = s->address_spaces[bus_num];
+
+        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+
+            if (!iommu_as[devfn]) {
+                continue;
+            }
+            /* Use passthrough as default mode after reset */
+            iommu_as[devfn]->addr_translation = false;
+            amdvi_switch_address_space(iommu_as[devfn]);
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2263,6 +2292,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     /* Discard all mappings on device reset */
     amdvi_address_space_unmap_all(s);
+    amdvi_reset_address_translation_all(s);
 }
 
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
-- 
MST


