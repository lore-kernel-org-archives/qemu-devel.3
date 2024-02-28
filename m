Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CC5C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJXw-0008LB-Vz; Wed, 28 Feb 2024 08:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJXm-0008EC-CN
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:00:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJXg-0001X9-Az
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:00:17 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46D2A3FE49
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709125209;
 bh=5nHIlTiIrOAQkUS14+L0as1rnVYvFgw3GZJu5GYwssY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HydQB1Vs/oYAz5fBUEMCtibzkbQSVaZSOPPKYWh8/mLrLVBFwBon76ANQmR+IQqz9
 gc1sstEwUQSGyUoQY+kB0U1sAClhcdQsmPAs2nm8C/sB5FKZmQvhFa/FHURkLz+cIe
 g4dC41pZHRncuOu+GRo8prKKzA+Z9UJa938c9FknDp0UA8cm7rV/kgt5z/jHGRVxyu
 5ILIFDdjleTE5B8/sxbHDw+D3Rlr4JYXDOr5h9/BGfaBVGzeqHprALRosfb0kK2A/5
 rFWAhDNPes+3HONiDO4kGYm/dr4zDl4JQ2gucPe8rPeZo67RUdvpYOgqLglir8Gd9S
 3L2Qajpm+mS2g==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d2b326f17fso8441471fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 05:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709125208; x=1709730008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nHIlTiIrOAQkUS14+L0as1rnVYvFgw3GZJu5GYwssY=;
 b=jjgqHUOrxxtANU8A1Ufj1QjzUYE2NzUYtDT0m2KMeZPo1pDxxcYDZt/x0pS+cDaT5R
 gVg6Kr5UHVfAUYXedagcjbRsx5/m+3CM5tCMTUsr6KcPdn6eQ0w72qrLmVfObhsvr2uw
 d8QOuP4AYLJUDXcVLKu3wjmcHfglCi0p2E8iiuYROaWHD4vFqIqYHerlU7xKwZPBIl6r
 NDJSJR9TmoOmshzi3cmjkWb5T7PE5jjMnHY5kk6hJO7i8M8QvIlrZ9dbX+Wp+tIWtNT6
 DnmPV5XDXHO1wcJVAzIHGUmhY+4vEmqMr++dhSj0YaGoY5DyDc0VU1CnKY1EPVNguiQz
 hVTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD1NhTr99FCN9pRClg5ol/PDMUlx0GX4x8Calnr0wQc88FEayoy9V8dNjlxNOs+LYLHJF3ZrQpWTL5pB+MgSN3gl2rgGk=
X-Gm-Message-State: AOJu0YwVAUYse2EA6Oez9jqTRq+yN+2ID3W3CTl6B2OzSIZgbNP8X3Vd
 KQr0l4VvC/Ubi2psKd+xUmEvGN9kCyIgfdMZ0BgWhsxDAccPO+u7ztuZo92ian3fqJrN/kaWmem
 V2h3VI8/v+6O8VycrN+KpwS9zuGgvCIRWV9qNLMB8CkFAzAWB85LJWWzZOgLP1G5zSVZE
X-Received: by 2002:a19:5512:0:b0:513:1957:de76 with SMTP id
 n18-20020a195512000000b005131957de76mr1216818lfe.48.1709125208587; 
 Wed, 28 Feb 2024 05:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9TxzdMLEpbqkxCswqMsnbJxB8FpPVD7qm/1dJWVev2q70/gm+qQ1LBttB7aeQD1Dn2jBzeg==
X-Received: by 2002:a19:5512:0:b0:513:1957:de76 with SMTP id
 n18-20020a195512000000b005131957de76mr1216795lfe.48.1709125208210; 
 Wed, 28 Feb 2024 05:00:08 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-095-222-037-056.um34.pools.vodafone-ip.de. [95.222.37.56])
 by smtp.gmail.com with ESMTPSA id
 p1-20020adf9d81000000b0033e0567e90bsm64893wre.5.2024.02.28.05.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 05:00:07 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH, v2] physmem: avoid bounce buffer too small
Date: Wed, 28 Feb 2024 13:59:39 +0100
Message-ID: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virtqueue_map_desc() is called with values of sz exceeding that may exceed
TARGET_PAGE_SIZE. sz = 0x2800 has been observed.

We only support a single bounce buffer. We have to avoid
virtqueue_map_desc() calling address_space_map() multiple times. Otherwise
we see an error

    qemu: virtio: bogus descriptor or out of resources

Increase the minimum size of the bounce buffer to 0x10000 which matches
the largest value of TARGET_PAGE_SIZE for all architectures.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove unrelated change
---
 system/physmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e3ebc19eef..3c82da1c86 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
+        /*
+         * There is only one bounce buffer. The largest occuring value of
+         * parameter sz of virtqueue_map_desc() must fit into the bounce
+         * buffer.
+         */
+        l = MIN(l, 0x10000);
         bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
         bounce.addr = addr;
         bounce.len = l;
-- 
2.43.0


