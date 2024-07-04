Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952C9C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPEIL-0003gN-Qf; Thu, 04 Jul 2024 00:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sPDWx-0007Be-HS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:53:11 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sPDWw-0002Jl-0Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:53:11 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c8e422c40cso168355a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720065188; x=1720669988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=954FZtnJ/4RzyioUlGQPdT8LzFDA4On2KO0MEDyOHSQ=;
 b=h6is+Gak77uaRvH74MzbI6m8T4T8kqa0M8U179MuKO8SgpPPlwmZGovE3FnH9im/ma
 ymNs2ETGouX3AlIp+9anrxqOAmHiXDSshZxLRmWyxlygI6+6LDcayUeywL18GuEQh2qS
 PLX4gkze5r6VHCKLnBfoaSlPFoYOpK0uv8q62hBd9TZxJtfEr9J0LODpJ/sjo+uyXf7T
 9KSoxaPaqEOzkweNFYtJ2Mt5GkPIT7dSQ9lpVkl3YVGRUvECO+srr9RCzIawm3hQR1yN
 J13zstXpWsEkh7+OVy3bLZWkGjdDxnCXqhkKD0tOYbKh7TV116hQnf5//+ohDAfz2bP7
 vGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720065188; x=1720669988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=954FZtnJ/4RzyioUlGQPdT8LzFDA4On2KO0MEDyOHSQ=;
 b=frzqaG0WXDdIRNdChk5rSiyiygl0HKguhKsf3L4BFuV4+KNiXDUuFs2Es8tcBOFeWx
 IT+DZd0soTwgty3aPW0M5JYjoEu125jFpGpvoAQKPp00Q9IT5z8FbBkap7wcQn/BEf6Y
 wiA/7gMYtNFza7NSm/GtBZAXrIzLL3at9p4/xYwKLFiSiMU3IxS35GDzhUwLaacYUj57
 tEfv9ZadEtPoNx6AYTbLVyq4aVJG2WY8VL66nVo233xCuA1xeoGZfNzkCZKzlis4I8ka
 wD+tiuXCHYx3g7qIbDaTXaMFSAgrmkYT932+Rdcm+Lo29QzY2K8mC9PnL1WNXd6crhro
 6xtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/389W9PD8bWlmdSrTAY5ZCAQXpWbaDRObwrWgmUxw/evkkMJ0n4f+fTUEv8viS8H9zEbs5n2A4Ej4rcX9As1CQyra89I=
X-Gm-Message-State: AOJu0YxF9kSjEso5JuvIh7NZxpoMKDlOkExvl9Im911Ozqb30xVAfsl4
 xt39MOBysdAPsgcmMUp/OljqBoBr0gep0jy9E8+F1LIqFC8X0wAF
X-Google-Smtp-Source: AGHT+IFRMlIb1Y/nzC4AbH6bz91LMqWAoqdE4GHKAN0D40uVBdeFwbe6LoWEJMCtykolU1eTes54jQ==
X-Received: by 2002:a17:90a:7406:b0:2c9:7cb6:38b0 with SMTP id
 98e67ed59e1d1-2c99c694cdbmr302720a91.19.1720065187961; 
 Wed, 03 Jul 2024 20:53:07 -0700 (PDT)
Received: from localhost.localdomain (113-131-184-203.on-nets.com.
 [203.184.131.113]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a92c1ffsm364594a91.9.2024.07.03.20.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 20:53:07 -0700 (PDT)
From: YeeLi <seven.yi.lee@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, yeeli <seven.yi.lee@gmail.com>
Subject: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
Date: Thu,  4 Jul 2024 11:53:02 +0800
Message-Id: <20240704035302.306244-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jul 2024 00:42:05 -0400
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

From: yeeli <seven.yi.lee@gmail.com>

When dmar_readq or devmem2 read the DW of IQA always 0UL because
"& VTD_IQA_QS". So, try to fix it.

case:
after vtd_mem_write
IQA val: 0x100206801

after vtd_mem_read
IQA val: 0x100206001

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 hw/i386/intel_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 37c21a0aec..e230a45940 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
+        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS
+                | VTD_IQA_DW_MASK);
         if (size == 4) {
             val = val & ((1ULL << 32) - 1);
         }
-- 
2.34.1


