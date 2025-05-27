Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB24C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KQ-0004lZ-8E; Tue, 27 May 2025 17:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KI-0004kj-VX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KH-00088H-CP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow9XZwvFSPaA1YRoz79EY6e13wTkk7fPGrMeCj5AqlA=;
 b=HUWyYebxsV+bscClle1EJBgvVze70agUCFUUqVyWFWOwZNlnnliLwgg7Tg/ukKetM9UgYM
 E7VA5iVAHd28REtGkLBW61kUgbcYheQVTcvLd3v/mD1RJq72n+1wFA+TsDBwu4JuylJ5w/
 sNwZaGBfMuvuv5ofFCeqQ2JStX2pxu0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-HCNP35QMOh2IcZFEqTFahg-1; Tue, 27 May 2025 17:59:10 -0400
X-MC-Unique: HCNP35QMOh2IcZFEqTFahg-1
X-Mimecast-MFC-AGG-ID: HCNP35QMOh2IcZFEqTFahg_1748383150
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f50edda19eso56597766d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383150; x=1748987950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ow9XZwvFSPaA1YRoz79EY6e13wTkk7fPGrMeCj5AqlA=;
 b=wmnRfFBulI7R8061etwW9FWVO60XaWaF/PjZfBcUEjE03n/yO8TYGw+GapFk6/XPah
 iKTKybU22Ez1TG6uAabJyUBhqq2JMHCiFjZH98ebBdaq6WE3zzID3iJJLDoXj7Ax6YXw
 trbchDmqWOENil1sjBbuWoCbIHwzY6BZw8mhCWvpqAghujs4P85HjcAc1+iV0o4zF9YP
 dABLN8CUWotzU4eG89FaZyLDeP3G8OxMuaNB2aRFHPoB04sjBOy6AHkxr9JaKSesW0q4
 bygQKwZajb+5JWtyqoE9I10hYttyaSOTfk4JUKF8reoiXroAtT9F7+HKPU82xZ3oo6QL
 a1gw==
X-Gm-Message-State: AOJu0YzlfJJQpJZRomqjgF+VU5yDgqjOCuAay4MSbfaWgc16n12Rmhii
 xXIFovCfSCeeq6rgwGoXQ/otrkcriaFVNcb4mgpEPpWoVnGvinM/Ct8ZNhPx5vpUFNn9dFrvbH+
 WCECy+IG6W9tWdanbXJCaxKEgWo77TIo7z5D2oeEXUd/mKU6q/BfatBXzAue+8bA3HbBuHU4UMU
 ijcES1pV1OuVzG4gQZS2YmnMG+/UbPdVkA/bTIEg==
X-Gm-Gg: ASbGnctylbCuYNRUsZWwCwVPzaTig6Bhn9HSDb+BzG5ghr8vI20L8+TRzgo3/vd2Goi
 RRC6czjVrf3Dj5cJa7OIPg2dMxyKv+75Ud9/hJfop+gC6DQ58GUVFa6txMluj/Ju+uwCHoRBm3f
 n5ySOlkPvldUQqm7tIbxGBHMns38iShFMHPwXwDSDIAlFE6xy351tNCTEa6mpV0SRp5YCJR/WF2
 jx1pHQst7NHNpNvJDbMFxUnJa7bRWhuulPZ4ktHKXlELxwg1IjhdMw/65FB/JBOUDTAdxS+2yCP
X-Received: by 2002:a05:6214:1d0d:b0:6f5:f83:1cf8 with SMTP id
 6a1803df08f44-6fa9cfe9a16mr248859066d6.7.1748383149725; 
 Tue, 27 May 2025 14:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEERYoWgEOp7ygcCxwDSWKMlmRyOV4jZWAiqDgES13PXu/QctQIcmzedy4Z2V19a3Lq1B54JA==
X-Received: by 2002:a05:6214:1d0d:b0:6f5:f83:1cf8 with SMTP id
 6a1803df08f44-6fa9cfe9a16mr248858726d6.7.1748383149336; 
 Tue, 27 May 2025 14:59:09 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 11/11] migration/postcopy: Avoid clearing dirty bitmap for
 postcopy too
Date: Tue, 27 May 2025 17:58:50 -0400
Message-ID: <20250527215850.1271072-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

This is a follow up on the other commit "migration/ram: avoid to do log
clear in the last round" but for postcopy.

https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com

I can observe more than 10% reduction of average page fault latency during
postcopy phase with this optimization:

  Before: 268.00us (+-1.87%)
  After:  232.67us (+-2.01%)

The test was done with a 16GB VM with 80 vCPUs, running a workload that
busy random writes to 13GB memory.

Cc: Yanfei Xu <yanfei.xu@bytedance.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a1d0e8ada2..cd4aafd15c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -835,8 +835,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * protections isn't needed as we know there will be either (1) no
      * further writes if migration will complete, or (2) migration fails
      * at last then tracking isn't needed either.
+     *
+     * Do the same for postcopy due to the same reason.
      */
-    if (!rs->last_stage) {
+    if (!rs->last_stage && !migration_in_postcopy()) {
         /*
          * Clear dirty bitmap if needed.  This _must_ be called before we
          * send any of the page in the chunk because we need to make sure
-- 
2.49.0


