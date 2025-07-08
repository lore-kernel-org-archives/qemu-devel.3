Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8F6C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG5N-0002tI-C7; Tue, 08 Jul 2025 17:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFJZ-0007eQ-Bm
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:53:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFJX-0003rz-AE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:53:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so3068916f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752007997; x=1752612797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=srgEDpGFqHVp83wO3nsWrDzTxJ6oIFK+IEA/umVgPdU=;
 b=V30+a5v3s6AmTFvJJ/TS7Zv69qJPLIJs4gHWsZoDGXjFJThf+2E9TbgEvgenAYNo8E
 D/jVwLf8uhAWGJQP4csL+olXCh/5WqRXwQAWVw+dOCqu3Vw7JCzHWdugoZAOa8HWp9UM
 IGgW4XUNsQEkWzpe5hTOnMMGljHer2uZfOoHiTLFrwrhUiG1sLZYaQACuWnOog5fBNdI
 t1iP4/eXVVr+8nNqTpY2Tkb7VG8/lt/H1jIY7qAcwkORoze85b0+n897T4sdL3oZEaXv
 TiMnTugjf/zsDWQgvt6Xkjbo+QDuMCxYKrtbRRxCFe9UV7bLgFDWQphmLvTGBNm0VCrQ
 n7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007997; x=1752612797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=srgEDpGFqHVp83wO3nsWrDzTxJ6oIFK+IEA/umVgPdU=;
 b=LU6WXzJzOc+X0SRpKrlyMIAjAc+H7WNr9twtyDrbb/mSrgYz/lPa8J4JigLGELfvOR
 1bVitPQwYjFP24AUU5RTfWCViKML5xOHO5BKpTcd7mwffPBHtMYUvKYz2xvAuOsTFixb
 FPcBVxig2xsdaRDyuBffoXkVZOB1pseaukNr9mqqPq2TK0WUQ8qgWQZWxgR3NQYfej8Z
 jCDjnYiCn0cDyOVHWwUw7xum9uq++RjIEyN3pUKM0TViJ1llbYqr1v1wFCXZpd3msTTm
 gXGOzHyFnCZqyZ8w5OmZ2vAozHeWRyQ+uxGxOjJ8ZzpnuQM/pNJ6rG9h2kE23Qs+1MQN
 1DoA==
X-Gm-Message-State: AOJu0YxnLZ9VikR6sBtslo8sUWSpea6SgMX2WW8UKRIbT78mUKr94vG1
 /K6kWrHuUxBEaRJd9G0QyRF2jwADg8VDf0cG15/35FbYpcYS6jmi5jxE/NBI00V+xalpTihGjGi
 ihB1C
X-Gm-Gg: ASbGnct7utcnp4ypDQSGjuDq5O6hC2lTXbVWhew9ZgcCqey7+zFc2bBEV8Nx0o3FU4i
 9+F3wUv/+T5Sow2nm212iKMIvOTjchBOEyaKXC8IwSNo3qu5gYolYlLNDD3hTOXAXnIT+Emar5x
 SSyAUbIVLbKyvFSD5MlFOislGJXUYAHOqavn3orRIF/rrQz+6X1S1ihWxtt2hnx2NLa1Le9jACZ
 c8YebuWsmuZvntXsy2P8rtygTECBYFSwnxUF9kGqS5xmHPIZbmjB7yz+zFvF4k23L+2Bf+cDo8n
 JoAQlYeKCprhbPH3nwfFf3OA4patftrzG5CdymfbqXu9cGWmSzI+QzaIPTK8QwmPIixhk8IdnDx
 9pMIwDmDgURi9+j7nVBDXIf/RZMKp4g==
X-Google-Smtp-Source: AGHT+IFBSq2sJCMTs7NgzEYiUgBJnrbUxSgRp46Nz9q4YNF5tKUFY6p8ZKQnQ46CkbDQnRPQ2hst3g==
X-Received: by 2002:a05:6000:4a04:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b4964c5d3emr12503077f8f.23.1752007997123; 
 Tue, 08 Jul 2025 13:53:17 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d275fsm31573375e9.20.2025.07.08.13.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 13:53:16 -0700 (PDT)
Message-ID: <37e9f347-f7ba-4ea6-93f8-879d8169012a@linaro.org>
Date: Tue, 8 Jul 2025 22:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/os-win32: Remove unnecessary
 'qemu/typedefs.h' include
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250708085859.7885-1-philmd@linaro.org>
 <20250708085859.7885-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250708085859.7885-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 8/7/25 10:58, Philippe Mathieu-Daudé wrote:
> Commit f5fd677ae7c ("win32/socket: introduce qemu_socket_select()
> helper") included the "qemu/typedefs.h" header for the Error type,
> but files including "system/os-win32.h" should already include
> "qemu/osdep.h", and thus "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/os-win32.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 3aa6cee4c23..662cfabc5e7 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -29,7 +29,6 @@
>   #include <winsock2.h>
>   #include <windows.h>
>   #include <ws2tcpip.h>
> -#include "qemu/typedefs.h"

FTR, copying Peter's comment on v1:
http://lore.kernel.org/qemu-devel/CAFEAcA9rcJHBaeAqCM1BszrhzkE4=gxJkx9h62BVhEz9hB7OMA@mail.gmail.com

 > This one's tricky -- osdep.h includes system/os-win32.h
 > *before* it includes typedefs.h. If you want to remove this
 > include I think you need to move the include of typedefs.h
 > a bit further up in osdep.h (taking care that it's still
 > wrapped in an "extern C").
 >
 > (Or we could declare the functions in os-win32.h which
 > use the Error type somewhere else. That header I think is
 > intended to be "Windows specifics and compatibility wrappers
 > that everywhere needs to have sorted out", not "this
 > function happens to only be needed on Windows": a lot
 > of the functions declared in it are only used in a
 > handful of files and don't need to be declared to every
 > source file in the project. But that's a bit more effort.)


