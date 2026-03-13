Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA0D106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuP-0002cb-4T; Fri, 13 Mar 2026 02:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuN-0002TU-40
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuL-0006z1-H7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-485345e1013so21299635e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382919; x=1773987719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ezuwi07fI8HqHQESlVfz3nJooOZfHLxiMHTs2rhW0mo=;
 b=s3ie7l9YPtX5K3OBjzJaZ22kJsFV56nOtQJtfJb5oMFMox3f0QSdwn1IIug5q7E07q
 fYTXPhBtqoDAX6DRhMq6SxVLTaPItKqJYBwKt5qQFNNhin+lbWXyeSQ/D1oQq1pn9irt
 n+78rDph3PNxjWsxECBtmRIRfDW/DCdiRhkXtUmkBP+oq50cBRxyG/pkDFaz0o/Ao7wd
 NJri2Dun0lfDn+aN3o2RlJmCMnoz4Sm/KI6pvZT7c2r60a2XKgpXdO8/IA5miYkWG/Wt
 IKNmBOFwv7ERNf0ZY0TYq3SZLW7Zuaqv41njijA3wWG1LWtHjwnsTKxq6N7Lmas42d01
 ZCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382919; x=1773987719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ezuwi07fI8HqHQESlVfz3nJooOZfHLxiMHTs2rhW0mo=;
 b=O1VKtk0twRMMVI1KdYIXS2vlNHmA1J1P7KuH3AlnTdNfXC3owosvgrXKo8O/l67Uql
 9CaTRlGncOXO5LutpDDoL3BJJ/r5r9bzvDlcz0rzw0b8vn9NAFQLh2l3u5GLNtq5YOfB
 fd6tKhFIW3EVv7Bd61dJCySzkghbBLbGmRd/xOIiD3SY0QiDq8ciM/pPCWrubOcRZfOo
 +MCcL9lOwMS7g2N1b1OfOPzMCVPWgWoLMcyl4L+FuxdQKCUt4xmqh8vCitdtFR8+dPY6
 R8EPeXFghcVXmDuUMs8Vp5JDBJHIIlPhUdMDvYI6oC3zOOh78k4LVjLXip7xTaMbEAV3
 7PVw==
X-Gm-Message-State: AOJu0YxBZIv+I2BnY7L0C3i1UrBJ8pLzafsmeQ0BxQnYjsofE/dFl2mM
 UGd648ErwwRYCmGgIJCCNBeFUZg6QuWzWpqHzTZjRun8t33/RC0+5Qrv4Ok6DxvWay9XC5gIdMX
 Mvk2RXl4=
X-Gm-Gg: ATEYQzye7ULYFGguUtMiRgtxOD9bXGvsuqdGIFo+frjeeoYnetsl0axsBct2AIc/brD
 CKJavrkALeUTMH0OHOdIpfRQ1tw/xjfJ+4mOL4O9X0c6pC/IGbRjnoQuPXBbKltHsIvXGFgW3JH
 EfUAqYvgnEXIOwcFkzes4U9rdduMmO5oR/TyPHyzwATYz/ynygTKAm/3mNBKF+pJQLC4ej89TfH
 A0sjaYlj98PkzNTEkfIcxQTOD30h1nURab3fFjcf0ypFNJOCKuIOAUxHmUeq1JvcJGy3Z1Mx1E6
 kyskdpkYH59b6HH3rZrs39wpnFvA2Wy7U1M4rbpK51QrhoUpWUBwUm2h7zuoN8ZXI1F37IHHO5d
 g9hW65ySlJ/tPp8MJxry25aCwuVkXCRSedJ0KcN5BnrAfhzUIiJsVV65olH5vF7bKQygqUTCpE/
 dE0bYMueo9MCJDz2u2LSseWYzVR7bZ9w+id5MGnjnehQrQ3L9af72BZga2ndVx4kQYpn6JP1ElR
 rndmA==
X-Received: by 2002:a05:600c:a016:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-48555b2c949mr33629505e9.12.1773382919181; 
 Thu, 12 Mar 2026 23:21:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm268269005e9.1.2026.03.12.23.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 09/38] target/i386: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:25 +0100
Message-ID: <20260313062055.2188-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

  ../target/i386/cpu.h:2777:43: error: unknown type name 'target_ulong'
   2777 | void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3);
        |                                           ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c40..6fad9571e25 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "exec/memop.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
-- 
2.53.0


