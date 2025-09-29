Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E65CCA46F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JEY-0007VV-2o; Mon, 29 Sep 2025 15:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JER-0007VF-9P
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEJ-0004u9-HX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rajHt1rQETy/sbQa2hhoaq4bHcPDcuCq1ZBhR4uILPE=;
 b=E3CPIUX3mnU2Kwypa+1uXJuPJJpwZyw1QMybIL6+6c+SpnowelvisiP+gxZXzcsUKEBY9/
 HWhXbuP1of2YB/dS75inO63FXTbaWX+8AHnlw24Wga+Et6nPIJBlZ0TkjYUFEa0s/Ndp3V
 Puo6m7gP8/zexBjBl6JT0e94M2l8MAA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-mN_4f87mN3O-k9jfudBdJg-1; Mon, 29 Sep 2025 15:08:08 -0400
X-MC-Unique: mN_4f87mN3O-k9jfudBdJg-1
X-Mimecast-MFC-AGG-ID: mN_4f87mN3O-k9jfudBdJg_1759172887
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78f2b1bacfcso87230296d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 12:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759172887; x=1759777687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rajHt1rQETy/sbQa2hhoaq4bHcPDcuCq1ZBhR4uILPE=;
 b=VS3ZV+CVg7VlmtUijzNRS2cqx19Y83FZuvbHayIgqB9KkOGIYkcZa4UySNN9Yu/aL1
 UZvZrVqsSoTxvSoP4Phd0vFpCYOyhLr7i2EVJbQSP1XTF8llFhtSYiLOBHfoh2eIMo7o
 R7YhYLradvusoxJwo4DkQ6nkBoKDxTYk7iyOwti+uY4xp71PZJ/xGDrtfEXzwTKN7oFI
 zI6FHF9XJhKG6ec+pCjeakpOzp8Ye9a3RcjyCfspAhD/PfupnLfL/P6x6l/f8HKHiCPK
 akqCslzKHKFONuBt08tuDU/CiPqon8+2SIXLwNK6fDTfYTV0MxZFw2RaWgeWWFJhNtNt
 j3KQ==
X-Gm-Message-State: AOJu0YyXE9kMbvtHglgjsPrvuuHLblDTXqOdFqghI83S6NhyoFbceMK5
 Hep85FLH105K/qYqrNHnfIu2ymDkQ2ktshCLCB8AyyniRDcLYrM7zMHMoFmlsP4/ePhuI8x5aKj
 kD2gWKk6DBsCatxmj8/Dfw51CQur1UdwVIgfjmS6TG9lG/7XdOXECYv3sOiD+3Of1IfQHny4bKp
 xgzYcqDZbOocDMTsMgelOfFhc1yWExQMRfWxGfMg==
X-Gm-Gg: ASbGncvj8lj+prf2G9M4ysh5IZWdF35ZdRUbyR85hKLsgPhB9U2AwSz2k0XsE9GP89W
 mEop5Ork9ZMJlv1oxzjSId/iTKZ+vijO5NyWzoxK7uGUWzAwbzYO6rmAXG4ipyYTMKZ8QEkojU/
 vAseXhL1zbFjMaTfOeottyTpM6KhwMXw8pRrL3GQQAwxnuRVfCEV2RL4Smnfr4KcruV1LUhvIWB
 qIBdI/fUjuUFLh6/63DOFLZXBoSF63D9o57qxXdGdZJi5UJXjUTbCPFG3PwLAtC9gHItAreUaiE
 WxM6Pv+tOH5njVdxnUZ48a5f1SOjhhLS
X-Received: by 2002:ad4:5c47:0:b0:7e3:4084:fcbe with SMTP id
 6a1803df08f44-7fc2d9ebe2dmr264588356d6.19.1759172887107; 
 Mon, 29 Sep 2025 12:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgaqs6QVjVe746cEYMJ1XKe14RcF5Mt0zm6vEYdOCadsljhqeWJyIzmVy9n8QhnbURGNs/yQ==
X-Received: by 2002:ad4:5c47:0:b0:7e3:4084:fcbe with SMTP id
 6a1803df08f44-7fc2d9ebe2dmr264587596d6.19.1759172886490; 
 Mon, 29 Sep 2025 12:08:06 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80142f5d6d1sm79626296d6.33.2025.09.29.12.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:08:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>,
 peterx@redhat.com
Subject: [PATCH 3/3] rcu: Avoid double rcu frees
Date: Mon, 29 Sep 2025 15:08:01 -0400
Message-ID: <20250929190801.931989-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929190801.931989-1-peterx@redhat.com>
References: <20250929190801.931989-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Trap call_rcu1() to make sure it won't be invoked twice for one rcu head.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/rcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/rcu.c b/util/rcu.c
index b703c86f15..9272fe5796 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -307,6 +307,8 @@ static void *call_rcu_thread(void *opaque)
 
 void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
 {
+    /* Avoid double rcu frees */
+    assert(node->func == NULL);
     node->func = func;
     enqueue(node);
     qatomic_inc(&rcu_call_count);
-- 
2.50.1


