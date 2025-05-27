Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53825C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KH-0004kS-VY; Tue, 27 May 2025 17:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KF-0004jl-Bj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KD-00087u-UU
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUd2N/gt18BX9yz0xYPGJs36PcbgIsSrKQL2cAT1iQ4=;
 b=JUeqPsASqdSUYEAvfj05sz5jWtRP3AfYrhvwvns9XIDTVwxlrjLZkcFK99naegezl1nzaj
 xtqPMNZV2E2W4zEwil5c0jIdFV2qRI2kJsHqa6WlFdijPwXafPN5Utz8s4vRRQvkz4mOCh
 ezvGl4EmfJHqkjRynBRiv7Km80fu0eQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-OJT4-EQkOLGIZELD9T1yCw-1; Tue, 27 May 2025 17:59:07 -0400
X-MC-Unique: OJT4-EQkOLGIZELD9T1yCw-1
X-Mimecast-MFC-AGG-ID: OJT4-EQkOLGIZELD9T1yCw_1748383147
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6faacebc952so43112996d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383147; x=1748987947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUd2N/gt18BX9yz0xYPGJs36PcbgIsSrKQL2cAT1iQ4=;
 b=wD+KceTehtRLrDAMzRJ31yNPhn+M/QDd9poURDuNq+R6Q7L1rTld7+d8vCZG/nOejb
 37Vb3cdDuyKFkeVYKop1NiZvoKwvcyVhkPVr6ZwcRW767GU3xAOEKlBcflVpQfil+gdh
 YmMpEZkBIZfkOPrUgCCotB2+kEa654dXBREKJTqOwq3Cl8jMLOsWAZSuTSqcv3JO5yU8
 IWgQQ2cIhJBW1Dv2fXxYkHn25EYmkiOV9MYNmdX33e1DTmMMn5a67+yaa1i+vBziA+qs
 QcGLBP+Rf4n+itlbTAeINvBANFtmUvK8TuWFYc1d+b0xRA+b6ZJ45nsfmuIjodQosaFZ
 l+8g==
X-Gm-Message-State: AOJu0YyBADI4Z7XgEuD5F5EwvPWChl1B1Ckrr9B0Jomo4+U755dwwsqx
 vvIheqwHUZvj5nRt2aNtf1TRKPoyvwnIC6Ij38xCKKhvTlcRN4SC5vdIclq7xUM6TsIFq0i937X
 mkjNXPpRpCp8U5S5vhnrXpJARZAx1KbVD0awlCUV2vJWDwUizCNjhqdj0QBZ5RMwoN25/mNnwlw
 63PI1Rgr1WeC9x/e7Gz7o+5Mneo4a/ozm9YQRAGA==
X-Gm-Gg: ASbGncsHYHXFZTqqui1TUSzREddD9O9Fsmz9qH8uzurECzDxHNLFbm1wRO3Z6ADVZBO
 Dpk3T7Y5R+UEHRacfYfsMhsFtsckVZjtqIkxaeS0lZysoq3jNJsVb3CR1xCSFK+LoCS/uzm/fxg
 Mp6X5lymmO9lpB124k+NTr9ahjBAB/rorgdtwZF6bqdO7TPzO/vSgU98Y6Laf9fstODVy4St2Z/
 nGMBJtTQwwwAsyjjrftW+8WS8zaTeiRxrQ8NEbSZPHpiXE/eDSTOLwmXAHhd/W29v1DnVWtylI1
X-Received: by 2002:a05:6214:ac6:b0:6e8:f17e:e00d with SMTP id
 6a1803df08f44-6fa9d01da5amr257560576d6.14.1748383146874; 
 Tue, 27 May 2025 14:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBeSfDhPYTlvFfN8T+OrMPtuBhoeP3r2g5pSZKi4EKuIhDEYlUdjFHq75J9duiLl/0pN9Aqw==
X-Received: by 2002:a05:6214:ac6:b0:6e8:f17e:e00d with SMTP id
 6a1803df08f44-6fa9d01da5amr257560276d6.14.1748383146572; 
 Tue, 27 May 2025 14:59:06 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 09/11] migration/ram: Add tracepoints for ram_save_complete()
Date: Tue, 27 May 2025 17:58:48 -0400
Message-ID: <20250527215850.1271072-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Take notes on start/end state of dirty pages for the whole system.

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


