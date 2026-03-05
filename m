Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C782CF33A73
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9di-0003uP-NN; Thu, 05 Mar 2026 09:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9db-0003tD-TH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9da-0001li-DU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae56e68216so31911065ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720712; x=1773325512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=AyHimFW55bhCqeN4GpooobwLC955AaOVASJTH1QHb2cf+sWsnt4bprwHOKIxmy3x09
 crFC0TJMpg7NsMFDZ5LTK4XdIpvsQjqgiuwTZvC4CxvT/xRbNwH6NVLi/dHVqL90euTf
 JDCKd4vG5T0YSNsvlMszHSSRCLrhiTzsi15/AUzKE4e9nyJrsp33nEiFLDrucKE+2PrT
 HDW+0/zmmUGjZ6NfyjQstBgbjxP5pJ14jD4YKKRP1ovZREqp3nPTGWhHig5hfKvC92vh
 AJhODdkO6O50ufvHHByZdfsVUndzDKauIIvSwV0caydg5of9UJQLeoIMo2d/hgjz/+9Y
 2Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720712; x=1773325512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B2QC7hLfF9zjfQ04CPizme4X1fY5wq+GdA4jvJ9NH8A=;
 b=STF+ROJVHY17Y72SzAW1qk4af/kz2KTAiOqKF2vwik/WKPNqnS+6GvzQiQ19oSisqz
 UT6FfivaFhfjjR3OgD2HgisDFyPRey4dtXIPYGeZnCnjvSe6q4jKRNx+W92NNSNFhkvw
 cZhM48OiwUYvZqlTbIrOCcgQ3kQ9tjBx4I8pa4jQORCpUWjsGx/BNbEtfbDN/HWgaava
 rGV/i08XB8BFsP0qujHGySOAP5mMZS5zaATvmeC7GvFjQ5PKrkUoVKEsim7uHE8sVsrO
 56owvs3moo4UMYYKphn1lxID6Sz7xQvVfpiJDXKOpfT1vHWdX+axSGekPEgOflTT9YNu
 n3Nw==
X-Gm-Message-State: AOJu0Yyinjuk4WVXEd/7JzubuU7KNiGOnRX/vYZytS4M5/456hNmc/dY
 LKpFU99ltpJMvtgbEdYg8vVEkfiWIeanJqxGiGfvKy9iQyEPqod0KPeP/KblKluALqxz/w==
X-Gm-Gg: ATEYQzwzfqyMi160TQMYNCrIsuqiXmmg5xOajZa6uys/UonmEFHj8ZxaTKVfAPxflKh
 kTcu24VfdGeOIvB/XUK4Pz+MOOs61tE6Ic8GsglWm1o5E7a58+843P3zrJhnSK+wPzGsu50U+OO
 r0GwhA/HAyao7IjBrlHtHxzUOmkeWyihcGk3zA4e35r0qoRVbOz9/dT3BAqjoCZkOuXZ6F0sfps
 +SvsfOfJS3CqNFb4xWHRUfUh2QkK06irSwn2aSJTNEJKb/HNkQf8vTvOJ1QC5Q7kj4jWbUocmY8
 OjwwT81OOa5FuXKRf5cMZ7tt/uuvavaLM90St/HpeVQbhcANeE3111Ou/B+O3oMmSfUddUHMGM2
 AIkGv/H5JGPISx5oiYd4yIg4ePoaQGFaBLZo7Z71KYZwO4m/YPwD1DjBEY0qlj8DALmhzd2touX
 YkEz3QBUuO0XknPVllWzvL3mQXFgD4LYU5r6Qhc4a7rm5zJkrBFkqI/U5MdtSAi96IcsY=
X-Received: by 2002:a17:902:e952:b0:2ae:50ec:fa34 with SMTP id
 d9443c01a7336-2ae6ab9da83mr59865215ad.46.1772720712480; 
 Thu, 05 Mar 2026 06:25:12 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:12 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V5 01/13] qapi/misc: Fix missed query-iothreads items
Date: Thu,  5 Mar 2026 22:24:47 +0800
Message-ID: <20260305142459.52559-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..1f5062df2a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


