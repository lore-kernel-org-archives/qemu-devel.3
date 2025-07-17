Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E61C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 22:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucX0m-0001qb-Ps; Thu, 17 Jul 2025 18:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3w2N5aAQKCrowpnwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--rkir.bounces.google.com>)
 id 1ucVfj-0007eU-Pw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:57:44 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3w2N5aAQKCrowpnwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--rkir.bounces.google.com>)
 id 1ucVfi-0005S4-Av
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:57:43 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-3138e64b3f1so1900151a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752785860; x=1753390660; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7GNLAb9+HAgXzXVkivfD2j5NSWuBMdtsr/kW1eIs5w8=;
 b=Vwa+hqyjIVAjwfNyVJCxMWg2hl6ReRl/VL3ZrMH2xDpD/vD+m2MroomtYkJBwSgF07
 AGaNAZojCgzA7wSzCU1a3bv58jugvCjogqGFuMnPrvYSLyuFD7dK20ldrSS92XgWglO8
 kBhhQWQD9rs/DXLBJ/pam6sZH+kdPf1aG7Qbp/KY6QVhUhqVAT0TN+AE5Xy3uac3exkp
 0Sz0gDGs2vC7qsfqieEWddMAdis0YVmH0gK7sED1m08g6JnuvrGLJjmWipVBF1d0W0Zs
 c/AT1WjAJs54MSicn72tFdEgMvQGTETUAOgvnwUyuOvoz7DPT1YhWe/GZ1XgFGiLHk2S
 nVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752785860; x=1753390660;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7GNLAb9+HAgXzXVkivfD2j5NSWuBMdtsr/kW1eIs5w8=;
 b=XsviQKwyKY1IFePioY4h/GChNxFadhmbXbE/kUM5LycGF/0xaIcW8LQV22nHeEj51J
 9liDYElED2nGIC/2kB/o6LxwE6WW+iYwpTBM15WklJ/kziDCzcnOgV8GHxetrJViWeYS
 Hq94Vw43P9VvlO+h3vVrQSzL3f5Ha3c8dBa8mdh1jbeeoG0KW6NnBfpLighoK+6viVE/
 bQcF3cMEOc83CjIBww/Z50DbEsVB9b7VTLzP90kWiVCx9vL8s8Qdce7RdFNPBLRIo55y
 R3s/3Z3jiI7hv+rNAHwawRkNmDgJyaOLT7Nyz+tLmhUWLSMiVRppPOHkJJg0xRtG2nbA
 UuNA==
X-Gm-Message-State: AOJu0Yzk+hoNnib0v1mqL8ugM9qx3mtzV027vpPwpTso4hySmrSmdP+f
 KjMEfxshZCUUjpStkLH8Y9jwAEJakWcn4+j85AWqWgybiVkoUe2CrGlqxzOqYuYNg7mKvw+ceD5
 0BoJx5EVEmELJE0B6FWZEPLGG9+FJxbM6Wmj0zKFvtx5GaDLPf2vLnBsFZFRl1JYvz1uacylkhY
 0UIFaZOSySoAZZqUB4ewo6AlTc
X-Google-Smtp-Source: AGHT+IF0S3FJ39z89y9XS8sAMGlgwSJ4VPdn0F/0DbDjr/DMlFKKEoR8B+TWvuR0qDsvTcUNxLvTbyyo
X-Received: from pjbme10.prod.google.com ([2002:a17:90b:17ca:b0:314:d44:4108])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5846:b0:312:e731:5a66
 with SMTP id 98e67ed59e1d1-31c9f398bf1mr11315983a91.3.1752785859814; Thu, 17
 Jul 2025 13:57:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:57:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717205735.2345674-1-rkir@google.com>
Subject: [PATCH] hw/arm: remove `inline` from `smmu_iotlb_inv_vmid_s1`
From: Roman Kiryanov <rkir@google.com>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, mjt@tls.msk.ru, whollins@google.com, 
 jansene@google.com, jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3w2N5aAQKCrowpnwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--rkir.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

this function is declared in smmu-common.h without
`inline`. It is also used outside of this file
which causes linking errors because the non-inline
version is not generated.

Signed-off-by: Will Hollins <whollins@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/arm/smmu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f39b99e526..0dcaf2f589 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -319,7 +319,7 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
 }
 
-inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
 {
     trace_smmu_iotlb_inv_vmid_s1(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
-- 
2.50.0.727.gbf7dc18ff4-goog


