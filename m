Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444FBC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGq-0004mr-Fn; Mon, 14 Jul 2025 19:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGW-0003cg-F3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGV-0005UW-2B
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6HCjFtnqBbcdRuGAnX2gaWDHRpcN82xm4JfTd+zMno=;
 b=HgpDAgdp8a6Z0J+vMWZPxWlGowY1KtqgJ8kwHW9+gBsI1N3XWTn1nyyOYp1XwI6yxoT/Uu
 zO9Lq98+dqDK4jBRiOuw5UjEDawexq/7sKwPBmufciSu9bPZsMN1nTyQ5kQSNSiudy5K8N
 baAl+i0Ps0zZhr/EoU3nEUqN+xXFNyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-2B12DhC3NfqCFjMAFLIOgw-1; Mon, 14 Jul 2025 19:07:12 -0400
X-MC-Unique: 2B12DhC3NfqCFjMAFLIOgw-1
X-Mimecast-MFC-AGG-ID: 2B12DhC3NfqCFjMAFLIOgw_1752534431
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45526e19f43so12569915e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534431; x=1753139231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6HCjFtnqBbcdRuGAnX2gaWDHRpcN82xm4JfTd+zMno=;
 b=aQs8jRyGnJ955B+mGJFKuAcbIpwX9pP5Rv/M3+PUJyEOuREdks6fUeEBQ7XIZF1STD
 hfGmNAeICSiEXM6rWs7X0Jrxvmy+0PEtTJOK7/NkAp6SPcjI2aIobTFstGrO9FFvzkpS
 JzRXdfMMrO7V3byw1zsAC7FY3+QwtwECQHKP8XGZhjXYrqZf3tymYb6DhSicetYweSHp
 x5nNugQWdV4j1ER+mmUHW986WDtuYvHE5hbohsTcbL9i4e0+yKfsbXS9bAKHN2OgRvGE
 9buUkMydBsJWCtNmOyjMkf1KDvwcjIU1p5BbrAM4KHJET1uItjqQClFgbN1tTqak/nyY
 WmTg==
X-Gm-Message-State: AOJu0YzQ2gL5kXnwZqD+09C15wgUeegGtdGOtVi0ZAscc0c+yKgDiJdA
 qQIm9b9Zrcdjxi6uvO0qa6Iw3de1Q8X/pOFw6gTwWfZsriyIrwmtSzWKLEmNe77GI1FatJzsWTs
 DuATD5k0oJFND8wx1ZvS7P9ezJqPx0C1coDLkRvLKMN2wYuB4V2ND//VZNg595uVBkk8qVeeWQw
 O++EpctjksEsZo2zeGjb1q4/KIng6Wm+7jkg==
X-Gm-Gg: ASbGncvuVhspnURpvjkf/f6bF0yOKaY68rI7zK1J9I1ce76Z0X+kq29m12eMln7QOrK
 K+ti/TrIS8yedhfD288nMuCFHV+eo45bczBjvdHAOGlXaqIAQYBoNCH4A2O8ixTkmIphbcoSmqa
 uxK2Kt7TQgCCcXycKQ9bBQSNT696UQET9u9A36YS8ZWmHf1mm1k21W4dqvEOPBRRBhd6K+DNONW
 vCen1AM9K0+ojqnTc0/M7ewp7OPtBI92qbnCzay6adDAzig7JHsOVGknMZtedxST6oJzAnaSPgl
 xwZHQ4FCLIvhCrQD/puRKENlG9bBnfX5
X-Received: by 2002:a5d:4c4c:0:b0:3b3:e3f6:4a9b with SMTP id
 ffacd0b85a97d-3b5f18d9726mr9692390f8f.41.1752534430865; 
 Mon, 14 Jul 2025 16:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHguxpAnwlpuCW/9IP+TlatV47K/ROse7sMo3C9gQoqtiqbvyNxP8t12j9Daz4UFQ58eQ58Cg==
X-Received: by 2002:a5d:4c4c:0:b0:3b3:e3f6:4a9b with SMTP id
 ffacd0b85a97d-3b5f18d9726mr9692356f8f.41.1752534430345; 
 Mon, 14 Jul 2025 16:07:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2710bsm13507621f8f.99.2025.07.14.16.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 22/97] amd_iommu: Fix the calculation for Device Table size
Message-ID: <67d3077ee403472d45794399e97c9f329242fce9.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Correctly calculate the Device Table size using the format encoded in the
Device Table Base Address Register (MMIO Offset 0000h).

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-7-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6e78047919..92f94dc788 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -665,8 +665,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_DEVICE_TABLE);
     s->devtab = (val & AMDVI_MMIO_DEVTAB_BASE_MASK);
 
-    /* set device table length */
-    s->devtab_len = ((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1 *
+    /* set device table length (i.e. number of entries table can hold) */
+    s->devtab_len = (((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1) *
                     (AMDVI_MMIO_DEVTAB_SIZE_UNIT /
                      AMDVI_MMIO_DEVTAB_ENTRY_SIZE));
 }
-- 
MST


