Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCQx-0004xU-EN; Tue, 23 Jul 2024 06:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWCQs-0004jx-Ff
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:07:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWCQq-0007WB-DI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:07:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so26996805ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721729263; x=1722334063;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hWNd38hpN/Oe3dGKzEQXzpH/NbA1TscT1qkScfx6B4=;
 b=zkuOiTyZ2xKE68SyO+eLqgoQ6LzNxW+0C6HR1D8ZVCRmcQSL1E0XXm7sXIICZr59TJ
 kT6YGp4tvdn5rCeNwubP+kLjffky4TFHQVEUQil4niTQLX5VaqGNcjcdf9K4IS19QSyN
 OfSh8ZWVH33zS9EV9MbgYMBShFDBNDrl3TAtafedeYOjnSFv/ZwUyWMq2AZyKu0r/BCn
 2GPNd3HPNCSGkiMEVrglirh+SQjZl+b0GgIrqqsRV2h/pk5KKfYK/SyHNhLkP6hbeDIH
 OcWaLGPPtnNdR3rMhdjXk4ynb50qxcQjp7C4yUQYnaystyeTySGrgrlVzFCv5s2kYwaz
 2Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729263; x=1722334063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hWNd38hpN/Oe3dGKzEQXzpH/NbA1TscT1qkScfx6B4=;
 b=sCzJLP6bYfv8dKWhAH1i4lrFdPjPCAQRTJzJTukC/I/v7K5cIUFxlFto4oM80LN5w8
 /BsF/RDJMK6R9cnW+d3OEIGmWZs0cxg2Yk3W9RWdIA61YQ///QGAKARyH/RkCG6pIvO/
 qPwAa+ZejIFExeqswmT3ySO8QwyoGt4qqqUNE0ogOR8mSQsZ2h2IpuSiDAiTdZHHgefw
 xGwUgA+zm4OThSqINg8g2gXCApnIJu0Lmf9aEDfd+TytwBaLpV6yDAlgnd+Ji7gKwPQJ
 z/WHAm8068dFiJ/DdcAyd1/Xhm17uofKlrsQv2C6GTV0IjvWHFLUZ4SUc2pPVJXndxEN
 PGEg==
X-Gm-Message-State: AOJu0Yz1Nbhg4RJetoBx9i5q23TF4Yt3Kr+kWHEG5GS3GCy2Iw2XCA17
 Uuo0+uwFtNCmN9kcy0sMd5NkvJEMQnITPXkxY2nDD66/MGntHm4x1u1ILzfHPX4=
X-Google-Smtp-Source: AGHT+IGlU2X6XOsS8rei3ZaUUwyxQkBc/N+uIzikQdYUWX4JIwLcB6ABqopHtRQm58DMjuhUTeB7aw==
X-Received: by 2002:a17:903:32cf:b0:1fb:19d1:707 with SMTP id
 d9443c01a7336-1fd745735edmr70726925ad.11.1721729262808; 
 Tue, 23 Jul 2024 03:07:42 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f473909sm70325105ad.261.2024.07.23.03.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 03:07:42 -0700 (PDT)
Message-ID: <7f34567a-cb23-40de-9d86-33b37e887360@daynix.com>
Date: Tue, 23 Jul 2024 19:07:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] macos: Allow coredump generation
To: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <roman@roolebo.dev>, Francesco Cagnin <fcagnin@quarkslab.com>
References: <20240723085902.98572-1-philmd@linaro.org>
 <CAAibmn1U=47wJOYhhpETHZihTu-aHcohm4eHK0JqK3epSEB8jQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1U=47wJOYhhpETHZihTu-aHcohm4eHK0JqK3epSEB8jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2024/07/23 18:09, Phil Dennis-Jordan wrote:
> This can certainly be useful in various situations! However, wholesale 
> enabling get-task-allow will enable other processes on the system to 
> inject code, connect a debugger, etc. to the Qemu process. Normally, 
> this is only something you'd enable for builds that are specifically 
> intended for debugging. I'm not sure users running Qemu in production 
> environments will necessarily appreciate this - do we perhaps want to 
> gate this behind a build configuration flag?

Yes, it is useful but shouldn't be enabled by default for a non-debug build.

> 
> (Related: Would it perhaps make more sense to dynamically 
> generate/preprocess the entitlements file based on configuration flags 
> than have a bunch of variants of the file? You'll end up with a 
> combinatorial explosion sooner or later - I'm also thinking of 
> com.apple.vm.networking and com.apple.vm.device-access which we can't 
> enable by default because they require Apple to grant the entitlement 
> but which currently require patching if you have those entitlements.)

I agree. It's better to generate a plist.

> 
> What do you think?
> 
> Phil
> 
> 
> On Tue, 23 Jul 2024 at 10:59, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     QEMU is allowed to generate coredump on other POSIX OSes,
>     bring that functionality to macOS. Admin users still need



>     to enable the kern.coredump sysctl manually running:
> 
>        % sudo sysctl kern.coredump=1
> 
>     the normal users have to enable their shell running:
> 
>        % ulimit -c unlimited
> 
>     Reference used:
>     https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-on-MacOS.html <https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-on-MacOS.html>

It is better to note the implication of adding 
com.apple.security.get-task-allow in the commit message.

Regards,
Akihiko Odaki

