Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECAC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMx5-0007n3-S6; Fri, 24 Jan 2025 11:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMx0-0007dU-C7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMwy-0002c1-Ey
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737737669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ePR9BfsmNf8AyNCl2IDFJ8EDqHaAP0dpO83jGHFUug=;
 b=Iw06NtcaAJU5yyQvuTe4c6y7p9FrUv8GP77uijNgLYtkIdXTEOlY8lyev1f4xB9ozUIu/N
 qA1JZHPP7E65AGYivRsvxBi+wm+3k4STewQEItVwwMCoi6C5XbS6PfH1s8RquQzUlG0iCv
 BlEVUJrLbRwLGvYrFdSz4QExqA5t51U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-7KvTn-m5OSqCBhTkXAIXaA-1; Fri, 24 Jan 2025 11:54:28 -0500
X-MC-Unique: 7KvTn-m5OSqCBhTkXAIXaA-1
X-Mimecast-MFC-AGG-ID: 7KvTn-m5OSqCBhTkXAIXaA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso18498795e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737667; x=1738342467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ePR9BfsmNf8AyNCl2IDFJ8EDqHaAP0dpO83jGHFUug=;
 b=gj376MFYtV7KZdeaN+5Tk7ArwTJSnwmXjUdYiNoE211tGOChEWQOpCbNTAfejBkpoi
 m00AtIJwfcqiDb6GaQptywCUYJk/B7/lbo3NtFGD9bOfYTIaxB5Nyn0frYcsXGtGlrC+
 R7Fcf40Deyd7rfxJTnlIi0IqktSpcNjt5nj1/8+Pb9Hxi+FxNY3kfY9IdvqA9GT9/p91
 nimNjQ/L7gGAXfcxOHBlYddBDWawXsuqbCIkiiYGO+txQ9rtJXdnrgFVwjnUXFarbas1
 5G85OxbUJMVnXohQYZAq8eU/iOYAXAv4oURL9JOG77RZ0FNdF+t3DYeIE89/YKARUB2+
 Qw0g==
X-Gm-Message-State: AOJu0YwEkGaYCiebJ55bXF4qN/JECN1VQRY2wslko9g0M//yuLX82ZPV
 Tkpzh1Q1pQMY3gSTfzgSsS0e31LIN2tSZRDa4sJZTEU07/1CSe6MkRH28N7WDF7tKjFRw6MO2Lz
 sqbwnX/lHypMQaeOPVKch7CYj6pIG5v9z8K9tK7U+W7P0UYcCoccWPT3WTJFXq2nROXyOMIwIW+
 sj3AqPEAAy3IxXeIFCMKQf39kpjMgF+HPh3436kg==
X-Gm-Gg: ASbGncsLddl30vupxagIuJU5KElk6/aHPE46d5X2DXOjnexGvvWXg6ugRGhFZO1H8lI
 Zs5HAxVBgG1ewDf9w+iMN6guJl+4CuGAEbsW4q8oDVp5desGW5mFhcNvtVkGWyvg8MTDbNcoGeX
 xaX4xw4fBpx6lW8FO0G4LwD/4IWHjlogirvl6FOjpeabVlIyaLp7ez9AVDhIo/+Qp5VJDcsXNME
 CdW1CdW1q9ReMkd66dUOdN2hHdqXyHskeY8N3W2pjMz4YdLGhuoio8XE4EFHsGMkV0+R1dFPTig
 HWGW36q7llkdhQuG4fgy2xrGGRNV1Uoz6Pjl2YINSQHSkuZA75Lup2k=
X-Received: by 2002:a05:600c:3b27:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-43891438051mr272045895e9.22.1737733541267; 
 Fri, 24 Jan 2025 07:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX+bF1jsoWfK3OOfQ+wEsvfKmRDf/T/plhchDfJQvWcdh9dkSk9uw/jkaH7TgCWS+5ru9R8Q==
X-Received: by 2002:a05:600c:3b27:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-43891438051mr272045555e9.22.1737733540821; 
 Fri, 24 Jan 2025 07:45:40 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1764e9sm3070240f8f.17.2025.01.24.07.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:39 -0800 (PST)
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
Subject: [PATCH v2 2/7] physmem: factor out RAM/ROMD check in
 memory_access_is_direct()
Date: Fri, 24 Jan 2025 16:45:27 +0100
Message-ID: <20250124154533.3534250-3-david@redhat.com>
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

Let's factor more of the generic "is this directly accessible" check,
independent of the "write" condition out.

Note that the "!mr->rom_device" check in the write case essentially
disallows the memory_region_is_romd() condition again. Further note that
RAM DEVICE regions are also RAM regions, so we can check for RAM+ROMD
first.

This is a preparation for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7931aba2ea..086dec5086 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2987,6 +2987,10 @@ bool prepare_mmio_access(MemoryRegion *mr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
+    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
+    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+        return false;
+    }
     /*
      * RAM DEVICE regions can be accessed directly using memcpy, but it might
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
@@ -2996,11 +3000,9 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
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
2.47.1


