Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A699F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdkF-0003qb-RT; Tue, 14 Apr 2026 09:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdkE-0003qM-Jv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:23:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCdkC-0001HK-VN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:23:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so60859245e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776173035; x=1776777835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fFGBXNObjmSGSFnpuHSqIcNQxPNr0H1Q6j6ng522NCY=;
 b=Me6I1l2AMOUZcORtZaS7J8AGx9sKY3sVevoTJszHqdw/3HfLK/m32B9A6+sTUk8A2K
 1IxPa6HQ2u6x5TDJfN0RWOBTRlA3br1whpNOEZRx1TOMS5nL0OyTGq1e1MjEpr0Uv7XE
 b1YCFuQdgejlOQ1zptvqvydexIT2urEMe1OcCO+5bhS12tdU8Vhcdlivkrp09jMktcTN
 fc4tp0z36GkxwEdlD4HOS2YiAJKT4p57MXq7DBrkB9cdkce/MjQjmC7H2SctRD79gTEh
 r+qdbVtPRomCUFjv8v4vP2nIJKKTwbGpfQyNT+MJWeOOSdPMIq/0Q4vkuK9Rz7bwSAcZ
 qtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173035; x=1776777835;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFGBXNObjmSGSFnpuHSqIcNQxPNr0H1Q6j6ng522NCY=;
 b=AUCexCYVJSn1E53U3ApH2sZlZXsE/lkNDkkxhgISAugo2WyJyVSyvbctSJLjDSSdjL
 fWzAAt7LjX39Y8NDmbOiWhYWjJvWZrO7m9mx2jWeGsJvXQI5hxIrYSnjvMN94SC3QKoQ
 OUF1vQAvZbnosIxtvZVWhj32/Uy1r4fE4jBxAUW/iyUtQMOGPUT+9QQNuvgTLHdEdO8c
 X0FjrxT5i0ZClhNHc8STZbR5gVPjIo5fkupzQo5Qhz3ybji3t8xjMiRYSG4qOHEHmk9S
 U9P6ZaVqxp+5kxXhCCCYD/gumfBj7jPl5X/9kLUsLMc8Hvm6af2YayJ+bCGG79k5zDeD
 9Y4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/igdhzl5sdP9+HVaSkOmfzUlTKVRWP8E2VrDQq84p/VKylXrWB7j7svZTvCRx4f3P8nE1E4uF1Bkc8@nongnu.org
X-Gm-Message-State: AOJu0YyvsJiUQjdpHtl0odod/mOuGFtmG3muqrUDGSL/xbkeQ8LhR2Yn
 UlOaGDens7BA0G/5MA81Dxl+E8jHpEG/PDau/cV55OnQKWYirvdBZPHUrihDkNfqXN0jAWY6LsY
 JNdT8ZzU=
X-Gm-Gg: AeBDieuyqBc3elpn5lMV7A7gZceta3gRhDQ4CUhNkHy9ijno+tWaHXTb42eMQ1HRE31
 nl5xU2tyG/rkqfUgyGQr/o6DSJULKndezyWKXu+FNNrEJCHxEXq1T7pVm9XY8nruQS7cSt4Yo7q
 1qSSpewUjKQb+gWnImK1De7waMiO/OvvxSFxM/VbicUqdl11qrQY5QmXviE58pRGMT7VhKsn35p
 rcFTjwwNaz29kKz6oFUigRXbFqSLzGtAYQpuULfd0moUw6BkitvoxQfkk9ES9+rAxX5thHEzyNG
 R+ylsyrcQfkx5Z9SR8K+JqJR9np9d7MrrIbRBawoxSm6deiCI8LTniSLeEqDqYmIU3x4vlnYOF9
 BlgRE9P0pY0PBwKh8X/Vxu+6dYDm4thNNRvo4989GIeHfeHpLdnQErQQnIgGvZkh309rKDIMNxk
 JBm2w5XGtmjJvcmYJ3W4l+GPBn22o+gEdmOehJ32MAWdJ8Fb3/yiQwOGE/IHwo1MUDBQ==
X-Received: by 2002:a05:600c:a11c:b0:488:af14:f1da with SMTP id
 5b1f17b1804b1-488d67f9a25mr173887085e9.7.1776173035112; 
 Tue, 14 Apr 2026 06:23:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d78cfdsm123676355e9.4.2026.04.14.06.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:23:54 -0700 (PDT)
Message-ID: <7be383bc-40f1-4da2-96c7-241946e6e52d@linaro.org>
Date: Tue, 14 Apr 2026 15:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/hvf: fix double hv_vcpu_destroy() causing
 teardown error on ARM
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, mads@ynddal.dk, brian.cain@oss.qualcomm.com,
 mburton@qti.qualcomm.com, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/4/26 15:11, Matheus Tavares Bernardino wrote:
> The following callstack causes hv_vcpu_destroy() to be called twice,
> producing HV_BAD_ARGUMENT on the already-destroyed handler:
> 
> hvf_vcpu_destroy
>   |
>   |_ hv_vcpu_destroy
>   |
>   |_ hvf_arch_vcpu_destroy
>       |
>       |_ hv_vcpu_destroy
> 
> The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
> second one, as it is redundant.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
> v1: https://lore.kernel.org/qemu-devel/70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com/
> 
> Changed in v2: removed second call instead of first one to avoid
> breaking x86 (thanks Philippe!)
> 
>   target/arm/hvf/hvf.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

