Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1F9108E1E6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ax2-0007oj-Fa; Thu, 19 Mar 2026 06:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Aws-0007m0-0L
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:49:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Awm-0007k6-Ls
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:49:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-485345e1013so13757505e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773917386; x=1774522186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r2QE1Wezg/vH92OJMcGcU3hzYOKu/4lGCyDpTXsFS0M=;
 b=Up90n5cM8yaKuXy+AKT3wONXoH0IeDfBoWH8ua4feqf/JsPwzPdIl2IHZNKLj0Arc1
 sQqsiSqtzp/F8dkYxVDjMAeXq/LjJJa21Emei+xTxNeex02n+02g4XTcO3g4hRQr97cm
 zLplojk6mzAG7wqCGlSRzmirloto2W63tKP04CE8YchOL0XR+jdBKSRd2fl7UIL8fUOk
 Oau9eB38uYxtzfpZ8OuhdGlaleDyd5e1N4uWFu27J00IH4RsfA16CDjBs6vihz6dgXrp
 SXjEOSMLxMGhjD0qFITJNJULYT7IL37pQ8t0ulMD4UvNxtV6z1cKoNFJ5yWFRuPJmUiC
 CkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917386; x=1774522186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2QE1Wezg/vH92OJMcGcU3hzYOKu/4lGCyDpTXsFS0M=;
 b=CDz3qlpw519Tt9geaVCTNkV64Sh3e71MMVlMLrbRWiCc2ZUCLKcViX/Ew93RFOByfR
 wpEsx0I6lpGxJzz2LuBliGqnmNUqDjE7LAYpsGEUBM9nS5rnr4z+jFVro357y+PZbF4x
 mFYcIwKeXjZMYzwTQeIB2lOK3H+OVdAnRAk9TG2HRT+ODiHdP6fekV8KpAbXnHphp1Xo
 SRAGJLcPIZDSKmmzmRCoNLVYNZwJc8Yi/MMYvJkpyd2Ep7FBEVazJYqwkl3rBUeS4SV0
 iIB3Cb69PlEGSCM9Tc5xEAJT5mJvxq1ksylo9DTDM9xwRJGpQPptwhmcDOHaE0B85pEj
 0vyw==
X-Gm-Message-State: AOJu0YzehpFB67qCh5OVFwvGSxs/uXDy5RSS9wRG79GBTqADxpC8jH/3
 zyXHBc6GPBig/JSdmSXSXRO2K8DZWbmgwz/m23pfFjyhfIHLCWCI/olH6k4vR5kz/ZR9q8KqroZ
 AATFfpB4=
X-Gm-Gg: ATEYQzzkqLxi6c8YMmIbm5CswkgHZmHR3VAIdhOYoZ0WEUok7a/qdpawpTG7l/ZbF7G
 y9CbUi7Mv2WPKg6c2RIOs8fn3uPtTQDxq0jUez9TjHwjzbfO3zlbSqddpc0pOGmvB8tpwq/WFGI
 ldCIbmeA83snzDb+x1LJewQ/FUY4J0sYB/Lg5j4JquPIx2RPZmR9ZoOk+CjII7NZE0A3PvmNn0q
 PzSICLcJUv1kLplLLwyDAVq0KO9F3gXz7zsdQtWTr3PgCLBCrzYh/8Qsv7n0GIRIqSS/fn2G/Bs
 uJ3+DeoZMVeIJtw3NyMyRPcnTftsDUDF7WNGOfKGQgDMCegyWqmEO/zT0IChuvIQuDBOTetH0V3
 HSIq9+cS5jgYjlz/eqA5UrQdZtdNqJpnmZtnx9CwsktWXOAP+HiVv3tG6K4jMascJHN9Bhbks1U
 rJAJBjZG2GnOPmpJlJcmck3gd1nG4IRFYmuWj5nZM4rFFgmEhH1zAQmWr3Q8kBiL1bPXbXDx7n
X-Received: by 2002:a05:600c:620e:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-486f8b0a496mr47388795e9.1.1773917386478; 
 Thu, 19 Mar 2026 03:49:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c40cf5sm54769345e9.8.2026.03.19.03.49.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 03:49:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/loongarch: Forbid to use legacy ldst_phys() API
Date: Thu, 19 Mar 2026 11:49:42 +0100
Message-ID: <20260319104944.66690-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Replace legacy ldq_le_phys() by address_space_ldq_le()
then lock the target again further legacy API uses.

Philippe Mathieu-Daudé (2):
  target/loongarch: Replace legacy ldq_le_phys() ->
    address_space_ldq_le()
  configs/targets: Restrict the legacy ldst_phys() API on LoongArch64

 configs/targets/loongarch64-softmmu.mak |  1 +
 target/loongarch/cpu_helper.c           | 13 +++++++++----
 target/loongarch/tcg/tlb_helper.c       | 10 +++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.53.0


