Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABCC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 22:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZHa9-0000t8-KV; Wed, 31 Jul 2024 18:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHa8-0000ms-2B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:14:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHa5-0007Gd-CG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:14:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d1a74a43bso4542444b3a.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722464040; x=1723068840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CE9fgF37GFZ/WnLbL0ZHd+GKYNoLQ9YgzLgWzB6XYlk=;
 b=ikQRtG/hW8AbrMVAg5hTVCAZYXaYCZpGT14Q3+dPNCDrOL/eZxTLUPa9mZkLEIu0k0
 M7/tfxieAkeiuTFKRfHUbjnbGlKNL1D3Key5R1a4gkrTG0pAJ+fkGnP4A5s+e6xBrnEi
 Eu2s6ZLBTZfaBb12MBkxDE5MxiN0jxuoUuY1Ig3LwdhAt+zVDj49UPIYi7gRKBclHQYH
 nQ64y/05w3MKX/IPNVfU5xrsdJoLhBVAsCjd4q2QhvMsl2pgJlM6pxIycj7h3DGYwXwB
 6YCPqMIn9BWz8QSyRh+/KkOL/SmCMyF6ChCouEervNB1INCg/fSU1c/nIuCFNFX6FrA8
 13QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722464040; x=1723068840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CE9fgF37GFZ/WnLbL0ZHd+GKYNoLQ9YgzLgWzB6XYlk=;
 b=a3rL0rGN7TVMfKdDCDMfHx4fgP04BicvwpcrZBDrwYjG2vmHLdST/K+DWbEZNTz+Cs
 T2O8ZZqHWD+K2XsYUSHE2Q8a83K0hTPdXAD8BGK5gypgrBB/08wGoRUSOufch3zjmxPP
 MTma7tOReJQLMX/5dv08JIVY0t4kg6Qqx0VVW/SyYNyM4ADSNUTlaGg8x49Zw726atIX
 ZcQrOOZ3p6eTmUgkD1QyYx41VOnvllnjo1etPihnpUUZFYajwKbHBhDfyV3wVOazOqkW
 UPEA5MvqNWvd9nvPa10JEHlPYeFtIp1BirxxBysMO9QZH5Pgung+zBHxevRE3yHFxxbD
 wNdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUpnD+Q+zrFPwfKr0HUuJssojDSZC7KFSypmT5Zx32BxMYkYhgP9NBGUl6xl11KNqyFhElX9qF0HO1ooId4ZMJJOPxO8=
X-Gm-Message-State: AOJu0YzXCH5TZBhlmbdh82CFrnTj5agcHG2J1FkNZqbXZ1r2cA9UPQSo
 BQ6C4a5jAInTnsVZBh3fIdxw7s98dWmAlOl11xfg4N7Juh2CzhokZMK+/7GCiR4=
X-Google-Smtp-Source: AGHT+IFcgcVmNm6hbEuNls3IoMOzwJgWgY8zx8Hi8EvycK5xyIBBNIvijJex1bXeDexhtd+nrwAcqw==
X-Received: by 2002:a05:6a00:188d:b0:70d:311b:8569 with SMTP id
 d2e1a72fcca58-7105d7da884mr808920b3a.26.1722464039630; 
 Wed, 31 Jul 2024 15:13:59 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead874bf5sm10385597b3a.162.2024.07.31.15.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 15:13:59 -0700 (PDT)
Message-ID: <f6a574f3-964e-4827-b3a0-b6360a53cfd0@linaro.org>
Date: Thu, 1 Aug 2024 08:13:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Makefile: trigger re-configure on updated pythondeps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240731140232.22193-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731140232.22193-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/1/24 00:02, Alex Bennée wrote:
> If we add additional deps for meson we need to ensure we trigger a
> reconfigure to make sure everything is set up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 02a257584b..0281a883a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -78,7 +78,7 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
>   endif
>   
>   # 1. ensure config-host.mak is up-to-date
> -config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
> +config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION
>   	@echo config-host.mak is out-of-date, running configure
>   	@if test -f meson-private/coredata.dat; then \
>   	  ./config.status --skip-meson; \

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

