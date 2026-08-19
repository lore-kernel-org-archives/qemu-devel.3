Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0398C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcV6-0007nt-QE; Wed, 19 Aug 2026 05:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV2-0007jN-Tp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV0-0001vQ-LM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47de008b020so414691f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787131337; x=1787736137; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hI/4kRcuHe18/qYKP2hOGxNnKh8pw1N2QjNp4C1E0DY=;
 b=FQSgU+cDLAKAcGNPMHLGaFESsgjpW4+TcamG5+OvErnb3xZEeaTSZWQcMiktv8+X1L
 aiI5fgoyrSzUUytxnBF1Xjfrv8o54wxov69/L0tbl8YfDsmg/63Cn4wwHF0Ndfiq5dza
 bPultDunMMqGoxYHH6mNzDGKcPIRpRV7lOiWyIjHHO/EGOh8jFnlI7L7h/0gBvwhi9R3
 1YVq7Nqj7HZhFxysQtly0EPlwi0gXWnmdlFxcxqLFhVGI4vDQQtorMg+RbmKbHjSEOMo
 bs8flewC0jHb7/Nr8okrTA2UrydwLJw3NWgX96RubAHx7LSATMFVaKFn05E7tR+H8ipi
 9cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131337; x=1787736137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hI/4kRcuHe18/qYKP2hOGxNnKh8pw1N2QjNp4C1E0DY=;
 b=IAsktH2vHGEHE1IWGDCi4S4kOtInhlV4aXaeKNiOkNNGwDeKwHBhVBbANwB1VKMVwK
 XqKhy+mO5coXGbdDOVa9oeSqHA/k0LQt0wOALYa4H4KyMq4gETrkBnIi35nIJhPrsxkg
 tgGjtwmBvaNUE3IZo8aMhdcUv5l7mopm8StW01lYUNQDdwFvNUDVksgytbjvpVlGvzyS
 063FAQAjYc6AUPYqR1Ei4r4U/nR/esQw2WmEIaW8Qm7NQMij6WTrbZlat4exHckyq0n3
 uTTY+htL2jlTiJGcvr2xg0N8XKImBrZl8WexhDOOXLctDvbnXCXwVSml+u7LsrbsxqS6
 Brzg==
X-Gm-Message-State: AOJu0YzhCmIP2i4RQnITWjeBt8NwpvWQ3WXC1TtffLVr/scBmNKPml6Q
 OryKdNL7AvhB6JB0yBPb5e6ZYjcrmQmxyX/CjYy2Bi0hXwbRy2oHWYpIhK6zRjf8CUQ=
X-Gm-Gg: AR+sD112vnu5d3KefFd0thH9pyqWoFsU/Fg2pQikkyGOh2wd4WYcNuZ+SVHKXeQE5nw
 Ge/sbqQKvzl5FwEAuGEYztgYBM+bGVvtBtxq61IGOf+kzM0/UbOTXrD4o9IrIf4KELX1CdNrG1b
 SeoyUTYiRRDfY+jpZQaWWdu4LA+R+XMnItuVbr5fiL4MvAa3I9Vn9aFTMCLY7mwSX7o/IW/2HSr
 JEudOA5oXQI0DWpAdR/1coiykXa46BBIh9LVgPec85ochNL5V8TynH/K5zDXAszOu3zhGby6lKV
 OOqCIUIAWtyoGH9pIkk4lgdPzVZcM78TA+D2d/X5L0X2Twji29CgT50p2S2cykAlYTsQStB+Se1
 k/ZzsQOAlc5kJ7hmbKL2nM/LEI21W7wAPvHcCOJMS7kC/evh5UJvPY0TzqtAqoYY/kZtQWr3PbA
 Zb9nUX6yO9Mff0c7VNTIJi6qsrnbPGvJax6RCGKDBtzaSIvZUqxyf6hgCbR5it/DSUQ327XI7/
X-Received: by 2002:a05:6000:4285:b0:481:314b:b041 with SMTP id
 ffacd0b85a97d-482b1066a6fmr5516939f8f.7.1787131336957; 
 Wed, 19 Aug 2026 02:22:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145d31bsm4447265f8f.16.2026.08.19.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:22:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61A7E5F82D;
 Wed, 19 Aug 2026 10:22:14 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 19 Aug 2026 10:22:01 +0100
Subject: [PATCH 1/6] gitlab: use .base_meson_job_template for macOS jobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-fixes-for-11-2-v1-1-b7981c2cc371@linaro.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
In-Reply-To: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=alex.bennee@linaro.org; 
 h=from:subject:message-id;
 bh=oLQW1QjvvZodHpTsPvGLeM5B3yePRIAQ/JBnkvtdcNQ=; 
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqhXXFqP6RI8y5GJAeGX56erSFzv9sCgzfILmz0
 jmFwC2A+iWJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoV1xQAKCRD70NsJWp4q
 RD3YB/4rMr73ZG79e/v4epC1W29loewTMHg5hEvwFFt17neUi6k9Ul5yZXMsGKtOP8MLpd4kneA
 zA7zyxvdnIwtO7VE58tRhZxL9EmSv0/98az/980b2qJjbi/7cDDK6s4aE353G/4M/iOGGf7wO7h
 KBqE19f3cWZ9iM73xW3e7ZEFHIeNfrNuXFCA0WrgAQ5BSjYq2bN4sNtB1NoYF+BUOHDjARjmXa+
 SbadvOXXb9CBHS4TmaTEYUW2W0W8k5JTqNjUPXvg6kcLj/mSSR5Hu0swDxpHWnGBbossZ9Oxs5i
 0zcfR+NuiUAApd4XCmY/HsZ5TSrNYoLaC62dfMXFxyJyQ1mh
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

This way we'll get more environmental information which will help with
debugging.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260723200904.224413-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 641a48b3832..bdb3eae18f0 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -1,5 +1,5 @@
 .macos_job_template:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   tags:
     - saas-macos-large-m2pro

-- 
2.47.3


