Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE49E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 02:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRjHt-00035v-IP; Sat, 28 Dec 2024 21:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tRjHp-00035a-OZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 21:44:14 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tRjHn-0000Oi-Qa
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 21:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735440248; x=1736045048; i=deller@gmx.de;
 bh=l51oapgnsoambBuY+Kz/MogVOQ1nnYr5DntqXJJDcA4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eWNQcW7NdPwK0GyiuE/CCH2Xu9dwcEO5g4FGQPfbU/j6HPu1fDZs7lSZPmPEjOIz
 UAoVXp4sN291ByQ9IL1szM4/SoHJD7LL0fkB87dLKzOd3Dzp/dGSNIYbADYngrJ7E
 6ZCUMYpuUzlNsy09mLfwzBdtgzFpJrcjdS+/PVNrOsc4ePVqMPuPprULV5ZN57T3H
 lmnXC8abBuBxT7IqquPac6UuIw19vrPfSiJDygi3GOuEG2Imhyqrinxp2gmXa16Mu
 P6xNmydmQycBaZZePzZKiSNRTRVvrSX+1sXruJipdW9sO2UDFIeNWK/BpNE/8oCNK
 sW/RpTuUFENXd5+KLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1teqJk2Ul6-00zSle; Sun, 29
 Dec 2024 03:44:08 +0100
Message-ID: <1db87d1a-cf80-4dbe-9d79-d9711d7c172f@gmx.de>
Date: Sun, 29 Dec 2024 03:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/hppa: Add CPU reset method
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@kernel.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <Z281jSej_buitgV8@p100>
 <3b0804a9-4df9-4eb0-bdc8-2745b62355e8@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3b0804a9-4df9-4eb0-bdc8-2745b62355e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UD7IOM+83t8reMnZSTPZungEUjWP0VmkBY2cyku1DP/3YCrtBji
 G0jjCz08lOCuXED8xo/AufKX/sVolIa8KqXVYFBp/5TDeMqxdO3Ups2cGJ8ai6pAJvY7l7e
 3RbonC/fNPx+ZgoVV0pKH3wge1l81DsxJzOsGxlOnQ6rmBgTsj6fgJdBr1i03VZt7eL3U8h
 GOozDvff5wLo0KT/LFcyg==
UI-OutboundReport: notjunk:1;M01:P0:466uZz84hWU=;bX/pFzdwzbzZAgrVMxqubNhLtO7
 tCz77LpTfEaZ5cMf9k3q7CTEyE9t7R/uWVOYbx+IFmSG3ZhoDHorxEsOXa2bhDBI0mwGHSou+
 inJJyx6xh5/gy29ZWPNkvocVC/6/T3q37BzxCKRXday0QNMfD9a9ez3MX24OW5umWRItVJtyf
 1HJ0H7x34dLD1Ia1cPF1R6yI3OOMCZuXWqOx9j09FRbQZ9t1nVFZLYEYC1h89B1q7ShubZQi8
 A/OGOLy74rGzlJovv0c55fmqw/oXGlojAsdSUtlpIS+hi4sfEZp2PwoahViQrMy2PyaAYJqR9
 R/IvbzSE1hE3jOgJq8nBKz6wYiVhDVQo5wi5UH4FgVh28D4RI0Nk05PMHdPGvEJnNFnAXleJ6
 NYwBF1QeNKsDeEuvvOjqaYjrzBRVl1ZrYYjQMOyZQe6Pqkl31Ul6qukZYsd6kfe/s8OeCYwR2
 GkluKn4wGUd4049O6aY4Plid0QvWqz8eARLEgW6pkOwztXt6vq5TC/i1ZKXrFiDA7AItKknBU
 Op7sYud1Wro9xOsY/lsR1I0Jdg+v7G1jJ8/MYT8gxXm2JcGixb6UPtzvLSBhNjYvyNGfveAAO
 ErwQ4M6FBFTZyl/a8pytd43EphgpV1mGGprqBzA1wWVN4dckVsbn/hxv+ekBSp5fGhZUM1KYT
 GgS5JcgahZmxcIaHKXDUluTfC1q8Orih19vBRGXAksPJzmgi8gfFmSI4WcEeGWDYXJfhtzk4T
 OdcTHnvuo6k9K67yPxIiMfYbWuiSUbZHce5sK1ya4E31LeTMLVMJTOGU1WEfumfIe0ZQ3x741
 MsO1bzKHd1TiE7yt/KSKrbmxQUhUfqhmNBi0vcuGYkKhblgfiA6wZGF0N9BfHyn3S9wcepJGJ
 8mxE5PqxRsXG1/meGP8gCyeySX7bWOX7x0D1uxLzi2BtAAssi+L9T+q6kdPvOJDVB3FD8S+Yp
 5kz3mgFnYHAlupLqXB2kHYH19AXAJ8YMsddf3rHvYGOSPgx6tARS58D0ZcGfMBQ7E6DCsY7r5
 xgmfM5yA7WSxX9jQknCX8KmdIcf6j7RVjcCTxIrUAiI714QFytfewx+vUYdzw3dh7FdXvD87D
 bNvR4kPVaxSMqZ0SYSMBSbZ82Th8mC
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/29/24 02:58, Richard Henderson wrote:
> On 12/27/24 15:17, Helge Deller wrote:
>> Add the CPU reset method, which resets all CPU registers and the TLB to
>> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) an=
d
>> start execution at address 0xf0000004.
>> Although we currently want to zero out all values in the CPUHPPAState
>> struct, add the end_reset_fields marker in case the state structs gets
>> extended with other variables later on which should not be reset.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> V3:
>> - Call reset function from hppa_machine_reset() instead
>>
>> V2:
>> - Add end_reset_fields marker
>> - call reset function in hppa_cpu_initfn()
> ...
>> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
>> index c38439c180..b908cf65c6 100644
>> --- a/target/hppa/cpu.c
>> +++ b/target/hppa/cpu.c
>> @@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops =3D {
>> =C2=A0 #endif /* !CONFIG_USER_ONLY */
>> =C2=A0 };
>> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
>> +{
>> +=C2=A0=C2=A0=C2=A0 HPPACPU *cpu =3D HPPA_CPU(obj);
>> +=C2=A0=C2=A0=C2=A0 HPPACPUClass *scc =3D HPPA_CPU_GET_CLASS(cpu);
>> +=C2=A0=C2=A0=C2=A0 CPUHPPAState *env =3D &cpu->env;
>> +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (scc->parent_phases.hold) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scc->parent_phases.hold(obj=
, type);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 memset(env, 0, offsetof(CPUHPPAState, end_reset_fie=
lds));
>> +=C2=A0=C2=A0=C2=A0 cpu_set_pc(cs, 0xf0000004);
>> +=C2=A0=C2=A0=C2=A0 cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0=
);
>> +=C2=A0=C2=A0=C2=A0 cpu_hppa_loaded_fr0(env);
>> +
>> +=C2=A0=C2=A0=C2=A0 cs->exception_index =3D -1;
>> +=C2=A0=C2=A0=C2=A0 cs->halted =3D 0;
>> +}
>
> There's also a set of exception_index in hppa_cpu_initfn.

I don't quite understand...
Do you suggest I should remove the initialization of exception_index here,
or drop the one in hppa_cpu_initfn() ?

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!
Helge

