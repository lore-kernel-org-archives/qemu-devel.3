Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E93AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSR-0004xs-B9; Tue, 03 Jun 2025 17:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSL-0004xK-PG
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSJ-00067s-Dl
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J33513jn08zgNTYa7se2Ks54aG/KpNg9VKnJHqRjCqg=;
 b=ZrqUJ8xVUgatb1lEn2CvDyJZ8w8e3W/tkCRLU/SeBXjo4xI+hLvT+CwTiLxv7e2q24qviX
 ZpmeI+NuPSWELgUqC9gFi8mQs0zfY9UJrlB6Ajp8BFiapjxG4gkPR27ORIyY9EImmdQhk8
 kdlNx1r9vlF1aS+1SrEHQdGB/4o2I2I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-7MRvHfmqNiCfcgAkyyZnbw-1; Tue, 03 Jun 2025 17:45:57 -0400
X-MC-Unique: 7MRvHfmqNiCfcgAkyyZnbw-1
X-Mimecast-MFC-AGG-ID: 7MRvHfmqNiCfcgAkyyZnbw_1748987156
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450787c8626so35309295e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987155; x=1749591955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J33513jn08zgNTYa7se2Ks54aG/KpNg9VKnJHqRjCqg=;
 b=FRcv+/UFjfdI90Byn2leWGqsSAGqzsBkTanQywiHlWizQ2sNevFuKjOYa0fkilhvLs
 1A7QpvbYan8q+ZE/IhozVax3jiXWZXpR8v7fY0hgl8NmxzlnTUl7OclMek8z3KfuJ9Jj
 j1A2B3McKC5TlNazi/IVhuykYGqSyIjGmrTOrW9AiAQ2V5CqzDLgtchUVx5vgrMKTYa7
 vccPZFVKK7ys2qkirqW1QmxWv3En416f4FoCG5U0jX0Z28tyGEG6YJZIV9YQ/v7HJWzy
 rhymGVy/UkQdzBPLgJrJiuheQNAuzSkwUK3TJ+SI4iFegkTbgoXWhuQiFEMMlU8UaAw0
 H0NA==
X-Gm-Message-State: AOJu0YzPxtRLmVTofG117C9ajdqOwhY4emJmsorwJA0Dn9mX3JxarF9v
 eZnIB2ui6pHqrORQS5fQB5lhW1H+okpY8ysoFsXYemsxiSup2HW0wMqwrPynK9mbUdXtp5vTrso
 nLJ3gbhS04gnzC2RZAloOowD8MHdpXlxSsnjfnoaBjJQ/dGkh/Mm8yS8Jthr+BqtnBIIWNlhv3b
 cYrDMXRAEEUiNMzhgxecchxrJNdq3ERn3D+XtxsYXg
X-Gm-Gg: ASbGncsTKzBHL/dInDL0fXjjdQ2QJvNH/T1qCqd1txjMPXPkcHJwhpj0qdEk3xJ+BSE
 befCt9/yHscCz952JwC8uVR0z233zQU5PjRasOdDXZ0yd4QPpMhQv3cZ4nQ5/CPE8A+WkmL3exY
 h8VKmKcNViBl+/jn4+JIFICs7mvozq143J9eiDr6XSxuhe/DewtyAFNIertw03xliskfi7gXLS2
 UGfLVpMokG9UWBwZE5OmSoRvfC3hxKzQJaAXD9FLqywf80y9aJPbvGcAe4j0d8P6SbfvZ0FzjRb
 mKrKBqDYONairA==
X-Received: by 2002:a05:600c:548d:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-451f0b20d15mr1828775e9.27.1748987155588; 
 Tue, 03 Jun 2025 14:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyh4oTP0soLwQGs18bjJiT3xuRkP3dUA7ome8V5QSbg4aPO39r0lv0t0sFs0EolCp77KLX1w==
X-Received: by 2002:a05:600c:548d:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-451f0b20d15mr1828625e9.27.1748987155154; 
 Tue, 03 Jun 2025 14:45:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012b09sm173168645e9.37.2025.06.03.14.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PULL 13/16] i386/tdvf: Fix build on 32-bit host
Date: Tue,  3 Jun 2025 23:45:20 +0200
Message-ID: <20250603214523.131185-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Use PRI formats where required.

Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20250602173101.1052983-3-clg@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/tdvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
index bd993ea2f07..645d9d1294b 100644
--- a/hw/i386/tdvf.c
+++ b/hw/i386/tdvf.c
@@ -101,16 +101,16 @@ static int tdvf_parse_and_check_section_entry(const TdvfSectionEntry *src,
 
     /* sanity check */
     if (entry->size < entry->data_len) {
-        error_report("Broken metadata RawDataSize 0x%x MemoryDataSize 0x%lx",
+        error_report("Broken metadata RawDataSize 0x%x MemoryDataSize 0x%"PRIx64,
                      entry->data_len, entry->size);
         return -1;
     }
     if (!QEMU_IS_ALIGNED(entry->address, TDVF_ALIGNMENT)) {
-        error_report("MemoryAddress 0x%lx not page aligned", entry->address);
+        error_report("MemoryAddress 0x%"PRIx64" not page aligned", entry->address);
         return -1;
     }
     if (!QEMU_IS_ALIGNED(entry->size, TDVF_ALIGNMENT)) {
-        error_report("MemoryDataSize 0x%lx not page aligned", entry->size);
+        error_report("MemoryDataSize 0x%"PRIx64" not page aligned", entry->size);
         return -1;
     }
 
-- 
2.49.0


