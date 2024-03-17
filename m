Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB2AC54E6A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaH-0002DT-Pe; Sun, 17 Mar 2024 16:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaE-0002D1-SV
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaD-0002al-A0
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTTgdRZi6XHKzRmdvfpmMl6ZUE3B1EhX+H7ELDCr2iQ=;
 b=UhUIHq14eXUwMERE9P6DTmksPR6eHAGLfYqkUHqbLhIOwNsFrZHSfbDyqd8SQD/KlQ1v8S
 P933xkFuq5QD0JdeNj4eMhg4S176TNmBLGF8MwVUBmSo3YFbHZ76bf3JCl1MF1bLleZQvP
 ZYYaPPo7axfws0xY7tDUZgKJ8/13HeM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-DpU6isATPYaDmUCPN3GRyw-1; Sun, 17 Mar 2024 16:58:15 -0400
X-MC-Unique: DpU6isATPYaDmUCPN3GRyw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6912513fc7bso23803186d6.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709094; x=1711313894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTTgdRZi6XHKzRmdvfpmMl6ZUE3B1EhX+H7ELDCr2iQ=;
 b=IiHsuLRU4JlgukAdDsdOxMnEeRoaUFXurEyn0Tt91bTKNXIbGxkcuCeDKZhe/0bRQq
 0tvfJvr7MyPHbldYwUR+rhtcDelj15W0bidIDZWvofruMhl4NTPyQfC3Sj30BW6MhMHH
 W8zVQ8pUWR+b0UfLfzxEKGBzwwiUJ5TJngfsUpUqVV1JLMrTOWGy4QDR3pbzVtLg0n7O
 18nkGItHN5Z4DideIVlEX7xABdfNlUukESdo2zQjHAnStqTfcaiUDwCyq8/hmhozX5/h
 givkOP2DydBwYoNNDSwbe9OGBni5EORzRufy+rCt5dWZQdDm7Su06LqMJe/cslrYIJXY
 qVuA==
X-Gm-Message-State: AOJu0YyLl6kYkPd87cEWCl1eMm//36vobszkYx2c8/r24jw8pjbW+0Qq
 q5zNpi58q67uXIFn9ND596cWdVA/WyiSrYaKCb1Ei8NRH4f9P16HEeA2kPT+dv8xKjxZkNhg/2x
 s9x3QQA9RRAl31Ybriu5ziT6lkXs9tXGj7qEYOusULF1A8V3AZkI/qXzPKy+4IKJzkKor+XR+Oa
 FRBpUVZmcwLEgiXLuN63JyesiAJ1L0pM8zkQ==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr12242768qvb.0.1710709094288; 
 Sun, 17 Mar 2024 13:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpH1c847CHfQKkcvLzdMrSe8fW1F+InzOB5L0yy/4SBbEfuurgSvcPP7IXTWnjIUmsEyZ92Q==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr12242747qvb.0.1710709093743; 
 Sun, 17 Mar 2024 13:58:13 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:13 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/10] physmem: Fix migration dirty bitmap coherency with TCG
 memory access
Date: Sun, 17 Mar 2024 16:57:58 -0400
Message-ID: <20240317205803.361163-6-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Nicholas Piggin <npiggin@gmail.com>

The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
aligned ranges forgot to bring the TCG TLB up to date after clearing
some of the dirty memory bitmap bits. This can result in stores though
the TCG TLB not setting the dirty memory bitmap and ultimately causes
memory corruption / lost updates during migration from a TCG host.

Fix this by calling cpu_physical_memory_dirty_bits_cleared() when
dirty bits have been cleared.

Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240219061731.232570-1-npiggin@gmail.com>
[PMD: Split patch in 2: part 2/2, slightly adapt description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240312201458.79532-4-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ram_addr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b060ea9176..de45ba7bc9 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -513,6 +513,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                 idx++;
             }
         }
+        if (num_dirty) {
+            cpu_physical_memory_dirty_bits_cleared(start, length);
+        }
 
         if (rb->clear_bmap) {
             /*
-- 
2.44.0


