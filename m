Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81732CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyI1-0000Ym-IV; Mon, 20 Oct 2025 18:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyHm-0000Ro-5R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:23:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyHg-0007xx-6i
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:23:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so411659f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998998; x=1761603798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fF9TDon2Tc7lH4qPU1VRFsYPiWX8szfElrXb2hU8A4A=;
 b=vpLSIuLA9e9kwb+lpisYu1BfFOIgi67sAFQAhIzryhqkhVLyRa33ZGpOvCIztBtSVP
 6Xcq5rk4+3tlRur1OpmtUO0uCp9DM/7wqtAuoLvIlmPHoC2xsido/H48lQpuqGQx30cB
 pdYzhgzeXzcSpbW7oC6kqQJ8cFNWOzWKpLVu2fVmY1ThKMr18DGjXLkQ93wUPnWReIre
 yKrIhelIRY+JUaXsNWShANelnaaUa5wyLZj/NkzlGeVqp+zzC0CllFIxdJk6HEhoeHVu
 ry0FRpKUG9nANGR0Z2ztzicU3lv9EiLXNHE6GHqzTOnzeAMNr2ajeU5+jC1tkHdl7XJp
 sOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998998; x=1761603798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fF9TDon2Tc7lH4qPU1VRFsYPiWX8szfElrXb2hU8A4A=;
 b=MBBABbvfvwayZaTQYvrv9Hs6u1a6OtGGdnSWW2iNvbMRwWTSPc8h1nVwlGnFn8Oapi
 MrwW5Tzgv8eEJan5GDrj2Eo4tNDmpTJkwWewEjgoHT+2e1F9e6gVcG44GuzBeBiPtnUv
 FWpzILdPJ1BG1WDnE/wl3MgfVQYIF1bk9QBEnhYxgZRDHIIIhgxtMdbSeul9uhijK0mL
 n6V1nMXlbrvbiXTrH4IVu25LvdaNL/7rMRNDoOyY6I7WQ+W89ICKdQN9X8zQ4YWY257W
 j324rAJZi8JzXh/GRqi0spe/OPm1nwkijdKaC6Y4cVBYZWBD52MkcvGiaXKCP5tNE6GT
 b2ZQ==
X-Gm-Message-State: AOJu0Yxix2uDQV0hTXQ8KA0t42G0y1AIrAygcddzPNtHwWsrhqDKJjCd
 ZUP3rGPtDFXnYpYsVEv2Qal/pTPhDYSZDeYmIHKucoUVgpIMPxpcbA3odw2uM9cQfFpiX2yJFYB
 r/a4CD2I=
X-Gm-Gg: ASbGnctaWBsxXtGM8vP+hOytcbqNr3Lu9pxyC3DG11V0tbZi6FwdnkgavcPfzE6XLJW
 G3F/Zs3dAVNN9q6/fNzT60dk29RLQROO4sTuDW9DXowIWC2jKC07M/AqQTzMVFd27TVi5Ot/n67
 10/anGSyj6vT7/vz5EHjdXffYf8vmKHI5zJdvJRMmkvtvPF2OUk0IILn7BG8AD6q9+0SwxFDoam
 p8CxkVuq2OvEqHki5ZYdieLJgPvYe0WhwHe4loCy4xREJKMY6Asn0RIpePpxGgQbB43reUtn39z
 lDbbuOb2d4FI0looxIQpKxtVeBvR3IXSoVF/VdaStU2QgblByqJLNHX0sB9UwljuUq8IHgKXqFB
 6rENSaVi7HO9IIQ5kscvuLTjwYhrLVLvalr9YWhOlSCAlVt1iAC7QTQi1tZuksN5LpvPF8Zqwfp
 FCZCh+QFmMTrSBKMb0HdthvZklFjIjCVGlQO8iWKbRhdVbA/+XZdMVU2JJAJWN
X-Google-Smtp-Source: AGHT+IEbx5ODURKSWaM19csRGkid5MXnIbaSFQIeQpDpdFf4QlS+cSUEAT5r6o21XMgeeUQ7mg/k1w==
X-Received: by 2002:a05:6000:25ee:b0:427:62d:132c with SMTP id
 ffacd0b85a97d-427062d135emr7594774f8f.21.1760998997691; 
 Mon, 20 Oct 2025 15:23:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a976sm17489413f8f.32.2025.10.20.15.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:23:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/vfio/helpers: Check base architecture at runtime
Date: Tue, 21 Oct 2025 00:23:15 +0200
Message-ID: <20251020222315.68963-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Replace the compile time check of the TARGET_ARM definition
by a runtime call to target_base_arm().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20251020220941.65269-1-philmd@linaro.org>
---
 hw/vfio/helpers.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 23d13e5db5f..007c37b28b8 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include <sys/ioctl.h>
 
 #include "system/kvm.h"
@@ -220,9 +221,5 @@ bool vfio_arch_wants_loading_config_after_iter(void)
      * See commit d329f5032e17 ("vfio: Move the saving of the config space to
      * the right place in VFIO migration").
      */
-#if defined(TARGET_ARM)
-    return true;
-#else
-    return false;
-#endif
+    return target_base_arm();
 }
-- 
2.51.0


