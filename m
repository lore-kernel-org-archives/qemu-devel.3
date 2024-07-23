Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7924AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCy-0000TG-OL; Tue, 23 Jul 2024 06:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCk-0007Jd-Na
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCi-0001p9-DF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5oJRr4r3YF/yxB2ziPoT4Qctv1Z09qYy5SwcSzq9dE=;
 b=f7PgfjR90IluEk5/oUicWFAV1co/i1Lw0jq4WKI6tNB1oCm4eFjfhQp5pRKdUj3HKGR1wl
 2eliOAddH5eHERXj2S7IArgo5m2KAR2YreFiiZcT+PKpHwKRXhsNX2JD2UOBFj9UlsO2tg
 KQjq21LTs1jaofyAe8756+PHKZHrVjI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-GbKX1lkWNKqmO3pb2-HCoQ-1; Tue, 23 Jul 2024 06:57:09 -0400
X-MC-Unique: GbKX1lkWNKqmO3pb2-HCoQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f571c3eefso47958966b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732227; x=1722337027;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5oJRr4r3YF/yxB2ziPoT4Qctv1Z09qYy5SwcSzq9dE=;
 b=oMLxQtesteecibGPK1MzIqjWzfXXcTubxBH1nTe3DjbSAhttmolhnAkhGpa9TkhICS
 jKYDprKy3dXxxvGnE6PaGH7IhjD3uSOzKf3yZZsx6SAveMrH/N0ojVkk6JEkIpM2oe9E
 pWsy0meQonh1VSFvC8fRapTnblhuIbkXYI3bylHyL69xU+sUhyuqtHEedUVk/JFs8Vxt
 8pn4Zu2T2Z4MbVKy9mcDWU8Nv+dQ05uKafEnxyRdX9G+Xb017mI/kwEEKH2yj+7bZtXA
 fOOa9LeWYC9w5EayvwFgnRSKEl+TASRk9PcH7T3BfrJBkYrtiu9ZOl4tWgOyFlnIJvYm
 rJFQ==
X-Gm-Message-State: AOJu0Yxre7/cWF8kOA2GBB+59mVigSLjeAeqxpanG/YgsRZnAiX9Quqc
 zBWZ/VAhxHkt5Mkbt36ZyMqepWLSAYmMvU2dzZ7GdTZOoI7hN/kqOZhj9BkrMYFfuSMDNOGZDuX
 ZhEGFo3Tp6SozUqURep4zQ+TlPKKyssbrjarU95dv37b4LJvEI7aulMwpOYY9SA3id2LnJZAmNL
 mijqP4PjfHnT2ZcWo4AchOUr95zhXXlA==
X-Received: by 2002:a17:907:d8e:b0:a77:eb34:3b4b with SMTP id
 a640c23a62f3a-a7a87c006e3mr208357666b.11.1721732227410; 
 Tue, 23 Jul 2024 03:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEx7tvHe+yWAO1iXftKoVDSyAZJFbauRNkPZtPTlgWz5Ug1UR82mHbjHEXMSJooAXJRVukIw==
X-Received: by 2002:a17:907:d8e:b0:a77:eb34:3b4b with SMTP id
 a640c23a62f3a-a7a87c006e3mr208355366b.11.1721732226874; 
 Tue, 23 Jul 2024 03:57:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c926bc8sm528496166b.157.2024.07.23.03.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:06 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 21/61] intel_iommu: make type match
Message-ID: <bb3a23d5b0b43bed3c9a6ecf5a6871e2871be883.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

The 'level' field in vtd_iotlb_key is an unsigned integer.
We don't need to store level as an int in vtd_lookup_iotlb.

This is not an issue by itself, but using unsigned here seems cleaner.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240709142557.317271-5-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 37c21a0aec..be0cb39b5c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
 {
     struct vtd_iotlb_key key;
     VTDIOTLBEntry *entry;
-    int level;
+    unsigned level;
 
     for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
         key.gfn = vtd_get_iotlb_gfn(addr, level);
-- 
MST


