Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A980C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh69Q-0001Vc-KX; Thu, 22 Aug 2024 07:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh69M-0001UZ-TC
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:38:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh69K-0005Yn-Fz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:38:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so5210935e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724326716; x=1724931516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKoonnN54/9hQBKTTocCEj1szudt264Kdo7sCA5zYAw=;
 b=MHnVEf5nojwyZMTCMsLn52nMYlrubrTinYfce+9ruuJbVnb4qU2R14BZbTRosynVTu
 ikwrNOVU8MvgLuCoWWNy0TpkUjLc3LpnKRcjpiNwFXKXf62HnXHp65cL01IoD2r1r9qq
 zJlly21liOWmX+mHZ+3G1iyW8kcP7ttzPkofPwmYP+G1ISTmCsr9wOHeMANY75u1SI2m
 GBRkGelAbKPQliaUg3nUHvzMO1lE9EDqGMSR9dMAxWcGTOsIF5mqsAHayj26JVHIBQTE
 d64/JGPWsiF6//DtOlf8y2OKq2SaiQG/MNhzW5V8XSWSeq9tqmMG+XhiMPAQI/h1Dp4R
 rOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724326716; x=1724931516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKoonnN54/9hQBKTTocCEj1szudt264Kdo7sCA5zYAw=;
 b=oSjNpCgeKKgQwAxasM9VZLl1jpYyToEvu07bbEZvfbMgOuRjY/PTqhFkFumD0GDElx
 qk2P/Mud349bg5qt9E223ihwgDrEfIMEHfEXv/g0iC8F5YRTi9SO1+hAVmv31ZfWXJop
 ZncWu1aD4FPga/ALCuiZ2HdFHmGEOZlhXn0BQPdmwCOd9NWLZNrtbFOH+RIr+70g/870
 HeZ1W/ODbBLvZLDRKAdtQtaAI2v8sL0bQWUGvgMofdAA5ba3Hrkufj0ISCuKiQpClRmB
 8N34M/onvedT2pyPDWmPKOGehAxbdnXtJaT/cLUNqB9MtZyBnVA6T/8IkwisBIF0C5D0
 15UQ==
X-Gm-Message-State: AOJu0Yzm2wxDsAVaH/h13AC/qfE1hpf2+Pac4nkWNTye5FzDaUZUZ+ye
 ZyncGsnX3YFmwAwz1Q1Tremd/skNG/3qjF6BxhPt72/OMCo00s0p6Q+lJwpYEeqSjB/BvhQR0YM
 R
X-Google-Smtp-Source: AGHT+IG/JWpfIKpvxSX66RzgYMowfqWjyQmSv4BzdvQi8IsqAFAaXwRK6x8W+SQanbhPVLDrhOMmQg==
X-Received: by 2002:a05:600c:1d18:b0:428:387:79ac with SMTP id
 5b1f17b1804b1-42abd1120ecmr38758535e9.6.1724326716165; 
 Thu, 22 Aug 2024 04:38:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e088sm22379575e9.8.2024.08.22.04.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 04:38:35 -0700 (PDT)
Message-ID: <57e94d73-66fc-48d1-aceb-6f4f2d888813@linaro.org>
Date: Thu, 22 Aug 2024 13:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert Aarch64 SBSA-Ref avocado tests
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240822113629.86618-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240822113629.86618-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/24 13:36, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Since SBSA_FLASH files are not
> tarballs, use lzma_uncompress() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20240821082748.65853-1-thuth@redhat.com>
> ---
>   MAINTAINERS                                   |   2 +-
>   tests/functional/meson.build                  |   5 +
>   .../test_aarch64_sbsaref.py}                  | 135 ++++++------------
>   3 files changed, 53 insertions(+), 89 deletions(-)
>   rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (58%)
>   mode change 100644 => 100755

Forgot to squash:

-- >8 --
diff --git a/tests/functional/test_aarch64_sbsaref.py 
b/tests/functional/test_aarch64_sbsaref.py
index 5f9a5f7e37..a72add393a 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -78,5 +78,2 @@ def fetch_firmware(self):
      def test_sbsaref_edk2_firmware(self):
-        """
-        :avocado: tags=cpu:cortex-a57
-        """

@@ -145,6 +142,2 @@ def test_sbsaref_alpine_linux_max_pauth_impdef(self):
      def test_sbsaref_alpine_linux_max(self):
-        """
-        :avocado: tags=cpu:max
-        :avocado: tags=os:linux
-        """
          self.boot_alpine_linux("max")
---

