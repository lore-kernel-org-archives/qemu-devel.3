Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D24C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklYl-0004Ro-H2; Wed, 19 Feb 2025 10:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYe-0004Mh-0C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:16 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tklYa-00012r-O8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:00:15 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb81285d33so777146866b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739977210; x=1740582010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NhPwQWl1F3AYtyAk+KL0Iy7zvZuOpHSL/Vd4WwluoCc=;
 b=lRcNRSVA/wMllesOLPnltP8GUFbkSD+8EragE3qwzFm0LN/eeD0+1ovuaO/v8rnT+J
 g/qQrX4FLumvZsgRIxuc9JTg86DZm8DM9Vv6paTLhdJhY9zGHaRItW8nKfhcqKBoXUgQ
 xuTzTxrZwLIHR3z1hYXVRLzsgr7m2rRwfN6S9p6uZ8LOOiFvhddk5ZUAt9vErX/NtcQs
 GvXOlXe7PmNmiku26/AbDcpDJePmXuXPH/V5mtmqpIP7gUb+RHlK2gMLbcDJV0OZZ4we
 9+W5zboIxxpH3ejZ9dFykYhOkq3J2S3G37f0w0oZPnAQFc+hMcriR8tM4Ki76Zm11mYA
 7q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977210; x=1740582010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhPwQWl1F3AYtyAk+KL0Iy7zvZuOpHSL/Vd4WwluoCc=;
 b=LY460qjt6prZwe1BpGSl542na3RUVDWwjLR4GwUVfPEDvXcL/7i0Ow8CaiDs/XQ5rZ
 G56T7LrwbA9bZ+E0/Wm5gMtIqdUrknyJi2AXyaGOAxqJtR7dj+ifM6gdAwdndD8eUi14
 D//ohAf8bqQ52QNpAI7UXgGXIIhQluMlFvTzkPvzAQn2AW8swN1T2TKsP59xaTg6Pp9l
 Q9WqquGfhH3+m6OwhkUz7XI9RaulF1ZRUZDWectDEXmhyNSRpSXWPub0wXxnEBnAAahq
 EsbMlI8anEFm1mIDeB2Lr05D2vEkDqRahjaZwAkYrlUo317O4zrUAM3tkoV5WMhg0/T0
 6FUg==
X-Gm-Message-State: AOJu0Yz9akv4TSuyXGpBNqYe5wEqGBDFJ6hpCx3yEo5b5FGevMNIucgF
 5gt2NNX/fKwcHwVk3g8zPhtDn1BOIu5RKkODp5RwxngUrl7UPSpKx1YW5ICJSYg=
X-Gm-Gg: ASbGncvoOZgZzYqDibdzq4vZkej+lsli77vyAG3D911niUMszPJQm0vU0NIz70pXSPi
 4g/WGXHgAZkR144fhIy7/tNvdFVcLcBLfRz/gTWCYyWkqwMWd0xs+F/eW83TD7695sKwZcvZ4el
 qTiDpq97ZOhZwN8fFFc/hveqxkxgOvf3gklYfl2mCeLo1BdFemUwnDtU9Xm3kV8UjSOxOZ2iMj/
 hNC5VgUsDxVneGVIDcR3jezpHiiG860wljHuvvCkOQ0Z4KUKT9EG0Thk2/9YhgbonjaiYQbc4P6
 JSqpEpXtYpXFCgYUQA==
X-Google-Smtp-Source: AGHT+IEFcoqFJ+xKGZEitK5z+Ivdsl69Wv1jK7KKl+FYZ/lTZaaNDwpG1djWKeJWS7kE58+Uu5T1RA==
X-Received: by 2002:a17:906:4794:b0:ab7:cccb:ae2b with SMTP id
 a640c23a62f3a-abb70a7b7f4mr2106860066b.4.1739977210425; 
 Wed, 19 Feb 2025 07:00:10 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba316dc67sm530082666b.43.2025.02.19.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:00:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DFFB5F760;
 Wed, 19 Feb 2025 15:00:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] testing/next (aarch64 virt gpu tests)
Date: Wed, 19 Feb 2025 15:00:05 +0000
Message-Id: <20250219150009.1662688-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

As I was looking at the native context patches I realised our existing
GPU testing is a little sparse. I took the opportunity to split the
test from the main virt test and then extend it to exercise the 3
current display modes (virgl, virgl+blobs, vulkan).

I've added some additional validation to ensure we have the devices we
expect before we start. It doesn't currently address the reported
clang issues but hopefully it will help narrow down what fails and
what works.

Once I've built some new buildroot images I'll re-spin with a while
bunch of additional test binaries available.

Alex.

Alex Bennée (4):
  tests/functional: move aarch64 GPU test into own file
  tests/functional: factor out common code in gpu test
  tests/functional: ensure we have a GPU device for tests
  tests/functional: expand tests to cover virgl

 tests/functional/meson.build              |   2 +
 tests/functional/test_aarch64_virt.py     |  71 -------------
 tests/functional/test_aarch64_virt_gpu.py | 123 ++++++++++++++++++++++
 3 files changed, 125 insertions(+), 71 deletions(-)
 create mode 100755 tests/functional/test_aarch64_virt_gpu.py

-- 
2.39.5


