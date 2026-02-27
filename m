Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD25FEFB53
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyLm-0006B3-A8; Fri, 27 Feb 2026 08:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLf-00069V-Vz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLc-0007U5-Lw
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48372efa020so16882325e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200658; x=1772805458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a9KECWfOOF9H4e152rcyPrGP114oax4qvSfriKZp0L4=;
 b=ruPzxQnScV+FZHe2TTt0FQOHrqSp1MLAOXphWzIc/YVtPkgheGsDLzKQ/ml/JjbjmW
 2Z1E0Yg67urcOsn07CYmUXI7IQ7+jMRpxRw4pfu1YAAoofavkcOyLM0HDm2LqD+H3nbt
 F+Urvoy3cxF79P7T0yxNav+o+f1TkxmbhG+i7je8RsFzyrH5F8b26f3xxRTOpcrKUE9c
 OtQ/L5I9zssY6hrt3UBEyfgib/COuxGFwfVKhbDNMGzcPUTv0kw0nlj7IHWRvEeery5e
 Dy5R+5IGbmcuflDqaOsXloWtcdSDwSyelmtssCAR81t2uN4uzX5pEXzRPPxgKyBe9Jqt
 MPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200658; x=1772805458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9KECWfOOF9H4e152rcyPrGP114oax4qvSfriKZp0L4=;
 b=r9BHj23djJZpiRnIMvkywREHr6MFzFFkuZl+768h1ghf2GCWBj6Fax59FLyXvu53m6
 RO1zt4F+ZtNvgY/OGBg22uYI5n7n74QIYbvbkleptga8HzHxOz1lb70+YxbDo7jnWKdI
 ThGhc79an4r84VCepyFtVtoaIkxIpmLSZKEsH37JrqzXMlqqpN+qThxwPqfMHQSjEq8i
 oZEZKuU4fh6FCzmE0EwWgJ9yMtAPToVNV7HXJ15sFdWRhtEpx+FEV7eo5qlOEV8Z1f6i
 JPcjs/FjN0hMCpC557HcRyXsfYuHlKWxsohonl0eUQrJBk1mm91CKDqPcYSy6McvWTF5
 vAOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0GaWUEXs0EEHBLPtnK6VWkkQfw+bezUNUET/PI6XCU/sHQ3QbKJ+/iCeOXu+aEV+sV1RHmFdW5luy@nongnu.org
X-Gm-Message-State: AOJu0Yyfa/RcvSd6q6P3Wtz6kifpaPjdcWMEDIBACwU3kI7JNVCsXBq6
 2uqyvnijOTHsKQfX0xv/kZFPRYyGi1s9LHhu1Wddy7363PE6qPczicp2A8f8vX4sUSA=
X-Gm-Gg: ATEYQzysD80dNvB33nXcWO8n/UQUTcQ4ffy+mYGr20wQBbEGZhx0bQgZ09e4Elz0HYR
 LDxa59xKdnhHVCOsmzA9xQG3IzhphEFa9ZroSutunFB5lF6JMasovHHuR59y1vZx13Ts5j+dDAB
 GyUNazHiPFJKklBx46dwwvHBSTIGU1MEM64cIFMLHZSOMJJHA8uuYKYCUk1zMVh5heyz7Oowt3s
 dEdScOBt+X1ScqRhBBeUb7M6pfVk/HVTvT1vk897pVSMLrYNsp9DRj2fUjqNeCVZDd3EgkkERGW
 IWGxP1tN+rKE/+b8rWPkL4Tc3KSetVeFA6hBJbadRw71wDT+M4+DoevgRtEt1ijh2P1TPwjQ06Z
 yFFYufasEOE38VA1og9DYUHLo0aDfUY5N3g0BttMIS30XdX2ptiANLw3oDqT6ih1sisyv5S2yf8
 +THaYh8M/KqpMxyRq4IC+eXUTY4ZOI5CuE+Gd8MTbEagbKx3ZaxTOPCxrZXuZhf0NvSoptkxbqU
 DB7bC/0XA1WFFZbfwovLqD6Vvx6gVo=
X-Received: by 2002:a05:600c:c16e:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483c9bbb8d3mr43182785e9.8.1772200657893; 
 Fri, 27 Feb 2026 05:57:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7655163f8f.20.2026.02.27.05.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:57:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/4] arm: Fix some memory leaks
Date: Fri, 27 Feb 2026 13:57:32 +0000
Message-ID: <20260227135736.2280161-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

This patchset fixes a couple of minor memory leaks I found by running
"make check" for the arm targets with the clang leak sanitizer enabled.

The first two patches are necessary because there are a few leaks
that are either not interesting to fix or which are not in our code,
and which otherwise clutter up the logs with failure messages.
We have a suppressions-file already, but it's in the scripts/oss-fuzz
subdirectory, so I move it out as it's more widely useful than that,
and add some more suppression lines to it.

Patches 3 and 4 are the actual leak fixes, which are straightforward.

This gets me what would be a clean run, except that there's something
wrong with the refcounting of qio channel objects in the chardev code,
which results in variously use-after-free, leak, or assertion failures
when running the vhost-user tests in qos-test. I'm still looking at
those, but in the meantime posting this series gives me something to
point at as part of the repro instructions for those errors.

thanks
-- PMM

Peter Maydell (4):
  scripts: Move lsan_suppressions.txt out of oss-fuzz subdir
  scripts/lsan_suppressions.txt: Add more leaks
  hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
  tests/qtest/iommu-smmuv3-test: Free QPCIDevice

 .gitlab-ci.d/buildtest.yml             |  2 +-
 hw/gpio/aspeed_gpio.c                  |  2 +-
 scripts/lsan_suppressions.txt          | 31 ++++++++++++++++++++++++++
 scripts/oss-fuzz/lsan_suppressions.txt |  5 -----
 tests/qtest/iommu-smmuv3-test.c        |  1 +
 5 files changed, 34 insertions(+), 7 deletions(-)
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt

-- 
2.43.0


