Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E4C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSV-0006e0-34; Fri, 04 Jul 2025 06:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSP-0006L6-DU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSN-0006lw-GE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so3756675e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624145; x=1752228945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+xZJfQ5oPTw81l9vGVJcZV3TZMpxgXbDigfZBZsjgfo=;
 b=F3vE14dwaRKqxdZMFgDn12E1zPjMf9wkal4Uh0WDsSlHpJ6UT5D4Ocx3HDVc8u8vGZ
 MidMDXBYinYNHIhPSae+kkBWJCywyYQNO2ktMNjeWhNLgFOMusg1u+OFYkrzM6LljcrA
 w4Ink3kON6YwXbntKFM5/7JXbkEOkjP1yq+ZpHkSsLlMhH/gnJVEf0kqJfCR5Jrq1Ujt
 4AbT5zjsoJMcFB40ePMOp2QvAdcxl4c0ATKfcm65LHfAWKiKyOw/d8I7leBfcmaaGRDm
 ACfb3LCIfky6XSFvF5zpsXLr2Fk5U2w91sm0jV2asDqdnlDoG9cGCnyWSX6oThVLqr0W
 WnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624145; x=1752228945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xZJfQ5oPTw81l9vGVJcZV3TZMpxgXbDigfZBZsjgfo=;
 b=fSqeO4g2VDitMuS7UONKcfpOdbIyLQUntCduu7HPoa7UtM1AF3iEaQ+6zbiq53SYAv
 yetl6kXLYWRUtB+794568e0Oazwc+6bQ0zFbBU0rFTHRdsGYU30OVkYjejZ/fZvHP++1
 bqFUJYr7XH6+rODLe5puykDb940Dxd115bkLHCr6PFmTLEHZFgU4Pv3I6Du+zRXFy9ST
 +v8qXxN52QHNvcEFtmg9hiBWF+z3fUTba7pXtW4fQ1hSHhspuibLKNOZOvuvSI4UQgPB
 qnhhnGC0oX8g03/lBdXoVzNV1bgPH7xSZn1D5OO0NcfVjLYYmQy8g7+Gb/XJhQF5JHbL
 OHXA==
X-Gm-Message-State: AOJu0YxPnt1RtKEHxozo0GxL/V7xylhaGS17ei+0U6wFDSGNndrJPMV9
 z4itA+q2nl425Zcm0V83c/+Ky4KWb7lCntV0afYGXAkZlEuCJYE32AjjSbKqfTTQcpEfUMdBu1k
 zyLM7Tss=
X-Gm-Gg: ASbGncs8gRhABLeMb2Yi05Shi0pRuVGK7Ih3wpsbVZIiZ4ISXZB0wrlvsuAk1CeDPhA
 zMewsBEcWFZaztY/uYEu+HrO8vE0PdDdF4T8qcmgkE6zy3zvYsV8n8DBrKLaCUiCaZj9Qrf8Edu
 z7nfzOm5aceZbYszFVfYhWjU5Q2ZRR5kUYxmZqlW4PYqvko94K6wu9SHVqkCTwgxBzQNHU+EX5+
 QNHnvM4QYAA7Y7MKv2GibpK6Q7JCGe5psP6J8pcdAL1Su03hths2duezI31AptoWvYCUChNQ5Rc
 JWh6UXd7GZ2wye7UL2TLD0IT12ZbwR0iYw92MtjAAneI3R5JXBhQsD5upMLrHJIddRdPs1iJF0w
 kdqxIWH8xZxt3+MWjxCaRyC1xickSzHNVZP0z
X-Google-Smtp-Source: AGHT+IGm8JHB0uskDnoY6TIEdksArRwhsyBIJOEYEhT4KXnuScfKWQWS57TfBx8+ske6NP+Dm2Tatw==
X-Received: by 2002:a05:600c:3e1a:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-454b3187c08mr24112365e9.30.1751624145409; 
 Fri, 04 Jul 2025 03:15:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0ae0sm2143688f8f.33.2025.07.04.03.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] accel/kvm: Remove kvm_cpu_synchronize_state() stub
Date: Fri,  4 Jul 2025 12:14:16 +0200
Message-ID: <20250704101433.8813-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-22-philmd@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


