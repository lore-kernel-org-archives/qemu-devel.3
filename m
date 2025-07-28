Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D539C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugP5v-00058q-BF; Mon, 28 Jul 2025 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugP5s-00053r-Uz
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:44:48 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugP5o-0003y5-UK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:44:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8776D883DC;
 Mon, 28 Jul 2025 17:44:37 +0300 (MSK)
Received: from smtpclient.apple (unknown
 [2a02:6bf:8005:f00:1055:831c:26ea:3ce6])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZiZNEL6G5a60-1Z5Y6Shu; Mon, 28 Jul 2025 17:44:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753713877;
 bh=J44XMBw1QKt8bmz4lqVx9U0wX661Lo+2HM/qtn0amos=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=Z3KQPqEg9zkx5oI2UUAr5xJ0Fos/UIqaZOz0gv7kTQyeZcaozkwq+cPkcd2e+a0qN
 eR5u1QIwUEbAojZ9UT5zXfEqr+amzYOY5su60isX3uEVpQRgNsqrUGrzNrXFL9youy
 Q6kmy72vJ7FvS+/wOTpZN/tlr9et25aEysbZh6XU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <6C44AD09-0675-4277-93C2-DB3647EC54C2@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_676954BA-D6A3-47DB-91E1-B4DE884BCAA4"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Date: Mon, 28 Jul 2025 17:44:25 +0300
In-Reply-To: <cf64058e-e5a2-4cf2-9851-92925553e72c@intel.com>
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


--Apple-Mail=_676954BA-D6A3-47DB-91E1-B4DE884BCAA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Xiaoyao!
Hi Zhao!

Xiaoyao,
I tested the patch you provided, it works smoothly, easy to apply. =
Nothing to complain about.

Zhao,=20
I also tried your approach (extend cpu_address_space_init with =
AddressSpace parameter)
First, it crashed in malloc with error:
malloc(): unaligned tcache chunk detected
After a little investigation I resized cpu->cpu_ases array, so it can =
fit second element and
it started working. However, it looks like that function =
cpu_address_space_destroy needs
some adjustment, because now it treats cpu->cpu_ases elements as =
dynamically allocated and
destroys them with g_free() and passing &smram_address_space to =
cpu_address_space_init()
in register_smram_listener() could lead to a problem since it is =
statically allocated in binary.

So, my question now, what should I do?
Do I need to send Xiaoyao patch as new separate patch for review?
Or continue polishing Zhao approach?
Any comments from Paolo?

> On 4 Jul 2025, at 16:50, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> On 7/4/2025 4:20 PM, Zhao Liu wrote:
>>> yes, QEMU supports separate address space for SMM mode with KVM. =
It's just
>>> that QEMU doesn't connect it with the CPU address space.
>> Yes, you're right.
>> (But initially, it might have been intentional, as KVM's SMM address
>> space is global. It is consistent with the current KVM/memory =
interface.
>> Creating a separate CPUAddressSpace for each CPU would involve a lot =
of
>> redundant work.)
>=20
> I think Paolo can answer why didn't associate SMM support with KVM =
with CPU addresspace, since Paolo enabled the KVM smm support in QEMU. I =
guess maybe it's just overlooked.
>=20
>>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>>> index a68485547d50..7d6f4a86d802 100644
>>> --- a/include/exec/cpu-common.h
>>> +++ b/include/exec/cpu-common.h
>>> @@ -130,6 +130,8 @@ void cpu_address_space_init(CPUState *cpu, int =
asidx,
>>>   */
>>>  void cpu_address_space_destroy(CPUState *cpu, int asidx);
>>>=20
>>> +void cpu_address_space_add(CPUState *cpu, AddressSpace *as);
>>> +
>> Instead of introducing a "redundant" interfaces, it's better to lift =
the
>> restrictions of cpu_address_space_init() on KVM and reuse it.  =
Moreover,
>> not explicitly setting asidx can be risky.
>=20
> I thought about it. I just wanted to provide a poc implementation for =
Kirill to try, so I didn't touch the existing interface by purpose.
>=20
> Meanwhile, I also had the idea of just calling existing =
cpu_address_space_init() instead of adjusting it, but it needs to be =
called for SMRAM as well to cover SMM. This way, it would still create a =
(when counting the smram, then two) redundant address space for each =
CPU. But it is how it behaves today that with KVM, each CPU has a =
separate address space for system memory.
>=20
> And I'm still investigating if switching to reuse the existing address =
space instead of creating a new one in cpu_address_space_init() would =
cause incompatible problem or not. And this is also the reason why I =
just provided a draft POC diff instead of formal patch.
>=20
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index a68485547d50..e3c70ccb1ea0 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -106,6 +106,8 @@ size_t qemu_ram_pagesize_largest(void);
>>   * @asidx: integer index of this address space
>>   * @prefix: prefix to be used as name of address space
>>   * @mr: the root memory region of address space
>> + * @as: the pre-created AddressSpace. If have, no need to
>> + *      specify @mr.
>>   *
>>   * Add the specified address space to the CPU's cpu_ases list.
>>   * The address space added with @asidx 0 is the one used for the
>> @@ -117,10 +119,10 @@ size_t qemu_ram_pagesize_largest(void);
>>   * cpu->num_ases to the total number of address spaces it needs
>>   * to support.
>>   *
>> - * Note that with KVM only one address space is supported.
>>   */
>>  void cpu_address_space_init(CPUState *cpu, int asidx,
>> -                            const char *prefix, MemoryRegion *mr);
>> +                            const char *prefix, MemoryRegion *mr,
>> +                            AddressSpace *as);
>>  /**
>>   * cpu_address_space_destroy:
>>   * @cpu: CPU for which address space needs to be destroyed
>> diff --git a/system/physmem.c b/system/physmem.c
>> index ff0ca40222d3..15aedfb58055 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -776,16 +776,23 @@ hwaddr memory_region_section_get_iotlb(CPUState =
*cpu,
>>  #endif /* CONFIG_TCG */
>>  void cpu_address_space_init(CPUState *cpu, int asidx,
>> -                            const char *prefix, MemoryRegion *mr)
>> +                            const char *prefix, MemoryRegion *mr,
>> +                            AddressSpace *as)
>>  {
>>      CPUAddressSpace *newas;
>> -    AddressSpace *as =3D g_new0(AddressSpace, 1);
>> -    char *as_name;
>> +    AddressSpace *cpu_as;
>> -    assert(mr);
>> -    as_name =3D g_strdup_printf("%s-%d", prefix, cpu->cpu_index);
>> -    address_space_init(as, mr, as_name);
>> -    g_free(as_name);
>> +    if (!as) {
>> +        cpu_as =3D g_new0(AddressSpace, 1);
>> +        char *as_name;
>> +
>> +        assert(mr);
>> +        as_name =3D g_strdup_printf("%s-%d", prefix, =
cpu->cpu_index);
>> +        address_space_init(cpu_as, mr, as_name);
>> +        g_free(as_name);
>> +    } else {
>> +        cpu_as =3D as;
>> +    }
>>      /* Target code should have set num_ases before calling us */
>>      assert(asidx < cpu->num_ases);
>>      if (asidx =3D=3D 0) {
>>          /* address space 0 gets the convenience alias */
>> -        cpu->as =3D as;
>> +        cpu->as =3D cpu_as;
>>      }
>> -    /* KVM cannot currently support multiple address spaces. */
>> -    assert(asidx =3D=3D 0 || !kvm_enabled());
>> -
>>      if (!cpu->cpu_ases) {
>>          cpu->cpu_ases =3D g_new0(CPUAddressSpace, cpu->num_ases);
>>          cpu->cpu_ases_count =3D cpu->num_ases;
>> @@ -805,12 +809,12 @@ void cpu_address_space_init(CPUState *cpu, int =
asidx,
>>      newas =3D &cpu->cpu_ases[asidx];
>>      newas->cpu =3D cpu;
>> -    newas->as =3D as;
>> +    newas->as =3D cpu_as;
>>      if (tcg_enabled()) {
>>          newas->tcg_as_listener.log_global_after_sync =3D =
tcg_log_global_after_sync;
>>          newas->tcg_as_listener.commit =3D tcg_commit;
>>          newas->tcg_as_listener.name =3D "tcg";
>> -        memory_listener_register(&newas->tcg_as_listener, as);
>> +        memory_listener_register(&newas->tcg_as_listener, cpu_as);
>>      }
>>  }
>> ---
>> In this interface, whether to reuse the existing address space (@as
>> argument) or create a new one for the CPU depends on the maintainer's
>> final opinion anyway. If the choice is to reuse, as in the code =
above,
>> need to adjust other calling cases. If so, I suggest Kirill handle =
this
>> in a separate patch.
>>>  #include "kvm_i386.h"
>>> @@ -90,6 +91,12 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error =
**errp)
>>>          kvm_set_guest_phys_bits(cs);
>>>      }
>>>=20
>>> +    for (int i =3D 0; i < kvm_state->nr_as; i++) {
>>> +        if (kvm_state->as[i].as) {
>>> +            cpu_address_space_add(cs, kvm_state->as[i].as);
>>> +        }
>>> +    }
>>> +
>> This will add smram twice, with the following =
cpu_address_space_add().
>=20
> No, SMRAM is initialize at machine init done notifier, which is after =
this.
>=20
>> Why are all KVM as unconditionally added to each CPU?
>> Another issue is the SMM AS index would be "unknown"...
>>>      return true;
>>>  }
>>>=20
>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index 234878c613f6..3ba7b26e5a74 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -2700,6 +2700,7 @@ static MemoryRegion smram_as_mem;
>>>=20
>>>  static void register_smram_listener(Notifier *n, void *unused)
>>>  {
>>> +    CPUState *cpu;
>>>      MemoryRegion *smram =3D
>>>          (MemoryRegion *) object_resolve_path("/machine/smram", =
NULL);
>>>=20
>>> @@ -2724,6 +2725,9 @@ static void register_smram_listener(Notifier =
*n, void
>>> *unused)
>>>      address_space_init(&smram_address_space, &smram_as_root, =
"KVM-SMRAM");
>>>      kvm_memory_listener_register(kvm_state, &smram_listener,
>>>                                   &smram_address_space, 1, =
"kvm-smram");
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_address_space_add(cpu, &smram_address_space);
>>> +    }
>>>  }
>> With the cpu_address_space_init(), here could be:
>> CPU_FOREACH(cpu) {
>> 	/* Ensure SMM Address Space has the index 1.  */
>> 	assert(cpu->num_ases =3D=3D 1);
>> 	cpu->num_ases =3D 2;
>> 	cpu_address_space_init(cpu, 1, NULL, NULL, =
&smram_address_space);
>> }


--Apple-Mail=_676954BA-D6A3-47DB-91E1-B4DE884BCAA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Hi =
Xiaoyao!<div>Hi Zhao!</div><div><br></div><div>Xiaoyao,</div><div>I =
tested the patch you provided, it works smoothly, easy to apply. Nothing =
to complain about.</div><div><br></div><div>Zhao,&nbsp;</div><div>I also =
tried your approach (extend cpu_address_space_init with AddressSpace =
parameter)</div><div>First, it crashed in malloc with =
error:</div><div>malloc(): unaligned tcache chunk =
detected</div><div>After a little investigation I resized&nbsp;<span =
style=3D"color: rgb(9, 89, 132); font-family: &quot;JetBrains =
Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, monospace; =
white-space: pre; background-color: rgb(255, 255, =
255);">cpu-&gt;cpu_ases</span><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">&nbsp;array, so it can fit second element =
and</span></div><div><font color=3D"#000000">it started working. =
However, it looks like that function&nbsp;</font><span style=3D"color: =
rgb(99, 99, 36); font-family: &quot;JetBrains Mono&quot;, Menlo, Monaco, =
&quot;Courier New&quot;, monospace; white-space: pre; background-color: =
rgb(255, 255, 255);">cpu_address_space_destroy</span><span style=3D"color:=
 rgb(0, 0, 0);">&nbsp;needs</span></div><div><font color=3D"#000000">some =
adjustment, because now it treats cpu-&gt;cpu_ases elements as =
dynamically allocated and</font></div><div><font =
color=3D"#000000">destroys them with g_free() and =
passing&nbsp;</font><span style=3D"font-family: &quot;JetBrains =
Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, monospace; =
white-space: pre; background-color: rgb(255, 255, 255); color: rgb(54, =
54, 54);">&amp;</span><span style=3D"font-family: &quot;JetBrains =
Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, monospace; =
white-space: pre; background-color: rgb(255, 255, 255); color: rgb(9, =
89, 132);">smram_address_space</span><span style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0);">&nbsp;to =
cpu_address_space_init()</span></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);">in&nbsp;</span></font><span =
style=3D"color: rgb(99, 99, 36); font-family: &quot;JetBrains =
Mono&quot;, Menlo, Monaco, &quot;Courier New&quot;, monospace; =
white-space: pre; background-color: rgb(255, 255, =
255);">register_smram_listener()</span><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp;could lead to a problem since =
it is statically allocated in binary.</span></div><div><font =
color=3D"#000000"><span style=3D"caret-color: rgb(0, 0, =
0);"><br></span></font></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);">So, my question now, what should I =
do?</span></font></div><div><font color=3D"#000000"><span =
style=3D"caret-color: rgb(0, 0, 0);">Do I need to send Xiaoyao patch as =
new separate patch for review?</span></font></div><div><font =
color=3D"#000000">Or continue polishing Zhao =
approach?</font></div><div><font color=3D"#000000">Any comments from =
Paolo?<br></font><div><br><blockquote type=3D"cite"><div>On 4 Jul 2025, =
at 16:50, Xiaoyao Li &lt;xiaoyao.li@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 7/4/2025 4:20 PM, Zhao Liu =
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
text-decoration: none;"><blockquote type=3D"cite">yes, QEMU supports =
separate address space for SMM mode with KVM. It's just<br>that QEMU =
doesn't connect it with the CPU address space.<br></blockquote>Yes, =
you're right.<br>(But initially, it might have been intentional, as =
KVM's SMM address<br>space is global. It is consistent with the current =
KVM/memory interface.<br>Creating a separate CPUAddressSpace for each =
CPU would involve a lot of<br>redundant work.)<br></blockquote><br =
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
display: inline !important;">I think Paolo can answer why didn't =
associate SMM support with KVM with CPU addresspace, since Paolo enabled =
the KVM smm support in QEMU. I guess maybe it's just =
overlooked.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
text-decoration: none;"><blockquote type=3D"cite">diff --git =
a/include/exec/cpu-common.h b/include/exec/cpu-common.h<br>index =
a68485547d50..7d6f4a86d802 100644<br>--- =
a/include/exec/cpu-common.h<br>+++ b/include/exec/cpu-common.h<br>@@ =
-130,6 +130,8 @@ void cpu_address_space_init(CPUState *cpu, int =
asidx,<br>&nbsp;&nbsp;*/<br>&nbsp;void =
cpu_address_space_destroy(CPUState *cpu, int asidx);<br><br>+void =
cpu_address_space_add(CPUState *cpu, AddressSpace =
*as);<br>+<br></blockquote>Instead of introducing a "redundant" =
interfaces, it's better to lift the<br>restrictions of =
cpu_address_space_init() on KVM and reuse it. &nbsp;Moreover,<br>not =
explicitly setting asidx can be risky.<br></blockquote><br =
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
display: inline !important;">I thought about it. I just wanted to =
provide a poc implementation for Kirill to try, so I didn't touch the =
existing interface by purpose.</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 16px; font-style: normal; =
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
text-decoration: none; float: none; display: inline =
!important;">Meanwhile, I also had the idea of just calling existing =
cpu_address_space_init() instead of adjusting it, but it needs to be =
called for SMRAM as well to cover SMM. This way, it would still create a =
(when counting the smram, then two) redundant address space for each =
CPU. But it is how it behaves today that with KVM, each CPU has a =
separate address space for system memory.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 16px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
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
text-decoration: none; float: none; display: inline !important;">And I'm =
still investigating if switching to reuse the existing address space =
instead of creating a new one in cpu_address_space_init() would cause =
incompatible problem or not. And this is also the reason why I just =
provided a draft POC diff instead of formal patch.</span><br =
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
none;">diff --git a/include/exec/cpu-common.h =
b/include/exec/cpu-common.h<br>index a68485547d50..e3c70ccb1ea0 =
100644<br>--- a/include/exec/cpu-common.h<br>+++ =
b/include/exec/cpu-common.h<br>@@ -106,6 +106,8 @@ size_t =
qemu_ram_pagesize_largest(void);<br>&nbsp;&nbsp;* @asidx: integer index =
of this address space<br>&nbsp;&nbsp;* @prefix: prefix to be used as =
name of address space<br>&nbsp;&nbsp;* @mr: the root memory region of =
address space<br>+ * @as: the pre-created AddressSpace. If have, no need =
to<br>+ * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;specify =
@mr.<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;* Add the specified address space =
to the CPU's cpu_ases list.<br>&nbsp;&nbsp;* The address space added =
with @asidx 0 is the one used for the<br>@@ -117,10 +119,10 @@ size_t =
qemu_ram_pagesize_largest(void);<br>&nbsp;&nbsp;* cpu-&gt;num_ases to =
the total number of address spaces it needs<br>&nbsp;&nbsp;* to =
support.<br>&nbsp;&nbsp;*<br>- * Note that with KVM only one address =
space is supported.<br>&nbsp;&nbsp;*/<br>&nbsp;void =
cpu_address_space_init(CPUState *cpu, int asidx,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;const char *prefix, MemoryRegion *mr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;const char *prefix, MemoryRegion *mr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;AddressSpace *as);<br>&nbsp;/**<br>&nbsp;&nbsp;* =
cpu_address_space_destroy:<br>&nbsp;&nbsp;* @cpu: CPU for which address =
space needs to be destroyed<br>diff --git a/system/physmem.c =
b/system/physmem.c<br>index ff0ca40222d3..15aedfb58055 100644<br>--- =
a/system/physmem.c<br>+++ b/system/physmem.c<br>@@ -776,16 +776,23 @@ =
hwaddr memory_region_section_get_iotlb(CPUState *cpu,<br>&nbsp;#endif /* =
CONFIG_TCG */<br>&nbsp;void cpu_address_space_init(CPUState *cpu, int =
asidx,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;const char *prefix, MemoryRegion *mr)<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;const char *prefix, MemoryRegion *mr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;AddressSpace =
*as)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPUAddressSpace =
*newas;<br>- &nbsp;&nbsp;&nbsp;AddressSpace *as =3D g_new0(AddressSpace, =
1);<br>- &nbsp;&nbsp;&nbsp;char *as_name;<br>+ =
&nbsp;&nbsp;&nbsp;AddressSpace *cpu_as;<br>- =
&nbsp;&nbsp;&nbsp;assert(mr);<br>- &nbsp;&nbsp;&nbsp;as_name =3D =
g_strdup_printf("%s-%d", prefix, cpu-&gt;cpu_index);<br>- =
&nbsp;&nbsp;&nbsp;address_space_init(as, mr, as_name);<br>- =
&nbsp;&nbsp;&nbsp;g_free(as_name);<br>+ &nbsp;&nbsp;&nbsp;if (!as) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_as =3D =
g_new0(AddressSpace, 1);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;char *as_name;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert(mr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;as_name =3D =
g_strdup_printf("%s-%d", prefix, cpu-&gt;cpu_index);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;address_space_init(cpu_as, mr, =
as_name);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(as_name);<br>+ =
&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_as =3D as;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Target code =
should have set num_ases before calling us =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert(asidx &lt; =
cpu-&gt;num_ases);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (asidx =3D=3D 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* address =
space 0 gets the convenience alias */<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;as =3D as;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;as =3D =
cpu_as;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;/* KVM =
cannot currently support multiple address spaces. */<br>- =
&nbsp;&nbsp;&nbsp;assert(asidx =3D=3D 0 || =
!kvm_enabled());<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!cpu-&gt;cpu_ases) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;cpu_ase=
s =3D g_new0(CPUAddressSpace, =
cpu-&gt;num_ases);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;cpu-&gt;cpu_ases_count =3D cpu-&gt;num_ases;<br>@@ -805,12 +809,12 @@ =
void cpu_address_space_init(CPUState *cpu, int =
asidx,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;newas =3D =
&amp;cpu-&gt;cpu_ases[asidx];<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;newas-&gt;c=
pu =3D cpu;<br>- &nbsp;&nbsp;&nbsp;newas-&gt;as =3D as;<br>+ =
&nbsp;&nbsp;&nbsp;newas-&gt;as =3D =
cpu_as;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (tcg_enabled()) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;newas-&gt;tcg_a=
s_listener.log_global_after_sync =3D =
tcg_log_global_after_sync;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;newas-&gt;tcg_as_listener.commit =3D =
tcg_commit;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;newas=
-&gt;tcg_as_listener.name =3D "tcg";<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_listener_register(&amp;ne=
was-&gt;tcg_as_listener, as);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_listener_register(&amp;ne=
was-&gt;tcg_as_listener, =
cpu_as);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;}<br>---<br>In this =
interface, whether to reuse the existing address space (@as<br>argument) =
or create a new one for the CPU depends on the maintainer's<br>final =
opinion anyway. If the choice is to reuse, as in the code above,<br>need =
to adjust other calling cases. If so, I suggest Kirill handle this<br>in =
a separate patch.<br><blockquote type=3D"cite">&nbsp;#include =
"kvm_i386.h"<br>@@ -90,6 +91,12 @@ static bool =
kvm_cpu_realizefn(CPUState *cs, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kvm_set_g=
uest_phys_bits(cs);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>+ =
&nbsp;&nbsp;&nbsp;for (int i =3D 0; i &lt; kvm_state-&gt;nr_as; i++) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(kvm_state-&gt;as[i].as) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_addr=
ess_space_add(cs, kvm_state-&gt;as[i].as);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br></blockquote>This will add smram twice, with =
the following cpu_address_space_add().<br></blockquote><br =
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
display: inline !important;">No, SMRAM is initialize at machine init =
done notifier, which is after this.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 16px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
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
text-decoration: none;">Why are all KVM as unconditionally added to each =
CPU?<br>Another issue is the SMM AS index would be =
"unknown"...<br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
true;<br>&nbsp;}<br><br>diff --git a/target/i386/kvm/kvm.c =
b/target/i386/kvm/kvm.c<br>index 234878c613f6..3ba7b26e5a74 =
100644<br>--- a/target/i386/kvm/kvm.c<br>+++ =
b/target/i386/kvm/kvm.c<br>@@ -2700,6 +2700,7 @@ static MemoryRegion =
smram_as_mem;<br><br>&nbsp;static void register_smram_listener(Notifier =
*n, void *unused)<br>&nbsp;{<br>+ &nbsp;&nbsp;&nbsp;CPUState =
*cpu;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion *smram =
=3D<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(MemoryRegion=
 *) object_resolve_path("/machine/smram", NULL);<br><br>@@ -2724,6 =
+2725,9 @@ static void register_smram_listener(Notifier *n, =
void<br>*unused)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;address_space_init(&amp;=
smram_address_space, &amp;smram_as_root, =
"KVM-SMRAM");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kvm_memory_listener_registe=
r(kvm_state, =
&amp;smram_listener,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&amp;smram_address_space, 1, "kvm-smram");<br>+ =
&nbsp;&nbsp;&nbsp;CPU_FOREACH(cpu) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_address_space_add(cpu, =
&amp;smram_address_space);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>&nbsp;}<br></blockquote>With the =
cpu_address_space_init(), here could be:<br>CPU_FOREACH(cpu) {<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* Ensure =
SMM Address Space has the index 1. &nbsp;*/<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>assert(cpu-&gt;num_ases =3D=3D 1);<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>cpu-&gt;num_ases =3D 2;<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>cpu_address_space_init(cpu, 1, =
NULL, NULL, =
&amp;smram_address_space);<br>}</blockquote></div></blockquote></div><br><=
/div></body></html>=

--Apple-Mail=_676954BA-D6A3-47DB-91E1-B4DE884BCAA4--

