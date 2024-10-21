Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C7CD3C53F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 06:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lUA-0003HW-Hy; Mon, 21 Oct 2024 02:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2lU3-0003DH-Iu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2lTz-0005gX-Mm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729490494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n9FGRL7g4a5XoyEQL8rvQTjKEocxsLblIQiJB9fxyIU=;
 b=OLY+m8O0II/s/gU9sWYhcQMeUkg5pXJiW25ZrUugc0yYqs/L8q77olgonNZMV/cowAzoTA
 pH/HOyV3aBuTlRGs/GODTWOeJOHd6x5zY7qTwnkwHFIYnNgAaTp/aOQLCZNkVuN0CS5rD6
 hpIm2F0EL3UCzAHn+VY6Rs+7dOpCRW8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-mRSPE9iYPEWKkZ58MvEK1g-1; Mon, 21 Oct 2024 02:01:32 -0400
X-MC-Unique: mRSPE9iYPEWKkZ58MvEK1g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159c07193so35612345e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 23:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729490491; x=1730095291;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n9FGRL7g4a5XoyEQL8rvQTjKEocxsLblIQiJB9fxyIU=;
 b=UJ+TyqsAWH6Y993cSc9U2WuPJ2fSf2AcWsYOxqsZTbIrQQV42S/v0ivSIedeHhuHxP
 DfWsZ2ee4BHtJubBlYT5EXjHjGwu1HWoKK0w2R+fBJB3Sfw935rwl/MVa/OkMK+1Tofs
 UgrtsRdWWusBEReyvHDN1p6I7VLMpfVfAZCGxDpdCM/NlTWSBwSy13/uI2Cq+jb3mW4j
 K2ObSxq5SpLvwnFkC/o2egi/uIqQQePoJXs03FzLWMOagNT/naehM3o5dbKiDTKdN/e9
 hAgPsMzf/QBBqRkDx/r0OtQL+C38CKVj7jacwGAp8CFMTNBE5LVnlp958farzRG/cdr8
 raZQ==
X-Gm-Message-State: AOJu0Yz4tXnalEUCJbk8AZbiflNbCBm/VkmNzXOkFRmKf62SkIYuRoCv
 lvvw8w5Omfxz4fgbSKvGbO797IZDPLKFrNa9VuGQ9OePklYBuAsOV8RyY+4/xC0SxpinS7Rclor
 1KWMCwtCaJyJmXQ2ER6+fB9WHI6qKWt0NsUR8yMr/c/68zMU7u8NAoKhpgbtFssrNQ9/LGv+Swk
 0nTfm7Qa0HNm/uMeIqw0iiO8omAQ9DmJ+90fY=
X-Received: by 2002:adf:f9d0:0:b0:37c:cfa4:d998 with SMTP id
 ffacd0b85a97d-37eb4768898mr8690023f8f.49.1729490491057; 
 Sun, 20 Oct 2024 23:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlNh9if4DVz6QcYI8n4+nT2yi5Pjq5ziOJVAhq8OR90U1543vgQZi44uXLKNHyXVCIntuO5w==
X-Received: by 2002:adf:f9d0:0:b0:37c:cfa4:d998 with SMTP id
 ffacd0b85a97d-37eb4768898mr8689990f8f.49.1729490490693; 
 Sun, 20 Oct 2024 23:01:30 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bd6esm3356912f8f.104.2024.10.20.23.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 23:01:30 -0700 (PDT)
Message-ID: <75745c15-feed-45e8-9ba4-93ab103fd832@redhat.com>
Date: Mon, 21 Oct 2024 08:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] Convert the Avocado tuxrun tests into new
 functional tests
To: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-arm@nongnu.org
References: <20241011131937.377223-1-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241011131937.377223-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/10/2024 15.19, Thomas Huth wrote:
> This patch series converts the tests/avocado/tuxrun_baselines.py
> to the new functional test framework. While converting the sh4 test,
> I noticed that the Avocado test was completely broken, so I included
> a fix (revert) for that problem in this series, too.
> 
> Thomas Huth (17):
>    tests/functional: Add a base class for the TuxRun tests
>    tests/functional: Convert the Avocado ppc64 tuxrun tests
>    tests/functional: Convert the Avocado aarch64 tuxrun tests
>    tests/functional: Convert the Avocado sparc64 tuxrun test
>    tests/functional: Convert the Avocado s390x tuxrun test
>    tests/functional: Convert the Avocado arm tuxrun tests
>    tests/functional: Convert the Avocado riscv32 tuxrun tests
>    tests/functional: Convert the Avocado riscv64 tuxrun tests
>    tests/functional: Convert the Avocado i386 tuxrun test
>    tests/functional: Convert the Avocado x86_64 tuxrun test
>    tests/functional: Convert the Avocado mips tuxrun test
>    tests/functional: Convert the Avocado mipsel tuxrun test
>    tests/functional: Convert the Avocado mips64 tuxrun test
>    tests/functional: Convert the Avocado mips64el tuxrun test
>    tests/functional: Convert the Avocado ppc32 tuxrun test
>    Revert "hw/sh4/r2d: Realize IDE controller before accessing it"
>    tests/functional: Convert the Avocado sh4 tuxrun test
> 
>   MAINTAINERS                              |   4 +-
>   hw/sh4/r2d.c                             |   2 +-
>   tests/avocado/tuxrun_baselines.py        | 620 -----------------------
>   tests/functional/meson.build             |  28 +
>   tests/functional/qemu_test/tuxruntest.py | 158 ++++++
>   tests/functional/test_aarch64_tuxrun.py  |  50 ++
>   tests/functional/test_arm_tuxrun.py      |  70 +++
>   tests/functional/test_i386_tuxrun.py     |  35 ++
>   tests/functional/test_mips64_tuxrun.py   |  35 ++
>   tests/functional/test_mips64el_tuxrun.py |  35 ++
>   tests/functional/test_mips_tuxrun.py     |  36 ++
>   tests/functional/test_mipsel_tuxrun.py   |  36 ++
>   tests/functional/test_ppc64_tuxrun.py    | 110 ++++
>   tests/functional/test_ppc_tuxrun.py      |  35 ++
>   tests/functional/test_riscv32_tuxrun.py  |  38 ++
>   tests/functional/test_riscv64_tuxrun.py  |  38 ++
>   tests/functional/test_s390x_tuxrun.py    |  34 ++
>   tests/functional/test_sh4_tuxrun.py      |  57 +++
>   tests/functional/test_sparc64_tuxrun.py  |  34 ++
>   tests/functional/test_x86_64_tuxrun.py   |  36 ++
>   20 files changed, 869 insertions(+), 622 deletions(-)
>   delete mode 100644 tests/avocado/tuxrun_baselines.py
>   create mode 100644 tests/functional/qemu_test/tuxruntest.py
>   create mode 100755 tests/functional/test_aarch64_tuxrun.py
>   create mode 100755 tests/functional/test_arm_tuxrun.py
>   create mode 100755 tests/functional/test_i386_tuxrun.py
>   create mode 100755 tests/functional/test_mips64_tuxrun.py
>   create mode 100755 tests/functional/test_mips64el_tuxrun.py
>   create mode 100755 tests/functional/test_mips_tuxrun.py
>   create mode 100755 tests/functional/test_mipsel_tuxrun.py
>   create mode 100755 tests/functional/test_ppc64_tuxrun.py
>   create mode 100755 tests/functional/test_ppc_tuxrun.py
>   create mode 100755 tests/functional/test_riscv32_tuxrun.py
>   create mode 100755 tests/functional/test_riscv64_tuxrun.py
>   create mode 100755 tests/functional/test_s390x_tuxrun.py
>   create mode 100755 tests/functional/test_sh4_tuxrun.py
>   create mode 100755 tests/functional/test_sparc64_tuxrun.py
>   create mode 100755 tests/functional/test_x86_64_tuxrun.py

Ok, if there are no objections, I'll include this patch series in my next 
pull request, with this small fix squashed into the final patch:

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4071,7 +4071,8 @@ F: scripts/ci/
  F: tests/docker/
  F: tests/vm/
  F: tests/lcitool/
-F: tests/avocado/tuxrun_baselines.py
+F: tests/functional/qemu_test/tuxruntest.py
+F: tests/functional/test_*_tuxrun.py
  F: scripts/archive-source.sh
  F: docs/devel/testing.rst
  W: https://gitlab.com/qemu-project/qemu/pipelines

  Thomas


