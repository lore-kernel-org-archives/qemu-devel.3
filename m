Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E3EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuff4-0001Au-46; Mon, 23 Feb 2026 18:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuff2-00018A-8Q
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:48:20 -0500
Received: from ci-2002b-snip4-11.eps.apple.com ([57.103.88.151]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufez-00067a-QU
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:48:19 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPS id
 07D8F180012A; Mon, 23 Feb 2026 23:48:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890497; x=1774482497;
 bh=pFQv9Rfm4AYozMTEgmSXV/riNdDHFakVBkK2Xow66sc=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=JWG6mAZT9RVLN/l7v2L9ut9LA6TWuGimYqNqW3E1gEK6FWSWdSLyOQ+OYRbShn78qPidAZMQA/YETluMK3ZPueAfDgawqXsWpMPFtme93yG2nwySThYK7o8ntXxlE26bTze+sj4qPLPIUuShGwTqzY6tDgBb2bSpG1Bpq11uxtWTkYus1aionxmeh8Cfw2aNh3n/mXCV7munfqiHS0auy/VcYoQ2a6xYPMC8IaAT6YRBmG8o72HGGNuEdnC/HGBBDHwCPna8+mg+kTcOL3JkZRe36SDPQ9XxqoKMtd8x2HhCycU+203uuddU9Liy0lFZOZhLXGvyed9XtYvUQefQsQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPSA id
 BB2901800105; Mon, 23 Feb 2026 23:48:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <9B620619-368F-49DA-BC81-295DD1A95F4C@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_106E73B2-3DBB-41EE-B298-B8A5291FA2A8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 00/28] whpx: x86 updates (2026-02)
Date: Tue, 24 Feb 2026 00:48:00 +0100
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
To: qemu-devel@nongnu.org
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNyBTYWx0ZWRfX4/UZ+PV2O1NP
 ZaB7do2u2o/PHak+UANsyH3t9M2o+PJUKPXLGauGTZYWJPjcLrOAvLZK+pprXoIohFOam9XNgUu
 xQzZxukZXitv9zeRYqU1uoD8+ihgOge2bd7UIAjrk+M+k3y9neJv22kNjAZINKodTNLCc+Pl+Vc
 SQBpjAbzmK40lT5Zj1Xj3mZXL6WSd8ClPFdlBlsW8O8ADJd7KMuEzSlnL9Jomhh9XVj55jsLuq0
 JFGh8YZ+rhJUTJwDCBqaytlKK9vl6duLb9/UcCukb81QNZCUt1wV3K7ZNQwbu1yLHr5jg8ayFqF
 akB7BEvkXnas9uhSdFZSTHg0DymIs1rAH461IDzidYMAtgaacjx/gGh6ZQQEUw=
X-Authority-Info-Out: v=2.4 cv=JKk2csKb c=1 sm=1 tr=0 ts=699ce73f
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=GaQpPoNlAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=AGh-_u6KpJHkCi6yoAAA:9
 a=QEXdDO2ut3YA:10 a=s_n1PURgIh485HEq:21 a=_W_S_7VecoQA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: 2eQsp3nUvJrj-_UsTnqmCLjAX-4UiwdV
X-Proofpoint-ORIG-GUID: 2eQsp3nUvJrj-_UsTnqmCLjAX-4UiwdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230207
X-JNJ: AAAAAAABxcbSQCOT24Z8wD4RazgZwjnMwyX9EqBw8+h91hCk6FLdhIk2yZ0s+HQ8ttfDfGl1FCY99oBA4yA7k3S3HjhfazOlRHjW2zQByiQD4lTrQtP/oTTLQi6PwH0f5+rRZJ+NbAAIiUcr+EYiS7NBj9om13RRwkR8YJRPbnxNen/o8mpeWsj4XmjwKTmkE8llRqZyFqGXgMt2Kr48Dw6w8ixE5tA199POkitrLpaicrDd7YUmz6XIJUPptpq8v2ItNL+NoLsMqy1BnfgUjikXcUg+dCbXWzqwlTH/jQvnrp/eqkfe8+wfhiMHi1yM5TZORewUBm3J/tFhkxDGqTL3DIE77Rf/A+dc3d/NGartK3hQkMOYJ7nyedqAOn3RU1sNbVK5Ns1kwe4/NO1zuVmjciTdjZPab2gQphub9i7PyARXS45VkRS0IZv+GFMsz0Greyx1Eq11JyqqDQ2xc5UF2eP+HgeT0MTdmNsSxAFLzk0JQGDDk/iC88GBAakV45YjSiM7M2VqIBDIISTqXORC8qqOzWyvEJgZoHscWBZZqQW8vHLrihOENUO3PvqByMq33L3wtZTOD9TCWTpuOE6zfoiYfTSNDFSPmVb05zDQIweSIm83F2fsTLE1rkwitYVryw6fWssa02RhHRx7IjkMvic28QvH8a0d+TNrgcJqEqZDPnngpRbOMPrCYQC9/nI9YDj4Zma4hG1c8MmzHLp6/T2T90sAMOQzbszZVtx6M+ogvD+wn2j/HWcsgbWsQacvquSWmH6V/SnKsIKIEqn+6AodebU5OFaLEulPgMKGnq0GVmsA4bnwKQCkwjz1KBhqARzxMbVpeNU=
Received-SPF: pass client-ip=57.103.88.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_106E73B2-3DBB-41EE-B298-B8A5291FA2A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 24. Feb 2026, at 00:39, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> It's a bit of a misnomer, but didn't rename this series to not cause =
more confusion... should
> probably have been named more like:
>=20
> whpx, target/i386/emulate: fixes for target/i386/emulate and move WHPX =
x86 to it + WHPX misc fixes
>=20
> Should have probably put a bit less faith in the state of =
target/i386/emulate from the get-go...
>=20
> In guest OSes compatibility: Win9x works now (but is not too =
stable...). I probably recommend using -M kernel-irqchip=3Doff
> for that case though as it apparently raises stability (a bit). Win9x =
didn't work with winhvemulate.
>=20
> 32-bit Haiku didn't work for me with or without this, with an invalid =
bit being there in the PTEs, but 64-bit Haiku works.
>=20
> On the bright side, this series should fix a lot on x86 HVF too=E2=80=A6=


Tests on x86 HVF would be nice to have.

> Some questions/notes for mshv:
> - On the model of the "whpx: i386: inject exceptions" commit, also =
have injection of raised exceptions for
> the MSHV backend for this all to work as expected.
> - I removed the reliance on the Hyper-V GVA translate call, which is a =
very slow one. If you want to add it
> back instead of using the QEMU target/i386/emulate page table walker, =
there probably ought to be a way to reduce
> the number of calls to that...
> - but emul_ops has a new mmu_gva_to_gpa call to enable this case to be =
implemented
> - la57 code is not exactly tested
>=20
> And in missing things that are probably a better fit for a separate =
patch (series) instead of this continously-growing one:
> - I don't handle privileges for the page walker in target/i386/emulate
> - and SMAP/SMEP for it, with complexity they might add to the picture
> - and the same applies to putting the reserved bit on error_code for =
erroneous PTEs
>=20
> Git: https://github.com/mediouni-m/qemu (tag for this revision: =
whpx-x86-202502-v5, and yeah the 2025 is a typo=E2=80=A6)

v6 instead of v5.

I should perhaps send revisions a bit less often=E2=80=A6

And the patchew link: =
https://patchew.org/QEMU/20260223233950.96076-1-mohamed@unpredictable.fr/

> This series contains:
>=20
> - target/i386/emulate fixes
> - move HVF x86_mmu code to common code
> - fixing debug support, which was broken since around: "gdbstub: move =
guest debug support check to ops"
> a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
> - switch over from winhvemulation to common x86 VM exit emulation code
> - remove some log lines
> - Remove WHPX CPUID traps as they're currently quite broken
> - Reworked implementation of the REP prefix for string instructions
> - page table walker rework, error propagation for target/i386/emulate,
> and injecting exceptions too
> - bump the exposed interrupt controller to an X2APIC
> - preemptively ignore interrupt requests to vector 0 instead of making =
the HV do it
>=20
> Changes added since v5:
> - Thorough propagation of memory error reads across =
target/i386/emulate
> - target/i386/emulate: warn on read/write from/to unmapped MMIO
> - for an unmapped GPA, continue and 0xff the register
>=20
> Changes added since v4:
> - MMU code rework
> - page table walker rework, (some) error propagation for =
target/i386/emulate,
> and injecting exceptions too...
> - all around cleanups around target/i386/emulate...
> - bump the exposed interrupt controller to an X2APIC
> - preemptively ignore interrupt requests to vector 0 instead of making =
the HV do it
>=20
> Changes added since v3:
> - Reworked implementation of the REP prefix for string instructions
> - Pick up flags conversion for WHPX x86 (used by target/i386/emulate)
> - get rid of the goto for the save/restore less state for WHPX patch
>=20
> Changes added since v2:
> - Take target/i386/emulate patches from Bernhard Beschow
> =
https://lore.kernel.org/qemu-devel/20260214131659.31378-1-shentey@gmail.co=
m/
> - Rework state levels to an enum
> - Skip some state loading on the registers save path too
>=20
> Changes added since v1:
> - move HVF x86_mmu code to common code
> - Use x86_mmu in WHPX MMIO exits
> - Remove WHPX CPUID traps as they're currently quite broken
> - Optimise MMIO vmexits by not restoring the full state
>=20
> Bernhard Beschow (3):
>  target/i386/emulate/x86_decode: Fix compiler warning
>  target/i386/hvf/x86_mmu: Fix compiler warning
>  target/i386/emulate/x86_decode: Actually use stream in
>    decode_instruction_stream()
>=20
> Mohamed Mediouni (25):
>  target/i386/emulate: rework string_rep emulation
>  target/i386: emulate, hvf: move x86_mmu to common code
>  whpx: i386: re-enable guest debug support
>  whpx: preparatory changes before switching over from winhvemulation
>  whpx: refactor whpx_destroy_vcpu to arch-specific function
>  whpx: move whpx_get_reg/whpx_set_reg to generic code
>  whpx: i386: switch over from winhvemulation to target/i386/emulate
>  whpx: i386: flags conversion for target/i386/emulate internal state
>  whpx: i386: remove remaining winhvemulation support code
>  whpx: i386: remove messages
>  whpx: i386: remove CPUID trapping
>  whpx: common, i386, arm: rework state levels
>  whpx: i386: saving/restoring less state for
>    WHPX_LEVEL_FAST_RUNTIME_STATE
>  target/i386: mshv, emulate: move the generic x86 helpers to
>    target/i386/emulate
>  target/i386: emulate: 5-level paging for the page table walker
>  target/i386: emulate, hvf, mshv: rework MMU code
>  hvf: i386: save/restore CR0/2/3
>  target/i386: emulate: get rid of write_val_to_mem() helper
>  target/i386: emulate: raise an exception on translation fault
>  target/i386: emulate: remove fetch_instruction helper too
>  target/i386: emulate: propagate memory errors on most reads/writes
>  whpx: i386: inject exceptions
>  whpx: i386: bump to x2apic
>  whpx: i386: ignore send_msi to interrupt vector 0
>  target/i386: emulate: propagate errors all the way and stop early
>=20
> accel/whpx/whpx-accel-ops.c                   |   8 +
> accel/whpx/whpx-common.c                      |  68 +-
> include/system/whpx-accel-ops.h               |  16 +-
> include/system/whpx-all.h                     |  11 +-
> include/system/whpx-common.h                  |   6 +-
> include/system/whpx-internal.h                |  16 -
> meson.build                                   |   3 +-
> target/arm/whpx/whpx-all.c                    |  43 +-
> target/i386/cpu.h                             |   2 +-
> target/i386/emulate/meson.build               |   9 +
> target/i386/emulate/x86.h                     |   1 +
> target/i386/emulate/x86_decode.c              |  12 +-
> target/i386/emulate/x86_emu.c                 | 356 +++++++----
> target/i386/emulate/x86_emu.h                 |  24 +-
> .../{mshv/x86.c =3D> emulate/x86_helpers.c}     |  13 +-
> target/i386/emulate/x86_mmu.c                 | 354 +++++++++++
> target/i386/{hvf =3D> emulate}/x86_mmu.h        |  31 +-
> target/i386/hvf/hvf.c                         |  40 +-
> target/i386/hvf/meson.build                   |   1 -
> target/i386/hvf/x86.c                         |  13 +-
> target/i386/hvf/x86_mmu.c                     | 277 --------
> target/i386/hvf/x86_task.c                    |  10 +-
> target/i386/mshv/meson.build                  |   2 +-
> target/i386/mshv/mshv-cpu.c                   |  71 ---
> target/i386/whpx/whpx-all.c                   | 591 ++++++++----------
> target/i386/whpx/whpx-apic.c                  |   5 +
> 26 files changed, 1031 insertions(+), 952 deletions(-)
> rename target/i386/{mshv/x86.c =3D> emulate/x86_helpers.c} (95%)
> create mode 100644 target/i386/emulate/x86_mmu.c
> rename target/i386/{hvf =3D> emulate}/x86_mmu.h (51%)
> delete mode 100644 target/i386/hvf/x86_mmu.c
>=20
> --=20
> 2.50.1 (Apple Git-155)
>=20


--Apple-Mail=_106E73B2-3DBB-41EE-B298-B8A5291FA2A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 24. Feb 2026, at 00:39, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>It's a bit of a misnomer, =
but didn't rename this series to not cause more confusion... =
should<br>probably have been named more like:<br><br>whpx, =
target/i386/emulate: fixes for target/i386/emulate and move WHPX x86 to =
it + WHPX misc fixes<br><br>Should have probably put a bit less faith in =
the state of target/i386/emulate from the get-go...<br><br>In guest OSes =
compatibility: Win9x works now (but is not too stable...). I probably =
recommend using -M kernel-irqchip=3Doff<br>for that case though as it =
apparently raises stability (a bit). Win9x didn't work with =
winhvemulate.<br><br>32-bit Haiku didn't work for me with or without =
this, with an invalid bit being there in the PTEs, but 64-bit Haiku =
works.<br><br>On the bright side, this series should fix a lot on x86 =
HVF too=E2=80=A6</div></div></blockquote><div><br></div>Tests on x86 HVF =
would be nice to have.</div><div><br><blockquote =
type=3D"cite"><div></div></blockquote><blockquote =
type=3D"cite"><div><div>Some questions/notes for mshv:<br>- On the model =
of the "whpx: i386: inject exceptions" commit, also have injection of =
raised exceptions for<br>the MSHV backend for this all to work as =
expected.<br>- I removed the reliance on the Hyper-V GVA translate call, =
which is a very slow one. If you want to add it<br>back instead of using =
the QEMU target/i386/emulate page table walker, there probably ought to =
be a way to reduce<br>the number of calls to that...<br>- but emul_ops =
has a new mmu_gva_to_gpa call to enable this case to be implemented<br>- =
la57 code is not exactly tested<br><br>And in missing things that are =
probably a better fit for a separate patch (series) instead of this =
continously-growing one:<br>- I don't handle privileges for the page =
walker in target/i386/emulate<br>- and SMAP/SMEP for it, with complexity =
they might add to the picture<br>- and the same applies to putting the =
reserved bit on error_code for erroneous PTEs<br><br>Git: =
https://github.com/mediouni-m/qemu (tag for this revision: =
whpx-x86-202502-v5, and yeah the 2025 is a =
typo=E2=80=A6)<br></div></div></blockquote><div><br></div>v6 instead of =
v5.</div><div><br></div><div>I should perhaps send revisions a bit less =
often=E2=80=A6</div><div><br></div><div>And the patchew link:&nbsp;<a =
href=3D"https://patchew.org/QEMU/20260223233950.96076-1-mohamed@unpredicta=
ble.fr/">https://patchew.org/QEMU/20260223233950.96076-1-mohamed@unpredict=
able.fr/</a></div><div><br><blockquote type=3D"cite"><div><div>This =
series contains:<br><br>- target/i386/emulate fixes<br>- move HVF =
x86_mmu code to common code<br>- fixing debug support, which was broken =
since around: "gdbstub: move guest debug support check to =
ops"<br>a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5<br>- switch over from =
winhvemulation to common x86 VM exit emulation code<br>- remove some log =
lines<br>- Remove WHPX CPUID traps as they're currently quite =
broken<br>- Reworked implementation of the REP prefix for string =
instructions<br>- page table walker rework, error propagation for =
target/i386/emulate,<br>and injecting exceptions too<br>- bump the =
exposed interrupt controller to an X2APIC<br>- preemptively ignore =
interrupt requests to vector 0 instead of making the HV do =
it<br><br>Changes added since v5:<br>- Thorough propagation of memory =
error reads across target/i386/emulate<br>- target/i386/emulate: warn on =
read/write from/to unmapped MMIO<br>- for an unmapped GPA, continue and =
0xff the register<br><br>Changes added since v4:<br>- MMU code =
rework<br>- page table walker rework, (some) error propagation for =
target/i386/emulate,<br>and injecting exceptions too...<br>- all around =
cleanups around target/i386/emulate...<br>- bump the exposed interrupt =
controller to an X2APIC<br>- preemptively ignore interrupt requests to =
vector 0 instead of making the HV do it<br><br>Changes added since =
v3:<br>- Reworked implementation of the REP prefix for string =
instructions<br>- Pick up flags conversion for WHPX x86 (used by =
target/i386/emulate)<br>- get rid of the goto for the save/restore less =
state for WHPX patch<br><br>Changes added since v2:<br>- Take =
target/i386/emulate patches from Bernhard =
Beschow<br>https://lore.kernel.org/qemu-devel/20260214131659.31378-1-shent=
ey@gmail.com/<br>- Rework state levels to an enum<br>- Skip some state =
loading on the registers save path too<br><br>Changes added since =
v1:<br>- move HVF x86_mmu code to common code<br>- Use x86_mmu in WHPX =
MMIO exits<br>- Remove WHPX CPUID traps as they're currently quite =
broken<br>- Optimise MMIO vmexits by not restoring the full =
state<br><br>Bernhard Beschow (3):<br> =
&nbsp;target/i386/emulate/x86_decode: Fix compiler warning<br> =
&nbsp;target/i386/hvf/x86_mmu: Fix compiler warning<br> =
&nbsp;target/i386/emulate/x86_decode: Actually use stream in<br> =
&nbsp;&nbsp;&nbsp;decode_instruction_stream()<br><br>Mohamed Mediouni =
(25):<br> &nbsp;target/i386/emulate: rework string_rep emulation<br> =
&nbsp;target/i386: emulate, hvf: move x86_mmu to common code<br> =
&nbsp;whpx: i386: re-enable guest debug support<br> &nbsp;whpx: =
preparatory changes before switching over from winhvemulation<br> =
&nbsp;whpx: refactor whpx_destroy_vcpu to arch-specific function<br> =
&nbsp;whpx: move whpx_get_reg/whpx_set_reg to generic code<br> =
&nbsp;whpx: i386: switch over from winhvemulation to =
target/i386/emulate<br> &nbsp;whpx: i386: flags conversion for =
target/i386/emulate internal state<br> &nbsp;whpx: i386: remove =
remaining winhvemulation support code<br> &nbsp;whpx: i386: remove =
messages<br> &nbsp;whpx: i386: remove CPUID trapping<br> &nbsp;whpx: =
common, i386, arm: rework state levels<br> &nbsp;whpx: i386: =
saving/restoring less state for<br> =
&nbsp;&nbsp;&nbsp;WHPX_LEVEL_FAST_RUNTIME_STATE<br> &nbsp;target/i386: =
mshv, emulate: move the generic x86 helpers to<br> =
&nbsp;&nbsp;&nbsp;target/i386/emulate<br> &nbsp;target/i386: emulate: =
5-level paging for the page table walker<br> &nbsp;target/i386: emulate, =
hvf, mshv: rework MMU code<br> &nbsp;hvf: i386: save/restore CR0/2/3<br> =
&nbsp;target/i386: emulate: get rid of write_val_to_mem() helper<br> =
&nbsp;target/i386: emulate: raise an exception on translation fault<br> =
&nbsp;target/i386: emulate: remove fetch_instruction helper too<br> =
&nbsp;target/i386: emulate: propagate memory errors on most =
reads/writes<br> &nbsp;whpx: i386: inject exceptions<br> &nbsp;whpx: =
i386: bump to x2apic<br> &nbsp;whpx: i386: ignore send_msi to interrupt =
vector 0<br> &nbsp;target/i386: emulate: propagate errors all the way =
and stop early<br><br> accel/whpx/whpx-accel-ops.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;8 +<br> =
accel/whpx/whpx-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;68 +-<br> =
include/system/whpx-accel-ops.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;16 +-<br> include/system/whpx-all.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;11 +-<br> =
include/system/whpx-common.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;6 +-<br> =
include/system/whpx-internal.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| &nbsp;16 -<br> meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;3 =
+-<br> target/arm/whpx/whpx-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;43 +-<br> =
target/i386/cpu.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br> =
target/i386/emulate/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;| &nbsp;&nbsp;9 +<br> target/i386/emulate/x86.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br> =
target/i386/emulate/x86_decode.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| &nbsp;12 +-<br> target/i386/emulate/x86_emu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| 356 +++++++----<br> =
target/i386/emulate/x86_emu.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| &nbsp;24 +-<br> .../{mshv/x86.c =3D&gt; =
emulate/x86_helpers.c} &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;13 +-<br> =
target/i386/emulate/x86_mmu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| 354 +++++++++++<br> target/i386/{hvf =3D&gt; =
emulate}/x86_mmu.h &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;31 =
+-<br> target/i386/hvf/hvf.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;40 +-<br> target/i386/hvf/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 -<br> =
target/i386/hvf/x86.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;13 +-<br> target/i386/hvf/x86_mmu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 277 --------<br> =
target/i386/hvf/x86_task.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;10 +-<br> =
target/i386/mshv/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 +-<br> =
target/i386/mshv/mshv-cpu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;71 ---<br> =
target/i386/whpx/whpx-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 591 ++++++++----------<br> =
target/i386/whpx/whpx-apic.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;5 +<br> 26 files changed, 1031 =
insertions(+), 952 deletions(-)<br> rename target/i386/{mshv/x86.c =3D&gt;=
 emulate/x86_helpers.c} (95%)<br> create mode 100644 =
target/i386/emulate/x86_mmu.c<br> rename target/i386/{hvf =3D&gt; =
emulate}/x86_mmu.h (51%)<br> delete mode 100644 =
target/i386/hvf/x86_mmu.c<br><br>-- <br>2.50.1 (Apple =
Git-155)<br><br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_106E73B2-3DBB-41EE-B298-B8A5291FA2A8--

