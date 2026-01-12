Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF09ECF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQn3-0006CK-N2; Mon, 12 Jan 2026 17:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmc-0004Wb-98
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQma-0003Te-QG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3618254f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258387; x=1768863187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+tLtXl8DAc7HFoZXanDRWDIN/ErIvO9Cei0mGmUOqEU=;
 b=r7G+tDJdP+yWLQZg9RcS9Rmx8riV23oZ6jxCSzv00G5QlvuTiGDi/juxtoEULWR9nX
 BwA4D9ZGmcydrhfiO6s6e2SPTBm89MTFsvJkaiDNIAaQqy27OMsunb1KlefTQjpCtUUs
 AUyVzl5htjK08z3UpTJ++4hOYUMa0wqmVRKK6WJdWX07cQoJ3Gnsiv4PhnvLx0UBFF9M
 tHiZdEzTRNTWBTtvwDo7UlFVc1MOnw8A62nhNkzvFdQ9KvOCBr0T2Og7MWZINlQ9TfFR
 wXN0y3g+UaAbpxubsaZcTalnlbZyyeyh3uErZA4QRnkKeg46p4biLJB30ksjlXuyRoAL
 FVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258387; x=1768863187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+tLtXl8DAc7HFoZXanDRWDIN/ErIvO9Cei0mGmUOqEU=;
 b=tJ6/unEqfTuufuRatpFc1BxvNQkxm8nNqA0kv2NjSpqhDx58ntHGUUsGHq2sY5DYrO
 5BNPDgevOL6AFH9aaCqP/P20CWKdwHgJoxdgCol9XOOVGRBdhXVbMMsX3IiKpWFd47Tm
 7ZdicXPOm4UlMDNTphmwAf99My6jUQpv2iaBW2zHMbsoQa7O069sktazLiA/CvkPtZRT
 442ugxi4M1hvvOzwWkslJtJkNv9BrEy+KBbk2fNdGYVsQ6znrQ9g8c3isCFiLn97vxB6
 D2IFVmoO/EWD+gOo49tLiy7Gpls01dPGQ6Qw9vBt85rTLBIeesFPm/Gazemnp9KncfyU
 d9Yg==
X-Gm-Message-State: AOJu0YzyjGEvXh0cZ2AQqc0NjA9c9x1ZOVaVBMjwXvZ8ek+Xwq+rQUKz
 jAQS1QSSCXXKmj5Z9KdrB+gfA9D+aciqnSKdr1pKWZuklavc0k2mwy9hot3tSDPJNp4YuDyP/eX
 ug2W2BDg=
X-Gm-Gg: AY/fxX6OYfYz9mn2iELiu68VArJuko7voODiFuqTmkfRl47b9f8zbTDJGmvq7XO1kwi
 QaoSxK9RRE4a+6lO0JztCzlDuZFtITPyfczNTk8xPCmxKj3QqO/jY/WVWN4b1z97IHkgCm9lkD5
 TLtOkNCf8V0yIwmjm2p7wSK6qdd+e28CCcW1eey4bdMiM1aqUw/6sntjOzhb4mJFsBHBGYwWWZz
 sdEcFK3hlDKP1ZkfG4muGBGoR7A3Ven3CJn5vfyf+4qQnh2ZLSr3a5GtJfNnE6CUKwvKlV3Idd6
 Rr/HRmexFq+DlgVZNcUzjADxg7t11gWsLYQeHGYpxyMn9oD6nic7hgREx9me9jUY+VFy8m9dmA2
 MmTAlCf7YOZP++NkXI/WpP4YMaiFGqpEq5/kJkFBqh5BPlmYlCRPy5LJsPkhbFVAcfl7kDqqzoJ
 HwLai2wPJlDO17BbkyfB3RDnafI2qXvH4m9yFMgbf+tUHc1OJ+bWOA971UPfOj
X-Google-Smtp-Source: AGHT+IEGipJdxAGphKEgMPWfQ5Nw2mjE+HMGidviTn8hkOuzxVoEmzWeAfx2FuePXoQsTqQ3/VK54A==
X-Received: by 2002:a05:6000:1a89:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-432c3761740mr25016296f8f.52.1768258386917; 
 Mon, 12 Jan 2026 14:53:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432d9610671sm23227079f8f.34.2026.01.12.14.53.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/61] hw/microblaze: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Mon, 12 Jan 2026 23:48:31 +0100
Message-ID: <20260112224857.42068-37-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-6-philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2a853a7fa5f..0c9a6bf2529 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -177,7 +178,8 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_lookup,
                                           machine_get_endianness,
                                           machine_set_endianness);
-    object_property_set_default_str(prop, TARGET_BIG_ENDIAN ? "big" : "little");
+    object_property_set_default_str(prop, target_big_endian() ? "big"
+                                                              : "little");
     object_class_property_set_description(oc, "endianness",
             "Defines whether the machine runs in big or little endian mode");
 }
-- 
2.52.0


