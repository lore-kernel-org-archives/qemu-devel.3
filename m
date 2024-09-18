Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B2CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squ1i-0006kT-S8; Wed, 18 Sep 2024 08:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squ1g-0006ZM-KV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1squ1d-0001W0-59
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726663395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLeU8ktCQnevvmd69YQfVSb78s3MnbSPwofGIbpcmzo=;
 b=EBfoTcP5tuayTmSrkAtm3oWZ9y0wz2uy8S+I8slOJJNiyRfezs/ahTMrcRnYAPEGAJr4kT
 tLntRz5pOIrZJd1Jyxfpx5ycNtnJTnCqv6pMrW06smVAmrasdoJz/UVccsZTaDhU6Mkq+S
 j585NJd+fLr/0rH4SG26oAc/xI+Cdkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-4XLHr5AlN2-2TtO8-y94uA-1; Wed, 18 Sep 2024 08:43:13 -0400
X-MC-Unique: 4XLHr5AlN2-2TtO8-y94uA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8cso44128975e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726663392; x=1727268192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLeU8ktCQnevvmd69YQfVSb78s3MnbSPwofGIbpcmzo=;
 b=VLZ3OJ5IWKJpgyDd4T8ExpqLskBYMfW2zo8aZeA9GKUahotneQQAus7YFX2/GtXcnQ
 fGdCGjVFzYjGIDa8v0iDnlc6vvUpcvqrBWdFhIoU7hMVKrusG+ND/oXOnsLiuKL1YLGY
 DLfuZwYnC/LHKb3kPQSnJS1MYic/Qz9hUEBPKfnJRLzVdz26Z2aJzMbxqWz3whWXeUkH
 MAq+l7mLvnBR0HlkQvfy1GMIVDrdIpUmmi3Jv9iwGGhPvkTBRMDuRzM46aeptKzQXpFz
 8sRgi4HQ4Nn4T6xwMstjhgGesp13ufX2p+Zrzph+P1acqZwNMVt72SKr6iw9stA/4a/c
 c2Ow==
X-Gm-Message-State: AOJu0Yw6P6Q7ySapKeVfk3r8T9Zdlyclqv6B7F6NansmeXyNpa670so9
 Th5KnnpTCk4QPoFp64SwbkrhhroVAnfxPDB/aYY/eKp/eIjus4SaLGGvrm+n8w96lGAxFAbDMo9
 jfMmO0LM7WH5RuQ+Zo2g7PGz4byKwk5sEMe5oMny4vAMfaFM+ta+w
X-Received: by 2002:a05:600c:21d1:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-42cde2fdb54mr161060435e9.2.1726663392215; 
 Wed, 18 Sep 2024 05:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjuHWCmUlwbdE/o622CtvUYXnp77CHMcfVo6Jkic+vpnqA22huDy6/iu/Iehyi7P9wqwYPog==
X-Received: by 2002:a05:600c:21d1:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-42cde2fdb54mr161060125e9.2.1726663391714; 
 Wed, 18 Sep 2024 05:43:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e70508027sm16030655e9.22.2024.09.18.05.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:43:11 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:43:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>
Subject: Re: [PATCH v2] i386/cpu: fixup number of addressable IDs for
 logical processors in the physical package
Message-ID: <20240918144309.5db630ff@imammedo.users.ipa.redhat.com>
In-Reply-To: <4967d160-bb34-498f-8f41-d451ac590482@bytedance.com>
References: <20240914110127.67690-1-xuchuangxclwt@bytedance.com>
 <20240918140242.2c360209@imammedo.users.ipa.redhat.com>
 <4967d160-bb34-498f-8f41-d451ac590482@bytedance.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 18 Sep 2024 20:22:26 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> Hi, Igor:
>=20
> On 2024/9/18 =E4=B8=8B=E5=8D=888:02, Igor Mammedov wrote:
> > On Sat, 14 Sep 2024 19:01:27 +0800
> > Chuang Xu <xuchuangxclwt@bytedance.com> wrote:
> > =20
> >> When QEMU is started with:
> >> -cpu host,migratable=3Don,host-cache-info=3Don,l3-cache=3Doff
> >> -smp 180,sockets=3D2,dies=3D1,cores=3D45,threads=3D2
> >>
> >> Execute "cpuid -1 -l 1 -r" in guest, we'll get:
> >> eax=3D0x000806f8 ebx=3D0x465a0800 ecx=3D0xfffaba1f edx=3D0x3fa9fbff
> >> CPUID.01H.EBX[23:16] is 90, while the expected value is 128.
> >>
> >> Execute "cpuid -1 -l 4 -r" in guest, we'll get:
> >> eax=3D0xfc004121 ebx=3D0x02c0003f ecx=3D0x0000003f edx=3D0x00000000
> >> CPUID.04H.EAX[31:26] is 63, which is as expected.
> >>
> >> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> >> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> >> integer too. Otherwise we may encounter unexpected results in guest.
> >>
> >> For example, when QEMU is started with CLI above and xtopology is disa=
bled,
> >> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26=
]) to
> >> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+=
63)=3D1"
> >> as the result, even though theads-per-core should actually be 2.
> >>
> >> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 inte=
ger
> >> to solve the unexpected result.
> >>
> >> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> >> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> >> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> >> ---
> >>   target/i386/cpu.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 4c2e6f3a71..24d60ead9e 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTo=
poInfo *topo_info,
> >>       return num_ids - 1;
> >>   }
> >>  =20
> >> +static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_inf=
o)
> >> +{
> >> +    uint32_t num_threads =3D 1 << apicid_pkg_offset(topo_info);
> >> +    return num_threads;
> >> +}
> >> +
> >>   static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
> >>   {
> >>       uint32_t num_cores =3D 1 << (apicid_pkg_offset(topo_info) -
> >> @@ -6417,7 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t in=
dex, uint32_t count,
> >>           }
> >>           *edx =3D env->features[FEAT_1_EDX];
> >>           if (threads_per_pkg > 1) {
> >> -            *ebx |=3D threads_per_pkg << 16;
> >> +            *ebx |=3D max_thread_number_in_package(&topo_info) << 16;=
 =20
> > why not use pow2ceil(threads_per_pkg) instead? =20
>=20
> I saw in the latest code that calculations of cpuids involving CPU topolo=
gy all use topo_info,
> so in order to maintain consistency in code style, I also used topo_info =
for calculation.

and we end up with a zoo of ways different topo stuff is calculated.

Given we already have threads_per_pkg calculated within the function,
is cleaner/more self-documenting to reuse it with pow2ceil() instead of
adding yet another helper with less than obvious '1 << apicid_pkg_offset(to=
po_info)' math.

> > =20
> >>               *edx |=3D CPUID_HT;
> >>           }
> >>           if (!cpu->enable_pmu)=20
>=20


