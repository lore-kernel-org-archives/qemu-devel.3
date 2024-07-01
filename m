Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E669C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFiN-0006Tc-8N; Mon, 01 Jul 2024 08:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOFiK-0006Rx-2W
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:00:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOFiI-0007ng-D8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:00:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fa78306796so15281865ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719835253; x=1720440053;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I5/cTjbx6ccIx0KbA7CLNKFyoTGLHeqIz/s3wNBoNMg=;
 b=Oi9K1JnkeVZN1A9noDMJdFrr2mCnPL/G7spKVFIQMKTqWG2YHLg5PBAmhz3I/QKGDE
 xpAv27YzSlrOJVZn1YfFfuRtTEez63ErKtYtvRb8Aad4Tb/XCECI7IP6jFqQGvrMh7Xx
 P88VpAbwInJfDSmISPqd6PJmWh7iww83LHCbLeLtJriMX7hlZJgOg51vbGd6Z5FFNyKx
 F5kzRRUiB6clvXm/W8Tgvv1cxp0IWqm2VuiZB/ZMGlMG5g435YJYeYXuqyMSvPg+6FzM
 TEdqtMvPVvcyfDIZdb59GLIId154CHyMle8zRH9tSM97C8KSTZj4mNU6M5vowc22lar1
 H6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719835253; x=1720440053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I5/cTjbx6ccIx0KbA7CLNKFyoTGLHeqIz/s3wNBoNMg=;
 b=QhgCujpye6bJ5a1OVE2skves9NGGPoM7xu9halSZ5T6I2I7PIY4KVCXwyV726d9VkA
 4Hqw5rsl5J7USwi3WDUr6aA/Eu4EjYsH5jogDDSwwsT2DgAPJvV19DQ1pVE/6y1zzFtb
 Qgtzbai7x0Yw6rr9j1Pg+DP0wR8v/R9wkJ34qBX4wtdp4X8R+AA+9Tswa611Y32TfQUB
 UyjQNfqXmuW95Ob5wRx3ve+M8xDII1rUZyeza70wDDhRFYU6yfzb2p7GtFms77Vjeavi
 Vr1JsLiIBN81CaRjs9xYh66ytv+UKNhsKyJVOQbwEoH1aKOBASCBRNYPPMZWadKi4bKB
 uxrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwqiNJsj/65Dv/lEKJfkFlXsgPazx6l+nud7NpQiPqy4ZvAMVlS/7Th5N3P+QjBMAVLIzcd47ElR3bMtCy1SOncwvCeM4=
X-Gm-Message-State: AOJu0Yy73OsTtK1NaenzzfLQqeOZkXtLig/oCr7wp0aDkX1tjrlxhF/g
 eMbV1SPp5Ckb8nzB2FvfQLhlou4E6Q+5YcrDd00drZZINfUwh9O+0Nn3/Pr+aDU=
X-Google-Smtp-Source: AGHT+IHaeRJ6bditod5E+/jy89yz6anpW3/Hpt4qejruZ0U/E2R3zRrdvnC5WB+570FdMhBMLVg9jg==
X-Received: by 2002:a17:903:234a:b0:1f7:1ba5:85ff with SMTP id
 d9443c01a7336-1fadbcf4103mr26726735ad.57.1719835252635; 
 Mon, 01 Jul 2024 05:00:52 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535d13sm63275195ad.165.2024.07.01.05.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:00:52 -0700 (PDT)
Message-ID: <4a83ba64-accd-41db-9d88-2c02a8ce541f@daynix.com>
Date: Mon, 1 Jul 2024 21:00:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <CAFEAcA88ALQNOrdCmMV5z8mNN2hydarMwSx1P-43Hn7hEzca8A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA88ALQNOrdCmMV5z8mNN2hydarMwSx1P-43Hn7hEzca8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/01 20:43, Peter Maydell wrote:
> On Sat, 29 Jun 2024 at 07:26, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> macOS versions older than 12.0 are no longer supported.
>>
>> docs/about/build-platforms.rst says:
>>> Support for the previous major version will be dropped 2 years after
>>> the new major version is released or when the vendor itself drops
>>> support, whichever comes first.
>>
>> macOS 12.0 was released 2021:
>> https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/
> 
> 
> Further, we have already dropped support for macos < 12
> in the ui/cocoa.m code in commit 2d27c91e2b72ac.
> 
> For the whole series:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> PS: you don't need to put a signed-off-by line on the cover
> letter, only in the individual patches.

I have been using b4 (https://b4.docs.kernel.org/en/latest/) these days 
and it automatically appends Signed-off-by to the cover letter.

Regards,
Akihiko Odaki

