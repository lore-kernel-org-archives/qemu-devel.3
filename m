Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F70C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNrA-0005bM-4Z; Fri, 24 Jan 2025 12:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNr8-0005bD-EP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:52:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNr6-0004np-Qq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:52:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1337219f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737741151; x=1738345951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qnhQdgQQCVH428VYTtbw+snr2O2l9ZoX9BEdJeAVPMA=;
 b=tOtmoEHjgE2N2bF5I/JacWj5gwKH3CQsWDWu8z5XIbPeA/H9qgfSMM4UBOyUcMHXe6
 6Wv6ZWm4z1g66g49Rpn8W2YbWMpirwKb/JCVE/m23wqay3qwfPIbG5xzDseHlxgB/1ya
 0qBGK8NYhHCCiPc6bipfup56JIX039UQho4QF9SiaZY6ECeZHDhdk9AVsRg8ByhJ8eDq
 AnH1hEIa8n1k4CiXlh4NAY3FdldqyUAZEkLY8k1jA6xxHlRAUrN9JUBZJ8uC49ExPISt
 b6aDfJkXJJBO6mg2pZaNN1F3iQhzJIGQZKLcCiciy/ABD3dCkHIedVSix/uqQI+tmSsb
 QUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741151; x=1738345951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qnhQdgQQCVH428VYTtbw+snr2O2l9ZoX9BEdJeAVPMA=;
 b=jNG3WdzSjrlzSYtb8TEcvryPVJt/bZ1SdE1kq+Z9+wOs7RZU2fHaq35Zdvy/0z7Svy
 VinjeFoa/l0foWdo/F5rfbScRpsKuxvCpYjZh0wTep+XkGTSP0XuTGeGGRFwj7zFKgvs
 nYFsL2pRy1ggA7VjtmG9eKsZnDtcWkujc9ZCqLBc88Lyo+f4nUzSgZR6ARWwl6LcwWGV
 e/dT7gEtJ/qQezoC/miUawmaY41HrSoG/wMYFD9vLNx72PsnCrTnvuG37TGn0Lg9AnKv
 8pmZFxklxC2X9e61smn5gWOjbiFPlV+cbFN7UoHLCfZJEiO/ByuRHaNYHiKAP7Jwi/l9
 xPFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNvL1gcxosLxw/Vu2qm9sYi2Uhit7odFdLV5Gp+0CMK9wS5mrOSWx/onPdYy5xwo19bI7F/YQ8Q7m4@nongnu.org
X-Gm-Message-State: AOJu0YxvsXisS6Nwv91tQuTCGGwEO6TDXGgVMqQ1IYH2EICkqLVC9VUp
 0s2BOjN8Hbc8EUcxKO1Hi6s7Lq3mLPBALufRRw6dDKP6TO1tm5hRfeIeYE5B8Bo=
X-Gm-Gg: ASbGncuKoaT3PnIioLMDjG11SdiI/d4zbKjNE3D0USi7uNoOrBdOlw0Jzoaopvoe3Td
 VXm7FHnO98I3X1fizLmqrPJQm1g44n7sxZ5FK8txv+n+GLOr7Ph6v9eyeE768qh7kuHgouvsvxV
 V/SfKX1jVrQVDPcuy/8wb2M5H6ve03C3U5iN89ZEoShEEjzmKLymhi/6CMd2t8jOrDtWeYsBfgp
 oCzmBiXz8EFqgCi9j/39zIA4LsVjo36H9nixpmpwAe7iLkLcX5xFAbDrw6YOMKUw7ujP3JUYqdi
 og85vXLUOflbOWrwMWs+yWEu9jE8RZcJAo2WfMKVx2qJjeWu
X-Google-Smtp-Source: AGHT+IFjMKpj6WUfcVQHn3EA7KdKE5azQXhnyw5lq2joNlmlUjGxpf/Gxizzfi22syi85l9djVJEvg==
X-Received: by 2002:a5d:6c6f:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38bf566e691mr29576726f8f.3.1737741151296; 
 Fri, 24 Jan 2025 09:52:31 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c35e1sm3314215f8f.82.2025.01.24.09.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:52:30 -0800 (PST)
Message-ID: <32a9172f-367d-4344-ae63-a9d98dfe8d9a@linaro.org>
Date: Fri, 24 Jan 2025 18:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hppa: Support up to 256 GiB RAM on 64-bit machines
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-2-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250122180913.18667-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/1/25 19:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Allow up to 256 GB RAM, which is the maximum a rp8440 machine (the very
> last 64-bit PA-RISC machine) physically supports.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/hppa_hardware.h |  2 ++
>   hw/hppa/machine.c       | 26 +++++++++++++++++++-------
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index a9be7bb851..a276240967 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -49,4 +49,6 @@
>   #define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS internal) */
>   #define PIM_STORAGE_SIZE 600	/* storage size of pdc_pim_toc_struct (64bit) */
>   
> +#define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */

Should we use ull suffix?

> +
>   #endif

