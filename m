Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07EFCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkNB-0006Vc-Ls; Wed, 03 Sep 2025 06:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utkN9-0006U8-U8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:05:47 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utkN7-0007l5-Td
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:05:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0472bd218bso16862366b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756893944; x=1757498744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7AMY/oP1U7UV9PGXQs0jR7co3hCgfKnMoRVcHgW5Pw=;
 b=f4xSqIk/Ekc/oULaL/Il6QnFbFeqzPcbjKrdEeDBQd93dnQBBZJitlttMA2n6nQuty
 X4sNM0d2UUGye1XopMqV6TBhr0U7keeNhER9TkGzRvcNamc6xNF02sDIcdYn0HmQKrX3
 22E9sef4n+eHg0aUxtj3IvMfzZVtVABBQ2HAIFqHDUco/OVaodgdxiB8miKljVQ7SMFt
 +bKVc1HlHv6c6kB12nnDlWDv2CGOLb2r5Pvt4dljPH9r5HqUYyHSxdrb+ZP3iUOpvRj4
 YSc9WBRUSW9JM0JQH91X4npN5RJDp4SnyW/f2KO1jWBGICvdSZ/Z58F+CmpbKVQ1j6k/
 MfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756893944; x=1757498744;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7AMY/oP1U7UV9PGXQs0jR7co3hCgfKnMoRVcHgW5Pw=;
 b=XNnMHGONRDwWHJZKoZwM+iXBTj3KtbKw/6UwghlucHvcUD+UMFU6OVx4qxPiqmADQN
 LLRbb8ZTbZpmB6Uff36LF4C3r0PXrf4HsLvV4+y2ZngtbAGsLIV3UsrgnwnYG1yTjkEf
 KKWTb/ZmcsxnNmMQ5oWDHM3QzIGX1K/0YHFDcgLozp903qNJG6wYZaWMDd9NYe6odve3
 9HHT2Yre0qvbrozXWpZJtcP7R9GZUxh5R0H5iHeZdfl4Fm8T7m+RIbeu1WUTyLcuf5GJ
 BqnYfrMJ7en+EwalVKA/gT6MxQ12o2JGcjLig3JnnKBu+I1BhoVZRahY8nFugQLiIEe7
 2j9g==
X-Gm-Message-State: AOJu0Yy0wYPh+PEQHUZNhI0Jl1DrqsV1efgKYS+Ci0kHCm1I/HiiIsQ+
 ppdTABRuzook9/IHsBirVvl5D2UT/F7aVzdp0PktUSEkyrXi1/Qt8D5ICUA6CuvE3HI=
X-Gm-Gg: ASbGnctLfh3WaaSnQoyZdSSIUPdREHb6ubXuyAHesFjF9qyNVT/LYfPzsXfK1BmOs/a
 cQ11Ue/Ufk+HRftR6GoPC2zk9zllTUbCMoNuuMMfg13zENsASbD6Neq1P/IdRBaRZiv9LELNu//
 Vm1/iItvtHGz0hoXLsJlub3z7s6bbSI+Fj8hAVilL19gv23qwAQa64GAfd23u3J2+sa3hIX1oDV
 Ur5Hb0++lz493RSCA1r7W3kwNtOX9C+amiOKp8cTh3jEJ4GbrcyKavUpkwVQd7zO6yqAs/y/ded
 WO7jt2OtCiB+iEqRz2oydEsC884BYLIVGLUCcrU2P3z1UUftsNXqs9AlzIyyNQAPlGe2L9FeXL7
 zCQAGjjbAvL0H5Uh3Knkvj0U=
X-Google-Smtp-Source: AGHT+IEa0nwVwrSTfGPBS76hOUmh9XLL+vTcz0HLfqMN36ZVy0bqDT7mqaX+ltSvhMNhSHSprsXBmg==
X-Received: by 2002:a17:906:e0d:b0:b04:1a80:35b9 with SMTP id
 a640c23a62f3a-b041a80da54mr1032354866b.12.1756893942113; 
 Wed, 03 Sep 2025 03:05:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046eb335f5sm66606966b.28.2025.09.03.03.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 03:05:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30AD55F815;
 Wed, 03 Sep 2025 11:05:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] hw/arm: use g_autofree for fdt in arm_load_dtb
In-Reply-To: <877bygymrc.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 03 Sep 2025 09:16:07 +0100")
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-3-alex.bennee@linaro.org>
 <CAFEAcA8WNFs5HGScaB1bs-u8bHT1MbS8BvWXefx-eSd7dCsz=Q@mail.gmail.com>
 <877bygymrc.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 03 Sep 2025 11:05:40 +0100
Message-ID: <871ponzw97.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Mon, 1 Sept 2025 at 13:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> With the fdt being protected by g_autofree we can skip the goto fail
>>> and bail out straight away. The only thing we must take care of is
>>> stealing the pointer in the one case when we do need it to survive.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  hw/arm/boot.c | 29 ++++++++++++-----------------
>>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>>> index 56fd13b9f7c..749f2d08341 100644
>>> --- a/hw/arm/boot.c
>>> +++ b/hw/arm/boot.c
>>> @@ -519,7 +519,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>>>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
>>>                   ARMCPU *cpu)
>>>  {
>>> -    void *fdt =3D NULL;
>>> +    g_autofree void *fdt =3D NULL;
>>>      int size, rc, n =3D 0;
>>>      uint32_t acells, scells;
>>>      unsigned int i;
>>
>>
>>> @@ -673,14 +672,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_bo=
ot_info *binfo,
>>>
>>>      if (fdt !=3D ms->fdt) {
>>>          g_free(ms->fdt);
>>> -        ms->fdt =3D fdt;
>>> +        ms->fdt =3D g_steal_pointer(&fdt);
>>>      }
>>>
>>>      return size;
>>> -> -fail:
>>> -    g_free(fdt);
>>> -    return -1;
>>>  }
>>
>> Previously, if we get to the end of the function and fdt =3D=3D ms->fdt
>> then we continue to use that DTB, and we don't free it.
>> After this change, if fdt =3D=3D ms->fdt then we will skip the
>> g_steal_pointer() and the g_autofree will free the memory,
>> but leave ms->fdt still pointing to it.
>>
>> Since arm_load_dtb() is only called once it's a bit unclear
>> to me whether this can happen -- I think you would need to have
>> a board-specific arm_boot_info::get_dtb function which returned
>> the MachineState::fdt pointer. But as this is supposed to
>> just be a refactoring patch and the previous code clearly was
>> written to account for the possibility of fdt =3D=3D ms->fdt,
>> I think we should continue to handle that case.
>
> Hmm I was thinking we could assert if ms->fdt is set because we clearly
> shouldn't be loading one. For arm the only thing that sets ms->fdt is
> create_fdt which also implies:
>
>   vms->bootinfo.skip_dtb_autoload =3D true;
>
> so on start-up we should either create or load - not both.
>
> but then I am confused about why we do another arm_load_dtb in the
> machine_done notifier.
>
> Either way I can't see how fdt =3D g_malloc0(dt_size) could ever match
> what might already be in ms->fdt.

Ahh I see it now.
>
>
>>
>> thanks
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

