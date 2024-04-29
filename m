Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E4C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hdb-0000VW-Dl; Sun, 28 Apr 2024 23:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DhMvZggKCikXRTXYFKFLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--smostafa.bounces.google.com>)
 id 1s1Hda-0000V1-8E
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:06 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DhMvZggKCikXRTXYFKFLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--smostafa.bounces.google.com>)
 id 1s1HdY-000491-Lp
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:05 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-61afae89be3so84379237b3.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361103; x=1714965903; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kQSHQ4bjl48E5wczRMJUqDVsdeVuhwGaWB+Kj7A4WsY=;
 b=Kufk/D15FaEOeMZ8bPgnGp2x07NgUvyZ7faS4SOwkwQB3Do7xha6MpE8G5j1grR4tg
 t4Ap0Fz6z4xIKtT29dUXgfL9EJheYqMqX0bByJyjB1W/I7MkiBSAcKr2JlmDMB3gFUTU
 IN8eKeB8YuVyYZS9C/lpPmiExjbl8T/QY6RJKUHsErGZsdwF0Etd6aa55F9HCpYJfJYL
 04+Y3gTPacycYZmwevyhaQ7Wsexb9TTh1kcMkX4E27NVndgYdBMWbyK6tcjuf949TVTS
 S+FRIjCzTAsoXb828LtO/BDZVlEaswxRCDftkmgEQlV4Qetohoc9b10KyT0HmKFLHDr5
 Ie3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361103; x=1714965903;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQSHQ4bjl48E5wczRMJUqDVsdeVuhwGaWB+Kj7A4WsY=;
 b=dVEQwZXkYhfOMaNxDvaodv3stdJAsSMC7Ykbx68gEzdcPKUPQS1+0QEEWqvjhA5Q89
 dk1NqUOWpc2UdeP2mavSIlDqMKd2fBlu85iti0BvcuTTtr91TIgFlvpUx2ghFJipDsxZ
 idhaWGTkTJhnZn6WQHIcyLsaewj+NMccKgH6odp4cVFYlVru3vx8c4Y9GJtVeTORauKk
 W4yIBCiEVvFFYKrFmSIPNeko3ea/HKoaoKfpzrOmFCfhkkoCEpTtHyt+s8tF/jAheMBu
 eGVl723fpB1yEAwqWfvTQtFvmHx1L1MnxY3sYj0rp9ENJcTKimlZ+nQ8ZClo4OzgIEnF
 z7VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWavQRwuehd2Y6Hzp629eTyiF7UzKN6MslVUJuZg7jW1JWOIdFB/NXFGt7n+vSlY255GY8qYFH5+A08STTL4kTgmhEwQU=
X-Gm-Message-State: AOJu0YzhbOGc03QkupEnjTUpIgGpy1zb6yQ8doDFpcxJntrNzp0BGUGg
 XzHJ/002kVg0TCFhfxQca7qbs2qOXbzel+XojAubXWFuyalfUXqvw/4kMhiF3nKalRo7scHI/pR
 Rq/h3bF9xlg==
X-Google-Smtp-Source: AGHT+IEEihisQcVfOSCXWkAdlTta/qFsp2lWKdxJceK3Mf4u+hCfssFO41A+q3TqTKjFBXvUokFvxwSAK5l6mA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:2187:b0:de5:4ed6:d3f3 with SMTP
 id dl7-20020a056902218700b00de54ed6d3f3mr3176328ybb.6.1714361102803; Sun, 28
 Apr 2024 20:25:02 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:57 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-14-smostafa@google.com>
Subject: [RFC PATCH v3 13/18] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3DhMvZggKCikXRTXYFKFLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs keep
the implementation, while only notify for stage-1 invalidation
in case of nesting.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c     | 23 +++++++++++++++--------
 hw/arm/trace-events |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e0fd494646..96d07234fe 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1051,7 +1051,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages)
+                               uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     IOMMUTLBEvent event;
@@ -1075,14 +1075,21 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        if (STAGE1_SUPPORTED(s)) {
+        /*
+         * IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs
+         * keep the implementation, while only notify for stage-1
+         * invalidation in case of nesting.
+         */
+        if (stage == SMMU_STAGE_1) {
             tt = select_tt(cfg, iova);
             if (!tt) {
                 return;
             }
             granule = tt->granule_sz;
-        } else {
+        } else if (!STAGE1_SUPPORTED(s)) {
             granule = cfg->s2cfg.granule_sz;
+        } else {
+            return;
         }
 
     } else {
@@ -1101,7 +1108,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1110,10 +1117,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
         IOMMUNotifier *n;
 
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
-                                        iova, tg, num_pages);
+                                        iova, tg, num_pages, stage);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
         }
     }
 }
@@ -1144,7 +1151,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1167,7 +1174,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
                                  ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         } else {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 593cc571da..be6c8f720b 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.44.0.769.g3c40516874-goog


