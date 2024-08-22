Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53472C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCrW-0000f4-Q0; Thu, 22 Aug 2024 14:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shCrU-0000dx-R6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:48:44 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1shCrT-0003ZZ-2a
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:48:44 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso131009166b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724352521; x=1724957321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=v3Rq6RD9bD6z2hu2d8FQg2chetgTeL8EOgxKa4xMRK8=;
 b=fhgYB1qYfKydTkEe1iNkhJLhzDDPHHAz5aJmBre2cDOAOQiHW/wmsZxhQMBTWv6g/k
 qGQFl8l7XpRg6uppVjCykN+Xc3NAuPBhMyGImXN+04/woB8A4PXY1IaqScj0w+L0CHpK
 NT76UGFmlll2bNJF/44lciUoSmS0iUpi1DVNIYTlfPLjFEjdcx4VE6dcvsn8X9drzoQU
 P6wkIDLco0eBoQkgDkXaMpel7NpHcKWuYsfISy+Tlk00+IYhO+VYK9TLA369Ck8No9BN
 EnOTp/KKphSARxs5H20p/+9BUklRWzI32/GxTXIq+yMqpourWFac0mCKTN0c68BHltIA
 IkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724352521; x=1724957321;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v3Rq6RD9bD6z2hu2d8FQg2chetgTeL8EOgxKa4xMRK8=;
 b=NrfBLHpt5EOdUCkKUaHS+YNDIhpnixNk2K1XijQxOKM935Wsrt7ICsO5QGZu6pmNHI
 WUGFdkSAYkdiuSo/VhId1CWRLvKRHb+RfEL97DgOOh6JCo0v3dwM72egKQekQKy2VNGu
 MIriFPMcXXmx/zY3US1qANq+ibgIZ9jAJ2bnw88dBRQmzTwAAvu6JAfSEgqjpeBpfLVy
 kOrbKsqxZffWd15XcjOxlLDccmgPzDwiDy7O9ggmOENot8uOpsuXwyjYDdJLod+3xrJU
 OsBMI9aGf0cYTyro3+0EW+A3wiiiGWadcgF9t/qHZZKPusKibX7cG7eKCVJJHshXjRY2
 NlXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkkO4O5zg+c0SYoMM2C+EUxb23kSErYcPYJFFoqJ5m2WcvNLPturZvABAC8vSc/HfBJiHaoWqn9Ntg@nongnu.org
X-Gm-Message-State: AOJu0YzzIILKN+PDijAX3GxKhRUcVcgK+9gms8oml2DUUCZy29JYCKAT
 sOEPPuAs3/p/WgoZyWlLugsQHIQe8BA3Ay+DqBiR6zHVpnIFjSw8vU+tT7/j1Xc=
X-Google-Smtp-Source: AGHT+IF+qkYrqf1/ekTOiDkFhrvrYBwPOq9VBfXxtatUr2LBdKJeLE/J74oZyCziSdRrXSsxfJC7yw==
X-Received: by 2002:a17:906:6a1b:b0:a80:f7d8:5bbe with SMTP id
 a640c23a62f3a-a866ee6dfd8mr509649166b.0.1724352520180; 
 Thu, 22 Aug 2024 11:48:40 -0700 (PDT)
Received: from [192.168.200.25] (83.25.211.12.ipv4.supernova.orange.pl.
 [83.25.211.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2adc55sm150691666b.71.2024.08.22.11.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 11:48:39 -0700 (PDT)
Message-ID: <17ba91fd-b876-4169-8b72-3fddf966e1a3@linaro.org>
Date: Thu, 22 Aug 2024 20:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240822114146.86838-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Since SBSA_FLASH files are not
> tarballs, use lzma_uncompress() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20240821082748.65853-1-thuth@redhat.com>
> ---

> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
> old mode 100644
> new mode 100755
> similarity index 56%
> rename from tests/avocado/machine_aarch64_sbsaref.py
> rename to tests/functional/test_aarch64_sbsaref.py
> index f8bf40c192..6728e5f92a
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/functional/test_aarch64_sbsaref.py

> @@ -44,47 +55,31 @@ def fetch_firmware(self):
>           """
>   
>           # Secure BootRom (TF-A code)
> -        fs0_xz_url = (
> -            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
> -        )
> -        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
> -        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
> -                                      algorithm='sha256')
> -        archive.extract(tar_xz_path, self.workdir)
> +        fs0_xz_path = self.ASSET_FLASH0.fetch()
>           fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
> +        lzma_uncompress(fs0_xz_path, fs0_path)
>   
>           # Non-secure rom (UEFI and EFI variables)
> -        fs1_xz_url = (
> -            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
> -        )
> -        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
> -        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
> -                                      algorithm='sha256')
> -        archive.extract(tar_xz_path, self.workdir)
> +        fs1_xz_path = self.ASSET_FLASH0.fetch()

Here you want ASSET_FLASH1 not ASSET_FLASH0. That's why it timed out - 
system was hanging on exit from TF-A to EDK2.

>           fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
> +        lzma_uncompress(fs1_xz_path, fs1_path)


