Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694ABC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 08:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugfpX-0000n1-CU; Tue, 29 Jul 2025 04:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugfpM-0000gn-U5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 04:36:54 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugfpJ-0005cx-Jw
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 04:36:52 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:110d:0:640:50bc:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B6797806FC;
 Tue, 29 Jul 2025 11:36:43 +0300 (MSK)
Received: from smtpclient.apple (unknown [2a02:6bf:8080:3d::1:22])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gaU4VU7Gx0U0-pmdkV3ns; Tue, 29 Jul 2025 11:36:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753778203;
 bh=RzL2yFcv5BCGc5jGGuH+zzevErupHr20NF8MkLKQmX4=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=fkaeBbA++DggBXdjg9vVFp3YC+hqSCPvwc3+0EzHf7+NPN76saqm76XbQA135LLjr
 0boSts7g1BD5GW9f2JWphLiQs7M5Rj/aHc8T2D+S9IgK3OphHwJYYSAH2nsm1xRqR9
 bxWeVSn5rn5x2APTGWvMTlT6QRq1SV3pBUeDNdvM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <106C9543-B7DB-4C2F-9096-A6FDB054F566@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C9F7D6B5-F254-45DB-8FCB-29F183B134CE"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Date: Tue, 29 Jul 2025 11:36:32 +0300
In-Reply-To: <256c721c-8846-4c5a-9535-0047d83264de@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
 <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
 <4985e648-6505-4321-8e3a-f987b9d03bde@intel.com> <aGeO2zCKep7StDA8@intel.com>
 <cf64058e-e5a2-4cf2-9851-92925553e72c@intel.com>
 <6C44AD09-0675-4277-93C2-DB3647EC54C2@yandex-team.ru>
 <aIei/i7+MHM2s3EZ@intel.com> <256c721c-8846-4c5a-9535-0047d83264de@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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


--Apple-Mail=_C9F7D6B5-F254-45DB-8FCB-29F183B134CE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Xiaoyao,
Sure, I can share how I reproduce this issue.=20
1. First I have modified hmp_info_registers
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 8eaf70d9c9..a4bb3d715b 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -102,7 +102,7 @@ void hmp_info_registers(Monitor *mon, const QDict =
*qdict)
     if (all_cpus) {
         CPU_FOREACH(cs) {
             monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-            cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+            cpu_dump_state(cs, NULL, CPU_DUMP_CODE);
         }
     } else {
         cs =3D vcpu >=3D 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
@@ -117,7 +117,7 @@ void hmp_info_registers(Monitor *mon, const QDict =
*qdict)
         }
=20
         monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+        cpu_dump_state(cs, NULL, CPU_DUMP_CODE);
     }
 }

2. Run this in cmd line:
# yes "info registers" | sudo ./qemu-system-x86_64 -accel kvm -monitor =
stdio -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don =
-blockdev "{'driver': 'file', 'filename': =
'/usr/share/OVMF/OVMF_CODE_4M.secboot.fd', 'node-name': 'ovmf-code', =
'read-only': true}" -blockdev "{'driver': 'file', 'filename': =
'/usr/share/OVMF/OVMF_VARS_4M.fd', 'node-name': 'ovmf-vars', =
'read-only': true}" -machine =
q35,smm=3Don,pflash0=3Dovmf-code,pflash1=3Dovmf-vars -m 2G -nodefaults


Assert should be reproduced within 10-15 seconds.
Not sure if it is important detail or not, however I run this qemu cmd =
inside qemu-based virual machine with enabled nested virtualization.


> On 29 Jul 2025, at 09:01, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> On 7/29/2025 12:19 AM, Zhao Liu wrote:
>> Hi Kirill,
>> On Mon, Jul 28, 2025 at 05:44:25PM +0300, Kirill Martynov wrote:
>>> Date: Mon, 28 Jul 2025 17:44:25 +0300
>>> From: Kirill Martynov <stdcalllevi@yandex-team.ru>
>>> Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state =
for
>>>  softmmu
>>> X-Mailer: Apple Mail (2.3826.600.51.1.1)
>>>=20
>>> Hi Xiaoyao!
>>> Hi Zhao!
>>>=20
>>> Xiaoyao,
>>> I tested the patch you provided, it works smoothly, easy to apply. =
Nothing to complain about.
>>>=20
>>> Zhao,
>>> I also tried your approach (extend cpu_address_space_init with =
AddressSpace parameter)
>>> First, it crashed in malloc with error:
>>> malloc(): unaligned tcache chunk detected
>>> After a little investigation I resized cpu->cpu_ases array, so it =
can fit second element and
>>> it started working. However, it looks like that function =
cpu_address_space_destroy needs
>>> some adjustment, because now it treats cpu->cpu_ases elements as =
dynamically allocated and
>>> destroys them with g_free() and passing &smram_address_space to =
cpu_address_space_init()
>>> in register_smram_listener() could lead to a problem since it is =
statically allocated in binary.
>> Thanks for testing. Yes, resize related details are needed, which =
were
>> I missed. These 2 patches essentially are all about adding SMM CPU
>> address space for KVM, like TCG did.
>>> So, my question now, what should I do?
>=20
> I just sent the formal version [*], could you please help verify if it =
resolve your problem?
>=20
> (If you can share the step how to reproduce the original problem, I =
can test myself)
>=20
> [*] =
https://lore.kernel.org/all/20250729054023.1668443-2-xiaoyao.li@intel.com/=

>=20
>> I still believe we should update cpu_address_space_init() and remove =
its
>> outdated assumptions about KVM first.
>> Moreover, users should have control over the added address spaces (I
>> think this is why num_ases should be set before
>> cpu_address_space_init()), and quietly updating num_ases is not a =
good
>> idea.
>> The question of whether to reuse smram_address_space for the CPU is
>> flexible. At least TCG doesn't reuse the same SMM space, and there's
>> already cpu_as_root (and cpu_as_mem!) in X86CPU.=20
>=20
> For i386 tcg, it allocates each CPU 3 MemoryRegions: cpu_as_root, =
cpu_as_mem and smram for SMM. While for i386 kvm, it allocates global =
MemoryRegions: smram_as_root and smram_as_mem and get smram from =
resolving "/machine/smram".
>=20
> yeah, this seems something we can cleanup if there were not specific =
reason for TCG to have different MemoryRegion each CPU. I don't have =
bandwidth to investigate it further.
>=20
>> There are also some
>> cleanup things worth considering, such as how to better handle the =
TCG
>> memory listener in cpu_address_space_init() - KVM also has the =
similar
>> logic. If possible, I can help you further refine this fix and clean =
up
>> other related stuff in one goes as well.
>> Thanks,
>> Zhao


--Apple-Mail=_C9F7D6B5-F254-45DB-8FCB-29F183B134CE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Hi =
Xiaoyao,<div>Sure, I can share how I reproduce this =
issue.&nbsp;</div><div>1. First I have =
modified&nbsp;hmp_info_registers</div><div><div>diff --git =
a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c</div><div>index =
8eaf70d9c9..a4bb3d715b 100644</div><div>--- =
a/monitor/hmp-cmds-target.c</div><div>+++ =
b/monitor/hmp-cmds-target.c</div><div>@@ -102,7 +102,7 @@ void =
hmp_info_registers(Monitor *mon, const QDict *qdict)</div><div>&nbsp; =
&nbsp; &nbsp;if (all_cpus) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;CPU_FOREACH(cs) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;monitor_printf(mon, "\nCPU#%d\n", =
cs-&gt;cpu_index);</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;cpu_dump_state(cs, NULL, CPU_DUMP_FPU);</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;cpu_dump_state(cs, NULL, =
CPU_DUMP_CODE);</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;}</div><div>&nbsp; &nbsp; &nbsp;} else {</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;cs =3D vcpu &gt;=3D 0 ? qemu_get_cpu(vcpu) : =
mon_get_cpu(mon);</div><div>@@ -117,7 +117,7 @@ void =
hmp_info_registers(Monitor *mon, const QDict *qdict)</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;}</div><div>&nbsp;</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;monitor_printf(mon, "\nCPU#%d\n", =
cs-&gt;cpu_index);</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;cpu_dump_state(cs, NULL, CPU_DUMP_FPU);</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;cpu_dump_state(cs, NULL, CPU_DUMP_CODE);</div><div>&nbsp; =
&nbsp; &nbsp;}</div><div>&nbsp;}</div></div><div><br></div><div>2. Run =
this in cmd line:</div><div>#&nbsp;yes "info registers" | sudo =
./qemu-system-x86_64 -accel kvm -monitor stdio -global =
driver=3Dcfi.pflash01,property=3Dsecure,value=3Don -blockdev "{'driver': =
'file', 'filename': '/usr/share/OVMF/OVMF_CODE_4M.secboot.fd', =
'node-name': 'ovmf-code', 'read-only': true}" -blockdev "{'driver': =
'file', 'filename': '/usr/share/OVMF/OVMF_VARS_4M.fd', 'node-name': =
'ovmf-vars', 'read-only': true}" -machine =
q35,smm=3Don,pflash0=3Dovmf-code,pflash1=3Dovmf-vars -m 2G =
-nodefaults</div><div><br></div><div><br></div><div>Assert should be =
reproduced within 10-15 seconds.</div><div>Not sure if it is important =
detail or not, however I run this qemu cmd inside qemu-based virual =
machine with enabled nested =
virtualization.</div><div><br></div><div><div><br><blockquote =
type=3D"cite"><div>On 29 Jul 2025, at 09:01, Xiaoyao Li =
&lt;xiaoyao.li@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 7/29/2025 12:19 AM, Zhao Liu =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Hi Kirill,<br>On Mon, Jul 28, 2025 at 05:44:25PM =
+0300, Kirill Martynov wrote:<br><blockquote type=3D"cite">Date: Mon, 28 =
Jul 2025 17:44:25 +0300<br>From: Kirill Martynov =
&lt;stdcalllevi@yandex-team.ru&gt;<br>Subject: Re: [PATCH] x86/cpu: =
Handle SMM mode in x86_cpu_dump_state for<br>&nbsp;softmmu<br>X-Mailer: =
Apple Mail (2.3826.600.51.1.1)<br><br>Hi Xiaoyao!<br>Hi =
Zhao!<br><br>Xiaoyao,<br>I tested the patch you provided, it works =
smoothly, easy to apply. Nothing to complain about.<br><br>Zhao,<br>I =
also tried your approach (extend cpu_address_space_init with =
AddressSpace parameter)<br>First, it crashed in malloc with =
error:<br>malloc(): unaligned tcache chunk detected<br>After a little =
investigation I resized cpu-&gt;cpu_ases array, so it can fit second =
element and<br>it started working. However, it looks like that function =
cpu_address_space_destroy needs<br>some adjustment, because now it =
treats cpu-&gt;cpu_ases elements as dynamically allocated =
and<br>destroys them with g_free() and passing &amp;smram_address_space =
to cpu_address_space_init()<br>in register_smram_listener() could lead =
to a problem since it is statically allocated in =
binary.<br></blockquote>Thanks for testing. Yes, resize related details =
are needed, which were<br>I missed. These 2 patches essentially are all =
about adding SMM CPU<br>address space for KVM, like TCG =
did.<br><blockquote type=3D"cite">So, my question now, what should I =
do?<br></blockquote></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I just =
sent the formal version [*], could you please help verify if it resolve =
your problem?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">(If you can share the =
step how to reproduce the original problem, I can test myself)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">[*]<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://lore.kernel.org/all/20250729054023.1668443-2-xiaoyao.li@in=
tel.com/" style=3D"font-family: Helvetica; font-size: 16px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: =
0px;">https://lore.kernel.org/all/20250729054023.1668443-2-xiaoyao.li@inte=
l.com/</a><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">I still believe we should update =
cpu_address_space_init() and remove its<br>outdated assumptions about =
KVM first.<br>Moreover, users should have control over the added address =
spaces (I<br>think this is why num_ases should be set =
before<br>cpu_address_space_init()), and quietly updating num_ases is =
not a good<br>idea.<br>The question of whether to reuse =
smram_address_space for the CPU is<br>flexible. At least TCG doesn't =
reuse the same SMM space, and there's<br>already cpu_as_root (and =
cpu_as_mem!) in X86CPU.<span =
class=3D"Apple-converted-space">&nbsp;</span><br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">For i386 tcg, it allocates each CPU 3 =
MemoryRegions: cpu_as_root, cpu_as_mem and smram for SMM. While for i386 =
kvm, it allocates global MemoryRegions: smram_as_root and smram_as_mem =
and get smram from resolving "/machine/smram".</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">yeah, this seems something we can cleanup =
if there were not specific reason for TCG to have different MemoryRegion =
each CPU. I don't have bandwidth to investigate it further.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 16px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">There are also some<br>cleanup things worth considering, such as =
how to better handle the TCG<br>memory listener in =
cpu_address_space_init() - KVM also has the similar<br>logic. If =
possible, I can help you further refine this fix and clean up<br>other =
related stuff in one goes as =
well.<br>Thanks,<br>Zhao</blockquote></div></blockquote></div><br></div></=
body></html>=

--Apple-Mail=_C9F7D6B5-F254-45DB-8FCB-29F183B134CE--

