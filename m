Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEBECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kYz-00060Y-7R; Tue, 14 Oct 2025 15:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYw-0005zo-Ox
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYu-0007Yv-Bg
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+VWQlRtDiKUJEtuqAgZyiqfrGUS0b2sMRTtBiC3lXE=;
 b=d77Vq/QmMu3MWK+4OQ2unumvW2B7aRTwkYy6m5btBULLEGetJThH5LT0/cmczZj94nd3RK
 3r48mVU2CUGlp4V/qrZkwlbJ1OO+cZE2n5uUcb4UVo2F3SahGDvhzg3EThWSinhWIa4LRx
 6hDgESO22YAzaAyipMYrtm5BJkJi9ts=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ZbC3z-73NKK4nxwViJpfhw-1; Tue, 14 Oct 2025 15:19:52 -0400
X-MC-Unique: ZbC3z-73NKK4nxwViJpfhw-1
X-Mimecast-MFC-AGG-ID: ZbC3z-73NKK4nxwViJpfhw_1760469592
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-86df46fa013so3583462985a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469591; x=1761074391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+VWQlRtDiKUJEtuqAgZyiqfrGUS0b2sMRTtBiC3lXE=;
 b=rGiUOeVABYgEV4B1DB5NCBB4RfrzSjwptf7Aa1gtN33YXSCfFJblEb5b0pzW0VRBuo
 oy7/el90ScyIO/kVNIMB2MRPfBucLIrdmYU6JIIjSxYPQxEjRA3s6fXQh+Dz8z+EFX1T
 OQ6O8XjPdIJQtOXG5p8oLRejRvKtzQlynqzg1014w0jPcT9KpgytvawvVOPDyGK+0TjY
 5b+X3pVp/yRGylBosz/e8WwuT347BDx/9WkP17jXLJ1ZpEqxzBXdxS3oGIGoqjGqJxzm
 5FBbsJsEaigPwaV2Jogim39/47WR57ion26zIJlH3w1EIZOXM7fP5mSNdQIyTJYtWUY3
 hQaQ==
X-Gm-Message-State: AOJu0YxmoK1EsxCb9A0hew8rNIZLRF64sURARrzzwE0lVFLSK9JwUpT+
 Ia4LJuv+Z983eoouCu75/xRaUEi8KC8hKUhyHzPqfkTN6JbS0YMgg4oAkS+GrjvW2gIRB2VCNoy
 pJrdY0j+rzbI+eKiFlQMY795j4f7ec8zRvEiCn+DU6eHyzb0E6imvahLPv1NJc7wDvadKpDJ4se
 dttulpZTy1hvIihQHZTnFvtOPARBCB9bQIZ9emdg==
X-Gm-Gg: ASbGncv8ZaZXujaN2Yh1JAlcU51rwO5MLyjujGVSu4RMvIMrJJ+nq3EW75oASUAkFtG
 +Tq8bJQLjX77mxRxptAExfni1aa1uah+aHPOZcpvyxZcORd/PL/DerF5CCwIFNTHI0U90VQG4Kc
 JPsGN12KCFPwaA2txz6uTmH+/stQz6Imf9aicQo09hkzi+EQsuMZHXwMBT7TjDkLSpWgKdmOqgg
 b1fytJL86ctdvHf9FDpPLE4F4mMi38NE4KBtNbaIFJQZUWGK4ZH6sQ0cQpQD+Xa5Y2HIICspdy1
 GhM6un4/EaT0kQVOP47ST/qCQQ4kpQ==
X-Received: by 2002:a05:620a:2981:b0:84a:f7cc:1eaf with SMTP id
 af79cd13be357-88350f575a5mr4294861285a.35.1760469591169; 
 Tue, 14 Oct 2025 12:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoakdbp9BljsWaX0AKJTl/ij+zsqC0Zbicq0Rxf7FJqOn2GPnzuFXEGfZ8S8aBbhB++KEikQ==
X-Received: by 2002:a05:620a:2981:b0:84a:f7cc:1eaf with SMTP id
 af79cd13be357-88350f575a5mr4294854485a.35.1760469590612; 
 Tue, 14 Oct 2025 12:19:50 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a22744f2sm1256602585a.44.2025.10.14.12.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:19:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Richard Henderson <rth@twiddle.net>,
 "Emilio G . Cota" <cota@braap.org>
Subject: [PATCH v2 2/3] tests/test-rcu-*: Zero-initialize allocated elements
Date: Tue, 14 Oct 2025 15:19:43 -0400
Message-ID: <20251014191944.2225735-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014191944.2225735-1-peterx@redhat.com>
References: <20251014191944.2225735-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


