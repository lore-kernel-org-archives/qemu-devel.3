Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMWm-0002NU-9v; Fri, 24 Jan 2025 11:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMWk-0002N8-Fe
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMWe-0005Dy-FI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737736039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcYXbuttJvyTYCdS1jYY2P3DyP6WKZ98vnviI1IyLBw=;
 b=CDFd7npQ0ZTT/ZU3UzxctqOVphsKpWBGJMvErLbQb88HvMdHnN8AX3g6ctLLw3U5N9vzyq
 1ABZ+Hag5e+7+rhI+WLVSU1zAye+zuxsu09ZEIShANlam6mF5zPLOo30k5gkuVuSB+qRPR
 IAJt3NbXwiSXqis708TkriNEQKGW3IE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-3z2bVknfMwmqMfSxRiMCQg-1; Fri, 24 Jan 2025 11:27:16 -0500
X-MC-Unique: 3z2bVknfMwmqMfSxRiMCQg-1
X-Mimecast-MFC-AGG-ID: 3z2bVknfMwmqMfSxRiMCQg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6732a1af5so277529566b.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735721; x=1738340521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcYXbuttJvyTYCdS1jYY2P3DyP6WKZ98vnviI1IyLBw=;
 b=H0ETnuprY9xR+mdxZcnOPL2QuYXopUzhZXmv69Cj0ehmcnylQ8elv4ukPJXRG16Fgm
 3fOpuXsiiVL4QORxzwo4aNKQiMYZYjYGma8rI52CqZTxNnLKpu6FeB38GGUgLYFBoQwK
 QSJOJ88EoCyXedQ/4RBDFwhiJdw9pnBS2khuoucmKvBqV8LYCQ/2vuD4P/jVYfcR+xmo
 wJV+Y0NMa2UdZMWegPgbhv3lZCeeOYPMZYt8mklM2HxSK47HdkV791H8hm+3/ESpXwpH
 DaLUNpncKUrXrJJkzqyuscNqFcNJI8fOD0Q5gdwmly48AcPlzD1AMsfCuFPNPp1+h4pn
 Kbww==
X-Gm-Message-State: AOJu0YylD2AtRXnmIiIC8KqK0yIW2jdFnaYR54In1Dnoc/oL8BvUDjMt
 /3heRtlF+ehk42awN+u2MbIWUkUrXyxjIsPbhvH2511Ba2vizM362acHm/dZPl+G7jeQyOs7Teo
 KDgXloeGM+akNiHWNlczxKO3ostPnOit1KPsSwjePB7Asf04MG6z7QaSFOK2pdcahaM3IyCmh7h
 ZdoNcfS41/qZ/3gBfM7+j5Vhsc4HnN1qHj4iMcnA==
X-Gm-Gg: ASbGnctjJlXT7bXISiZiMuJ29xZXtWZ9HoD2c7RG5sGmc2Qbejw28LxwczuDQZPTKIS
 f04DnrINCuc5wBuW8z1w8hBLfCFCrXW9QPnfSeOTTZCZvMV/q8xIErAPuzuRXqDoMFXauixqweD
 d1mmejZNy2+ByboJ1gczA8c+JbBmGBkCpYWYyVveQGKQqQcYgFutXgr15l9YEoyvAehCylHiav9
 L4ju3VlGGQxre2mrwHocUBrYJ0wKHd+V3d2EcphLIxaFF3ddL/F16LkMVbN+ahNzsu+PRFJGcsk
 oC2S6EfFnzhomquHJ5TpGD4aySmaPDLp5li9Q8H/xcsybdevKWJabQ0=
X-Received: by 2002:a05:600c:4f8e:b0:438:ad4d:cf01 with SMTP id
 5b1f17b1804b1-438ad4dd129mr200052585e9.7.1737733547704; 
 Fri, 24 Jan 2025 07:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiXBr9NRQ9sJjlAXXbFZwrvB2NDC9H1nG8Bq2i09O5ZaQ+aitsafpmoJPw/XUeC/T0UwjIfQ==
X-Received: by 2002:a05:600c:4f8e:b0:438:ad4d:cf01 with SMTP id
 5b1f17b1804b1-438ad4dd129mr200052125e9.7.1737733547315; 
 Fri, 24 Jan 2025 07:45:47 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd4fa46esm30544735e9.1.2025.01.24.07.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:46 -0800 (PST)
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
Subject: [PATCH v2 4/7] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
Date: Fri, 24 Jan 2025 16:45:29 +0100
Message-ID: <20250124154533.3534250-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..2d4f8110e8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3029,8 +3029,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
         l = len;
         mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
 
-        if (!(memory_region_is_ram(mr) ||
-              memory_region_is_romd(mr))) {
+        if (!memory_region_supports_direct_access(mr)) {
             l = memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-- 
2.47.1


