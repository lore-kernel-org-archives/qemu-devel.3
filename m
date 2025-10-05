Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED97BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFZ-0002s6-G5; Sun, 05 Oct 2025 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFP-0002RU-79
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFL-0006ay-KD
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qi2c6v9N5AmCZh3R8EnHA/KH3jdmBYOZ9DKao79FqjE=;
 b=XRzyR8I7JBmyU8JscS4unSRIZFdCXRYj5bHg4zARHptRrYbHquQ+wcKOeFWgjlwXh9II2+
 Nxj+b+wi19ZANNu7FCzvWS6qPpOGmjipLE3Ks6cg8hYCHTy4vn0sHYa4sXjKyXFxtSq89p
 0GBFu4dNnCvFCSTu37bBpeyWHAq3c6I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-2cFvU7-kM7aARIUlbLU0cw-1; Sun, 05 Oct 2025 15:18:07 -0400
X-MC-Unique: 2cFvU7-kM7aARIUlbLU0cw-1
X-Mimecast-MFC-AGG-ID: 2cFvU7-kM7aARIUlbLU0cw_1759691886
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so2032869f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691886; x=1760296686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi2c6v9N5AmCZh3R8EnHA/KH3jdmBYOZ9DKao79FqjE=;
 b=jCF2aeuf+ruFSbnAyYVtlAq9pP92Sg+0wwH2r3w1YHfl0l2jsb9PzVlLCxPm+VHf28
 /9VxZ6e0oRoPcQ90OXkOAHmZM31cP0D7jwwI09CK9xxicCmXTioActQWpZZaxOAKoF6D
 FFZRkSU78yZNcZVlof4oKUp9bRp6TPB49dKFxBAXQ+2NS/8rUlOxDDiOj/fWRc05ggq1
 XHoSSq4brHoyLGbZ2gq/GVrWJA/WgFbvJqslMtUrAmM6xhi4FlcnK0FbeIfVZhfGPKoM
 q/CxSkESAl+a0N2wf9G+N3QxHbxoEKSQmGGownhZG85YK/HuXFWoNMEeCup4X8ZA5E8E
 QjlQ==
X-Gm-Message-State: AOJu0Yz8El5AFQUxQuOxLfOzwCNrDcnZaSe5m1uN1GAeZmDFLDCOGSyC
 SDo6j+bD4YmXzC63hfC1KfyoYcpvMR6tjWibQOR4yfqezIHkSWMPnCJ7s1iHSf30qxlnkXsrZMR
 Pw7wy+KQ8eQSkYqJixCuuuaElRBOQlq9IEtr/Y7RP0k/ZM7yUHoQhhhYh2OZSXD8bP79rpcK+ET
 bmm5xV97xn57xBT5FoyjzUBUX9ZKZP/KnNyg==
X-Gm-Gg: ASbGncu/tlZAhlE4/I38YIRmoxyAG11ExXtZAVc6Z9vuGrMj3vQxzHTYjKC831x1CTq
 +GN9kegz6FFIfeT7XNCWBmcOluyC5JCQLlkChx/Majvjzsj2W6cG9g4QX2nLij9tP0sNK2+5uU7
 vGiZKuzavebacFpFD24a3diHBFFPp86Q6v0XLpff7SJAKQBvif3VJVXuFaM8NLPeOhXoEjCtCK9
 pxP0kBuRgsUOUpRLW3B50ekeJM7fWXx6PP0wX7cRS3iqdiAnC8cJAavFAZSb7PMncoI8IH4PVil
 hhdMvDB/nhdiyAY+bJdY0GAr3VrrQqLRxcSBPi4=
X-Received: by 2002:a05:600c:4e09:b0:45f:2cf9:c229 with SMTP id
 5b1f17b1804b1-46e710aec2dmr72682585e9.0.1759691886183; 
 Sun, 05 Oct 2025 12:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHep4BPcVEfCzoBqhT/DZHq8Cnwa8tVa3o9UiW2501ooZkE8V3acfn8TwmOUaZEJtjRYeIUoQ==
X-Received: by 2002:a05:600c:4e09:b0:45f:2cf9:c229 with SMTP id
 5b1f17b1804b1-46e710aec2dmr72682435e9.0.1759691885704; 
 Sun, 05 Oct 2025 12:18:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab960sm17428614f8f.13.2025.10.05.12.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:05 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 55/75] amd_iommu: Return an error when unable to read PTE from
 guest memory
Message-ID: <55d06ef8c9568761e2c92f4fa2b12e5b9465900d.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Make amdvi_get_pte_entry() return an error value (-1) in cases where the
memory read fails, versus the current return of 0 to indicate failure.
The reason is that 0 is also a valid value to have stored in the PTE in
guest memory i.e. the guest does not have a mapping. Before this change,
amdvi_get_pte_entry() returned 0 for both an error and for empty PTEs, but
the page walker implementation that will be introduced in upcoming changes
needs a method to differentiate between the two scenarios.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-7-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dc7531fd4a..29ed3f0ef2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -528,7 +528,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
                         &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_get_pte_hwerror(pte_addr);
         amdvi_log_pagetab_error(s, devid, pte_addr, 0);
-        pte = 0;
+        pte = (uint64_t)-1;
         return pte;
     }
 
@@ -1081,7 +1081,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
             /* add offset and load pte */
             pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
             pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-            if (!pte) {
+            if (!pte || (pte == (uint64_t)-1)) {
                 return;
             }
             oldlevel = level;
-- 
MST


