Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC2EC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1tG-0005CA-GP; Mon, 19 Feb 2024 06:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc1tF-00058Q-8b
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:32:53 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc1tC-0000qP-9G
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:32:51 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-564a53b8133so370353a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708342369; x=1708947169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pRJOp7FOhjLlDAJg3wFzomYmDPIiujaqErD/yJgs4Og=;
 b=KbHo0ZQpqEi61qMc90TUms+BH3jGUhXBZDPo3MABWE4Y/tO6CfvGT/JqkMDDLOcml0
 Ov6qAM8MAOQ7aQ/yXUg9wRiQB5Jx0RGLEGi/qACDJI+G0nrbg9EtVu2b+eXIICywF4oc
 kraLpbjaWkWNohPz6CFzr95LM6zvKQUtulnemc1791P7K/qh3QtUqu5IAIKNETSuGwPu
 y6VrRuJTF2hN7cCNNZfn5BgvRQn1943MMs4ZL7k9PPbHPS3B4o8KALvQ14u6Z9t/hxCK
 UIWzbR2NMq5FXIcDsJH86qUp0U/fhqdiMeTPDxPjj+xMxAo8JQ/DwX2w7qwGIEYo7IZM
 gJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708342369; x=1708947169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRJOp7FOhjLlDAJg3wFzomYmDPIiujaqErD/yJgs4Og=;
 b=UUmOfmt7CGrZDncLiBqWuMQwo5NwnlfLj4TZ7OVezpwz5ThKCrgfajx3zBLvXGNOPk
 Wr+Cz0jOk32pL2FAmKTXZgqgLTyQ/9SJ6RgybT3jdpqMmLM41g7/YESqXXyd96Gi2OmR
 1ja1P39QIom45rrcrkL5gVLddlPI8Kp1dKuvzaTK7l2ic2S4mX9mIIRrGFl6M78Cfsws
 Ce2kfXshLrYTcsbuMZ9kCh+08PY3B/JZNCvjEecWoDjzyA5V+McDM9niFlJxIjcJ5S8B
 0/yTfvQX9DwxoRXyoNxjVEF2T9jCEpwiUKW4EKLxKE6hbPn2hUPP+L69n7njaCT2Cooy
 9XvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4GM27ycwJGezwuGGQSLmcPdl3S3Auab3ItT8pYDRD8h8CZmA80epcaKjlYBa5NAuDG2UmesomTYMTQe7F/dw/96Zk8b4=
X-Gm-Message-State: AOJu0Yy+CToJ5A4lDbadlP70E2PgPzVZe0vJSFTBoePFkHPfxJimjpXK
 MEtxbPbw7tUFWlyvl0Cb7mjQzasQ7Bbh0Ewk0J608zRuE/fc5aiiy4mZ03ljsk0=
X-Google-Smtp-Source: AGHT+IFPJYsJkDIUwH3U0VHHacui3qaqop5SX9YTkcyc0KJSCxRGO6nJ2/z8sh6QgaYtM1wyYLxBEg==
X-Received: by 2002:a17:906:564a:b0:a3d:232f:a4f7 with SMTP id
 v10-20020a170906564a00b00a3d232fa4f7mr8002303ejr.16.1708342369037; 
 Mon, 19 Feb 2024 03:32:49 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a170906448e00b00a379ef08ecbsm2846778ejo.74.2024.02.19.03.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 03:32:48 -0800 (PST)
Message-ID: <76a21d79-e3ad-4454-8704-d9ff9efd3b3b@linaro.org>
Date: Mon, 19 Feb 2024 12:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/ide: Clean up hw/ide/qdev.c and
 include/hw/ide/internal.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240219104912.378211-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240219104912.378211-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 19/2/24 11:49, Thomas Huth wrote:
> While trying to make it possible to compile-out the CompactFlash IDE device
> in downstream distributions (first patch), we noticed that there are more
> things in the IDE code that could use a proper clean up:
> 
> First, hw/ide/qdev.c is quite a mix between IDE BUS specific functions
> and (disk) device specific functions. Thus the second patch splits qdev.c
> into two new separate files to make it more obvious which part belongs
> to which kind of devices.
> 
> The remaining patches unentangle include/hw/ide/internal.h, which is meant
> as a header that should only be used internally to the IDE subsystem, but
> which is currently exposed to the world since include/hw/ide/pci.h includes
> this header, too. Thus we move the definitions that are also required for
> non-IDE code to other new header files, so we can finally change pci.h to
> stop including internal.h. After these changes, internal.h is only included
> by files in hw/ide/ as it should be.
> 
> Thomas Huth (7):
>    hw/ide: Add the possibility to disable the CompactFlash device in the
>      build
>    hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
>    hw/ide: Move IDE device related definitions to ide-dev.h

Modulo comments in "hw/ide/ide-dev.h", series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>    hw/ide: Move IDE bus related definitions to a new header ide-bus.h
>    hw/ide: Move IDE DMA related definitions to a separate header
>      ide-dma.h
>    hw/ide: Remove the include/hw/ide.h legacy file
>    hw/ide: Stop exposing internal.h to non-IDE files


