Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FA7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jrZ-0005Ig-BC; Thu, 25 Sep 2025 07:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jrX-0005GE-0z
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:10:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jrR-0004D1-GH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:10:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45f2cf99bbbso3740005e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798601; x=1759403401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liny2HRjDhzY3uSkfrMSt+/LAu0SDiqPN9EdKNvcux8=;
 b=pBytXiFxwtztGQFwifaaVuXY3G+5VbtR3ZfbiPib24vkJMLLgORE9KAlTAEF84VShU
 y5hWRy/EinCIUtTHa6aSsXptyX/rkWzuwZA/p9dZ/UqabcChUNQ65oFMerwHe4UEN8R0
 FCIqeQjRoyXb9r8pXSpDrCTuUBQ8vbzgFnhKdjEL6CmU2X/4GpNUEK0oUmbvD5fb+ZKZ
 lSvz3hvfX27A2GZi7/OMVzfDrXuvIxcSttE6FfR0OOOfMGrZOVPeJHhYspWUc39tkpyi
 hi1HIhKaagOZufqWB+/LOcsU0EnsaAgl8lFb6XLgqWA7XhrEgc/G6jRD2i7kB+RWBLei
 BpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798601; x=1759403401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=liny2HRjDhzY3uSkfrMSt+/LAu0SDiqPN9EdKNvcux8=;
 b=xHQbkhuNeKsv1VCe7D2yvBpHgtqBpGaJnNyjDuRZuHBA7MZRv2XpF62VcYwja1KU9i
 7xwxkQwB778C1QvCYvR0tcmT4D9+znzM9c6ySiBsuPyWmcF9PzVasxUZt7YVEMIGVS/X
 cvXWVd83i2AI82GFo86rG0eWxX0Hn5fmlBcv/GZOuMPTFNqfvr36QSYitrgwwxUaaECc
 qe6Ev9DZdJ9/LsiiecsB7mrgu866SW1sXdRR980WTjxvH7Bx0OTMDixfBoAH+Limx6Do
 Q+ubL5CZGCsfF+LXtMr8og82+4m0AUjLHBiWIXto05rdEQ5UPcEFFzse9mb3xTkCKscy
 skIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6sKxiAuuOkon7kG4EAOxSy78tv/nJteoVitPgoE/8v1k6V5PD0W6rTuhTRGmBprfAH1lmO7h9H+ad@nongnu.org
X-Gm-Message-State: AOJu0YwcPeeSGL3p0dRLp+TahA4ZVTkm5g/zltjFkrgCdSX5XONeC1mK
 mo+aNwYJPd6JeIPp6hGf+2SHGptboMIw6omhNqKmtarw6pI62EzPaZI+DmZPksphy1/kH6zDaXV
 Ue0qGhRzR9Q==
X-Gm-Gg: ASbGncuDJ7YR38GysifZhhXzQmasi+KqaHmTOk+FLgHeRn1wDKPCb27wKk+4bHr+9rx
 QphG+EgWCW7kqKk15UO6362WI0TCwFdV5VrF4wkziRUO81ldCDv79NDCcqD6heUG4gRCYW6j9at
 t0Dr20Hk29UYAHmujIGIqjs090tpUjg3Bl65Ojp722H31IHF8rDx+Bnru0j52g1aXDzio6GMuhA
 l8nRSikE8fFxlwCxflMrmH9BUb/hEyJtIDfQ9/n+muxtH62aeURaNQbJCHjl6YlJvg7cC0Dk6NO
 C5u1hpCGPk6pLvdJzr2FpkldYmYnZcYTZfiKgtrpAgjWhWuLNemBiFaQweKJS8mhFESCeBUl4SQ
 tuoijvyC/iNdcgjgtXWrBIcL0KyGYeaQ/pbxQqH4wAbP9X0ld8Xumh4JsGijwVNJGGA==
X-Google-Smtp-Source: AGHT+IGZiMO7p8NJ1xjOCpmMO3At0cVi38DKoubhA5df/G0RkgPytlRCwPG5XRrKv6FJZ6q7zC+9sw==
X-Received: by 2002:a05:600c:1394:b0:46e:1f92:49aa with SMTP id
 5b1f17b1804b1-46e329c6355mr30981965e9.15.1758798601079; 
 Thu, 25 Sep 2025 04:10:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be363esm29684185e9.15.2025.09.25.04.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:10:00 -0700 (PDT)
Message-ID: <6139d104-5b63-496c-9d6a-0d919737074a@linaro.org>
Date: Thu, 25 Sep 2025 13:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/36] target/arm: Split out alloc_cpreg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Include provision for a name suffix.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


