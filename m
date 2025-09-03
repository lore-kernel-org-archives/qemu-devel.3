Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8126BCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utifE-0005E9-No; Wed, 03 Sep 2025 04:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utifB-0004yF-BH
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:16:17 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utif8-00023Q-Fr
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:16:16 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b040df389easo645150766b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756887369; x=1757492169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvnGN5I+4Xd8ST1Iu+S1aQnbXtg0tn0QCV9HrVJQ4tE=;
 b=RIfYhNsqqFyt1ETa3jVXj/bq8PxgJy80Xq7u6xs7x2g4gwTW0RP5wr4MGzLMc3fnPy
 8HimeObEv0mhX5Q0bHkxNrZEKORSOS7XD/Lo6Fn0rmcsy2UwD32TKSBdqATmKDQ5h+vx
 LHjuYHDbYj2USsXLB3mfIdt7yHP1Qy+kVvTHmuggf0QEnEnoyiRJCd9pt7kv9x2YJ4iN
 tEBkO5vZdAL5P1uedDS0NxFCfPgsYzTASfdC9dvadjvsAcdltZpObpnQn+7il63P6yQQ
 rSFlkd63OpT6M1+1+KQg/Du6Ac9pb7nh6JDxbajgiBRAS95JxQxjzQcPeZIYJLF69BnV
 X4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756887369; x=1757492169;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvnGN5I+4Xd8ST1Iu+S1aQnbXtg0tn0QCV9HrVJQ4tE=;
 b=CjvJlmVaZmdzsEYb4cOcduPx6mNMVT/Yv+oooYNzeg78ig3CR3pEBydNhkQzh9+KOg
 i5oHzFyvqp2KolQ3qDNvLwIhEL4pGg0m6eyUIiqSqSxs6vaDYSzLm3ootfw1CKwpSz67
 QY91HIb0iEQFDct+enkDzmzgS31tOOwEPutpUrj3fgaI+lH0JR/WT4hcj8BSVj3FwUl7
 DOUSPO3jUY7Y23KoLDPcI50eKV0b3Yx2uH3cBkfvyHgoFF6Vk2zHBv+ciKUnMn4gKzYU
 khtY1gBfy/Cxg/PlFx35mkM2MQl0s+JYyFctQAa6vf6Da8TknNkmX9CSXn4lB13qL1wt
 dFrg==
X-Gm-Message-State: AOJu0YyBLWJvVmCggm3AU8y+SBVnv9X7xlZTKaESqUXJjHLyAGWnmYb1
 9jrcRBWkWXsQzB0Phq6TG4o5qrz1uvShRc4eXINWPISuMFvb7WxF6Zz/i1B43muvgxEkuKaRpnh
 uYtis4Qk=
X-Gm-Gg: ASbGnctjhZhtaZAv3lGt7BgVJetKcfm2D+Anjgcc7Hid73o+ruCdTL56JdEo4upqqYV
 KgxAmz/d8QFn+p9BXa9B9KciR6rlQWga/jcgmjwe97n5SRyaoejH7DGsciFJbNTy1g/XLNC8bvD
 7ZXBKXhKE0E4624y+TGmKN6OHCWssu3dHPdl2napk8C3OmqUzpTRckm+zzdrkTnxS5JRdbOBxSX
 +1wwNpOs/KxRVAPLA6Kopj1TCiL2jTTc0jG5PUvuEmqJmqovaev8cI4FuiWlf12FLZ46fgTzDw/
 y7vyI5IJxtqso5cmV0N+p4qQrd3m+DNV0GzVpPZqegGu7S5jVxpO2DQ1/mRkB0L33Ca3BjMjTJq
 hEVb10hCZ0YxSoyAc3fm03J6U00u/dQIx5Q==
X-Google-Smtp-Source: AGHT+IF6RWyF/9Ju1XoQ1Fqy61B1V1/yNaHxs+rEvjRb+GFeO7h4ChICfBiAr2YVKwMWb/F5AxlG4A==
X-Received: by 2002:a17:907:9444:b0:b04:53cc:4400 with SMTP id
 a640c23a62f3a-b0453cc4661mr558065666b.27.1756887369416; 
 Wed, 03 Sep 2025 01:16:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff079861a1sm1202805766b.22.2025.09.03.01.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:16:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CE6D25F815;
 Wed, 03 Sep 2025 09:16:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] hw/arm: use g_autofree for fdt in arm_load_dtb
In-Reply-To: <CAFEAcA8WNFs5HGScaB1bs-u8bHT1MbS8BvWXefx-eSd7dCsz=Q@mail.gmail.com>
 (Peter Maydell's message of "Tue, 2 Sep 2025 10:36:00 +0100")
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-3-alex.bennee@linaro.org>
 <CAFEAcA8WNFs5HGScaB1bs-u8bHT1MbS8BvWXefx-eSd7dCsz=Q@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 03 Sep 2025 09:16:07 +0100
Message-ID: <877bygymrc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 1 Sept 2025 at 13:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> With the fdt being protected by g_autofree we can skip the goto fail
>> and bail out straight away. The only thing we must take care of is
>> stealing the pointer in the one case when we do need it to survive.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/arm/boot.c | 29 ++++++++++++-----------------
>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 56fd13b9f7c..749f2d08341 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -519,7 +519,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
>>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
>>                   ARMCPU *cpu)
>>  {
>> -    void *fdt =3D NULL;
>> +    g_autofree void *fdt =3D NULL;
>>      int size, rc, n =3D 0;
>>      uint32_t acells, scells;
>>      unsigned int i;
>
>
>> @@ -673,14 +672,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_boo=
t_info *binfo,
>>
>>      if (fdt !=3D ms->fdt) {
>>          g_free(ms->fdt);
>> -        ms->fdt =3D fdt;
>> +        ms->fdt =3D g_steal_pointer(&fdt);
>>      }
>>
>>      return size;
>> -> -fail:
>> -    g_free(fdt);
>> -    return -1;
>>  }
>
> Previously, if we get to the end of the function and fdt =3D=3D ms->fdt
> then we continue to use that DTB, and we don't free it.
> After this change, if fdt =3D=3D ms->fdt then we will skip the
> g_steal_pointer() and the g_autofree will free the memory,
> but leave ms->fdt still pointing to it.
>
> Since arm_load_dtb() is only called once it's a bit unclear
> to me whether this can happen -- I think you would need to have
> a board-specific arm_boot_info::get_dtb function which returned
> the MachineState::fdt pointer. But as this is supposed to
> just be a refactoring patch and the previous code clearly was
> written to account for the possibility of fdt =3D=3D ms->fdt,
> I think we should continue to handle that case.

Hmm I was thinking we could assert if ms->fdt is set because we clearly
shouldn't be loading one. For arm the only thing that sets ms->fdt is
create_fdt which also implies:

  vms->bootinfo.skip_dtb_autoload =3D true;

so on start-up we should either create or load - not both.

but then I am confused about why we do another arm_load_dtb in the
machine_done notifier.

Either way I can't see how fdt =3D g_malloc0(dt_size) could ever match
what might already be in ms->fdt.


>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

