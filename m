Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77EDFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRJE-0000dE-1d; Mon, 27 Apr 2026 15:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHRJC-0000bh-KB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:07:54 -0400
Received: from p-west3-cluster4-host10-snip4-6.eps.apple.com ([57.103.74.247]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHRJA-0004NX-AH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:07:54 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPS id
 8DA5218001A3; Mon, 27 Apr 2026 19:07:46 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRPEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTApIAygGKANJFEEFXANGBkYATB5UAFoAXQ85CisAW3NID04ELnceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777316868; x=1779908868;
 bh=/uk+gMG8ozpJQd/ealeMqKcr+cyrib5yYM/9yLGNeBE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=YqtLwNBT2bAWkOmQCjqGpTPwPlXhAD/7hD9Epn85PZqX32ZTqMt3yuDtSiAPzJ8aYtKNnhL2gM6GMSS5kLicJjycPnA2ZHVy8ILyXpG6V+LSOkNu4b6agPslUaJaO08LmvjXAt85ESrBQsP2YkJwtbbOezOTYqcHgpkgjVvOn2cn/hgZwhiQGBlQ6JQ1uTzshFVg1l04zQCF+Z9D9WQYuXMndT9jamxMLXrV8UOxI3w6htT5SrMakX5wtBcMfBlee1n0+HNaqdzWdR/cQIeZFDclhtlHFgAGNaATdfFTOkXW4oAvMDQ7KGUTkzxhIxMLVIrKARvuoprmBIUzQEVfjA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPSA id
 8B484180019D; Mon, 27 Apr 2026 19:07:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260427184540.80415-1-lucaaamaral@gmail.com>
Date: Mon, 27 Apr 2026 21:07:31 +0200
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <300E1C19-9614-4694-9712-6A9F70A8667C@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <CAFEAcA-8BeBte6CxH._5F5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
 <20260427184540.80415-1-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: Y2Ls35Y_2Dw3ZJxCO0iALkN-9arUD9ZF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIwNCBTYWx0ZWRfX0kgev/FO6Yy9
 9NOjJ/eAf6lbdr8WR3i9hAzKp1Ced5i3DThXHznupLcV60lkt6IeoPXASr2EqXAwf/ObXuzXLMK
 CHXkQS8nxi0VHnZqOhlLn/mnMYou0Qkb9d1pr4XKe19j1WcCYBmBphr6eR1SgD0bbe8al3w6tep
 uCQzD7k7CVRk3mcZ29iwWy/4fNMJBUnTp/MoJXcsGg7pJj1xD07bvtwMRZaML1A9q+YCInDMjZh
 f/RA2k/Y41WH08t4SvGPiHN+3rLAjP4xDzFsufTRR+EH63GS3YuvNPZCbPV/DdGQON4zANNKU/E
 QgV9Mou/N+IxcRYodb0BMvy8mK+vm6yYW7BEB0j7GuLfnrqdaz0DHvn3w4FhOI=
X-Proofpoint-GUID: Y2Ls35Y_2Dw3ZJxCO0iALkN-9arUD9ZF
X-Authority-Info-Out: v=2.4 cv=LYMxKzfi c=1 sm=1 tr=0 ts=69efb402
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8
 a=i29ttfuYZYl03s6muUIA:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
Received-SPF: pass client-ip=57.103.74.247;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



> On 27. Apr 2026, at 20:45, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> On 2026-04-27, Peter Maydell wrote:
>> looking at this I share Mohamed's question about how much of the
>> atomics/etc we really need. This is a thousand lines of code
>> handling instructions that in a lot of cases the guest really
>> ought not to be using on MMIO regions in the first place.
>>=20
>> If we have real examples of this being needed, that's one thing,
>> but I'm not very enthusiastic about implementing 'doesn't actually
>> have the atomic properties' instructions otherwise.
>=20
> Some empirical data first.  This series was motivated by an
> observed workload: the original Venus development capture (Ubuntu
> 24.04 ARM64 + vulkaninfo + vkmark) showed ~1.8M SIMD/FP load-pair
> (vLDP) ISV=3D0 faults plus a few thousand other ISV=3D0 hits on
> LDR/LDP/STP/STR variants =E2=80=94 guest-side accesses into virtio-gpu
> blob memory that the renderer had been forced to map via the
> subregion fallback (MAP_FIXED rejected as unaligned), trapping as
> MMIO with a syndrome that can't encode pair semantics.  Without
> this series, those 1.8M hits land on the assert(0) in HVF and the
> guest is dead.
>=20
> Patches 4/6 and 5/6 (exclusives, atomics, CAS, PAC) were included
> for correctness against the ARM spec rather than to satisfy any
> observed traffic =E2=80=94 same capture had zero hits on =
LDXR/STXR/STXP/
> LDXP/LDADD/LDCLR/LDEOR/LDSET/LDSMAX/LDSMIN/LDUMAX/LDUMIN/SWP/CAS/
> CASP.  The intent was to cover every load/store class the spec
> permits with ISV=3D0, so that paths I haven't observed (different
> device, different driver, different guest OS) don't fall through
> to assert(0) either.
>=20
> I instrumented every trans_*() and the HVF data-abort dispatch,
> then re-ran the same workload on top of the MAP_FIXED alignment
> fix currently in flight:
>=20
>  https://patchew.org/QEMU/20260424000544.9617-1-lucaaamaral@gmail.com/
>=20
> Result: zero ISV=3D0 faults across the run (2.68M ISV=3D1 dispatches).
> The alignment fix resolves at source: blob now lands in mapped RAM,
> no MMIO trap, the ISV=3D0 path goes silent on this workload.
Hello,

That=E2=80=99s very nice! And addresses the issue at the root cause.

You probably saw the performance boost from not trapping anywhere
near as much too.
>=20
> So the question is what role this series plays going forward.  My
> intent was a defensive path covering the load/store classes that
> can legitimately fault with ISV=3D0 per the ARM spec, so QEMU degrades
> gracefully =E2=80=94 emulate when meaningful, inject a clean data =
abort when
> not =E2=80=94 instead of the current assert(0) the moment a guest =
happens to
> touch MMIO with an instruction the syndrome can't describe.  The
> same wiring covers WHPX, which has the same syndrome limitation.
>=20
> I want to make sure I'm addressing the right concern before
> respinning.  Two readings of your and Mohamed's comments:
>=20
> (a) Scope: trim instruction classes with no observed use case.
>    Smaller series, less spec coverage at decode level.

I think (a), with adding emulation for problematic cases
only as observed, as this is MMIO memory after all.

Thinking like the TPM device on Windows and cases like that,=20
but without trying to cover anything a guest might do.

Although (b) is intriguing it might encourage guests to rely _more_
on isv !=3D 0 accesses which I think is preferable to avoid.

Any comments from anybody else? Because we=E2=80=99d have this wired to =
KVM too
I think, as it already showed up for the Windows TPM device.

>=20
> (b) Correctness: keep full spec coverage at decode, but per-class
>    handlers do what's actually correct: emulate where we can
>    preserve semantics, inject a fault where we can't.  Atomics
>    (LDADD/SWP) and exclusives' store half (STXR/STXP) go to the
>    fault path =E2=80=94 we can't honor RMW atomicity, since the =
read=E2=86=92write
>    window can be observed by other vCPUs if BQL doesn't cover it
>    continuously, and STXR claiming success without an exclusive
>    monitor lies to the guest.  Plain loads (LDXR by itself) could
>    legitimately emulate since they make no atomicity claim.
>=20
> If it's (a), I'd respin trimming patches 4/6 and 5/6 entirely,
> keeping framework + immediate + pair.
>=20
> If it's (b), I'd respin replacing the atomic/exclusive/CAS/PAC
> trans_*() bodies with `return false` (UNHANDLED =E2=86=92 inject data
> abort).
>=20
> Either way the existing wiring in hvf.c already error_report()s on
> every UNHANDLED before injecting, so operator visibility is
> covered.  Happy to downgrade that to warn_report_once() so a guest
> spinning on an unsupported insn doesn't flood the host log =E2=80=94 =
that
> addresses Mohamed's earlier "warn somewhere" suggestion in a place
> where it actually fires.
>=20
> If it's both, the (b) shape covers both =E2=80=94 explicit fault on =
the
> classes you don't want emulated, framework still in place to handle
> the legitimate cases without an assert.
>=20
> Could you and Mohamed confirm which reading is correct?  Happy to
> respin either direction once I know.
>=20
> Thanks,
> Lucas
>=20


