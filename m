Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1488C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIGT-0003IZ-1b; Mon, 15 Jul 2024 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIG9-00030O-Uf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIG4-0005Rb-7K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so23440945e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036672; x=1721641472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BOAqUmobpFO1Jx0eFtVmkOJtUM11wxqJzutKMTITd/I=;
 b=ieynYuFSnfbUL30WQMIeX5HhhX21RM7WPvRBqp0vVEaLIH3i9NSdDuFVPVWGvYiKU0
 +CaU50pYkgup8pAZ2v4AjboFdEcSUEvTjKIGwLpzk+/b4GYqKl3bNY8HH/ecoLj7yeph
 UsE1U64rsujASZwYoXuhJUenjBdaJdqLARMZcHoXYKdS2i5e+Oz8qXAaMhzFDKwn1p4Q
 aoc3odKNvezqVUOFEdf++BrTqu3yUA9sDETTdpb/W35OqzkeSYEzlW1mTOfvEh3rYf/8
 mCqWqnd18wgUhfhwy8hqOKmd3xMxNgV+wWN1blegPMJaNQD9NH1o/EX3xDaPFkAvXu3y
 Tp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036672; x=1721641472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BOAqUmobpFO1Jx0eFtVmkOJtUM11wxqJzutKMTITd/I=;
 b=H5sxflUnpjXi2M8QeW1zaJX11FCv9aSJcAw++rzaVCEf8WOe6Q/1OW25Z1Nm9KlOG0
 BXGcSwDUEjChpxFX6aKml/B65Flp7WZd5oJh/d4wMATfChBJSA0WC1O6QOerLT2UCIEU
 B8WuOQyX0VNoWmiJhJO650RopNnYCbb7q70CN08ayROsJDG88ob/qve2hjY+DMpetqri
 /rxFtUpDZUiFH6c4WkLYkClQ6+jnM6G0h40NzKMyIYq2fX58wTEcsgQNFfJJyNJ3xNen
 tF8mLmZ2kK/h3Pqh2hMADqhlxnGRXbSfhrz3D5HNwUiR23YZthf1E0h7zSfVIVnozRPV
 kAhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYna6/I9xQmqBtshnxfBeCH3smUARXH6tYing81Zg1mEzHKqle/2Ln/LgEEbME7yNHK5iXMfuxOGQ/QOmjnwKC4cGdVQ=
X-Gm-Message-State: AOJu0Yz+eOaY+s4Gvs1cq6gi81BqPaNAAlfwiGkQU6lyLN49eOIlHkbA
 jGNG2bkas4/0AbnGAsmFMR0asi+C8MXq8FL7rYo68eWh1vnTIflDuX/7Jy1I9sw=
X-Google-Smtp-Source: AGHT+IEXFsGo3BdrUqln/kFZze0xcuuDnqJbpOi3UiXGHCpQ9feWbUY7zpjv6vC5gT7SlF2ywvqEIg==
X-Received: by 2002:a05:600c:41c4:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-426706c903emr114944755e9.2.1721036672455; 
 Mon, 15 Jul 2024 02:44:32 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426740d88bcsm165008935e9.1.2024.07.15.02.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:44:32 -0700 (PDT)
Message-ID: <9946ada2-ecf6-4a4c-9415-915d400240bc@linaro.org>
Date: Mon, 15 Jul 2024 11:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/usb/host-libusb: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-3-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/usb/host-libusb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


