Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0AC105F7B4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w133U-0002eV-Q5; Fri, 13 Mar 2026 09:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w133T-0002eD-8I
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 09:59:55 -0400
Received: from p-west3-cluster1-host1-snip4-3.eps.apple.com ([57.103.73.134]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w133R-0004Gk-5H
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 09:59:55 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPS id
 CCC361800E28; Fri, 13 Mar 2026 13:59:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773410391; x=1776002391;
 bh=DHZFEJBviYqWw4jkkZ1Y72fV6fgSDFNyfm/jDvEMzUY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=cKcQELfPnFyADHjbD5fcOMk9h0hSDp3Tenner9uDcva+Mq3Fs26Hq4AQ8jXOA3QBmmVSWeZcCPz/7wj/qUjRHIuEdXk6G5g7JVouiVWfLDJlrDSBM9kQeDG16Z5c+HSWa94/ZehHteJlC9KH+mbM7MgRKidp3ofj6Ugbc+SFEDnaAdEDCuIyZbpNbo5avpjYgeEc7aV8F4/rGnFdFVorVhx4BymD28Ul3kpNK8/01yQnKK/gDG/NV8TjGXtBjGIzInhfYmVcQz2BSKZNJHfYe+2NPRRueVvOKMWQ9EtIb8o91eDTMM9s/DFPFZtepxRbAWk38KxQ5djwo8U/IWoQkQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-5 (Postfix) with ESMTPSA id
 E3EEB1800E2F; Fri, 13 Mar 2026 13:59:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA98aTmU0cKSbddQnLFwrmifNfXYaDeNsdvJR9XuB--6ew@mail.gmail.com>
Date: Fri, 13 Mar 2026 14:59:35 +0100
Cc: Alyssa Ross <hi@alyssa.is>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>, Miguel Luis <miguel.luis@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03B77364-61CE-4709-BDAE-20A0F8E49972@unpredictable.fr>
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
 <87fr64vtms.fsf@alyssa.is>
 <CAFEAcA98aTmU0cKSbddQnLFwrmifNfXYaDeNsdvJR9XuB--6ew@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMSBTYWx0ZWRfX9U9/VwciLL1N
 /A6cgiuOsi2GIFOrjZmrXS1u14t2frHrhceNcAR/QLe1ILNPEUOPyfq2r7jhxx/ofo4Gos/ahPG
 2RXUO4QEr9bDhz64Z08dSLY1lxS2SrYfuiHclSbxov3uQQzCghS7SDRk4l7VRRJBw9lp06RNboS
 YcwW0DfNE48njnTaH/MDnkGzsYn8P/ti6wF2RC1AqZHzQj6KX6Shb6qTttY6mhbNhlMEqiNYIRp
 ztqqH9ssdBPsXybTyC6bYz/hCbJYzOc0VLQ6NcT17bsoEEZ2EOCL676wBkTFMJjGguDwtEHQwle
 kdeHhR7VyOsYoT9B4FH1Oydy9+QwNOm4k0YlxZuzuGxmORPUZOYZLWlk9Ry7O8=
X-Proofpoint-ORIG-GUID: GkPl7-w7ZnSYq9G5wbqAzd24QH5DZLzK
X-Authority-Info-Out: v=2.4 cv=b72/I9Gx c=1 sm=1 tr=0 ts=69b41856
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Y4FzxyyIIySzoEe9l7IA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GkPl7-w7ZnSYq9G5wbqAzd24QH5DZLzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030
 mlxlogscore=960
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603130111
X-JNJ: AAAAAAABLaURqRjtpxUGBkBX3DjTjdKf6MikbuFqW3iue15NZG4HW+y6UHOCJB4KMDKyBWqJjTztose/jVA07X0p+UOtOZ9gKqhvVz5rx3jrQYxVS4oaKTxmatu8EiFuHmha1sScJ0s0jk/g7L1kIRqscNVJTP03Lg5VLHxxX3t6Dnm/TP0KghCUhLNqj435OsBxuw3EwZ6/98e9MD8+uYJlzhHvS6Xk48n+HggTSUD0TDc6b5ruKsdAq3MUZhUjawWbNZjdPQ5b55dnABZfiKSTfpFKWjgUY2pw6dqM7edvlU9fOFurhGe29EuPc9RiAOQpsvcjjknbgGqr1t0MMOcXgye4ExmReBNMaY2EILtOGt5F4SVxFb+uxjthCCU7dGvYX9l4k2VPYflvQKcAWrBUs6PtUjME78S1uNcXvnOy2fvxvGoEWzyBBwhEgwBMt9la//X6ekgWYBdxQzsd05nXer210w4PqnYCMUnZlRmXxAGmtvSla+C7NVueoDnqPOLthIAhOdxZzdoRXLndgsq07lzkRmrmhZM8p/EfpyDcRjKd4de/GRQQffiHMuG6XHryLBssVc4vrd9p5ORnobi3IKzs+3SbuKV2GdTpOni/x0dOWEiex0D97SFuNTsfM8piMRmq23hqoUTCSs1KVNhkd1wRTngGsh66gfdASpaJNGOhFFzW22F/NBq5rb7BSM56z+S1rBJZkQ==
Received-SPF: pass client-ip=57.103.73.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 13. Mar 2026, at 13:33, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Fri, 13 Mar 2026 at 11:47, Alyssa Ross <hi@alyssa.is> wrote:
>>=20
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> Looking a bit closer at this, it's a bit awkward that we're
>>> looking at a machine property in generic target/arm code.
>>=20
>> Isn't SMP a machine property that we're looking at just above?
>=20
> It's one of the ones in the base MachineState that exist for
> all boards.
>=20
>>> There is no guarantee that the machine is "virt" or that every
>>> KVM-supporting machine has a "virtualization" property, and
>>> the target/ code isn't really supposed to do board-specific stuff.
>>=20
>> FWIW: there's another arm board with the same property, which I think
>> would have the same requirements.  That's why I chose to just check =
the
>> property rather than checking machine type =E2=80=94 the idea being =
to establish
>> the convention that machines /do/ have a virtualization property =
where
>> it makes sense.
>>=20
>>> The board-independent way to say "are we trying to enable EL2" is
>>> to look at the CPU property has_el2. But the CPU isn't created at
>>> this point, so it's too early to do that here.
>>=20
>> I spent a day or so trying to make something involving has_el2 work, =
but
>> ultimately couldn't get anywhere with it.
>>=20
>>> Similar things where the early accelerator code wants information
>>> from the board we have handled with a method in MachineClass,
>>> like get_physical_address_range. We could do that here, but
>>> maybe it's a bit over-engineered? IDK.
>>=20
>> I'll give it a go and see if I can make it work.
>>=20
>>> There are other cases also where the virt board will error
>>> out for "KVM and some config we could do with TCG":
>>> * KVM + EL2 + GICv2
>>> * KVM + EL2 + kernel-irqchip=3Doff
>>> * KVM + GICv2 but host hardware doesn't support GICv2 emulation
>>> * KVM + GICv3 but host hardware doesn't support GICv3 emulation
>>> * KVM + MTE but host hardware/kernel doesn't support MTE
>>>=20
>>> The first two are "always fails", but if we're going to have
>>> a mechanism for "figure out in kvm_arch_init what KVM features
>>> the board is going to want to enable" then it might be nice
>>> to also be able to use it for the last 3.
>>=20
>> I can try that.
>=20
> Thanks, that would be helpful. I don't really have any
> specific ideas about what kind of API might be best here.
>=20
> There are probably similar issues with the other accelerators,
> e.g. -accel hvf,tcg -machine virtualization=3Don
> also ought to fall back to TCG, and similarly with "picked
> a GIC version we can't handle with this accelerator=E2=80=9D.
Hello,

Something to note about that (with HVF and KVM) is that there=E2=80=99s
also kernel-irqchip=3Doff/on to take into mind. For example on a =
vGICv3-only
system you can still run GICv2 VMs with kernel-irqchip=3Doff on KVM.

And for HVF once the hardware irqchip is merged kernel-irqchip=3Doff
will remain there for (primarily) GICv2 usage.



