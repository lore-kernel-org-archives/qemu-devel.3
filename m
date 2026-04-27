Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3EAFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSMe-000082-G6; Mon, 27 Apr 2026 16:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHSMd-00007X-HN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:15:31 -0400
Received: from p-west3-cluster5-host10-snip4-10.eps.apple.com ([57.103.72.103]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHSMY-0007GC-NL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:15:31 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id
 EDA68180009F; Mon, 27 Apr 2026 20:15:22 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRPEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAE5A1oCKgpGFDwFKQ5GBjMATx4vclgDXXpBBykCU3RHAE51L3ceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777320924; x=1779912924;
 bh=ytB/7hkn4QUdoq4tAakQ+OdBtuIiNHQGnrcAnwtfD1M=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=B1DrRBPUUNK5LeMwzjRFELPZgTc22TDWWH1sDcTva85dU6NdHkXKXVd2f0x/iRsJSebLw4OWWEedxmRhRtsp1btY5l9fq/uBnrq77otZLnnw6tmA7gNNxvIcWncrUUdbdvXVTf9nvOliogVd72RheHJeXAcf1h5A/cdBBu9n22KTyawqOZEqsYpTYTePCCyk/BtQYO+Xf02JdIJXk+mlvBu8WU/4JRs9ANquFsg423fyKK86o+XCxVWEscEFRPVsEcrKdr4KG1k+P+kIYjPWn7T5htYve/eKeGCIawqBNv65sq7Eqn4PdU7wkNhq0YKbPdJi8edadWkPTon8HvA8kQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id
 11E481800285; Mon, 27 Apr 2026 20:15:20 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9yGmWq--JsyZpPnOQ74i=j7JeeO0Xf6be7wWxJGbXLdg@mail.gmail.com>
Date: Mon, 27 Apr 2026 22:15:08 +0200
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A075A86-D6D9-4C97-BE31-C94D58F796FB@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
 <20260427184540.80415-1-lucaaamaral@gmail.com>
 <CAFEAcA9yGmWq--JsyZpPnOQ74i=j7JeeO0Xf6be7wWxJGbXLdg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: OIf6lxNyTLs23fnZBb9iJtBmXxtaQjoZ
X-Proofpoint-ORIG-GUID: OIf6lxNyTLs23fnZBb9iJtBmXxtaQjoZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxNSBTYWx0ZWRfXz9z7O3e9R8Q3
 Rxz3ML6iHrtVP/ZiOa4qhspVWfgSt3KqzXsmqyjK/d8qvK5YlK/OSYcUA5koQcRcpry9HuGTT5h
 Orf5pvSfenHOSiz30tshDS7mIELZUUHdVmHkn0ECWeOSDrvsa1D+Cr0MbZQxUOl/dcsncV2V5rg
 Mn0pXiFZ4xBJMeVfp5vY3CySRgGo+IUUNr4GBTBNJVq0t6vVYAJaFuOTXJ2USkfsU6k8/pHW3cB
 qpKee2yCeEPvwClznBAXaFN9cPZj0RdABZ2LkjkOP8tFSQZOGwRuymiltHLcmY8fd7DAay0Stfw
 mFYSo4Vgp9g/Pk71vUsPeCTP8h8jx902lJj4C9ZxnW94lDeSz+f4mMOZMWL3SM=
X-Authority-Info-Out: v=2.4 cv=brhBxUai c=1 sm=1 tr=0 ts=69efc3db
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=5c9yfxEVLTWfPgpAd_0A:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=57.103.72.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 27. Apr 2026, at 22:02, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Mon, 27 Apr 2026 at 19:45, Lucas Amaral <lucaaamaral@gmail.com> =
wrote:
>>=20
>> On 2026-04-27, Peter Maydell wrote:
>>> looking at this I share Mohamed's question about how much of the
>>> atomics/etc we really need. This is a thousand lines of code
>>> handling instructions that in a lot of cases the guest really
>>> ought not to be using on MMIO regions in the first place.
>>>=20
>>> If we have real examples of this being needed, that's one thing,
>>> but I'm not very enthusiastic about implementing 'doesn't actually
>>> have the atomic properties' instructions otherwise.
>>=20
>> Some empirical data first.  This series was motivated by an
>> observed workload: the original Venus development capture (Ubuntu
>> 24.04 ARM64 + vulkaninfo + vkmark) showed ~1.8M SIMD/FP load-pair
>> (vLDP) ISV=3D0 faults plus a few thousand other ISV=3D0 hits on
>> LDR/LDP/STP/STR variants =E2=80=94 guest-side accesses into =
virtio-gpu
>> blob memory that the renderer had been forced to map via the
>> subregion fallback (MAP_FIXED rejected as unaligned), trapping as
>> MMIO with a syndrome that can't encode pair semantics.  Without
>> this series, those 1.8M hits land on the assert(0) in HVF and the
>> guest is dead.
>=20
> Isn't the problem here that we're ending up in the MMIO
> path at all? That seems to me to be what you need to fix:
> taking 1.8M faults is a problem even if we can emulate them.
>=20
>> Patches 4/6 and 5/6 (exclusives, atomics, CAS, PAC) were included
>> for correctness against the ARM spec rather than to satisfy any
>> observed traffic =E2=80=94 same capture had zero hits on =
LDXR/STXR/STXP/
>> LDXP/LDADD/LDCLR/LDEOR/LDSET/LDSMAX/LDSMIN/LDUMAX/LDUMIN/SWP/CAS/
>> CASP.  The intent was to cover every load/store class the spec
>> permits with ISV=3D0, so that paths I haven't observed (different
>> device, different driver, different guest OS) don't fall through
>> to assert(0) either.
>>=20
>> I instrumented every trans_*() and the HVF data-abort dispatch,
>> then re-ran the same workload on top of the MAP_FIXED alignment
>> fix currently in flight:
>>=20
>>  =
https://patchew.org/QEMU/20260424000544.9617-1-lucaaamaral@gmail.com/
>>=20
>> Result: zero ISV=3D0 faults across the run (2.68M ISV=3D1 =
dispatches).
>> The alignment fix resolves at source: blob now lands in mapped RAM,
>> no MMIO trap, the ISV=3D0 path goes silent on this workload.
>=20
> ...so yes, that seems like the fix we want.
>=20
>> So the question is what role this series plays going forward.  My
>> intent was a defensive path covering the load/store classes that
>> can legitimately fault with ISV=3D0 per the ARM spec, so QEMU =
degrades
>> gracefully =E2=80=94 emulate when meaningful, inject a clean data =
abort when
>> not =E2=80=94 instead of the current assert(0) the moment a guest =
happens to
>> touch MMIO with an instruction the syndrome can't describe.  The
>> same wiring covers WHPX, which has the same syndrome limitation.
>=20
> We also fail in this use case for KVM, and have done for years. It
> doesn't generally seem to have been a problem particularly -- guests
> don't do this sort of "needs hypervisor to emulate" access
> typically, because it doesn't work under common hypervisors.
>=20
> (Though for KVM we don't assert, we feed the guest an
> external-abort: kvm-arm_handle_dabt_nisv().)
>=20
>> I want to make sure I'm addressing the right concern before
>> respinning.  Two readings of your and Mohamed's comments:
>>=20
>> (a) Scope: trim instruction classes with no observed use case.
>>    Smaller series, less spec coverage at decode level.
>=20
> This is mostly what I mean. If we don't need the emulation
> functionality, don't implement it. We're not going to get
> every load and store emulated anyway (for instance this patchset
> doesn't cover SVE or SME loads and stores, which are a whole
> huge class of memory accessing instructions).
>=20
> I would like any memory access emulation to come with an
> attached description of what the guest workload is that
> is triggering the requirement for it, so we can check that
> it makes sense to do so. (Mohamed mentions the Windows TPM
> device, though I am still not sure what exactly is going on
> there and whether emulating the access is the right approach
> to it.)
>=20
For the TPM:

TL;DR is that currently we have a workaround in QEMU that maps the page
to the guest for direct read but traps writes. As it=E2=80=99s an MMIO =
range,
it relies on FEAT_S2FWB to keep things consistent and misbehaves on CPUs
without it.

Emulating ldp is enough to get rid of that hack and instead map the TPM
as a regular device.

ldp/stp are also used by recent macOS guests to the GICv2m...

> thanks
> -- PMM
>=20


