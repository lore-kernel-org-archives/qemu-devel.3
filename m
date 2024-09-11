Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE25FEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMQC-0000ff-Fo; Wed, 11 Sep 2024 08:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1soMQ5-0000Cq-71
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:26:01 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1soMQ1-0000Ec-47
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:26:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so1371558a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1726057553; x=1726662353; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C0flz3BOAVW+SipOgDwY35TpZ6l1/7Fs1KgpV09Lmhw=;
 b=J+U05FNIflMwIVcV99f+lvEFvw2ikgygmdzHojRxLp+Lx0bIHqfCZxfSEUY/DUxgi9
 O0AzrYLes6gaI8hwfbEiNDNGTEn291SqiOcR4XfT9cjwvhi+HiHDVN3YWK1B0e3alVJl
 M30trmYGSnfXP21Yu2M6KPSVN9JO/ktgjKcdrQyGST5lyvP3iuqhNaDXqezmJLBe/snx
 TQ4vJpLVi3tCV7nyvxF/zCF2askskLBJr4ClJoFfnE6BxYC43Q50dkY+fFfZd6zOpOYl
 PUV4fUAIADPNV6vWUTkZXARN+YrC07UDwpLeWfNeHPH8Whd1ODVHz3JI04Nwsffqe8IT
 lP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057553; x=1726662353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0flz3BOAVW+SipOgDwY35TpZ6l1/7Fs1KgpV09Lmhw=;
 b=rqIOIPgFJfdkjR1SkUYxLvIsEpZCnwY5HU1bE4mAek+20bqRU+ZPjRSpwPV1FVfECz
 oMIPd+kqN0NAxatKJR/S6H8XxaLOwidAi3KkB5OD4CzIJ4np8qJ/r9GuBdaGzSIs9bWE
 REN53flQ3P2VPkQEMEJQQ51qJHCUMqgmvyCjG4WKbRTgikJIVyWKa9ZW7xCZZ6GMrHAC
 vAOt2aVV0+w8e0QpnOsIcIxK82jjHe7KPAr5cScMX/QmEUh+xU0jLRj8+RBXISq/SbiA
 f1RzpAzcRm+gIEY4H2CZ3H0n4j2bsv5Pb1zXPxpZjnVDxPonopuESqyxNCnQcbuB4yFW
 aYzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY0Gioygebi05PJrYSpXlib4HuXYLJ34fJLluKzOex2LtQyZB9ASltB9fskOexlpmQREIjR+yhlohJ@nongnu.org
X-Gm-Message-State: AOJu0YykNTysqzfybxJzPbbxn6aSX1NMgP450792P7b4ev6U9b4YQ17L
 igFmJJdbw9Vj4YsxeWEP1S8MfxmuPT8zJMKugUyPO9XLsQ2o23cFKd6cZv+D7CuyCEynLyILo+h
 NE9vMcl7LXN97b0CmNI8a4CUPdY88FuwQRNgC/g==
X-Google-Smtp-Source: AGHT+IGsaWE0jCK4Q95FzxoUsGfIrdrLWHYwhlhWH/evnwEkWjihjDBe7M41KAFrYl720+63KmW123RpXSuk+lPLE4s=
X-Received: by 2002:a05:6402:401d:b0:5be:c8ad:afd0 with SMTP id
 4fb4d7f45d1cf-5c4015e5dbcmr7145915a12.9.1726057552919; Wed, 11 Sep 2024
 05:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com> <Zthx3dQInrcgly6+@intel.com>
 <9376341923d94a2bbd8d24f4f6844585@huawei.com> <Zt8UGd9YRANnBPVT@intel.com>
 <cff9b8f407044deb8ed4b1aa5acea5f4@huawei.com>
 <20240911123510.00004557@Huawei.com>
In-Reply-To: <20240911123510.00004557@Huawei.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 11 Sep 2024 12:25:40 +0000
Message-ID: <CAJ7pxebQwihKVoXuXxyZ4HPZJxu-PnH1MJKZ8c9MotVc__o4xQ@mail.gmail.com>
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, 
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, 
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 "shahuang@redhat.com" <shahuang@redhat.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000004de4e20621d71713"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000004de4e20621d71713
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:35=E2=80=AFAM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> On Tue, 10 Sep 2024 12:01:05 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > HI Zhao,
>
> A few trivial comments inline.
>
> >
> > >  From: Zhao Liu <zhao1.liu@intel.com>
> > >  Sent: Monday, September 9, 2024 4:28 PM
> > >  To: Salil Mehta <salil.mehta@huawei.com>
> > >
> > >  On Wed, Sep 04, 2024 at 05:37:21PM +0000, Salil Mehta wrote:
> > >  > Date: Wed, 4 Sep 2024 17:37:21 +0000
> > >  > From: Salil Mehta <salil.mehta@huawei.com>
> > >  > Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new
> ARMCPU
> > >  > {socket,cluster,core,thread}-id property
> > >  >
> > >  > Hi Zhao,
> > >  >
> > >  > >  From: zhao1.liu@intel.com <zhao1.liu@intel.com>
> > >  > >  Sent: Wednesday, September 4, 2024 3:43 PM
> > >  > >  To: Salil Mehta <salil.mehta@huawei.com>
> > >  > >
> > >  > >  Hi Salil,
> > >  > >
> > >  > >  On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:
> > >  > >  > Date: Mon, 19 Aug 2024 11:53:52 +0000  > From: Salil Mehta
> > >  > > <salil.mehta@huawei.com>  > Subject: RE: [PATCH RFC V3 01/29]
> > >  > > arm/virt,target/arm: Add new ARMCPU  >
> > >  > > {socket,cluster,core,thread}-id property
> > >  > >
> > >  > >  [snip]
> > >  > >
> > >  > >  > >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList
> > >
> > >  > > *virt_possible_cpu_arch_ids(MachineState *ms)
> > >  > >  > >  >   {
> > >  > >  > >  >       int n;
> > >  > >  > >  >       unsigned int max_cpus =3D ms->smp.max_cpus;
> > >  > >  > >  > +    unsigned int smp_threads =3D ms->smp.threads;
> > >  > >  > >  >       VirtMachineState *vms =3D VIRT_MACHINE(ms);
> > >  > >  > >  >       MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> > >  > >  > >  >
> > >  > >  > >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList  > >
> > >  > > *virt_possible_cpu_arch_ids(MachineState *ms)
> > >  > >  > >  >       ms->possible_cpus->len =3D max_cpus;
> > >  > >  > >  >       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> > >  > >  > >  >           ms->possible_cpus->cpus[n].type =3D ms->cpu_ty=
pe;
> > >  > >  > >  > +        ms->possible_cpus->cpus[n].vcpus_count =3D
> smp_threads;
> > >  > >  > >  >           ms->possible_cpus->cpus[n].arch_id =3D
> > >  > >  > >  >               virt_cpu_mp_affinity(vms, n);
> > >  > >  > >  >
> > >  > >  > >
> > >  > >  > >  Why @vcpus_count is initialized to @smp_threads? it needs
> to
> > >  > > be  > > documented in the commit log.
> > >  > >  >
> > >  > >  >
> > >  > >  > Because every thread internally amounts to a vCPU in QOM and
> > >  > > which is  > in 1:1 relationship with KVM vCPU. AFAIK, QOM does n=
ot
> > >  > > strictly  > follows any architecture. Once you start to get into
> > >  > > details of  > threads there are many aspects of shared resources
> one
> > >  > > will have to  > consider and these can vary across different
> > >  > > implementations of  architecture.
> > >  > >
> > >  > >  For SPAPR CPU, the granularity of >possible_cpus->cpus[] is
> "core",
> > >  > > and for  x86, it's "thread" granularity.
> > >  >
> > >  >
> > >  > We have threads per-core at microarchitecture level in ARM as well=
.
> > >  > But each thread appears like a vCPU to OS and AFAICS there are no
> > >  > special attributes attached to it. SMT can be enabled/disabled at
> > >  > firmware and should get reflected in the configuration accordingly
> > >  > i.e. value of *threads-per-core* changes between 1 and 'N'.  This
> > >  > means 'vcpus_count' has to reflect the correct configuration. But =
I
> > >  > think threads lack proper representation in Qemu QOM.
> > >
> > >  In topology related part, SMT (of x86) usually represents the logica=
l
> > >  processor level. And thread has the same meaning.
> >
> >
> > Agreed. It is same in ARM as well. The difference could be in how
> hardware
> > threads are implemented at microarchitecture level.  Nevertheless, we d=
o
> > have such virtual configurations, and the meaning of *threads* as-in QO=
M
> > topology (socket,cluster,core,thread) is virtualized similar to the
> hardware
> > threads in host. And One should be able to configure threads support in
> the
> > virtual environment,  regardless whether or not underlying hardware
> > supports threads. That's my take.
> >
> > Other aspect is how we then expose these threads to the guest. The gues=
t
> > kernel (just like host kernel) should gather topology information using
> > ACPI PPTT Table (This is ARM specific?).
>
> Not ARM specific, but not used by x86 in practice (I believe some risc-v
> boards
> use it).
>
> https://lore.kernel.org/linux-riscv/20240617131425.7526-3-cuiyunhui@byted=
ance.com/
>
> > Later is populated by the Qemu
> > (just like by firmware for the host kernel) by making use of the virtua=
l
> > topology. ARM guest kernel, in absence of PPTT support can detect
> > presence of hardware threads by reading MT Bit within the MPIDR_EL1
> > register.
>
> Sadly no it can't.  Lots of CPUs cores that are single thread set that
> bit anyway (so it's garbage and PPTT / DT is the only source of truth)
>
> https://lore.kernel.org/all/CAFfO_h7vUEhqV15epf+_zVrbDhc3JrejkkOVsHzHgCXN=
k+nDdg@mail.gmail.com/T/



Yes, agreed, this last explanation was not completely correct.
IICRC, Marc did point out in RFC V1 of June 2020 that value  MT=3D0 is set =
by
KVM to tell the guest kernel that vCPUs at the same affinity-1 fields are
independent.
Problem was with the interpretation of non-zero MT Bit  and it was not
consistent.
The key thing is we should not rely on the value of the MT Bit in MPIDR to
know
if multithreading exists. So yes, to know the exact status of the
multithreading
on ARM systems parsing PPTT Table is the only way.

I mentioned that because handling still exists in the kernel code but I
think it exists
for handling those other cases. Maybe a comment is required here (?):

https://elixir.bootlin.com/linux/v6.11-rc7/source/arch/arm64/kernel/topolog=
y.c#L34

Thanks for pointing this out.


Thanks
Salil.




>
>
> Jonathan
>
>

--0000000000004de4e20621d71713
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Se=
p 11, 2024 at 11:35=E2=80=AFAM Jonathan Cameron &lt;<a href=3D"mailto:Jonat=
han.Cameron@huawei.com">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 10 Sep 2024 12:0=
1:05 +0100<br>
Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_blank"=
>salil.mehta@huawei.com</a>&gt; wrote:<br>
<br>
&gt; HI Zhao,<br>
<br>
A few trivial comments inline.<br>
<br>
&gt; <br>
&gt; &gt;=C2=A0 From: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" t=
arget=3D"_blank">zhao1.liu@intel.com</a>&gt;<br>
&gt; &gt;=C2=A0 Sent: Monday, September 9, 2024 4:28 PM<br>
&gt; &gt;=C2=A0 To: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.co=
m" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 On Wed, Sep 04, 2024 at 05:37:21PM +0000, Salil Mehta wrote=
:=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; Date: Wed, 4 Sep 2024 17:37:21 +0000<br>
&gt; &gt;=C2=A0 &gt; From: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@hu=
awei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt;=C2=A0 &gt; Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm:=
 Add new ARMCPU<br>
&gt; &gt;=C2=A0 &gt; {socket,cluster,core,thread}-id property<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; Hi Zhao,<br>
&gt; &gt;=C2=A0 &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 From: <a href=3D"mailto:zhao1.liu@intel.com=
" target=3D"_blank">zhao1.liu@intel.com</a> &lt;<a href=3D"mailto:zhao1.liu=
@intel.com" target=3D"_blank">zhao1.liu@intel.com</a>&gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 Sent: Wednesday, September 4, 2024 3:43 PM<=
br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 To: Salil Mehta &lt;<a href=3D"mailto:salil=
.mehta@huawei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 Hi Salil,<br>
&gt; &gt;=C2=A0 &gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 On Mon, Aug 19, 2024 at 11:53:52AM +0000, S=
alil Mehta wrote:=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; Date: Mon, 19 Aug 2024 11:53:52 +0000=
=C2=A0 &gt; From: Salil Mehta=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt; &lt;<a href=3D"mailto:salil.mehta@huawei.com" tar=
get=3D"_blank">salil.mehta@huawei.com</a>&gt;=C2=A0 &gt; Subject: RE: [PATC=
H RFC V3 01/29]<br>
&gt; &gt;=C2=A0 &gt; &gt; arm/virt,target/arm: Add new ARMCPU=C2=A0 &gt;<br=
>
&gt; &gt;=C2=A0 &gt; &gt; {socket,cluster,core,thread}-id property<br>
&gt; &gt;=C2=A0 &gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 [snip]<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; NULL); @@ -2708,6 +271=
6,7 @@ static const CPUArchIdList=C2=A0 &gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt; *virt_possible_cpu_arch_ids(MachineState *ms)=C2=
=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0int n;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned int max_cpus =3D ms-&gt;smp.max_cpus;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; +=C2=A0 =C2=A0 unsigne=
d int smp_threads =3D ms-&gt;smp.threads;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0VirtMachineState *vms =3D VIRT_MACHINE(ms);<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0MachineClass *mc =3D MACHINE_GET_CLASS(vms);<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; @@ -2721,6 +2730,7 @@ =
static const CPUArchIdList=C2=A0 &gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt; *virt_possible_cpu_arch_ids(MachineState *ms)=C2=
=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ms-&gt;possible_cpus-&gt;len =3D max_cpus;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0for (n =3D 0; n &lt; ms-&gt;possible_cpus-&gt;len; n++) {<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ms-&gt;possible_cpus-&gt;cpus[n].type =3D ms-&gt;cpu_ty=
pe;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ms-&gt;possible_cpus-&gt;cpus[n].vcpus_count =3D smp_threads;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ms-&gt;possible_cpus-&gt;cpus[n].arch_id =3D<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virt_cpu_mp_affinity(vms, n);<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; &gt;=C2=A0 Why @vcpus_count is initial=
ized to @smp_threads? it needs to=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt; be=C2=A0 &gt; &gt; documented in the commit log.=
=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 &gt; Because every thread internally amount=
s to a vCPU in QOM and=C2=A0 <br>
&gt; &gt;=C2=A0 &gt; &gt; which is=C2=A0 &gt; in 1:1 relationship with KVM =
vCPU. AFAIK, QOM does not<br>
&gt; &gt;=C2=A0 &gt; &gt; strictly=C2=A0 &gt; follows any architecture. Onc=
e you start to get into<br>
&gt; &gt;=C2=A0 &gt; &gt; details of=C2=A0 &gt; threads there are many aspe=
cts of shared resources one<br>
&gt; &gt;=C2=A0 &gt; &gt; will have to=C2=A0 &gt; consider and these can va=
ry across different<br>
&gt; &gt;=C2=A0 &gt; &gt; implementations of=C2=A0 architecture.<br>
&gt; &gt;=C2=A0 &gt; &gt;<br>
&gt; &gt;=C2=A0 &gt; &gt;=C2=A0 For SPAPR CPU, the granularity of &gt;possi=
ble_cpus-&gt;cpus[] is &quot;core&quot;,<br>
&gt; &gt;=C2=A0 &gt; &gt; and for=C2=A0 x86, it&#39;s &quot;thread&quot; gr=
anularity.=C2=A0 <br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt;=C2=A0 &gt; We have threads per-core at microarchitecture level in=
 ARM as well.<br>
&gt; &gt;=C2=A0 &gt; But each thread appears like a vCPU to OS and AFAICS t=
here are no<br>
&gt; &gt;=C2=A0 &gt; special attributes attached to it. SMT can be enabled/=
disabled at<br>
&gt; &gt;=C2=A0 &gt; firmware and should get reflected in the configuration=
 accordingly<br>
&gt; &gt;=C2=A0 &gt; i.e. value of *threads-per-core* changes between 1 and=
 &#39;N&#39;.=C2=A0 This<br>
&gt; &gt;=C2=A0 &gt; means &#39;vcpus_count&#39; has to reflect the correct=
 configuration. But I<br>
&gt; &gt;=C2=A0 &gt; think threads lack proper representation in Qemu QOM.=
=C2=A0 <br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 In topology related part, SMT (of x86) usually represents t=
he logical<br>
&gt; &gt;=C2=A0 processor level. And thread has the same meaning.=C2=A0 <br=
>
&gt; <br>
&gt; <br>
&gt; Agreed. It is same in ARM as well. The difference could be in how hard=
ware<br>
&gt; threads are implemented at microarchitecture level.=C2=A0 Nevertheless=
, we do<br>
&gt; have such virtual configurations, and the meaning of *threads* as-in Q=
OM<br>
&gt; topology (socket,cluster,core,thread) is virtualized similar to the ha=
rdware<br>
&gt; threads in host. And One should be able to configure threads support i=
n the<br>
&gt; virtual environment,=C2=A0 regardless whether or not underlying hardwa=
re<br>
&gt; supports threads. That&#39;s my take.<br>
&gt; <br>
&gt; Other aspect is how we then expose these threads to the guest. The gue=
st<br>
&gt; kernel (just like host kernel) should gather topology information usin=
g<br>
&gt; ACPI PPTT Table (This is ARM specific?). <br>
<br>
Not ARM specific, but not used by x86 in practice (I believe some risc-v bo=
ards<br>
use it).<br>
<a href=3D"https://lore.kernel.org/linux-riscv/20240617131425.7526-3-cuiyun=
hui@bytedance.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/linux-riscv/20240617131425.7526-3-cuiyunhui@bytedance.com/</a><br>
<br>
&gt; Later is populated by the Qemu<br>
&gt; (just like by firmware for the host kernel) by making use of the virtu=
al<br>
&gt; topology. ARM guest kernel, in absence of PPTT support can detect<br>
&gt; presence of hardware threads by reading MT Bit within the MPIDR_EL1<br=
>
&gt; register.<br>
<br>
Sadly no it can&#39;t.=C2=A0 Lots of CPUs cores that are single thread set =
that<br>
bit anyway (so it&#39;s garbage and PPTT / DT is the only source of truth)<=
br>
<a href=3D"https://lore.kernel.org/all/CAFfO_h7vUEhqV15epf+_zVrbDhc3JrejkkO=
VsHzHgCXNk+nDdg@mail.gmail.com/T/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/all/CAFfO_h7vUEhqV15epf+_zVrbDhc3JrejkkOVsHzHgCXNk+nDd=
g@mail.gmail.com/T/</a></blockquote><div><br></div><div><br></div><div>Yes,=
 agreed, this last explanation was not completely correct.=C2=A0</div><div>=
IICRC, Marc did point out in RFC V1 of June 2020 that value=C2=A0 MT=3D0 is=
 set by</div><div>KVM to tell the guest=C2=A0kernel that vCPUs at the same=
=C2=A0affinity-1=C2=A0fields are independent.</div><div>Problem was with th=
e interpretation of non-zero MT Bit=C2=A0 and it was not consistent.</div><=
div>The key thing is we should not rely on the value of the MT Bit in MPIDR=
 to know</div><div>if multithreading exists. So yes, to know the exact stat=
us of the multithreading</div><div>on ARM systems parsing PPTT Table is the=
 only way.</div><div><br></div><div>I mentioned that because handling still=
 exists in the kernel code but I think it exists</div><div>for handling=C2=
=A0those other cases. Maybe a comment is required here (?):</div><div><br><=
/div><div><div><a href=3D"https://elixir.bootlin.com/linux/v6.11-rc7/source=
/arch/arm64/kernel/topology.c#L34">https://elixir.bootlin.com/linux/v6.11-r=
c7/source/arch/arm64/kernel/topology.c#L34</a></div></div><div><br></div><d=
iv>Thanks for pointing=C2=A0this out.</div><div><br></div><div><br></div><d=
iv>Thanks<br></div><div>Salil.</div><div><br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Jonathan<br>
<br>
</blockquote></div></div></div></div></div></div></div></div>

--0000000000004de4e20621d71713--

