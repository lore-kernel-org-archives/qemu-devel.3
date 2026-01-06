Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19314CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Rh-0003Ht-03; Tue, 06 Jan 2026 10:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Rf-0003Hk-O2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:07 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Re-0006TC-6F
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:07 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so647541f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715084; x=1768319884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5roLA89uLgbVSNGHvODMTx5DI2hyxThnFPheFtSmSs=;
 b=ZgKCUYJzNsrjk+hQDSwH89xprHuKIf3bouvvHS+ZdN+Ap0TR1/S5CRluc92rQl2xoA
 82kUEm7WT2lfAbEZ0KVL+mxgGguaTtHY2a0im+cYppypjEYZ/wGXIrFCY2wTbL5YIWlA
 +XVrFQ0taUNO5yCLOVi4bm1fAt/JdZs+2pZ5ZEsD/OFhWvPHrXntPDrdOV6r63Kkd6ii
 +LB0HHNH5xXvZvp1VmMSfdg8/uJdpk+P6qK3fh/T4w91WG6DWEFo+5ANFGiYNnNkkrzF
 dXNGvaL5UfFdEUF98cQobAk9uCSOe9yWY75f1WxgxhmG0TEbvIksL2Jhf/BIm+KEUKsa
 E5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715084; x=1768319884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5roLA89uLgbVSNGHvODMTx5DI2hyxThnFPheFtSmSs=;
 b=nAFLjhJtq29ZP8N9F+poaohigUKBeSRLK3rAVMIuc2P01PF1CNVWlOiM1XbWhQkdtn
 BfcdqnWbtuSIEh+nrlDlZPNwymoZ3U6xY4ln1D1EF+InXb7RvZgfdzJK1we3PSPVYbUg
 JTG09IF+KouzM6c+ZdSyKLpdpPtYoBWu2FXx5wydUuonDEOmOR22z/pY+cEwH0JyXIde
 hNn9qOY9R4OYWLg4Qtcgw/Ia6YWowxcQv3Q9agL35EuGgDzW+FZ50Eslvxlebj5K9K9k
 sGr0mmNhHRcsf8VJ14TDvFtVRySGxyn2k2rYr5lnCqn5i3ghtYGLLqu4ywglRkvbgEAT
 Vo/g==
X-Gm-Message-State: AOJu0YxHjq7nfYxDcxuTvdjjzU36hXhddVngkYnYbQ6IK236c740RVuz
 8xgZMaNzM8sipET5+YLJPIObu5kBvfK8AZXCAvZ5ig6Yi4ZKLkPkKHp67BG4+ZMz/lnUaA0RdNA
 LrWony1U=
X-Gm-Gg: AY/fxX5HTFjGJ/EJQJvaOMshk5XIcypx55Ya/nvH3dND72b5e8cmW3xDYv12TztdXvS
 EiN6xyF53p3TmKSXUheSVOUsgUhn07mB4csL2qsQDqAEqKEDgHCFurgy+ZHhMrw1AjBM4ciqpYf
 hrIevGGw0wsZ/Vh190tmxqXCq8+UecN0d+9DNDWL7EaNHC2ScenbKNIbFvJ90jVRd/Mae7ZsKds
 IVq3LGF5TgGgrwOI7ySXmN37HmSRhEvMLHwRn3XdR1Rtdz3qFWgaCfsicUuL7m4iN7ICvbo/TM2
 3z+SUYtKIqS2a24HKNiyBf9nW7dyk9oYIC+cJr/NAK+9N6NlR1XxQ6zwxlXFmrGKeMbjZ3T/389
 9gVKToG899BDyW/E1JENeyw+we2Rec3GW6u+y9vpOo84RK5+wdtmoYf9/pdUv3OBfM1AVJ1Lncp
 sikH58S5hV1hAeLsg1f6xS/0bZGNiFTxjG0v9EZZizXbROGH1YxLz03BWwK6/ovGUgg9W4L6E=
X-Google-Smtp-Source: AGHT+IE15yS0TX56lvaufPD4IOv+N3Eu6w+89GICp6O6msnA0bjYS1nfSQif+7WSefs+LtLeWUL3tQ==
X-Received: by 2002:a05:6000:2204:b0:430:f704:4ef with SMTP id
 ffacd0b85a97d-432bca58d28mr4124477f8f.61.1767715084064; 
 Tue, 06 Jan 2026 07:58:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e180csm4967390f8f.10.2026.01.06.07.58.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] hw/alpha: Use explicit little-endian LD/ST API
Date: Tue,  6 Jan 2026 16:57:47 +0100
Message-ID: <20260106155755.53646-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The Alpha architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/alpha/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/alpha/dp264.c   | 11 +++++------
 hw/alpha/typhoon.c |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index cddd94fec82..5e64528431e 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -194,12 +194,11 @@ static void clipper_init(MachineState *machine)
             load_image_targphys(initrd_filename, initrd_base,
                                 ram_size - initrd_base, NULL);
 
-            address_space_stq(&address_space_memory, param_offset + 0x100,
-                              initrd_base + 0xfffffc0000000000ULL,
-                              MEMTXATTRS_UNSPECIFIED,
-                              NULL);
-            address_space_stq(&address_space_memory, param_offset + 0x108,
-                              initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_le(&address_space_memory, param_offset + 0x100,
+                                 initrd_base + 0xfffffc0000000000ULL,
+                                 MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_le(&address_space_memory, param_offset + 0x108,
+                                 initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
         }
     }
 }
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 01fda4b1c8a..7722d4fd009 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -622,8 +622,8 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
    translation, given the address of the PTE.  */
 static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
 {
-    uint64_t pte = address_space_ldq(&address_space_memory, pte_addr,
-                                     MEMTXATTRS_UNSPECIFIED, NULL);
+    uint64_t pte = address_space_ldq_le(&address_space_memory, pte_addr,
+                                        MEMTXATTRS_UNSPECIFIED, NULL);
 
     /* Check valid bit.  */
     if ((pte & 1) == 0) {
-- 
2.52.0


