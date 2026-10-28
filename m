Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB92606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iDfVpzDM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mN8Q2p1J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HL-0002uU-C7; Wed, 28 Oct 2026 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gv-0001d2-E4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gs-0003zg-Pn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bw9hLk3N4LZox5VvA6se4Ek8EdgEmTEXgTSPI9S4a04=;
 b=iDfVpzDMasaEXuqfhinA+YVBvTQLDEn9zkY0FpLfbHKuWnoxbH+X/9cp6BCLspsLZZkJo3
 p2A2yxnQEShoGUbJ6OHXYx1wU/4lhnPQ3XZXFh8azE2KIhF53CV9/6BPR/q9tY3V1sGz9d
 NUZJ0I8mIstOzSsuZnGYUSVnBKtB8rM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-MuNI0HnKMBuyQHqz-44hIw-1; Wed, 28 Oct 2026 13:16:58 -0400
X-MC-Unique: MuNI0HnKMBuyQHqz-44hIw-1
X-Mimecast-MFC-AGG-ID: MuNI0HnKMBuyQHqz-44hIw_1793207817
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0461e040so955702f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207817; x=1793812617; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bw9hLk3N4LZox5VvA6se4Ek8EdgEmTEXgTSPI9S4a04=;
 b=mN8Q2p1JRrAs2+cOPUbA7wl9s3CU4mIArICUFEAIkfXAt9PqBzfYbn0Qx6pZpkxqXC
 DD4n6JqHTymh6Kn0Diwbg+bCMOQi6nhr22rj8aarSogxeWvLP3fTMj8ALsHD6qUNdaep
 aeaCJCKh1A0YHYO0blOpJ7EsDrPevt7c0mqqo5IvwwwaTU8fgEzvUrQD07fn4j4gjHoh
 5wO500oB0MeYyKFxADxvbvS6JVrtlvKjaFZMTfxQeJzz6b3RFWhaJlJ7TOrkq7J2xtoj
 WYI4zBO8oqTXhDrKTpNoTfb9cM+j6LOkx9DSjTChqzozeCOjHvcZ11byoG8db+0k681Q
 bqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207817; x=1793812617;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bw9hLk3N4LZox5VvA6se4Ek8EdgEmTEXgTSPI9S4a04=;
 b=j5JtLspJWhk8Zw9H4iILiSUMPzkAn+cDZnG9SbohsaU9204EbJnTNK9WRRbpn86ctC
 AIu3WuIsaE6/sC5VvrOPpuxxocGU51+/OYrOATUn4oyaMMFe/Xmn/1fKx/lomYPAe1S9
 pc7DhOkkJ6DEyCg7ELDWCse7krgHneuqklfs4LWNt3ux5yD5k0Wh+Vbca6IfiIeTKssm
 mNu18vCq2uwvud4lF7yQZtun/A1s35p0R8UENUXutVF0u0tJ1KYVqfSHlEcn3z7+uUHR
 jqsQKxRdGs3OtdsUd2pcJ/eF03dcIOiWuGoOWnwj71xfBvxsQPtRwwbp4/LbZQR4Tu4V
 NeQQ==
X-Gm-Message-State: AFq9FYJ5Z6BlqsebolhWt09Qh/yrmW/0a1bqUzUch8Nbrg/QMfCbwcXs
 8J80l+PYt8VbHvcqAU/eKteczndVDux/85LLCs0JjqFi3MQ2VO2zCRTVaZR2kH/7/DWwyruQiQn
 xDxe30tEwMaHFyhFTLTIILYFTIlCDNpQ7Xs79mJrGLgNUl6JLBSWWjHJLACaF1pH9JE/AIfIn7/
 s6AdmRdAUZy3LVgaSAqG7v5FdT/nzz2+LhXw==
X-Gm-Gg: AYBFou0vrf+YoI3WKmqbb9Lm23z9tCx49KUnpUb6jWC3ZUgw7nENe1nC/2ouIVf0kYb
 aQ6/rI8j9W2ap/y1SSlpcSne7rHcKflqUTZJnI5IfMW1vvqahkb79PCkOxTAtf/OI51BznjmLO8
 j+m3dV71iAkwyA8tFOIx8zpsTDfks2yMDiBGp6LGqO5nUkGq1bddxSXyaYH31roavyHZ2BzrD7W
 FDKtPzVvazsxuW06cqZGFQItSNnGcSvVrG9K0HNe3Jg9en119bTMKSYOHC1Kxswe2P/4X64YB9H
 zCAyveN5g0DAV0HghxnKuwWQ/I7KPDTGEwS7kG+/eu7cNXkt78DB2XVluXXLXnGG5SUH5IaV/sy
 XSFTBerourjkoehDS0NtNH16yMNeD0ZWo0KGbBLGG
X-Received: by 2002:adf:e00f:0:20b0:48e:3db7:4dbd with SMTP id
 ffacd0b85a97d-48e5d564ef7mr5343629f8f.48.1793207816737; 
 Wed, 28 Oct 2026 10:16:56 -0700 (PDT)
X-Received: by 2002:adf:e00f:0:20b0:48e:3db7:4dbd with SMTP id
 ffacd0b85a97d-48e5d564ef7mr5343573f8f.48.1793207816124; 
 Wed, 28 Oct 2026 10:16:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm29992881f8f.16.2026.10.28.10.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:55 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 66/78] amd_iommu: Introduce root bus
Message-ID: <eb46c65c1fcb9ba2c172fd29763c64f50ba82065.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sairaj Kodilkar <sarunkod@amd.com>

Following patch will create IVRS entries starting from the root bus

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-7-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h | 3 +++
 hw/i386/amd_iommu.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c5b346cc35..948d8611b1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -388,6 +388,9 @@ struct AMDVIState {
 
     /* DMA address translation */
     bool dma_remap;
+
+    /* root bus to register IOMMU ops */
+    PCIBus *root_bus;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b2df0e9533..14ea8274b2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2713,6 +2713,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    s->root_bus = bus;
+
     s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
                                      amdvi_iotlb_equal, g_free, g_free);
 
-- 
MST


