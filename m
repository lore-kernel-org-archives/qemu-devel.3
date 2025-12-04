Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77125D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKF-0006zX-9b; Thu, 04 Dec 2025 14:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKA-0006vl-5f
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:10 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK8-0007L2-4v
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso17530915e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877747; x=1765482547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfylBEVv2Mm1oEekJv/OQL/IvOcYQoBtichu4RhP+II=;
 b=hwtxltGnZLvoAQzyigtN0xT5lNC8Kr07jCtzzTIFBdT7WXw/rh1h+z/USiXkHNZIP0
 z16ohcZYjPMNGQM2HdA9eR0HYDEepCxnnjjsODp6ILCe6Sf1h/nXayJCG0ctDRcbkxeO
 J95BPskQObTU4nTchfpiaVIDIX3Kg1s5gFm9D3LzH3SWflDSIjUuy2FSQsZLRadjoAT3
 SIysfFv1kbrarbXQrybToL/drwCxznKX0lwVHbZ/sjG2iEAZncQIeN+VdZ3gZuBRMKYX
 0Zr0G9J6huskq/HWvcsHnIEM6Lh9Aqcb24ITGaHB1yLKZ77sDVcPd46J+isMyOCljhRa
 bKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877747; x=1765482547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nfylBEVv2Mm1oEekJv/OQL/IvOcYQoBtichu4RhP+II=;
 b=kW+izLNV1PDLHvySzY3XnWPvzk6W+pHzVgn12XVLbXJE9/z/Clk/OOeElsopvT02Jh
 hqjEnCorRFBeapdSm+lkYoGgKpCFF+Jh8zIu9OBy53U4XXUWaFttjdkdbxKFRv/TgNH6
 lnE8ftc7fFiLfOZl5XOPBpWoc+a2RfyEPDZjwTvMoReMv2T2qm7V+G7G3ZT5AK1lGdNx
 GLLwok+fzmY8BSLi/cccLwL/ZJsSWzgCiPr9+7Qdu/uuYOM/eGhUwICrp5ddu+dxv0fR
 nVv6XxVTeqmD6jdn0dgclCg3KyRcs1TukMvs9Xr3m2GU2UVuMkjPNoXDBNIjVh+NFIHj
 sH6A==
X-Gm-Message-State: AOJu0Yy+pwav45ZB+IUyuYRLQSxxuvP6q+NJKtLxJcXCHvNCBRKZNdpy
 jcQWZfmZiGeMDYz1RSNkKwgcvjRkCJDYPjpmay0/jDRgjyb80/OXKXiwCEsNaWnmziE=
X-Gm-Gg: ASbGncumeY6oHVEFhY98ChlpIAqAz36RHCx3DCtKwxSuEcZGNsQLnCyAX1P96fTgKy6
 mg5+LZBGY/O6Tn87SCMFmYPINt1lrCoeBUCLVkhjvEAqerK17ihOCRLmZMt5N19x1UQHUwEvpLh
 gPe+9Q/mvqq4kJCDIb6usogN0AXwKg5dAie+jn0A3A3dd88SUUkbLaWbPmhR5DQhgrv8HHQLhTf
 HaC3k51N4JelSbUOPqSEbQTYgKN0dAIyaRMdOwMmbUUCVrRsoXppfNLfrk+J0cb+Yf0LoQ4UnYp
 vmIOHkh0eYwXrW2JSNLlL1Xn78skuvUeUBGsVBZY6dhFft/e3zQx2zf97lzmMgQZNFk7dJJ04s+
 7Kyxtt86mdMoqn7lV1tgP2/gPHeCfZwGVcVeiVRe2Lu2K04cFChGCH3LJh6NAEIZaKrCzFoBO06
 bcQ733CHZ6Epk=
X-Google-Smtp-Source: AGHT+IF5x+Pq5zawlxEKIbU82cJ6RLcce7h8kucsSPM6YGgyQKsuHBJA5RlizW7eKfN4I3345PliDA==
X-Received: by 2002:a05:600c:c8c:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4792af2fe5emr68153825e9.22.1764877746773; 
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310a6d9dsm45950385e9.2.2025.12.04.11.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E9B45F87C;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 05/11] tests/lcitool: add nettle to the minimal deps
Date: Thu,  4 Dec 2025 19:48:56 +0000
Message-ID: <20251204194902.1340008-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Technically we don't need a crypto library to do the base build but
I couldn't see an easy way to skip iotests which would otherwise fail.
Besides libnettle is a fairly small library even if its not the
fastest crypto implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/projects/qemu-minimal.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index 2a1ac51d402..eebdc23e682 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -18,6 +18,7 @@ packages:
  - libffi
  - make
  - meson
+ - nettle
  - ninja
  - pixman
  - pkg-config
-- 
2.47.3


