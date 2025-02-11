Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0533C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6E-0005fn-C8; Tue, 11 Feb 2025 17:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz68-0005de-Gb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz65-00054H-Jw
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD3Ak85mvd0a6yhFU9zB0ucBwPuFg4Ck7y87CxK+Lj0=;
 b=FVbKoxOtGvbrqBX7Zz2w6vpwhwzppmosrdzjaKgKTQsz5j659mPEgERc+oLpozzGWycH6O
 rQR5W85aWhzBA3fnVYsg/WMZtvPBXHhJLTbzLVxpW+pyLfL/E2o7yEru0mU65y7WJqkedA
 5jUQHNIJJ9I/ZwpisJALDHG62Yv6UrM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-qUBDmdDaMBejNh-Hhn5JBQ-1; Tue, 11 Feb 2025 17:51:15 -0500
X-MC-Unique: qUBDmdDaMBejNh-Hhn5JBQ-1
X-Mimecast-MFC-AGG-ID: qUBDmdDaMBejNh-Hhn5JBQ
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5fc476501cdso4561985eaf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314274; x=1739919074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JD3Ak85mvd0a6yhFU9zB0ucBwPuFg4Ck7y87CxK+Lj0=;
 b=q5atD+SVtQAMY87YqdyZl3PDCMUF4SEivOQXxy078YVdEOxtrMZFjuVuOcMwxBScWt
 YmbGrhYBavYIrhq4KRlT5bl6q50cnYJMTt4p90X4CfM2xPKp+Y5uxNq/0eWEzPfkSJKJ
 IeKmH91aNb/BAnrHdzraTVcnnP8Rf2mrcuA8Ww6uEvoACTaVZya7YJCZ7NrR//3AuZ0c
 IYAwPEkJFOdXEyMlEzZWEv5O8fzjv/7o0r+AktGSGS6aGMfpuVDUFUgTdHnTOJTeB2MR
 thWwQq/iw8jtXTuUnF/PvkGmMD2i6BmWh9cFmORD09seLkmpC/hRe+DqbKMQdJ6Apmzn
 XBzA==
X-Gm-Message-State: AOJu0YxMGODK/Of5+sMqr9E5v0r49Q15qWwrXcHQt+V25FlOPPMObPeJ
 eRcf0kLfWoBj+NH7IYGbhXRoYG+ZtJYZZK5ODjChAwfJNv/dCuTlzab8WIA0mi+6DOegcajz/yc
 mWBhHpbtwyu/WQ8P2YWiRS4tCCXwk07SCSFI/KYARqVZVigQg/MbdQa1/Y22vAC/wJa40ZUm9+W
 R6s9Wc1BDlQZjp0WkJGGY4MyoEQJxKnNGUhw==
X-Gm-Gg: ASbGncvoW2cRbpC8zt93H0g0bLDVkHgHldTSiM7xr8/ofylJ7fKMRvkz3vHWO0m/ZDJ
 P0dLT7MHygLpPly6ZCf+CG/YycHvWWjUO7tDUxYqSjduhQQ2k1py+dzs+9wHwlo0D8cZOSV/mVI
 xGtRbOHBczLoOHagljVC8OxbqYAoAbI3RAk0d1RJqtGGZ5UJGUGpD5m+9EGlqUhdhd/10SvNyam
 HQFCln7CGMQd5Y2XEUjY+KQYOiRpk0RbFlJ4buuOfME9bgMVN1T90qg
X-Received: by 2002:a05:6820:8cc:b0:5fc:9ebf:25bd with SMTP id
 006d021491bc7-5fca18aa32fmr886072eaf.6.1739314274240; 
 Tue, 11 Feb 2025 14:51:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIsQSmH/yPL+mdo9tBvbsCo9e9Z61CRjKpePdLmJi3t/txBdBQJvieabXSs4HYzm2LwBZpTQ==
X-Received: by 2002:a05:6820:8cc:b0:5fc:9ebf:25bd with SMTP id
 006d021491bc7-5fca18aa32fmr886056eaf.6.1739314273793; 
 Tue, 11 Feb 2025 14:51:13 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 06/14] physmem: factor out memory_region_is_ram_device() check
 in memory_access_is_direct()
Date: Tue, 11 Feb 2025 17:50:50 -0500
Message-ID: <20250211225059.182533-7-peterx@redhat.com>
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

Let's make this clearer to prepare for further changes. Note that romd
regions will never be RAM DEVICE at the same time.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-2-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.47.0


