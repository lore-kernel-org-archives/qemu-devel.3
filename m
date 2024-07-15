Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3B5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLB-0004i3-41; Mon, 15 Jul 2024 04:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uOGUZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1sTHL9-0004c7-Cq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:47 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uOGUZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1sTHL7-00043h-Uq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:47 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-65f94703b89so36715987b3.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033144; x=1721637944; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WmRB0IiiVcJoW8Guf+AR/DDBZ7QNZLi0NBcwnWdsC5U=;
 b=VZYDARWtGBtV8/tIXFBOzsfw8i7pdAbf21D0xQogVh78Rq2Ul5a4wHl5K/0pJsGp9r
 9s+wEn5H+g5cmeTBbC3Y+Jnbd/svq3mMK8TtIuN4IVB09R6+2SSK3QiN3+x9Ah74cB2Q
 GVf1L+R0x0urWcGB9QUmeitPs1DBiNXFJsxumxthAI50BQ9Urt9MVVc3vGy7LvLU3z+s
 x70K7Xtv9dWF9Ir5sipjsB2Vn8GkXDu4jQdej8/+XbvyA9/F3A7mJZ9Qr8XAS0W/Zazm
 Woel/WvqEbK7jb8XHPTHieGP5EKm4vf35BFxa/abCfss19xlx+tzu8Aov1gQaRFig4Dv
 SeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033144; x=1721637944;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WmRB0IiiVcJoW8Guf+AR/DDBZ7QNZLi0NBcwnWdsC5U=;
 b=d619RY0sVLBBu/fQaNAhKH8mmw6rdZyEyBzwd0jDGXkCUQ5YkmvXNOKQqN1KrzdYn9
 lvoHxDJ3nMKa/du+gc1i4cUTpaLeE87GEgxGudFcqcFyANFq+lJQIxJVMKx3mCs64ctm
 hcHDipTE0yQBOTcL71aK2JWO+fPUesRfw8VzWAEklB7XVSC1+KUZg+0AP4rCvgJ8AIf0
 9T98QqZRJzwQ4A1JPRWyvI3EA28Q7aZCPNPmeYwH1d8JcalMGeYvgieSs5FOsryQ23LC
 +U87wAoi5+IMZ9VgLbr5g8A5YgdWWBH0zuwhofWOjbImZJm4SV9K5pDChhE2XQgOi2LB
 6YjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnmYZ6vyJ162WcQGl4abpg6ZDGe7hy0wxz7PTwo2apW5WGMScMOLjf8PpeP3e4+/xS0MMYpWf1WJQJdCMnMTozi4+KJ0=
X-Gm-Message-State: AOJu0YxIX6FS0emsQZmITOHPBYmsrOyLAExVdHkW3qAaGY9MicL1UOpY
 1FL+pfIpndCF8qdEMvOAOMJPcpCnRA1eiL09sz2xgGC82lbKrjtZ44+vqGi9s1UZaaTCT7sRbj2
 UG1+cWKGDPA==
X-Google-Smtp-Source: AGHT+IHkY4joZxpPBoOYPle6hjTkrZ50f80+fxDiFkYAo99eo4IbOOArX65KLgtOhVNn4L0NzOkMFVrx0fwQvg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:64c1:b0:62c:ff73:83f with SMTP
 id 00721157ae682-658f04e8ddcmr2119357b3.8.1721033144191; Mon, 15 Jul 2024
 01:45:44 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:07 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-8-smostafa@google.com>
Subject: [PATCH v5 07/18] hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3uOGUZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com;
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

Soon, smmuv3_do_translate() will be used to translate the CD and the
TTBx, instead of re-writting the same logic to convert the returned
cached entry to an address, add a new macro CACHED_ENTRY_TO_ADDR.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c              | 3 +--
 include/hw/arm/smmu-common.h | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 11cd12e32f..3f2dfada44 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -951,8 +951,7 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = cached_entry->entry.perm;
-        entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & cached_entry->entry.addr_mask);
+        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 96eb017e50..eecbebaaac 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,9 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define CACHED_ENTRY_TO_ADDR(ent, addr)      ((ent)->entry.translated_addr + \
+                                             ((addr) & (ent)->entry.addr_mask))
+
 /*
  * Page table walk error types
  */
-- 
2.45.2.993.g49e7a77208-goog


