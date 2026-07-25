Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FBEC531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmw-00025n-4f; Fri, 24 Jul 2026 21:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTT-000739-28
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:43 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTR-0000sl-Gv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:42 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-96935063700so579936241.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940160; x=1785544960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6XwavS7Vmn+SIE6qd8LrtngwH7IkOtkdttru+6DtMCY=;
 b=emu75k5qH+OYjb/bzt3wjDqWuzzKz29Qg/te0L80nofuXPirvJWk5qSLOrovib0M6Z
 E4DMJStMVOvGoeVNqNlghmjwhO5N8O1UauNkCQUyM9qFe07HURPXftRPJbiAMrd9rRGL
 /VsjGVpCv85IuB9JB0uwNAG8PhCbad/gcCki34ozAZ+exyyWviQPrVuN/gLBP4RUm8iX
 +gYKRy7mTDYHPcmzm5CLAUQ+pRIaA02N1yp1CQh/cPGvE/0FNihGcGpMTMfDHEg573PO
 ytAATyOgX7RpOCOiUamhpzBL7g+cr4+u/akgoL3kWu9pM5CCSlAiQNFipOwOyiRI7J6e
 BEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940160; x=1785544960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6XwavS7Vmn+SIE6qd8LrtngwH7IkOtkdttru+6DtMCY=;
 b=QO8yO57YMIWWsEAFVFtRx5y7TdEop9qefsAI+sOv9MNxygwehAWjvQkyMAakWNmGt7
 gnmr774TfSCE1YfV78WlccvsqWPd4vPjgR1I2eDYzFxV6mmz2LgVFrqy0zA7uvSZVuX8
 fAdnLBC/ngRT8OUmd/A9+4TyvVQzJlTkSJriThCf5YPO9mDrUr6ba2IIhyuBIadwIMEA
 zwepPbBq9Jto8Y1iryxfI0mqC8KP88HWZkXlXjwdc/hOylXZW8Ln/ziGg03uzlI0rjIz
 jXvPBGSaCUrsHJUTrudpqpj95Bva+Zj7kNsc0KXuqE92nZw69rUvvRSJRFFIBF+V/VI+
 do+w==
X-Gm-Message-State: AOJu0YxIbj9gCLyCbRaiZiuMKONoZqohH2GXB/lkHUJ7yby4MBksQP8o
 BwEyhxbT4ktYIjTSxTo+5+PveqKcXzL4Q8KHxGsHMH+QaA7RRi/kbFW1Vx80YFcf
X-Gm-Gg: AR+sD13pKBPP3zcXBuXXq8oKgx6VxQmrWLd+n6QxIF80+7Wptw8Xm2qXfSV4FSRu7Xl
 sJIO1jv20fMJFq3dYVwk8Lg0HFNcYTr1ApzId7qgnl5iDUpygSriOvFw/V1OTysAdNuc++nutWZ
 4JYZPlXhLTO3/pEg1iiatKeEEK0lVpEt4lqH+rxL6BJiD1ewR5hqhzLim2B7VCsnZ+qQOba9tVh
 hshnXsKlTHIqZQ0+WbtIvsGgaJ3xlCYL0XOs4NONx3Qx4grjXpGoIZSp58vCI2HQzmSk4bLm4ZH
 Mr2+59osUE8TwwzziUue0xhPKtii2tdST0V7ooQJjF9JLAQOTJE2eankR8FIqFhBevK0xoqAdc8
 BFVGsm8Sh1erU8PAtIIw1ojmvDAMFmKOzWzP0W+HTTBJa164scE1YREwBs0B0UfbWj+D0xq63hH
 2AIunLbsvqKdo2cnAlgOm6X7eUPqE4zB/y
X-Received: by 2002:a05:6102:54aa:b0:739:5cfb:50f4 with SMTP id
 ada2fe7eead31-7503e671e86mr806409137.11.1784940160632; 
 Fri, 24 Jul 2026 17:42:40 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:40 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 18/19] docs/system/arm/raspi: move PCIe/GENET from missing to
 implemented
Date: Fri, 24 Jul 2026 20:42:17 -0400
Message-ID: <20260725004219.66222-19-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 docs/system/arm/raspi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1..a4f83d0a 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,10 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
-- 
2.47.1


