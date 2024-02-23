Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B75EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZnk-0004QE-8h; Fri, 23 Feb 2024 12:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZcp-0004Qd-4M
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:46:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZcn-00055F-44
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:46:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4127190ad83so7558115e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710375; x=1709315175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PxPBEWauCakJ6fTsy6wu5Rg+ufE95ZTHGLWGc4L6cg0=;
 b=p/tZH6VIAq8tbQtVC1rNn6UyVbkC4pVsi/02PJZu4vKex+avlkywKHpphI3X/A2o8v
 SWS4ytuJyxVh7IA/J9TgKRGfN42oznoyCQ36dbjqCOjo5BIy5vMehIIRDQUfGwY9Xeg6
 TZCbP3/Uj2WBFBhjzwGsEVBYK+CDEvhymB5/XoxjDBGIg4eQ0tKKLjE9Z/Hb7MaJgCBP
 +JmE4adOsbPwK3eIlAFeeXRvgLC7EQ+imeoSTXRbi1EGxOC0sxsOQSi153bJ/unsArwX
 yNaTOalLPmHTtczOcVxhA0dS+iqMWYa99AVp8bAXhphxpAcJhRjVy5M30zJwaaJ96uMI
 aw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710375; x=1709315175;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PxPBEWauCakJ6fTsy6wu5Rg+ufE95ZTHGLWGc4L6cg0=;
 b=qaGX5X4fgvT36WJh4+n6FG644WCPRsLbNQ+rLNEpsXppzT8+ognaKxGMDKywGnpg+7
 o0UquqwsHbTuba+dZrsNcS55OG3blWiEA4dPK78vtCXxCzaT6H3du9CnrCJzEaIQAFdC
 p14vV4O0hOfLaZn0I0cAgu3yArwTO6RogzQfJXZB7WUNbS3s3kSspO/T5oyaMvbX80jd
 lU9DMQdZT7sRH1/oYrVzZjlgchPKVY2NolCyYKr8z6paq0ym6fwUiHvt1TARaj9A0kF6
 FDKlOrqQ/DTGqmw4wUgIKUUdoX9O8geGJB5ybEYRG+W7BeasSHauVIBl2y14b0xZPr29
 36Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiS90NCdg4WqdCFcdEGCRVFfij1AAlowF5Q9TxK8ardfCALKcvR3bT0FvQLja9MqyyObjbKVUT6IHWtoICcDTYUGfKGN4=
X-Gm-Message-State: AOJu0Yx4KZF/OGQE7tyDUS+ClRN0QoclQrdBwIiU4R8mAYzVdB2TJOXU
 R1yywhF6jQLwn3xZ2ih7pAxd/uSYZMQQkmjUmO847PoCLC8W/fGjN76cFgbctoL7bZh1PUFTziF
 k
X-Google-Smtp-Source: AGHT+IECxfS+hXvdg0ZNv/xZBPFD/w7EJh3trgFuvPBopHyLHMP5SWHkgOSnuaieL2SnQgu+mBs7Fg==
X-Received: by 2002:adf:a48b:0:b0:33d:5f6a:60e3 with SMTP id
 g11-20020adfa48b000000b0033d5f6a60e3mr326728wrb.43.1708710375341; 
 Fri, 23 Feb 2024 09:46:15 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 r12-20020a0560001b8c00b0033cf4e47496sm3439369wru.51.2024.02.23.09.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:46:14 -0800 (PST)
Message-ID: <7a0115ca-b83e-4e09-bff5-06e85440108b@linaro.org>
Date: Fri, 23 Feb 2024 18:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nubus: add nubus-virtio-mmio device
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 elliotnunn@fastmail.com
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
 <99a3a89c-7a1b-4b14-b495-b96d59278d55@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <99a3a89c-7a1b-4b14-b495-b96d59278d55@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/2/24 15:47, Laurent Vivier wrote:
> Le 11/01/2024 à 11:29, Mark Cave-Ayland a écrit :


>> Mark Cave-Ayland (3):
>>    nubus-device: round Declaration ROM memory region address to
>>      qemu_target_page_size()
>>    nubus.h: increase maximum Declaration ROM size from 128k to 1Mb
>>    nubus: add nubus-virtio-mmio device
>>
>>   hw/nubus/meson.build                 |   1 +
>>   hw/nubus/nubus-device.c              |  18 +++--
>>   hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
>>   include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
>>   include/hw/nubus/nubus.h             |   2 +-
>>   5 files changed, 154 insertions(+), 5 deletions(-)
>>   create mode 100644 hw/nubus/nubus-virtio-mmio.c
>>   create mode 100644 include/hw/nubus/nubus-virtio-mmio.h
>>
> 
> Series Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Since patch tools didn't processed your tag:
Reviewed-by: Laurent Vivier <laurent@vivier.eu>


