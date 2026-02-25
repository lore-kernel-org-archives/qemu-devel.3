Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEC1F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6P0-0007we-QZ; Tue, 24 Feb 2026 23:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6Ou-0007rD-Pl
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:21:29 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6Ot-0005Kj-BN
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:21:28 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c307db9aso3572052a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993286; x=1772598086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MtGPMDWIsncSkI1mtgWxQwkCcUXZVt7Jw1DmKzLQ2Qw=;
 b=fvIhPApE77hgBB1ksFy5JCgqswOTloqjKOiOB7kcuXDRhMvKJmMZFpLdQOx3JNBP5+
 SgLkmzv8YZp6Mw1pFx8a69ndhn3PqVgyV/SbvWoOo03D03qdAhJuXTiREd1WoczoLfYt
 ZyYHF42VBdy7SpOhKz4gLWSuD3IhxReZLmKOSN8Ow5x163q4iRG+2FDfsiPuF8Z8H469
 2gGZD1bN2/Gp3DYVmDPvhOG5g+eZIQOf7mXAU/NKMT1Be5cr3+vpZSZcOST7xmg4qfKz
 JxISbbhjDURP4OoS+nRWr0hPLzBak0uAFS47GvlIVM758/UYDdFKr9yh8qgzohzbbg4N
 gjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993286; x=1772598086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MtGPMDWIsncSkI1mtgWxQwkCcUXZVt7Jw1DmKzLQ2Qw=;
 b=s8jA1GNC6vrnLcItTkKegB5hIW9O9YZl+t1JRwc+PK5TMuRmwd9ui2ROYLCMIjkPNG
 IiEeiQ8H9+Az0odeLH5IYkaUP/l3H3fQ2YzIk2UWaqajK6qmDFcM+l51RuSuu4xuogyd
 F/QIyNgtsDA1vINZSsQc4hbvqARg43147gJt+WqJs2dUFc2m2CpmQ3R7B/z1adhfWFBf
 xaDFTaENSZHHuraLSetFyaITXX1ab7TpP85UgwwWT9uv7mR2/wiMkuS9lMM1/YU4ux/l
 lxBhqBFRbYEPiA7ubzCrbgype9T4KilEWh/3fhq7sq43Vos3JgTIYc0ak0WD9GN+EUPm
 8TmA==
X-Gm-Message-State: AOJu0YytS6CkdR/gU72Ef4PHWp7XkQ+ZWeWs7dQNKh3q2PyOQnr135W3
 GM+MUEuV573IWawL0Z7MT16WjeVtEtmMnR7isaLAWoeSFR+pPsrj/72zSTkpAALi0ds=
X-Gm-Gg: ATEYQzw0U68XoM2JK9cuDOORGGLU+ICbDqkjVgp33LF3+JkedVdQfnSPJpOinJjKoWy
 qxZ+qSuZwLyjrbWVUgpKNSm4sSxZ3dtvby3U6dadEn0onp1bdHP/iN7OZzgG/YaVlQ6UtepzBQg
 yHxpLbWMQuZas57eVQCMvdJ1Z/y5jaraYP2/mBh0ITVbF58y2PwcEQCH+D3XpzDTJlPU5I6/JPu
 wpQoTopp2Yev2jQxMK/rH5lKFFMSd+hAdzPkndh+NkKmEuOOkr0xQT2EUcST8qQCboBHCuRbZQ2
 WpvucV5gc59pNkNPX+1AwLPBAg8eLWLydlrszl8mUkvAoj5Xm3n4yQC8JGeSYZg9ZbeGIBQoD5d
 WSekDFWqgbty38AMbWD7zBtuDK41pCwd76je9e0a5VNJL6f/zUSDB6eQtBFTjyBxgyPkPm6fRaE
 i5cNOfsFE3wRgEz4Doo1uWX3rL4pakAWcXtMZYDFKCILItUTWxROxW/V/nJx3GMriCg16lWUz+S
 P5x3oi8Jv7I0or8n6pwRSSvMi0a2g==
X-Received: by 2002:a05:6830:838c:b0:7d5:17fb:6af6 with SMTP id
 46e09a7af769-7d57a0f40b2mr466800a34.2.1771993285725; 
 Tue, 24 Feb 2026 20:21:25 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78e52sm11652692a34.2.2026.02.24.20.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:21:25 -0800 (PST)
Message-ID: <d46044d0-5363-400f-8312-409b7c3610d3@linaro.org>
Date: Wed, 25 Feb 2026 15:21:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/13] target/arm: Add vq argument to kvm_arch_{get,
 put}_sve
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-11-richard.henderson@linaro.org>
 <CAFEAcA_0ueuehtayiK5svZEDos_3FdjXwg58-vHef+ZTGpVW9Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_0ueuehtayiK5svZEDos_3FdjXwg58-vHef+ZTGpVW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 2/25/26 03:52, Peter Maydell wrote:
> On Mon, 16 Feb 2026 at 03:46, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/kvm.c | 27 ++++++++++++---------------
>>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> 
> 
>> @@ -2139,8 +2138,7 @@ static int kvm_arch_put_sve(CPUState *cs)
>>       }
>>
>>       for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
>> -        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
>> -                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> 
> What was going on with the double assignment to 'r' in the old code ??

No idea.

I suspect they used to be separate statements, but got smushed somehow.

r~

> 
>> +        r = sve_bswap64(tmp, &env->vfp.pregs[n].p[0], DIV_ROUND_UP(vq * 2, 8));
>>           ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
>>           if (ret) {
>>               return ret;
> 
> Anyway
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


