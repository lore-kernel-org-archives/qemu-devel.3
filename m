Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BABC106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxN-0003YL-SJ; Fri, 13 Mar 2026 02:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vx9-0003CE-NC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vx5-0007Kx-Uv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso1652865f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383090; x=1773987890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dezehQEE47OgJx6wP6NF7FqVAQGz63o5UDLzIgeTZAg=;
 b=JtRm7+9ma9jMF2VCgDwqUogpeSqgCciJ/q0hAA/pYaWMIOib6bsmAb5Negc6ejEgBg
 Xg4jGJBTtSV8TIh9oN40+cjyET/9bAreo3RoI2nXceaY09FKBP02OLAE+eNmwyChtTKV
 UWfykNc3gVCI0JnI/icTJxriOpVQnZJ94EsAQN/ZMAcs96OHEKCQvEtXKmFTwmZ6zxB3
 QjAf2fruAuyPL18Jf4XisfmjddcC93kAwQOVdcMDeQlDaf0cGzK8PeL6F4ck8MoAoXcR
 lIGwwaMXjsI84triq4lI0qmaicy2lgejGl2ZbHU4iiPQ1YdABeBK+fpeIm6JHyYbblxT
 qL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383090; x=1773987890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dezehQEE47OgJx6wP6NF7FqVAQGz63o5UDLzIgeTZAg=;
 b=XHD1shyYtXPBs6Svwvw5zX9VA9oB0dJfwKvvxPtp8ExjEoKA+3++v4WyhWNhg7y67s
 1EQg5FM5LnGyY3GLS0x7rTKns6S764xuyN+khs2cf8sPoApniABgcLdLB3saLPZIxhOb
 Qg+CTD2L1l4yT1whkQIYa5nV5SYf04kG9XvtLicaNndqKui1XgKVI4BcmgRMdrKVMGx/
 bH1Fp76xzgEmFI4PXgJWOaCmqW51wrQvseDKOjftbh5SHW+wsr5DSAzAI51u46MPpWuX
 taBo7WpztBFQY2Dz+KTjp7c6gwbV/RqTfM/HjOLeTUn80yhRWUO23Za9EhCIpp2Hnz2N
 ePEQ==
X-Gm-Message-State: AOJu0YxKmZBKB5jNw5YyY5ktFfgp0j99rsbWoE6gN1aHsYdNFkXTWADr
 6C3Wj64gs0wSv5z+thZu1ULHWEza8aNz1H2CuSKQtCKFqaqXixfhzFCHtsYBRavh7A6IAbDRaoh
 jdR+iQ+I=
X-Gm-Gg: ATEYQzwK6sREpgFpedQcZZJ6NpO7vuS/451Bq437FeYV9UHjgBkyxKq4xkUeZN1qcEc
 YOPt71BQPnW0xDngzDNB0Hoai7RdPwqc0YS7R1QFIvxT7G9QtuxceWgHkuLW46Cv4UKlloJQMCO
 KFd2eSzS6iEyYxTrm8oYq5/Cy0JC5F9a3Gqrqq3tm7sXKvnMgt4g9kQa7GtNiblfkDp5dQzU1jH
 oLEggd3kmCzplFULl7Y67HZ6xwpUTAVDUYT3szAeAtXDkkZCBOfGH5Qzkmmmn/lKGPpLg62sdkl
 qkYbdbTkeNGEjYKjNeHtAd9epzLFsfQyhmM3fhMLTVrfhIr6aRrrTleRPc4Ov8UJ0N4G3Btd/Pa
 on6CbdPtLt2ZJuvY+2aV8jX5DoLNrA9j14Qn03OyY2iT3Cs126mTNr+uBXEV7hY3Xx3av6GkR0G
 FHxsAxPHp36bgtDNl817zaW89/sfwJXGPzYPaNMiR8KFYrAdcvksY5U8zyOv6cKXDHpHdIF+ruI
 sg+Qw==
X-Received: by 2002:a05:6000:40da:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-43a04db6022mr3906972f8f.34.1773383089614; 
 Thu, 12 Mar 2026 23:24:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a78cesm14110433f8f.11.2026.03.12.23.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 34/38] hw/tricore: Include full path to target 'cpu.h'
 header
Date: Fri, 13 Mar 2026 07:20:50 +0100
Message-ID: <20260313062055.2188-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tricore/tricore_testboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 60772d4f1d7..d5d796c8eec 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/tricore/cpu.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-- 
2.53.0


