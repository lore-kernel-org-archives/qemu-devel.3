Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B6D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghrU-0008SM-2w; Fri, 16 Jan 2026 06:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrS-0008FX-68
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:26 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrQ-0005xy-Mk
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:25 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso1130941f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562363; x=1769167163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FIl7RjFm+tucu6fJwNq1+KG0f2AMg64O+5Vnw5OpV/c=;
 b=lecANSppcWqrmFx9Y7DnrTXRNTiO7pRR1VI+UW+z2pdU+vduunjL1bHhjkWTpIDvpd
 b1UU4RUQ3Ehm/1o7kkL6JbJPNngh3/Y0+lB2C6E9+6g2zhRiYDeeab+eddRevM24K6em
 CfrRq1gOlowXjWHRij50k0sSJYTdnve6Ea2OHWYZCeYN9X8E84SK/lfOso23pd+a4LhR
 nxlVf+vXMwv4CzC7Vx78SoU0Mzk6asJE2oRVa6u2R6U+vKXncsR+o+LtZsCbMjPuCMst
 InH6NIc3D3xiXI80k4P1FbfLXuqQm97MAAaQelJgtd5uInVLPHAYw2XdJqbmEOclRdyT
 5Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562363; x=1769167163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FIl7RjFm+tucu6fJwNq1+KG0f2AMg64O+5Vnw5OpV/c=;
 b=oJ8bu1i2hSPYtt25qr38KicZU0t6DaZcHIzBGwLwSL74nnB6cbhDG4oSqVmg/YQpxV
 zmy/lBiwCgvio1Nxs1+uG0MLrpzZTxDYWSaFdiXKbHXs6N48Xk9UUwvaztJ+qQ2fGJaW
 gnsT79WdhDD080A+6uVIapEBU5O8buTD7Der/QbbNkgkNnNZ/p1r/4p/h6vHZF6izhfU
 AujdoQ2tPEXz2/KVhfnb74cP+s8YQ9J+KOGYAYzcGO19MZ8GSsv4kxMVe1YyXL/A/+qK
 cN0fiPIitNzhxXpIb+WAyok+tM05uPa1TT4GKU2DDBzdjCcOMcrLuqS/nCnYmDN3Ircx
 kOEA==
X-Gm-Message-State: AOJu0Yx6OH2Pk4Lu0GwIh5NM3jlGNngI5O6U90dtcXO4HaQp9itta/yX
 XyahQvAJmkE8us9Bw4vmvoGYUM/jHIYVikzHnFdRBaBJcAxUfMH1/Rw+I0fBKBbKUik3ZrqW4AV
 B/0hPSgw=
X-Gm-Gg: AY/fxX7pPbIbFanJ3u8EY7N+EP1kdl1SGzfTjrHoO+E9nwhC/ofyVEaP3+SehsH51Ul
 AUWgaQISVSttnOB2ehRXb98d/mOHndRRvoHFzEQr9aH0/zMoPDE6TMqd49eXFClWo5dh9Tmbi1z
 pVB94RUCYcqjP5/x4siQx0NcvbcoRwxmHmcTnPu9ugwObcqS6LI/V0yCC+q1duD9GqlytP/K7aC
 PwcNt5bjoyjRGZ68vqV2jS2ndVvgz3ZI9C20CfGZxL2L/H/4qsSdaCjhS6/RmvjJi9+j7MAtDXl
 v3O2BRHHoICOfmFIXpRbv6lElJa3m5zUvfjpMvPbRdUmoltk1fEuBuSp28gT+RDJsgYiUeKhAJc
 9ri1ArfUq/+s0fRJ6a5jo5fbmJtGZh+ZKNejah2oGsTybN2exfYzXS/+j0Na2Uk8iN0A8I1tskY
 /Euj1qoIMwHbps99zyIlNX/PnndtdHM9UOvPhTVL/QO0qNDDoUaJp4ipMNQVEt
X-Received: by 2002:a05:6000:1787:b0:431:104:6db7 with SMTP id
 ffacd0b85a97d-4356a02c9f0mr3308535f8f.26.1768562362583; 
 Fri, 16 Jan 2026 03:19:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf42sm4609491f8f.20.2026.01.16.03.19.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/30] target/i386/hvf: Use hvf_unprotect_dirty_range
Date: Fri, 16 Jan 2026 12:17:48 +0100
Message-ID: <20260116111807.36053-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-5-philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 731cd954630..1610000d9ca 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -142,8 +142,7 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
             uint64_t dirty_page_start = gpa & page_mask;
 
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, page_size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+            hvf_unprotect_dirty_range(dirty_page_start, page_size);
         }
     }
 
-- 
2.52.0


