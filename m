Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE307D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOyA6-0002Y0-Rp; Fri, 28 Nov 2025 08:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy9t-0002GL-8S
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:05:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy9p-0006GF-F7
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:05:07 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso1481579f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764335103; x=1764939903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jb6la3CAFKv7XaA7EfMH6M+sFcJFlMF0KFvlfRLsjpo=;
 b=ZSuuj77ovU48WL6sWidyZKv+KK98UxjqYxF8FIhDtJD0sw9Xvb5v/S6NzbkO05HrWN
 Fka0RRUCsIlge5f8zowPtmvfcKkfm0GoLuyftCmVCyWBRBVYwWSKfAkuE/ViHUtOKGUw
 Wd4mKx+UZK5Q7D09jFTheHUoCT1I9IRtU8qhTUNKtn2E0oQTrNUtHSM4VWGGYfMvnTvZ
 eB7Fc1YzkzfyUD2yMa7tH4fmSF8m8JyTaTExchfvjsn54FaLEwE9vYBx9wWCTXT0TC/6
 w5QUWyGav8Ejdm1zY+wA2hpVdMaH1VycnL1utx6k4s5+X9QYGImXTCSseN7tmHeM6/WA
 sMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764335103; x=1764939903;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jb6la3CAFKv7XaA7EfMH6M+sFcJFlMF0KFvlfRLsjpo=;
 b=cl0yDe/HrWQ10DPm7c9psYvKf3FsD2e4y6NWI+xxW3LcwQd9VUryg/VKIg4WinXHHT
 SeWRiOlDVmnEcXEmNlhFFenuurvC1jkf3WyUygr787M7q3EJAhwOVXGMFsY/erHkOWrj
 yKg52c8rNP1UaFYAiUckepmskxgR6GmMcjg8/ZVSSEaZQxAt+iaa3BzQIVdDNlmSnjnX
 Gt/maVzgl/k3Yb3bN5/cbVRFpnZU5Tsh2/gBTxdzMeksHJCeTKEWSJOV06NxAoUFBPjr
 gRepDNYRQlIvqLEnDIE2axTbMI9YBY127Immae+SAbcQzxFgct1BkgFnsqQM53BMOOQI
 drIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVXei0dFvRR+qToY7Fa2eGtUxQ+8ShtSF3XjrTRhiLikD1FHe7RJVmEYaEEQVBzNv/11SRz7FQlO+j@nongnu.org
X-Gm-Message-State: AOJu0Ywt28BbrtnRCGQX6nR9Mw88ryKZWjaGsV+B1eEVkIlcBKWy2uWq
 UmbrXK1iZKVCMLPIetis7HAoFTV8aV6L/QfCwUI8LW96b7E1/e7QnwnMkfJ97xiSHBs=
X-Gm-Gg: ASbGncu2LtNENFaZ6L7h+4gvTUsc41tEMtjXT6h2tiHPowmymG/af4uxo0tpYt+mx9G
 H80/GQ6StWt5vQmoWB39MLlrFz7aixPna+fOug/f6+xy84Ar1lvq7KsTNqjITO8tSHY1YqMmt3d
 Sw4PiM1TdXSKXcr8MODc6WG+UGQk94HDmTZ50n0Bq41+ZeuTpbl5f7hT3gef/y9UA0TzghPTtQx
 0h6rMgmcik1HZ0SiOravBoQiWjNaJUe9uwYiZRoX5XMFFsnGQu6r72XZMkOs3bJmH94cRImrtiQ
 OVBdcbieo95Wr8ykzep27mI33veQbs+QvmLIXd1y/TkOwbk22w92e5QVasaCPn+5+yclsjF3CW/
 1oVzV5PxypdfYOrDcLURuZYzSEWt2aEWkoFoAX9eITHooFBtg0BeO5TMp2RTBcm1kd6+YDLuUHh
 fdpLA45HOFAcJwrr5JgU3F2kbwtTa4IXxnvjqsd44i+DKUE723ZEtZGA==
X-Google-Smtp-Source: AGHT+IGML9yv/VDC/3DTri/RRWW/BkVK74aGUHwvFS4domJLFWlARRlArKtmxiUErmA4dQXzV2bzMw==
X-Received: by 2002:a05:6000:2003:b0:42b:3220:93e8 with SMTP id
 ffacd0b85a97d-42e0f35935emr17518596f8f.57.1764335102840; 
 Fri, 28 Nov 2025 05:05:02 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c30b8sm9637577f8f.7.2025.11.28.05.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 05:05:02 -0800 (PST)
Message-ID: <d2870199-cc30-4268-b7ce-1ef9dc5ece16@linaro.org>
Date: Fri, 28 Nov 2025 14:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [RfC] edk2: add qemu variable store firmware builds
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20251128092602.373747-1-kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128092602.373747-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Cc'ing Michael and Daniel

On 28/11/25 10:25, Gerd Hoffmann wrote:
> This is somewhat related to the bigger question how we want move forward
> with firmware builds in the qemu repo ...
> 
> qemu got uefi variable store support in version 10.0.  With the pending
> edk2 firmware update (patches are on the list right now) edk2 is new
> enough that support for the qemu variable store is present in the code
> base.  This is a compile time option though, so it needs separate
> firmware images.  This little patch series adds them.
> 
> The big question is if we want go down that route.  The images are not
> essential for qemu itself.  The test cases for the acpi tables use the
> firmware images for the traditional, pflash-based efi variable store
> and can continue to do so.
> 
> So, do we want add them?  For qemu developer / user convenience?  Or
> leave that to linux distributions?  Fedora already ships builds (see
> /usr/share/edk2/*/*qemuvars*).
> 
> take care,
>    Gerd
> 
> Gerd Hoffmann (2):
>    edk2: add qemuvars builds to config
>    edk2: add qemuvars build binaries
> 
>   pc-bios/edk2-aarch64-qemuvars.fd.bz2 | Bin 0 -> 1621714 bytes
>   pc-bios/edk2-x86_64-qemuvars.fd.bz2  | Bin 0 -> 2095693 bytes
>   roms/edk2-build.config               |  37 +++++++++++++++++++++++++++
>   3 files changed, 37 insertions(+)
>   create mode 100644 pc-bios/edk2-aarch64-qemuvars.fd.bz2
>   create mode 100644 pc-bios/edk2-x86_64-qemuvars.fd.bz2
> 


