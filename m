Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F88C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBX2a-0005k4-Ot; Mon, 27 May 2024 05:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX2Y-0005jK-Hc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:53:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX2W-0008HE-CF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:53:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-357f1c0b86fso1091503f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716803590; x=1717408390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTvOFcRioRnhwU5iUk34BgipIQyxDh4f1bq5Rktqm/A=;
 b=qZTABBJPJF3dLRmW7Vxl8mFZJKr1KPqR64Z+sdySGXKsBsqBq1o6fohqJHuLuDC5lv
 VsIodYNNSNMCrteiK6DgZ6wXM3Ue2+eJ4JdopiMsTol27ermBH+r4GTOPR0Pb1M//MaZ
 ARxGCefxHgvRLjBG7hN7zDFuwkZEdxAlL+rJ0KX9+r/RNLKL/qc+1QX2Ej68FeuVC3UT
 wkbFUHPXVAojH4x9u50BaD5SSOp86XHFYBAVRR8Wr1me4lqRuK6l71cBbxWKKePrWcKf
 BpYYC62Fl/nIbIRfub/InTihkh8T1qjiCzSSjtRHRgEu1OvV1NY/oWfgPaJOPjjxl046
 i2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716803590; x=1717408390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TTvOFcRioRnhwU5iUk34BgipIQyxDh4f1bq5Rktqm/A=;
 b=IaWxuUdzVzjVT2ZxluUTI7POTL3jiYNfZ4qCkTlymS92nDmHCE1YZYBYCAU+bajg0q
 jQDbHuur50t4Z0P+cTSRRpBHafRt17anQXdbEa9icNmijX/2kjhCdfeyrIA3iNyS2IiH
 feD0pOlWYH1/uK55cGf2a9VjKTidRakgV5OGYbz8V/63PxTwZLdEE82FN0KiQAsXseoH
 D0RWfQNtXEHXFwiiFJcApN73ZZXbqRSbWBY/4LY13bc1yXsC3T7pv0Lwvjh/EY7c5KBr
 1G4LzSFVqss8QHutQzCGBt3OZXGB4PVDoT1U8QWUfltPPxHCKiMHL0v1IN+KkcuxpV1b
 kQDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz/aHXnn1kvAZG6YnyV3XLt8nD5MjwTytZgKX4qDM0UN5riyCXNfn93ahl0Tnhk5GfaH727TaIQS5hSroWqnfrdHdRycU=
X-Gm-Message-State: AOJu0YzT7MgmTFQVoHRI3449J3osfz8mS3RIaLbX/ZEPsJ5iwYzlC8Zl
 rfNcUbQ3jrjsJkXoSzg10t1lEc1KII0/QpPB5m2e9upof0UNdFXdpBHwlZ6zuK8=
X-Google-Smtp-Source: AGHT+IHTDfadl0OwYpEBCJW7/XCfkDFGaGDZRFu93YEcIrNNvJ5cpITi+jqGXGnJRjntRXrMyC29wg==
X-Received: by 2002:adf:f605:0:b0:351:d78e:875e with SMTP id
 ffacd0b85a97d-35526c271e2mr5889702f8f.14.1716803590214; 
 Mon, 27 May 2024 02:53:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3577505a218sm5416098f8f.31.2024.05.27.02.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:53:09 -0700 (PDT)
Message-ID: <f2b32bb7-409b-484a-b4c3-71ca40d9bbe2@linaro.org>
Date: Mon, 27 May 2024 11:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/avocado: sbsa-ref: switch from OpenBSD to
 FreeBSD
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
References: <20240523183928.37809-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240523183928.37809-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/5/24 20:39, Marcin Juszkiewicz wrote:
> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
> than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
> so we can stay on 14.x for longer.
> 
> Planned to upgrade to newer OpenBSD but we would have to wait for 7.6
> release to get Neoverse-V1/N2 support.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 65 ++++++++++++++++--------
>   1 file changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 98c76c1ff7..c3c7c0e639 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -1,4 +1,4 @@
> -# Functional test that boots a Linux kernel and checks the console
> +# Functional test that boots a kernel and checks the console
>   #
>   # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
>   # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
> @@ -177,14 +177,14 @@ def test_sbsaref_alpine_linux_max(self):
>       # This tests the whole boot chain from EFI to Userspace
>       # We only boot a whole OS for the current top level CPU and GIC
>       # Other test profiles should use more minimal boots
> -    def boot_openbsd73(self, cpu):
> +    def boot_freebsd14(self, cpu):
>           self.fetch_firmware()
>   
>           img_url = (
> -            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
> +            "https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.0/FreeBSD-14.0-RELEASE-arm64-aarch64-bootonly.iso"
>           )
>   
> -        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
> +        img_hash = "2f3ceb0ef6b1de53553abb9979a6d65f51b006dbfa985798b282812ecb758c1b"
>           img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
>   
>           self.vm.set_console()
> @@ -196,43 +196,64 @@ def boot_openbsd73(self, cpu):
>           )
>   
>           self.vm.launch()
> -        wait_for_console_pattern(self,
> -                                 "Welcome to the OpenBSD/arm64"
> -                                 " 7.3 installation program.")
> +        wait_for_console_pattern(self, "Welcome to FreeBSD!")
>   
> -    def test_sbsaref_openbsd73_cortex_a57(self):
> +    def test_sbsaref_freebsd14_cortex_a57(self):
>           """
>           :avocado: tags=cpu:cortex-a57
> -        :avocado: tags=os:openbsd
> +        :avocado: tags=os:freebsd
>           """
> -        self.boot_openbsd73("cortex-a57")
> +        self.boot_freebsd14("cortex-a57")
>   
> -    def test_sbsaref_openbsd73_neoverse_n1(self):
> +    def test_sbsaref_freebsd14_neoverse_n1(self):
>           """
>           :avocado: tags=cpu:neoverse-n1
> -        :avocado: tags=os:openbsd
> +        :avocado: tags=os:freebsd
>           """
> -        self.boot_openbsd73("neoverse-n1")
> +        self.boot_freebsd14("neoverse-n1")
>   
> -    def test_sbsaref_openbsd73_max_pauth_off(self):
> +    def test_sbsaref_freebsd14_neoverse_n2_pauth_off(self):
> +        """
> +        :avocado: tags=cpu:neoverse-n2
> +        :avocado: tags=os:freebsd
> +        """
> +        self.boot_freebsd14("neoverse-n2,pauth=off")
> +
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')

Nitpicking, maybe 'Test might timeout due to PAuth'? (few occurrences).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    def test_sbsaref_freebsd14_neoverse_n2_pauth_impdef(self):
> +        """
> +        :avocado: tags=cpu:neoverse-n2
> +        :avocado: tags=os:freebsd
> +        """
> +        self.boot_freebsd14("neoverse-n2,pauth-impdef=on")
> +
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    def test_sbsaref_freebsd14_neoverse_n2(self):
> +        """
> +        :avocado: tags=cpu:neoverse-n2
> +        :avocado: tags=os:freebsd
> +        """
> +        self.boot_freebsd14("neoverse-n2")
> +
> +    def test_sbsaref_freebsd14_max_pauth_off(self):
>           """
>           :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> +        :avocado: tags=os:freebsd
>           """
> -        self.boot_openbsd73("max,pauth=off")
> +        self.boot_freebsd14("max,pauth=off")
>   
>       @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> -    def test_sbsaref_openbsd73_max_pauth_impdef(self):
> +    def test_sbsaref_freebsd14_max_pauth_impdef(self):
>           """
>           :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> +        :avocado: tags=os:freebsd
>           """
> -        self.boot_openbsd73("max,pauth-impdef=on")
> +        self.boot_freebsd14("max,pauth-impdef=on")
>   
>       @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> -    def test_sbsaref_openbsd73_max(self):
> +    def test_sbsaref_freebsd14_max(self):
>           """
>           :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> +        :avocado: tags=os:freebsd
>           """
> -        self.boot_openbsd73("max")
> +        self.boot_freebsd14("max")


