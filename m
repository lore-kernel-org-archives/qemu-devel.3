Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5675DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6H-0005gy-N0; Tue, 11 Feb 2025 17:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6C-0005f3-Io
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6A-000558-ES
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eeNEejx0gSgxbc7SXhQ12rr1X3D1jH5EIOgc3BWNRhY=;
 b=UdwRJUWJ8YQCl55pLJDspTxZGT5J1XXDS2zY/dZlzHWpOPtjqWWAXLW0d3smqFx1GnF1z2
 pm26QRs8AUJfMZMOUIqcziy2YoMBOLcZlvaqbSPk3lDWNnkKI3QHbY/cWXJxn+Qnl5H0Ia
 VpWHGUWwZ4QK0/vCk8YvJSHxxEEiVBQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-SkavUxZcMn6hX0m4uuANiA-1; Tue, 11 Feb 2025 17:51:20 -0500
X-MC-Unique: SkavUxZcMn6hX0m4uuANiA-1
X-Mimecast-MFC-AGG-ID: SkavUxZcMn6hX0m4uuANiA
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5f8d5e499a5so4254096eaf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314279; x=1739919079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeNEejx0gSgxbc7SXhQ12rr1X3D1jH5EIOgc3BWNRhY=;
 b=PsbH3wgtslWbrdQvo8PfvkAWj/Xij/BTzfq53ZPCCOqlQ3BH5WHBsKnW81o2FI/DJa
 7md0zwXLEOxZwTmHHuYXhNadqNZGzJyauDeZIk141Ccs62z+ezlTnlxFH9f26DNK+18m
 zFMKV6TtDTSKXgT+njXwKgYCa3tdWW8T2mm/w5RWej9i0kKlmIHopZDpciDlDl/s3Gzy
 1fy1deRCCtuALkWOcNS2kxvwYA/xmhEmFUnHxpiITS3X3YZuOTZ90gwPZ7CQ4NdITFZC
 dQmZEJG1R49ksczbjLnB+Vs8UJB63VhtmrnXvsdhrW1sF2IjD+kroB2ZMxTAJTuaASuQ
 lKCQ==
X-Gm-Message-State: AOJu0YyJSTDnJy9YskNIcUBC+VVRYKbWKmjK3KON+GL/cH3J8VCmYwRm
 MalPSsC7yXDfNHZiAxtUPeCfoNacJk8CjfMZOIhszdLo1LSakPb9LtBuiopZGGN/xE/CyLZ3XjG
 46kMUbZTWGI6QAGE6J/vbuncRcjnIhoo0Vko3TKDVJSIjQhuScekyHFK2WxCj99QIplyHvlhX75
 I88yHtvykBGcRdWTtsJBgQEZUMpVxheiX8wA==
X-Gm-Gg: ASbGncv2tRyoLqL2qotbQ9EXk3jaFpSuTmJO+kI8oKmAs+G1O7ukm9420zLBm56UQBu
 ntXEC+BoxhtGT8XKuRbfS/T16l7hH90i9Irh2woJRFqvvZYlkVMu3PeCrdIGzhLghgt6+kXevNf
 lC/7fNGq86Z1nzw4aQh6DTDYfRELDqjT4jWbTPDWR0hQwAGv3bgRLWEJnjhml2QA5+8Eh0y3vsL
 c4XxhHoofLtQRFkbpiCshf++J9XO0IhLBAGWye4tMwyNgWOaYw0KcLa
X-Received: by 2002:a05:6820:2904:b0:5f6:4ce2:fa4f with SMTP id
 006d021491bc7-5fca186c700mr930336eaf.4.1739314279544; 
 Tue, 11 Feb 2025 14:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi8QtzMQUmUreGQIUGxqIu0XEAI6SUojRpLlYv4wbLPbRgKM2Ie6dc8c8OIUfn2sWWNeLxuQ==
X-Received: by 2002:a05:6820:2904:b0:5f6:4ce2:fa4f with SMTP id
 006d021491bc7-5fca186c700mr930325eaf.4.1739314279170; 
 Tue, 11 Feb 2025 14:51:19 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL 09/14] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
Date: Tue, 11 Feb 2025 17:50:53 -0500
Message-ID: <20250211225059.182533-10-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: David Hildenbrand <david@redhat.com>

As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
ram_device regions"), we disallow direct access to RAM DEVICE regions.

This change implies that address_space_write_rom() and
cpu_memory_rw_debug() won't be able to write to RAM DEVICE regions. It
will also affect cpu_flush_icache_range(), but it's only used by
hw/core/loader.c after writing to ROM, so it is expected to not apply
here with RAM DEVICE.

This fixes direct access to these regions where we don't want direct
access. We'll extend cpu_memory_rw_debug() next to also be able to write to
these (and IO) regions.

This is a preparation for further changes.

Cc: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-5-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 235015f3ea..cff15ca1df 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3137,8 +3137,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
         l = len;
         mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
 
-        if (!(memory_region_is_ram(mr) ||
-              memory_region_is_romd(mr))) {
+        if (!memory_region_supports_direct_access(mr)) {
             l = memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-- 
2.47.0


