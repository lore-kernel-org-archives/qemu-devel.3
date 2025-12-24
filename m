Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB275E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYROb-0004rD-Pc; Wed, 24 Dec 2025 11:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROO-0004pr-5c
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROM-0007pS-Mx
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so28443195e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592432; x=1767197232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PhSyOCHER6qNm8+jjtpExCMtcWqtOopfzHYlGbi2n00=;
 b=FnzWMRQP7ZSiRzcvpIcUJLvJM7xW0KM3G9k9huRNeSglT18O9+IPWMOKbKD8p5SmG7
 8nN4gp9DIloMq9ZOk/o5+GfL38eLyu8KHxg42fYiuTslzo+K2KlrIGUReMIEoCipcOjb
 3Fzx/Ty0/AWs4M8YDmEnsd7CdDCqDWGkyR7ofJbmeomgxxoPvluCMS10NP0zuRcyzR5y
 rGo5FqYzK74c6QchT3kKJ23unjMR7jM6YSeWkjClH/MHSDVs+zMBw/VByynQH9vn40pN
 L0MkiSNVR3pSYtU0zB4r3OFcLrJvWluwsUpA3EoNUc2rzKe01Cc0U/lcuzNFU8GLshVn
 pCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592432; x=1767197232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhSyOCHER6qNm8+jjtpExCMtcWqtOopfzHYlGbi2n00=;
 b=J27k/UiRbQgQsxgz37WvqOmHCKupcrHNpDSBQvXinS8Pf3Wa5w9cntaSU92sT1VWYF
 4HYCQRHgnUpnsXRrZIc79EkbjxjvYbJdPgS7f3zHcxpgkE0yh5NsICmLX7kCGc7AwkTf
 sP5WLEW/BKhEdJSDDEeGWkgzLcyQM3cDb1J8gWtoMno9/HixioyGinmk/QN85Mt9fpqd
 sG19pUlxumJhArsg91T5jY8hPJAVYi7BT3ej/Y+m5zvrDb5YIm4RhSwYsnptnf9u/U1i
 P2cXVr5L/n59zYRZTJkgPt5M9XlPOsRzinx7nCnySfVycFRoDw++afJSTbE+Os+ublih
 KCAw==
X-Gm-Message-State: AOJu0YzKNV5C1lNlnxbvqgGP/XSGf276CbfK7/cCbp3quTGUTpwMn+dY
 SACbWxwAra3r1DkjkPcU1lQBvBH2HKPIq2Grhbgq+XQNTDDQqBQ/Kuc5UsqEVYD892tfdx91Rvy
 qYC1wcQY=
X-Gm-Gg: AY/fxX7LvLficohaDZ5JaXuNW+iqpDLUD3N8tZWgo8ZLeRG7jR440B2jDqrC/veut8Z
 8gQyafnha18Ghq4f16d8/v21Mup0kDSnuIghnM+FFNgYOp5q6oQGr/K/A+msx7pVh0DWVP3Tin4
 kI+vUqazdgQStCX3FJxPxPMG0lQA9RnlN2M/u58uI89HWzbH6mdgk1dxTEmmwS2oDtI5gHA+sU4
 aiAE6nep5Rk2yTrbPE0Yv3zh+hiaIGsyVyq6829QhDkkiVKJIiIE1y7dJI4mpmYAeFaSGOWZUUa
 zaz/Yv9+O0FmMbtImAJqTLj/SJzR3B5veTBEmd3EaoeBUZFqsoTlr4LEjNmrfhj6gAW9LyVPufq
 WQfAD0u5RAu9zleGcmWXk1U/wrttHw5ksLIbdlbozob/zmJxf+I35W/OIqYr0P0LKXhZwO/26zY
 DD9gT92iAYD4tDNBMiqSbN4FY9vs96cgbIOVugdqfjzJSeNq7LTxiI+QM=
X-Google-Smtp-Source: AGHT+IHjwjqNrBZHhXSIBNSfXIuR5NX2DfoTU9vVfVCXlywywNX70/CGkRyXaD1ODdHXaRQVpaDEAw==
X-Received: by 2002:a05:600c:4f4f:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-47d1955187fmr235595625e9.13.1766592431723; 
 Wed, 24 Dec 2025 08:07:11 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa9971sm137676175e9.13.2025.12.24.08.07.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:07:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] target/hexagon: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:07:05 +0100
Message-ID: <20251224160708.89085-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hexagon is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_hexagon-v3
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (3):
  target/hexagon: Inline translator_ldl()
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  configs/targets: Forbid Hexagon to use legacy native endianness API

 configs/targets/hexagon-linux-user.mak |  1 +
 target/hexagon/macros.h                |  6 +++---
 target/hexagon/op_helper.c             |  6 +++---
 target/hexagon/translate.c             | 11 +++++++----
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.52.0


