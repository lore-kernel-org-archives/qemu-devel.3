Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3DC3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoAz-0002VB-1H; Thu, 11 Jul 2024 03:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sRoAy-0002Ug-2T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sRoAv-0000CC-PZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720682707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=k46L7m+Be6nl3HwKIE053XL909wDmAgb3/skfnepjf8=;
 b=d/upmJnLfx84XS6IkVS23AJ9O0bUlByoJqiV16L+7++46BCdQMvnIDRNW/7B3ghKeP2Sj8
 J8pKwSzTHlDeO4FFd1doM/gcfIEry97NDpjttG0/c3ORApLxhyzXRdNNRmQa7PpHIU26Fm
 hFwuJ5xme9DqZiQSiJh5lHw9k8TKGCs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-WdhV75j-OLqm4EuVDHXO8A-1; Thu, 11 Jul 2024 03:25:04 -0400
X-MC-Unique: WdhV75j-OLqm4EuVDHXO8A-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1fb0a631d86so5110635ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720682703; x=1721287503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k46L7m+Be6nl3HwKIE053XL909wDmAgb3/skfnepjf8=;
 b=g4WjJCgjQ8jscEHR0hP9HrIoBYxjY/kDt9Zc/ojf4/wWBE2wUStGMNBC8npbpKrTlz
 4OvPBDZ1GQ3HvB/ApI7bMFg1bZifY4S6EwRydFxxNEtssKufuJmnjDEg+NBq+wSuwml+
 5kjkySZnfIqKDMOCiJFDntqCFNuQN/uNeIKb6AkUFX+d9+8lo5/gmv/vLPuf0d+gx+gs
 2dreNKAlJ10ux6KR5OQQ4b+2bcfWYkCAloTcLyovD+h1aQLHYM9mdg6rKafDrvEHDFdw
 +CuGVEA2bVx42IgFfBg3oG/1orFDZGHqiJkvnpN6gKkZ8nmj2/txB3YfR+yW/fySmzHx
 OOYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPu+yQXdNVrGqHwF+7MtdCDAM4zkb2s1RlYsdc1z1eU6689eu8mRkUi83LN/zFNF/y64N4p7ewZUezi5pfBjxT/7qGn3s=
X-Gm-Message-State: AOJu0YzpKnrmihiL7tT9mB2J7O5le92RbV/apyrHaRwvM6wsFjkE8IDv
 +2Q2lyYNXtJwrFezz8M7AzLdwjQ523ltzek16Y7y8+FvKjZbf5BS8TKEijCZ1htqGYnMSDSizxB
 QFFHCHJK8JU27AGm4wTnuxo7bbwfNra15zUUuKfpjRqpqpUvR2DRO
X-Received: by 2002:a17:902:e745:b0:1fb:7b01:7980 with SMTP id
 d9443c01a7336-1fbb6c2498fmr80249355ad.0.1720682703664; 
 Thu, 11 Jul 2024 00:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMtRj5bgYD4s/MmRHYX/3nAarF+nKgYvMO0rpJ+4WHxi3UwMkP2Cp0ib+F+DvDDWStGsKoNA==
X-Received: by 2002:a17:902:e745:b0:1fb:7b01:7980 with SMTP id
 d9443c01a7336-1fbb6c2498fmr80249185ad.0.1720682703188; 
 Thu, 11 Jul 2024 00:25:03 -0700 (PDT)
Received: from localhost.localdomain ([115.96.204.198])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1fbb6a2f54fsm44212535ad.113.2024.07.11.00.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 00:25:02 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: peter.maydell@linaro.org, philmd@linaro.org,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] loader: remove load_image_gzipped function as its not used
 anywhere
Date: Thu, 11 Jul 2024 12:54:47 +0530
Message-ID: <20240711072448.32673-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

load_image_gzipped() does not seem to be used anywhere. Remove it.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/core/loader.c    | 13 -------------
 include/hw/loader.h |  4 +---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index a3bea1e718..c04fae55c0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -845,19 +845,6 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
     return ret;
 }
 
-/* Load a gzip-compressed kernel. */
-ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
-{
-    ssize_t bytes;
-    uint8_t *data;
-
-    bytes = load_image_gzipped_buffer(filename, max_sz, &data);
-    if (bytes != -1) {
-        rom_add_blob_fixed(filename, data, bytes, addr);
-        g_free(data);
-    }
-    return bytes;
-}
 
 /* The PE/COFF MS-DOS stub magic number */
 #define EFI_PE_MSDOS_MAGIC        "MZ"
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 9844c5e3cf..7f6d06b956 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -77,15 +77,13 @@ ssize_t load_image_targphys(const char *filename, hwaddr,
 ssize_t load_image_mr(const char *filename, MemoryRegion *mr);
 
 /* This is the limit on the maximum uncompressed image size that
- * load_image_gzipped_buffer() and load_image_gzipped() will read. It prevents
+ * load_image_gzipped_buffer() will read. It prevents
  * g_malloc() in those functions from allocating a huge amount of memory.
  */
 #define LOAD_IMAGE_MAX_GUNZIP_BYTES (256 << 20)
 
 ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
                                   uint8_t **buffer);
-ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
-
 /**
  * unpack_efi_zboot_image:
  * @buffer: pointer to a variable holding the address of a buffer containing the
-- 
2.42.0


