Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F59606A333
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hP5YNm3+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW0X-0003BE-Mw; Mon, 09 Nov 2026 15:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xQW00-00034w-Vl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:29:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xQVzy-0006vK-Tc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:29:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so15988045e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794256187; x=1794860987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=60quz6GJ0ddLFf9bdqwa7huw1CPPQ4V2I59iLY+dFrs=;
 b=hP5YNm3+bNoi3UQMm2MUrIFJtHybu5ggegL0XpayojH/SKyeX3YqE13+d+Z+JVlHXM
 4fgeH6USrUa1JvDl2lm6gwvUUBgLFB/zgXOvUXN2GsN1dzG0XWv7keboscSp7lJ3rMWw
 Casrqi2QjnUluE8zQpbUIMQA1eLnaxNwE89VjKR1vSNZLI4SQ9cKfrUd/ZIReJ8TpAoj
 zFdKDtHrvz7zdCGWGMzEaeh0+d5A2dnY340Lx0QBroeLwPz0CgWM+REB75LLBILevXAG
 LIsazuO6orjIsxOfjz1B//z2dVWFOhVbXwmcbmMRvu02/XIUnBwETb7l0HxTdIn0PVf8
 aBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256187; x=1794860987;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=60quz6GJ0ddLFf9bdqwa7huw1CPPQ4V2I59iLY+dFrs=;
 b=KikV8S0ONzypxqpM1r5cfspMnxNxu8i60dUm0uFIbIalM/rikvoUeP8nvTNo9cszw9
 a4kraQ3KxQW62AFq7zUMNaOgrzbdErkq3VspbPM11/uo1aBnNnirZf31yLz4MQ7oyzMF
 SPjZdJvsASGl7B8p+wc0SqUAV9KkbnUh/DqUblMz88Ocx04gxqN41FOz9nxgTOWxaSOw
 42G9RbyvO7UPDPqUV/c7tk2wxtuWf5PFuKpUlISAuYwD16Y27wuFyTLBiTJcwFe4jMxf
 EiLtvaewUk+OVO39SgNVjs5z2Hxfk0rIk71nnMRlO8E7kvdL+1nC03rPN3774pNuEuSj
 VLDA==
X-Forwarded-Encrypted: i=1;
 AL+hErFX/W6woi75PbG+gUubeoqMt160uinI6aHZ0Bqt0b/bQJXSGvlN5pI4boMwCZ/KNN9DsL52+fTXeGku@nongnu.org
X-Gm-Message-State: APuU4Z+jt+INfc9SdIKaM9e1ktcmUdJ3U+4umt7T1tuZxixqLjJaQgnT
 koYKTDQAQrgWNf/gCAQejRxOm9yTe1Xu/n2dRI00y6DCWcuPh8OzHIYz
X-Gm-Gg: AYBFou15G9zBCJ8yxkbo4PkeSxEx9Xlk3XxhEBQDLq4lG7YZGSaTK2saQgqoHiqYu2A
 pmGeHo3P+dhNx+1+wHnP05YdJgTBDsSXAbQyqjlCR3tTPT4zPxj5X7/zMqDdfloala/lxrwIaIr
 Sr/rMUkae49GKNdY217Q11DK+MVm/6tIvWnxc75ML5+F+MwRYSX6kXUCo1ajporx5PBa30mF2cI
 0xvUy2JAAhUxkgY3I1XzVsZ5k3Ogdq+dhLy2Cdi2xI64Kk+fHAZvAjf3Sp2SiCKR33RhqXAW1wt
 T1kxlE3foVTvX7XFdjF3QKgvGs9nyJtn7zU38gQhn8+PG+Ahp9GWU8A2+VHvBOaTfvJem+dE0Or
 1MC7iNPGh+cnlO3qqGJG11VhpfM5eqH99dN+CHne+vLQRPOcNrj5z1Poob2ZSzJ8+DBng1/0+HQ
 MCLrjeE02GVQVhB7pE4mLgOoxD+QLek6RWRXTjf5JydZXerL9z5rSKy8u+IuVjgp5mV9wtMx3ZD
 RnC/pvIUvyXhfwI92kNy8x4hdiEVJASzW46PYez5gxH5EiV3+SjYXLkJqiS+h3d4GIC3Wm6rNb3
 ra0BmzqGctm3i2EWQoXCwp+JW7fnG/eqqMe6MkjKqtrgRA4IjzIa2yVbcntIfeI3+rwKem2UB7T
 qgNyvHeXScm11x/8SKJko+w==
X-Received: by 2002:a05:600c:3b0a:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4ba02348031mr6147435e9.10.1794256186610; 
 Mon, 09 Nov 2026 12:29:46 -0800 (PST)
Received: from [192.168.2.6] (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe9357sm14667545e9.9.2026.11.09.12.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:29:46 -0800 (PST)
From: Sampanis <nicksampanis@gmail.com>
X-Google-Original-From: Sampanis <Nicksampanis@gmail.com>
Message-ID: <f2d8dc74-8658-469c-98f1-6b09bfc09978@gmail.com>
Date: Mon, 9 Nov 2026 22:29:45 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] target/i386/tcg: Fix 64-bit RSP truncation in far
 call/return
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20261025231803.870-1-nicksampanis@gmail.com>
 <601fe158-f510-45a0-92d7-6732af1ef023@redhat.com>
Content-Language: en-US
In-Reply-To: <601fe158-f510-45a0-92d7-6732af1ef023@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=nicksampanis@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Paolo,

That is correct.

On RETF(with 32bit operand) when we are in long mode(LMA=1), the operand 
size(32) should be popped from the RSP even if it points at a 64bit 
address. Furthermore, `get_sp_mask()` tries to calculate the mask of 
RSP, based on attributes of SS segment, which is incorrect when we are 
in long mode(AMD manual 4.5.3). Maybe the fix should be the correct 
calculation of sp_mask in `get_sp_mask()` while we are in long mode. 
I've seen the use of setting sp_mask equal to -1 in the same function, 
when it does `if (env->hflags & HF_CS64_MASK) sa.sp_mask = -1;`  before 
calling SET_ESP(sa.sp, sa.sp_mask);. And I thought that I should just 
use that.

The other two bugs have the same root cause.

Best,

Nick

On 11/9/2026 8:56 PM, Paolo Bonzini wrote:
> On 10/26/26 00:18, NickSampanis wrote:
>> Found the bug while debugging a kernel using qemu-tcg where a retf with
>> a 32-bit operand size executed at an RSP above 4 GiB in long mode, 
>> leading
>> to a triple fault. This led me to investigate the retf handler of
>> qemu-tcg, and subsequently find two additional bugs in lcall.
>>
>> This series fixes three distinct cases where 64-bit stack pointers (RSP)
>> pointing above 4 GiB were incorrectly truncated to 16-bit or 32-bit 
>> values
>> during far control-flow instructions in 64-bit/long mode:
>>
>>      target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode
>>      target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit 
>> mode
>>      target/i386/tcg: Fix 64-bit RSP truncation on far call through a 
>> call gate
>>
>> For the first two patches, I used the HF_CS64_MASK flag of env->hflags
>> based on the similar check in the retf handler that sets the sp_mask 
>> to -1.
>> https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L2207 
>>
>>
>> For the third patch (far call through a call gate), patch 3 checks
>> shift == 2 instead, since the call-gate path increments shift under
>> EFER.LMA, so shift == 2 for any valid 64-bit gate regardless of the
>> caller's mode.
>> https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L1834 
>>
>>
>> Proof-of-Concept & Testing:
>>
>> I wrote a proof of concept for each bug. Each PoC is a 512-byte boot
>> sector that sets up a basic 4-level long mode page table mapping the
>> first 2 MiB of memory 1:1, maps a 2 MiB page at the 4 GiB virtual 
>> address,
>> points RSP above 4 GiB, and executes the instruction. The PoC source
>> files are available on GitHub Gist:
>>
>> 1) 64-bit RSP truncation on retf in 64-bit mode PoC
>> https://gist.github.com/NickSampanis/3d67093b5b99a5e9627912e2f8f4b297
>>
>> 2) 64-bit RSP truncation on far call in 64-bit mode PoC
>> https://gist.github.com/NickSampanis/d4dea9948a34fbdedeed91d77586ff05
>>
>> 3) 64-bit RSP truncation on far call through a call gate PoC
>> https://gist.github.com/NickSampanis/7e9c6a9c994ef67a1aea2b13814be441
>
> Interesting.  And really complicated...  The gist is that in 64-bit 
> mode, the operation size only governs how many bytes are popped, not 
> the stack size.  And for far CALL, in addition, your patch only 
> touches the same-stack case.
>
> Is that correct?
>
> Paolo

