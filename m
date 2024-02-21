Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA06C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqDt-0000UB-SD; Wed, 21 Feb 2024 12:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ITDWZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com>)
 id 1rcqDr-0000Tm-Np
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:31 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ITDWZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com>)
 id 1rcqDj-0007i9-0c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:30 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc746178515so11409832276.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708535841; x=1709140641; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X/FmD0tvEMB0vrU/lqftU698V2aAgtD4PqSjN/oj0ik=;
 b=NP0af65uwwiHhY/3RPZvgU8y9Tn/cVaA1kvRbA5wX8koklj09r1ZEHPCykW6pikKQ5
 07Jw4nX7mB38TXjR6HXcyp2m7m0ou6795wZPLxE8rU2eFaAvS3I4bo7+TYvMNLDO5Q0i
 eXOZc5Nob17Z2ySltYYFNnk7coZVglCiT8f+ia+iqn4VdgVrqEBmaQ4nWUmn9OHNgyjF
 Sn50UGosTPLNwwi/IQkTJKnY4m6LYHuqqeGW6yqbL56NCKJCfrGyJzVtt68fs4+zIaS8
 hNBqgbfHjtGYyyPQXBzmD/4ptw8wWOopxZ45d5aA0n40FB2LTyYw4FVJ7HXfuNPGsrbs
 mIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535841; x=1709140641;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/FmD0tvEMB0vrU/lqftU698V2aAgtD4PqSjN/oj0ik=;
 b=Q43kZYnYnhwK5CVsPQSO6Zu3mEY+OiwXZ+aoksXQj1TdwNOBnJOjYPavyh0TKeLjyP
 gxBoY97wnpyCpfMTayhm5yrfaN/LuIRoP9tfSetiZ6408brvOrrkOyAwOhppq+rmZm5C
 Rde0yv2LpaGGNQb7cJVpqT1sgNb3iFZjaSoMCR9PwSZI3xBP+xq8rN/DnNKXyA4mEDqO
 k1gG6G0PC2XvQuN88gJyY0O9eOZFRbPS8Xa5J03+Ww4jOvJpzM+bzzK+0dNR8SQ2PsCY
 Ep+TRT2NUXZWTbhOTO+QH3BOmqsB/l+g3slNkJQcUvqMsD2SEDchUZldQYpF87RxljtC
 O+Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSpqbS6fU/BMzFZ62271UprHnMcqeJ5jCQb79L9h3kJLclr8iNpSLJ5iMlJg6TXW1ie3Z68DKI+XlJ2oyNWurcqbrjIs=
X-Gm-Message-State: AOJu0YzUqgLs7ER4FdNi6xbfCpQHXSosGrBrv4XarGh8TLqDLSoFdZ5d
 aPva+XwcemVafmcPQQ1UJnlhs6IRxG1pTFP7vxRpg8KmrLZulH7NqZWd7S6Hz5zFKVZr8lFWqYo
 doqSwwWAxe4emPN5/PoMC9dxEcg==
X-Google-Smtp-Source: AGHT+IEhGM5FLCTGtFXsQwxMDuaGkuJ6MYzn1t9csUFbuRHUGHgg+LsRvr8l4PJu+zO0B/ZCtjUK56p+pa+bSg1TNb8=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1208:b0:dc6:53c3:bcbd with
 SMTP id s8-20020a056902120800b00dc653c3bcbdmr4675123ybu.7.1708535841023; Wed,
 21 Feb 2024 09:17:21 -0800 (PST)
Date: Wed, 21 Feb 2024 17:17:15 +0000
In-Reply-To: <20240221171716.1260192-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240221171716.1260192-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221171716.1260192-2-nabihestefan@google.com>
Subject: [PATCH 1/2] hw/arm/smmuv3: Check StreamIDs against SMMU_IDR1.SIDSIZE
 value
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, 
 roqueh@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ITDWZQwKChA3qryxu89uvq3w44w1u.s426u2A-tuBu1343w3A.47w@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01, T_SPF_TEMPERROR=0.01,
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

From: Roque Arcudia Hernandez <roqueh@google.com>

Current implementation checks the StreamIDs against STRTAB_BASE_CFG.LOG2SIZE
register field value and a constant SMMU_IDR1_SIDSIZE which is also used as
initial value for field SMMU_IDR1.SIDSIZE.

This limits the possibility of extending the SMMUv3 by inheritance and
redefining the value of SMMU_IDR1.SIDSIZE because the check is hardcoded to the
constant SMMU_IDR1_SIDSIZE rather than the register value.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/smmuv3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9eb56a70f3..a01031821a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -580,15 +580,17 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
+    uint32_t idr1_sidsize;
     int strtab_size_shift;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
     log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    idr1_sidsize = FIELD_EX32(s->idr[1], IDR1, SIDSIZE);
     /*
      * Check SID range against both guest-configured and implementation limits
      */
-    if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
+    if (sid >= (1 << MIN(log2size, idr1_sidsize))) {
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-- 
2.44.0.rc0.258.g7320e95886-goog


