Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C70CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtmc-0005ip-Tn; Thu, 23 Oct 2025 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmQ-0005Au-UO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:46:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmL-00020F-0Q
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:46:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-427084a641aso515081f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220005; x=1761824805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSq0w+2pMt9GZjD8Tq18/wVUPKd35IM8rk6GrG4O1u0=;
 b=M5OrheG8bws6f1OSmtqkFBRYAsSQg46Q0OMpbBcUx560qeBaAIFiUR1KJBz8RdEE+t
 pNDVzhyoIQRZyXkcUlXRb71zdwaXs0H7jnvGDQSptXusjgkmuw8AZC8iJ068YTqQnFmV
 88oMSYSKe0fD5BPYlqUpQHrJAhl93FcX2RmkBcsWkJzkqWwIm6KtFm6O9D4V4m3CTUxq
 sZfU6YqV+KaHFYOMKCGLSNXSriABATgaGmVWIWmnj98QgxGt6Rlm1Wd2vgBQd+Burq3h
 5AdKdTt0Q4l0AyH6lcXRy+rh3kNwmSCkZsTDXmreUUQwQ81vUmWrZXz41B1VVh9YdT/j
 a/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220005; x=1761824805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSq0w+2pMt9GZjD8Tq18/wVUPKd35IM8rk6GrG4O1u0=;
 b=ZPD/O023VQKUe9zmuO6uuq7/0+XETzHz18+pEfjY+DH47N9nObwLgn4IcqGvWyCGUi
 LMq072qynYoQVYcbTD6Znu9LnfyH7KTk65dglQgQDujJO+tr4bTYdmze9hKdOnOZS3C0
 ziUuBb16KNE1t4fJKkvfFsi8oM9zO/oPE10lmD4UffzD75N/QtNDcSKYdRLkuWp+YiGV
 E/PVQ7Ge3fvU3+5wXNS6GEazadGLDHryG1r+A78A2R+zfK0iAwhLSaUS39nCup134V5n
 JOu8o+8WgP7+yM998RbWdI+aVMiSXNr3qjKz6sTx1hYjj63aAa1SfNYshJOVYgPZHGNH
 he2Q==
X-Gm-Message-State: AOJu0Yzl+arke38KywOqLRU38TLe6mHKt02s6VaJVanQ5kPug1zVOr3z
 XsQxJ3mBCNutmJ/QjjinCMkg1hT2p+wC5hwnGxOQXLXPr2lryey3mSdRzVxER9MpVVx0c19U+Md
 CR0+VHUY=
X-Gm-Gg: ASbGncv1PAiiHiSQ08Zsc6tVRtrVRDmxhFWGxRdFcknxiFDCNT/7zKYLETe82/jgGsV
 9dDUK6wCED+4drg84cVcaorxF9mR7DBIOuV6wAPjh8f6uSt239I2fOmMKl/kxp8IsjargjBZ7Yt
 vnohPvBf8ka+a25Senhns6Jvu2wHT2V7Y6fwYGpC0YpoTDxeF6S/FJBbseeA2v735tfYxhxBEIw
 9WU0uv6q1iP7lzSeWVZ9MNTzRk4isazWL6O68n9vyk7TIZupzCgsXCfBagW5iZ7PT0HjT5MA3iE
 jH1qLASt5mzMBttOxK+iqfiAeiVbCmMHHlpqCuX0kJPXoJTp+vgx9gxKVrHOTbMdmrwA71UACAD
 cwjW8IRN4mXtKMJXP8JY1U3/7JAU1uehk15mi1xEqHJU/tpCs6YqQMmEngWvbjFdk8epJWjj397
 I6Voo+2zH1APtCegjCx5hxpdkHGUEuflPbudIFDoDhs3c2Jv8U4esCV3eoipaT
X-Google-Smtp-Source: AGHT+IEZJyvFhuzGIGZJv++6f9eKF8rmESmx53xFLanbExoNENsrukszXTt5kxcX5eY4EbxwyP7o/g==
X-Received: by 2002:a05:6000:4024:b0:3e9:a1cb:ea8f with SMTP id
 ffacd0b85a97d-42704da3924mr17359817f8f.52.1761220005491; 
 Thu, 23 Oct 2025 04:46:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ee8a9sm3509866f8f.46.2025.10.23.04.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:46:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 01/58] target/arm/hvf: Release memory allocated by
 hv_vcpu_config_create()
Date: Thu, 23 Oct 2025 13:45:38 +0200
Message-ID: <20251023114638.5667-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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

hv_vcpu_config_create() is documented in <Hypervisor/hv_vcpu_config.h>
as:

  /*!
   @abstract Creates a vcpu configuration object.
   @result A new vcpu configuration object. This should be released with os_release when no longer used.
   */
  OS_OBJECT_RETURNS_RETAINED OS_WARN_RESULT
  hv_vcpu_config_t hv_vcpu_config_create(void);

Release the memory allocated by hv_vcpu_config_create() with
os_release().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d1..83db1088384 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,6 +150,8 @@ void hvf_arm_init_debug(void)
     max_hw_wps = hvf_arm_num_wrps(config);
     hw_watchpoints =
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
+
+    os_release(config);
 }
 
 #define SYSREG_OP0_SHIFT      20
-- 
2.51.0


