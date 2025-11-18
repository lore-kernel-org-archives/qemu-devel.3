Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E75CEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQIa-00026t-Eq; Tue, 18 Nov 2025 13:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQIZ-00026h-5j
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:19:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQIX-0007on-CI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:19:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so26905695e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489964; x=1764094764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oX4nBcOixFPcuQ+ZnKJFA3Mq6nOvTUGekeiK4b8ii4M=;
 b=fPFTQset5ii6TZcFJIvACql+VKrU+nvIkrayp4UKUDujInba29qKGq2b4akeEJ20g/
 0mPtLjQ1Jt7/RaeVhqTUskBofhU26Jc7/nbeWk+1l9syhIRvagPeqrrVnxyIVwHWgOj8
 Jxs7tccPGGFsSslxfqsdqvRyLQrP1JXo6sjQAPfmP2OTkSCg9gV1/Z8VtchWxG6Pjo7v
 75wTCqjDAbB8zfZewflNY8SmZVqWE8e7cCmCvCn5K6EG3ATjTe/AFiB1wg606qTGP1Zq
 sMIFQd5m9vIPVkcMab3R1WzZxi+6G4C2KWwnm1G5TIdmLDtfBBtMAz+jVW9BexASlBA0
 onhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489964; x=1764094764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oX4nBcOixFPcuQ+ZnKJFA3Mq6nOvTUGekeiK4b8ii4M=;
 b=Py5BlyMkWbZ5RzQpmDZc4xlKbc0GBrzLBugBIvNU9Cn1v8xmx7jcHWcP+Ts8qCbz+a
 J2ngoS3Ue7hohjttdspZzzhFtW5bJjyJg7eRu+kqLXbab/jXwE4IdDH2NlyyYqlQ4xaQ
 GkkZJhBui+muPZdVRQUP5RUY3otiC3KB4B0FaP+PQSv/ya+pe/35G3em4n4Otc04YGFj
 zimCKHSxwBCeYusXMzVeHMkJBWRELdG79QT8Sei2YXLDXxIQkty29E5OGOyv/xQq3ssO
 ZE+PvdmpNIj+6qKkfsEfAE4qx+B9KhjKz6lSKTNCk4cz0rpEb1PuqVd5+HGMQPJ2d2DJ
 rB+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl9gQTVBdf8uPOyvZrIcW9uHGwxU4RIjBUbM6GTN7UnGGoMWFRyc1Kypn3BrbwFx+2X/eBEObcbC9p@nongnu.org
X-Gm-Message-State: AOJu0Yx7RwU0OqG7Su3Lu6rboxPUnq2q2g/Y/cATrp034q/qraJtxWE0
 LlpF7c1RRSGTb/STZTjOduELXpQDg5NRSfyAtmKUOz/xRV5ay8gdGOhESgYQLE84wIk=
X-Gm-Gg: ASbGncsD2XPXphoG33HAIFPnWjj8cd+pbGarHam2inQJX4mmGrYSWjGckKLEZU7Pfwt
 je4aEFbIT0aikLA+GNquHCqjyMEZGLzSKu9V1dHDpZeCNgfs3iXwwjv2v0pAFzJTvoNczXHafUN
 a/zh0SeQ3H80/jOxWm+ocOz936M05zMFNR43bDJRuzwhQarTCJnQ7Oi324H110AYxPZfRiugnMj
 m+R4uNC9sTmXMYVsa94MriKO91M9CAZ0ijbbZeKBOR5DxRYar7/9gmeGbM5No4OojPKyuTCkFuP
 eM4JgcA0WxM3BYLFxdix2mRbx6xD8GRDkKbKohu5xZwlCbRDaYp5L2Xpjcxusnei/JDIh+jZOTo
 ezBKAtiF6kDTUKKZIZAbxcVUd7wYOj/7U57gqbjtiT4NlXhIJvjqbQRK2xeljeOk/Lz57tZPVm3
 /pyt9pNEXzNxjZ58h2RZ/3Q0I1sSWCfjRBzUiKPyTcsR8EXRZAo2pm4NM0jRXDU4yi
X-Google-Smtp-Source: AGHT+IFKLJQGmJNTnSgNbgHUAgD4UYfbPHEVi7bCm5l5KX1VkWVR0Sebl1snkWy9IIRC6vETYynsiQ==
X-Received: by 2002:a05:600c:4f51:b0:477:a02d:397a with SMTP id
 5b1f17b1804b1-477a02d3af1mr90646285e9.2.1763489963960; 
 Tue, 18 Nov 2025 10:19:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9d21591sm24077725e9.2.2025.11.18.10.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:19:23 -0800 (PST)
Message-ID: <5a5ab812-872d-4995-8cf9-59a7c7f6b452@linaro.org>
Date: Tue, 18 Nov 2025 19:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/sd: Fix broken ssi-sd implementation since v9.1.0
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110110507.1641042-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/11/25 12:05, Bin Meng wrote:

> Bin Meng (2):
>    hw/sd: Fix incorrect idle state reporting in R1 response for SPI mode
>    hw/sd: Fix ACMD41 state machine in SPI mode

Series queued, thanks.

