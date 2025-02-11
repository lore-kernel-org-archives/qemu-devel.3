Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1724FC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6E-0005fg-A2; Tue, 11 Feb 2025 17:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6A-0005eX-JF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz68-00054b-A9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJeNFp1k0A/JbpmAa90NjLlwhynPzaZBj2J+1fW9xPg=;
 b=SYsS5IvgQ+4CuUFIhv3thJkMK4kxx75XsIZElXo8ztyFUXuRDe7pEd/MG1cT7pcFixp1IN
 TGC4sIQoAyaAwY2BZe8ZdEh/1P8C1nE6hF9yV9kxtCv9j1LyC7sz7pE2WywHykMuDjXadq
 do9+x8hrf8AxWAQHX0sH9Vmxe489ZV0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-1wRnVfYHM0CY0ht3xs6hjQ-1; Tue, 11 Feb 2025 17:51:17 -0500
X-MC-Unique: 1wRnVfYHM0CY0ht3xs6hjQ-1
X-Mimecast-MFC-AGG-ID: 1wRnVfYHM0CY0ht3xs6hjQ
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-726e878ddefso1217689a34.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314276; x=1739919076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJeNFp1k0A/JbpmAa90NjLlwhynPzaZBj2J+1fW9xPg=;
 b=iw2zGZjy5gIhSPQ5TJd8BMoN5omjSPthJzfZ2vMAXkMB4wOuJkgYgihsUtpZyvPA0u
 bhHLngqKowYhoHsMyme9+aWz8ZRRlE5+//0b4oPc3O0J5e9nDbV5/tR8miKSwbIg/Mk+
 ner2J2MRivfShHOi8xhB6WDUNShef9bx/0TXbW8nqWoXbQM8x1yHTBFOQL0QWfEGRYbi
 BLuFVd7MBs6DZ3eNSyF1URD8yPzItBuQB1APOW2X8gn9wn1fc7CbhE25xvxohLVI+e8w
 6v/BKVTpj1yD6Gq/1FwEQnIaUc4Cpal6rIpoBv3a4dSclZvNa15I02xLEJejje+sFSAN
 EODA==
X-Gm-Message-State: AOJu0Yz1cIg0XyQs2s6XwbapK4edkpfmETNhadDx58OHFCaEoa36EOHm
 V4sl9lVpM45p/zuZFXPyyHpNroVtbw+1LfL4keNCbBbBP1l8XOScYnvwnUDNHhctjW76PXL9LL6
 HUPpqnC+kOK8GIHTbGSE1x1mK7w3bdx1Cauhz8JRZNmxTSwAlcWC2pUBGCHsBo/L0Hb1YmKvS4d
 vEvwnHDfPvHm7cgKjah8HCQE5FCmRvebAQ0g==
X-Gm-Gg: ASbGnctJ6ZCpnc0Thn9vFi1JXeL6ZX/jIS4r3bp5fVdhliHzD7QPoAekBJmOoqPyhsy
 Kgcz8lwWkdTFqzutZOUxWmTBc5z2MhbMz8L1NCQIUasGuNvZ7GCZ1IekZwqERSEfmm+TibYGQvH
 owvpu3JhtUtzw4ELk3igeVn7i73eiFA1MfWeHV6gMSsY7VYzf9oh154uWR5tKLIPCAu7jyDlqNt
 Hdoxwh7/5/MsUrigQ9N7RTtD5rsIOVuh1++nybO7pSEuLyQ3OESGo9q
X-Received: by 2002:a05:6830:3786:b0:726:ec20:7387 with SMTP id
 46e09a7af769-726f1d327b5mr808704a34.27.1739314275801; 
 Tue, 11 Feb 2025 14:51:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpQgzeu/m/SbCybHDgXYSf9pcSXJ8HGGYi0pyCJm1KUrvJrgdZ7EmcdX3fKcLLI8KvnD9VQg==
X-Received: by 2002:a05:6830:3786:b0:726:ec20:7387 with SMTP id
 46e09a7af769-726f1d327b5mr808688a34.27.1739314275431; 
 Tue, 11 Feb 2025 14:51:15 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 07/14] physmem: factor out RAM/ROMD check in
 memory_access_is_direct()
Date: Tue, 11 Feb 2025 17:50:51 -0500
Message-ID: <20250211225059.182533-8-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: David Hildenbrand <david@redhat.com>

Let's factor more of the generic "is this directly accessible" check,
independent of the "write" condition out.

Note that the "!mr->rom_device" check in the write case essentially
disallows the memory_region_is_romd() condition again. Further note that
RAM DEVICE regions are also RAM regions, so we can check for RAM+ROMD
first.

This is a preparation for further changes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-3-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5cd7574c60..cb35c38402 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2997,6 +2997,10 @@ bool prepare_mmio_access(MemoryRegion *mr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
+    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
+    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+        return false;
+    }
     /*
      * RAM DEVICE regions can be accessed directly using memcpy, but it might
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
@@ -3006,11 +3010,9 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
         return false;
     }
     if (is_write) {
-        return memory_region_is_ram(mr) && !mr->readonly &&
-               !mr->rom_device;
-    } else {
-        return memory_region_is_ram(mr) || memory_region_is_romd(mr);
+        return !mr->readonly && !mr->rom_device;
     }
+    return true;
 }
 
 /**
-- 
2.47.0


