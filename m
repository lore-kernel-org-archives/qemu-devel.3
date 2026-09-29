Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D85C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBaCf-0002mm-1I; Tue, 29 Sep 2026 11:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hakan.gurbuz@tubitak.gov.tr>)
 id 1xBZnb-0006KA-Br; Tue, 29 Sep 2026 11:31:19 -0400
Received: from pgmail01.tubitak.gov.tr ([193.140.80.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hakan.gurbuz@tubitak.gov.tr>)
 id 1xBZnW-0007z1-VR; Tue, 29 Sep 2026 11:31:18 -0400
Received: from pgmail01.tubitak.gov.tr (localhost.localdomain [127.0.0.1])
 by pgmail01.tubitak.gov.tr (Proxmox) with ESMTP id 0EED714041F;
 Tue, 29 Sep 2026 18:30:58 +0300 (+03)
Received: from mta01.tubitak.gov.tr (mta01.tubitak.gov.tr [193.140.13.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by pgmail01.tubitak.gov.tr (Proxmox) with ESMTPS id 8B922141307;
 Tue, 29 Sep 2026 18:30:33 +0300 (+03)
Received: from localhost (localhost [127.0.0.1])
 by mta01.tubitak.gov.tr (Postfix) with ESMTP id 71D25182D39EA;
 Tue, 29 Sep 2026 18:30:33 +0300 (+03)
Received: from mta01.tubitak.gov.tr ([127.0.0.1])
 by localhost (mta01.tubitak.gov.tr [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1vVC5Iodbdr4; Tue, 29 Sep 2026 18:30:33 +0300 (+03)
Received: from localhost (localhost [127.0.0.1])
 by mta01.tubitak.gov.tr (Postfix) with ESMTP id 3A465182D39EC;
 Tue, 29 Sep 2026 18:30:33 +0300 (+03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mta01.tubitak.gov.tr 3A465182D39EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tubitak.gov.tr;
 s=3CB53094-0179-11EB-B19A-889BD1D29365; t=1790695833;
 bh=Yrb6StwvIVb8SHkZogabcXChCo0wQ6Kkqzxk70hirD8=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=MoDHNiK+zzEWYM5KhB6BCp7buGWQNf2vuOlYXi2ayrF1Vh2I/6KFW65yx+EtR32T6
 GVTA7a6umobbgqb7eBJDJMafviVbhjR3VmnIn8p72h7jJg1qnDLgzZNyPFufSZzlef
 E0ZiwbgbvpBwHwHSQR2XodAzXOz1uQGvY837P55GWbUzHQXe120KZHpTnzFtVBLF2V
 ETOLug52ObgP10u4c8Op/oAtoo88oUjjmx01SZdeStNIZga6Ov3rUAu1jtqwDmihLe
 H3EKntupu++Z0Zunk0lYa4o1qG16AKY3aR9XgX1LX6uaWswGtade0xV6YGTVlC8tEe
 +XVTaof7x+iRg==
X-Virus-Scanned: amavis at mta01.tubitak.gov.tr
Received: from mta01.tubitak.gov.tr ([127.0.0.1])
 by localhost (mta01.tubitak.gov.tr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MZ1ES8tZhbjR; Tue, 29 Sep 2026 18:30:33 +0300 (+03)
Received: from mail02.tubitak.gov.tr (mail02.tubitak.gov.tr [10.250.10.120])
 by mta01.tubitak.gov.tr (Postfix) with ESMTP id E5E1A182D39ED;
 Tue, 29 Sep 2026 18:30:32 +0300 (+03)
Date: Tue, 29 Sep 2026 18:30:32 +0300 (TRT)
From: Hakan =?utf-8?Q?G=C3=9CRB=C3=9CZ_=28BILGEM_BTE=29?=
 <hakan.gurbuz@tubitak.gov.tr>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <637886995.7258761.1790695832847.JavaMail.zimbra@tubitak.gov.tr>
Subject: [RFC] target/ppc: Book E debug facility (IAC/DAC/TRAP) is not
 emulated on e500/e6500
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_cc1529d0-d7b4-4d76-b10f-97d7609f29d7"
X-Zimbra-Message-Verification: hash=SHA256;
 guid=NDgzMjZjZDFhMmU0MjkwNWM3ZTNiMjllYzFhY2RkNjMyZmQwYTZhZjhmNGZlMjY0YTQ4NGQxMDQxY2Y4Njk5Nw==
Thread-Index: YdgWyNktTGa2cZOZ2zANYnsMeQ+Zow==
Thread-Topic: target/ppc: Book E debug facility (IAC/DAC/TRAP) is not emulated
 on e500/e6500
Received-SPF: pass client-ip=193.140.80.92;
 envelope-from=hakan.gurbuz@tubitak.gov.tr; helo=pgmail01.tubitak.gov.tr
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 29 Sep 2026 11:57:10 -0400
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

--=_cc1529d0-d7b4-4d76-b10f-97d7609f29d7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, 

QEMU's e500/e6500 models expose the Book E debug registers but do not 
emulate the facility behind them. I would like to check whether adding 
it would be welcome, and to agree on the scope before any code is 
written. 

What is missing today (checked against master) 
---------------------------------------------- 

* IAC1/IAC2 and DAC1/DAC2 are registered with a plain generic write 
callback. Values written are stored and never compared against 
anything, so no instruction-address-compare or data-address-compare 
event is ever generated. 

* IAC3-IAC8 and DBCR4/DBCR5 are not registered at all for e500mc and 
later. Writes are silently discarded, which hides the gap from guest 
software that probes the registers by writing and reading back. 

* DBCR0[TRAP] is not consulted. A trap instruction (or a conditional 
tw/td whose condition is met) always raises a Program interrupt, 
never a Debug interrupt, so the architecture's trap debug event does 
not exist. 

The delivery side is already present and correct: POWERPC_EXCP_DEBUG is 
routed through IVOR15 with DSRR0/DSRR1, and rfdi returns from it. Only 
the event sources are missing. DBCR0[ICMP] single-stepping is the one 
source that does work today. 

Why it matters 
-------------- 

Any guest that programs the hardware debug registers is affected: 
on-target debug agents in embedded operating systems, bare-metal test 
harnesses that place watchpoints on device registers, and firmware 
self-tests that verify the debug facility is present. Such guests either 
see no events at all, or - for IAC5-IAC8 - cannot even tell that the 
register is unimplemented, because the write appears to succeed and only 
the read-back fails. 

It is also an emulation-fidelity question on its own: the e6500 model 
advertises a CPU whose debug facility has eight instruction-address 
comparators, and software is entitled to use them. 

What an implementation would need to cover 
------------------------------------------ 

Registers: 

IAC1-IAC8 instruction address comparators (IAC5-IAC8 on e6500 only) 
DAC1, DAC2 data address comparators 
DBCR0 IDM master enable, per-comparator enables IAC1-IAC8, 
DAC1R/W, DAC2R/W, TRAP, ICMP, FT 
DBCR1 IAC1-IAC4 user/supervisor (US) and address-space (ER) 
filters, range modes 
DBCR2 DAC1/DAC2 US/ER filters, DAC12M range mode, data value 
compare control 
DBCR4/DBCR5 e500mc and later; DBCR5 carries the IAC5-IAC8 filters 
DBSR status bits per event, write-1-to-clear 

Semantics: 

* An event is generated only when DBCR0[IDM] and MSR[DE] are both set. 
* US filters on MSR[PR]; ER filters on MSR[IS] for instruction events 
and MSR[DS] for data events. 
* An IAC event fires before the instruction at the comparator address 
executes; DSRR0 holds that instruction's address. 
* A DAC event is reported for the access direction enabled in DBCR0 
(DACnR for loads, DACnW for stores). DBCR2[DAC12M] selects exact 
compare, inclusive range (DAC1 <= EA < DAC2) or exclusive range. 
* On delivery the corresponding DBSR bit is set and the Debug 
interrupt is taken through IVOR15 using DSRR0/DSRR1. 
* With DBCR0[TRAP] set, a trap instruction whose condition is met 
produces a trap debug event (DBSR[TRAP] plus Debug interrupt) 
instead of a Program interrupt. 

Implementation approach 
----------------------- 

The comparators map onto the generic TCG debug machinery: each enabled 
IACn becomes a BP_CPU breakpoint and each enabled DACn a BP_CPU 
watchpoint, re-synchronised from one function whenever DBCR0/DBCR1/ 
DBCR2, IACn or DACn is written, at reset and after migration. The 
TCGCPUOps hooks debug_check_breakpoint, debug_check_watchpoint and 
debug_excp_handler then decide at hit time whether the event passes the 
enable and filter conditions, set the DBSR bits and raise the interrupt. 

That is the same shape as the existing x86 DRx handling and the Power 
ISA CIABR/DAWR handling in target/ppc, so TCG code generation, 
translation block invalidation and coexistence with gdb breakpoints come 
for free. Writes to the control and comparator registers have to end the 
translation block, because the breakpoint set has changed. 

Limitations I would propose for a first version 
----------------------------------------------- 

* Events ignored while MSR[DE] is clear; no imprecise path 
(DBSR[IDE], event recorded and delivered when DE is set again). 
* DBCR1 IAC12M/IAC34M range modes fall back to exact compare, logged 
with LOG_UNIMP. 
* Data value compare (DVC1/DVC2, DBCR2 DVC1M/DVC2M) not implemented, 
logged with LOG_UNIMP. 
* DBCR0[IRPT] and DBCR0[RET] events not implemented. 
* A DAC event delivered after the access completes, so DSRR0 points at 
the following instruction. This matches e500 behaviour but differs 
from a strictly before-the-access model. 

Are these acceptable, or would any of them need to be in the first 
version? 

A related defect 
---------------- 

DBSR is write-1-to-clear, and spr_write_clear() in target/ppc/translate.c 
computes "spr & -value" instead of "spr & ~value". Negation is not 
complement, so writing a single bit to clear it leaves that bit set and 
instead clears the zero bits below it. Without this fixed, a guest cannot 
acknowledge a debug event at all. It also affects the 40x DBSR and HID0 
on the 970, so it stands on its own regardless of this RFC. I am filing 
it separately on the issue tracker. 

What we exercised 
----------------- 

We built a prototype against v9.2.0-rc2 and ran it on -M ppce500 
-cpu e6500 with a four-core guest that programs the facility directly: 

* instruction breakpoints hit at the expected address, with the guest 
handler reading DSRR0 and the DBSR bits correctly; 
* counting mode (comparator enabled, handler does not halt) produced 
exact hit counts over a free-running workload; 
* data watchpoints on a kernel variable caught the storing 
instruction, with the register context showing the written address; 
* the trap debug event took the Debug interrupt rather than the 
Program interrupt; 
* ICMP single-step interacted correctly with re-arming a comparator. 

Boot time and the -d guest_errors output were unchanged from stock QEMU. 

I am sending this as an RFC rather than a patch so the scope and the 
limitations above can be settled first. Comments welcome. 

Thanks, 
[ http://www.tubitak.gov.tr/sorumlulukreddi ] 

--=_cc1529d0-d7b4-4d76-b10f-97d7609f29d7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><div>Hello,</div><div><br></div><div>QEMU's=
 e500/e6500 models expose the Book E debug registers but do not</div><div>e=
mulate the facility behind them. I would like to check whether adding</div>=
<div>it would be welcome, and to agree on the scope before any code is</div=
><div>written.</div><div><br></div><div>What is missing today (checked agai=
nst master)</div><div>----------------------------------------------</div><=
div><br></div><div>&nbsp; * IAC1/IAC2 and DAC1/DAC2 are registered with a p=
lain generic write</div><div>&nbsp; &nbsp; callback. Values written are sto=
red and never compared against</div><div>&nbsp; &nbsp; anything, so no inst=
ruction-address-compare or data-address-compare</div><div>&nbsp; &nbsp; eve=
nt is ever generated.</div><div><br></div><div>&nbsp; * IAC3-IAC8 and DBCR4=
/DBCR5 are not registered at all for e500mc and</div><div>&nbsp; &nbsp; lat=
er. Writes are silently discarded, which hides the gap from guest</div><div=
>&nbsp; &nbsp; software that probes the registers by writing and reading ba=
ck.</div><div><br></div><div>&nbsp; * DBCR0[TRAP] is not consulted. A trap =
instruction (or a conditional</div><div>&nbsp; &nbsp; tw/td whose condition=
 is met) always raises a Program interrupt,</div><div>&nbsp; &nbsp; never a=
 Debug interrupt, so the architecture's trap debug event does</div><div>&nb=
sp; &nbsp; not exist.</div><div><br></div><div>The delivery side is already=
 present and correct: POWERPC_EXCP_DEBUG is</div><div>routed through IVOR15=
 with DSRR0/DSRR1, and rfdi returns from it. Only</div><div>the event sourc=
es are missing. DBCR0[ICMP] single-stepping is the one</div><div>source tha=
t does work today.</div><div><br></div><div>Why it matters</div><div>------=
--------</div><div><br></div><div>Any guest that programs the hardware debu=
g registers is affected:</div><div>on-target debug agents in embedded opera=
ting systems, bare-metal test</div><div>harnesses that place watchpoints on=
 device registers, and firmware</div><div>self-tests that verify the debug =
facility is present. Such guests either</div><div>see no events at all, or =
- for IAC5-IAC8 - cannot even tell that the</div><div>register is unimpleme=
nted, because the write appears to succeed and only</div><div>the read-back=
 fails.</div><div><br></div><div>It is also an emulation-fidelity question =
on its own: the e6500 model</div><div>advertises a CPU whose debug facility=
 has eight instruction-address</div><div>comparators, and software is entit=
led to use them.</div><div><br></div><div>What an implementation would need=
 to cover</div><div>------------------------------------------</div><div><b=
r></div><div>Registers:</div><div><br></div><div>&nbsp; IAC1-IAC8&nbsp; &nb=
sp;instruction address comparators (IAC5-IAC8 on e6500 only)</div><div>&nbs=
p; DAC1, DAC2&nbsp; data address comparators</div><div>&nbsp; DBCR0&nbsp; &=
nbsp; &nbsp; &nbsp;IDM master enable, per-comparator enables IAC1-IAC8,</di=
v><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DAC1R/W, DAC2R/W, T=
RAP, ICMP, FT</div><div>&nbsp; DBCR1&nbsp; &nbsp; &nbsp; &nbsp;IAC1-IAC4 us=
er/supervisor (US) and address-space (ER)</div><div>&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; filters, range modes</div><div>&nbsp; DBCR2&nbsp;=
 &nbsp; &nbsp; &nbsp;DAC1/DAC2 US/ER filters, DAC12M range mode, data value=
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compare control=
</div><div>&nbsp; DBCR4/DBCR5 e500mc and later; DBCR5 carries the IAC5-IAC8=
 filters</div><div>&nbsp; DBSR&nbsp; &nbsp; &nbsp; &nbsp; status bits per e=
vent, write-1-to-clear</div><div><br></div><div>Semantics:</div><div><br></=
div><div>&nbsp; * An event is generated only when DBCR0[IDM] and MSR[DE] ar=
e both set.</div><div>&nbsp; * US filters on MSR[PR]; ER filters on MSR[IS]=
 for instruction events</div><div>&nbsp; &nbsp; and MSR[DS] for data events=
.</div><div>&nbsp; * An IAC event fires before the instruction at the compa=
rator address</div><div>&nbsp; &nbsp; executes; DSRR0 holds that instructio=
n's address.</div><div>&nbsp; * A DAC event is reported for the access dire=
ction enabled in DBCR0</div><div>&nbsp; &nbsp; (DACnR for loads, DACnW for =
stores). DBCR2[DAC12M] selects exact</div><div>&nbsp; &nbsp; compare, inclu=
sive range (DAC1 &lt;=3D EA &lt; DAC2) or exclusive range.</div><div>&nbsp;=
 * On delivery the corresponding DBSR bit is set and the Debug</div><div>&n=
bsp; &nbsp; interrupt is taken through IVOR15 using DSRR0/DSRR1.</div><div>=
&nbsp; * With DBCR0[TRAP] set, a trap instruction whose condition is met</d=
iv><div>&nbsp; &nbsp; produces a trap debug event (DBSR[TRAP] plus Debug in=
terrupt)</div><div>&nbsp; &nbsp; instead of a Program interrupt.</div><div>=
<br></div><div>Implementation approach</div><div>-----------------------</d=
iv><div><br></div><div>The comparators map onto the generic TCG debug machi=
nery: each enabled</div><div>IACn becomes a BP_CPU breakpoint and each enab=
led DACn a BP_CPU</div><div>watchpoint, re-synchronised from one function w=
henever DBCR0/DBCR1/</div><div>DBCR2, IACn or DACn is written, at reset and=
 after migration. The</div><div>TCGCPUOps hooks debug_check_breakpoint, deb=
ug_check_watchpoint and</div><div>debug_excp_handler then decide at hit tim=
e whether the event passes the</div><div>enable and filter conditions, set =
the DBSR bits and raise the interrupt.</div><div><br></div><div>That is the=
 same shape as the existing x86 DRx handling and the Power</div><div>ISA CI=
ABR/DAWR handling in target/ppc, so TCG code generation,</div><div>translat=
ion block invalidation and coexistence with gdb breakpoints come</div><div>=
for free. Writes to the control and comparator registers have to end the</d=
iv><div>translation block, because the breakpoint set has changed.</div><di=
v><br></div><div>Limitations I would propose for a first version</div><div>=
-----------------------------------------------</div><div><br></div><div>&n=
bsp; * Events ignored while MSR[DE] is clear; no imprecise path</div><div>&=
nbsp; &nbsp; (DBSR[IDE], event recorded and delivered when DE is set again)=
.</div><div>&nbsp; * DBCR1 IAC12M/IAC34M range modes fall back to exact com=
pare, logged</div><div>&nbsp; &nbsp; with LOG_UNIMP.</div><div>&nbsp; * Dat=
a value compare (DVC1/DVC2, DBCR2 DVC1M/DVC2M) not implemented,</div><div>&=
nbsp; &nbsp; logged with LOG_UNIMP.</div><div>&nbsp; * DBCR0[IRPT] and DBCR=
0[RET] events not implemented.</div><div>&nbsp; * A DAC event delivered aft=
er the access completes, so DSRR0 points at</div><div>&nbsp; &nbsp; the fol=
lowing instruction. This matches e500 behaviour but differs</div><div>&nbsp=
; &nbsp; from a strictly before-the-access model.</div><div><br></div><div>=
Are these acceptable, or would any of them need to be in the first</div><di=
v>version?</div><div><br></div><div>A related defect</div><div>------------=
----</div><div><br></div><div>DBSR is write-1-to-clear, and spr_write_clear=
() in target/ppc/translate.c</div><div>computes "spr &amp; -value" instead =
of "spr &amp; ~value". Negation is not</div><div>complement, so writing a s=
ingle bit to clear it leaves that bit set and</div><div>instead clears the =
zero bits below it. Without this fixed, a guest cannot</div><div>acknowledg=
e a debug event at all. It also affects the 40x DBSR and HID0</div><div>on =
the 970, so it stands on its own regardless of this RFC. I am filing</div><=
div>it separately on the issue tracker.</div><div><br></div><div>What we ex=
ercised</div><div>-----------------</div><div><br></div><div>We built a pro=
totype against v9.2.0-rc2 and ran it on -M ppce500</div><div>-cpu e6500 wit=
h a four-core guest that programs the facility directly:</div><div><br></di=
v><div>&nbsp; * instruction breakpoints hit at the expected address, with t=
he guest</div><div>&nbsp; &nbsp; handler reading DSRR0 and the DBSR bits co=
rrectly;</div><div>&nbsp; * counting mode (comparator enabled, handler does=
 not halt) produced</div><div>&nbsp; &nbsp; exact hit counts over a free-ru=
nning workload;</div><div>&nbsp; * data watchpoints on a kernel variable ca=
ught the storing</div><div>&nbsp; &nbsp; instruction, with the register con=
text showing the written address;</div><div>&nbsp; * the trap debug event t=
ook the Debug interrupt rather than the</div><div>&nbsp; &nbsp; Program int=
errupt;</div><div>&nbsp; * ICMP single-step interacted correctly with re-ar=
ming a comparator.</div><div><br></div><div>Boot time and the -d guest_erro=
rs output were unchanged from stock QEMU.</div><div><br></div><div>I am sen=
ding this as an RFC rather than a patch so the scope and the</div><div>limi=
tations above can be settled first. Comments welcome.</div><div><br></div><=
div>Thanks,</div></div><div data-marker=3D"__SIG_PRE__"><div style=3D"backg=
round-color:rgb( 253 , 253 , 253 );font-family:'tahoma' , 'geneva' , sans-s=
erif;font-size:9px;color:rgb( 64 , 64 , 64 )"><span class=3D"Object" id=3D"=
OBJ_PREFIX_DWT730_com_zimbra_url" style=3D"color:rgb( 51 , 102 , 153 )"><sp=
an class=3D"Object" id=3D"OBJ_PREFIX_DWT771_com_zimbra_url"><span class=3D"=
Object" id=3D"OBJ_PREFIX_DWT87_com_zimbra_url"><span class=3D"Object" id=3D=
"OBJ_PREFIX_DWT92_com_zimbra_url"><a href=3D"http://www.tubitak.gov.tr/soru=
mlulukreddi" rel=3D"nofollow%20noopener%20noreferrer nofollow noopener nore=
ferrer nofollow noopener noreferrer nofollow noopener noreferrer nofollow n=
oopener noreferrer nofollow noopener noreferrer nofollow noopener noreferre=
r nofollow noopener noreferrer nofollow noopener noreferrer nofollow noopen=
er noreferrer nofollow noopener noreferrer nofollow noopener noreferrer nof=
ollow noopener noreferrer nofollow noopener noreferrer" style=3D"color:rgb(=
 51 , 102 , 153 )" target=3D"_blank"></a></span></span></span></span></div>=
</div></div></body></html>
--=_cc1529d0-d7b4-4d76-b10f-97d7609f29d7--


