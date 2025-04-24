Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C96C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAu-0007dF-4x; Thu, 24 Apr 2025 05:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAs-0007ce-3j
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAq-0002Zd-CO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so513006f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488034; x=1746092834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+dClDFlT5FzPOmVGUogkFyrT6hsGGcZxW7y5tMgj+s=;
 b=KbADdO92CIGfFxIPHuzkaQozscuO0Ewm2Y2fh1XKiYL5KDqHBTWgnwdgufo0GfAq1C
 Oa2rVWHL3Gzp+j7DZ5r63WPFxLqoudv9LTzrpEPH8bW67zSZaZJ9Ho8ZBSxvOFohyZEL
 ud1X3L07L0ciujvO2zqqwVigzJvfKmn8K5eSwFVOswEwtLAYk4IXL1pLyHohcVxh4fH7
 3NDCdC05Xmz2wse1QzLmBBuza4qW/ft3FW3pMN+xA4Lpc9nEebRkInGLf4TlNR98VVA0
 FI+uXabgvTfhXVgS8ujtTxY5XW3TurrFWDtTlM8WH5KPLba/mBlMXrpP+ggUngfR+A/k
 yKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488034; x=1746092834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+dClDFlT5FzPOmVGUogkFyrT6hsGGcZxW7y5tMgj+s=;
 b=ni2Pq4K5a6k/JjKjtEIVXpWCw54U2Y5rC7ODxh6HYHktNxKT93J0E98UnvxpWzlQzK
 aO/dKzl8TeT5Aw6SQEmhNI/s91fdC2pszzadluHn9RwZMd7E6BPcmkwGR5svD2aRKJv8
 kzrrX8Bj9VMyfPb4UaBxA82HZus+gvwvcVCFiGL8LkNs5gzPOZtzRXagH85xgN+7rT6u
 cJedmmmZBqu/kgE/DwQ5sNlF2RWfg3q7a71IEYLhbQDhS6Ml0oMScl1wbtEN/rGw1GD4
 3n6STASHc130JvvWAuToSp8LL1PYXTbNMUYwTfwkIS6LAo2DrMbfeISEYItg9Gsn7uVJ
 9zfg==
X-Gm-Message-State: AOJu0YyL2CRtlAX6DkbOxKO4jOE3B36BlqAP4xNt1HYR5l3pR3HY6rwV
 tMTNlnXe+tUnDHQWOfXt5lGoMnnReXWT8xUtfWv4g4NNafdU2kgmSK3F1NSvQ4BLDzHrtimqvFb
 Z
X-Gm-Gg: ASbGncu5yzlWnuPcOEY7CjEIAQn5P/yKcOQteY4FzuFLvbxs6PH9y3vYumqNY3Nany1
 nswTcPM2CAECSHebxdjYWtPp/+1IMaynJh1aXVphadG9ny2XACo6OVO7A68bj9PmHrWCl2yktSA
 Pl4oI+7rpEDbVUg69DdD1HDZ24Y8PxfgJANtQZxGq1uXunhN5Aji3VWLmi9VXOBOv1bq2Ri02Av
 Dlx2q4+sk2snjpiRmak5NDX8DPTNRc469FeijUuIyJjlEaSjA0FAVouDinxhyd0QzQRW+I3u4re
 t1Fdf9SJedk35QtQGtmjd5xEUrLpJtIO1wqyFplUlNgUSFkptd+Gj6lgeo0+kWRKEr8ibMJyrAt
 aDuTk8C9m4NlxtWYLXcSo
X-Google-Smtp-Source: AGHT+IEs/xKAwwxSKtY1IKodHa6qV99Lrv0jJje1VuP6qtxp3/4NcpnIHsa9DbMfd+gKIDqIWqyjOg==
X-Received: by 2002:a05:6000:228a:b0:39a:cd84:a77a with SMTP id
 ffacd0b85a97d-3a06cfa2f37mr1380357f8f.37.1745488034503; 
 Thu, 24 Apr 2025 02:47:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4c4b52sm1535896f8f.55.2025.04.24.02.47.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/13] include/exec: Include missing headers in exec-all.h
Date: Thu, 24 Apr 2025 11:46:44 +0200
Message-ID: <20250424094653.35932-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"exec/exec-all.h" declares prototypes such:

  void *probe_access(CPUArchState *env, vaddr addr, int size,
                                        ^^^^^
                     MMUAccessType access_type, int mmu_idx,
                     uintptr_t retaddr);
  MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                        hwaddr index,
                                        ^^^^^^
                                        MemTxAttrs attrs);
                                        ^^^^^^^^^^

vaddr is defined in "exec/vaddr.h", hwaddr in "exec/hwaddr.h"
and MemTxAttrs in "exec/memattrs.h". All these headers are
indirectly pulled in via "exec/translation-block.h". Since
we will remove "exec/translation-block.h" in the next commit,
include the missing ones, otherwise we'd get errors such:

  include/exec/exec-all.h:51:1: error: unknown type name 'hwaddr'
     51 | hwaddr memory_region_section_get_iotlb(CPUState *cpu,
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 24383b6abad..c46255e66ef 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,8 +20,11 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
+#include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
 #include "accel/tcg/getpc.h"
-- 
2.47.1


