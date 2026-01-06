Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4129DCE9D46
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd8b9-0002lE-6t; Tue, 06 Jan 2026 10:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd8ay-0002cg-6M
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:03:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd8aw-0008Qk-HY
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:03:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso12069765e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767711816; x=1768316616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8aNC0ucMl9G90cWjMnn4LBWNfaLHs/abDthz72gHSgI=;
 b=h3JQHNHy/Yn06BXDcXiFjcx9GsyUlh4Twz389Eaeoxe+b/Vf4xSmdfS4K9pARz9xIG
 k7YvfzyCvMICvI2pGvbbDSZbVTPqmwtT20zwOWmpOof/DMxCio6bukkcf8w7l59KB0et
 KISSRnBmSjGMsyBl/zmMRh6+aXhFp64eI3tf9JNfQE0nUCesiNTJutqXVPCaqkgEu/6v
 aNGyS84UDwTreFy8Z+UaAGChHSibWLuOSBT6B1HPLoF7Q+kC7zDuwEPU/l+7MCtyTKjN
 /MQTg3641HWO/4hFSZB4+c254pikMFaU8TrxIIX4tunROKJh4Ok1eiERopYJuMXyTOm+
 ijUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767711816; x=1768316616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aNC0ucMl9G90cWjMnn4LBWNfaLHs/abDthz72gHSgI=;
 b=An9afLo77fNRBYi28JahP8o2OS9u9vSVz97YF4r+5ohvJG0YEhS2SDUKYu7iQsIWs3
 +NnAC3xg84uxZxApYR0lbpm+DNFE/bur7PsRLdcifdI0/5Zuxy1ct0pdYSdK0McLkxJ2
 WsQcyZBjy504JAeqK7RvPgrBTLYIqNvIPAK5mpfaCZm2ECKnvUJHsFFoAx4Tte0hLj9n
 ypNxGRFz9/gw86lPWtn7JHuNQX7groQ34sSPLJA4+fNwWsq1T/Yj3p6qpWvUlqNh2sd9
 IfxicwtsZKOAf5V/OJwPbnZ+K5+GZTq2M21pt7J8HLEBjjK1EVrbrbcaNATjRWIOGSbx
 OIqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtNkCa4zzpJQAINyLuJEPaUCPOvgjbXEisFFP+sdgF+2vXJqBD9+6XA/VSweBq+iEsDVOfVpKlSNW@nongnu.org
X-Gm-Message-State: AOJu0YxEVR3z1SP4+b38kIf4JYmfG5VOhrAZ55QXaw9a8NvlevgxkbTr
 ZOMSQA8QgwtPby046C/clSE3Jn9aXenia75/S9TLPDgdY+CyoHAN5gGP7WdLUSJeVTc=
X-Gm-Gg: AY/fxX6FD0VC8VqbnA8Jcxvt0V60A4Rc0h3UwQZ4ey5DqLRsyEReP8FkAw2bVvYmNhJ
 yeu865YasFq0MApX/gIapDx51fPoXSN4piheGhNJllzCFTb5L8xZibV08LFgB/OJUHwhPXd5w/m
 AmIcv3BQrEdLo5VKGPpZLMcwPlxtqGqmB6m84dxYNulKlwWHGILn9aHmOFhSIEzdKToxzNnv/Vw
 2TFLk0RH7pMYmzsvkvtmOWHtfgee+GBaM83Lf9hnSm+wcIU/f/pe+xIHumQHInzfIY3tXoQtHcb
 dzhFVFaryfArLaG8H0Ou4cZFfoT3NSwT6Y9cRLgi0LeZ1Cubs5A9aXWXEd6etq4ezYnd4D8pkdq
 eLet6LL0iyLWToGm/y/lQ7q84ZRcmw06CTAr7Uoxoo+EhjO6noQZNWq6pjENHdk2D+9OrdNB2mR
 YyNb8TSo6qojXM1RsoaH93E4vvadXtllf8EiqkhD3HJH9EjQxmAOu/aQ==
X-Google-Smtp-Source: AGHT+IG0b1z86lIjtUZvBh/LBnH99IEkHd455/DTfq7eDAkps8vlANqmIloBrlLX3YX6wj81uCgqiA==
X-Received: by 2002:a05:600c:5395:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47d7f06fd9amr37265515e9.10.1767711815835; 
 Tue, 06 Jan 2026 07:03:35 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm49307625e9.2.2026.01.06.07.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 07:03:35 -0800 (PST)
Message-ID: <1093a44d-8b37-4229-bd0d-93dd232cd1d3@linaro.org>
Date: Tue, 6 Jan 2026 16:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/arm: Move ARMSecuritySpace to a common
 header
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <20251216000122.763264-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251216000122.763264-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 16/12/25 01:01, Pierrick Bouvier wrote:
> From: Tao Tang <tangtao1634@phytium.com.cn>
> 
> The ARMSecuritySpace enum and its related helpers were defined in the
> target-specific header target/arm/cpu.h. This prevented common,
> target-agnostic code like the SMMU model from using these definitions
> without triggering "cpu.h included from common code" errors.
> 
> To resolve this, this commit introduces a new, lightweight header,
> include/hw/arm/arm-security.h, which is safe for inclusion by common
> code.
> 
> The following change was made:
> 
> - The ARMSecuritySpace enum and the arm_space_is_secure() and
> arm_secure_to_space() helpers have been moved from target/arm/cpu.h
> to the new hw/arm/arm-security.h header.
> 
> This refactoring decouples the security state definitions from the core
> CPU implementation, allowing common hardware models to correctly handle
> security states without pulling in heavyweight, target-specific headers.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/arm-security.h | 37 +++++++++++++++++++++++++++++++++++
>   target/arm/cpu.h              | 25 +----------------------
>   2 files changed, 38 insertions(+), 24 deletions(-)
>   create mode 100644 include/hw/arm/arm-security.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


