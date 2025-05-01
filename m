Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D124C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZD8-0001fC-AP; Thu, 01 May 2025 15:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZD6-0001eC-JP
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:04:40 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZD4-0004iE-0z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:04:39 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so40489939f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746126276; x=1746731076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K4YDmSyud6q/pard33P/Y1HZdOYsUvHM646Z9mKyr3s=;
 b=qBD3OgzMT590QhqX/jIRyHvHlrGd1URMpd7jPfhcJr6EuGssZR5OI4M0cs/pkSknW0
 NTO4o6eFnvF0d7imT5VQWC8w12r6v4lFqvQpyJXDAYKaGAnSmCYPoF6+cV3wfEP0HadL
 o1esGD4x18KJ3olV1q18gkiJLbR2aGNyorZKVZGZQLIiqdJqBvg0oZjzPfC2OAGk9B5D
 X/HRZM8FjgNmpdAVRpAY18Ro71h2uKY/T7cUCJ7yen9FKkk8joUIbMPCQHkfAC7txriB
 gfZYPpLd9wSgwSEHrCZEpRQU52PCJ3b46jfimarT/ZS9/BiiUwqA/28qKsJvJF89NxCw
 DSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126276; x=1746731076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4YDmSyud6q/pard33P/Y1HZdOYsUvHM646Z9mKyr3s=;
 b=iV0+jeVmvrHRzF8+N4y2nrhdodu3P0bB6P0EX9COodzZRDCLLtFy+rb7tpmkRyQW4c
 y/9/8u0uG6c7yWxJOaSTPR9WRNUbZarevvJLUEZQaOtZyBXIuVMpw+HHrUJuZKXkbg7P
 I4W1/vW2fDgtSAWUstiNzf7yECaRu8OlXkdDFFBzloMnatV4VQXEcykW6PlCpbYWwtmQ
 Of5kF9zzKMNSJ4C4DI5z0YcyinhPC5ZERUFP6GtIjtlqtoSyUlDN0wC/aeqVfD2dWr1C
 BdHQRZqD1axrMGniwI5Zia1cSH/sg7KMx5AhFsGgf3R2qQ/vxYbvAZHgxiVEofstcLag
 tH0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh0+I5blU+VwU1VhembuvT0NW1dD0vlLNC1OEFaZYts7RCwTYOdW1ooqwS+o9abDxmLfHGTjSooYVq@nongnu.org
X-Gm-Message-State: AOJu0YyhKvmEF3W5VsUGsL0lpdsprornnwXkbnPyxjBWrg/7soWDMo9l
 3SoWj76lEbABBkgheR5kbPR17Pi7l4Mhs7uJeiSqsDY3wWb0CVyZUjvsdH+JTsI=
X-Gm-Gg: ASbGncuGJDTbvAU3pvdswg1ssjhWDWkO6iWMkrFENAcrPUhsU4YsvBXpFVjHkDiQ6SC
 RFmlECZ+H7vF66/c5o5JrnsT7WRfKinujaf29vHCffxeOv/NAPU/mNgDULkqJ5uutAvzStfm3eA
 vg+gmnwHaMtEzd3is289Zmn4PjUSlOJyZGQG3wB1GX2g1tgk2u7HIX/As6Vy37EGMOcKUbImiea
 bjTAUWf5rzDu58Q08UXT/rjuF35tPvrJ/b+cGvQMMglGVKM6/iD5TyalsQX0mFhaH8TIge5Huhf
 OaEXO39T00tUETr4hlRvrFktyw7nAh3cbVLX6YAKIFvJVEyb9zDcpa7fyKyc3EGysttEISrI26k
 /t4ILRmZ9+ZSryw==
X-Google-Smtp-Source: AGHT+IES7gfo924cu6NmC6Fpw1p44/31nhllgml6j8ZZP/Q+e4X6+bk0kLicbSEp6P9W/EBJ6lnsOw==
X-Received: by 2002:a05:6602:401b:b0:85b:3677:fa8b with SMTP id
 ca18e2360f4ac-866b424e060mr41003939f.13.1746126276702; 
 Thu, 01 May 2025 12:04:36 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a8cda94sm3393173.18.2025.05.01.12.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:04:36 -0700 (PDT)
Message-ID: <e8976a2f-b050-415b-912d-3f2231f20fa8@linaro.org>
Date: Thu, 1 May 2025 21:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/33] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd33.google.com
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

(why?)

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h  |  2 ++
>   target/arm/cpu.c      | 31 -------------------------------
>   target/arm/kvm-stub.c |  5 +++++
>   target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
>   4 files changed, 36 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


