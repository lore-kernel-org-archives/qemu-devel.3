Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F44CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjO-0000qM-JL; Wed, 06 May 2026 09:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjJ-0000p7-Pv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjH-0007ol-Kg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so72817525e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075757; x=1778680557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=etiaBBe0FYCm1/YT1vM9NGHZt/oKDk7PL8PCJaPEj6A=;
 b=Sl6UWU/h+tPjOAF85gwpf/cSP1tZktj4ULvuJ2MU/pxr88SzG4pUysP7SPC4z3+m/y
 24BbLOlQv/4in7oDZSsPbQYSv0OLjXJpkJoS9f/Q/xu1xPp5Uo2Yvz/oxTI9/I+DJsnt
 qvIEIVyRBhNJbYYjML+BfxdbaRiCfRgnYLbCP3x8UoHwS3n0YcKo39preA0RaM0U1ruK
 Ylpe2b3YEJmNA6UNYpIPaeNOk8ykhUPGqxSw2EdNfTg3EZgxKB2oLQoHxSfWKfsDO0T7
 PMTUJv7z6Xh4hvBQZz+qkl+SjBxSG9r8KJH5p9EBhfUvnojxeen0xCmu9t+pvSwbojTO
 X4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075757; x=1778680557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=etiaBBe0FYCm1/YT1vM9NGHZt/oKDk7PL8PCJaPEj6A=;
 b=dJ7CyeVKgQ1w2MViONuhqHrCrQsRaQJ2uS03+S1Rpx4kyzeswNbZkAvFP9fyIMX7/+
 F7i/Eh8MZndVJkVXYmUvoy/+2YiY7vvlhGzSkEPfNXvInbUWwbR0oR6FTfw2yPtYFRjK
 4fjq+L83J+yTGc1sjsg3mGn9wiJJ2NU7XQg0UEaiqc49ru+3k3quDKNhbAfciEJ4H2DX
 cd/KLS0/cPr4YfWeVBZ7VHSPtBwDxOP4qxsppJWy2PupJS7KpQKhHTYOgdnuopyAsMQb
 jXEqRrqJlAoyOfQqmAVALrlTdLuzRFaxhYgYzGAA1oE/GCmPW+8oB2DGs2Ev2q4/AvC7
 WiFw==
X-Gm-Message-State: AOJu0YwygNCShphT9+C9Nvq869nn6dYG0VcVtgpZvEBFOtopiGeoQZ7t
 M90BQwhY1oLyvoM63RlQN9HvvaJ/XacMIhVASBPVlQ+0lKPlt/EYrkcPOP5GV7AUpnxqXjoB13e
 SI8YzOEU=
X-Gm-Gg: AeBDievwg1cuRQJbBRf5n/39Ed70xE0dQrz1gXt58h0m3dnqJkKTMGc/ubgmX52KjUO
 HbVGj/mcVwiFbaCLlCsx5ZScx92Q1jyyzlGisEpbeXceJ1lL1OcoVuaXacDy6X9Eox/1jt7I8dU
 qHoY8+tWpssjQ2+03BBz8tw+/TabiYsYCw/HmuP0zWhQXninf4aYmRwcytkcYpKh3kp7Svx/Nsj
 nKIbmLuBDGCBxbErRzgF+b3daIQ3Pyc5kXA1OfKCzY3sBvyqQ+uYYEucyY4PmOfUsU1/I+FAfQt
 mRW/bfrUdiom8/w9QMfnDafwjVXp76MwaLUtwMfztY72NjzSkUVBPPYVT532dEjF94ub2kyxlcI
 Y4JVZbsvlsQuEoVq+evygaiSujzoinii+G3wphopEUUC/uQ/HzD75VgNwuYimWOedo4PF9pLp9S
 6pfSZ2vD7Lv1giPj2KewqFS37LBvFhTG2NY4xDTt7MNtAiN+pCwbltXE3ftEB3H6BHmCXjuQh4g
 2SOpUjYB+U=
X-Received: by 2002:a05:600c:6d0:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48e51e09730mr37205515e9.5.1778075756851; 
 Wed, 06 May 2026 06:55:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm46703615e9.11.2026.05.06.06.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:55:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 004/110] target/hexagon: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:36 +0200
Message-ID: <20260506135524.20617-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/hexagon/cpu.h:76:5: error: unknown type name ‘target_ulong’
     76 |     target_ulong gpr[TOTAL_PER_THREAD_REGS];
        |     ^~~~~~~~~~~~
  ../target/hexagon/mmvec/mmvec.h:69:5: error: unknown type name ‘target_ulong’
     69 |     target_ulong va[MAX_VEC_SIZE_BYTES];
        |     ^~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-8-philmd@linaro.org>
---
 target/hexagon/cpu.h         | 2 ++
 target/hexagon/mmvec/mmvec.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index f99647dfb61..faa07a6e05b 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -23,9 +23,11 @@
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
+#include "exec/target_long.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
 #include "hw/core/registerfields.h"
+#include "qemu/bitmap.h"
 
 #ifndef CONFIG_USER_ONLY
 #error "Hexagon does not support system emulation"
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 52d470709c0..4a4f6cc9805 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -18,6 +18,9 @@
 #ifndef HEXAGON_MMVEC_H
 #define HEXAGON_MMVEC_H
 
+#include "exec/target_long.h"
+#include "qemu/bitmap.h"
+
 #define MAX_VEC_SIZE_LOGBYTES 7
 #define MAX_VEC_SIZE_BYTES  (1 << MAX_VEC_SIZE_LOGBYTES)
 
-- 
2.53.0


