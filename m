Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E86ACF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQk5-0004K5-9r; Mon, 12 Jan 2026 17:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjw-000497-NZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjv-0002sH-9I
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so64786095e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258221; x=1768863021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DQKJikYrZlEXVopEimiXf12gGSbyWtDj+VINIWDC6kg=;
 b=Cc+TGNpYxPGqCVExIGjK4SX6AKt8XPa+z30ir7KdM4k5V5QEbVfUDIYp4IRB3uM8or
 tH7j/ypZ72sURh5llOIa1SG746erA2fzVlJ8dDQTmzairzMJN/5/RXX7FnmgUSLdWINW
 sjnFv/2iNPkfQCUA69pT3d5OJGm/kaVWOCXVG/qUnYbT4npLf22oiC8FcQRhpLv7KW8c
 8lNUgs1t8zAzEMnbiExbE+1C0Lka9rtwTEFzXff2nnbHXxU8kplERqaYmo0pvGqX+1py
 oUn+QLprdQFC4/PU3xmJKgJM3yE89C1djsQ+2bDn0XAow2yVhqQkMrju6BO/v8bMjGhG
 3CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258221; x=1768863021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DQKJikYrZlEXVopEimiXf12gGSbyWtDj+VINIWDC6kg=;
 b=ZuEPc15ic1BNeZcqUt2PFyj7BVzdQjoeqehTJOFvk9izbgK82jyP4ALu1BKVCuZ6bY
 CDgUxuz3/KWXsJu/QKVrF+FAfgJRlA5S09lyx8LkYcEk7TR+2rV8tUJ1et2Ga/nu5bf3
 qcShJEZWsn7WoDcbBI+cqMwhp70Ct43cJXciEIyr/ItCXCMDmdi2S8zeQlDzSs9giS/X
 1kAidshf7qk5pifZ4fl15D4cXHvkymHDffPfoAsyCyf3dCp0owLSThWrxInchID7+7XR
 l4EtRsfxJSQj20LCPBPH5nVlNHCkYXeJ3W5OJVeE4V1zPcehFDs+RKBXt3afWqHfTfXB
 tk8Q==
X-Gm-Message-State: AOJu0Yy4SfYue1DUMRlZi2flrzfyidpBpdVSl7y5JFksihksGZgaWPVI
 z6rR551m8rsToofy6tAl1xyqRQnuvxJxiE9RHNJIgUE8SqVWkB6/T2RNLHozcVDKlh8FBtTmzqu
 lMoSiyQc=
X-Gm-Gg: AY/fxX7MzJRFOdDHBeEUKdCpScras+C+McByaFCJtlxJLC1m5ylUJ8x2RYAd6ciNUCW
 JHGX7NplG3BcXouwb1SYCxodBj75ofazf6C+zzI71/2qzpMccrc6/WrTGkdcFG399hqNUHtRqq4
 U61KhnWWhfXYXpqLphi/msPpMoqbkAJVd8SIuyipkknZOEC3Kf2EUq9G5ACeXDm9EddI04fSHa0
 2sFah7u22/IcAj+mUZG/T++ryMPZ8QXzIk5oq6PrLF5Xa57PPwI3T16o24BOUHn1S6T1NtN0hqT
 H+r4Lc/xesKTYNEaJMaC5P8ieCPArnPruD6Fyo5fAiOURNlMfsqYgbCTbQI2Qz9XLXkySP9fba6
 Kzu4+hcJ9E73gcVyoZJBERZNTG2dfvuXMjiwq3VogPZ8A0qqJwYNqj/G/8J06bHAhNbC8r5zAon
 pGDnVUEtOEd5L0S6FqyGwyPus7mHs4fIhGG/uSxOYq+M0CyipkCzFl0UCoCBIR
X-Google-Smtp-Source: AGHT+IEScxvqZ2WvhYGTAH9ZcXBn5shU5Hs62KZDfpdZOhl6MKdFlrWOUNVoMZleIHHv032Jauz5Bw==
X-Received: by 2002:a05:6000:3113:b0:431:abb:942f with SMTP id
 ffacd0b85a97d-432c379b828mr27195412f8f.54.1768258220952; 
 Mon, 12 Jan 2026 14:50:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee893sm40302915f8f.37.2026.01.12.14.50.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/61] hw/alpha: Use explicit little-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:07 +0100
Message-ID: <20260112224857.42068-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Message-ID: <20260106155755.53646-2-philmd@linaro.org>
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


