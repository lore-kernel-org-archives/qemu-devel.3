Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D78FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2oE-0004Jv-Cm; Wed, 17 Jul 2024 07:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2oC-0004Eh-KY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:26:56 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2oA-00089G-6E
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:26:56 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-48ff19d7074so373010137.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721215613; x=1721820413;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JX+nAjcYY+LMDcfImL4020FgTCtt3QdRUVW8xwG+iHc=;
 b=BTc+rekVTWp4j07qXKnjVuh8wGpRjbM74qKuZ34huarLGR6MG+AcsnXo4JM8XVGX/w
 XrZFy+6DyBhkhPuRmes6Sjh4mW8Gt/utxTngUOu5dixkqVqS8floEY13vlFUE/s3wkYP
 GaftLTvosmxhTTlqucHKSFAuFvERh1usSOasfBsdlIt0AKxOi3CgQCW3U63QJbqE8rA6
 WU7QCYp/fosQfI801ZTeu4Mi1uoa4F67gm2PV39Ky0wsZMk74J2gLyLS4L924ugeSXNu
 mt5CGmhUSFyHqnPErOrXiYEvxCa/K7o1d7xJ+izubWxZmQunVYIMTAvAvtICD1WK7ZhC
 a8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721215613; x=1721820413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JX+nAjcYY+LMDcfImL4020FgTCtt3QdRUVW8xwG+iHc=;
 b=nAdiWvfWlz+QlNgo3MBKMQsKkDr8EZb2T/OgynVpEBkCwqFXxIoxiEmGiE8sRcVaRV
 LN/LuQXddgtUJt3QURQQvZ2YnNPowtSDQn7yX95nxzjbYTE1gN3I1ZCAEsPP4VG+f6BH
 PJDmBr7qZxsobh0WqSs/dSkmjttosnPXMaWv6zeDco1V7ASZdZyWtQUR7PkUK9CJRYId
 nvhSiN8IHZaAurXK+P+fggWpGKMj0972rZpvfX0B40pl92CAeAUi+fexBZC02opDZUCj
 eg79KGvxl9X5SZhW3EfKevjZCAXmQfpPG3Ptbel2mZF40snR2+j5wMagdtum5mABBOx0
 I1Dg==
X-Gm-Message-State: AOJu0YyPGSGveU6SWQPc39TWELqsjQlfkOO3dedOZhM+ad8EFhRPAMqw
 8svcnhtLJQUY2DVjQMP3Ud4m1m5P5kkf72osqFgi9TAW0opFEkE3slUj9QFNwLKxD29Q9om8/ua
 2aLLaKl1AqQq6c0BfKE8bshjW9TZlOsph9CQi0qo4Ndnlh4b8q76T
X-Google-Smtp-Source: AGHT+IGiKGPKntC2ILZ4ttsy7T7kPNHOlElfba30TYpgUKsJZvu5wfZTUhxE9ikauuH4jkse/6gj88chIc8iK9yJPMs=
X-Received: by 2002:a05:6102:549e:b0:48f:db67:16ee with SMTP id
 ada2fe7eead31-4915614eea5mr1617533137.2.1721215612765; Wed, 17 Jul 2024
 04:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240624094647.77156-1-phil@philjordan.eu>
 <CAAibmn0HizdzdqACQRQHamzYqL6J1_FPo-bzOodJQM2CCZv_dg@mail.gmail.com>
In-Reply-To: <CAAibmn0HizdzdqACQRQHamzYqL6J1_FPo-bzOodJQM2CCZv_dg@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 13:26:41 +0200
Message-ID: <CAAibmn0YD_XaYcY8vVb-sdgv3NUe06dv6YPNifLaCjnf5HMysw@mail.gmail.com>
Subject: Re: [PATCH] i386/hvf: Integrates x2APIC support with hvf accel
To: qemu-devel@nongnu.org
Cc: lists@philjordan.eu,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="0000000000002e601e061d6fbda4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e35;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000002e601e061d6fbda4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pinging Philippe and Akihiko-san. Would you mind taking a look at this
patch as you've tested & reviewed other macOS specific patches? We've found
it to improve performance by 20%+ on most SMP guest workloads. The listed
HVF maintainers haven't been active on-list for 8+ months, so unless
patches touch code areas with other maintainers, HVF patches are mostly
being ignored.

Thanks!

Phil


On Mon, 8 Jul 2024 at 16:37, Phil Dennis-Jordan <phil@philjordan.eu> wrote:

> Ping!
>
> It would be nice to get this one in before the 9.1 merge window closes.
>
> Thanks,
> Phil
>
>
>
>
> On Mon, 24 Jun 2024 at 11:47, Phil Dennis-Jordan <phil@philjordan.eu>
> wrote:
>
>> Support for x2APIC mode was recently introduced in the software emulated
>> APIC implementation for TCG. Enabling it when using macOS=E2=80=99s hvf
>> accelerator is useful and significantly helps performance, as Qemu
>> currently uses the emulated APIC when running on hvf as well.
>>
>> This change wires up the read & write operations for the MSR VM exits
>> and allow-lists the CPUID flag in the x86 hvf runtime.
>>
>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> ---
>>  target/i386/hvf/x86_cpuid.c |  4 ++--
>>  target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
>> index e56cd8411b..4f260d46a8 100644
>> --- a/target/i386/hvf/x86_cpuid.c
>> +++ b/target/i386/hvf/x86_cpuid.c
>> @@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func,
>> uint32_t idx,
>>               CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
>>               CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
>>          ecx &=3D CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3=
 |
>> -             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
>> -             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
>> +             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
>> CPUID_EXT_SSE41 |
>> +             CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
>>               CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
>>               CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
>>          ecx |=3D CPUID_EXT_HYPERVISOR;
>> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
>> index 38c782b8e3..be675bcfb7 100644
>> --- a/target/i386/hvf/x86_emu.c
>> +++ b/target/i386/hvf/x86_emu.c
>> @@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct
>> x86_decode *decode)
>>      env->eip +=3D decode->len;
>>  }
>>
>> +static void raise_exception(CPUX86State *env, int exception_index,
>> +                            int error_code)
>> +{
>> +    env->exception_nr =3D exception_index;
>> +    env->error_code =3D error_code;
>> +    env->has_error_code =3D true;
>> +    env->exception_injected =3D 1;
>> +}
>> +
>>  void simulate_rdmsr(CPUX86State *env)
>>  {
>>      X86CPU *cpu =3D env_archcpu(env);
>> @@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)
>>      case MSR_IA32_APICBASE:
>>          val =3D cpu_get_apic_base(cpu->apic_state);
>>          break;
>> +    case MSR_APIC_START ... MSR_APIC_END: {
>> +        int ret;
>> +        int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
>> +
>> +        ret =3D apic_msr_read(index, &val);
>> +        if (ret < 0) {
>> +            raise_exception(env, EXCP0D_GPF, 0);
>> +        }
>> +
>> +        break;
>> +    }
>>      case MSR_IA32_UCODE_REV:
>>          val =3D cpu->ucode_rev;
>>          break;
>> @@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)
>>      case MSR_IA32_APICBASE:
>>          cpu_set_apic_base(cpu->apic_state, data);
>>          break;
>> +    case MSR_APIC_START ... MSR_APIC_END: {
>> +        int ret;
>> +        int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
>> +
>> +        ret =3D apic_msr_write(index, data);
>> +        if (ret < 0) {
>> +            raise_exception(env, EXCP0D_GPF, 0);
>> +        }
>> +
>> +        break;
>> +    }
>>      case MSR_FSBASE:
>>          wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
>>          break;
>> --
>> 2.39.3 (Apple Git-146)
>>
>>

--0000000000002e601e061d6fbda4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Pinging Philippe and Akihiko-san. Would you mind taki=
ng a look at this patch as you&#39;ve tested &amp; reviewed other macOS spe=
cific patches? We&#39;ve found it to improve performance by 20%+ on most SM=
P guest workloads. The listed HVF maintainers haven&#39;t been active on-li=
st for 8+ months, so unless patches touch code areas with other maintainers=
, HVF patches are mostly being ignored.<br></div><div dir=3D"ltr"><br></div=
><div>Thanks!</div><div><br></div><div>Phil</div><div><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 8 Jul 202=
4 at 16:37, Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Ping!</div><div><br=
></div><div>It would be nice to get this one in before the 9.1 merge window=
 closes.</div><div><br></div><div>Thanks,</div><div>Phil</div><div><br></di=
v><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Mon, 24 Jun 2024 at 11:47, Phil Dennis-J=
ordan &lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@phil=
jordan.eu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Support for x2APIC mode was recently introduced in the software =
emulated<br>
APIC implementation for TCG. Enabling it when using macOS=E2=80=99s hvf<br>
accelerator is useful and significantly helps performance, as Qemu<br>
currently uses the emulated APIC when running on hvf as well.<br>
<br>
This change wires up the read &amp; write operations for the MSR VM exits<b=
r>
and allow-lists the CPUID flag in the x86 hvf runtime.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
---<br>
=C2=A0target/i386/hvf/x86_cpuid.c |=C2=A0 4 ++--<br>
=C2=A0target/i386/hvf/x86_emu.c=C2=A0 =C2=A0| 31 ++++++++++++++++++++++++++=
+++++<br>
=C2=A02 files changed, 33 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c<br>
index e56cd8411b..4f260d46a8 100644<br>
--- a/target/i386/hvf/x86_cpuid.c<br>
+++ b/target/i386/hvf/x86_cpuid.c<br>
@@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t =
idx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_PAT | CPUID_PSE36 | =
CPUID_CLFLUSH | CPUID_MMX |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_FXSR | CPUID_SSE | C=
PUID_SSE2 | CPUID_SS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecx &amp;=3D CPUID_EXT_SSE3 | CPUID_EXT_P=
CLMULQDQ | CPUID_EXT_SSSE3 |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_FMA | CPUID_EXT_=
CX16 | CPUID_EXT_PCID |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_SSE41 | CPUID_EX=
T_SSE42 | CPUID_EXT_MOVBE |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_FMA | CPUID_EXT_=
CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_SSE42 | CPUID_EX=
T_X2APIC | CPUID_EXT_MOVBE |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_EXT_POPCNT | CPUID_E=
XT_AES | CPUID_EXT_XSAVE |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_EXT_AVX | CPUID_EXT_=
F16C | CPUID_EXT_RDRAND;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecx |=3D CPUID_EXT_HYPERVISOR;<br>
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c<br>
index 38c782b8e3..be675bcfb7 100644<br>
--- a/target/i386/hvf/x86_emu.c<br>
+++ b/target/i386/hvf/x86_emu.c<br>
@@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_dec=
ode *decode)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;eip +=3D decode-&gt;len;<br>
=C2=A0}<br>
<br>
+static void raise_exception(CPUX86State *env, int exception_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int error_code)<br>
+{<br>
+=C2=A0 =C2=A0 env-&gt;exception_nr =3D exception_index;<br>
+=C2=A0 =C2=A0 env-&gt;error_code =3D error_code;<br>
+=C2=A0 =C2=A0 env-&gt;has_error_code =3D true;<br>
+=C2=A0 =C2=A0 env-&gt;exception_injected =3D 1;<br>
+}<br>
+<br>
=C2=A0void simulate_rdmsr(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0X86CPU *cpu =3D env_archcpu(env);<br>
@@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_APICBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D cpu_get_apic_base(cpu-&gt;apic_st=
ate);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MSR_APIC_START ... MSR_APIC_END: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D (uint32_t)env-&gt;regs[R_ECX] - =
MSR_APIC_START;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D apic_msr_read(index, &amp;val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(env, EXCP0D_GPF,=
 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_UCODE_REV:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D cpu-&gt;ucode_rev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_APICBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_set_apic_base(cpu-&gt;apic_state, dat=
a);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MSR_APIC_START ... MSR_APIC_END: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D (uint32_t)env-&gt;regs[R_ECX] - =
MSR_APIC_START;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D apic_msr_write(index, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(env, EXCP0D_GPF,=
 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case MSR_FSBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wvmcs(cs-&gt;accel-&gt;fd, VMCS_GUEST_FS_=
BASE, data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.39.3 (Apple Git-146)<br>
<br>
</blockquote></div>
</blockquote></div>
</div>

--0000000000002e601e061d6fbda4--

