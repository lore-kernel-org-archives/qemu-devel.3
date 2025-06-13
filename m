Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF20C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ550-0004AH-QH; Fri, 13 Jun 2025 10:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54x-00049N-1L
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54v-0001Vt-1k
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1A0fDBuQYTqmVarAzgYqBRrK/hWUHvpepmptSmGtWkw=;
 b=gbrLMuWJfsb8bTJoIoO4mZNN6kjW/E5kNophYcsedkcm3VZmU1Srqx4gy5Nv4Cetp0DNvW
 iBhXCJw/69XVmhvQ3PMhYgihD/fstD4GRhUncqqKXbVRBU3DBGW9yyZXnySuu4kF+rO7rF
 799CE9t2zXllwatpOXj9B9kjO3bRt38=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-_UjnyBUVPaaDRDq9T9RXYw-1; Fri, 13 Jun 2025 10:08:19 -0400
X-MC-Unique: _UjnyBUVPaaDRDq9T9RXYw-1
X-Mimecast-MFC-AGG-ID: _UjnyBUVPaaDRDq9T9RXYw_1749823699
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a42d650185so28999161cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823698; x=1750428498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A0fDBuQYTqmVarAzgYqBRrK/hWUHvpepmptSmGtWkw=;
 b=DB+zANkXKOYI2RpgaXKBGa2dxmvZLF2/R0mUD6LZRHCCTmGTpjbzl6PbZAdGDO/ldX
 yx8QUCBecz+EdlD+zX4SO+jdJ2oUyPJ0xXLhcuJmxWAUvxpztou2cizGtVvjeA8NW8lE
 cg9KgNr5MyhQ6hgOYzMVIpLp90/C7aWZSqSVJSnKEW1M6qwwjQi6qQkVoVj6CHnPJ0Mj
 RPfHhlsH+ADLnEzank48/pknMQL9xFAuvrY2F/CrtYKUHo/W4iaVJvUNepur2e2zx/KS
 +eJtTvMvmUkBWdIgUj/X6geDFAhyqF6V0ms63alU52Ukbozhl5RgrTwz/4CRpvqUBgb9
 411w==
X-Gm-Message-State: AOJu0YzhdM/Zqe0EOmPD8669Y8NkGqKt96ginO8jqWggZQAI3lQZCdy1
 SHPJLcpiOMAFH+aL9rDMF14FiU3MGPcm1MXN1PJ/Z5HskvOT6R7rMcOXVPHqiEkadb08RyZxGyz
 Pk1YtGmAXjjAYYUH/kd8TAN90un9wPWYEWTA6iK/KL/qybT+Ny02e29xhpSwbjpF/KTMVZGRoGe
 /nqCfonJExUsO8DiBVgaa/OnaMQv6t8cixwkoshA==
X-Gm-Gg: ASbGnctC3lkFz3gWJBXK5b6/klnjA4qckj9gK95HnL1KByv3y+Vka6NPnktpEKI5KgK
 KmohRF8kyJkD27Ps1+iEhHSj1meIeGvMsYAdQTyWrZMa9+yMWHrczPz+Koz0iQBvGUL5dWol34V
 7sKxbL/lnAM4dmaNadz8esNPTVEOA8Kv7bkAzWt6FFLbFCt6bpMW1K8AGc6OV3G7GUysybEw4XQ
 IhKJPM748+sNv9vbn2bHw03AF59aw1xwcAtRolVKEE1nc9jyL4S3dIHQ+KrJUTBawlXL61YArMP
 AyxSVqefWmI=
X-Received: by 2002:a05:622a:1e98:b0:4a4:3171:b942 with SMTP id
 d75a77b69052e-4a72ff1c1d8mr57239741cf.39.1749823697874; 
 Fri, 13 Jun 2025 07:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcUg2sla6Pi8BTIx7AxNjTdd5kTcrQwyuGwGYaSh2EgvGfy9zw1ofuiuNp1y3rP3Mx9kSsHA==
X-Received: by 2002:a05:622a:1e98:b0:4a4:3171:b942 with SMTP id
 d75a77b69052e-4a72ff1c1d8mr57239221cf.39.1749823697382; 
 Fri, 13 Jun 2025 07:08:17 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 09/11] migration/ram: Add tracepoints for
 ram_save_complete()
Date: Fri, 13 Jun 2025 10:07:59 -0400
Message-ID: <20250613140801.474264-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Take notes on start/end state of dirty pages for the whole system.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 5 +++++
 migration/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index c66ad3cf8b..a1d0e8ada2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3289,6 +3289,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     RAMState *rs = *temp;
     int ret = 0;
 
+    trace_ram_save_complete(rs->migration_dirty_pages, 0);
+
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
@@ -3352,6 +3354,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    trace_ram_save_complete(rs->migration_dirty_pages, 1);
+
     return qemu_fflush(f);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index c506e11a2e..dcd8fe9a0c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -105,6 +105,7 @@ ram_load_postcopy_loop(int channel, uint64_t addr, int flags) "chan=%d addr=0x%"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+ram_save_complete(uint64_t dirty_pages, int done) "dirty=%" PRIu64 ", done=%d"
 ram_dirty_bitmap_request(char *str) "%s"
 ram_dirty_bitmap_reload_begin(char *str) "%s"
 ram_dirty_bitmap_reload_complete(char *str) "%s"
-- 
2.49.0


