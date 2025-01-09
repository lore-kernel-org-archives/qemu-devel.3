Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41247E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrNO-0006tH-2V; Thu, 09 Jan 2025 07:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrNC-0006s7-Qu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:10:52 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrNB-0005vt-9U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:10:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1277665f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736424647; x=1737029447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dgo9yBapRcAllbwTcnu2QtKf5J2bG+P2y6fDUr50e7c=;
 b=G/hMN0B9FTxrwJ5Ee1L9vJINVBCOLgNb/8Uvnajb1v5MHxgyNuAlgGUq95Rp+bIKIk
 ZLqRjrsSUK8dhM9aiZeT8pTwy/WP0GKWkQVuftsAZLH3aVB7tkbXyOaCk1mYVTWNTU4/
 4TLgwb8SmKPCMwzMMCXUwbmqGoBRswLQb5CT/QpRGdbBKWOETwC3tpiTqWAYu+Nz2pXD
 ghlteENcVpvhAfYM4nqa7fVBl8H7i34cRhYS1yPMvPiLZXew0j8L/Fzto+QM4j33oLBz
 s/npTr3ZFevrdlrEaTrLxYfKs13o3wuo9CYr+xJXSyxhSEXJeJOJQjhvNTdNeJ1DNaED
 yICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736424647; x=1737029447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dgo9yBapRcAllbwTcnu2QtKf5J2bG+P2y6fDUr50e7c=;
 b=Wpe0cexEVW7VTQbX09WnLHwdzR6//L35Gk+MFpIAe3AMVropNJDvHH/hgznqS9PQIB
 faVFozSUTP6ubrsUhdRjAYgdI21Zkv1aXwtMd8i9nDfZpE0Hs/8j3VfmUkhZZgwNjku5
 KhYJRlBv8fC0dXvlurjmmTIFjvjQwq+W3HIwgBZG4K/WKIR+bO5bAOeqmnIp8Nz45u8P
 dyPJjrsv/CrhxMs25KrNdLcT2UYNd6CpkFnVPyvGD9zfTLIoNm+QdaS+tbQEwBGKj4EV
 kkPS2k3WwT5QRh7yNh0LzcwkQPjymZfVBBfzqdTmVTkOWGVN/e+kUGtehOBFG0v6ZSCn
 XRGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCoy1nruGs6v4UVct7Q4raR4YPqeqUx/QQz50/NJGs5GrhG/ehmUCmhx0Q4hLRbJ3/gAs3Pd8H/QCI@nongnu.org
X-Gm-Message-State: AOJu0Yy9XpN6WRmI7+xi96/ywgI5SciC6+cCg1Et6tjafn6ij+VAbhxe
 06JB/EnReyFyq7jhk0HpzVOtESE0+dtCqFoAlLkMnj+1LAQkxkmOU+Kt5BMOA1E=
X-Gm-Gg: ASbGncsWBoqy7ovHr561lI0tduREC2Y08ntoZbQxC/sIFhIE7arKKeIGOVTkNHb2smN
 L4UU+jjy+Xyu7RyWmC14dFDC3RonopW71K1kjabkR2cbkv6Mfwm1PMgYXcRySmxq39ZU+ls/4a9
 CrDcA6o/ilmOZVoRDsMuaiMeUljBXwJWJC+NQ1Xez0jNoXWdljos+Jub9lRCc6n88c7XPlb6jnK
 SoQgWdT3Uorz5+8K1KIem7kFt1foGqklS9QjXjxYWOqQSX3csyMZ2qmZXuOrV7zCsxg93vMKRrJ
 VeO68z+/F3az/n9WqRUJgjtc
X-Google-Smtp-Source: AGHT+IFgCfrrnONiUbLHsYpXdmR4etIdMU7M7SvcfNOoLgbycb/njcLXZmtPt3Q7mrARmKqgrOVr6g==
X-Received: by 2002:a5d:6daf:0:b0:385:e986:416f with SMTP id
 ffacd0b85a97d-38a8b0c7109mr2437638f8f.10.1736424647361; 
 Thu, 09 Jan 2025 04:10:47 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm1658040f8f.48.2025.01.09.04.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:10:46 -0800 (PST)
Message-ID: <eab5d179-a409-4fa0-af68-9f8c89d7848f@linaro.org>
Date: Thu, 9 Jan 2025 13:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> In U-Boot, the fsl_esdhc[_imx] driver waits for both "transmit completed" and
> "DMA" bits in esdhc_send_cmd_common() by means of DATA_COMPLETE constant. QEMU
> currently misses to set the DMA bit which causes the driver to loop forever. Fix
> that by setting the DMA bit if enabled when doing DMA block transfers.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sdhci.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


