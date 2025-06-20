Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72096C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbVH-0006QI-5s; Fri, 20 Jun 2025 09:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUq-0006Ad-1D
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUo-0004zj-H4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso21175135e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424968; x=1751029768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ho90gmr9LBnf0X5r6n+/qD5b6A/rnGinNhmNB6fBLQ=;
 b=h5W6ZV+jJfjqLfkZoqArgbiag5+e5R0LmITY2mykPJJlfJVlhFuNlJjGm1lBrl+x6M
 StKuwhG+0oOvrvcoMq+qroCshLhH6u58I1UgscJeh4oInrrqCpZvFBAW9WaLBbMt459N
 04Kh8Nao+O4zo82EqGb3DyW6H7JCvb1kkY9ndi1GNR5pXc4VYEKbwDF35HALDOlM0vxn
 jKvm5F8hfQuRU89RYmPVlV3qow0+cbieyLLQ4bV9dg1tV2g87WfVPGpycqR69mUNtuu6
 DBd7p2iefuBvw31hLaXHnWn+5bn+6mib57eAVWlBV4wn4CQIpql5w4Zg0AewcAmOvPku
 uEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424968; x=1751029768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ho90gmr9LBnf0X5r6n+/qD5b6A/rnGinNhmNB6fBLQ=;
 b=q9cDXQrNPlDL+3qX4dIM1lXDSM8vckQPWJFybQ3K/DhFPlU1UBYP0jx+Q4dbCux4/c
 +TzAtHW6fiT4lT8Xy4J7aM+ndgT90UxHeS/QYwoLe1WVug0gHa3cjRJbFaMYnN/1lU7J
 /voTU7ZLcbj0rElg9pbbRFpNllS0VrNTGIGWAwx3kAuv9H8yF7/dYPxfR3TX9LikFV/4
 1ZLaTRLUbLdZAvWNE98LiGBkutSRwT9ZL7hhb4+2MuICjBdvJh0xAQ8nNErBXEZIMrUr
 SM8Ozda+6bAfX8FaUsXzJbLfDS8F4WB/G62Qt3fwnDDnV/9I4t3KVHseqYp5oH/c6wyG
 hQag==
X-Gm-Message-State: AOJu0YyP9krknuXuFZzLNsid5hor1Ssf2wT69Dox0eN49V2aUqjmhgSA
 CqpbxHBTUsBod4sTf88DAQYtLvw0y74pM7ivf7kTcnEz0q5dMUU7w0Fac1mW6pX8Vg//tiepI+d
 y0JmPH7I=
X-Gm-Gg: ASbGncshav3ygEclwQujY6aXatAVcFN5dN/GI8fPhqKh7M15P7LNwSV/A4nVTzSEktL
 3hkhO9JUnnOyXFMrSvFU64gqKF/+Lff5SgUQsjfB6+bb64SOp4IgROFAUD39XX3eAZZEl+6M8ZY
 lnSpdd0PC8jqQLoXC19YRaawK6tx/+3LkKld5HPMkmH1uswXhmAjep8HbEhtgQMbNZK0GUDaJGQ
 GYK4adYXb2JAqydbiNNupNPAu0E5hJNYWKQejLr7Kr0laFskNqTXp9RUyorsTuK3iauCf/lsHhb
 JN0/3ap5NL/5u0K+/k0x/dlb9/ip+VkrR8AUTcP5v+WqrRZQtyBR0jQiiLjJM+HdCTWJzxaByRn
 wFuJ7gjtVPXXqJ1YyfKbfH9ohUqgSRU1FdqZy
X-Google-Smtp-Source: AGHT+IGF8bB+qSx4ZvZXQLjUAOyAVozgjbRUMGz4uRoQ08Z1w2S6A2LTzrO9vB7Kb0AUvy301GjaBg==
X-Received: by 2002:a05:600c:4747:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-453659c0a51mr22550685e9.13.1750424968380; 
 Fri, 20 Jun 2025 06:09:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190c9asm2073452f8f.93.2025.06.20.06.09.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 24/26] tests/functional: Require TCG to run Aarch64
 imx8mp-evk test
Date: Fri, 20 Jun 2025 15:07:07 +0200
Message-ID: <20250620130709.31073-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The imx8mp-evk machine is only built when TCG is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_imx8mp_evk.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
index 638bf9e1310..99ddcdef835 100755
--- a/tests/functional/test_aarch64_imx8mp_evk.py
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -49,6 +49,7 @@ def setUp(self):
                      self.DTB_OFFSET, self.DTB_SIZE)
 
     def test_aarch64_imx8mp_evk_usdhc(self):
+        self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
         self.vm.add_args('-m', '2G',
-- 
2.49.0


