Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C3E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtic-0000fi-Dj; Thu, 09 Jan 2025 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtiZ-0000fJ-Uz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:41:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtiY-0007QM-GQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:41:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so7952075e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736433660; x=1737038460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAmNPq2tm5M/yUWKZQvL5Wtiv5W/IkLrMzzzbJzYpz0=;
 b=K7TD9WfhhEU922sjRrr9xkkeD1mkEjJbdlUyUU6DmZRHG3GaIJshqulr7OV7G//0pn
 LG22FsKVXI0gA+aZT2AHD6Ubqwbe/GUPxYDk2g1B7IC342SLGaydyfhS2KJYWmxD31hT
 PcV3h17cqSl4r3SaJaU0EDsTevQ7cWg3Z+ljmI5R0vPPHMDJEQ4bwT8Z8CAY6nBxDCLW
 eDfFFQSyiPahgjNUD+fsFDLVWud9oNYtX4QnS8TiT3FpqKuIyIf4LpD59CKwpcQ2ymmC
 2wvFsxrue5X+x6jJgnz/mbM+1HLC5tz1xd7lL4p24VCpT8q03oc5mz+YKGwJTW3LVP51
 Mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736433660; x=1737038460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BAmNPq2tm5M/yUWKZQvL5Wtiv5W/IkLrMzzzbJzYpz0=;
 b=dDv00MOgBRfHB2v5V0TDEpAo/RRlcTLFjZj1FiQq60Vrw58rQvQHS3Vc1KoQGjNqVj
 ZDeAorzgB8lU2p4A3CyiEQF1oXzHYijjpKinlPPJNZDOhBw0wHcw2rNrMDUpEObNg+9O
 xEizK8cqokbCe0/rUGNMHz89bYViFZm8CjoeIzXMxI8+En9d90IHa2/nmjhUZY1dT+Zk
 AyMTUw5Ps5e2LfSzi6H5qh8DNePzmZLppZM4EECXMNmrmOgGC7po52apNOd8j+3wfD3l
 aTW91iGahuo8bsR6vt+3du+X3BSZBAW3kFcJsg6tq95WTIBm7mwg6n5A2NGTHb6F+hJD
 a5Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn/CN9pEYbDeyxayX4pnNnwyeqsz2ZY0sU3Bx8y0urLXUN6DK4Way3yvvlOECG/LbjsjCSzJu9QztQ@nongnu.org
X-Gm-Message-State: AOJu0YwswZiUSIqPY3it5CJz5ZRdqOl2u2bWmIc+oW1XNSnEV3vUkSHw
 deZhUUTIdiFAK5MAfreyh8wcBG9jJsTuM9m10aa8zR9u/ZC2Ma5H8SGlhuqIuwQ=
X-Gm-Gg: ASbGnct5fMMaPR5P2R5sH9azFYNmfsnSvY8OQQPuBNOm+oA3PigSDUPxtkG0PH6rhEb
 KTEMZnnDU3H5oPuL6aDUH4MVWBWHWpbIblQqqdVPVNDymETd9taZjJKdlWC2QLnUBozYN4cLeji
 l8SV4b6LMPD5dtbIpNmuWuT3ZGFlpuGrDX0tiy1/cslo4qpKjdzjVwTqxd6nkaEp95eRKXehczQ
 zzECYMLJ98bdmrdUOoK1LLtYszE+kW9xXLu5EwZi+nZrJYTSxmwco38M+dEY2zCL0Q5FGJtYFFf
 Zunfani38jOCj3lhfmkFmUQNTiQ=
X-Google-Smtp-Source: AGHT+IHCFrhvFfNucZrWel1F7bHDR12Z8Dxd4i9uSvXYjkyPqW0pXjmWxFy5tM5/Cq0HWTvrmiaSpA==
X-Received: by 2002:a05:600c:1c9b:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-436e26c2927mr60207505e9.18.1736433660076; 
 Thu, 09 Jan 2025 06:41:00 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0casm2016015f8f.11.2025.01.09.06.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:40:59 -0800 (PST)
Message-ID: <aa339180-72d1-4a4a-a38a-75f979137128@linaro.org>
Date: Thu, 9 Jan 2025 15:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: remove unused field
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250107111308.21886-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107111308.21886-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/1/25 12:13, Paolo Bonzini wrote:
> The "concrete_class" field of InterfaceClass is only ever written, and as far
> as I can tell is not particularly useful when debugging either; remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qom/object.h | 5 ++++-
>   qom/object.c         | 1 -
>   2 files changed, 4 insertions(+), 2 deletions(-)

Patch queued, thanks.

