Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D74FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewOa-0003BT-0q; Fri, 16 Aug 2024 08:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewOX-0003AQ-Cy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:49:29 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewOV-0002Xt-Qv
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:49:29 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so2256719a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723812566; x=1724417366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/2nnqydntJEadUXC0EITzBVHEYX2kA59vRnZ8l/I/pY=;
 b=Zx1/b6a6JUNIcX++P3WDVGrGam6thhTVr3/3miyCCD41TOc78t6qxpxHgA2SVwD7jh
 WBWJJfUNl/N95XoFqFtyR4H++NHpmSBdvbuLtdl9YuqQ6FStmObIPGJNcg63PTrqeQ/q
 x9orqE9K5V+w0ONYb+8JpLNvuh2DEQbbp/CODuR8pW7WI1UTO12mnIoMjRvZQGl+oBGa
 OfjONMSxJdMEmN6xdQq6jpHotS1he8KfqqunoAb8YPUH4ct6srGRtuXNVDOjQqxWcs9c
 NkHqzr398NyJjaelIVOJtb0p1IV7XALqEmPoMLPrSE4k5Kktzs8NJY8INb6I2RAhb3S3
 HWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723812566; x=1724417366;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2nnqydntJEadUXC0EITzBVHEYX2kA59vRnZ8l/I/pY=;
 b=v2rqK0Mf/l+zVViOaTGGdf6H5FqUbPv5Cp9cvCOH0mTePLU/YgE58EAab1cBDo1oPf
 ZHuS2GsoYmLZyaYP4f0/bylZarxuJml3T9FF1PmIW5+JEpFHMmZHLLLbm4zuGGsweUrk
 kpnO9F4aNtlwjcVz6iGcGAwvThxZn2cTlrMFnEFNbC17MdsUj6eLIBxzn3pVAdebY4+9
 Dns/KRGZzDDloF7S5Wp5HFGcC6y+jBvresP4kJuszX77GPgfnTN6KfH8xUZcFQguQdYF
 TMB465ZPTjAUfG9IaqqTQl2zJ80xKG0WqeK588Y4n2oiGhLa2NexYzUWwQgcCUH9x0NR
 iK4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2mCIsBHtaM6GnZCK+FXejugpCiqzkFPKXRilqYPtlbEQXaxOe4FhhC2CTg+srmHiR84sjWCAwptWaUUPzf7kSs5OPSJI=
X-Gm-Message-State: AOJu0Yy2tQ5zpTaV+Z6PQLuMiiUMMnnt93YPet2EDMEQMTcvwxoT/JBz
 vAa/kQ9qZ4sitI/WOJFb9cxJTxits+Ua6YFHdcvKvNO60eFrw1M7uCfC/HBd56sHGITIrBM9Gn8
 6
X-Google-Smtp-Source: AGHT+IFnHtSOKjePSZCt9OMD7ojwTlR2n4vDFRVr7S6hau3hoXDz/RPkDQ5qBDLirHI1BnQCHLLd9A==
X-Received: by 2002:a17:907:94d4:b0:a7a:8a38:9d99 with SMTP id
 a640c23a62f3a-a83951c5bb5mr185996866b.35.1723812565646; 
 Fri, 16 Aug 2024 05:49:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383946441sm253063166b.148.2024.08.16.05.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 05:49:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53E835F867;
 Fri, 16 Aug 2024 13:49:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling
 on 32bits host
In-Reply-To: <10d3fd64-bb03-487b-afd2-28e0f5e014c6@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 Aug 2024 10:38:38 -0700")
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
 <10d3fd64-bb03-487b-afd2-28e0f5e014c6@linaro.org>
Date: Fri, 16 Aug 2024 13:49:24 +0100
Message-ID: <87cym83a5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 8/15/24 04:46, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 15/08/2024 01.36, Pierrick Bouvier wrote:
>>>> Found on debian stable (i386).
>>>> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
>>>> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integer=
 of different size [-Werror=3Dpointer-to-int-cast]
>>>>     477 |             effective_addr =3D (uint64_t) qemu_plugin_insn_h=
addr(insn);
>>>>         |
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    contrib/plugins/cache.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>>>> index 512ef6776b7..82ed734d6d4 100644
>>>> --- a/contrib/plugins/cache.c
>>>> +++ b/contrib/plugins/cache.c
>>>> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, s=
truct qemu_plugin_tb *tb)
>>>>        n_insns =3D qemu_plugin_tb_n_insns(tb);
>>>>        for (i =3D 0; i < n_insns; i++) {
>>>>            struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(t=
b, i);
>>>> -        uint64_t effective_addr;
>>>> +        uintptr_t effective_addr;
>>>>              if (sys) {
>>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_haddr(insn=
);
>>>> +            effective_addr =3D (uintptr_t) qemu_plugin_insn_haddr(ins=
n);
>>>>            } else {
>>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_vaddr(insn=
);
>>>> +            effective_addr =3D (uintptr_t)
>>>> qemu_plugin_insn_vaddr(insn);
>>>>            }
>>>
>>> Is this the right fix? I assume effective_addr stores an address of
>>> the guest, so if the guest is 64-bit and the host is 32-bit, you now
>>> lose the upper bits of the address...?
>> I think the problem is higher up, it was a mistake to have:
>>    void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn
>> *insn);
>> return *void, at least vaddr returns an explicit 64 bit value which
>> can
>> hold everything (at a slight expense to 32bit emulation hosts, but
>> seriously stop doing that we've been in the 64bit world for some time
>> now).
>>=20
>
> It's an open question I had. When executing 64 bits binaries on a 32
> bits host, are we emulating the full 64 bits address space, or do we
> restrict to 32 bits?

Yes - and having to jump through a few extra hoops to do it.

> For user mode, I don't see how it could be
> possible to have address space beyond the 32 bits range, but system
> mode is probably different.

For user-modes very simple base + addr calculation yes it is tricky and
we often fail to find a gap big enough to map the guest address space
into it. If we implement softmmu for linux-user we could get around this
difficulty for a cost.

>
> The real proper fix is to not encode directly value under udata for
> callbacks, but allocate this and pass a pointer instead.
>
>>>
>>> The casting for qemu_plugin_insn_vaddr is not required at all since it
>>> already returns an uint64_t, so you can remoe that one. For the haddr
>>> part, maybe do a double-cast:
>>>
>>>    effective_addr =3D (uint64_t)(uintptr_t)qemu_plugin_insn_haddr(insn)
>>>
>>> ?
>>>
>>>   Thomas
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

