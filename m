Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAA7C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWz3-0002mQ-6T; Tue, 18 Jun 2024 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWz1-0002lc-JZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:26:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWz0-0007gz-32
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:26:39 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f0e153eddso689075966b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718709996; x=1719314796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YQudNKu8azyngKUCk1mtQWfq8HuQzQWFYAVBeiFwb0c=;
 b=os016mf2VZMCOTFzp1xCUg/iD+Aa/0gKZwN3D/Tq8rU/jx1Vh+EiFZvGD9TvOCTWAy
 gBUt46QrUmh/9qjWvJeN6QLMH0NExznp8k+Iqx0xKeRzzPv4kI0TgGAU1Fuy+7MGp70H
 aekaUuddRUzM8mRsPb1kAh30p9TapXX/2yFcuv1RH8M7H10q6H7UQIObuFCGJMI2bpEz
 eSPhh+N6tbWORdR/c0KNufGr2mvtANp6Df/Qegfp3P4dI7a6JfXJG4S8ekh2xnk1Slws
 qwYsIDkCSQoxv7QUCh/CIka2e3mT4vIRTmfXizcizQB/BF3Ym4PnU440Ark575HjdpSR
 bImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718709996; x=1719314796;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQudNKu8azyngKUCk1mtQWfq8HuQzQWFYAVBeiFwb0c=;
 b=Bza/NrJaNY0e2Rszas/SMliJuR1qH3ge7b6lh3Bky7yjh//rTFOgIzkF/PknJ3Ug5V
 +LTb0+WF0wySlau3jxDG7mBjryKpvOZG90ufSh/TUwZ7GWydzKdWUAoe2MwJdSYLaJS3
 VHj3eccbsD3xUSxyvcLH4rqsZklWnMgfUQQ7iFVElXoBeOBGWFmaHzec8jp//SvWox0I
 4EIxwJSwHJ6di7dxsdDGuOqlPqWbz2hoPWk/GoH6ebbQT5e44H9MDyBbvutf8VrOIXJC
 sIxi8ItGvjCZ/in1ZAxd/6tCW3VfasTG/4sTNft5bZIyS3vFGi7re4/kStC3U8IBBHZP
 N/Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/9pUlW8MFOJYENRe7x6POAgAyq9rVAVJ9RHZj1ry4unP4jQnQO3XkVrFI9RpyJiaHojdf/1XXmFM6UrlPPnXXzl5kdZE=
X-Gm-Message-State: AOJu0Yw4hHvslc3JyGt5j19mY36rPgu2fz7q+GD813Kq1YNFhu9KCvw1
 5a9w9M/pTw/TPl9LkDs3V1sylLylSVGGBWRP0G4CkIjXhgrhJAxr7+ub+Rbgitk=
X-Google-Smtp-Source: AGHT+IGIhE4STqqsSjoczdR272GhuTGkmZ1sBHQsEPLnq+3QQ0YGovxId4x7pe13UlvsJ7HgiKmfeQ==
X-Received: by 2002:a17:907:cb81:b0:a6f:6aa3:e378 with SMTP id
 a640c23a62f3a-a6f6aa3e5e2mr724114366b.38.1718709996449; 
 Tue, 18 Jun 2024 04:26:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da3faasm609439666b.5.2024.06.18.04.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:26:36 -0700 (PDT)
Message-ID: <e66104c4-6284-4182-9886-6fefbe39fb7c@linaro.org>
Date: Tue, 18 Jun 2024 13:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] meson: Remove libibumad dependence
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611105427.61395-1-pizhenwei@bytedance.com>
 <6a09ba76-ce94-4a98-9826-3aac8212bfea@linaro.org>
Content-Language: en-US
In-Reply-To: <6a09ba76-ce94-4a98-9826-3aac8212bfea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 13/6/24 11:01, Philippe Mathieu-Daudé wrote:
> On 11/6/24 12:54, zhenwei pi wrote:
>> v2 -> v3:
>> - refresh lcitool after removing libibumad
>>
>> v1 -> v2:
>> - remove libibumad from tests/lcitool/projects/qemu.yml
>>
>> v1:
>> - remove libibumad dependence
>>
>> Zhenwei Pi (2):
>>    meson: Remove libibumad dependence
>>    test: Remove libibumad dependence
> 
> Series queued, thanks!

Dropped since already merged as 829858f4f2 and c0cb5ccc35
(I had fixed the typo in subject but didn't mentioned when
queuing).


