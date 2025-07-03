Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6A8C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGCL-0004Yu-70; Thu, 03 Jul 2025 05:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uXGCG-0004VW-Kk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:25:38 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uXGCD-00086c-Ej
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:25:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:392d:0:640:2669:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B5C8560A13;
 Thu,  3 Jul 2025 12:25:25 +0300 (MSK)
Received: from smtpclient.apple (unknown [2a02:6bf:8080:860::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OPYBF40Fq4Y0-GtQSidva; Thu, 03 Jul 2025 12:25:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751534725;
 bh=QjaZmZGrxQHGccLn74FhWaFEeRL6LWEdicEAr+H8SQg=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=A6ooQc+G9b+goMuCbqE/WGZ7scyV0RbhbwponrbOWHbJzd6h5X7pT8PtZdHxBjBJ/
 rSt2PR1bAjeP21WKc7npJfi1++0FlU1eQuVE33FBfkBgzlg64RtdOT62AHgkYIOVac
 UqGhihsJ7pth4rfZlWxcThf9RvggbThbuwlD/bPU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <09AD44D6-E381-46B0-9B86-B248EB9582D7@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_88966E14-667B-487B-A506-943B82445F7B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Date: Thu, 3 Jul 2025 12:25:14 +0300
In-Reply-To: <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
 <3096f21e-d8dd-4434-afbd-ee2b56adb20f@intel.com>
 <6a18dfcc-1686-4e3e-8e0a-b96d7034f4ab@intel.com>
 <1d12e519-9f3c-41a0-90ff-8e4655000d21@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_88966E14-667B-487B-A506-943B82445F7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi, Xiaoyao!
Hi, Zhao!
Thank you for your feedback.=20
You wrote:
> QEMU allocates separate KVM address space for SMM in =
register_smram_listener(). But the address space doesn't associated with =
cpu's address space.

The address space allocated in register_sm_ram_listener() is  stored in =
KVMState::KVMAs::as

However, function cpu_asidx_from_attrs() returns index which is used to =
reference CPUState::cpu_ases
These are different array used to store address spaces. In softmmu setup =
there is a function called for cpu initialisation qemu_init_vcpu() which =
has hardcoded number of address spaces used to 1

if (!cpu->as) {
    /* If the target cpu hasn't set up any address spaces itself,
     * give it the default one.
     */
    cpu->num_ases =3D 1;
    cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
}

Do I understand your concern correctly?
The number of address spaces from KVM is allocated correctly (2 address =
spaces) however in QEMU CPUState is allocated only 1, so the correct fix =
would be to associate/map KVM allocated address spaces with
QEMU CPUState address spaces ?

> On 2 Jul 2025, at 19:24, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> On 7/2/2025 11:10 PM, Xiaoyao Li wrote:
>> On 7/2/2025 10:16 PM, Xiaoyao Li wrote:
>>> On 5/23/2025 11:44 PM, Kirill Martynov wrote:
>>>> Certain error conditions can trigger x86_cpu_dump_state() to output =
CPU state
>>>> debug information e.g. KVM emulation failure due to misbehaving =
guest.
>>>> However, if the CPU is in System Management Mode (SMM) when the =
assertion
>>>> in cpu_asidx_from_attrs failure happens because:
>>>>=20
>>>> 1. In SMM mode (smm=3D1), the CPU must use multiple address spaces
>>>>     with a dedicated SMM address space
>>>> 2. On machine types with softmmu, address spaces are hardcoded to 1
>>>>     (no multiple address spaces available)
>>>>=20
>>>> The assertion occurs in cpu_asidx_from_attrs() when trying to
>>>> access memory in SMM mode with insufficient address spaces.
>>>>=20
>>>> Fix this by:
>>>> 1. If number of address spaces is 1 always use index 0
>>>> 2. In other cases use attr.secure for identified proper index
>>>>=20
>>>> This prevents the assertion while still providing useful debug
>>>> output during VM shutdown errors.
>>>=20
>>> To me,  it's just a workaround to avoid the assertion.
>>>=20
>>> When attrs.secure is 1, it means it's in SMM mode. As you describe =
above,
>>>=20
>>>  > 1. In SMM mode (smm=3D1), the CPU must use multiple address =
spaces
>>>  >     with a dedicated SMM address space
>>>=20
>>> So I think we need to first figure out why it gets attrs.secure as 1 =
when there is only 1 address space.
>> Ah, with KVM, QEMU can only support 1 address space.
>=20
> In fact, KVM does support different address space for supporting SMM =
mode. There is KVM_CAP_MULTI_ADDRESS_SPACE to report how many address =
space is supported by KVM.
>=20
> (It turns out my memory on KVM is correct. I was misled by QEMU code =
and comment)
>=20
> QEMU allocates separate KVM address space for SMM in =
register_smram_listener(). But the address space doesn't associated with =
cpu's address space.
>=20
> I think this patch can only avoid the assertion in you case when vcpu =
is in SMM mode with KVM. But with this patch, do you get the correct =
info of SMM mode dumped? I guess no, since the info is of address space =
0, not the SMM address space.
>=20
> If there is no reason of cannot associate KVM's address space with =
cpu's address space, I think the right fix is to enable the association =
with them.
>=20
>=20
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com =
<mailto:xiaoyao.li@intel.com>>
>=20
> Based on above, I need to withdraw my Reviewed-by.
>=20
>=20
>>>>   }
>>>>   static inline AddressSpace *cpu_addressspace(CPUState *cs, =
MemTxAttrs attrs)


--Apple-Mail=_88966E14-667B-487B-A506-943B82445F7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Hi, =
Xiaoyao!<div>Hi, Zhao!</div><div>Thank you for your =
feedback.&nbsp;</div><div>You wrote:</div><div><blockquote =
type=3D"cite">QEMU allocates separate KVM address space for SMM in =
register_smram_listener(). But the address space doesn't associated with =
cpu's address space.</blockquote></div><div><div>The address space =
allocated in register_sm_ram_listener() is &nbsp;stored in&nbsp;<span =
style=3D"color: rgb(9, 89, 132); font-family: &quot;JetBrains =
Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, monospace; =
white-space: pre; background-color: rgb(255, 255, =
255);">KVMState::</span><span style=3D"color: rgb(70, 224, 192); =
font-family: &quot;JetBrains Mono&quot;, Menlo, Monaco, &quot;Courier =
New&quot;, monospace; white-space: pre; background-color: rgb(255, 255, =
255);">KVMAs::as</span></div><div><br></div><div>However, function =
cpu_asidx_from_attrs() returns index which is used to =
reference&nbsp;<span style=3D"color: rgb(70, 224, 192); font-family: =
&quot;JetBrains Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, =
monospace; white-space: pre; background-color: rgb(255, 255, =
255);">CPUState::</span><span style=3D"color: rgb(9, 89, 132); =
font-family: &quot;JetBrains Mono&quot;, Menlo, Monaco, &quot;Courier =
New&quot;, monospace; white-space: pre; background-color: rgb(255, 255, =
255);">cpu_ases</span></div><div>These are different array used to store =
address spaces. In softmmu setup there is a function called for cpu =
initialisation&nbsp;<span style=3D"color: rgb(99, 99, 36); font-family: =
&quot;JetBrains Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, =
monospace; white-space: pre; background-color: rgb(255, 255, =
255);">qemu_init_vcpu()</span><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">&nbsp;which has hardcoded number of address spaces =
used to 1</span></div><div><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);"><br></span></div><div><div style=3D"color: rgb(64, =
64, 64); background-color: rgb(255, 255, 255); font-family: =
&quot;JetBrains Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, =
monospace; line-height: 24px; white-space: pre;"><div><span =
style=3D"color: rgb(157, 78, 150);">if</span> (<span style=3D"color: =
rgb(54, 54, 54);">!</span><span style=3D"color: rgb(9, 89, =
132);">cpu</span>-&gt;<span style=3D"color: rgb(9, 89, 132);">as</span>) =
{</div><div><span style=3D"color: rgb(146, 205, 120);">    /* If the =
target cpu hasn't set up any address spaces =
itself,</span></div><div><span style=3D"color: rgb(146, 205, 120);">     =
* give it the default one.</span></div><div><span style=3D"color: =
rgb(146, 205, 120);">     */</span></div><div>    <span style=3D"color: =
rgb(9, 89, 132);">cpu</span>-&gt;<span style=3D"color: rgb(9, 89, =
132);">num_ases</span> <span style=3D"color: rgb(54, 54, 54);">=3D</span> =
<span style=3D"color: rgb(73, 104, 57);">1</span>;</div><div>    <span =
style=3D"color: rgb(99, 99, 36);">cpu_address_space_init</span>(<span =
style=3D"color: rgb(9, 89, 132);">cpu</span>, <span style=3D"color: =
rgb(73, 104, 57);">0</span>, <span style=3D"color: rgb(162, 86, =
55);">"cpu-memory"</span>, <span style=3D"color: rgb(9, 89, =
132);">cpu</span>-&gt;<span style=3D"color: rgb(9, 89, =
132);">memory</span>);</div><div>}</div></div></div><div><br></div><div>Do=
 I understand your concern correctly?</div><div>The number of address =
spaces from KVM is allocated correctly (2 address spaces) however in =
QEMU CPUState is allocated only 1, so the correct fix would be to =
associate/map KVM allocated address spaces with</div><div>QEMU CPUState =
address spaces ?</div><div><br><blockquote type=3D"cite"><div>On 2 Jul =
2025, at 19:24, Xiaoyao Li &lt;xiaoyao.li@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 7/2/2025 11:10 PM, Xiaoyao Li =
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
text-decoration: none;">On 7/2/2025 10:16 PM, Xiaoyao Li =
wrote:<br><blockquote type=3D"cite">On 5/23/2025 11:44 PM, Kirill =
Martynov wrote:<br><blockquote type=3D"cite">Certain error conditions =
can trigger x86_cpu_dump_state() to output CPU state<br>debug =
information e.g. KVM emulation failure due to misbehaving =
guest.<br>However, if the CPU is in System Management Mode (SMM) when =
the assertion<br>in cpu_asidx_from_attrs failure happens =
because:<br><br>1. In SMM mode (smm=3D1), the CPU must use multiple =
address spaces<br>&nbsp;&nbsp;&nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span>with a dedicated SMM =
address space<br>2. On machine types with softmmu, address spaces are =
hardcoded to 1<br>&nbsp;&nbsp;&nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span>(no multiple address spaces =
available)<br><br>The assertion occurs in cpu_asidx_from_attrs() when =
trying to<br>access memory in SMM mode with insufficient address =
spaces.<br><br>Fix this by:<br>1. If number of address spaces is 1 =
always use index 0<br>2. In other cases use attr.secure for identified =
proper index<br><br>This prevents the assertion while still providing =
useful debug<br>output during VM shutdown errors.<br></blockquote><br>To =
me,&nbsp; it's just a workaround to avoid the assertion.<br><br>When =
attrs.secure is 1, it means it's in SMM mode. As you describe =
above,<br><br>&nbsp;&gt; 1. In SMM mode (smm=3D1), the CPU must use =
multiple address spaces<br>&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; with a =
dedicated SMM address space<br><br>So I think we need to first figure =
out why it gets attrs.secure as 1 when there is only 1 address =
space.<br></blockquote>Ah, with KVM, QEMU can only support 1 address =
space.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">In =
fact, KVM does support different address space for supporting SMM mode. =
There is KVM_CAP_MULTI_ADDRESS_SPACE to report how many address space is =
supported by KVM.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(It =
turns out my memory on KVM is correct. I was misled by QEMU code and =
comment)</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
none; float: none; display: inline !important;">QEMU allocates separate =
KVM address space for SMM in register_smram_listener(). But the address =
space doesn't associated with cpu's address space.</span><br =
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
display: inline !important;">I think this patch can only avoid the =
assertion in you case when vcpu is in SMM mode with KVM. But with this =
patch, do you get the correct info of SMM mode dumped? I guess no, since =
the info is of address space 0, not the SMM address space.</span><br =
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
display: inline !important;">If there is no reason of cannot associate =
KVM's address space with cpu's address space, I think the right fix is =
to enable the association with them.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 16px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Reviewed-by: Xiaoyao Li &lt;<a =
href=3D"mailto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt;<br></blo=
ckquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Based on above, I need =
to withdraw my Reviewed-by.</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite"><blockquote =
type=3D"cite">&nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span>}<br>&nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span>static inline AddressSpace =
*cpu_addressspace(CPUState *cs, MemTxAttrs =
attrs)</blockquote></blockquote></blockquote></div></blockquote></div><br>=
</div></body></html>=

--Apple-Mail=_88966E14-667B-487B-A506-943B82445F7B--

