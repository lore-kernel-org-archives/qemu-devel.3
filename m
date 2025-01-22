Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D809C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabau-0000Os-Do; Wed, 22 Jan 2025 09:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tabas-0000OJ-JM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tabaq-0001l3-En
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737555631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dut6hZbDd6BfAIsiyGgJ+kYCdZA4Ogbk5rArrmutuEA=;
 b=YskXaTJWq4gAyteG64sA9zgujP9BbFEVqXaOLB+XGqXxxoFuMU9UhEhau/DnPC5z98SHZi
 dZEwDlkztVFes7u69UvyBtZnmpq6C3JtUp1z/boAVd3GghUkDNY9FU14RrX9hTGvrSkTZI
 7hXtWzp5yuersPjz40n/cmNAGntlueY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-3_JogLlJPSm-y9BpJ-CFYw-1; Wed, 22 Jan 2025 09:20:29 -0500
X-MC-Unique: 3_JogLlJPSm-y9BpJ-CFYw-1
X-Mimecast-MFC-AGG-ID: 3_JogLlJPSm-y9BpJ-CFYw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso37790265e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 06:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737555628; x=1738160428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dut6hZbDd6BfAIsiyGgJ+kYCdZA4Ogbk5rArrmutuEA=;
 b=ljEmIJLXhGPdreAQOfWVbOX3kLkpBa7yZkeaqcojdVN9iTZz0KO8gYKi3W2cn+j+Sj
 qy6jmdNd1vAV0vwMo5TRX5eadR27VpjQnZMUphYokE4gSWxqBWEdJQwRtO846ihlJnY+
 ER6YRpBrOAcgT/LidqxL2aBVPe+voExj9skZ0iEGO9XdpNtIA9ZZg5qDPaReutUExqdb
 XCfsXmkiadumCMRAMOYtafvjRG4xYBPCkfMDQXcUIb6QWqDYIjBglkJDNs2Vgh6SIIZl
 IawvKnLrmSm9YtsUpqgl1OHZMZowYjwxsl34OaWZxrlGZvh4NWgxcDuJ1/JHEgEKWX8L
 lwJA==
X-Gm-Message-State: AOJu0YyHnue9MOTqxqGKcn/UJ0qz73T2ZY8dFmse6CW3T9ujdY5xXRYZ
 +eHb7ltbNcpYe33fmYrIa5QKlODkj9gs7bUqECrqjlvMCOVgpakvANcVhJZ/IqlBXqnQmdRyLgm
 y4XQDVCk4cnzyQMp1dAAIajaTUHB4gAbKLA/fjUyMHvtaQT6+NU7IpYAfBvU8ZsA=
X-Gm-Gg: ASbGncvG+41t/HsAb0eU85q4bmZu81dgKYrXiXDmeCnw1ntbjzeosfDPg6fFu2sHFo/
 C9AK1VrbQgHNYefs8fRRhsq7UYyfNLJrQ+Jes4UfqlQ+YsKOi7WA1irdnWCz6yXqstsRet4lMVH
 ZNPG+uq+fu2v1yJq/la4vS1VIsP7QxHaGfKUNTYPotde/m0tplvTwY6B8ulGiuffrfbmkmqY8vh
 T4lztmUqgUCE3OtCNYqHyD8FHQSMZYvHN68DigIf8G9FOcojW5JurV2lKXa0bUpto7oB+f6Q8eT
 cfQpPyVlcXHo8vnFBuiFnyXKP30T7E3huqGF26Dz8Q==
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-43891451388mr174742355e9.26.1737555627656; 
 Wed, 22 Jan 2025 06:20:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5NEdwGW3AASXDNblTqeS/rrJSs7oL8g6o9u0iasINje1Lj5tIEqz7MQ/xoV62NeqtH0NxQQ==
X-Received: by 2002:a05:600c:4710:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-43891451388mr174742065e9.26.1737555627147; 
 Wed, 22 Jan 2025 06:20:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31af925sm26918075e9.23.2025.01.22.06.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 06:20:26 -0800 (PST)
Date: Wed, 22 Jan 2025 15:20:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>, Anton Johansson
 <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Marek Vasut <marex@denx.de>, David Gibson
 <david@gibson.dropbear.id.au>, Brian Cain <bcain@quicinc.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Claudio Fontana <cfontana@suse.de>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-ppc@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Aurelien
 Jarno <aurelien@aurel32.net>, Ilya Leoshkevich <iii@linux.ibm.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, Alistair Francis <alistair.francis@wdc.com>, Alessandro Di
 Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Chris Wulff <crwulff@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, Yanan Wang
 <wangyanan55@huawei.com>, Luc Michel <luc@lmichel.fr>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Bin Meng <bin.meng@windriver.com>, Stafford Horne
 <shorne@gmail.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, "Daniel P .
 Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Bernhard Beschow <shentey@gmail.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>, Michael Rolnik
 <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Markus
 Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 06/22] exec/cpu: Call cpu_remove_sync() once in
 cpu_common_unrealize()
Message-ID: <20250122152023.5ee90f50@imammedo.users.ipa.redhat.com>
In-Reply-To: <5f25576c-598f-4fd7-8238-61edcff2c411@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-7-philmd@linaro.org>
 <20231128174215.32d2a350@imammedo.users.ipa.redhat.com>
 <5f25576c-598f-4fd7-8238-61edcff2c411@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 16 Jan 2025 19:05:46 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 28/11/23 17:42, Igor Mammedov wrote:
> > On Mon, 18 Sep 2023 18:02:39 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >  =20
> >> While create_vcpu_thread() creates a vCPU thread, its counterpart
> >> is cpu_remove_sync(), which join and destroy the thread.
> >>
> >> create_vcpu_thread() is called in qemu_init_vcpu(), itself called
> >> in cpu_common_realizefn(). Since we don't have qemu_deinit_vcpu()
> >> helper (we probably don't need any), simply destroy the thread in
> >> cpu_common_unrealizefn().
> >>
> >> Note: only the PPC and X86 targets were calling cpu_remove_sync(),
> >> meaning all other targets were leaking the thread when the vCPU
> >> was unrealized (mostly when vCPU are hot-unplugged).
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   hw/core/cpu-common.c  | 3 +++
> >>   target/i386/cpu.c     | 1 -
> >>   target/ppc/cpu_init.c | 2 --
> >>   3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> >> index a3b8de7054..e5841c59df 100644
> >> --- a/hw/core/cpu-common.c
> >> +++ b/hw/core/cpu-common.c
> >> @@ -221,6 +221,9 @@ static void cpu_common_unrealizefn(DeviceState *de=
v)
> >>  =20
> >>       /* NOTE: latest generic point before the cpu is fully unrealized=
 */
> >>       cpu_exec_unrealizefn(cpu);
> >> +
> >> +    /* Destroy vCPU thread */
> >> +    cpu_remove_sync(cpu);
> >>   }
> >>  =20
> >>   static void cpu_common_initfn(Object *obj)
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index cb41d30aab..d79797d963 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -7470,7 +7470,6 @@ static void x86_cpu_unrealizefn(DeviceState *dev)
> >>       X86CPUClass *xcc =3D X86_CPU_GET_CLASS(dev);
> >>  =20
> >>   #ifndef CONFIG_USER_ONLY
> >> -    cpu_remove_sync(CPU(dev));
> >>       qemu_unregister_reset(x86_cpu_machine_reset_cb, dev);
> >>   #endif =20
> >=20
> > missing  followup context:
> >      ...
> >      xcc->parent_unrealize(dev);
> >=20
> > Before the patch, vcpu thread is stopped and onnly then
> > clean up happens.
> >=20
> > After the patch we have cleanup while vcpu thread is still running.
> >=20
> > Even if it doesn't explode, such ordering still seems to be wrong. =20
>=20
> OK.

looking at all users, some do stop vcpu thread before tearing down vcpu obj=
ect
and interrupt controller, while some do it other way around or mix of both.

It's probably safe to stop vcpu thread wrt intc cleanup.
Can you check what would happen if there were a pending interrupt,
but then flowing would happen:
 1. destroying intc
 2. can vcpu thread just kicked out from KVM_RUN,
    trip over missing/invalid intc state while thread runs towards its exit=
 point?

If above can't crash then,
I'd prefer to stop vcpu at least before vcpu cleanup is run.
i.e. put cpu_remove_sync() as the very 1st call inside of cpu_common_unreal=
izefn()

> >> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> >> index e2c06c1f32..24d4e8fa7e 100644
> >> --- a/target/ppc/cpu_init.c
> >> +++ b/target/ppc/cpu_init.c
> >> @@ -6853,8 +6853,6 @@ static void ppc_cpu_unrealize(DeviceState *dev)
> >>  =20
> >>       pcc->parent_unrealize(dev);
> >>  =20
> >> -    cpu_remove_sync(CPU(cpu)); =20
> >=20
> > bug in current code? =20
>=20
> Plausibly. See:
>=20
> commit f1023d21e81b7bf523ddf2ac91a48117f20ef9d7
> Author: Greg Kurz <groug@kaod.org>
> Date:   Thu Oct 15 23:18:32 2020 +0200
>=20
>      spapr: Unrealize vCPUs with qdev_unrealize()
>=20
>      Since we introduced CPU hot-unplug in sPAPR, we don't unrealize the
>      vCPU objects explicitly. Instead, we let QOM handle that for us
>      under object_property_del_all() when the CPU core object is
>      finalized. The only thing we do is calling cpu_remove_sync() to
>      tear the vCPU thread down.
>=20
>      This happens to work but it is ugly because:
>      - we call qdev_realize() but the corresponding qdev_unrealize() is
>        buried deep in the QOM code
>      - we call cpu_remove_sync() to undo qemu_init_vcpu() called by
>        ppc_cpu_realize() in target/ppc/translate_init.c.inc
>      - the CPU init and teardown paths aren't really symmetrical
>=20
>      The latter didn't bite us so far but a future patch that greatly
>      simplifies the CPU core realize path needs it to avoid a crash
>      in QOM.
>=20
>      For all these reasons, have ppc_cpu_unrealize() to undo the changes
>      of ppc_cpu_realize() by calling cpu_remove_sync() at the right
>      place, and have the sPAPR CPU core code to call qdev_unrealize().
>=20
>      This requires to add a missing stub because translate_init.c.inc is
>      also compiled for user mode.
>=20
> >  =20
> >> -
> >>       destroy_ppc_opcodes(cpu);
> >>   }
> >>    =20
>=20


