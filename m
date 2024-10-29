Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F92AD3A696
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sjI-0003fn-Q2; Tue, 29 Oct 2024 16:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t5sjC-0003fJ-Bd
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:22:11 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1t5sj6-0001ac-Ae
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730233318; x=1730838118; i=deller@gmx.de;
 bh=SxeEjvXZCN1l0lB4tPVAp8U39Or/7FGXK6YmuRk2efg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WfgrPA+pJPgPKUAcuQsX8b5i7iPkC7V4Stfkm+99/VB/9WUhdmldt0dxL0yOp8mk
 gzJmJnSv9K1CSp5HNOFotxZjbHkLQ8PriyFKKpo06a8NHuuJDytbxCECo6QWbBbtB
 i6uCchrivqjfLhNpQcj6NNhLGY1tiZ7O9XauhbI6SxyCQfxQPUXOQruYHvVnJxEHE
 HZWjLDLXQkAoTbC2RFlHEV+A7E0Z7rK2aZMkuyrMUnR5MevD9Q7APi9GMzdatr+y9
 Dv8YKfzrcLThXxY2ItN989niOf/y2z7CEJKoQuN3YDRj7qUPN/9Y1z7ge+nqjNSRZ
 vFLlYeI/OZF1I9wCYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.235]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1tLXlF16MN-00KP36; Tue, 29
 Oct 2024 21:21:58 +0100
Message-ID: <4c610ec3-7a34-4cdb-905a-358be7166f12@gmx.de>
Date: Tue, 29 Oct 2024 21:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Add CPU reset method
To: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <Zxvinao2jcZgyAVG@p100>
 <CAFEAcA9N4fq6E9PAtkVPh=qArfZ56jdNoKDNUTUb7+u3d4VNJg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA9N4fq6E9PAtkVPh=qArfZ56jdNoKDNUTUb7+u3d4VNJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:62BjW+LvHqgsfwnKfeaDOLbFFl+Wp7WTj5GOZpQmc54NKnVVLto
 y/Fwvq+n/doC8ZnNt64VEddP12z6GTAjD7CB4EYBAWU4jvdAUyGxZuLmdx3L1f/dEGdA6t/
 KBHJDOdPiyn97IIcOxRqdKq3SNMisiFc0z2d9WljHSTB6m/AgNst6XROg1ozEYbvZHquzaq
 z4GFNBpHSjntp+abGA12g==
UI-OutboundReport: notjunk:1;M01:P0:Jif3oLfpbYo=;Ur1NoX9leqo04LZSDDIiHiKoac6
 WraxM+XaINSTXN3C/pT8tUCE3G55qNoCMYM8va7P9/yRxWe3G//5PMgiuOHleKr49hKvMjUMG
 aKgv3rF9P1hW6SeiOrwZKKJHl754RsErPCLYRekirIJJOAsF4EjDXNy2fakhFMwocfB5daZqi
 be2bIS91NHRdwtm8npk/j0pMet/GjasDbrtJpKZNfwd1JQY4zMIQjc3gaK8gagLkpt/39K8cm
 WwAMKLlfWzlyvB9Xl9GFMNHQIarXjBHY9GLoYDfsuEDyHBiX4mu36U3Nc7HPzbDu4ojTvr08g
 dYA8maryIbKunVfpEkpMHVTBeURqdydbY+v6wqmZy8tFBFKYfK5LV4ntr2q/TZvsSDnPNBn+x
 2fIAV6Vx7VgXLgE69cWdI6LMAvmw/67c/eD19iUF0fero+J4mTGhClYKc98kaDlg6GJyGOvWO
 5HbWbt+8jSyTDtRdGaPFuVHVdx69R2+gBZE9RYAHk3b/duumHuiMnawaTbEAaNoMJ1SKLiTcf
 0aBRTLUp4t13OI1WHlh15jPFPJuXtNNiwQ/VhB9ZhAGgigsVwF7tNqyrXep5aQnDmi3D+pYFd
 pwxNIg2DnZveGmDBjzeQJiXLFLJs0aEW5UL0Xb/+R6SzapHOKzgVJGb8BGBROI1w9jag3jel6
 LEGcV1f36QaxEiOHtHlt1wEAsCHyEPLofz/T1BuKOftmLNYwz9gan4mCGLl4o3ehNBDb6vzCR
 oCRXGXsMClPiVx4DDRIKtAIV23swPPwf2iYDXVdu+Hv8aJslrCJ0ApKW/0ZON5WdgyrBvmohX
 WfUvpDzJvH+EKZmOHwt71ytA==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/29/24 13:44, Peter Maydell wrote:
> On Fri, 25 Oct 2024 at 19:25, Helge Deller <deller@kernel.org> wrote:
>>
>> Add the missing CPU reset method, which resets all CPU registers and th=
e
>> TLB to zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not
>> set) and start execution at address 0xf0000004.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
>> index c38439c180..0cc696ccd3 100644
>> --- a/target/hppa/cpu.c
>> +++ b/target/hppa/cpu.c
>> @@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops =3D {
>>   #endif /* !CONFIG_USER_ONLY */
>>   };
>>
>> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
>> +{
>> +    HPPACPU *cpu =3D HPPA_CPU(obj);
>> +    HPPACPUClass *scc =3D HPPA_CPU_GET_CLASS(cpu);
>> +    CPUHPPAState *env =3D &cpu->env;
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    if (scc->parent_phases.hold) {
>> +        scc->parent_phases.hold(obj, type);
>> +    }
>> +
>> +    memset(env, 0, sizeof(*env));
>
> I would recommend doing what the other CPU classes do
> and having an end_reset_fields marker in your state
> struct to mark the last point which is zeroed out
>
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> which you then do with:
>      memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));

I did implemented it initially like this...

> In particular, I'm pretty sure you don't want to zero out
> pointer fields like tlb_partial. (That kind of data-structure
> piece of the cpu state struct either needs by-hand code to
> reset it to power-on state, or in some cases may be OK to
> simply leave alone across reset, depending on what it is.)

... and I did check the various pointers that it's correct that they
get zeroed out on reset. This is true for tlb_partial as well.

So, zero out the whole struct is OK currently.

>> +    cpu_set_pc(cs, 0xf0000004);
>> +    env->psw =3D PSW_Q;
>> +
>> +    cs->exception_index =3D -1;
>> +    cs->halted =3D 0;
>
> hppa_cpu_initfn() currently does these:
>
>      cs->exception_index =3D -1;
>      cpu_hppa_loaded_fr0(env);
>      cpu_hppa_put_psw(env, PSW_W);
>
> They should probably be moved to reset (or deleted, for
> the cases where the reset code above already does that work).

Yes.

> PS: the PSW reset value looks like a behaviour change. If that's
> intentional you probably want to do it in a separate patch.

That change actually doesn't really matter. On reset the SeaBIOS
firmware will immediately be executed and sets the correct bit width.

>> +}
>> +
>>   static void hppa_cpu_class_init(ObjectClass *oc, void *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>>       CPUClass *cc =3D CPU_CLASS(oc);
>>       HPPACPUClass *acc =3D HPPA_CPU_CLASS(oc);
>> +    ResettableClass *rc =3D RESETTABLE_CLASS(oc);
>>
>>       device_class_set_parent_realize(dc, hppa_cpu_realizefn,
>>                                       &acc->parent_realize);
>>
>> +    resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, =
NULL,
>> +                                       &acc->parent_phases);
>> +
>>       cc->class_by_name =3D hppa_cpu_class_by_name;
>>       cc->has_work =3D hppa_cpu_has_work;
>>       cc->mmu_index =3D hppa_cpu_mmu_index;
>
> The machinery for registering the reset handler function
> all looks good.

Thanks for review!
I'll send a new patch series.

Helge


