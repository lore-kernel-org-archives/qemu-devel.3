Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2543010F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRl-0000g2-If; Wed, 08 Apr 2026 15:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY2G-0005Yu-Kl
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:53:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAESD-0005Uy-FC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ad135063so23813495e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599163; x=1776203963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3F2Q5EnnzT6rmGzklEM6ziQNPmaPW6cAaunkc3rGNik=;
 b=tAtOZ3WICz1A57zeiqha4Tg+JT2fkNah+wfUelJ16Sp3MeW1ZPOeNX871a+mvDihZG
 7wwzxwZ2hWuHFHLEUiW9pjPw/ohWoO+iy0nnMdywlYAj2VLDGoJGfOKJ+gzVYMxmnxwm
 7iC8r8Ta3UOEK3l+KW46eRlqxyNIshmBZxiiC3ydIqLGh4wB5qeaNJiDvfFVKjhCG62I
 uviP76QwrMAAor2yo4BScyxjvAgL4U6q7mi+ugiDOXey24vMAPv5EaYd/apba1joAuSk
 TUC6QdppAXcWPAIHgSgw5RyXTpWzI/I2AQTC8GE9bF0pVrU9zRDuEaWrnfRKVl8zm/2I
 VxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599163; x=1776203963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3F2Q5EnnzT6rmGzklEM6ziQNPmaPW6cAaunkc3rGNik=;
 b=hSFtCzfwH5/ulbbXJnmQ5ARaGKeQ2plwtDBEfGyil31zjKZmJfCp/gY3ups88PSOec
 OHtYSw7DhBMQqCms5cgFuC8n5nPqFRXnL/9BE3KjyZHRP/psHx1Je4cwf789WIYoDhqi
 TtQFNjtUWLCPZe9Rcz9ALRaxhByuSI56FkMPy3j4BfxMPIJO1VFaB8S/kB516Zd8GcmG
 xhb+ZNw59RX2aWNQOXS1hg+45UW0f0/VOUqfzcbORnvn2HRn9wkrrvZ1lwts5zQhQioR
 H3UAJe3TjKVkwtgClmgn6cp6oT8EikJH/LgVVmlCNAsYbr3wTl0DN48lz86ZhTdaK6rA
 IkNg==
X-Gm-Message-State: AOJu0YwQOeC93TXYawgdYlR2KwMIfdYEO9PfASe0ciFCWwzvwiRUyAUX
 9wli6Oj7gnwU17l3j/WGn5c0LlNEJSzhpVJE/xO4GmqvsqYRwHw9odxZMMOWgqJdwF/sIZ3k7q1
 to6Xdz3E=
X-Gm-Gg: AeBDiesOgXpx1ZH3RQMbmhxOqHJMhIm+TsCGglBzRyREzPBIoxpbtYWP75MJRM/q6au
 N0Quj00atDcawkjmGpgDWfuJB1LucagnV1vHfHMmml3uXr/l8mR/HuhP6zxiyxSR7a6aJA8sB6O
 W8P1kb6fFMl9QBemHQjVW6ebwK2FtWbKd1ouXuXgrFwdTG5dN8rPseNyl4KFKU3GdntqhPxGDQt
 8eeQgJAOaAJbryq+3SfWiQTwO+tO15AoJxXdDsoMP1xSAmEfm1dgnze/1T2kU921Z84UaE7b3C+
 HfkLnsusSX5u+hMglYZrh9iOgDCCIDt9MV82IFZ9QIBBY4PDyITP+5dZJLinG4ke6M+kgKtCbyS
 jvFKQ+A7riJGEtYG3q6fZzvt+dNEZ1nvAetbumVfxtC62f/o8E61iMSjk/SPWkWHLWMsqV+M58W
 KuOPFLf1Idi9GjjWgY6payBT1huJt3U5NkpUD2gPghVl7+5gzyB5y4qq76B+Qz1+ClMKzNK0KB
X-Received: by 2002:a05:600c:8b75:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-4889978c516mr275818025e9.17.1775599163067; 
 Tue, 07 Apr 2026 14:59:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e822227sm659482215e9.4.2026.04.07.14.59.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 3/6] hw/arm/omap_sx1: map CS3 at the correct base
Date: Tue,  7 Apr 2026 23:58:57 +0200
Message-ID: <20260407215900.63390-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

omap_sx1 wires the "sx1.cs3" region to OMAP_CS2_BASE instead of
OMAP_CS3_BASE.

That places both CS2 and CS3 at the same address and leaves the real
CS3 window unmapped. Point the CS3 region at OMAP_CS3_BASE so the
static chip-select layout matches the OMAP address definitions.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Fixes: ba1580299d0 ("omap_sx1: convert to memory API")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260403014441.38725-1-zhaoguohan@kylinos.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap_sx1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index d858dab3253..bcb7105323f 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -146,7 +146,7 @@ static void sx1_init(MachineState *machine, const int version)
     memory_region_init_io(&cs[3], NULL, &static_ops, &cs3val,
                           "sx1.cs3", OMAP_CS3_SIZE);
     memory_region_add_subregion(address_space,
-                                OMAP_CS2_BASE, &cs[3]);
+                                OMAP_CS3_BASE, &cs[3]);
 
     fl_idx = 0;
     if ((dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
-- 
2.53.0


