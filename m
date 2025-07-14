Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHd-0006ta-0P; Mon, 14 Jul 2025 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGJ-0003Lx-6I
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGG-0005Rp-WA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6nMveUbGLrix9Gi4Nv9/DgFcJ4qjPzRjbMU6l4MMKE=;
 b=IemNU1LBE+FYN/STm+itbe+tnZKWW5OMbRhN3WG8mBx/Xz2AHRlcLgvmPtgXfa7hCR0W9B
 FldVAw0W/0vLlq/NWudBlscNFAD1wemod34DZxR7C1eiKuS0t7kCl8y3g4CwC3r8VLg53Q
 V9/r8iDxYE44Fo5u2R8aFeVPWmvqUfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-HSh_MKSmNw-W1CBz6GSKzw-1; Mon, 14 Jul 2025 19:07:03 -0400
X-MC-Unique: HSh_MKSmNw-W1CBz6GSKzw-1
X-Mimecast-MFC-AGG-ID: HSh_MKSmNw-W1CBz6GSKzw_1752534422
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561bc2f477so9105785e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534422; x=1753139222;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6nMveUbGLrix9Gi4Nv9/DgFcJ4qjPzRjbMU6l4MMKE=;
 b=adVBNYBmMpUlc9Tif46diJz//5GXja7TYwjmzBqYQ3pGZZ2f63NdpRs9AacQoDeE9d
 TYYzbcpkUfKG2BiNg9KrXmbfaFKeh/uBCRhb1P2NzzzHOFNCRaw1RiYJNKqg2TvatsEn
 d7pQUbx7XhmoJihv9vjs1tQB9dhP8fZttScJrv4UlxzfLow2u67jJ/qwnkQfxT1CNwO1
 G/vFY8NOyJbHNhz8qG1P+jJv8IFvTd4Tccv5/77QBTVsOnF1+HhzGWQxxgJ7RKWQAnfv
 jApNgWkODrjGsXFl8ZRJH3euj1hRx1P0z1jtH3oy2DXWEaqIMTq63N9P+o/fMbh5ZbC1
 4uKw==
X-Gm-Message-State: AOJu0Yz54Dj1BtlZusZZxwEtVQ6m55Xcb4IynIZCRwIsASC1bzwV6+bH
 VkYBqL+XDG9j+H+6cGD5fo3lnNJqpxHhIHiO2+FJub++KpgFqU98bKyyRYZ8bB06HCYAzTpA27t
 07LzsMaSk9wY5gRu//P0aXyPA+aNtZwx0VALM/ebBj1iKnbOlVo5RaR0kqTmJYmGrhhel7CneJq
 fkWfm8BQA2WtD0XTJJYnG+61No56zxFzfp/w==
X-Gm-Gg: ASbGncueANbZJlSy4klGURDjezIjjeJquvFERhS9I8GVHU1jgG/wT8Zt6jSIWlCU4j8
 XFfpe9AfLwyA5HD8JF6XfdNo2KvhSMNUiCfMgyngn3lh3GgYW7q+reWBAiutFfRoMJgqx+pv6Em
 cqrRNwnFysYk9jhtnRhFpH5lUxED774B3oQfWDcWbbGXYsOJ1pQlWcZZa3gT0/EkyChFrT28CVH
 IkhbrN9tPB2SLkpjM9NhM/Rh23rYP1ohJ8QFZLFgGGssyJoszgIT679vM0+6TtGrFD3OzMWiReM
 flAaaJ4VknZA2UiOtuZ1UiSZ+0ScV60U
X-Received: by 2002:a05:600c:1546:b0:456:58e:31af with SMTP id
 5b1f17b1804b1-456058e33b9mr111509005e9.14.1752534421657; 
 Mon, 14 Jul 2025 16:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyylURUBM3LIWdMLMxKD/hA1FAGQUvUOFHLCGzEzYdB0A8DxTgBP8nfxqlcrOEzw1UWV/How==
X-Received: by 2002:a05:600c:1546:b0:456:58e:31af with SMTP id
 5b1f17b1804b1-456058e33b9mr111508755e9.14.1752534421199; 
 Mon, 14 Jul 2025 16:07:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45619fbcff8sm48845765e9.2.2025.07.14.16.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:00 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/97] amd_iommu: Fix Device ID decoding for
 INVALIDATE_IOTLB_PAGES command
Message-ID: <c63b8d1425ba8b3b08ee4f7346457fd8a7f12a24.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The DeviceID bits are extracted using an incorrect offset in the call to
amdvi_iotlb_remove_page(). This field is read (correctly) earlier, so use
the value already retrieved for devid.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-3-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 963aa2450c..c27efa504d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -508,7 +508,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = extract64(cmd[0], 0, 16);
+    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -521,7 +521,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
                                     &devid);
     } else {
         amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
-                                cpu_to_le16(extract64(cmd[1], 0, 16)));
+                                devid);
     }
     trace_amdvi_iotlb_inval();
 }
-- 
MST


