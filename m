Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80DEC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYkJ-0006ov-IF; Thu, 01 Aug 2024 12:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYkC-0006jv-U9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:33:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYkB-00034U-0Q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:33:36 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5af51684d52so8137086a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722530013; x=1723134813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cu4Wz0iHkSYgVesZOWF+MNHxKYpOMXeHGu3wWKL/III=;
 b=Y/4BDpHbHcpevN/VAG2lHumk/0k70kscKvt1w/TVBzVj9yk+igdCrt5UQu5c7yqHFp
 o/Zi87XWc16TOsUElmgoRg0nFI3hL0hl+da9dohrRSUdXPNbtdW0HD9jtT3cFhQIRaXd
 oWAJxPZYn1PcEGh6eHkwFOZwg87N32HlPLldoqQQ8WP1rMGMa0iiJaYyZRsUeuvcc0nH
 5jyZj2q+9NbhiGagGFgimqCNpfcjsgH395MljgB+m0+bS8nr9TnVObYqyW6iiYb34oPd
 U53HB+xfJtTvIQ1AynrUdT8aUF2x1vXTNBlBeb6MxgTFhvJ7ed5Tymonb3PDjyz0KjSM
 pDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722530013; x=1723134813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cu4Wz0iHkSYgVesZOWF+MNHxKYpOMXeHGu3wWKL/III=;
 b=gsj9J0vJe6Eo/zEeyypF67su2S/2/3Tpbny/5olgsyMqX1zes1tnecN6K5275hZbRR
 qN6L1jsIPD1kN/S1d0f3jCPoXFeHCFTTMBdw1fclnpEf0KWh2I251PjeS5i/KSR2AJi/
 jUmJlRD0gTmuYfEZHJA1CoZ31vYVNq2I48ogCg3vYhBV/BmNFH1p0CkAOEeHqYOBikoe
 pDni3sCjtwFvdrr1BUu+TYzFzf1rpPOOkRxxZKBPaJzatylM4EJR7pWu17AtH1qtTKCB
 mh0Qp5BAvg9QeygDs20NF4ss6G7OY+L0QVNZqpX3QNpY+IMT0XdQxRUlP/Wi2EgYk3Ty
 rwCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh4HPTPfvFr5V2eAnNU97aPtyKyMoDQcsx4dcSk/gVagjTmPwcrqeF3r9RRLiRWk1aVxxzjDdyO35sjLl+dKZ/ML264YY=
X-Gm-Message-State: AOJu0YzEsLWb0zVwc22B8aQ6ywYZAIc92xh+NXzBrvCje72Wy3Q/auoy
 k2V41x6UoHfxHFlYxxzFSTZOlB5KZokuYibKe1EdJocBduICV/j4tsqAZqDS/9g=
X-Google-Smtp-Source: AGHT+IHz1cboMKJATvItabnnmckKz8w9lk4syDdiUzBFD1gNZN361U0oxqbWfKhwztM0FC08NJqYqw==
X-Received: by 2002:a05:6402:40c:b0:59e:a1a6:134d with SMTP id
 4fb4d7f45d1cf-5b7f56fc987mr662651a12.32.1722530012929; 
 Thu, 01 Aug 2024 09:33:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59cb0sm10483978a12.45.2024.08.01.09.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:33:32 -0700 (PDT)
Message-ID: <7985c207-6816-4346-8037-c829085bfab1@linaro.org>
Date: Thu, 1 Aug 2024 18:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] tests/functional: Convert the m68k nextcube test
 with tesseract
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-22-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-22-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The code that handles running of tesseract needs to be tweaked a little
> bit to be able to run without the functions from avocado.utils, and
> while we're at it, drop some legacy stuff that was still there due to
> Tesseract 3 support that we already dropped a while ago.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/tesseract_utils.py              | 46 -------------------
>   tests/functional/meson.build                  |  4 ++
>   tests/functional/qemu_test/tesseract.py       | 35 ++++++++++++++
>   .../test_m68k_nextcube.py}                    | 29 ++++++------
>   4 files changed, 55 insertions(+), 59 deletions(-)
>   delete mode 100644 tests/avocado/tesseract_utils.py
>   create mode 100644 tests/functional/qemu_test/tesseract.py
>   rename tests/{avocado/machine_m68k_nextcube.py => functional/test_m68k_nextcube.py} (76%)
>   mode change 100644 => 100755

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


