Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE76C3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Im-0004lt-3k; Wed, 02 Apr 2025 17:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Id-00049n-7q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:07:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Ib-0007SW-Q4
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:07:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso856805e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743628020; x=1744232820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybuOT5iHPjheG8AHEncXZPqzQ8VYLAi18PseEWSYhQk=;
 b=VikV8kYEfBzzUsyrniXgqqFEeK/JnQqjiO6+DtaGkjJvfORSZWSvmE6lHZBP7/9qBh
 jh4GRzA/8iPWwC0ju7r/KpJhgcNBHZsqQe4lmBVk7msc0nm1yWJlU5fD7oOauGpXlI6h
 h2kLJPVE1FX06s4XstDChfNcK+AZd9nTm1PlzjPg/Le2vc3z4K0515Vdj9Q3gaVVKb0z
 BIsS5ae+AJnArDvYwqKaCWRnuoQo/ovEvy356jasp5cBY1gApsNrzMYFjss5w2yhmkNm
 ZM8mnQuHuEAFjQBq4gR7zMd+u8xRPwavkAzYXjHdBEGzBE/Jsmt43ThwB0MbUsKXgMCF
 Z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628020; x=1744232820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybuOT5iHPjheG8AHEncXZPqzQ8VYLAi18PseEWSYhQk=;
 b=RImHmnRhvnkqOvUDyvm5n8zlG/GFCfc0j8KRgG9ocD5m0maZVb0xGIk+qzHgAGfxHn
 71B58twC0+Tbn3tum4j6edlWwTsTQf6hW1Csb5Ihd/6QtHD5DTtMGFa4YUd4Z1fH5CMP
 q3cYwpYer1BnT4JIsTOn6im3Zu62lJwCXUO7EBZhNmlbzBmPf0omW8e0FTywzD7Brqrm
 FYbA9T7KALGAjKzEbxIcASTLFx71pxBuLAkDGNhpJP5wlGL7LnipsLyj4uhyInzSUXdc
 Ft0ZD5Cmbf567uO8OmTVODiZxHnuKmAsf75VdoMty7yDFGe3yZT3sXCtwXIKf6OV6D5j
 I4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7OsNNz2BlnG0aCu7tEC4vFZRd636BnUiPc6eSeohnnpf9Qf0sHgcTiHm/qxuFtLY9Ndtlb81rscQy@nongnu.org
X-Gm-Message-State: AOJu0YxyOmc5VjEQoQkilrvOFsDXKnBdvEMfU/RoX2pPFWdaYFHAxRvC
 H0eXncVLNc9vonc/avKGLo1CRnmjlJXLyzhnGoSratm2FZL/uBWBg4aMs5grs7hgj51AWLabwcv
 g
X-Gm-Gg: ASbGncui5KQ3hY30aY6fvOvPCTREubBn/fTs+B0JihjViPhbkgmTjyUrSBffuGIrRYZ
 OKKLmpWELixfrkLY7KEIGaG4hLDhmPiN8P9pOvqL3WOuq08eY+Ntxb3UzVPjvLs158XHBtPPz1W
 VIIxU8//MyQsLkgFNbitbL0w8eZEEUszCDvOojfab2cVYAXq6klws6PQcYx+ycYboeTq6CQKyqC
 DfOrSPdFIhdK4Swb86/Kqib27L7/K2m3lJ1ZenBv+Auw8B9PiLQKBJeB5tNV7jl5MR87v8tLGA3
 ht6HIi7EpaFBXo2g/NQs+F24zGb1DbnQVxgnH+DkFp6ZU+VMEepxGq/oyq/XqCHLr5Ll1VxA3TR
 p46fNf7VFpddTENhn9YyuhktiD41O5Q==
X-Google-Smtp-Source: AGHT+IEJ8G/KsHkTjIjBlJWdG/BUBQ1k2G9prN5U50H00O0yDpMf45I1s9HcttBC5VH2fgvWcyGvyQ==
X-Received: by 2002:a05:6000:1863:b0:39a:ca05:5232 with SMTP id
 ffacd0b85a97d-39c2f8c77d5mr117983f8f.5.1743628020464; 
 Wed, 02 Apr 2025 14:07:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a9d2sm17930101f8f.43.2025.04.02.14.06.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 43/43] target/arm: Update comment around
 cpu_untagged_addr()
Date: Wed,  2 Apr 2025 23:03:28 +0200
Message-ID: <20250402210328.52897-44-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
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

Since commit f9ba56a03c2 ("user: Introduce 'user/guest-host.h' header")
cpu_untagged_addr() is only needed in "user/guest-host.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3705b34285b..88ed06987f3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3233,7 +3233,7 @@ extern const uint64_t pred_esz_masks[5];
  * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
  *
  * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ * include/user/guest-host.h, and not some place linux-user specific.
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-- 
2.47.1


