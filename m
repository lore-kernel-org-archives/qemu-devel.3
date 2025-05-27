Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDDCC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJulm-00085X-7S; Tue, 27 May 2025 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJulj-000809-TI
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:55:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJulg-0005C0-Qq
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:55:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a3771c0f8cso2484985f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748354098; x=1748958898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6ZctTBKUtkldfATLLgyIzJAwy/mVXtBwYa5MuXZLtY=;
 b=tcuJ2C+B4kdfmb7PLrzZUFc/1DAlKjgwQfXdTVLKRbOXQI++xmlFlNKjxwOkOOYKDk
 lzrlT09KVTxoQyvHmGa/iacbr2pfxMWo2zthdiBjba2I8d5Mn+1H0KkMWaR7ghBKae/s
 4E0UcpACCk4C7ijAHzRA1c4HwFHgkF1PRMFA2PD9qR+p/sTu0tOq/z/HX00Zx9ADSLlt
 mRrK6XnL61FhUKoSr0nxgyWXsgHSDUsl6Vgk6golXU7unhPdTeRBG1vFNVgiGSWHHVIf
 jl7e68hqhMHF4MBZSMHDVGa2TOZThVcvnnZ4rEfe8fb8VpvaPXjWklsVuuiUbktGTPqB
 IaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354098; x=1748958898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6ZctTBKUtkldfATLLgyIzJAwy/mVXtBwYa5MuXZLtY=;
 b=VNRDNEqW0bNgxaQNdPq4mxoGIBdrXCbdMl/fnla6aB+VP7SgpAF+483nwsy4mpJCqm
 4loBVEtjOBrPqfQexqnGxD65pN2nt3N0vgL7k17iIdNQccJhoiOwwsqg9WQE1EJd/rzd
 ikTZlEA8ikTQqFg4lW2ilf1hRy0Aahq3ued6AUeq+zuSMv3tn3vtSSIKIRVDiDIF9K46
 F2h8yJiP16AMyiYr6pUGOgSaHNah8OmdGX00+NL+yuW/nOHsrz90EeZ/h5yWKli/KnAQ
 xBSq2LKThqVrKp073PWdXf0DhlaxZzx1NhuHkUQuxj2gGAvdqkJw9DKLGK9bY92q0hzI
 yDcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYzMuudySHKEy9esLT6z9VkHvW2Lw3y2CbrukcvqIPtNBrLs0tPcuyCYVLSCOMR2QSP9hFkNidkAAY@nongnu.org
X-Gm-Message-State: AOJu0YxowR5Bcktd7jC93fV8RDIVQ0+vXODcOJ5uTIEumEEadfiFi8hL
 NukGKnyJxftf5nRHXbDaJHNVeLsrzVUbzwHz4lUl7KuhfvFbUKYG/XQ36MFk95MZbQc=
X-Gm-Gg: ASbGncvjkL6D/VsGbIEjvm4kvIuguomnYObA6IP3aFAyktezf5SE5dBQygFoZ/iPaRM
 3pNOSrjWXWXSDseUIBttEIUqGP23bFFHtuWluKYdp2PIbsMI7cKz95XfBECYL6XUpk9qPf+gRS/
 YB4SJCj/UYsQ4JBkdcuC+DlhXUl71ZDmIUChRRAOlJP8Ivs3ceIgPJiMF1NngI1pANQHUzrvGqB
 qhO2tBZj3OTVtRtcqf01RP6PC4wS6U3WtofaAAvwbjfJWbAmUl0pZFIIzaW8uFE08LtkIrGAoDN
 2hJqFZnWFMUQVdjW803NS1M4zessvnVHDi0wVBLv0njxYZkxm254l1vb6O11zkx8BznqGeADJIJ
 S93CJMBruK8KsuKn/dWk+HJV5
X-Google-Smtp-Source: AGHT+IGv6xP2sMMLvB22M943qizNmDwk+ymzTmuechgMJfOxbl97xhUgQ/M3lbF6SH+bdi/Wj9+3Jg==
X-Received: by 2002:a5d:58f1:0:b0:3a4:ce5c:5e98 with SMTP id
 ffacd0b85a97d-3a4ce5c6528mr8594951f8f.39.1748354097982; 
 Tue, 27 May 2025 06:54:57 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ce65342fsm10133853f8f.6.2025.05.27.06.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:54:57 -0700 (PDT)
Message-ID: <0e6a115c-8af4-4867-8ffc-aca5b0167143@linaro.org>
Date: Tue, 27 May 2025 15:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/functional: Test both microblaze s3adsp1800
 endianness variants
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250515132019.569365-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 15/5/25 15:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that the endianness of the petalogix-s3adsp1800 can be configured,
> we should test that the cross-endianness also works as expected, thus
> test the big endian variant on the little endian target and vice versa.
> (based on an original idea from Philippe Mathieu-Daudé)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_microblaze_s3adsp1800.py  | 17 ++++++++++++-----
>   .../functional/test_microblazeel_s3adsp1800.py  |  5 ++++-
>   2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
> index c93fa14232b..c5e60b555c6 100755
> --- a/tests/functional/test_microblaze_s3adsp1800.py
> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> @@ -25,12 +25,14 @@ class MicroblazeMachine(QemuSystemTest):
>           ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>           'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>   
> -    def do_ballerina_be_test(self, machine):
> -        self.set_machine(machine)
> +    def do_ballerina_be_test(self, force_endianness=False):
> +        self.set_machine('petalogix-s3adsp1800')
>           self.archive_extract(self.ASSET_IMAGE_BE)
>           self.vm.set_console()
>           self.vm.add_args('-kernel',
>                            self.scratch_file('day17', 'ballerina.bin'))
> +        if force_endianness:
> +            self.vm.add_args('-M', 'endianness=big')

This 'force_endianness' is a bit confusing, I'd simply always set
the endianness, anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


