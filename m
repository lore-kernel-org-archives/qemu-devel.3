Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBEEC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLzA-0007KO-0C; Fri, 24 Jan 2025 10:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLz6-0007KB-7y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:52:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbLz3-0006ms-TC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737733956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CP+BeYR5Gl//cccFzIG3OGb6LhFJghy4FZ9u7PGcy6o=;
 b=fGXhv694X9pw1kcBbcz9CQeQa7MFdDylh4WNuOnhuiZx5D5q3nKr0GltTLAZRSsgMRgHyX
 ax45drNmD7NhEvv4nCkfRKig6pjfzpn6v4DpZ107K9GZkUjrpWOdVYQlpuU2iBLi0nLLQj
 42y3q0r0xSCHgCCaVXRjXpIBCQPsBfI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-wYw4iC4eOa66AgypCYPfJQ-1; Fri, 24 Jan 2025 10:52:32 -0500
X-MC-Unique: wYw4iC4eOa66AgypCYPfJQ-1
X-Mimecast-MFC-AGG-ID: wYw4iC4eOa66AgypCYPfJQ
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dc0de54194so2044465a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733911; x=1738338711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CP+BeYR5Gl//cccFzIG3OGb6LhFJghy4FZ9u7PGcy6o=;
 b=lvxsO0Ocy8FyoqXevc0Tmyn2BCdRH9dLbrmrYN9okWb7mPZqar/iJxr0U5vdudgygr
 ByrhmFui6ZR6tiUB/owMDk1oIeQMku3IDWB7Ulp8Hl8Z3K10lUhC/c+/0czTMPtUkEY7
 6fkIQkXIiiZdB43UbjfZKAb8ECnhrlAKUPWr4g5Gt7Vlhaz+bSRURFfmV2U6yJ+2tpkD
 /l9I0OBBqoMU6QngxUK0q7kRlzMQ/Et/g/DsuO5szb5vanOJQzR+166GOLfZBnARabxI
 g1JEDLWmoEW1+HEy8mAQDsOZrl+jnvbIOaUpd0Pfqs62KoBjtg3Eq6c/E/4XVvVBplMm
 Opjg==
X-Gm-Message-State: AOJu0YxRTuMosITan1UMGG9TfZ82ul6x3S+iePovnidqXb7bu5iUayzH
 q3/fFOsLd17FzX2NH3Vs3u+b0D/k9/zT1DBLcY/oYnbriuezduqceGdRICxVG3WeNIE126QbrRk
 5CpjGpdt931Jq8SlF02j02kKqgxw1lSjIPpCGTj9suotcvStdoNmh2c/sHxNfm1WlEHeD6RsEVj
 k90nyNTgPye/grCqnaMOHYH0o7wPg4p/0LC8GAFQ==
X-Gm-Gg: ASbGnctkqMkrZ/Bi7aI3H1BOmA+ByvfFMkG/dqdlEP/YdEC3hGdDvjgFAEPWIcX2t/9
 bydmC5im9CaChTaxA6pfp/gO6/ThRzP5F9tpcBlOOVEpjSHCq4i0ulphLCqvQ0jY18HcU62Rqla
 MPm5qr5uaOalxKQbGquIoIWSmZaN3XjJlU5DuuvLeJFgbeucOOVYFS7fRrckUfDupmb5E7CXHmj
 CyV9WDdvvF48+SJm47cQowlUWN0FEZ3KJwYDxFPQdwDmw9A7ZLXsV9LYXRTC1Ls/h/ozLl+RAa9
 GNmJ2SYmTE0nope2zH9vwFipjR6aHoxQKlTWQFd9DuHpMQJUXDgnXNc=
X-Received: by 2002:a05:6000:d09:b0:38a:88d0:1c9c with SMTP id
 ffacd0b85a97d-38c22275430mr6769690f8f.17.1737733538726; 
 Fri, 24 Jan 2025 07:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRqrgRX5kyR6AO0c7Kkk5lCFZNfbAShaldGSh5LDUN0/EB7e75pK3yNZku5RyXD3Krprce2g==
X-Received: by 2002:a05:6000:d09:b0:38a:88d0:1c9c with SMTP id
 ffacd0b85a97d-38c22275430mr6769658f8f.17.1737733538321; 
 Fri, 24 Jan 2025 07:45:38 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a188689sm3057609f8f.48.2025.01.24.07.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:37 -0800 (PST)
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
Subject: [PATCH v2 1/7] physmem: factor out memory_region_is_ram_device()
 check in memory_access_is_direct()
Date: Fri, 24 Jan 2025 16:45:26 +0100
Message-ID: <20250124154533.3534250-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3ee1901b52..7931aba2ea 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2987,12 +2987,19 @@ bool prepare_mmio_access(MemoryRegion *mr);
 
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
2.47.1


