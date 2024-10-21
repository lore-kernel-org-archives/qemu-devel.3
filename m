Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FD8D17138
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2zJC-0005Gc-15; Mon, 21 Oct 2024 16:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t2zJA-0005GI-7N
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:47:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1t2zJ8-0007il-0s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:47:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso717344766b.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1729543634; x=1730148434; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N+6LrkdgPv0SCEWFTJM7+H5x0MLlTOlerbCbkD0hUGE=;
 b=DpVWX+HkJyBsFnoWk+QaR8BctWjlHJlgOs4HOGtnG5+vhFNCDPVwVtRwDwbWetftOS
 XBFPIBueqSoZJiJwK5Eshqb/ssqg22pF8ymU4duBMSjhT9jiYDqeKYWyTDZK/TJBAnIJ
 dZHn1crTZnKQmFRc7Fwwz8Gqamjk9/LsuIWpqkeivSJpufkFrzVsxNYSCQmsTMh0YOUw
 W2ej32d5QaHrue1ziI27sn5UIoF+MVqrTvoiauYYfjuq0IfjZ1zzP/z1LBLXsP+z8pE4
 Ixedv151VigtkM6kBIRGOUA6brtB4eS/Jr27LnHkwVA50zHDVTmXHbZUt4FF42gAb4ij
 bu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729543634; x=1730148434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N+6LrkdgPv0SCEWFTJM7+H5x0MLlTOlerbCbkD0hUGE=;
 b=w+ucn5wEuiD+rwQWDd4XNsdfaBuenC/jNosumpS3DjkuKlX9GdSUYOoibUoietosvL
 ho88HJvy5DPSPhnR25SM5MvDqB3u0cNMcloRDPWD7Jp43ESU3qUlzQTBYc6EgPwQ88nd
 27lgNaACRexS2FIQjr7ifJR67OU1qiNtC6hnR5nlv4LZlkhyvjXxHkLbF9K5q7kXmecn
 WVA+a7hw77TtW6VISwPVB/om2MnW1LS7icjXd4dDIGpAIQAfTnNGti3pLk+J/9K/QZrb
 mXh/A502Y8+s946gTJVeDC1GBdjS09wR4V78zboK5/QAplbgmLd5AW0mt/8pnEBiqwjo
 db2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkbwKx9HZkZ4O09xGXnlMQMWROEP3uRGZzyC1r/M7SXmhkHpbvbDe7gj86TB4XdbZESFeQlnLlJBSm@nongnu.org
X-Gm-Message-State: AOJu0YwjLMtsr20XvQvwkdjYjAItrKKj+7EXD+RornF/3fFUGHW/bKqT
 hcbGtzkCsE/nbq4IbGdzGZ2JJTYVyKBu/e6fj104TseAcMncec0PHB89cngXgkWnKXJXJa19DW3
 Eyzcla/zW7FMqj9JFsda6BeD1KX+SH9v8Aj40BQ==
X-Google-Smtp-Source: AGHT+IGBnt1Ft8t2uBs0XRqJOmoi3jCyDqY2PNSHP9Q/TPOGhkb83fnd19zIZ+eDDmduCKgexTnmohBsb3A2aXN6hYk=
X-Received: by 2002:a17:907:3ea1:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-a9a69ca14b7mr1377217666b.55.1729543634438; Mon, 21 Oct 2024
 13:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <b403fa29-2ccb-40fa-89d3-ce6d4152b766@redhat.com>
In-Reply-To: <b403fa29-2ccb-40fa-89d3-ce6d4152b766@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Mon, 21 Oct 2024 21:47:01 +0100
Message-ID: <CAJ7pxea0y8zPXmDj2cdPjow1KweE+_+YdAK+tau1GdD8hYUOmQ@mail.gmail.com>
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Gavin Shan <gshan@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 mst@redhat.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev, 
 david@redhat.com, philmd@linaro.org, peterx@redhat.com, eric.auger@redhat.com, 
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, 
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com, 
 linuxarm@huawei.com, gustavo.romero@linaro.org
Content-Type: multipart/alternative; boundary="000000000000f465c1062502c1c3"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ej1-x62d.google.com
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

--000000000000f465c1062502c1c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

Sorry for the late reply. I had to travel outside the UK urgently because
of some
personal challenging situation. I'm still on the transit back to the UK
hence replying
from my other email ID..

On Thu, Oct 17, 2024 at 8:07=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:

> Hi Salil,
>
> The issues reported against on RFCv3 are still existing. I'm listing them
> as below two.
>


Yes, the one existing I had mentioned as part of the TODO list at the end
of the RFC V5. Including below two mentioned.



> (1) Guest fails to start due to SVE initialization
>


I do not have the hardware to test this. I will not mind if you can share a
patch and also test this part.


>
> /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  =
\
> -accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don                  =
    \
> -cpu host -smp maxcpus=3D4,cpus=3D1,sockets=3D2,clusters=3D2,cores=3D1,th=
reads=3D1   \
> -m 4096M,slots=3D16,maxmem=3D128G                                        =
    \
> -object memory-backend-ram,id=3Dmem0,size=3D2048M                        =
    \
> -object memory-backend-ram,id=3Dmem1,size=3D2048M                        =
    \
>    :
> kvm_arch_init_vcpu: Error -22 from kvm_arm_sve_set_vls()
> qemu-system-aarch64: Failed to initialize host vcpu 1
>
> Workaround: The SVE feature bits in ID_AA64PFR0 need to be masked off in
> kvm_arm_get_host_cpu_features() after the feature register's value is rea=
d
> from the host.
>

This would happen if the kvm_arch_init_vcpu will be called again during
hotplug and its SVE related config is different from the one initially
configured at the KVM init time. I had included a patch to check such
configuration but did not test it for any of the ARm extensions
i.e. SVE, SME etc.

https://lore.kernel.org/qemu-devel/20241015100012.254223-23-salil.mehta@hua=
wei.com/


>
> (2) Fail to hot add vCPU whose PMU is turned off
>
> /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  =
\
> -accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don                  =
    \
> -cpu host -smp maxcpus=3D4,cpus=3D1,sockets=3D2,clusters=3D2,cores=3D1,th=
reads=3D1   \
> -m 4096M,slots=3D16,maxmem=3D128G                                        =
    \
> -object memory-backend-ram,id=3Dmem0,size=3D2048M                        =
    \
> -object memory-backend-ram,id=3Dmem1,size=3D2048M                        =
    \
>    :
> (qemu) device_add
> host-arm-cpu,id=3Dcpu1,socket-id=3D0,cluster-id=3D1,core-id=3D0,thread-id=
=3D0,pmu=3Doff
> kvm_arch_init_vcpu: Error -22 from kvm_arm_vcpu_init()
> qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (1): Invali=
d
> argument
>
> Workaround: Keep PMU on while the vCPU is hot added.
>

we should disallow any vCPU configuration different than already configured
at the KVM during VM initialization time.

Thanks


>
>
> Thanks,
> Gavin
>
>
>

--000000000000f465c1062502c1c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Gavin,<br></div><div =
dir=3D"ltr"><br></div><div>Sorry for the late reply. I had to travel outsid=
e the UK urgently because of some=C2=A0</div><div>personal=C2=A0challenging=
 situation. I&#39;m still on the transit back to the UK hence replying</div=
><div>from my other email ID..</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 2024 at 8:07=E2=80=AFAM Gavin=
 Shan &lt;<a href=3D"mailto:gshan@redhat.com">gshan@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Salil,<br>
<br>
The issues reported against on RFCv3 are still existing. I&#39;m listing th=
em<br>
as below two.<br></blockquote><div><br></div><div><br></div><div>Yes, the o=
ne existing I had mentioned as part of the TODO list at the end</div><div>o=
f the RFC V5. Including below two mentioned.</div><div>=C2=A0</div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
(1) Guest fails to start due to SVE initialization<br></blockquote><div><br=
></div><div><br></div><div>I do not have the hardware to test this. I will =
not mind if you can share a</div><div>patch and also test this part.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-cpu host -smp maxcpus=3D4,cpus=3D1,sockets=3D2,clusters=3D2,cores=3D1,thre=
ads=3D1=C2=A0 =C2=A0\<br>
-m 4096M,slots=3D16,maxmem=3D128G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-object memory-backend-ram,id=3Dmem0,size=3D2048M=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
-object memory-backend-ram,id=3Dmem1,size=3D2048M=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0:<br>
kvm_arch_init_vcpu: Error -22 from kvm_arm_sve_set_vls()<br>
qemu-system-aarch64: Failed to initialize host vcpu 1<br>
<br>
Workaround: The SVE feature bits in ID_AA64PFR0 need to be masked off in<br=
>
kvm_arm_get_host_cpu_features() after the feature register&#39;s value is r=
ead<br>
from the host.<br></blockquote><div><br></div><div>This would happen if the=
 kvm_arch_init_vcpu will be called again during</div><div>hotplug and its S=
VE related config is different from the one initially</div><div>configured =
at the KVM init time. I had included a patch to check such</div><div>config=
uration but did not test it for any of the ARm extensions</div><div>i.e. SV=
E, SME etc.</div><div><br></div><div><a href=3D"https://lore.kernel.org/qem=
u-devel/20241015100012.254223-23-salil.mehta@huawei.com/">https://lore.kern=
el.org/qemu-devel/20241015100012.254223-23-salil.mehta@huawei.com/</a><br><=
/div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
(2) Fail to hot add vCPU whose PMU is turned off<br>
<br>
/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-accel kvm -machine virt,gic-version=3Dhost,nvdimm=3Don=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-cpu host -smp maxcpus=3D4,cpus=3D1,sockets=3D2,clusters=3D2,cores=3D1,thre=
ads=3D1=C2=A0 =C2=A0\<br>
-m 4096M,slots=3D16,maxmem=3D128G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-object memory-backend-ram,id=3Dmem0,size=3D2048M=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
-object memory-backend-ram,id=3Dmem1,size=3D2048M=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0:<br>
(qemu) device_add host-arm-cpu,id=3Dcpu1,socket-id=3D0,cluster-id=3D1,core-=
id=3D0,thread-id=3D0,pmu=3Doff<br>
kvm_arch_init_vcpu: Error -22 from kvm_arm_vcpu_init()<br>
qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (1): Invalid =
argument<br>
<br>
Workaround: Keep PMU on while the vCPU is hot added.<br></blockquote><div><=
br></div><div>we should disallow any vCPU configuration different than alre=
ady configured</div><div>at the KVM during VM initialization time.</div><di=
v><br></div><div>Thanks</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
<br>
Thanks,<br>
Gavin<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f465c1062502c1c3--

