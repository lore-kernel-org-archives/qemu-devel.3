Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ED4CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIlM-0001V9-66; Fri, 08 May 2026 06:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLIlJ-0001Uf-0G
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:48:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLIlH-0004U5-Gv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:48:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so11308905e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237329; x=1778842129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hRJOA6ZgQLrllULVnAZGeW+n1iykn4/klW5RV4J2ytA=;
 b=K4sNtCOpp708dMp4QiUExS/TvXPnehBn9xHlH2NSboqzM7SqSwXHnIT0nTpt42JRMw
 e6hnkTdHrR+gQZyyIwKECAbDNWldGxsFE+46qgFZPcYuRNSAuv5+id+JWDGMGqeDsYxO
 WiCXHCTDsPCoLDVNLTucLIlCMOVJYL0C637sOJOuAQOFgnYApd7zrOcocAKC1HAcO3Xl
 HnyRuzSmkfxigtu2Jg6ugW5ec64yWFaRy0KCy4qq9Lm10M5m98MZakYUhIF8wd7khv15
 gM82HtkNwc/JU31UqTg+OwOfUVDRoSLEiSeGt096xVWjq2d9zPJZfkk8SXFo6Pi/Giwm
 BCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237329; x=1778842129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hRJOA6ZgQLrllULVnAZGeW+n1iykn4/klW5RV4J2ytA=;
 b=aePVtDSikcpYlZ5BIqHG/onqRtOsd6sj4fLEwmNUVgWFwkE+IKA+dj+iifUre76lDq
 TFVYqxevgob0mFUne/3PsFivhQbVmTzpejkrMkkCPSF7Sz5LKUjLmpg8KcouuGSZlQ6m
 NTakhACkBxfYjtriZAI49Yhvzc3NR8M3IKN60mz6SZ8Ox7GagLxNZ6SZ1/UwW3gaFK2H
 HGo1BmJOLVMMukjobhg7YTXYA0qT4749v03L8p+gJzkCKEJ8qRoP670PiPeSTdSz++cp
 2AfNuh1fZnOrA6i8OqPdkF49LEupzd3xcfDFsLC7P8no0P5YfuGJ7lWnEmmTZsucBJ9O
 aVNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JP5AGEXkszjDYgvkdCcf9jeRrwlXPy6C5hUVISnOcmQ2bSZnZ7ZfHrtr3RisTsA3mcAnsglVB05xt@nongnu.org
X-Gm-Message-State: AOJu0YwMFCk4WZ45VKYbO2Hm475OaiBq9++VeToYYbn4UWyYnw5y3wtT
 +v8bvGjxDdddzqjn8siTYMKHLFXkgDrvS97j2sGu6/+ounBbaF2ARRNBWORwdS8MG2Y=
X-Gm-Gg: AeBDievP00bRa2SZyNhVsbskmB6ThpA50w8tjhkFBTn3d9+Qbs0SCspK/UtzEUrBFoy
 Fg2OSV8gn43NIhOCS24Afe1xY/HlhXV5YagJ4WMmtINQMDDvdTxioopanN0oQsX18+rvGRiwCVT
 kcIoS2T6rPtCnxtB8z+snO0PBstfm73GFaAUnz+70loEdxMkRpGzLLScIle4mpm13rJO1IZhw97
 K2TuPg7ouBmwREiKcIppj2RKi+Bn4ZFfkpDIhvB///vVwLifz8IyndIr9No2YgBQxjsgAEKbovc
 O+HQBN2jHvSGWSyjb8QpBXLgDYUlNCUJqhCPE7E5YM1cE00+CuwEwO3qdPdCy1FbsmLqh/8AoDy
 VShByqPWGAPumlq3Rm8pSgQQ+k27awNZ53eVtvOd7Jk5kfRpdEGxvOfjD77/OQRG5/oTN+NOTQj
 PX0HrjCia5Age90xZ884voKEOoIbpcYxwO+KRZaxVOs6+oI9MRjbJKAf1zH/YPMGBW5cBuFQ6U5
 tE=
X-Received: by 2002:a05:600c:a30a:b0:48a:53ea:13e6 with SMTP id
 5b1f17b1804b1-48e51f4563emr140984975e9.25.1778237329247; 
 Fri, 08 May 2026 03:48:49 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c157f6sm16266525e9.26.2026.05.08.03.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:48:48 -0700 (PDT)
Message-ID: <0c3efbf3-bf89-4798-8e9f-9b211ab9213a@linaro.org>
Date: Fri, 8 May 2026 12:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Content-Language: en-US
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, jag.raman@oracle.com, clg@redhat.com
References: <20260508102657.644247-1-john.levon@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260508102657.644247-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 8/5/26 12:26, John Levon wrote:
> This subsystem is no longer seeing any development, and the primary
> contact listed as maintainer has confirmed they're dropping support of
> it altogether.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a90204ae9..ce2b494086 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4429,7 +4429,7 @@ F: tests/tcg/aarch64/system/semiheap.c
>   Multi-process QEMU
>   M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>   M: Jagannathan Raman <jag.raman@oracle.com>

But then shouldn't these 2 email entries be removed?

> -S: Maintained
> +S: Orphan
>   F: docs/devel/multi-process.rst
>   F: docs/system/multi-process.rst
>   F: hw/pci-host/remote.c


