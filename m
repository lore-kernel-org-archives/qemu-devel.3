Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC92CE8E9A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 18:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t427p-0006lI-Bq; Thu, 24 Oct 2024 13:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t427n-0006kx-Nh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:59:55 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t427m-0003Kw-3W
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:59:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so674651a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729792792; x=1730397592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tIqDcNbYTVZWbfAuK5MioxEwio+QdY/1Sd/0q+D3CrI=;
 b=wkyShw3pN76cfjQddU7Q1p9Lg+ciBs3N1JARU6KJAWDdr3k4Cd40PDdWIENYFB9tXE
 VBF2W2uxkRxejKXecL3H0zk87KnhGcJM+K95wz0Llf3OCrUjc3zZNQtY1VXAWz/c0NS1
 Dx9Hp5Xr9G5JkBzg9xvz5KW2FzgQ2pSs68JQXej7I0mOKTLAXsHmAhXKYS1bN8C3tqZu
 5pBcxMGseaZvvad0RtfKVKcXrSTsE4shJKIolCqeMfIuvyeBQgABK1NWKA7xX7ZWr2FR
 w7kICtd2pPrMG8vxuue2i3zOXf2KP8nKJ7SauSyiT7sE7o6zOFqB42VclV/G3SaFzJWp
 jk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729792792; x=1730397592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIqDcNbYTVZWbfAuK5MioxEwio+QdY/1Sd/0q+D3CrI=;
 b=pIpQ0N4RHNoIc/QqVGM1g17KAQV4Aq+m7cPZZAB3kG9J4mrSjiZyTyFwqhj3oyEFt4
 FOly8pwX0n0oMCPxsNLArIWRy7h4H8lJq7sfL8FA9GbgbgKQTGzxlPPA9+9xZ/h5WXUS
 gpUf4iJh51pHW0KLynqI9x5ZfdwT9RRVTsOBdCLHfXt9um8QQs680ys/FoTJdgu8ENqU
 dV/v9U5eM94MFOwGyoPrkh32Uo8fsH3AzuOPFEB7Hot2A3BMMFUX0L81t6uEHegf71H6
 AmyeIFjAtmjYrYU+tRZ76ql307IXkBssS1erqnPr0Mwn8fVlsOn0xNyeORCJjwweLzy9
 s6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+wDIiJZqUcBXFOuAjY4SupxOpRaiqwimf5IUZSI9/vZyQXttMQ1MGvKZHIaGGHZYp88BIwsw/Zd22@nongnu.org
X-Gm-Message-State: AOJu0YwrGNC3vumq+MfSXxiM4Qyi7xT6f8P/azx9mUohKM1DzWAH0xbn
 8+Z+oSpgAMjKcxBO3wYEIkIGEFgiyTvJ2QnrsBz2Zs6zBwZvjVwoo6OORr18gDm3vKqmnGP9vcW
 5
X-Google-Smtp-Source: AGHT+IEwY08smMeD+hGJlqAjfyHRepsVOr5YNqZFkShf6Z1eN9KRiXykf65EvdGyRzZ0QQ5YSfymhQ==
X-Received: by 2002:a05:6a20:d795:b0:1d9:69cd:ae22 with SMTP id
 adf61e73a8af0-1d978b3de45mr8419283637.30.1729792792292; 
 Thu, 24 Oct 2024 10:59:52 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1312d6bsm8226672b3a.29.2024.10.24.10.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:59:51 -0700 (PDT)
Message-ID: <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
Date: Thu, 24 Oct 2024 14:59:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Guenter Roeck <linux@roeck-us.net>, Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cc'ing Jan.

On 22/10/24 12:04, Guenter Roeck wrote:
> On 10/21/24 21:09, Philippe Mathieu-Daudé wrote:
>> Hi Guenter,
>>
>> On 21/10/24 11:02, Guenter Roeck wrote:
>>
>>> Unrelated to this, but I found that the sd emulation in 9.1 is also 
>>> broken
>>> for loongarch and sifive_u, and partially for ast2600-evb (it has two
>>> controllers, with one of them no longer working). That is too much 
>>> for me
>>> to track down quickly, so this is just a heads-up.
>>
>> Please Cc me with reproducer or assign Gitlab issues to me,
>> I'll have a look.
>>
> 
> If it wasn't funny, it would be sad.
> 
> hw/sd/sd.c:sd_reset() calls sd_bootpart_offset() t determine the boot 
> partition
> offset. That function needs to have sd->ext_csd[EXT_CSD_PART_CONFIG] 
> configured.
> However, the value is only set later in sd_reset() with the call to 
> sc->set_csd().
> One of the parameters of that function is the previously calculated size.
> 
> So in other words there is a circular dependency. The call to 
> sd_bootpart_offset()
> returns 0 because sd->ext_csd[EXT_CSD_PART_CONFIG] isn't set, then
> the call to sc->set_csd() sets it ... too late. Subsequent calls to
> sd_bootpart_offset() will then return the expected offset.
> 
> I have no idea how this is supposed to work, and I don't think it works
> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.

Jan, can you have a look at this bug report please? Otherwise I'll
have a look during soft freeze.

Regards,

Phil.


