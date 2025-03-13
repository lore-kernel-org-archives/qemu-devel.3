Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88189C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWV-0004nO-Q0; Wed, 12 Mar 2025 23:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWC-0004gb-IU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:00 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0007n7-HX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so977248a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837541; x=1742442341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BWrsEoujlC9AWCKD++ZQxeOKLD3Q+4U2GszON2PKZw=;
 b=lUN6TdUAIHpGA5aw7rbXKaRfAsN/fOLNQuQYZQ3pSpdFaCeDHsww+EVqYF4GOWpn5K
 bHJsMQDMiBzP26ZwyOxA8a6LfxX+Ue3p+yC6eOm7ea+5w2jw2pZnWrQuaKfU6usdYfQw
 WtKn8m3I4SOWPKBR7CQrTsj/sV/X/OQbTc7OmKv9l2y6ngmxdYTJFJMia2+aliHpL8lu
 gGm0iTHdbIt0Z+BPtryKF5Z5/NXtrdfE0aVODXHCVtXeGG41nmgNVGRR/OFLrVEl9IO/
 ODDKbQRasvxFFk9X2oS9+98x4C4T66nEXTQQm2cnwT9M//TMLbLlKN5I0dTkQI4Rbsko
 dNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837541; x=1742442341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BWrsEoujlC9AWCKD++ZQxeOKLD3Q+4U2GszON2PKZw=;
 b=i2UrAmJo9/xLtohzuRqD9PFXdGYE0vfWAQBbkVpbDJdg9YeN40VdSXjeZvFtLJnD+n
 r0cbI+M8a+6RBbAGxxVD0IZt9qBURLQMSKBQqHwCZG9eUoAOiHENNkIGtstfZtKxSZPD
 6b7bh4UbgT1PuOMiTunh3K/I7i/LE33iMp5yrX5V8D2EiWKrCSrNMIb4CXOwyrARCii7
 ZkyHbMZ6xEjJrUWcH7MW53tKhcIq1Hq/rNTdLQyRbzrfkdCsjEHItTBdgNahnNgk80M3
 oScb3DDZHIiXFKyJqssE+Qsky4IZDWqAk4BV43GWf0KsOu4RvK4Vnvb2skbE62ioLpP1
 vnVQ==
X-Gm-Message-State: AOJu0Yz7ikNM1KqXI+Mva3d3HlZqDr2h0O2rR9ra234LgQZq5ZHu+rPx
 qLQZn+maxEMT0vp1EOIFFsDI8JaraWlMa4xixlCoSWQTYA0q9dasNCTz5hEI/b2rjLNnskD+Rpt
 K
X-Gm-Gg: ASbGncv2op9gLxKSjrOOBpB2/UrIuMWZpMV8wHOkMa6z4hoK4oonAsd+BuZ4xqd1v54
 9kW3RW3y+Qg0T0IusqkLbWLGDXcJSR32jpn9bTDtLtIUekuGXpz1SIkTeJBclPnirxELWbgsGVU
 jQAjUF6bgBarLUXx+MJFQDV9TfdidcCWjvlBv79/4AljzO+kgRP9xy5bqOG23mMzO2Os0UzzzDX
 Mjv4xNB8efhmEL4mLun4ADTW89n+lGmepTC5Ns6SJEfobYn+ClxRAP92GEOoOt1YH5wWbSWRYU8
 +CxvPsKIhhYidNDSKM0vl0SKdhtyVhG5AU5hec2pLPvtpRY1cBqm7xDeo1ex0U1LuYUcyoDn7eD
 k
X-Google-Smtp-Source: AGHT+IGolhoHstUf386P+UWerkRh8jggaCoM8l4UkJSFBUr1QEzDzz0HxltPEBgu6DlVM/Uf5XnU2A==
X-Received: by 2002:a05:6a20:72a3:b0:1f3:33bf:6640 with SMTP id
 adf61e73a8af0-1f544c90f98mr38853507637.18.1741837540851; 
 Wed, 12 Mar 2025 20:45:40 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 18/37] gdbstub: Move syscalls.c out of common_ss
Date: Wed, 12 Mar 2025 20:44:58 -0700
Message-ID: <20250313034524.3069690-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Copy to libuser_ss and libsystem_ss.
This file uses semihosting/semihost.h, which has separate
implementations with and without CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 0e8099ae9c..b25db86767 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -7,15 +7,15 @@
 # We build two versions of gdbstub, one for each mode
 libuser_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'user.c'
 ))
 
 libsystem_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'system.c'
 ))
 
-common_ss.add(files('syscalls.c'))
-
 # The user-target is specialised by the guest
 specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-target.c'))
-- 
2.43.0


