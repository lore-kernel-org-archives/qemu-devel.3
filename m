Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F0CEFCE3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGsa-0003Uo-Fd; Tue, 06 Jan 2026 18:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsZ-0003UQ-85
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsX-00045i-RF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso7098585e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743660; x=1768348460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fx/85G/s+VYWSF18WauulcwVsUieDaCovi7d8Ks6OsI=;
 b=c3cvgVYKF8LJsN2ycuQ6OnFJC0xD7YspkMvz0QgDzEWydtR3BGC9VoOGL10H7qJd9J
 zDGYfJiiOIsOoFmAmT4QEkGH7fp8YcPFWwN89Nq9UnC1yrbgdsHMiICG2HLw3XVEX6h8
 TRaj3S2zBZdH04Ql2dWgxUTlqhhDmAZexVBBDjYbv4PQRcO9aoXKWuJ44/9VXVg9SuDz
 0Vkk5Y1grBtmbIAu1u7hL7Fb4oFHhN1RsKw7Yd3bKJOSQZLCgP2KyDhExJkjECo2RwjN
 uwhxApQtbMmIwcwUXdRHmix4dk76aIcIOJjv96et2XCaefXDfh5mvG8d275wrYdNbekY
 LfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743660; x=1768348460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fx/85G/s+VYWSF18WauulcwVsUieDaCovi7d8Ks6OsI=;
 b=oNyF13erml3Kn5EvcX2MCUyOpUuY0fVOahhuOPD+3V51kMBNMtveqvkzy/NOs/1d8/
 RrpYUiN4qGq/rmR3LWU1icxBJamDCXonpTHerky7uH6rpWN1ilBC1IWuvs8UrJpIcCul
 uvRwHuiCwZFsnjCg8cA+VEls34o5Hblxb/6GH+snANxAxEP0SZ4PzpPO7b4lSXtz2AYS
 DAiK/QTq81WdtR9poPMbOjrrkneEMFHsUVyXC5sxi+tEc942dPaYl83H/dNVLbhIP5Pq
 Ch+s1M7SMB1QD9d77Z3JS2k2suO3GlHUaMK+IDuRf7bFnyGor4GgUzdRHXnMHrfksxdH
 KdEA==
X-Gm-Message-State: AOJu0YzlzOYZpZTHuErUjWlhL1fKid5npiAnS+SMtCdHQjQvxRaQ6ePt
 z1/0JfNrajWCaWt0Sw+7h6bujJGrVfCB9wbKD9WQxzw8mck7XRG5zwv/bSzIbNZ4JPHd/4O7/9P
 i+jlQoM4=
X-Gm-Gg: AY/fxX6QvtBuZGHionO3IqQf8/5z/KddFYoMt/VE2Vxcspufye0hP1zhhoI0GQm7BQv
 kutTPuvMj43QAHd/hBTWgxukDLDgUv2EqYl7NHMLP4DZKVkBKNgA3IATeZNJ21TnBTxRgUsifHX
 Go+pviU5EHUPejCyxf9gRVoGhuFFZkcUw0tkO8iibgiuwx4AO1ZgCoildrywlIG9n4IFM2SXJnk
 i5Q3qsYGeLkkeMLm7vCvFTS8Mnm8jPmeNQ56lc+H/Ql2uabe4VoWw5SQFVi/4dGSsec1fZpzKbh
 M6hQa/WTE6tw0+YwiswKXzRBSopTFIbPhFkzJOzhpIuEOfuGtQ4/McOTV8YYKFfuBwt+Y/NHBEA
 FVL/DXLb26AtlaYESO9MqGxaiZJQnqN7vxz00+tiUecbjDEGKYa51ULs1trEoXjnHWAlFUXorEZ
 urOORSnPgGcYvdzO9/J9hZv8Bu5qjGTuEYN/Or/MxfeSehKo3WmVylybv6nS1e
X-Google-Smtp-Source: AGHT+IEkbNSBfp8Y4pfmV2bVE3auMWZG/+m0liGgY1A/9nYwNeUYgf+PSTLuI2RWZo3zcXYX/2Rvsw==
X-Received: by 2002:a05:600c:354c:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-47d84b32f1fmr5935795e9.23.1767743660020; 
 Tue, 06 Jan 2026 15:54:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm7349841f8f.12.2026.01.06.15.54.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:54:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] hw/microblaze: Build files once
Date: Wed,  7 Jan 2026 00:53:32 +0100
Message-ID: <20260106235333.22752-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Previous commit removed the last target-specific use in
hw model units, we can now build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/meson.build b/hw/microblaze/meson.build
index bb9e4eb8f47..d8e7dfbe0e9 100644
--- a/hw/microblaze/meson.build
+++ b/hw/microblaze/meson.build
@@ -4,4 +4,4 @@ microblaze_ss.add(when: 'CONFIG_PETALOGIX_S3ADSP1800', if_true: files('petalogix
 microblaze_ss.add(when: 'CONFIG_PETALOGIX_ML605', if_true: files('petalogix_ml605_mmu.c'))
 microblaze_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-zynqmp-pmu.c'))
 
-hw_arch += {'microblaze': microblaze_ss}
+hw_common_arch += {'microblaze': microblaze_ss}
-- 
2.52.0


