Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8D3CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s6H-0000av-VV; Wed, 01 Oct 2025 04:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6E-0000Zh-67
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s5s-0005Lh-PL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so47399705e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306900; x=1759911700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C5CzLMaPwDa1iB060vEOK+Ww+NfWXh/VYhisUdBYCs=;
 b=xS4+INqkvrOyo0VDk7EdrzA97R4H3E06nazlYJqUUGT+SdLdO9IawwxTPISovEhjIj
 cwf7W25cbcpHOkttjEmjU3BCmZ3Dcl0QskG96Mps+YD6zbyv0s3fBHw7lWCm2ztCLEML
 ltDwSlX9tLvy0kF7Y5/IhQmoFPVlmxRJMuWyPkhF/7IO37osNWdU0NQb3HhxYcHQu3GT
 ZW9xVK/EFXW+96lt6OJWHCERnBJFN4fKoxNBYRCQv2wYu42oIJxBRqYMf8JiRbvSdP7W
 4lTaCgETezKtvywCUgI3b7/hnbniaU6mLa/EGUmSoQZDrjOsvNsZPI9TL6aHJFyNQHLZ
 KAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306900; x=1759911700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+C5CzLMaPwDa1iB060vEOK+Ww+NfWXh/VYhisUdBYCs=;
 b=Jb0UrmTmxwcSL5ZHcZgpuixm2Pg0pElA/NUNf2a6Xkg+NkOj9f+HK1srq7bo3zGpPA
 nF/9oUl0qZYpMQC4GAAM/0y4R4JgJb2y77koPVD486FWg7n8WD83yQV4+6Q6MUq+JVCx
 MExYPet9jShAqG48itl4n6N52gJlfx62kRnIv+Ypeh2zJ1n9kw7VJn1hT7xsujgUyBpQ
 eP4w5dXlUe9a3CCKHh4mS9HGAkp0BUBdRE+oCxY6h97sb/1W5T7uXUDFa5wIa/bfQa2B
 I8+fH4vuCleE/x9xbbn4trwTS0qbGcB/+9hDQAj+7F0APZTZ+Ho0BKm5TdzYk3scL4cU
 6Rnw==
X-Gm-Message-State: AOJu0YzE029/AhTMrUuCakgkOHXxtxjY42bT3ommnz72Rkg3BEmUKkof
 CYZduFdy90yvrISjzo6a5LDWwMBZs9GQfAPohtaos9m0B4vCUgav6tsTVkRVgTmrX+jFFaujw2T
 3RKeNHghJ6w==
X-Gm-Gg: ASbGnctzRVqlDfy9UkmUbdNjPZaesFfX/e0jlWHdHVFdvrAplRoPR1JU6W0KOBrUlwA
 In5GGsU7AiS/eTXigsYUoQgx2mIgCjfyeD61SrtG7M1+vV9ldgDAv51tKoN0oTfCyjctP5Zh/qx
 7crNGEx5JoIZX/ng4DWhbotMuj51rr6peVzXcFdnbhZEBLZ/XvgpAf66qQ57BAnHVqU5lLe9RVC
 +GNSxqnlgc1czo/powxXg9wWZSqp7V01KxcMFjfbQT6y2P0fRgzk+Y7J+ETv2Af7wgrKn4bBp8f
 JCkyZu6p2rTmM8EY23FYyg4vNEKdkN0ucSnV54nQdgbuKPPWufSJbp/NgF4ZDUzvFv5OcLyydOn
 B3yU2migYbxxdA9TkHgWYfFx1Nos1Sr6JXkT4ADc8rgFVTcmQnyfSM5j+PUvIPPiOWG9VO3fhz1
 CF8LrOEw1TrNYif9Q/e7dW
X-Google-Smtp-Source: AGHT+IG+BsZmZhn5AVBasoM2tJ9zzxKe+EhfCA1OHPGY/VYR6bdoCD06Y50Qg9jsUtcYDIRS/+ZYRA==
X-Received: by 2002:a5d:64e6:0:b0:3f7:ce62:ce17 with SMTP id
 ffacd0b85a97d-4255780b1admr2121501f8f.38.1759306900546; 
 Wed, 01 Oct 2025 01:21:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921b7dsm25730046f8f.42.2025.10.01.01.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:21:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 02/25] accel/kvm: Include missing 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 10:21:02 +0200
Message-ID: <20251001082127.65741-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  accel/kvm/kvm-all.c: In function ‘kvm_init’:
  accel/kvm/kvm-all.c:2636:12: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
   2636 |     assert(TARGET_PAGE_SIZE <= qemu_real_host_page_size());
        |            ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e3c84723406..08b2b5a371c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,6 +36,7 @@
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
 #include "exec/tswap.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "system/ram_addr.h"
 #include "qemu/event_notifier.h"
-- 
2.51.0


