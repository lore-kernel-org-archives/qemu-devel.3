Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CEDC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 07:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKBob-0001dF-H7; Thu, 20 Jun 2024 03:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKBoZ-0001ck-Fa
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:02:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKBoX-00071V-NS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:02:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3626c29d3f0so309139f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718866951; x=1719471751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sg37o9GwsiwxQ8zvMynTyvvGgPLYYcf+aEXKs+qRkHU=;
 b=Lwg2IKSrYT94hPGeMQZPn/1iyRFHuHe/j0tJx0bOGQOHYxzfruuQpHdHzyL/MMCgvg
 S/FLjk9j+W6PagYZ9pACFQG89v3g49Bzh4XAHlj6R/sRcfqLF+rT1a0vo09FJOb9Muzg
 j6IAIua9UO9fIzilBJilBDd9PATfu/IJv31oeMynjPWrdnLn3QYQLz/MCGRkhwcOZlLU
 thhfHSyreJVSHxZkj8IZ1Nn1PmbgeMij3DV6OtiE6smv5nxr6qxPSo0Z8Y6YYfL90sAM
 Ef31Fv5YlsQTbCobwqKb/euj4Ok7pck1KwDfkCcGkRXjK+MVkM/DIot2hkRDOPjHHlj6
 NHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718866951; x=1719471751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg37o9GwsiwxQ8zvMynTyvvGgPLYYcf+aEXKs+qRkHU=;
 b=XvzE06JRk4NUve/cQDra7AYsdPoz9WENOqDR/uL5ah+A4xtuT9l5wZm7WclqHVTwBw
 lU+l5aYlg4+ttFkmbf0ECqZJe6o4evS657ZzzGvyo1ejvru/zg+lIADkdJgJzgCE5HRg
 s4XPrdllIh8QaMgV4kdXRmV9xGHoofIa8PHxd9ts9OZUHezYvSuD+YnIAbvVYMQuUdAr
 74Pf9UswrPtiEMOaZgEb5afzia9nS3hzaQOX1y9iJ7T5mOL/gkqmbCc1HKgOZiliT4hQ
 hAdc3TAIywjuZ34l0E8UFGef+adO559X16IwM0acdveSPGWTzoJUROSIKnGbD44EAQlv
 jWSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK+fYIgmfMk2L/f0fhU5MCrJIL39esB1gIDx/r+/M3EKQ56+Ix2A58J8gysBBe7s/AO8Eq6SSdhRn8Vm9bvL7bkfLCZOU=
X-Gm-Message-State: AOJu0Yxf1ftd3KwAbJmE4+Zqas3upjHUhM6gOaXqSrRDkqH64PoNO8gd
 6o9JiPEo/wkBwGUzo1z313odoF7mzrg1DxNZ/6PQZ/eSlwE70IjekX5m+feSmc0=
X-Google-Smtp-Source: AGHT+IEd2pogDLUYExO8cZA8xUvBs0H/6r0Z9HNU8TZY5jsVqRaEuK9pU8nUcIsNjA0U+iXQp2c92Q==
X-Received: by 2002:a5d:68d0:0:b0:35f:bc7:6e4f with SMTP id
 ffacd0b85a97d-36319d67ec5mr3632011f8f.64.1718866951417; 
 Thu, 20 Jun 2024 00:02:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-363ff2c934bsm2639694f8f.86.2024.06.20.00.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 00:02:30 -0700 (PDT)
Message-ID: <49dc3d36-1f4a-41b8-acd2-e758bebbfa87@linaro.org>
Date: Thu, 20 Jun 2024 09:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/avocado: update firmware for sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org
References: <20240620060014.605563-1-marcin.juszkiewicz@linaro.org>
 <20240620060014.605563-3-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620060014.605563-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Marcin,

On 20/6/24 08:00, Marcin Juszkiewicz wrote:
> Update firmware to have graphics card memory fix from EDK2 commit
> c1d1910be6e04a8b1a73090cf2881fb698947a6e:
> 
>      OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C
> 
>      Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
>      tolerate misaligned accesses to normal memory, and raise alignment
>      faults on such accesses to device memory, which is the default for PCIe
>      MMIO BARs.
> 
>      When emulating a PCIe graphics controller, the framebuffer is typically
>      exposed via a MMIO BAR, while the disposition of the region is closer to
>      memory (no side effects on reads or writes, except for the changing
>      picture on the screen; direct random access to any pixel in the image).
> 
>      In order to permit the use of such controllers on platforms that only
>      tolerate these types of accesses for normal memory, it is necessary to
>      remap the memory. Use the DXE services to set the desired capabilities
>      and attributes.
> 
>      Hide this behavior under a feature PCD so only platforms that really
>      need it can enable it. (OVMF on x86 has no need for this)
> 
> With this fix enabled we can boot sbsa-ref with more than one cpu core.

To keep bisection working, don't we want this patch first, then the
previous one on top?

> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 136b495096..e920bbf08c 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -37,18 +37,18 @@ def fetch_firmware(self):
>   
>           Used components:
>   
> -        - Trusted Firmware 2.11.0
> -        - Tianocore EDK2 stable202405
> -        - Tianocore EDK2-platforms commit 4bbd0ed
> +        - Trusted Firmware         v2.11.0
> +        - Tianocore EDK2           4d4f569924
> +        - Tianocore EDK2-platforms 3f08401
>   
>           """
>   
>           # Secure BootRom (TF-A code)
>           fs0_xz_url = (
>               "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
> +            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
>           )
> -        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
> +        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
>           tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
>                                         algorithm='sha256')
>           archive.extract(tar_xz_path, self.workdir)
> @@ -57,9 +57,9 @@ def fetch_firmware(self):
>           # Non-secure rom (UEFI and EFI variables)
>           fs1_xz_url = (
>               "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
> +            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
>           )
> -        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
> +        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
>           tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
>                                         algorithm='sha256')
>           archive.extract(tar_xz_path, self.workdir)


