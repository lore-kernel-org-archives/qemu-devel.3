Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFF4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnN-0006Nz-V6; Fri, 01 Aug 2025 10:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhO-0005RR-Is
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhL-0002hL-1g
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juJQ/hFTjs1a2j/Tj1r7rgVJhv27n25AWpAqA5inFBY=;
 b=TPtxExSqWA01ZWlJiPoQeq04jegnh57KVLtL+WgtNlKPnyxIdQ+t+Tkz/2tAMX9yKsay1h
 e9hqgbLaKzoqQnDh38iQrifC1/MrZCh0Wja73JoilVP+p4O2V0zBhYUvhlLpda0JAEaxvz
 Gz3TQ4ZsXx7HmO6LxJRsyXCKtqxXyxw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Ufuzzuw1MPqapSP9IVe1cA-1; Fri, 01 Aug 2025 10:25:19 -0400
X-MC-Unique: Ufuzzuw1MPqapSP9IVe1cA-1
X-Mimecast-MFC-AGG-ID: Ufuzzuw1MPqapSP9IVe1cA_1754058318
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b793f76a46so1916137f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058317; x=1754663117;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=juJQ/hFTjs1a2j/Tj1r7rgVJhv27n25AWpAqA5inFBY=;
 b=h6ZzVX8euVVPWziYinaUW3raCFrUrlvve9RorXXbdW2GOgE2Wg6JZ5vs8o4J1rWuMb
 PpzbDkUr/kU549XhyPnvcwVmjR7PIvNjXZbfjpdRjk/+lVNZRJRsW5bJXWlhfI57T1Bf
 pmqKiOG/Kzh/raONRf4F/6yZv7cu5XKTMKlH27uQUMiPPOB2kubtc9O78rrQK0sbCpdY
 YV5B24WH/D+98XIFqykFwGyzTpDCUamJBMYxooCrUWD8UltZ+IdWHQ6mo7TEkrkezzhw
 /oy32zmd3XzY8sCAiR0v+QYoair+RWSBcxYyZsEOXVZrcaIPmou5+zHPrkwgjCEGroNy
 fpzw==
X-Gm-Message-State: AOJu0Yx9B6D6ADdNw4S48bC2R2dqslNnDJwvifPltJ+pkq8/GvLoi1hF
 JcgGIiJ77seqWtBednNQuA8/wz4X+GH2t5hQhntXqbiwjeTqwvNh1XzNwr/5mN/5Z5qWNmOwRwi
 nv0grTPqVgOL4RydhzxbAOYLS4kt5Swz/gT/vstH48vbKRdOAQJKKDctKvl5XiXtIFL+TTwDkG4
 EkcBDvL+Vn5n82OeC8jdWl6UXtHjIeNoJ9sQ==
X-Gm-Gg: ASbGncvKZ+HfpOPl3zlIgdM/P36APsyJlpFm3hhMkF84+k+1wzgsAdug1eFvK12VUHy
 m9QLznW8WQWvembGhc2Rmn/RdrtK4NF7HqWHjrWgUQMkOrKTW2/4ML2cTpV4bFl9rI8YVbhMxyZ
 SI/EWMM+6hb0gj3oT+adXP9MpQ0JG/uwurq3PUtJRSW81t9n+NiXDuNRLRdrZeUW2eTLytjj9Wf
 gqyGaZe46yxfU79wMj7rduwF6YeonW2aypN8c84jnBjmFXbWFAT7TlmRNiUpDaFivP7/Y99nI5u
 pFf43dC6aKqARE9dqU340AqHy3i39axw
X-Received: by 2002:a05:6000:1785:b0:3b7:83c0:a9ab with SMTP id
 ffacd0b85a97d-3b795035de2mr10720803f8f.55.1754058317310; 
 Fri, 01 Aug 2025 07:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhlTFUnKF0XKj5YBims/YinJb+/4Rl9uNaLsdQeT+jTp1rJ4aLnqloSBATDBoFdUN49XyqBA==
X-Received: by 2002:a05:6000:1785:b0:3b7:83c0:a9ab with SMTP id
 ffacd0b85a97d-3b795035de2mr10720766f8f.55.1754058316691; 
 Fri, 01 Aug 2025 07:25:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abed3sm6042326f8f.10.2025.08.01.07.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:16 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 06/17] hw/i386/amd_iommu: Fix MMIO register write tracing
Message-ID: <96c75abc872c1a90c8e1f4a4d2ed35e89a1befe9.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Define separate functions to trace MMIO write accesses instead of using
`trace_amdvi_mmio_read()` for both read and write.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250801060507.3382-2-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5a24c17548..7fb0bb68f0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -592,18 +592,31 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
+static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
 {
     uint8_t index = (addr & ~0x2000) / 8;
 
     if ((addr & 0x2000)) {
         /* high table */
         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
     }
+
+    return index;
+}
+
+static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+}
+
+static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
+                           addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -623,7 +636,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_read(addr, size);
 
     return val;
 }
@@ -770,7 +783,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_write(addr, size, val);
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
-- 
MST


