Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE6BC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAw-00060h-RO; Fri, 11 Sep 2026 05:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAE-00049y-PV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAC-0008Hi-Sh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=YqYIGAdw3gmHkLEUUBUnUuBwLH6Nzpy60xc76rfrnxJf0Qc3sZtNpgLpA8oMhAv/4/hTOq
 Ic6Psr3QeMujq+IyslzuAiXkYRUzC5QnToUodW3Fh8iHoTXts3gq5tNl+oRtHznt56V8Rq
 DLyqoUa93rPGu5jSv1S5mH/upqWd+F8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ZJ6A67S3PmexFqgembDmDA-1; Fri, 11 Sep 2026 05:03:12 -0400
X-MC-Unique: ZJ6A67S3PmexFqgembDmDA-1
X-Mimecast-MFC-AGG-ID: ZJ6A67S3PmexFqgembDmDA_1789117391
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso327102f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117391; x=1789722191; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=BRP7bK6ruSppgclE5TnFkXMEh2Bzz3ckQLzouclkPhaFd8+zxMwP+071nBqxI19UlD
 khktFHaoVrnDwY/ZrMNAuLRCVcM3TjJOHbErBarqpeUozv+x1A0rGruPIWLx6BgJ8uIY
 k3XOgiHLEdolJceifxFaaXWdJjfRWiyjzhAdWcUAqPSDdY6oB0qQcvbr2RCTh99GdbVp
 sMVB8s7e7ajUAk7bL23tbr8lTbKJ+eaOLGjr5tdSiGuY5BQ6QhnNxz/6pBtvKBFDAg77
 WZKliW/k9gC1Qof1Jls7CZd2QMbQDGR+U4GuUYUJIllz3XACKPgWYYkweiF73Mh5DGs3
 FBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117391; x=1789722191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=KXo0fWnpao1H56uYXz34Gxsn9wzQVxUvBLXKijld647EtCRXsV/CdZRQCEQxYB7tFq
 AgwX9p4N2kAKfnTDX+SlmrFo+TcBMAmF37RqiTkc+3ufJzrnxL4XKJZGL1Pg1WsNJceU
 9PupaABSmB2K7U7i6DvpE6Xh7UzrtoQQGeltLt+PWSGnExjrhyw//odwMHMJf+FnrQhk
 RYSUvCv8I59TX4rPuD0R3XSeB3cod5h4qLEDoT2g2cxQsxbixT0/lxE1fHVrlqTspEdv
 a1d1WWeQmebHED4J5g/xqd8Zz0q38Mx8ncw8UTqi7+zw0Lbph9d/gfKlM5v9FiEMvI9d
 4y/w==
X-Gm-Message-State: AFuF++mgoGDJ6BYX7DLngVbRAWjLqPi1glOu3rlVYEoaJ3oOhN3qnwOn
 8aM0qEw6negwLdU6l3wXIFBGZLd7WYMsHI9+MC2J0dNfgav/PHCTATYyv1efrmnvptuA/ZntANP
 1mySEr8Uni5zTKQjRqtGlB0IH3+IkAxmC7PpUNTmcm71fOTHR9Rt8Js9DWdvo9ll2nwLXT6TEiG
 FWGlPaO0DTI1F23GZWMzTWpGQds8x5ANXK+Q==
X-Gm-Gg: AYBFou2HpQ7dwZpfx9XeBLj6SbgpGRI2iku9x7YJMpWIFXXCUzaWbU1/s69B0Yn24BR
 MqHQp4pLKY3Cc97hLgj14CIffRW9/RTES/jz7R7B5BD1VbhlyiqwWm7ET2P8O17/nCUMcnvZX9o
 0vfO2stpykpUqX06vCDK6ThlNNeZrsu+SqDns+CxT1DeWQl1yD/4+RpVetE21cJDwQRZhIUrJ6d
 IqNdwcU9PLDezkqxe5oJRMOyWniGJbc8KqgD1ejWBBiwik/Ik7ZWmWsc5xpvOGVdFRbdqz0Tm40
 ewcNgVDxCPj0ARF0cle/pqoHh/9czAYc5aC38EoMKGiYlMMt8u0hgK5wU+N1Jripk6UvtR2syxf
 Loi5clYtVssFHbLCggGXDIuc=
X-Received: by 2002:a5d:64ea:0:b0:486:e91d:9f99 with SMTP id
 ffacd0b85a97d-486eb2e40c3mr7014909f8f.10.1789117390544; 
 Fri, 11 Sep 2026 02:03:10 -0700 (PDT)
X-Received: by 2002:a5d:64ea:0:b0:486:e91d:9f99 with SMTP id
 ffacd0b85a97d-486eb2e40c3mr7014734f8f.10.1789117389778; 
 Fri, 11 Sep 2026 02:03:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm4622931f8f.22.2026.09.11.02.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:09 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 46/75] amd_iommu: acpi-build: update PA, GVA and VA size
 macros
Message-ID: <12e1b767b60a77da1c55749d72330ef733fd3e80.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Current implementation supports up to 64 bit IOVA and up to 52 bit PA.
Modify related macros so that guest can see right size.

Also, use these macros to build the IVINFO field in the IVRS.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-4-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h  | 11 ++++++++---
 hw/i386/acpi-build.c |  4 +++-
 hw/i386/amd_iommu.c  |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1c..d01f9b41df 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -243,9 +243,14 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
-#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
-#define AMDVI_MAX_PH_ADDR       (40UL << 8)
-#define AMDVI_MAX_VA_ADDR       (48UL << 15)
+/*
+ * IOMMU Capability Offset 10h: Miscellaneous Information Register 0.
+ * VAsize[21:15], PAsize[14:8], and GVAsize[7:5].
+ * These fields use the same layout in the IVRS IVinfo Field.
+ */
+#define AMDVI_VA_SIZE_64        (64UL << 15)
+#define AMDVI_PA_SIZE_52        (52UL << 8)
+#define AMDVI_GVA_SIZE_48       (2UL << 5)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1696821048..05b68d05a8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1858,7 +1858,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* EFRSup */
-                             (40UL << 8), /* PASize */
+                             AMDVI_GVA_SIZE_48 | /* GVASize:     010b = 48 bits */
+                             AMDVI_PA_SIZE_52 |  /* PASize: 011_0100b = 52 bits */
+                             AMDVI_VA_SIZE_64,   /* VASize: 100_0000b = 64 bits */
                              4);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 8);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 578c27ccbe..56e7815412 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2595,7 +2595,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
-            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
+            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
 }
 
 static void amdvi_sysbus_reset(DeviceState *dev)
-- 
MST


