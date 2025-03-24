Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39710C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1two1t-0004jJ-4T; Mon, 24 Mar 2025 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1two1r-0004i6-FY
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:04:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1two1o-0001JO-Cd
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:04:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223a7065ff8so21865845ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742846646; x=1743451446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K22cW4qBn4awU7ILJ7ADy3cpZ5OQ/hdG+dxwswpBSjA=;
 b=JeD2SCl7hp8BsGWUeTcLwPVHg8rknb85psKqoaZon/JX6GIj+BZAH6Bzn47M2QhjZP
 dF44gobW4JCarY+gXjDkSidCQvKASPosHmIQTGlLJ9soP2B68YcN5TjcjvKbhwn1Cif6
 6VAHHpYY71lYPO4RIAe8zISCjPpuxpIlIjtjsNTIzfLkrCNxR37E132TwLfhLnczOLSr
 Sxvt92UhIn7NmpBowfV3sS/P1z1M2gMH46YXCgNXC8nLjbIPaZ/Ltg2ML9R8BoC19hyA
 MmRhFbQHEIFddg2KLMVrpOd7WYrElLvo4q6IipxdcBeM4PRaSB0/B3ENRNjLPpwY+ftJ
 gglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846646; x=1743451446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K22cW4qBn4awU7ILJ7ADy3cpZ5OQ/hdG+dxwswpBSjA=;
 b=pQsfG/rq+/ezykI2l3TdjfF4wSDrDgfzz/8/9JokSgbhC9veRrUTwKdsLvVpO5omfp
 UgRvOmYCRepfaYzZ9b2yYvi290J2SXXq6ilnk8uYf0EzlWOtgMNxBQR6Ji3hWaC1mbsv
 mQpFhq4h1RnzPgXrZxlj9ZwmZI8qqoIi+KftknjE+6+DpG0lwlC/Guw35qBDMQEgzzvT
 5qAdd2ogrZKeTHXyQAFWP3heHNbV/FPY5PJRnC7o+9aX9kD2KHJpJB35w6HC+87l1BlX
 8nXn2Wb6yRQHD/dE+NZx2QnE3MVIiKHcjgVH2UTQfiqxO4B6UC3Ha1MmQXx37ht2d1wI
 EC8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ktFf/A7FhJtwlqrhKz7doolXHHWKeXOImh2Assdp23sbHwaZQulqJj5q9/OgKFOikJ+cOqdwP6C+@nongnu.org
X-Gm-Message-State: AOJu0YzejM/rSEiIi7ocT771T5Xj23bPYTclJYSf4qtbxHm/JQXmaxeu
 lZJR8RUYy1y9h+Qktqi3a+f8ZnATglKCNmwnbGMK53ZQPaQMe7SSIm2OYcagQO0=
X-Gm-Gg: ASbGncs8EZyd5wNQxiU2dIGFNDxqL4RebxKCCS0vLFBx7ROdfR+y+9DH0+LNBFtRlMb
 CzO/8HdlwOSnEbBXooebWywRL3nmDglA6L4/2zDD3+gGOPY9WnNDZHPkT6LL/tPhsfio6YNA3GX
 GsW2rZ0DPdKwUK9w+dzcNzAKwMwW8DswQUKBdVy5MtEjmvCpgyzpnIC+AFh2tWQgAgEc/TBsxS3
 rNy0T6GK4Xy7CgkhxJqXZy2P4wO25TKJ0LnTIByFccqvQkkrJQulwsIaoEhSk4/AWAfQgXRFvdC
 TqccAT3Fyd+dk8lp2GA32QZC9biiNga9Gw1ytBtDo9o6DkA5a0BoE2n+PhKInQTDk94dkTlUvMZ
 eaigvVsoP
X-Google-Smtp-Source: AGHT+IEi4DaDhIyAxt2r52Nvm/SXYDg7U38Tkz/CjmH8BAYuaiOLsGKzgMN+R2tMoABfqDm4Fe5apQ==
X-Received: by 2002:a05:6a00:ab0d:b0:736:a77d:5412 with SMTP id
 d2e1a72fcca58-73905999e48mr21388813b3a.12.1742846646388; 
 Mon, 24 Mar 2025 13:04:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390600badfsm8433350b3a.83.2025.03.24.13.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:04:05 -0700 (PDT)
Message-ID: <f2fc4de2-7235-4c86-8574-2b8d630e5cd6@linaro.org>
Date: Mon, 24 Mar 2025 13:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-10-alex.bennee@linaro.org>
 <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
 <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/24/25 12:29, Pierrick Bouvier wrote:
> On 3/24/25 10:39, Richard Henderson wrote:
>> On 3/24/25 03:21, Alex Bennée wrote:
>>> +    #ifdef TARGET_BIG_ENDIAN
>>> +    MemOp end = MO_BE;
>>> +    #else
>>> +    MemOp end = MO_LE;
>>> +    #endif
>>> +#endif
>>
>> That's what MO_TE is for.
>>
>>> +/*
>>> + * Helpers copied from helpers.h just for handling target_ulong values
>>> + * from gdbstub's GByteArray based on what the build config is. This
>>> + * will need fixing for single-binary.
>>> + */
>>> +
>>> +#if TARGET_LONG_BITS == 64
>>> +#define ldtul_p(addr) ldq_p(addr)
>>> +#define gdb_get_regl_value(m, b, v) gdb_get_reg64_value(m, b, v)
>>> +#else
>>> +#define ldtul_p(addr) ldl_p(addr)
>>> +#define gdb_get_regl_value(m, b, v) gdb_get_reg32_value(m, b, v)
>>> +#endif
>>
>> Surely you're not intending to replicate this in any target that can have multiple sizes?
>> This is not an improvement.
>>
> 
> If I'm correct (and from v1), ppc is the only architecture having registers defined with 
> target_long types.

With a quick check, mips, riscv, sparc do as well.


r~

