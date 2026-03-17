Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82F6FEDA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJf-0007Rc-R8; Tue, 17 Mar 2026 15:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJW-0007Nd-CG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:51 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJT-0006yi-S4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so3500486a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776566; x=1774381366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=VnV/+WKgJvGMJRmw6Yvg4WrQZ81EmwFpPZX7NufgYKFlyrn43UXfSm9QshLwcuP4GT
 jLDOnsqhCAY23Oz3V3RLnoHptSMfAe1MZr/XTug30ZG+n0f8pXppIkNZyfZtWCtLJkMn
 mXo2rbvd9dYJnLjo18dQ9FJIav51tb7gamJYjbFgoBbiXZ0c6pH6/zFNdM8QYNyiuyiE
 vHPayF/raNFMf2zjbdOUxyWVBOAJlj9S1jpZRVQyLYxbhTdsvJfz/TM3R+s4H3n47R6c
 6SO0xjQ0OrS3LHEtlFdVGZxKSunRMAAe4XQi23RBEnGPKqy2Cv8RQt6W1ue5T+39yFNw
 Yh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776566; x=1774381366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGp5LxAmYWTKuDMXym/h2A+YdJTwFfJW4kvCbf6qbNk=;
 b=fjjIhsMnk8ZwR8JW70OsYNzGeHy+V0mffMnkl/kOKQ7ep6g5MI3S58At5OebXdjX9e
 HnuuuuAxa62i6YnEGZ54o2XogWyC+TXNVr3XLnsxcDv5n6U66evcRdSjFLFfNikB4A8o
 nV/J5ja4+D9G38UmWl7G1IZ9FwW4FoT/R4Rjo67/gqIfWS5azm7r4yiUjEUrzIHiSHDF
 5xig/W5D1HxFbgjRTpfP+Y7usRXaNodyGAYw+OKAXLOGdwWdlZQ8wy9EZ81GNoafARku
 P9lTvsAREpTRiNl9I1nT2wgiBp/Q0WJdHzqr2I9huykQpq9G4GXyA4NT75CC6C0lq7wa
 h7ZA==
X-Gm-Message-State: AOJu0Yy3/cbhFQnGmg4u+5zRWKcwP8e0RSBPjkhUHcChOY+C1DkV9KMg
 wZOBBSQnilN1i/B1GAzXuqKbUa7FrACpVYjX9LLmjykuujF519svu6IOqyev2fD9nO1j+mXcN+m
 EonWNHdc=
X-Gm-Gg: ATEYQzzMeTR5JBlAaeoC0N+L2Lq/KHooZ6/rbW7HVX8+uCIy1bIrDiSBjl9QlCy7CdX
 5tw85oujWxZ/TiTzA0XnMGP3IYjEoJ5muS5hXUmpRGUfpqMKJD6sEUfr6dS3/tOLoYrGwtwwtNX
 vzFdZY5qjjE666UYbHRI5lcUpzwpdIv1ij6IftiQDpeL/9Y9P2Dm59d83qu0Tq0UZhOT6Grj6Xv
 EDoq3UvP4p4c/BNh8mF8ksKK+uU6hefY6+vfhZ0GKkGggjXXeZ/7dyMh6JSFR6qX7BXUq97CG7L
 Or+nT9GOKXCHR3nQAFY+h24AIEU+/UZI4p/htE2cPRucrbL6hi23vfl9c/G+Wz60cJulOzGr6XE
 xxF9CreZVyCJSalH5bSwEiDBiZ0uQCgVChz3vKDe+CPMqgpszbXIMcll7DJI/Zkjkv5w9NrsVlN
 /Hu2Q7Q4MJCgrYoBbmzVQ5RxhTdYKniVSNFZMqRxhghjRm6HjawhXm/oHrT/pd2QTtwidlDO0Ji
 6nl
X-Received: by 2002:a17:90b:510f:b0:35b:945d:752a with SMTP id
 98e67ed59e1d1-35bb9ef607cmr564798a91.17.1773776566106; 
 Tue, 17 Mar 2026 12:42:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 1/8] hw/vfio/listener.c: remove CONFIG_KVM
Date: Tue, 17 Mar 2026 12:42:34 -0700
Message-ID: <20260317194241.869568-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


