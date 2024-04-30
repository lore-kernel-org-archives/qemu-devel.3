Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DEC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgl-0006iR-0P; Tue, 30 Apr 2024 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgX-0006K6-V8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:37 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgT-00062C-ST
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:28 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d1ecaf25so8212261e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495823; x=1715100623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t+fSrRYl5L3yQvPVldSqnOrtZxoJXX623JAMweDjXA=;
 b=LX7u3B3KomLTQZZinVI25jA1zH0M9BBnffiPE+uUnsoe1JxtlVdkR2xzSZiqR8fSYy
 a0apJL3WGfp9X73ks4k8K/DZz1gpX7wzrYHD30P+BqM3LjLKMte9NagJmHvo+1enD4ND
 UMNlVxmRsv8rXDoFTJmg4yFk/DSihaszLIDiV/xIjN6vjHMBmSoRYSm2ucEp2Rl3F4ud
 eH2Y8t2oz8QQ7oUM+lwfO4ug0YT+HJwqo8S0eJXHqsUQD4OS4lGEZW2kvcyOOr7vR/it
 fxhrC8pVPxhFii/RHywMaWU5KJjkq2EcSs5Qydo9TV/ORke6/0DLRJdGKlRZIIybTul5
 dZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495823; x=1715100623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1t+fSrRYl5L3yQvPVldSqnOrtZxoJXX623JAMweDjXA=;
 b=QhJBpySNzrDyilAwV4RxVbPw0+ggM5HmbT+zzJ9qdbEY+ZDDEUQT6bcgZ33jLXtUEQ
 UEoTlO98TbsafSlQz66ILjWT9YQ4nZOXVvoMRS6kvIdDiSuQXBVZbhAs6W7ByPD1tISx
 QterC+J8sn9GAzR0FSnETh5kOfcI2mUmJ7jWzfmibryw7xJ2XCAmQA37+ga6Nz+cd7a6
 hMj/lJd6+/iDYdTvGxouMnWvEb8MUXmgbMpT9NmGt1n50q1lzWwbQLQ+iTjIYKIl06/p
 8vkDTqaTOnJC2SW3HpSe8gflUWLNr8fzUcXFCga2+Hs5656QeseR8+0qgj3Cjgu0z5Wr
 INfA==
X-Gm-Message-State: AOJu0YyAH5pxD/fWbCkF3A4ynrnKen1osZGoKBzOu0deySJWRShrI2uK
 OnvPD8HyTs1EbxV0TVgLBhymy0+P8fzxmRVCOBipHykoyEqgHONw4319j9N/
X-Google-Smtp-Source: AGHT+IH8tNB+OMEEjfoZnK00fenwXOTSLhumxvmYC1KCq8f4Ohl2Q8/E13IsvLGqDP3McXiamSkmOA==
X-Received: by 2002:a05:6512:3d23:b0:51d:682d:c2ab with SMTP id
 d35-20020a0565123d2300b0051d682dc2abmr35470lfv.32.1714495822602; 
 Tue, 30 Apr 2024 09:50:22 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 d18-20020ac24c92000000b0051bbba4541bsm2593600lfl.165.2024.04.30.09.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 07/17] xen: mapcache: Refactor
 xen_replace_cache_entry_unlocked
Date: Tue, 30 Apr 2024 18:49:29 +0200
Message-Id: <20240430164939.925307-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add MapCache argument to xen_replace_cache_entry_unlocked in
preparation for supporting multiple map caches.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index d2deff70c8..6e758eff94 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -556,7 +556,8 @@ void xen_invalidate_map_cache(void)
     mapcache_unlock(mapcache);
 }
 
-static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
+static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
+                                                 hwaddr old_phys_addr,
                                                  hwaddr new_phys_addr,
                                                  hwaddr size)
 {
@@ -578,7 +579,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
         cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
     }
 
-    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
+    entry = &mc->entry[address_index % mc->nr_buckets];
     while (entry && !(entry->paddr_index == address_index &&
                       entry->size == cache_size)) {
         entry = entry->next;
@@ -614,7 +615,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_replace_cache_entry_unlocked(old_phys_addr, new_phys_addr, size);
+    p = xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
+                                         new_phys_addr, size);
     mapcache_unlock(mapcache);
     return p;
 }
-- 
2.40.1


