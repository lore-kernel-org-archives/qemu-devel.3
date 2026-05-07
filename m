Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0053CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKres-0005Wv-0C; Thu, 07 May 2026 01:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKrep-0005WF-Eu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:52:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKren-0001TI-LS
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:52:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so336192f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778133140; x=1778737940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mK/3rVfA8VWBvKCytrm/nLapp+zCSQhS3Ida7QcTMqg=;
 b=CYHK1nshk9PVD1HlIknZz7QR4i07EuFLcxeBWNCnbG1nLe2pue5LXwg29W9To1k1oT
 ALga3+3hWiVk+pK/SlTodLZDDhgGZpark1FPywixAnTlUQ+8+gUr1B4rjSlt0/pHw/Y8
 AXxVdEsZ4ESmtqPV4+7AEtaniP5aPRs49PsL1tHNTaZrddMLSMJpObXsoYvRWOXNE7tI
 +J+pw/ajImtT+mZuoL/lXyJwgySOIlnzM2tXdTCD7T7fSYwnqJAJCFr1jvNws98eIObf
 qWJlpn7ML+4+k3/MzP8Dowm9uW9IF7by9i5eijAMYTF9hmFPXhriYJmMCh1F9TJWURqe
 Ycqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778133140; x=1778737940;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mK/3rVfA8VWBvKCytrm/nLapp+zCSQhS3Ida7QcTMqg=;
 b=fiWRaNW7gj996ouEd+L+8SZHcWbEOomOpfWEA8L96gKDK2DW3OQZelRMs7xV6MdrkB
 sa0xUG0S6dVYaemCHvkwQHNKRlwVazZRqeKZUt6NxrvPzHAt/0nADTJ+TwGVJZYjkJHC
 8bGgEJTMPQo7OrZCuJnwzEdh764Xn3MqJYzWTlIyjEv9pgllmm9P6Oy0kEfn+x9KrhXf
 5BBT2rXrOHbpP2ikVXZ85rGHdYx8JE6grJCGjimR1TWrgTHydqujIFenzlb9Rdz8Hqe4
 sidbNYxw7yn56UffuJoSVHIrV1Born368GVABD7KYl3FgU1x3cE8fEK4gj+zcfM1WiPo
 U+jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TvLyiYK+gdZDREVEk+tS0jOo94w/elXSDzURKt4D4llU9t0y/mdEPGxdXat1XT5TAndyMadPT5fry@nongnu.org
X-Gm-Message-State: AOJu0YxbSzi2bsZi85IuvXA5W761Sbuj255u7+s2C6K4QSbWiPlCXyoG
 fOo4L2xKeYzh9++8U/4bFS4IkFMWpsi8tHFBdhfIUIeeP8G6NXaxknBNOnYQVFPPvn4=
X-Gm-Gg: AeBDievRdPkKiCcvzsktEL08FZ8NZWzsDfgkhqcNXfpVpB/9KAiQvWi77H1akCiDZAx
 KlCVd+TLbbxCrS0gB9S23FdmEIa+im3QVYPfXG4z/87t7z6zfF83+wC37bI+oNp5hXX4DozupSZ
 Ms4CFvk7oGZX+HA95Vcf4r9Gg6XdIQUN0J1vSL3qsiW2vIms160V+6mTjE8Pgh8Dxj2yUqQAvki
 kAaLfZ/Bf8zOs3B00E4Xz/801PVgZNn07aKZxaAiRB7qxg9GGZN2WtQX9DvkA3Yua7LkF3mRHpo
 OIg6xUHsXNtTOoMwJ/11JH/Z21ja5O+LTA7qAIByf7pAvX9fVF6nP/8RhjDvF1DLklghCyK1+zn
 rp+KTNrD3tD5bzynuvN3YL3tfKmf5Gx501Qjbeevbvtu1neM38jPMkycYZ/ZplNhK7RCND/TzcR
 193Tvt9wKM7RR9De3UB9qNhKbDK3oHt7Tg5oZsKgKQuxstzhcVGhrmL51/52/mkmp6qbNk+U1tj
 8jv
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-4515d3dc343mr9881833f8f.31.1778133139920; 
 Wed, 06 May 2026 22:52:19 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02f76sm16947316f8f.23.2026.05.06.22.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 22:52:19 -0700 (PDT)
Message-ID: <e3fd9643-b19c-4779-9bd3-dcb1c8314e78@linaro.org>
Date: Thu, 7 May 2026 07:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-2-philmd@linaro.org>
 <4bc408f7-7db3-4515-82a3-38b94de17262@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <4bc408f7-7db3-4515-82a3-38b94de17262@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/26 21:19, Michael Tokarev wrote:
> On 23.04.2026 16:50, Philippe Mathieu-Daudé wrote:
>> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
>> Include the latter to avoid when including the former:
>>
>>    include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 
>> 'tcg_gen_qemu_ld_i32_chk'
>>     34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, 
>> TCG_TYPE_VA);
>>        |     ^
>>
>>    $ git grep -w tcg_gen_qemu_ld_i32_chk
>>    include/tcg/tcg-op-common.h:328:void 
>> tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
>>    include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, 
>> tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>>    tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, 
>> TCGTemp *addr, TCGArg idx,
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: a8af0fb24da ("include/tcg/tcg-op: extract memory operations to 
>> tcg-op-mem.h")
> 
> Just to clarify: this patch has been Cc'd qemu-stable by mistake, right?
> Because the mentioned Fixes: commit is not in any qemu release, it is
> applied to the master branch after 11.0.0 version.

Oops, likely... Sorry!

