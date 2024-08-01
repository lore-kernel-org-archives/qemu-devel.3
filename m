Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D9CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBW-00030z-DC; Thu, 01 Aug 2024 06:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBT-0002tp-VU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBS-0001qd-6y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOlVB7WwJCX9drLmyP0GySNt0EHrEKT86ZQ33vsIJ0g=;
 b=E1igy8ugbHygX4jz0tA5aLHhscy/hlNLE/aIAVIC9ATFwdjbPV7VwY2oxZH3SJN6LHHZcr
 GamgIsY0i5NVfcV7+kLPLacAUg9t689vb877ziHjrP1+IT2N7b1/yDUMxdTl49wtTuASv+
 kOSHm6K7xtjtsR7gVOcUMErnysAVT8o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-v5c0E_hyMQutuZxE4jXHAg-1; Thu, 01 Aug 2024 06:37:20 -0400
X-MC-Unique: v5c0E_hyMQutuZxE4jXHAg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a2ceb035f9so2660664a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508638; x=1723113438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOlVB7WwJCX9drLmyP0GySNt0EHrEKT86ZQ33vsIJ0g=;
 b=Oxs4vGXGOLiG4O9ovYz4W+BF77ESZSn8iRqHMu6nJnMnAm/4Uybtr8rLvEAjslw4ab
 vqfTNhtDBy33DQsgssL04cW74EyvdNecd8FKOJPFNjZsC81P/nUJF7XZGAu7xGMTZAaW
 E57pv38GtHs+/ucP+yeGjQIUuO3zmkxAAzfojx8nTAoj5idctg4Xbz6QFTRsTmlXlxkK
 oX6WW+3Up/NU5yFIfOVcxCNVQ2yroUiSMBlj0YgD+5CFub9X3iPi77ia5Qgr5fRFPAeO
 yehReZ6HH5/tqIrOhvqW0MN2/f1WKfC2X1ZbrEmTd6QvByYQokIuHw2YlB7HmyhJ4S0u
 fWUA==
X-Gm-Message-State: AOJu0YzD7+CmTVuPTDHtvKIzSOVXX0tKc12d98MH1t+D3qHTkDSyp5Gn
 KRnpeZ8RT7m2Vu6jrg6drj7SClDw3myVJImiV3iQDYLIKMsWyMzkaXc6JTofuuA+Tadd6Ix0tUI
 VODhkkAxsWCL8RZXl2NJ22K/92Y97nvP1WMWrUO0yodMT/T+uaPiWU3LMlmWWBW4XlPdnNPtwTB
 1rpKgcfrz0FTDD217we5iPDsyOPQCtww==
X-Received: by 2002:a05:6402:5253:b0:57d:455:d395 with SMTP id
 4fb4d7f45d1cf-5b77c28ed64mr760776a12.7.1722508638469; 
 Thu, 01 Aug 2024 03:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZtd/mEIqzI1B9QmqIuimkJW+I1NHLRLfmldGQsR4vOaGJA4TqYolkGo9fXOdbmiDQIGGZbA==
X-Received: by 2002:a05:6402:5253:b0:57d:455:d395 with SMTP id
 4fb4d7f45d1cf-5b77c28ed64mr760733a12.7.1722508637828; 
 Thu, 01 Aug 2024 03:37:17 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59cb0sm10049005a12.45.2024.08.01.03.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:37:15 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:37:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/19] hw/i386/amd_iommu: Don't leak memory in
 amdvi_update_iotlb()
Message-ID: <9a45b0761628cc59267b3283a85d15294464ac31.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In amdvi_update_iotlb() we will only put a new entry in the hash
table if to_cache.perm is not IOMMU_NONE.  However we allocate the
memory for the new AMDVIIOTLBEntry and for the hash table key
regardless.  This means that in the IOMMU_NONE case we will leak the
memory we alloacted.

Move the allocations into the if() to the point where we know we're
going to add the item to the hash table.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240731170019.3590563-1-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6d4fde72f9..87643d2891 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -357,12 +357,12 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
                                uint64_t gpa, IOMMUTLBEntry to_cache,
                                uint16_t domid)
 {
-    AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-    uint64_t *key = g_new(uint64_t, 1);
-    uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
-
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
+        AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
+        uint64_t *key = g_new(uint64_t, 1);
+        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
 
-- 
MST


