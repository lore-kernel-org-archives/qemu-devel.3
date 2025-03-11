Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD09BC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5kb-0001cs-HR; Tue, 11 Mar 2025 15:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k6-0000x2-0P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k1-0008W3-Ur
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so114172175ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723096; x=1742327896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=qTrUqQrS5E6Jv2aS6Ixv11BuNRh1KnTuP9xXCEbRmLMIzL5njoGUaI7fop0B9UtGAH
 aN8QuyoKOWX3UhC5CmYrseXou5miV4e/fn8VJyygiAGdea5EKO66DJXbo15volDfrHCL
 b+OYP5y59gXfSHzwXk7viPGxs9YTN17lfAnoCTVc0UBvyCBDl5i7CdWO4RzImr760CiE
 IuIwMcLORxbdrNh0mHI3I2NwlXf3BtmKpVgG71EWX1ZhE3wx5tThEZBpmeEyvYDsaujj
 EhUvaH4zvmwF844V6SDf58oonTSPckANgGGaxI12oyUuzmB8Te/tCpN89wVnCIgqlJeV
 C9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723096; x=1742327896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=nsSE1imopcge8zlAlRMzxtVRHS7VRdY8Y8VhGvLxV2eoCvxCiP0L8OkAzHeqzSMZXJ
 24/rQKNrCiJ0YWxXQa3L01zPR9vozOJOY56nFq9yTpYhD043+poDKx7ifDfJ5XSdDYrn
 IrfV02WigGUiZSyW6b4nyeWVCP6OHGUJOyDwHvcBLOl0B8t5Y9wLw3J2IbJLAkzO4Ni3
 VQjyLLz4s41M9/AqwVh3xGuUaypkeeDLAg8AHN1kTWbsLMUAw+/EZ/D3WG7Bp1sT7XRd
 HM4IEBLW9Nxz7QkVta0pUj1l+rRVp1WYE9DHheE+aHav7Gv3S4Lljc3vCguRyJTMdRQo
 pqcg==
X-Gm-Message-State: AOJu0YyKkIgSSCfDMKxMwITDxVKTRrPzH14Bmlrp0Hle7iQLrMTg0aOR
 wpC13pGgL2d9/SO0mr/XS4PTzxqyQxuhUw5QI02mT8cGNW1ico+5mK3bbjkwm++Ff/iJSpf34rL
 xpJc=
X-Gm-Gg: ASbGncvuesW6QJ10rwAcQL8XZWgtxOEj9DGir/p6jM2kMBYBx2qQaVVn0A+Pv/aOIda
 KJ/4fq5BPYcRmt+QCDKdtaIhq+33DzdNnzkHyRM2Fpl9+dGzxk8X3jMNZY2Sp7MeGGNoVkzUeKb
 ZOi3J6g48eRGdwkVu+iwZwMNRnvIJxfRpAAC2KYZ9OiniYOQM93hk+uIil+ISsevt3TXnoXWJJF
 341cLe85Hf08c8OVUgRgIjWupTkNjppJrFXUy5CM9g8O6XaVCPot7sx83n0PnbJtAcqwmpg16qN
 x2pQ49iPNvs9+ptT4uubq1xEzby9OLD3F+Q1ZcqFpF7u
X-Google-Smtp-Source: AGHT+IFol9xcK9Mza8BcbJc/CzML1UZwkH32uaLlj+5vumcl06S67T5kaVFtBRtM8pv/UzBlFhWjBg==
X-Received: by 2002:a17:902:f691:b0:215:bc30:c952 with SMTP id
 d9443c01a7336-22592e2009cmr58302965ad.6.1741723096508; 
 Tue, 11 Mar 2025 12:58:16 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/17] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Tue, 11 Mar 2025 12:57:51 -0700
Message-Id: <20250311195803.4115788-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Will allow to make system/memory.c common later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index da21e9150b5..069021ac3ff 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,25 +3138,17 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-#ifdef COMPILING_PER_TARGET
 /* enum device_endian to MemOp.  */
 static inline MemOp devend_memop(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    /* Swap if non-host endianness or native (target) endianness */
-    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
-#else
-    const int non_host_endianness =
-        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
-
-    /* In this case, native (target) endianness needs no swap.  */
-    return (end == non_host_endianness) ? MO_BSWAP : 0;
-#endif
+    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
+                       ? target_words_bigendian()
+                       : end == DEVICE_BIG_ENDIAN);
+    return big_endian ? MO_BE : MO_LE;
 }
-#endif /* COMPILING_PER_TARGET */
 
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
-- 
2.39.5


