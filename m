Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43539C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Uu-0005Pb-Tc; Fri, 11 Sep 2026 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x52Q5-00049Q-FR
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:40:03 -0400
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x52Q4-0000LQ-35
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:40:01 -0400
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-530de452c33so2888141cf.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789137599; x=1789742399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gen85KNvmlBU17q+o2lsJIIITZCkVOcB09/l+2DpFIU=;
 b=kaWzpDJSS+BiMmZhI2hnMMocAizI6ZH/iJ6qArXEIu3QWewftG067eF72bvOkU4mX1
 gidI3seBlyIFBZKe2jpA2yDbfuu0oqKi1PIsE00eCQzzjenkk8eChEd+gMBV/vdVOGmH
 ZuCJDoI0ln3Isq1Zfd4HVa8ih27SdfJ9a6/dexsX7wCspd/nQ2SAjEYc3rymsXkKKqoN
 gzcwsSnz1N2R7FHLCPU6lvGt8yIgZofBQ5D8ozldwEhRQKyJ7Ygjg89cTTGTRZUYQxyv
 IPPEr40Jmiq7tU1PczDPIr72vph3OYFJDDxG4bIDd7lJd4vqnID0H4WS5YVCWzaru9v9
 S4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789137599; x=1789742399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gen85KNvmlBU17q+o2lsJIIITZCkVOcB09/l+2DpFIU=;
 b=bcBAJsp3+3Q/zsPT8iWSMp6NMI4nt42rhyyjSlpPgtLWO9LB5FhcprFb7MkuolPknL
 xq3cSfgBT9E3V48uALLGIilO9M0PxuBXwCqNT8pB4JEnJ+E6GsD022dUCvGgAGDlvH8N
 tT7lF6VK9Nsve8sm8sa76TmheHbxt/g8xAYjZtrJYrIIPyZq3Hs/ay8bi0oA/1J2oFtK
 KnD2FBBajhGz/r7VOnbPX3XBDROqrzRikwBTNT+v9iRaOzz/yYNY9mTcbG67shd8b5w4
 ZWT7TIqS6mfgeCQGVWDGrTjstGXL5tI8rGP7dKWdTKqRIOcwwNX4hTk3eiMhG3T12vgf
 yvIg==
X-Gm-Message-State: AFuF++nhADFhKZeqsEzaO53LoSu0mSnWDPlHIc+oC6kjIKV8v0hWXXgA
 12pQDtAu+UsZy3f20G4FI4B9SzdXLATgZiiFS1rMa3thGvgiPH4N4xyg4GC1iSRi
X-Gm-Gg: AYBFou39BNGcduQPKZdlymAt5g8VEP+/w5O//PwZNUI+COtIfmuX/R+b5AnxJ9sYhDq
 axXQxm0LTegsVJKhVG8VQ6bwgdC/20ptNSZA8E65XV3SmSr9hvqDHp1dOkJ1IpjgJF9e8pl1JUF
 vUkgfZS1OoSspNqqp+9/svJG8U7R5LTqm4pClt9ZgxRj+m9+3I4unKbOUYVILPNifwI9+oqnSGZ
 t3TbdFVeiPUp2PbYNSeupLG6wwPuT318wvuqUEhVvwn7W2gO6VJBGBoO3Buu9C6KZapnnpqFFbv
 U0eYsrLEvXXXzQ9gbTAX9sVzdx9Ghnc79Nb/GAgBbdcz99qPf4y/IODTvSj8GMP+jEUKayxVSBE
 K2JZqSd87/UFn16zzjcFg5wr/cuzzoEx7E8PIjipcJUf3N9FF6v0Rv3KjlHyQooMLzmaWVuB5I/
 OeRYvC4W7FSfujdw7vX5587/GUXhXXtZol6uWiRlmJI1LG6x+wrCdM4S4WXzJ2aoHjQ9PDM4raY
 tAiOTnbwnPVYOAKjw==
X-Received: by 2002:ac8:6106:0:b0:530:596:f70d with SMTP id
 d75a77b69052e-530c870ff91mr74788711cf.34.1789137598968; 
 Fri, 11 Sep 2026 07:39:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530ca30855csm21596321cf.1.2026.09.11.07.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:39:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vhost-vdpa: Avoid unbalanced IOMMU region unref
Date: Fri, 11 Sep 2026 10:39:55 -0400
Message-ID: <20260911143955.1601850-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:34::10;
 envelope-from=oss.patchbox@gmail.com; helo=mail-qk2-x10.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

vhost_vdpa_listener_region_add() handles IOMMU regions separately and
returns without calling memory_region_ref(). Its delete counterpart
removes the IOMMU notifier, continues through the shared DMA unmap path,
and then unconditionally drops an owner reference that was never acquired.

Limit memory_region_unref() to non-IOMMU regions. This keeps the existing
full-range DMA unmap for IOMMU teardown while balancing the references
acquired for RAM sections.

Fixes: bc7b0cac7bf4 ("vhost-vdpa: Add support for vIOMMU.")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 hw/virtio/vhost-vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 9e1aa4860a8..2a067afd0a5 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -487,7 +487,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
                      s, iova, int128_get64(llsize), ret);
     }
 
-    memory_region_unref(section->mr);
+    if (!memory_region_is_iommu(section->mr)) {
+        memory_region_unref(section->mr);
+    }
 }
 /*
  * IOTLB API is used by vhost-vdpa which requires incremental updating
-- 
2.43.0


