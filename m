Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891B8C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRR-0004W8-Ud; Tue, 11 Aug 2026 13:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRQ-0004Vd-KL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:08 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRO-0000Rd-M8
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:08 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso14922266b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469945; x=1787074745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N69DbYpUl1rZqFPWyq/bw6JFA1tssKwuW30lwMxOl1A=;
 b=DOcUjRF9L/3FQxBN6JHu3RbEkHqA7JhP626KQYaySJZN//isMyCB7Z7g9tlm4X8sC9
 Dq3SoQClpxaLr6iuFxwpSle3NlD/RTSTyU02jYDNqiCh7cCtn0dZ5SQbjzuEeztAybdy
 9Soki4ytn9rwFw1ACkxuNp/vpvicLoq9CTY0ns0DPTcpPHwQsjmonud2iNG+dXM0je8X
 I73Pc/7pxeELo1SCUfYJpG+AY7REiza21mNhlTnTbXq4laSesjO/eo770v2/6RdFcTgz
 6rnX+nPKZK8M39HQOjh1GNMUotinHtRBsLs5I6iYy5eK9kAZh3K73gODmynrCKltO0NJ
 kIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469945; x=1787074745;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N69DbYpUl1rZqFPWyq/bw6JFA1tssKwuW30lwMxOl1A=;
 b=YQ/f8hJ2LrenXqVdBaGdLLO64LpEjxM159iGz1gghK5KFIf50gfANJGOxuycxqDje3
 MwOh7jYAYtlMUR4V4Lma9/9mDnYU9Fj6ps3r7XdEKoEm8OiyG2+xG9b7KnTyTAC7P7uN
 Oeaturj5Ygxk8DYYWRhY2GQ9m+7qic6NMtUxutktqQTN/BmDGBDV7sMLmoCX65Ne0yqz
 sooX7EYQUoRTtQdYBHVagltk2pYheT6X4f+wF75BSZnBLKu+AwkLhZBri2EfLHF1GXTi
 h5M6b664f7hHi9ZmUWl1qOAq8Y3TIrp01xLhTKtkOKDbMU+XiUw9Uq1Izmzj93pkgzRv
 Bruw==
X-Gm-Message-State: AOJu0YzKQL8DXuYT8m0O1OlKr9yK9pYqo8PL5fDIe8Lc5ln+mUc6qChj
 V7iUcF9Ydm9kAF440YQcxHZM39/uI/xjq4jJlHWaBbeOlSXn7TTU862xuwFWZZ7KI/0n3L1d8Ia
 mIbUt
X-Gm-Gg: AR+sD12itF7brVInVPzL0cvi5u9SGZ0BtssjTLgevJwfVkCTTt/Ch7quSMkmBkD1bA0
 O3Loboe2hij5pjM+Pqk+KBptjLjCTBI9KK+QWnHoBKg4oKo8PGoDzDdeNeGc17Gt9lYo468feSc
 kEg3UZQc+8+RSmCgvpwMSzkL19pxyxn4JZV10KGesgwJADSh8y0KpXApXFDh/BeThkq+uAWkVRE
 l/3q2o0obFOt3iInxoIciS7yJ9lnC04GGh5jcdXuNpbdmw495bDMOgXLDRC4gXrg6GOAncwkWjW
 AaZD15lN/yWiipvD0E9O2lRBgcL88vEIqOmp1qX39BNj6WIvgF9wyAuZk4+C2uyrDedK8ArYSu/
 H/qgibpfgJNPBc5/K8hed3oYoPm1u7Z2IsBDtg9bORiS22of0G6oAFefpLxM9d+Of7qJkwkN+e9
 yWz4gXQJVr61l2qEkMyAz1sz+Lwm00jLIsRiWMrn9WrFQTgh+SjNrIyeRr
X-Received: by 2002:a17:906:f584:b0:c16:a402:9d8a with SMTP id
 a640c23a62f3a-c20e6189f97mr287124666b.11.1786469945091; 
 Tue, 11 Aug 2026 10:39:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/8] parallels: fix out-of-bounds read in format extension
 parsing
Date: Tue, 11 Aug 2026 19:38:50 +0200
Message-ID: <20260811173857.396571-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=den@openvz.org; helo=mail-ej1-x62e.google.com
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

parallels_parse_format_extension() advances the cursor over the feature
payload but subtracts only the feature header size from the remaining
byte count. A feature whose payload reaches the end of the extension
cluster leaves the cursor at the end of the allocation while the count
still allows one more header, which the next iteration then reads out
of bounds, 0 bytes after the 512 byte cluster. The stale count also
breaks the data_size bound of any further feature, so
parallels_load_bitmap() can read past the cluster as well.

Account the aligned payload in both the cursor and the count. Aligning
data_size before the bound check changes nothing, as the count is
always a multiple of 8, but it has to be computed in 64 bits: on a
uint32_t a data_size of 0xfffffff9 or above wraps to zero.

Reported-by: Martin Holeček
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4156
Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 7f6ab6b0d2..baee86a159 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -239,6 +239,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
     while (true) {
         ParallelsFeatureHeader fh;
         BdrvDirtyBitmap *bitmap;
+        uint64_t data_size;
 
         if (remaining < sizeof(fh)) {
             error_setg(errp, "Can not read feature header, as remaining bytes "
@@ -260,7 +261,8 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             goto fail;
         }
 
-        if (fh.data_size > remaining) {
+        data_size = QEMU_ALIGN_UP((uint64_t)fh.data_size, 8);
+        if (data_size > remaining) {
             error_setg(errp, "Feature data_size exceedes Format Extension "
                        "cluster");
             goto fail;
@@ -283,7 +285,8 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             goto fail;
         }
 
-        pos = ext_cluster + QEMU_ALIGN_UP(pos + fh.data_size - ext_cluster, 8);
+        pos += data_size;
+        remaining -= data_size;
     }
 
 fail:
-- 
2.53.0


