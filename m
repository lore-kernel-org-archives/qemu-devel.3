Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5F7D4A602
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgctE-0004R4-Dp; Fri, 16 Jan 2026 01:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcsz-0004Lt-EF
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:00:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgcsy-0007ql-0X
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:00:41 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so10437245e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 22:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768543238; x=1769148038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5sYBS2kESQe3rQhftJ8aEkAT5UD4N3brmYKsc7JJPo=;
 b=IJXko+SkpqZW0J+vVwQbzpT8PwPvZqi7lhti3fJEPqEFDb48RQq6F66SBDQljc60sD
 MqjdLR2SHwlh19MhsCdppnDhTXN5i09Dd64vLVrZBu6lr8nxS/pV6iMqAQYewaVOjRvO
 AHABOS8FthLJEnONntkZsra0HLPRzKQUp5MdxQwy5te0+0DKiwsSykwMBad5e4/LSZv3
 cKK5zPw161uiWIoRLX24RTuBnUrXCjFy2Ka6MatGZ6FCjQIdWlBdPUr+2VAZF29os28C
 fqdE72sIE/fqkxvDDzGjoi3yIeoUgyaqjqzIaYI6wZ7ib3xy+E5JtswZDBNUTYcULaiQ
 tdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768543238; x=1769148038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r5sYBS2kESQe3rQhftJ8aEkAT5UD4N3brmYKsc7JJPo=;
 b=Os+54/r6Ce0KbJo3jrN8NaX6WdpJNoKjQjwv2ptX+c6GoqWC6yOQ53/pl21JLPoqXt
 vlkAUK9cr5DOMmBrmX+o8M6S11s0oq/j6aghoTcRAt3bnYPc3BepNSC32UmDY694nCMh
 ok3dEcrYmGcRwnQeORpizSgPte4AyxRylCJQ39HrWoDTxkaWrvP5OtcIICbHaWKYRKK2
 9Xw7w5+R+j/+deVFfiXR3wD02VKPAxv1q6Y1qkGIUiIHvhcnTAh+1sNZodUv15JEIamG
 H8SPyOidHOzGNy2Zhxil4e+d9EyaFMu6l5/4attEU4oJxml4ppni0PIOpCz1fBtFifHb
 XHhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbFv6xn8vNsuRDtPElSrvR1lEU4ILWIdnE26tzr5yKJucQhy8ur1/wxbWa0i3z7r0CNP4pkjQ221i6@nongnu.org
X-Gm-Message-State: AOJu0Yy21c3SU/MwQ6aANgk8iRM3k96XDzFdTEnhGCt5hDg6bucB27mj
 +53CyumwhO7so3jVECHBTq7dvsJzLzU/8y14tSZJnbuRfIOEeCqIGiuXOkvUcNgbQjw=
X-Gm-Gg: AY/fxX6mY9rlHhSqSTwgMl+Egin7SVCgTc3J6xCrgcu8/6dM17lzTN6OQloYu7OkGZ5
 z2iEhJH6Ihj7l0N3K1C58reeUyfjXErRflO3jLKERg5t91MDCJpd3g3C5MWq2PRkYdsyMDoS667
 rbqiq0LuvTcJUg+I9ULtSeP6O9gN1T9fNwhiOk5rFNixUYGMIbk+my/s/opL9E+yPoxV/Itey6e
 HKf+dMaijDJBcWqy0PgnRkmH+BS444c0W+BaGqjY8XmbxWqx2iW93VzeFGLvZWRWVrMKcygwBjy
 1gywmoa1uSr4gM8ev/+/DuahLw/Tbsa3i7Srt8fpUydFSw2YDj3gzP26M72nxcgRIomlSuAT91h
 e2jr3ZHzC9Cdu5zinukCi3DkiK/Uq8kIcVXPETQcGBhUwbbFl4thwE4QVzoGfseJZ1I1dBBKxYU
 ewvFWh83aA7Szhrcs2FNstbtaMnjFTbvFbEmfmyrzyr2Zn0QvW8pMWTQ==
X-Received: by 2002:a05:600c:548d:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-4801e2a4c3bmr24839485e9.0.1768543238569; 
 Thu, 15 Jan 2026 22:00:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e886834sm25840475e9.7.2026.01.15.22.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 22:00:37 -0800 (PST)
Message-ID: <1640c849-9c10-4033-948e-9a2660640a21@linaro.org>
Date: Fri, 16 Jan 2026 07:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/58] gitlab: Remove 32-bit host testing
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116033305.51162-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/1/26 04:32, Richard Henderson wrote:
> These deprecated builds will be disabled.
> Remove testing of armhf and i686.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/container-cross.yml | 12 ---------
>   .gitlab-ci.d/containers.yml      |  2 --
>   .gitlab-ci.d/crossbuilds.yml     | 45 --------------------------------
>   3 files changed, 59 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

