Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DDC1061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Kaj-0000K6-Eb; Mon, 30 Mar 2026 17:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Kah-0000Jy-OW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:56:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Kag-0001M6-8I
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:56:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fe655187so65144785e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774907769; x=1775512569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MnNQU3ttoxAU2eFyjeik3i5dnHhuPIJngsLCgvGahig=;
 b=VsGBjB8MEPDrOWvnLyZtTeVW6anOM487NhrUU9jm/CZD7ar+9InBhbr7xqQ2uR7fN0
 3Rik9Y+BZDTCv8nSBdpO3hu3S8vWKmxjL0wXcnR6SxbRxtep+mqyT0MK6TKlqkwgr9oS
 5qFcdjxFILdlB+ShwfyShEjHOJsAXtY+ZogTIOSuF+3AxujZ81pUKx9PZfF4/1nQX3cx
 BhyYrGILqOnkteLmp0wL/A/Q4YyPphTAFJ86z4KAXwVV7qKUh9DNMX+fhQG/AZJEflvc
 tIiXaHgykSwF1TVZa1TPDCPgxkn2T5cji/w+/sb/2ITNErdJrz3vyry2IVumWSPaUaRb
 fhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774907769; x=1775512569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnNQU3ttoxAU2eFyjeik3i5dnHhuPIJngsLCgvGahig=;
 b=gPZd3ucZW6kJdhEgNCZtYPFnSckIFHvZxvXng2cU5QNK+grZBu2dnCq3OFpl3c+XMU
 rLs+C/GOCq+xVnT+B9BKMoIDCHvDnjva9ObSpXeRJpBgy+sl3yKKpb4n4t876Rix/ERO
 qpuBJgBhbaPFTY9qa0mOOqSUm3P7YV7KDGEkcRdGOnrY8ztdcwWlIqZHx/DHWm8PpQCP
 dnjy16vYLLJ7bfXgMuRKkp1Oz9bJ20H0pN+YQ3rnoavktZv+ry6byTJ5t4mppGfZQj4B
 CJBDdZb6XUSu8U20lRAm082aLSoXvT9kRhpM/XqO91SDEPcbzvoql46Yxh6qniT0MBvT
 vQVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDDnntutCD0/7Qax0cM0y9qmVpFlnpleR1uk0wsiOQ6hWOJVGEUNWt5UbPZsLQhWotuxqnc/IgvoeB@nongnu.org
X-Gm-Message-State: AOJu0YzaQpsG6jA5bewrEyvhc9aqg4ucPKgh5ftehiFe8zWsR3ZZ4y2z
 yaSiywdzHRVLvWz6DVReeriNu0XrEAswLE5HhZMR/IWFUQuTKrYfTpLuiW3j5LFVwtM=
X-Gm-Gg: ATEYQzwkncLduEGQU5QZpI4J4ffFBtrllFj3pEb3q7OSH2n0fwCJJ8p8ijB0xuxC/Ej
 P5npk4Z5WaYMUTkPi37hMkmb/aAl6In9B95DPfymqd53McCL0KmXVdKi5IqrHjIM3a9F3esY2Ow
 y/raCu1xZUSlnyDEPF5jgG8O3sf+3tiP61ZWQ0/r5d7QPv6glho/fVui7Di9+TJjbag/ImioxWo
 ngHQqkLkfdtgv4jGXX+PDEMMXg7hlgNRqzyWUfDRNYHhEeyWNr3MKLTewhljXry7rM02JnrzhUk
 D8Tegyd5ioOTUL8LDxMbVfHn04MBto9R+El7Q8hzFfoUXR5jIgC3aXETZSuYnQuATM6J2fFGC1S
 Ozn6Ze6XwDxEoEPXJaetMe9Y/IzG3f7Uyptl11+yb9F8aoYxN7fi8ENExzCf3wENMcmsYsXB1/u
 HYClL8wAv9+YaKBAkJFfVs7vDzKbWirNi2O+QyPthjtTm8oRmx79/Pc9n36esE
X-Received: by 2002:a05:600c:6387:b0:487:cd8:4c9 with SMTP id
 5b1f17b1804b1-48727ed5618mr236117125e9.27.1774907768813; 
 Mon, 30 Mar 2026 14:56:08 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887adae019sm2598625e9.25.2026.03.30.14.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 14:56:08 -0700 (PDT)
Message-ID: <9aaf1736-c355-4ba6-b6cb-6bdd03930eb2@linaro.org>
Date: Mon, 30 Mar 2026 23:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/pci-host/astro: Add GMMIO mapping
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-8-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-8-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/3/26 23:18, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Implement the GMMIO mapping.

As this point in the release process, this is a bit out of scope IMHO.

> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/pci-host/astro.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)


