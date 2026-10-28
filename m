Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5A606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M1YpLPpI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=g5k2CjX7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hy-0005CS-8G; Wed, 28 Oct 2026 13:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ga-0001De-Dh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GY-0003wi-QM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=816p1E+UUch2ibqqA8gEvAyCIO+NMBFukcb1/cGAUd0=;
 b=M1YpLPpIzf/S0F4FIDWl1SWqVD2IZAd/3ouQB0pZJBtEZ+q5jFM2mulXCSl+lZ6JHtjNY6
 N9pQd82HfTMw4PlxXnUbjOSuydzytQp9jntirWaI6AMlQtdUTZA2Ctc1INAXkLyICU2ggp
 Zc9PAWW8f3P1bIO74Upey40w9Wd8v5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-OuffnzXwPQm8Kx-QQAVXiA-1; Wed, 28 Oct 2026 13:16:43 -0400
X-MC-Unique: OuffnzXwPQm8Kx-QQAVXiA-1
X-Mimecast-MFC-AGG-ID: OuffnzXwPQm8Kx-QQAVXiA_1793207803
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso9025265e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207802; x=1793812602; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=816p1E+UUch2ibqqA8gEvAyCIO+NMBFukcb1/cGAUd0=;
 b=g5k2CjX70fLQn+6ZXSftRC/lmRngzquRU/cOumd8/zsic8VvItDwk652KPvHuobB7Q
 YszqHkUJavt6wpmd1RzZ/LAAU7h0Trc2f4chNAaYtF+nYA6ox60h+WQf3JhSqWuZcCfD
 5H5Uq3qpEOA9P43Ck1zI9kuzGvYO3A8whmryb4sig2pS50zOrs2oYmbwaQkPOQr5gUI9
 Iuvws/phQcl4DbGPQZwduBN5473iWPwZgNt7ugiWwZqo4haI/iEpYm21k0SkoFv7A0t1
 DEChpdY5PTfxXu0k25YdD5pxxlmiyrVXegAMj75SCKnMHNfZjIRW2ZQaYELflG0QmYhj
 /5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207802; x=1793812602;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=816p1E+UUch2ibqqA8gEvAyCIO+NMBFukcb1/cGAUd0=;
 b=NJSg34yoRLcZ6URgvqyuqV4ggbJSX8e3ky2b4+ZaIZ3IiHSQ0sgPanzNTM+S8hKC08
 Tq7vEVX2zatKZHyndpSoxfM/tNN9bbtQs9RLVv/dk2tk1tdZ2qBkg/FvxZTCMoBV70/E
 MZVn0ntTaY1Y/DUw3FAgtjWwxhNZfhFgHZ0Ct/v4TTsiadWdsTPTHyFVczoWAFMej+MW
 OeRiZRJll2ahJCiDcrN0ex6Hzl4Fmi+FfoNoBSveXwQvEBF8PwJVfO/uBpLLvSHpWFdh
 Y/0ldnO84QXJvNRsLP8oWsy6SgUeEgPi63wQ/7jJt3bUt1sqLTMA9073RqfY3c+Q3OfE
 hMWA==
X-Gm-Message-State: AFq9FYJEaCSN4uChSfHe2djwnfXpL/qW9KuMmffDUr6qFeuvBYwSs/Oo
 iKmZFK7nlVwY6SkGfY4fAlndJ9szSlmk1PvPEWxUu9A6ZYP8X2ft4ov6q1vhDq50SF5EOT6cKJf
 HQBtCJXdYw97fhR0vWEMuqgXV7IrOIUfqmLS2rQZdxmK2yw3InbTldlyE4sllA3Gm34d35T6N5M
 ErSNPIQTO6kJTC/TutomiYe8DpMoaDP+Bt4g==
X-Gm-Gg: AYBFou2dn8xX8yokVmfQae4wK3mny6x6MjMtgqxPbLIHo7K51Fw9h65iGMhgY6jyFiX
 bsg/2Flu21lwPWZeL9+mYoFY7GcyO1So4Alag6iAgEGcImy6c3dWZW8mRuVG4v/a6p11G3AIPp2
 JJS6Do0aELQNXWJmqg4ykXNkY3XdqJRA21jfiOIt4z50RbUpztb+aYRzS1j1QIsR5Pt5nwcOUqu
 Fh+xHjPt4O88lJk55veH62c+zuOpWU6Yx3TQJaz4Uvje7NDrrYJa7AI59EE38yI2FJDUk3aDvsI
 09fZdw2k7MVaTOuz1Lij+Ms3ME/4a16OVrjBG4b4SPp/FrAsvufz1hNaPbalezoqAlyLDtJMt0X
 QvLirt1t60UmP4pggUrULohvV1U8UULLSrFcXEA53
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id
 5b1f17b1804b1-4a966a56974mr66026055e9.18.1793207802582; 
 Wed, 28 Oct 2026 10:16:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a1:fb01:13 with SMTP id
 5b1f17b1804b1-4a966a56974mr66025195e9.18.1793207802048; 
 Wed, 28 Oct 2026 10:16:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f25fsm28867529f8f.2.2026.10.28.10.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 61/78] amd_iommu: Assign ioapic_as only when interrupt
 remapping is supported.
Message-ID: <6d5e16d4b2f580355f89596c50868aefb8e14ba9.1793207602.git.mst@redhat.com>
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

When interrupt remapping is disabled (intremap=off), the IOAPIC should
use the system address space instead of the IOMMU address space.
Currently, the IOAPIC is unconditionally assigned to the IOMMU address
space, which causes IOAPIC-triggered interrupts to be incorrectly
translated by the IOMMU even when interrupt remapping is disabled.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-2-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 56e7815412..817320c51c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2733,8 +2733,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+    /**
+     * Pseudo address space under root PCI bus.
+     * The linux kernel disables the intremap when it cannot find IOAPIC under
+     * AMD IOMMU IVRS, hence create a ioapic_as with root bus even though AMD
+     * IOMMU is not serving devices attached to root bus.
+     */
+    if (x86_iommu_ir_supported(X86_IOMMU_DEVICE(s))) {
+        x86ms->ioapic_as = amdvi_host_dma_iommu(pcms->pcibus, s,
+                                                AMDVI_IOAPIC_SB_DEVID);
+    }
 
     if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
         error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
-- 
MST


