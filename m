Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A542CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTt-0002ue-94; Wed, 22 Oct 2025 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTc-0002sQ-AQ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTZ-0001R0-9z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61OlonQ1mj4eAWEnn8sA5zmXZ1Lvykf4bLCwkotKe7k=;
 b=Q22eI8f4SqdTT9MGAXffbAThCM6Tr67epp8ttgGPxVybzaHtUsAD/p3VdYjbNiwbPXDNtc
 AR/Olr4Hm8PpdcPhMaUe8veGXUF4EYLxuClQZkrDF/8XH/HFgjxei6bLXsnahuOZTBFRWn
 D0pl45VuIg3YdzDuNcbkpgNabsDAXW0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-BAukl99nPHCukyQQcdU8OQ-1; Wed, 22 Oct 2025 15:26:20 -0400
X-MC-Unique: BAukl99nPHCukyQQcdU8OQ-1
X-Mimecast-MFC-AGG-ID: BAukl99nPHCukyQQcdU8OQ_1761161179
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8916e8d4aso67858841cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161179; x=1761765979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61OlonQ1mj4eAWEnn8sA5zmXZ1Lvykf4bLCwkotKe7k=;
 b=IZ6m1L1N6RHNAvg7U+6yRuBRtzMBnvZvyOwIdkK0hPiEWFSe+4FhqY3pw6IKl8Tci3
 Vy0inht+LLRHjD+Z6WUW+me0IpfhiObwhhF2nNnajVGh3p7J8Es+nq87WhBlYC2Jv8qJ
 lmRgsBVo8KKkPze0UhNTv8ozWsBJG27nA5THHzVUJC/uA5sQeHVj9yCkr8SWPMYdIh8z
 93YPht9XfHV06dLr98BvB0NncsgRylQ2KRhrdYtBVHhOMv70qtKHbB+kJX653pzDkuub
 nSeRyEfDoVWWQr0ys5uOSP0YSfVHeRT02AC00WFzNj76VildT8NAcr6OwWQqyjOhk3Jr
 hTNQ==
X-Gm-Message-State: AOJu0YyqsIxHiYV8E8B0t+F+1tRfRwVr28KgwHKuOzLOnQdXfeDQ2Csr
 jGaQJXst0KsiT7CJD/V1eMgco1hTNFVqRrVqXQ61WSkvDyKliMOsXnrIoeIaN9FjC+NAsZXBHe8
 Arso5Ab/lvEk46bMU0o6sWsXvTb69OI42UHgk5xduk9s8pwWE+0IE5RiwxuCPXyYisYrFdWJ3et
 d7afMp36Q2ax4LLD9aH7LEzc+i4+XiuBviBtw5zQ==
X-Gm-Gg: ASbGncsKSYzwwtpoV567v/easr273QNchvuOrw1/nXrM3RpOEPLhnOgFDB8VF1IvrGa
 bOD3Dl9MN+xFsThJLNHy+F+4q4+fUY1/CdW9QZjAuCTFkCyqXbwqD/+F6PYl1iVsLsP+VpHR++S
 kosl6pMh1hxulBTTNmaBYbEBVbGWO7F26xMNb2iyVedYIGtZyR4mOQtQykXoN8vh7w6lSSKhCzg
 +SuKjf+8xA4PDmHzppeVcIDELwZYmnCcPjoSoNob8pF/W+TY85D+rOoyf8zhKut7ljULYu1TJdx
 7Qeq7D6vfIS6cfg+ym9DxC4yspMan+aCo8vS4vYybn9z9pUOU5FZxG9l+WT4pGi1
X-Received: by 2002:a05:622a:1a9f:b0:4e8:9809:82b5 with SMTP id
 d75a77b69052e-4e89d1d994dmr236809231cf.5.1761161179073; 
 Wed, 22 Oct 2025 12:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEatqoyacPnKNZo7Jnm+fR9tBJpJFoFqlKY/9GAgG99O+3Zgv/7SpB6pt3hl+BFskr/hQEg5g==
X-Received: by 2002:a05:622a:1a9f:b0:4e8:9809:82b5 with SMTP id
 d75a77b69052e-4e89d1d994dmr236808901cf.5.1761161178590; 
 Wed, 22 Oct 2025 12:26:18 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 02/13] migration: Properly wait on G_IO_IN when peeking
 messages
Date: Wed, 22 Oct 2025 15:26:01 -0400
Message-ID: <20251022192612.2737648-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

migration_channel_read_peek() used to do explicit waits of a short period
when peeking message needs retry.  Replace it with explicit polls on the io
channel, exactly like what qemu_fill_buffer() does.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a547b1fbfe..462cc183e1 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -135,12 +135,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
             break;
         }
 
-        /* 1ms sleep. */
-        if (qemu_in_coroutine()) {
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
-        } else {
-            g_usleep(1000);
-        }
+        qio_channel_wait_cond(ioc, G_IO_IN);
     }
 
     return 0;
-- 
2.50.1


