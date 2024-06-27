Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64120C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgy5-0003gm-Ab; Thu, 27 Jun 2024 00:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgy3-0003gX-BM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:42:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgy1-0002G9-O5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:42:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1faad409ca7so1126435ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719463360; x=1720068160; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpA/8GTrVhILCYAp0oUOeJWgAJK2/J6X5buypLhyo7Q=;
 b=lnARci7ZeYMJqSHhjVKsmOcscjok79qcqGjDRMdJPxqfvEn2xOP6+BQAnzuiVP3LqJ
 3RSQGchBfwQApi6vV2K1uwA0pBmIeSS2hqDiGM3dYZnSY9lNbULdIXmLCZqgrVxsIDZ2
 xWeSsvyV0rZze4rCrCibGoNBEQLUUrbRoEyRMd8RT72hqEYz5Syrcu/3QVcNU/+ySysl
 0NvicbgWHzIFxsPTGnVLWdF9H10fu5CypqAKdpGmS2f6mdm8Ag3FWk/De1BrsAqWXhkP
 PKBRJcv9FbZKexheGOXfLhGtOSbmsfXUyRfRlI3N0UdQvIqghvYuo+wkIGKx/gX6Bngq
 dj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719463360; x=1720068160;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LpA/8GTrVhILCYAp0oUOeJWgAJK2/J6X5buypLhyo7Q=;
 b=Dj7HGH+RsuvcwVsVBIf03FTHxJ8tE/4irrEBIwXXKvxlKTRUFoKoK6d0bqzLxgPXDr
 Ce3VLytwrj1lMw5YXtzrcgJK29J8sQBv3jq5c3+Wh+4o5yf48jbcVmq9ctEfEtWNYhiJ
 8GSju9nQhQRs+lOh592WOJ/D8cEWwo2Ntlv9N6syaY0/dcKrXj+EiX9gqX7gm/QtxtfP
 xs85mO5UhFhoCqwT0vmm5hDbx/xBsKTc3Ed+S7feQ7DmEbSMk9cmmqejuz31eZnICyyP
 /pc/03stCeJuwPv3p2smy7BNCVFzxcbPoADb8refUqBGUzF2jwEWIEvkYbuOR1FxL+wA
 7f7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVDtaHHBsD6eUEGamT7vPCt0CEgzN+BbBQ5Wr9GhkvhzkLQ3imRchPvCHK4AwHMQOrvD4580cSBzNwgDQzigIJpP2DBrs=
X-Gm-Message-State: AOJu0YyRx3zTZ55JdUJhMKDnw9HW7RtQ2QZwP9HdB/gLZlM00wGGzHlY
 DhznY6GNDMqmuGSiIR2j15yzZd64n2MawbJ9X1JQd5Bv4heJd5MYYB1iLNl5GyN9h3tltjVrxnx
 x
X-Google-Smtp-Source: AGHT+IGLMbW0UUxG39BkcwC1M9WzPC/LKtM2UFq8pB8wLtMZhZlteZl4ZeOLPtOWeM8QcmPshfGfbQ==
X-Received: by 2002:a17:902:d2d0:b0:1f4:6fad:ba59 with SMTP id
 d9443c01a7336-1fa5e674ea3mr124626105ad.14.1719463360003; 
 Wed, 26 Jun 2024 21:42:40 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df87asm3374305ad.14.2024.06.26.21.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 21:42:39 -0700 (PDT)
Subject: Re: [PATCH v4 5/9] target/arm: Make some MTE helpers widely available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
 <20240624053046.221802-6-gustavo.romero@linaro.org>
 <bdb11f59-43e5-4715-adfe-1a1a4d7bdf1f@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <35ce58a7-8e2a-74d5-5715-56f69953cc27@linaro.org>
Date: Thu, 27 Jun 2024 01:42:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bdb11f59-43e5-4715-adfe-1a1a4d7bdf1f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.112,
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

Hi Phil, Richard

On 6/24/24 4:47 AM, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 24/6/24 07:30, Gustavo Romero wrote:
>> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
>> available to other subsystems.
> 
> Again, you can make them available externally by removing the
> static scope. I'm not keen anymore on inline function definitions,
> please justify why you need them. Inline functions often requiere
> more headers to be pulled in, and behind the preprocessing overhead,
> it makes header maintenance more painful.

@Phil Thanks for the clarifications. I understand your point now. I've
removed all inlined functions in v5 [0] [1].

@Richard You have already reviewed one patch in the series that had two
inlined functions, load_tag1 and store_tag1 [0], but as per Phil's
request above I've changed them to be non-inlined. I kept your R-b tho,
so let me know if you're still good with it.


Cheers,
Gustavo

v5:

[0] https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg05089.html
[1] https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg05092.html

