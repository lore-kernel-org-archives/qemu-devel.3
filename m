Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E78D6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTb-0000GY-B8; Thu, 02 Apr 2026 13:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTT-0000E8-Qp
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTR-0000h1-4q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4888375f735so9553275e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149491; x=1775754291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmWIUBtLQhZg6Fk5PRpm7hykp4J6Nl1LUSsnQTY160k=;
 b=gfbQsCy6Dw7CdkNFefYgQDkQzn2uL8QS9QRCy9z0/tvqZ1uAnl/GbH2hrIR/sGgkav
 1sTy3WBdiaRI9vJn/2MvGVddIbjlp4telUAMCw4GbpOCrxaD1qh0hK/0ROqf+7LYBZ0F
 PhZ129rGHAVJW9rjkWG3mJetnkgHfVA4jGW3jsiF31wKcJ0cs0JH7JRWwKp9EwRXExg3
 YAWQcQCMKbxl18T9czcbFF+aLFzX2QuDOCWOf7D5fql4EpjNt1CYIhW2XiAKsH4vgXIP
 gsy5QOuoN1QV1eE1J+kBNgyg2fIQEdhY0nGqFlqcR90mQezGGiwUWnlZ2xs2xlfF0r3w
 e77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149491; x=1775754291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WmWIUBtLQhZg6Fk5PRpm7hykp4J6Nl1LUSsnQTY160k=;
 b=bQMIzb4XL/KtMwZv1fN/tznbHuK+2Wmj3ynSaXMrGskSEC4Bj+hGFTRvx9++DgqQ8R
 SfAZVrbb2SjhLncB8EP3m00f3E0fIn9Fa6cCfPKnGZw4OG5To9Pnn/ImvNrRJ8HuDGWw
 K7eyDHYYnAfNbiwIAdd+5VRk1tqeXZr40sdbjHiBv4u0R5fPh4HJgOZPCu/liUW5eUPn
 gBMwZPPzbhej14rQ2eEKpLmlS+Dfdc/snre5opoHkz4hlGSWSSRLOta7uhVZUk5mP4Sy
 b1DJUHcVIe/pKqQuH6ixxVZ98r/pHdR7MRGg7+JueiAUuFxgwTYbW7zSrrL0E+AW+/+s
 a6qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFDWx02TXanMEamd7cHTklWwyjAZ/kjFdSH/fwlBSXa8jE4zAWsL5eBWQhDuOFbMRsYmIh27aOIOkG@nongnu.org
X-Gm-Message-State: AOJu0Yyv4s2Vhud44yr2+t0X7sCKe9KmD0N9oUFbsRTXQmSugg5YreQv
 qX2kq4GBUEnwQJkDjOnufLImVms8zD1Y1BWGC+h/d5QrTe8xDkwVNCjeC6C2C79DqvU=
X-Gm-Gg: ATEYQzw0/NE2sueWYbtvHCVraymHlV/JcrqNaDUyoGoLg5XMTZP4f+fpwWhHLJ60rT9
 nIPWEsJVl/9g6fsbLVt2hxkTXQo6EwC3OuxQeqRWtnblcVGXc6BX/8XXexmrQidxmAsFKGDqlKv
 Z9i5X8InXpZ73KSf4iVWlvI+76s5b798QHyK30gB86FEZT5rok/iFFjuMyeHW2Bnxu21tvZ4tS+
 rhvIoZmGllmNrw25u1qSuOkX3OcQUPtSAVyBReItkr2HA5Bz/f6pOrfYEhbDFlzlacc7+47vFP5
 gm6UBlD349wFSg5iKi4PBA4bt8jXxEjIpj8pQpVr2heNraaauGUsEhX12R79M7ZUZ+bi3EaTP7S
 6L6A7VLg1BbDfVn6kBKBMftmZh7BrNW5OweXagNyR/KuIRH7jRlrENofuIh+hgMmRpJK6k1UdXa
 8Tr8uLtvXg34+ekmXEZc8kPUdqJ7WMhUJVbrYeyapch8/PBv29xjqsOO/HF0wGRrvdGg==
X-Received: by 2002:a05:600c:c87:b0:487:13d:4e77 with SMTP id
 5b1f17b1804b1-488835b790cmr136460145e9.27.1775149490588; 
 Thu, 02 Apr 2026 10:04:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488980df5afsm823325e9.6.2026.04.02.10.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 10:04:50 -0700 (PDT)
Message-ID: <9f7d4633-d841-41e5-879e-bc30b331e934@linaro.org>
Date: Thu, 2 Apr 2026 19:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cirrus-vga: Make frame buffer endianness little endian
 by default
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260401205327.914905969EC@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401205327.914905969EC@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/4/26 22:53, BALATON Zoltan wrote:
> QEMU VGA defaults to target endianness but real Cirrus VGA is little
> endian so set it explicitly in cirrus_init_common() to fix it on big
> endian machines.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/cirrus_vga.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

