Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86813CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFi-00042m-Vb; Sun, 05 Oct 2025 15:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFY-0002pd-Qp
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFV-0006df-FO
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dvq3Htrv0viX4ei8ZfWqc/K5pFXyFBAcjRUr9cMuaQ4=;
 b=AwOyZXJclPSUTRap9crgLl5ZSd4Ftsr75S8auKPlAzFL1ISY13tkbreR8VL35rVq/H/cJx
 DYWRE3Q6l1tQmAdPh3QzAuHbrKlzNS8HemERmbk/xlG8b/oLfTOlfY2M848Nn6+q7PEW7T
 7D8a3tS8vk28hLtIyM+4s0DW7ZTLD1k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Kug0meQwPF6_ZLLJb1cA3Q-1; Sun, 05 Oct 2025 15:18:23 -0400
X-MC-Unique: Kug0meQwPF6_ZLLJb1cA3Q-1
X-Mimecast-MFC-AGG-ID: Kug0meQwPF6_ZLLJb1cA3Q_1759691902
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so2159591f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691902; x=1760296702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dvq3Htrv0viX4ei8ZfWqc/K5pFXyFBAcjRUr9cMuaQ4=;
 b=VWTZLZiD5qhhu4ELS8htmaTMn7reb1m7MndTwJpTebBTfY3hHn1JYWR+FzbDM88HLI
 a9yYU68mmVy673sPdNBtHNVDC6ttCxAhq6k8AEL8J7SdxAii2lAqS5qmr2vKUkPEQ4BO
 IjQiM3/8eAQ2ovtqu9q0AgkVJLdymf6iKpwj8QNnwPWv8n+wFwZhsGzp6sbSJC6dZohx
 Hc9X5SwwXuKaw6MySgA1oNRpKU6pQHjpg7gdTTQY5DSOoi2hQO9lwRGrAtcUVG7ec7h1
 t8E6HL+OcvtM3MCIRDkhFCOJYF9OOSsQaC3d7NlU9WNQp65TH5ytganwCImITKprH071
 G1ug==
X-Gm-Message-State: AOJu0Yz36kuKGQK/a0ZQsZUIIOjYZEOlKXYj8F2WOYalvrsASvAkcgHu
 EERO5v/WWe3vbmvDjAKWyz0m/Q9StWQbK9WC2ePCEYBQvrJvUIVu1bJwN0Q/cD6suK+G77ULnRm
 ZKgFLQ7EJaDvMYIaHMfg1ZdEBeuAZUc6oZNzzhu9/XFBneE9NuHVin0K9fyDN9L5qOqhy8WWCrK
 u1LpYQpXo3hCF6rbxl2QpX2AlGb2VeDGWngg==
X-Gm-Gg: ASbGnct8Y4Sogkz7MvEYDoSg12ejL9JbcHsxrfpsNyDetQQNOWeVgBkrSGt80J/4asg
 0cd9OPwbLO3HLm2IF53BHa/oWYno1TD0VeJvrKwwOm1YF9EbbOqgoCEZoKoHqUnEoHj+OzMMA0J
 ioQXQCWmEPO3s99rSzqW7V5F2YmbWXX9bYsGBQ+TLeBJH0TixAp5IknGMdJ4nQk4uYGS6zleN2J
 SC6A+NzUjiB4kYwjLUMmQr/cb+Q3sBpxeCbxALCNHWnd9szfNwxIZuHxt5Ydgyo+p1gV1h7nNsV
 PkqnpM40btwjk/HWs2BRmZ97FiPBAhLT6+5bAZU=
X-Received: by 2002:a05:6000:1acb:b0:3c8:d236:26bd with SMTP id
 ffacd0b85a97d-42567137c0amr6933064f8f.11.1759691901792; 
 Sun, 05 Oct 2025 12:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ1n0m53fa/ZPX2yn+NfRq6JZVp0siYDgYth0kFh1N4JL3vbSVdFYEQKmrnqoDnJbhXAKFlA==
X-Received: by 2002:a05:6000:1acb:b0:3c8:d236:26bd with SMTP id
 ffacd0b85a97d-42567137c0amr6933046f8f.11.1759691901244; 
 Sun, 05 Oct 2025 12:18:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a8542sm17441162f8f.9.2025.10.05.12.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:20 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 62/75] amd_iommu: Add replay callback
Message-ID: <20365b0fd2aa349f16c409638b2d99d7b478057a.1759691708.git.mst@redhat.com>
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

A replay() method is necessary to efficiently synchronize the host page
tables after VFIO registers a notifier for IOMMU events. It is called to
ensure that existing mappings from an IOMMU memory region are "replayed" to
a specified notifier, initializing or updating the shadow page tables on the
host.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-14-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 497f18c540..9027f7c054 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -918,6 +918,29 @@ static void amdvi_address_space_unmap_all(AMDVIState *s)
     }
 }
 
+/*
+ * For every translation present in the IOMMU, construct IOMMUTLBEntry data
+ * and pass it as parameter to notifier callback.
+ */
+static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+    AMDVIAddressSpace *as = container_of(iommu_mr, AMDVIAddressSpace, iommu);
+    uint64_t dte[4] = { 0 };
+
+    if (!(n->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    /* Dropping all mappings for the address space. Also clears the IOVA tree */
+    amdvi_address_space_unmap(as, n);
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2364,6 +2387,7 @@ static void amdvi_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = amdvi_translate;
     imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
+    imrc->replay = amdvi_iommu_replay;
 }
 
 static const TypeInfo amdvi_iommu_memory_region_info = {
-- 
MST


