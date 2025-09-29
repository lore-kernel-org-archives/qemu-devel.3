Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10664CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JEL-0007Tm-Vk; Mon, 29 Sep 2025 15:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEK-0007Te-5x
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEH-0004tg-Ni
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+VWQlRtDiKUJEtuqAgZyiqfrGUS0b2sMRTtBiC3lXE=;
 b=T9DqXVjH2DkD5d4KS2XZQjdJXJBGWn7I9ktn0HsAj8FHmXgGYWXFqDm0/+wBUK1UY0uUcy
 wFkkGyk/z/PjKd5E4CUg2wroJbGR9Gsx1AyKeaNTPDn0Eco4H3X6hk+c8PN0Ej0BpUy02k
 R3XI4u8TGWM8BnDCwbhfbnyjdWi31q8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-xjM6icFfNeWkgP7rO4g21g-1; Mon, 29 Sep 2025 15:08:07 -0400
X-MC-Unique: xjM6icFfNeWkgP7rO4g21g-1
X-Mimecast-MFC-AGG-ID: xjM6icFfNeWkgP7rO4g21g_1759172886
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4de4fb840abso91322771cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 12:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759172886; x=1759777686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+VWQlRtDiKUJEtuqAgZyiqfrGUS0b2sMRTtBiC3lXE=;
 b=l4UTuHHe3iNIDnodV+442AVJFV4/IPvJeoE8/mtHKlOl7Ukg0ImTc6UXiV9yk7iOMm
 R1jY7uSfcooQBTBrH6WX65GX+OVAO8xjzOnG5pQ/wd0KcDeuZodKXCeqFSHQvlRvSuLB
 V4TDQjp0chw0BjVIQnzMu9x3ib+xwNGJmje/hnGGvqMZFIc0OFRoNp/PXaNqn4p+gySb
 rTSndymkFqBhb8Q/Lch5pfYVeKPEmjh44nkT9Apyihbb7hYyId2QiuIDtmEzYwd7X0oe
 QbxJKkVYxKpetpOKHnll4cLYymuI3QhwZehAaP0feOUvbMDmH+LqBDUqkKcIYY3FIRfF
 CZSg==
X-Gm-Message-State: AOJu0Yz6snHvgskwa6kvQx0jYXK040bJENyzFvkvv42crdoKSE6klwwM
 jvh31jh5XRXg5cmGpr50Js1rXYQvwtNhbFIHLhy+UCtIfUGvduECRWhhTqCFelksCCGgaVHPRrH
 uaWsbqOFqGUreqnSJZVmM+is0tQ6zvJ3364/4W2Tg9614hcbueMmohU2YtbG5VV8NtLTZ2O3em+
 SfLlcoeCNBqG3UV7g0ZdpkNYUMewTJeXA6KYReuQ==
X-Gm-Gg: ASbGnctM/9ATiEZPQCOeGBgp2NuzhG187C99mQTTnHFDsEitIu98lFP5z8hUmioJp8y
 yxdlT8+VunaQywDeaNKPQ1pVtFG5sUtRnY+dt6PSmi3kp9097ukPCv3Ow1h99IDE08mG8dIUWsE
 XiZA//5Y2a2YjHT0wh2J+RijCZgtsLG2yVAIb4r/QvrwSBLywsxZe/dUGZ6/6eWmooy/kUnbR4h
 Jqdl4THy4B8RzQbEUYGod5jb8cUIAiaVcitHVjoWj+fWAA8E3hRrZ9ljwBO3VKprcUQwo4KJd94
 UrR8ibrf6sDoNfmOC/S9KSsHw21xdPex
X-Received: by 2002:a05:622a:311:b0:4b5:dc4f:7d67 with SMTP id
 d75a77b69052e-4e27f5228a8mr21018361cf.27.1759172885862; 
 Mon, 29 Sep 2025 12:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZjpvvOsystAqiLGeUBCYXzdPNH4TzWaN0T5jfauJtTgSKDZ4Dx51vb/N2Hg6+qjvy03scw==
X-Received: by 2002:a05:622a:311:b0:4b5:dc4f:7d67 with SMTP id
 d75a77b69052e-4e27f5228a8mr21017781cf.27.1759172885262; 
 Mon, 29 Sep 2025 12:08:05 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80142f5d6d1sm79626296d6.33.2025.09.29.12.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:08:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>,
 peterx@redhat.com
Subject: [PATCH 2/3] tests/test-rcu-*: Zero-initialize allocated elements
Date: Mon, 29 Sep 2025 15:08:00 -0400
Message-ID: <20250929190801.931989-3-peterx@redhat.com>
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

QEMU almost always do this, so do it too with the RCU unit tests.  It's
preparation work to start asserting on possible rcu double free.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/test-rcu-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-rcu-list.c b/tests/unit/test-rcu-list.c
index 8f0adb8b00..853c9e33d9 100644
--- a/tests/unit/test-rcu-list.c
+++ b/tests/unit/test-rcu-list.c
@@ -233,7 +233,7 @@ static void *rcu_q_updater(void *arg)
         TEST_LIST_FOREACH_RCU(el, &Q_list_head, entry) {
             j++;
             if (target_el == j) {
-                struct list_element *new_el = g_new(struct list_element, 1);
+                struct list_element *new_el = g_new0(struct list_element, 1);
                 n_nodes_local++;
                 TEST_LIST_INSERT_AFTER_RCU(el, new_el, entry);
                 break;
@@ -259,7 +259,7 @@ static void rcu_qtest_init(void)
     nthreadsrunning = 0;
     srand(time(0));
     for (i = 0; i < RCU_Q_LEN; i++) {
-        new_el = g_new(struct list_element, 1);
+        new_el = g_new0(struct list_element, 1);
         TEST_LIST_INSERT_HEAD_RCU(&Q_list_head, new_el, entry);
     }
     qemu_mutex_lock(&counts_mutex);
-- 
2.50.1


