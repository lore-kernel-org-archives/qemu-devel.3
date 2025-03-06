Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61739C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqD4Y-0003CZ-Gx; Thu, 06 Mar 2025 10:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqD4J-00037j-VP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:23:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqD4G-00037r-T7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:23:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso639697f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741274603; x=1741879403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g5xcyUTC2FBBC8ws2EpJP55hOAobvLUj6F6GgMCg9g8=;
 b=btyTM9dCNraKwgpug9RMbp2WXkWnUEzslJkgZQrNS7bEu4q38ioB10fJc05iQn9tTh
 v/RUxP7DhFpghhq5FzCyPYDsZ822pMO8FqQoNQ6dKa9dtIPQs2cLiyMmmD9c7Y0U7V7g
 GSOfTvV8Ql/jZx6FqsTd4+t20fxKlKsYLmqNRSLQLTcah+TSEGwLSeWiPf+is3SgzMS0
 6FIeWQL7D2yULN73VBEBnzRqSSvCH7SHJqgELNLPCnCERPdINY2NPLDEoR7juqyiX150
 9jRODODj6NtFSOFif/LDVYavjYD5Vd3yValUDSTdtzfDwu1lVimZ/Kxi4lOJyVWAufxJ
 cuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741274603; x=1741879403;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g5xcyUTC2FBBC8ws2EpJP55hOAobvLUj6F6GgMCg9g8=;
 b=vjpsvhmMduWhFXz/demigMxsJOlNajR3vAWHFghiqnwMkN4MJGqMjYd7N7owqgm4D0
 r3puezNAX/Mqjg7e+0/eS8QztiXwBTFVWfqK2P1ms+RlADaJJXDX1Mpz5020aSc/s9vA
 hYCNzaDZsW/YtRSmHIVrctmKGRr5KhksuzWlYRJMFkxULt0Mt03JsBH+W+pl8Vbg2IXv
 Zi/lM9Y+lDvSiPJTjVqR6asH5vpQ2GO5d4xR8XIMvKOIIPc53R/eQ711FATuw4fQPYh7
 LPjk54AP90qB+ikRINFn5qk89X0S+HzTdxRWnBT6EB7IjeRwHnD6Jt9jBMpKZEe6Rv+E
 l8MQ==
X-Gm-Message-State: AOJu0YzSoafa+S+bwUuUwnFyp0X5T8mCW5Ql6x93S8e59gYReVgfneQm
 n8B18Po81VHJEJiukCB07bL4drPYqE9MPmGQV2fRlsrRGT14SgREwWyu1BgxW9W4E1EAIEZeP3+
 zlCQ=
X-Gm-Gg: ASbGncuW1jhekRyK8S6cpWerAVZEsBf2B1QbbJsU7L9C8ZNn53zspbJ5cyrbBQjOilk
 6o9RomwkCHIZyZ981nMXOo5pwwxNX8DcGp2Kj0Z0OdkLpyRENn8xuWtK7XfA5E14u9hDpNMaRfg
 BkT9wye8Axe1Jy3vlM+C7mXt2hdA5ZNmH5jOfUyqDfHSOQpQ2DWcoHK7kcTiRs7R0OkonouUD7w
 MXyWSMiv+BzurQIp4LdNMuRomf+aF9lSRHu0SD0mvos/QsGOsQORCmDS9WfxBs/FRcXpEDkoEZi
 tlW6gMETRKEwHatzyUm1A3qzD6zAvr1r3xesRCqJm/LZ9vnZe9eltysQ5A0bKSWS4kIfSG9eXKH
 7nzahiCY/JzKi
X-Google-Smtp-Source: AGHT+IE2dqcwRJN4hjnydYUrObO5vuLwuF0s5ftMLDJyBC+igVKimxEznfqmxqNJD3HksLIi6vfo/g==
X-Received: by 2002:a05:6000:2a3:b0:390:f641:53f2 with SMTP id
 ffacd0b85a97d-3911f727717mr7139594f8f.10.1741274602720; 
 Thu, 06 Mar 2025 07:23:22 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292b06sm52822905e9.14.2025.03.06.07.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 07:23:22 -0800 (PST)
Message-ID: <a40b4790-27bb-4da9-9472-238768cdca44@linaro.org>
Date: Thu, 6 Mar 2025 16:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] hw/ppc: Remove tswap() calls
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241220213103.6314-1-philmd@linaro.org>
 <2568d2ea-8437-43ef-9d34-1fc1f2ae6242@linaro.org>
Content-Language: en-US
In-Reply-To: <2568d2ea-8437-43ef-9d34-1fc1f2ae6242@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

ping

On 9/1/25 13:54, Philippe Mathieu-Daudé wrote:
> Hi Nick,
> 
> Ping? (series fully reviewed)
> 
> On 20/12/24 22:30, Philippe Mathieu-Daudé wrote:
>> Since v3:
>> - Addressed Nick & Harsh  review comments
>>
>> Remove the tswap() calls on ePAPR, and convert
>> them to big-endian LD/ST API on sPAPR.


