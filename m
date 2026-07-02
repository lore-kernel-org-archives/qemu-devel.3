Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685A2C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGgt-0003kS-8o; Thu, 02 Jul 2026 08:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wfGgr-0003jy-Ct
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:38:49 -0400
Received: from p-east2-cluster4-host3-snip4-2.eps.apple.com ([57.103.78.133]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wfGgp-0008Vw-8i
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:38:49 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 3688018014E1; Thu, 02 Jul 2026 12:38:38 +0000 (UTC)
X-ICL-RepId: 019f22d6-a0a1-70ac-ab80-24d6ef9e9cff
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ITRMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wPO3EoBih3MxQ+CysORgZIAT4eVAIuBl0MSgBacVt0R3hKAF93HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1782995923; x=1785587923;
 bh=Ut/JLvsd42eKREb5T24DtBg7CjVhiI3+3Gvlq6kEPkY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Fuf2ND6I/pVWxFWP3Gn92mCHGDcBOkfO4vZAQnre60RSFloWoYrimKxQ6PcCK0A5RZlFkmoPWMF2sr2lVkCcX7xEzZf7fNW8ARu6t4K6hgHmX2JApmaBCvpWiaWonNo6FfS6893/XyxDEhOdHMiHQSYSuDJYCMtjmu+apomzlJfdqk26GcBXZXmOLNtWowvWfZZmedPp5TauOU/PQvY+m9ZJUoiAcfFJNQNHhFGe1hbFHBgf3anM7WmcxYzYfxQjmWlrjLzE+z0ZtKjbtm976mooJTGszGPvpuI3yGF552Ig5sz8kYEmSFrUlwXm9D59m/B+N+NVTMM1tWrg4FAo+Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 5BC8418005B4; Thu, 02 Jul 2026 12:38:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3893.100.7.1.1\))
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
Date: Thu, 2 Jul 2026 14:38:24 +0200
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
 <akY0Gpd/GHj3Pdun@example.com>
 <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3893.100.7.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX3BULtrD4gNcF
 gZiT2r5JqCm1Vb2jPvWQK3+GMK1Z8SW87nIpOEg86R116KFF+SbQIyPCkM2ytU/yZr8C1gbn+TA
 nekLkfW0n+04Ts8AnyzdTylxGIx4bDiASCUMFvW9QM2PodfOHynva4/1lFKeSPZFixGZiF8JwcD
 NW8d+P9BZUOSfAArYYPpLHsAXIvlABJHGDiDt7AZ6/HyZ4+tztRZnunf+t+83AY0emdp17WTVJ3
 jf6UQjftPjFX0lbTuzH9KbS7sSavtuTq15BIWpM7cJn1/J2u955PjQ2YkrMPi+GvKijg9Bgfs4Y
 9eJ/4pU2rN4q5rSdaxN
X-Proofpoint-ORIG-GUID: QIVq9sUMfUUpgZbOb-uMYKalLzzRA4bY
X-Proofpoint-GUID: QIVq9sUMfUUpgZbOb-uMYKalLzzRA4bY
Received-SPF: pass client-ip=57.103.78.133;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 2. Jul 2026, at 13:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> Il gio 2 lug 2026, 11:49 Magnus Kulke =
<magnuskulke@linux.microsoft.com> ha scritto:
> On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzini wrote:
>=20
> > What are the additional fields that aren't covered (i.e. cannot be =
copied
> > from hv_lapic_state to the struct and back) by the common APIC =
state?
> >
>=20
> that would be those:
>=20
>     uint32_t apic_version;
>     uint32_t apic_lvt_lint0;
>     uint32_t apic_lvt_lint1;
>     uint32_t apic_lvt_cmci;
>     uint32_t apic_error_status;
>     uint32_t apic_counter_value;
>     uint32_t apic_remote_read;
>=20
> Reference struct is this: hv_local_interrupt_controller_state
>=20
> =
https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h
>=20
> For anything that's new but part of the standard APIC you can place =
them in common APIC state, just making migration state part of a =
subsection.
>=20
> Notably we have to do this for lvt_lint0+1. We cannot use the =
respective
> fields in the common APIC state, because writing to those has a side =
effect
> in QEMU: If unmasked, it will trigger a chain of events,
>=20
> pic_irq_request() =3D> apic_accept_pic_intr() =3D> =
apic_deliver_pic_intr()
>=20
> For MSHV (and WHPX afaiu) we're currently not able to trigger legacy
> interrupts from userspace in this fashion.
>=20
> What is the issue? The interrupt won't be triggered either if you use =
a separate field, or if you use the normal one.

Hi,

For injecting LINT0, it=E2=80=99s possible on modern WHPX when using the =
hw irqchip
 - starting from Server 2022/Windows 11 only - not before that point.

How it=E2=80=99s done is though cancelling the vCPU execution, wait =
until the vm exits
as a result, set an interrupt window, run the vCPU again and then when =
it exits
Manually injecting an event=E2=80=A6

That=E2=80=99s unlike non-legacy interrupts where the request interrupts =
path actually
works on Hyper-V.

>=20
> For LINT1, can you not inject an NMI either?

The request interrupt path works at least to some extent on LINT1/NMIs =
unlike LINT0
but didn=E2=80=99t dig deeper to see if it has more issues=E2=80=A6

I=E2=80=99m convinced that an Hyper-V specific structure is the wrong =
idea for this though...

>=20
> Thanks,
>=20
> Paolo
>=20
> Hence we roundtrip
> lint0/lint1 in a dedicated mshv struct.
>=20
> best,
>=20
> magnus
>=20


