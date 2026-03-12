Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB505106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omB-000718-Kf; Thu, 12 Mar 2026 18:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omA-0006zL-0h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om7-00031O-Du
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aaed195901so7969215ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355502; x=1773960302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVPh6hUNYTqIlaASmhU37TsP54+Ua3pMDBatmpC/UoY=;
 b=D8c48nl2/fN/Oo0hkXlQW4T0wEFV22yF3v96wH/x5JQa5GdzdSIXtcjKyeRh0855eU
 E0Owxn/zGRicq4rfCI5H0Rwjal7G9/p+y6EqPtgTc4lhdtE/ka8cK9ceFTkw6UKWVFXb
 GkfJUKLMnrBLhA1YDyqH8gY4WCiNzrou1dlWbXKM1UkldwDWeqKZXQN4yG0wyv7Wy0KN
 iURTyioijFsK7GGrq23U3a+xq6De/30IrvkVCTJnt5cVGUd9HT6wVW0Bd+X7CgXN2W/l
 J2Awl7YDQZjjWIFHAmc7VCULu18P4oXA90F7dAKkiw8y1JioFJcP2B5baIOmkWOlW2sn
 R/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355502; x=1773960302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WVPh6hUNYTqIlaASmhU37TsP54+Ua3pMDBatmpC/UoY=;
 b=JCNs/gSB4MLsEzW4+BcoLFvwTGrNwNA/wNPqj/oxasHHOcuEh31VRhc871KWXKyZcY
 JIIGg+DFjVUMRVM63+BinSIp/AKT30hf4dZARYIdQAyfElfJ8OM0WTUEvYEo+AqZuR5V
 TBgUZDNy4ZUMrKRQsOFlZo4snrMb4FJ3Ub7HBS5sQa0XZjeoO/h3NfpNb/ztAEMvOCmj
 gNkzt7MkAStWmpK7UlS3M2FkINNXV85xIucyokeYTxxms73n/0g9nLBt1i+uiy7OxkGV
 EhqxO45KevgQkXbE9nUR6GBh7GHuHrEwyZwbwg74ShrTxowkL+5+Y2rfjKIbvDhE96ON
 7z5A==
X-Gm-Message-State: AOJu0YyD59k4DVMhEMgGbyo+mEx5pc3bswd4C/cfzumQsAZjrgN9UOIC
 m9VRk+Kcf0Dfm5Vt7n3Ft6prs/qkoqLONjBiGQ2LHSoqxgO/qhU20fSOUE2XL3V+d7U8POeBqkz
 KmUgDX0w=
X-Gm-Gg: ATEYQzzdpb9RmA7Bjz0x/YsPdqyuMMlNugSjS9GsMKQmKNNhJAnYWy3r2Qa5xlmDh2R
 EqiAJp6fhaJZsEz+TVkfzNB7+KOJVubXWOBXP2wWO1uz7yp6xZ6D2OEz7inIhQbDTOtuxr8+rhI
 DxAALFLNS8/yjlQJiLDS+aUcT4Y/0Yt1rTEgNUkK+1bYU8KJAyn+wHT81NgmcKg7yy495GOxVtN
 G6IX+wfeCH4r+UpZEWfzFX58W+Lfju+1kERtcHV+MRToUl/8FGg0+1x4lT3hQs3+iwzA0RaJbhS
 awiiAsCwGbA4GXxpfkMiMgEpTG7raus7erxYjzoxsWYVF5OPxps8wJrrvQc8PRhJzk88JixOtuC
 QllMUxjEEQXByb19myN/pG6O9MuecY873wK6F+7z3ZoYFplAHuDf+CrqVxRkxmMjU+2UD/+GOOF
 C/8U9X1gl9RpY69O0NXluLjjclNRZmhwFD87R8SiTYmSd67kHqE6xapwA+RYb3j1vSDA1Np3Yal
 +/8GOCO/htUbhI=
X-Received: by 2002:a17:903:1207:b0:2ae:48a0:33e3 with SMTP id
 d9443c01a7336-2aecab1b69dmr8994455ad.45.1773355501952; 
 Thu, 12 Mar 2026 15:45:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
Date: Thu, 12 Mar 2026 15:44:42 -0700
Message-ID: <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Code concerned is under a kvm_enabled() guard.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/listener.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a93..31c3113f8fb 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,9 +20,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#ifdef CONFIG_KVM
 #include <linux/kvm.h>
-#endif
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
@@ -303,11 +301,9 @@ static bool vfio_ram_discard_register_listener(VFIOContainer *bcontainer,
     if (bcontainer->dma_max_mappings) {
         unsigned int vrdl_count = 0, vrdl_mappings = 0, max_memslots = 512;
 
-#ifdef CONFIG_KVM
         if (kvm_enabled()) {
             max_memslots = kvm_get_max_memslots();
         }
-#endif
 
         QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
             hwaddr start, end;
-- 
2.47.3


