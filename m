Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfCTGNvR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jPFvH2wZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IG-0005Ou-1t; Wed, 28 Oct 2026 13:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gx-0001eD-B7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gv-0003zt-4c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUht6RxDnl/zXalqSlPXdqFS4O7R1iyd+udLblyz8/g=;
 b=NfCTGNvRbNi5MgxFIbqzU4rMX6syj/jvMyeT/ov5B6CwrMggDtLF5vtu0vkZHOeGoUqIem
 ALmBzOI+SbwFcOJAx722B7SVhgpJGXNzlUDnEw9rpMvIW+BQhwdC5NgY3l7Pa5Vr+GnL6u
 oC02bIyWlG4rx8pRQL3huTv6kJ3YJDo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-J2-1a37kPDezrgEId_kyJg-1; Wed, 28 Oct 2026 13:17:03 -0400
X-MC-Unique: J2-1a37kPDezrgEId_kyJg-1
X-Mimecast-MFC-AGG-ID: J2-1a37kPDezrgEId_kyJg_1793207822
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c293e604f0eso131120166b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207822; x=1793812622; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pUht6RxDnl/zXalqSlPXdqFS4O7R1iyd+udLblyz8/g=;
 b=jPFvH2wZZtM1eDQFtcv54aZrO4LuU8rVZB9x8Yg7CgF2gvVk533OWo5SwOLh0bwu7X
 2JYCe+bL1zgbbSUumSVK+qtgTreAyewN3uvFQ3W3pNbKuIYH7wnWjg5lK9Qu/42QfTK9
 FVjCDD4DOnIiQBEEKLVsTLst+9JzWWjsHsRjF+5SROKbB/pmbHjAcGbZiGrYuvd/fGQF
 oaWZFvq+yYXAp3E3PnhC/jsYeOVuhbPSjaFX6ye5+2wAYSm85JpVbahSGtgkVXbm1ywl
 z7u/lDRFhbJHInWtvb1WtJ13Ke6x4/7SMk+JrlGGxo2+GJYQpAb0CVdgyq/5PEpXmJBG
 ze7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207822; x=1793812622;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUht6RxDnl/zXalqSlPXdqFS4O7R1iyd+udLblyz8/g=;
 b=z0JAI7xLhior+OU/4yeWGQd8VJWn5oq5JcTC7kz9Au+imDiuH5/NO+FEgao9uCIsio
 d+P0sG/OrLuMeT++C0FphEg6poJ//4c1p0rkYG2cw5Q5G7A+mizpcEhE89Mv8tYFLFr9
 oV8xVlbuYTN7t9wU2GOF4lf6q5z6Vat8iZgpesUY+L5pcmImPR8ocZhFYnTnPR8rXoUM
 8N+RC37wgH5rjpvILvyP2DQwIHxXEU5ZhOYIIxf20b7l9wOpZZ4BYNUCco5DeebcnXja
 B+Jf+Tc8LES2Y0qMozZeut21EjBgexEK0LSgMcpON0d6KGMzA0ZND8xBjk3xbBlFy4PM
 0iXw==
X-Gm-Message-State: AFq9FYI/oKLRdSPjrWyGSj1BP0n3t2VzC6KTezdl7hJFQrXMlZ7+GUWS
 sRnrok0p41eOITXLRRqpwxNFq6x29nTE3wIsv0VZeP7PMaR9fs0GHiE54jxSaRGFQDjD9mixBCC
 e3zV3OAJikDpPV8KMCb0NXwZBuE4fv47Yk9Qv7oI4aGk2jSWswS+APTeYWXNLzQasWjKT5yX/Po
 FKNuqXgTBzq5P4lhOySinAlKMjUh6CAddgBQ==
X-Gm-Gg: AYBFou0b4nzd9LHsb8nwn8FWtLrALdpEsY8ma5JN5QhWFmCOY91kosgOGPsG2Tg40hV
 isyjjd6PVNfXLjCpWpwPkTWUdmYlsVyaGoKGa/ioy0V5qAaXrlRI5ODYsB1eWoYjBBV5SDX178n
 Qc1d8fQ9dLyaA6WF6OSPqfMNCE3+1UDD0tejWyTHYDiYYCBA0NaTL59POT/jfiPWExJTyGBoGkp
 KsAFLaNKeaFve6FTxNukGAzP0KFW9Qg5iphzP7OO0Gyl/57WCcrcKLP1LtQkHdjGWodzHoxiN/Y
 8/Za0kGGqB8gyvQXNpcZ+8zHpU3Oyq8MtnuXhztyRuO6Eq9r5bwLWrfVrtnP9QvdHURgZIolHMb
 f4nxENZULDtpk4AYphsPbye7K+BUS8apYupOOTnso
X-Received: by 2002:a17:907:9349:b0:c41:e0c0:e6b7 with SMTP id
 a640c23a62f3a-c49bdf25521mr272854166b.12.1793207822065; 
 Wed, 28 Oct 2026 10:17:02 -0700 (PDT)
X-Received: by 2002:a05:600c:609a:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4a963ffb29amr63997515e9.1.1793207811365; 
 Wed, 28 Oct 2026 10:16:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f418afbsm6825235e9.6.2026.10.28.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:48 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 64/78] intel_iommu: Add support for get_x86_iommu callback
Message-ID: <637dfc409e1f0f5c33651e3d1f0d6a4a719fc50a.1793207602.git.mst@redhat.com>
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

Return X86IOMMUState during get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-5-sarunkod@amd.com>
---
 hw/i386/intel_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 350d2b7753..3686ca8ba7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5485,6 +5485,13 @@ out:
     return ret;
 }
 
+static int vtd_get_x86_iommu(void *opaque, void **x86_iommu)
+{
+    IntelIOMMUState *s = opaque;
+    *x86_iommu = X86_IOMMU_DEVICE(s);
+    return 0;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -5559,6 +5566,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .pri_unregister_notifier = vtd_pri_unregister_notifier,
     .pri_request_page = vtd_pri_request_page,
     .get_viommu_flags = vtd_get_viommu_flags,
+    .get_x86_iommu = vtd_get_x86_iommu,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
MST


