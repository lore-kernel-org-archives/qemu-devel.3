Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD55CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOnwX-00011k-Lo; Sun, 17 May 2026 22:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wOnwT-00011K-3i
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:42:53 -0400
Received: from pv-2002i-snip4-3.eps.apple.com ([57.103.64.134]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wOnwQ-00079E-5j
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:42:52 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id
 4DC75180011F
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 02:42:47 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhKAkMOUhxBCE4dXwJLVxQEFVoOXwpXHFMbXwxFAHIdWBsdDlgGEhZdRV4EVANTFVUSUAFWGVkwVBlQQ1QEX1BLGw5cFwNXHFZFXBhDCV0FVxwdHUFFWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQWgpRXloXXk1aAlZNBUoCWQRaBUBdVQtUDlMfRAFJAUAOWQJEFE0EC1IJUxUAHARYAitfEVpWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
 t=1779072168; x=1781664168; bh=WMOb7T49Eyo1q3+VLeXnJrVzy+t0/ewa+UxjmmvKG/o=;
 h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme;
 b=LT21kePrR1rNyL0iHFlGXa/eceVmh03WgSNEExz116WSEuEK0GjyYk5I+uURQ3COcCGUCl0/oVRnOk/bn2aOBVZoMpAe4psGjDT7bSo7WE1yi/YRMcVM+e5wkOd5vM84iWtiRiMwyvScunGyX+ZFVODuNLsMPiaTM1Cl+ubf0U6budNbxzPQ7VIO93fQ+zkm6nbER/t8VofWKT5ZmueGkltgvsMAX1CJhhyJakkcgwv80umtO2rXUxhpxCzTe/von8EfR7Qnjs6iF9ruHuCdc23sdoyIMA+lvBySxYQZRE+pdLV5rI7xylsrO0gGIa9CVLiqsSLK02yjniBjleK89g==
Received: from [192.168.1.3] (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id
 10E67180010C
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 02:42:45 +0000 (UTC)
Message-ID: <2143170d-8998-4812-9204-57febae9d755@mac.com>
Date: Mon, 18 May 2026 14:42:43 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
From: Michael Clark <michaeljclark@mac.com>
Subject: GLYPH: TLB miss handlers, virtualization, and modes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ovd8gq5wjYq6mTvu1v2hq9cJnAHzgB_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDAyNCBTYWx0ZWRfX/YiM0/vjxrvP
 NJ5ScTLmvuV+QU8dvXFzPlodbO6LqtwRVXBpN6QPHDcNJqmyH1r9M01hL8JWWRiXlZk3mbQfY6P
 ycg1l5eepZe2Cy7gMZhV6qWTu0/l1jMqv3QZUxfeZDKC33liEnwTWR1D532IJegR46r1gGXhlfO
 jiHjYrPgD5I7yaWft2ijqF5Sw0QUwhtt3Br1c3j1KEduSnLeeUZAg2CcUL1hAIGu88MOaYD9gaw
 eSpqr8Djd2LYLaaAC+zuJJFagnBhuqPKnXot4U/ReJ9DCg58tpDJ2IH2FGLFQbhGt2OWw0UpRpw
 Nqpz5Pg4tDwyV8m74yIDb4pTdxdDNbYygVKY/UxTk9ceC/OMjQ6Gha/CVcsyWE=
X-Authority-Info-Out: v=2.4 cv=d+74CBjE c=1 sm=1 tr=0 ts=6a0a7ca7
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=u0hES8UrWMkA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YJ9zdN9lAAAA:8 a=NEAV23lmAAAA:8 a=lDmWKlVU4ShJGlyLhkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eqbXquKEjoujS2g1hgVW:22
X-Proofpoint-ORIG-GUID: Ovd8gq5wjYq6mTvu1v2hq9cJnAHzgB_D
Received-SPF: pass client-ip=57.103.64.134; envelope-from=michaeljclark@mac.com;
 helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Hi Folks,

rather lengthy update on a high-level architecture exploration:

- https://metaparadigm.com/~mclark/glyph.pdf

I have reached an inflection point with nested virtualization and SLAT.
I believe I expose enough from an architectural perspective to support
SLAT in this version of the architecture, theoretically, as we have a
dominating machine capability for each virtual domain. it still needs
testing in a full system architectural simulator. I think this version
of the specification is worth a fine look, though. I just made a change
to domain context switching for nested traps, keeping in mind SLAT plus
TLB miss handlers for first level address translation.

# SLAT with virtual TLB miss handlers

most of the architectures exposing TLB miss handlers are somewhat dead.
few of them supported virtual TLB miss handlers with SLAT. I know QEMU
would like it, because when having the right page sizes it could make
soft-MMU super fast. interesting nuances. UltraSPARC exposes fixed TLB
entries in the architectural spec, obviously because when using SLAT
one can't call a TLB handler in a VM using virtual physical addresses.

planning to address the virtual physical address problem with hardware.
just added "per-domain" TLB miss handlers to this version of the spec.
if added to a virtual domain, one could use the register update event
to call the miss handler on the handler virtual physical addresses and
map it to a fixed entry in the TLB, but do so in hardware. in this
model, miss handlers would have TLB slots. but architecturally, not as
a micro-architectural detail, so unlike UltraSPARC, we won't expose
tables, just the miss handler address. i.e. hardware-managed TLB
software miss handler. hardware controls evictions, and if we need to
ensure the "virtual" miss handler is in the TLB, we will specify that a
miss handler on a domain with a dominating machine domain can access
virtual physical in its address space, as it will be performing SLAT.

# microcoded privilege levels using domain capability matrices

- 16 hardware domain slots default.
- address space reserved for up to 256 per core.
- 64 seems like it might be a sane choice in 12-15 years time.
- domains have MSI addresses on them.
- interrupt can context switch domains.

# hypervisor/firmware/OS config

- 4 sets of 4 privilege level domains
- 4 sets of 3 privilege level domains, plus hypervisor, enclave, iommu
- 6 sets of 2 privilege level domains, plus hypervisor, enclave, iommu
- 16 bare metal domains with all capabilities self-mapped

it is trap-routing. we mux 4-bits of "domain" through microcode SRAM.
they have been carefully sized with combinatorial complexity in mind.

# domains and capabilities versus privilege levels

trap routing for capabilities on virtual domains is an elegant model.
this work could trigger a tidal wave. the model is super simple and I
have been compressing on it for years, adopting elements from RISC-V
piecemeal, in a simplified form, while also adding some complexity back.
because we have to MUX through some SRAM for trap decisions. added a
domain stack to handle exception nesting and hiding 'dom' from 'sys'.

model misconfigurations. analysis of the rather simple capability model
presented is huge work. it is not like I have a department at a school.
it is a missing piece. the work extends Cambridge Xen. Cambridge CHERI
is fine grained memory-object capabilities for pointers. GLYPH is
domain capabilities and page coloring capabilities. the model is simple.

# meta-circular virtual memory

virtual TLB miss handlers aren't specified in detail but the idea is to
trap to the dominating machine default domain for a given domain and
have that domain invoke the first level TLB miss handlers within a
virtual physical address space, then run second-level translation on
them. there are a number of ways around "needs physical not virtual
physical" so that the handler itself is in the TLB. we could link
relocatable code in a hypervisor API and host them in M mode at known
physical addresses. needs a verifier. alternatively, we could cause TLB
miss traps on some "system TLB miss handler vector" addresses for the
virtual physical addresses and have magic add them to per domain fixed
TLB table entries a la UltraSPARC. I have physical self-map checking as
an option. this way, under certain circumstances, we can depend on
physical addresses being usable when virtual memory is enabled.

# QEMU soft-MMU

system-level TLB miss handlers with SLAT have the potential to make
emulators like QEMU be 5X to 10X faster in systems mode with domain or
system level TLB miss handlers. soft-MMU is super slow. this could also
help with development and testing of IOMMU/vIOMMU in emulators.

there is no full system architectural simulator for this work yet, but
the privileged architecture is quite settled, at least theoretically.
if you read the spec you can see the dimensional aligment. maybe:

“This maps onto VMX non-root operation with EPT/NPT second-level 
translation and VPID-tagged TLB behavior, but generalizes the refill 
path into an architecturally visible per-domain handler mechanism.”

Regards. Michael.

glyph current - https://metaparadigm.com/~mclark/glyph.pdf
glyph latest  - https://metaparadigm.com/~mclark/glyph-20260518.pdf
glyph repo    - https://github.com/larkmjc/glyph
x86 repo      - https://github.com/larkmjc/x86

