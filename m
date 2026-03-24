Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151C7F54AC4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52tk-0000nv-Jv; Tue, 24 Mar 2026 10:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52th-0000nN-9i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:38:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52te-00079j-Ov
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:38:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-667f8794e97so9205342a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774363097; x=1774967897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQcI8BKi1qvMDPWwBTaO4BHjJ8aG6ZzpF9S+Abxw0e4=;
 b=YKkUL2aLrC4O03u6TXmneha4qqmxlTbbfLbn80hL1Y+KYAuouhR3c1EqZGlyp3Q7h5
 lsFOEInOxZIWbNAEbeK1i4vZiFJmRiq7uJYSBcVlm6LcqHZWFUivn97I0SBUIRvqBDfP
 GROEimOI3ch8OC4MyuucJMIiG23WsmbOnfQTZRLMQVYApr9l5XVjSaiFVuXFzuIqLQai
 vpscPmPMQsSRNDz2WRo7K2qkUkH+t3Vume+yr5FdODgAu/XmpO0Jv7PtbI5W01GwruMW
 GYArTnXVQlgb6ZtXwSXXV+s96Gazgs0JS3J+icyDkJMdiNKtTVUjv6TlE/NF9tImsV9e
 GicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363097; x=1774967897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQcI8BKi1qvMDPWwBTaO4BHjJ8aG6ZzpF9S+Abxw0e4=;
 b=kwpXKnknboLgAqmCr9556vcmammslZRlAiYllCfxX0ie6LckfxkhK7Hs/mfVFgqEYg
 +CRyQwYLgtoF2lbov084tQSEyHOcKlDzZkDT7doSOCeuhroZUg44YGpOmMAgnGmKiMcU
 dnDYYUI8MOHzSlv4Ar2CG7voGOOxCvgoJKKoefH9MDCkhfvpq3AWdCULuMAxEaJ4OeFC
 UPFH/kWP3+oUZDXvdwsRRAlDWf0lUc/zToJzgK8rYsNRdZ+UkHu6U9xCmonVQ8GSq+9o
 JQCX9DAUy0crnERH/qpolmH50UVzQxfmgLdmWItB+OpfvPwIq2Pb2d4LM9xhdTnOyIgZ
 E+gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvBmr8g6DynDKw6Whpz3I+V9v32nJsxw5UV8oXlq1usvClWW/e58f0jmnh/70KPY2CL73NdJHjuq4@nongnu.org
X-Gm-Message-State: AOJu0YzNdzT8lQKpM9or9pd+PuTm19/eelgTjarRmGmeh7X4RIwEYk/W
 gJytaDj1+MAW3rhxxDgvPXqrUXZy1shFQc4WL8PA82b/74J3lek2CZyuXZ13y/0JVD0=
X-Gm-Gg: ATEYQzzbs88AKT6MsjvkkPujlefFJG/kg6au4EpBkktkC3UsOKkhHscPiRxlVzlUf/c
 fedso+Gu9B0Gkw1LE3eOOW2QsmxunENLOmvWw37du/KeB87pVUMUMFNm8duGls8f4Dri6TfnZdP
 j10FAE7Nrqc2ExEUY0+7eUZtrryNJsCzRAJL7enJ5Wpfg5dHb4IuGUrVSAr+HyoE0OYSJxzFy99
 1NQQgfMwC/nKG9PJvDy8ehIdoEtDD1+Kiy6V16klxmP4GYB0WrmZAk9tFDksSYSXJwTi7Bm3aYf
 65nIQMxpf3sa+0LVGszHMwaKoc5OEvMZnnAb5NOHSzeAWxhHd4I9j+cCGq9bcx3x3mhP4dqwXUi
 YBd+ATCQaK+rNeeth/B1wLzMqIR9ghoWr7k5f0FeF1MuvnWl0EVf3PSNVYq/Av+85Cr533t8tkh
 qlqFO2P+ZmPaPNrRTSi78QHpWI3Lv7mv2QO/P52Uf9RdGGvMn0JxR6py7BVYzwIC0ttg==
X-Received: by 2002:a05:6402:1453:b0:66a:6c0b:937f with SMTP id
 4fb4d7f45d1cf-66a6c0b9604mr808888a12.1.1774363096741; 
 Tue, 24 Mar 2026 07:38:16 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6697d733a0dsm2664506a12.26.2026.03.24.07.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:38:16 -0700 (PDT)
Message-ID: <e0686a78-cad0-4cbf-9063-81c4c211bde4@linaro.org>
Date: Tue, 24 Mar 2026 15:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.0] pc-bios: remove obsolete linuxboot.bin prebuilt
 blob
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260324122025.892666-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324122025.892666-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/3/26 13:20, Daniel P. Berrangé wrote:
> The corresponding source was removed in
> 
>    commit 88641f4df388faa78c49c54ed885e530fd0a75dc
>    Author: Philippe Mathieu-Daudé <philmd@linaro.org>
>    Date:   Thu Jan 8 11:30:39 2026 +0800
> 
>      hw/i386: Remove linuxboot.bin
> 
> We must also remove the pre-built blob to avoid a GPL violation
> from lack of complete & corresponding source.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   pc-bios/linuxboot.bin | Bin 1024 -> 0 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   delete mode 100644 pc-bios/linuxboot.bin

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

