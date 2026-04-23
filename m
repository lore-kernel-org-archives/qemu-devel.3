Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA9F589D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSb-0000gw-DD; Thu, 23 Apr 2026 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSN-0000dw-Cu
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSJ-0005WO-Ev
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso40981405e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952249; x=1777557049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqJL0rl96nxU0ves898eJ2z4C/7AT9ewOI72ZiQAO7M=;
 b=NC0f7ClTl1M8sl5rQPAkA7AQ/oAvA2PiaWyFQVlm0Sod7mqP1V0Lac7XVrRjmvGt0Y
 xZWjgLDQmpTTBXzJbkcAzShhyzyf2GXUo+dn+0k6JSHEmtGu1uAR7YvIoTaJN50y9a00
 gFQz1hKPHmYv1M7VE+IEZYThD0OzyvIDnOBSYhk3iLoRYRn7lG1D4KDefspVKEjJ17is
 3qWBlSgidj8r7SUCbOFZH/mjIv/6eYlIxkYjRxFCFc5UVwfm3TytPMG0SYLjrLs38wY6
 3snEj7wVIKY9MVGNYVt6/enP0Q36mg3rI9PqRM0Ikyp8QrYebgpGzGaFuUfeZijQ60k7
 tQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952249; x=1777557049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqJL0rl96nxU0ves898eJ2z4C/7AT9ewOI72ZiQAO7M=;
 b=d84LCRPXuuln9KWPG6C45+ETGrVhHV4OMO+8B1CO8L1QCHGmw1rGPya8Hk1OZ5AzSd
 nsYQs3aWx0/1svvn15T2GUu+2w+k2iIXXfse6sH5SIAwD4QI00CMj1Nl56zaS0jP/INe
 +NOh5M3ONBzoS47tX86eRkly+OEapCW6ko/mjPZyfrg+XmuwNZ0bhF1/1aC/KTibJE4o
 cIDY/5ooFMxM9sR4xnFtbQx6JUMMbZJlfCUuxZi6bwtd0XhFTVgqdqCjL0zTHYNEog3e
 2qrKpmqYKHWBJ3qlOG6LbI3hX3gVbDNxN8QFeaN11LEuMLzjanC44AZ5NonTZPqeHusG
 BReQ==
X-Gm-Message-State: AOJu0YwUeBmVbf8Iud4r11QZm8akLMMdfVY6RPcPQToB1eK/0L4YoZS/
 VbOGsmijdmHr7fMxiZD7oV5dtfYPGDDHsR0yz+uzRuWnd7AUEm7VdIT/bukeSMpvSZaWSz62OYM
 Y5FMjDqc=
X-Gm-Gg: AeBDiev/obSDuUdxZfmOyD1HUffEa4FVjR9OnSsNfOeOEYqwlAH7ElBov0m8C1xgr3H
 6KrnUJv3P42WKs0clM7W4+BqQNgiftruvWBLzdHMJcOP2Vhs/8b6qvfvOZPlfxaCeWjmBik4U+U
 9LSs+gjNrbrz/JCz0bWuW7seIQIClgGIGXZKnBMdI2Mws3rHIBO4EpsPBoocyw5HCPAvizohtm2
 0hcblSlb81Sj++Xki75UY8TXVWomqXzpbCAqbX56HIpr+z0aP41aGGO4VEl+/jsNAEIYm3iue81
 h4e8oc2pXJkzciZB2ZZXljxC+Bdj1GxkbM9xCVYNT4UbXG8naGAXa4LZVcvLEFgCt9SHvEYoDwW
 zqlwHG1RoHxo4i/4EV0aNG00cRxtYt0PWaO7EuNJY+dMNGWGxgAU8TAthfAHZ/9ioYhizRCe/TZ
 xqSBiEp+dWoUxPxHl0JyZUvzjLVRl5t4HYIH75o1tvCftLVaN0DvNDZnnHVDqTo2ah2BpPSrnRc
 ELXQd+Kfp8=
X-Received: by 2002:a05:600c:4fc7:b0:488:dbcb:ca08 with SMTP id
 5b1f17b1804b1-488fb787a62mr377145845e9.30.1776952249493; 
 Thu, 23 Apr 2026 06:50:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb794e26sm222847365e9.6.2026.04.23.06.50.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:50:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
Date: Thu, 23 Apr 2026 15:50:27 +0200
Message-ID: <20260423135035.50126-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

"tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
Include the latter to avoid when including the former:

  include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 'tcg_gen_qemu_ld_i32_chk'
   34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
      |     ^

  $ git grep -w tcg_gen_qemu_ld_i32_chk
  include/tcg/tcg-op-common.h:328:void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
  include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
  tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,

Cc: qemu-stable@nongnu.org
Fixes: a8af0fb24da ("include/tcg/tcg-op: extract memory operations to tcg-op-mem.h")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op-mem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 36931d1dd57..ea35a02fb40 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -12,6 +12,8 @@
 #error TCG_ADDRESS_BITS must be defined
 #endif
 
+#include "tcg/tcg-op-common.h"
+
 #if TCG_ADDRESS_BITS == 32
 typedef TCGv_i32 TCGv_va;
 #define TCG_TYPE_VA TCG_TYPE_I32
-- 
2.53.0


