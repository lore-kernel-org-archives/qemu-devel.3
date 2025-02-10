Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43F7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPRb-0006G6-Tl; Mon, 10 Feb 2025 03:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRU-0006E0-TM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRT-00045Z-8N
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ef1RecRxAPZwDQS2yKvZrhemiPbygCkC67O8bP/q9Zg=;
 b=FsHHtWH92L8m+XpNxkh8p3DdC5/UzPXk3rlZHfFth/vFkvtRSTp2o20khdTePp/kZAv6GU
 Adk36zd6N63hGmh6JH84FTrMtqWUzTzI1vrHsFJXt+Kt4ULk6eTwY7Nnb8NwmowJwgbq2+
 99uqDJhfBxyoMWeBzdqQqfRKbkiNlcs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-QHAAzfXfNI2lPQCzDcDmCQ-1; Mon, 10 Feb 2025 03:46:56 -0500
X-MC-Unique: QHAAzfXfNI2lPQCzDcDmCQ-1
X-Mimecast-MFC-AGG-ID: QHAAzfXfNI2lPQCzDcDmCQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dd91cd38cso702850f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177215; x=1739782015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef1RecRxAPZwDQS2yKvZrhemiPbygCkC67O8bP/q9Zg=;
 b=gz5PcncQ0rHVShNSqTf7X/cI/mpzsS8KQ47uH9KAf35J2m/UzNobOq3Kef2BovHbL3
 2N7ADsDsCEXg1dazBrUDGa63jjzUgSkkVvauuAj1qmhqTjihb4EpUtDS1RXg1syC5rrY
 Gdze8xqITyvkTiSVshsemERESdOsACmun/5qEDnwSI0dzqWo58MVLrsGYdtI4Uh3jkio
 S3h9uEIVYpgRdvO8q7iIZlbq98fccqCbaPWlvLvbSbMLzitCSr88ECpEoPoFj75oLFug
 6dgn6cplSHfttAgku0NGm5yoKaanvSOCe0ObrGEzQSWw/Npw9FT+Y4iAsn8AgwSZBGqY
 Todw==
X-Gm-Message-State: AOJu0Yxgp4SzdXITD9XvmdUJzIG6fNf96itexeHy5ZSLvN1S0gexPFWj
 N2BgusRTQTS4Tbl+DfcqXSoXkrYa1Yys/sS0CLaPC92yCIefQHnVKXcWnxx/bZk5bjcGbWi8yQ/
 ecEt4h9taShfUJ92ChNd+DBY9jabPCRhSIIEJMokg8I7PnNSagGA2iSm07fT6HI1A3hRU+w1d3B
 eA/EXejfoC9VKG7UqZY4W9KcNjZ56pfxZ4
X-Gm-Gg: ASbGncvMXyyFvQ+MLSoT0IbdjSEbyeYIgP6fbK5MEpsDvzaz/Kv3owBuYYZ/viQ/pEe
 oumb9eNL9UWL+hNCnKjSmhupm4AQiuu16MFQAoZbWteV2YmVJqNGWXxqslYbWlqak8oxTk2yBf5
 UBJHLdpY3+EQPJGOq36iFGn+XtkPhhTGc20rpFEstfyO5RyKBTt74JiHvFwJUJUvUzcitU4iVlP
 ZQIA8VrRl676lLT8MAa84YFP6AqGW9o+ic0cr/BqMyCmeNhlxMPPf2tOAn7tx9V+tAkPjoH78AW
 8Q/zDSGWZzbcor8H+nvCqceFU04AzgJIzdS8aRMgkHkM8NOiCRFJ4VkoyXZ8UbJMTQ==
X-Received: by 2002:a5d:59ab:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38dc891ff80mr9299563f8f.0.1739177215458; 
 Mon, 10 Feb 2025 00:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1ciQeMz1l11TsPg1Lr+XwpjVAysO8rL1opUL1Sd34fSwKdOdq8dLAdW11YNpSfvEBNXHUZA==
X-Received: by 2002:a5d:59ab:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38dc891ff80mr9299525f8f.0.1739177214986; 
 Mon, 10 Feb 2025 00:46:54 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dd6080926sm5625957f8f.83.2025.02.10.00.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:46:53 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v3 1/7] physmem: factor out memory_region_is_ram_device()
 check in memory_access_is_direct()
Date: Mon, 10 Feb 2025 09:46:42 +0100
Message-ID: <20250210084648.33798-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
ram_device regions"), we disallow direct access to RAM DEVICE regions.

Let's make this clearer to prepare for further changes. Note that romd
regions will never be RAM DEVICE at the same time.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9f73b59867..5cd7574c60 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2997,12 +2997,19 @@ bool prepare_mmio_access(MemoryRegion *mr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
+    /*
+     * RAM DEVICE regions can be accessed directly using memcpy, but it might
+     * be MMIO and access using mempy can be wrong (e.g., using instructions not
+     * intended for MMIO access). So we treat this as IO.
+     */
+    if (memory_region_is_ram_device(mr)) {
+        return false;
+    }
     if (is_write) {
         return memory_region_is_ram(mr) && !mr->readonly &&
-               !mr->rom_device && !memory_region_is_ram_device(mr);
+               !mr->rom_device;
     } else {
-        return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
-               memory_region_is_romd(mr);
+        return memory_region_is_ram(mr) || memory_region_is_romd(mr);
     }
 }
 
-- 
2.48.1


