Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C522DC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtS-0003W2-Uv; Tue, 28 Jul 2026 11:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtR-0003Ul-4d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtP-0002gJ-KS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso5649f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253133; x=1785857933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=AjmtS3xis4n+6Os5d6y3bQZM5b8Ixj/TNic/wX5GY+xq2odbIJhFrmu0+U5OhycF8j
 B8kQ4SaLD0atq29K5ehBcdcNboABf5Wh4GMrzVJhZEPEqeXrFfT1QZ+mblS7CmsnsMit
 VxW3P0T/bxX/d6+GeP4Cuj8n64sQZJi0KuFM9UwEg0xXcOSQmR77SLdO3GdG41yDRsme
 iYZr5tUAtEW2MLaGeJj76RltPNi1bWk7eONRjEGjYUnv8xnrfKoL/1zBid4x8o0OJc9H
 98joXxH7oln3EhQ48yv6KSu7KA66ustGbmVtK1ATWYEKCQLsT8AK7TvpJBEF00xDGlA6
 KatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253133; x=1785857933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=cOmcyJtDWKHXbcuM5ND/Her5xuLXAiVhcl9dW4m7hNPjNSI3VJWrAypqf4U99px+tu
 qy1qGcMy4o9gg8SQpAIZHRr/LbcdPCHWeua+kV4K5JBRAdnFX6fByuI/G/O4FEPoWGCP
 w5ToaR0rykTnPQimRviKt7OyTDjV+Vsi4XpDZ9v1Hs/Iqq1MhLovtOoNGaMFo7hhf9pW
 o/t6C+IOuBfcFoVp+AijMfWHp1vbDXqYTryGqKaeWPpaCMeiNKGo5eaPeo3juH9vPlHN
 98Yzgtl17oUclNyK8LMSSsqL5lROteEHcbIjcWsnYWpAo2Jd/wMYIn8U9Wi8F/JVILpJ
 SlpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro37m44g6yEWcZt2uYrWQphtjVhgrWXiqvNIsSjlUM69vi7RFdT9Ae4cTzlowTgs9SBnOJZz9B09sDy@nongnu.org
X-Gm-Message-State: AOJu0YyHCnrc1J39gnwiN9/pW8KXWtuLRLp/TsDh7yfBzMRBkKr9CZRb
 xtGodwMSwAliq5n1y6bAUxg6QB3SOkscpKPpbmj7zwIhlbp2pk4W9YuCODiglXsFKlQ=
X-Gm-Gg: AR+sD131BFtNB8M64Tz4gafT2y6buwIjUm/mrWBplv+JpTyefZynsTdt3xR2+JmJ+Cy
 HUwutAsvtC6xZW+ifewc2o6xa4rxHiYLpfhG4ekTasYS0JXRka3u3OcOTzqlx3yKQV2kytmgvIq
 m/U5j2xoc48d/mihfjO7P9lG1Tmw8u92UBUZA9jl3HjckG0WaaLdcFC/Dz6wzRIxl4DLYiRvSgv
 LbM+p69XwS43jInP+d4jNWRKSDapmDSPJsUred+JJvcZgeGFqnvJgaKRhRBEFvYhj8ssCijjyRa
 +UhoTrvz7fE09s3E9jSYZBfnDBS+qFjFMsTca3QqKphhR0oM88zSejnYBA7t3PEMdssFJxRVn5S
 cLvqFH6XVscH4zSG/+Dw9wQ45gt9DiK1WoUObhUewUjDXoYYRAyQi3YcWgKKENNYgYjGYF/pQjQ
 ==
X-Received: by 2002:a5d:64c5:0:b0:47f:921f:3a35 with SMTP id
 ffacd0b85a97d-47fb1f129fdmr3754841f8f.37.1785253133212; 
 Tue, 28 Jul 2026 08:38:53 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 1/9] parallels: fix integer overflow in header size
 calculation
Date: Tue, 28 Jul 2026 17:38:41 +0200
Message-ID: <20260728153849.601939-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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

parallels_open() caches bat_entry_off(s->bat_size) - a uint32_t -
in a plain int before it feeds into s->header_size. Near the
"Catalog too large" bound the value exceeds INT_MAX and overflows
on assignment.

Match the cached value's type to bat_entry_off()'s return type.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7a90fb5220..59f00c64a6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1240,7 +1240,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
-    int ret, size, i;
+    int ret, i;
+    uint32_t size;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
     bool need_check = false;
-- 
2.53.0


