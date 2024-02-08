Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7992C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBnM-0003WR-J6; Thu, 08 Feb 2024 16:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBnK-0003Ue-BW
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:18:54 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBnI-0005u2-Qk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:18:54 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso2131195ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 13:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707427131; x=1708031931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BJLaZPnFZgGtYLqup+5pLLvVPueDUbFfffblq2qf0v4=;
 b=wVeu5pwjeMuRASWxYbxW1bCjTctGDVgUqKthTzqkJqP7f6gxQlBb8vntXbk+LqW2JO
 imjo7Zt2cFpTPFl8BGGpmzh+NvHzCvhuCOvzUVhQ2ZDHxqVis3rM2Dq/9TmOh+lLlelm
 Og3b+wguFJ/NnlAXISVivilosgUEpPVNKe7Gt1PH5pRdz2S/bcjg38zC4k3H7+P0o8mI
 adGDs6VTcQCnAEgh7qBp5pFyynHVxmVWsRyXDkCnm/pLEj/REE+xJKbMvBf36Z0tiMhb
 xjNtIcnW32FFy7Pg/ZsryCfzbUxGzl4yoxNjqJhoUcmE4xvfw0v9HiNkwymZJBDDAmsV
 JBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427131; x=1708031931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJLaZPnFZgGtYLqup+5pLLvVPueDUbFfffblq2qf0v4=;
 b=f4CFBaK8h9vGbEd40YXLtLMuxzM3BrwHZhKRx0PRAU2R3NyPuLphg+yzxf0DpwIBNx
 LAZiM5PgxQExVgM99SAuRxmqT16kWMt8RNgo3rEKWTr1WaJqvNMbXUKLFDRcwu9sGA0y
 yBQb3cZhytCR3Dx3HIWqFvcNuyqS2iXj4mVOyYr1ylLmkAB4DXfPlwf2I84ZZHPmcOtl
 bnFs2S2jg/vEz7Xz11WsRy1973BnJYyNUpdyqLcT1CmiA82D0ti5cxsIN1jfdeFZwXiI
 86QBbnly7f8pchks859gqYdw1eTyG2xvViu7kDT2rateN60C+aZLz5dZd3F5DlHj1o9J
 GlDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1doMT/fXgYI3Lu8tbS/9HUwNd4JPNW1mCdl9rL6F9Q3m1ip3ZsfxXzGT5PZbiUtCOOyayAfRBq0umzH4mu3gAMgx4yCE=
X-Gm-Message-State: AOJu0Yx1jQCQZR8LRudRIGA7q4hrp6ZlHFx4K4+br9UHO/tF+792MpqK
 CnLXsbV8J0vY3dRGJ2FQ4CVtPCEk0lzDH/ROJdOu4qa+PjaK8M9k8tASJQy+hFQ=
X-Google-Smtp-Source: AGHT+IH8jeefzoF10NkBd2sWyltP1uABzyWCUgaFkgiFTKsui3C53Erj7GzmFuI+P/2HUwPqrORDCA==
X-Received: by 2002:a17:903:1212:b0:1d9:486e:ae47 with SMTP id
 l18-20020a170903121200b001d9486eae47mr498043plh.33.1707427131037; 
 Thu, 08 Feb 2024 13:18:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUpGsBpdLvnBtr6TYRa+lZec7NZKaCw8ZNK6zv9pY1KWFHCBaMhBvbhAXa73oawe5PYe9+/dQ700Gfx2GizE3uJE+bx9Wo=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 q13-20020a170902c74d00b001d8d04a4fa8sm198458plq.300.2024.02.08.13.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 13:18:50 -0800 (PST)
Message-ID: <52779e6f-1039-432b-aee6-94d0507ee528@linaro.org>
Date: Thu, 8 Feb 2024 11:18:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] hw/hppa/machine: Load 64-bit firmware on 64-bit
 machines
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-14-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-14-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Load the 64-bit SeaBIOS-hppa firmware by default when running on a 64-bit
> machine. This will enable us to later support more than 4GB of RAM and is
> required that the OS (or PALO bootloader) will start or install a 64-bit kernel
> instead of a 32-bit kernel.
> 
> Note that SeaBIOS-hppa v16 provides the "-fw_cfg opt/OS64,string=3" option with
> which the user can control what the firmware shall report back to the OS:
> Support of 32-bit OS, support of a 64-bit OS, or support for both (default).
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/machine.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

