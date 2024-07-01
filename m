Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA40C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqC-0003GZ-LL; Mon, 01 Jul 2024 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-4yCZggKCloKEGKL2728GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--smostafa.bounces.google.com>)
 id 1sOEog-00027P-6v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:26 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-4yCZggKCloKEGKL2728GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--smostafa.bounces.google.com>)
 id 1sOEoe-0005Hs-M7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:25 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-62d032a07a9so52121297b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831803; x=1720436603; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UfBJyxBJlX36JReOZrhuuKa8JG/QE6j++ZmqLb/7jGE=;
 b=EzQ/ju5iI0L1RTCH7pbNgBqmtKm0Bt2DwwiAabruStqjCa8rNVj+R5vTEGCQO0PpFb
 MkFTuLRy3mS1mbCjQEBwzJiYQasC+Ib9d2Vu/LdEEeBqdiSQkSj1uD+lWX1c/6F+Zexe
 YBNMppHDBR3hSwQGufgRwVIdgkirmmpSHtym9L1r4Qij/kWkcWy0dJoxwO5m4pv4AuIQ
 awIWsyH/Zw+QKIQIT8AXwwoZrRPCwTPdDUbJHrW1Dpt6EmwDLe6sc9fmhiKPrLr/WKor
 aUg/JveFRBbsnWFMyHKGy5Ts73s+fXVttfxFCo6Kz2txeCOLLcGBM6iZvobYq2w5zgl/
 KFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831803; x=1720436603;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UfBJyxBJlX36JReOZrhuuKa8JG/QE6j++ZmqLb/7jGE=;
 b=e0vb0O9honfFvE1H81pueFnVQzR+B0tyHUeLBd7z8VzKnrWoVJqhasV54s9NA6Mvsf
 oebp56qTqaxvuGAyv4iXUQzCqfipTnDV7vnLlaO35uX6EiRzePqB1grPmGsRY/b3hucG
 mINpxvvhlgvyMyd9HekOMrvgK1Hvzj64D0yP601PDP8EER8QhXePoFJCgY2JH4EovMbF
 m0U8rU38lwTuPvCHkl3siq+jHqZLUjmvJCQxTUGK8mdImVYjBvlne01RBPXa418h14S7
 uqNUiMfw2i2jO/km3kqJ6CBmmAbgN1y1eNMXuwyt9/TH9Y6W4kUAXB03KNYvapthvJc7
 sIPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNoIioxGUnNVM1k8sRh/9njiXBXLll/D6cF1ANtpWb8j51+9noFs/BPztDkqnyrdZGy9idKJW3tsJZQdWBYXx9KJxZfck=
X-Gm-Message-State: AOJu0YyIWF3rbKHAkVuhxUPVilxRz2EgIPdIuK7v5xyI9cu9cMURMtif
 ArA6hXKr40aqpErzD/H+5VspB7VjDAk/kgtkFILEO4Wu/9BXboBy13xWSJtOnTC+pl/AINgNERW
 Kjvv4bmPWrA==
X-Google-Smtp-Source: AGHT+IG/Fq2m8cESYu8kSPxryk9xDGzQ8B4vYXhoSYRAV11KJ6UaKbL/GvAU4MD78NH5G2gXWjssOCLkrFQKEQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1542:b0:de5:2694:45ba with SMTP
 id 3f1490d57ef6-e036e6c3acdmr558657276.0.1719831803084; Mon, 01 Jul 2024
 04:03:23 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:29 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-8-smostafa@google.com>
Subject: [PATCH v4 07/19] hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3-4yCZggKCloKEGKL2728GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

Soon, smmuv3_do_translate() will be used to translate the CD and the
TTBx, instead of re-writting the same logic to convert the returned
cached entry to an address, add a new macro CACHED_ENTRY_TO_ADDR.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c              | 3 +--
 include/hw/arm/smmu-common.h | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cc61708160..229b3c388c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -950,8 +950,7 @@ epilogue:
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
index 96eb017e50..09d3b9e734 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,9 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
+                                             ((addr) & (ent)->entry.addr_mask);
+
 /*
  * Page table walk error types
  */
-- 
2.45.2.803.g4e1b14247a-goog


