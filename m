Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9DFC5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMg-0003zm-8A; Sat, 22 Aug 2026 17:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMe-0003zD-GI
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMc-0000mP-Uj
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so2270079b3a.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434493; x=1788039293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clK7NAadLjai2hYCbo19w/+DIioUQ3aPdbUwnfpG/gs=;
 b=DPx+yxa5e3hbD8U4jtOsOs0P2QdklYJu8/VBabQDPdFRYdyOankGMRncZu/3QAW6K5
 bv8/94a3t0Fp/CCQJzVtusH2T3ra7lMhgNi9baxaiV/VXFBvDG6n3PqzYGkM8vcsT6vK
 lf98MtiRr0INtn9mi9+i5M1X1KagfNhoKqcf4GFp7DQpaXqTTCjm6sJ5escw1yV9Qj1A
 xWe6S5Ksgnpq423FEMIK4vGmjt/fQqtGbZnlj74aTlj8CQDO0tQHkk3xDhvZWCS/n20r
 j0ziGG1iyZkqzzH0jGgr44N3dbrMFM8SOCE0oSxQQPPfOhbC9jXrhAfCjaOZpWfGKGTk
 hdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434493; x=1788039293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=clK7NAadLjai2hYCbo19w/+DIioUQ3aPdbUwnfpG/gs=;
 b=hkO9RDWRv2mx0N7Ceo0VXrD0CK2hIOO3ZWjh4C1KM2Stdd7TCxdZKoZEJ2vHPDJqnt
 1/lef6ABFozXtKII3KSKsTmmeFOi3YpEbNL2mA95QMOo/m5zGJ0NxVXC5PpVTsGoEUY1
 j6scJZ9MqsFfYOgq7N6sxdyYFxJ+iEoO3j2eZO+9cKUt5f4MI7SsC1SezahaOjrnMC0B
 d897Z1J1k8l+vRgf23sULvAU+SZsgEOFXOLydd2vjgaLaiEYcHwOa+kA957f/A/bMerQ
 nEQJF3Xyz8prPsq+Lor1lVheATTrHZj9PYCpGpWKoH9qsHVUkPNeFPeooemuQBdoWAkz
 RggA==
X-Gm-Message-State: AFuF++mN+jDrTvh89CwRnGDcu+eD00nmaXtu/u2GlGHY9djxtJHq7b2Z
 JmVFN63I3T/WN5BkUXy3wg8Ms3vsdSlkBtxnXToiL1y+gOP5j3xgQ1htJJ3hUdZUhbXX0G8a
X-Gm-Gg: AR+sD13qulDG694ugxVLcjMxaMuk8yOeuf6LjMu7gP02d3cP0toAb2jD/6szRDr+i9q
 fFoSJsFDB+okvDZv9WbMrQQJlwfjzD0NP+0VK98CnMKk/Ao8VmRS9u7GStJnDHkkYEPgXkbEEQs
 YNJcvx9ZvpV+fW2ic5o8N7dBAk+etAgsLS/nnEvgmuByW12IRPSe2rlQ3NmAAMLTXs1dZmFIcUb
 LVQtH6WRU6tiUv2ArvY2LGbh/AFzAtPHAkODL2OViWgoc95hzEvhw4mVLtLG2vBjd0qSwR7C1Ut
 RIoQISmWQICiMZiIYbl36r4xA2AygXYk26MpAxIceXfCGPHbHwiMFdYAPaZcmOJA205F+XU9Qmi
 +D9vY4TK4j6U11hNLV2ZXRF4YUqW7e5YemGapv9ne899fnmuc4ryBTJHT9B1cMUtaBVwXTFrXuh
 SmlAQM6ClV6Q4m4ZEIPTCDbyQyOemrdoJpcGKiwrmSauMT8klg+H8M2iaeKEz2+0jERxlU+ewru
 O7MTQbZ
X-Received: by 2002:a05:6a20:d48c:b0:3cc:9162:6bfe with SMTP id
 adf61e73a8af0-3cd4b68476bmr15769871637.0.1787434493540; 
 Sat, 22 Aug 2026 14:34:53 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:53 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 14/15] iothread: remove legacy iothread_get_aio_context()
Date: Sun, 23 Aug 2026 05:33:37 +0800
Message-ID: <20260822213343.661939-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

All production callers have migrated to either the holder-tracking
iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
accessor. Remove the now-unused ambiguous getter.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 -
 iothread.c                | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index 2ef8c1a1bb..9850cdb3dc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
 
 /*
  * Return @iothread's AioContext without registering a holder or taking a
diff --git a/iothread.c b/iothread.c
index 803d6ce3c3..3a092119ee 100644
--- a/iothread.c
+++ b/iothread.c
@@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder)
 {
-- 
2.55.0


