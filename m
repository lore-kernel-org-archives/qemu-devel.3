Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1789BC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh24J-00019A-Vp; Wed, 30 Jul 2025 04:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uh1fJ-0002lr-RH
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:55:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uh1fG-0006dv-Fv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:55:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1c:2f40:0:640:b89a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 394E380813;
 Wed, 30 Jul 2025 10:55:46 +0300 (MSK)
Received: from smtpclient.apple (unknown
 [2a02:6bf:8005:f00:fcc5:df31:e94a:2d2a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id itU3941GomI0-AqcUnhBt; Wed, 30 Jul 2025 10:55:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753862145;
 bh=BU9VsS15mRLapPhf4tEJbRYgQX9JhJUPV25K5FD3wi0=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=L9VsXe3JRf9w+X+CAw3jHCWOkqZVTjuO6bzuwM87yXTuvA1S/MwQHaXIkxTeAlrMN
 S5rlZMezlhSbjJT5AuceAn9nkt0Sk0FRPJig7mpYTMd78Gupau8UuZl/karv2Unj6Z
 8uSujQCkjy2xer/vehy0u8aVoJJA2Nh0KYqIM+iY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <400CF1E2-6551-4426-8CA4-FCA4A47E25CA@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4C7F47D6-E202-466E-8E1F-1DAD5E09F5E9"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Date: Wed, 30 Jul 2025 10:55:34 +0300
In-Reply-To: <aInTujVM5hr6/cJw@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
To: Zhao Liu <zhao1.liu@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com> <aInTujVM5hr6/cJw@intel.com>
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


--Apple-Mail=_4C7F47D6-E202-466E-8E1F-1DAD5E09F5E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 30 Jul 2025, at 11:11, Zhao Liu <zhao1.liu@intel.com> wrote:
>=20
>> @@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error =
**errp)
>>         kvm_set_guest_phys_bits(cs);
>>     }
>>=20
>> +    /*
>> +     * When SMM is enabled, there is 2 address spaces. Otherwise =
only 1.
>> +     *
>> +     * Only init address space 0 here, the second one for SMM is =
initialized at
>               ^^^^
> 	       initialize
>=20
>> +     * register_smram_listener() after machine init done.
>> +     */
>> +    cs->num_ases =3D =
x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
>> +    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);
>> +
>>     return true;
>> }
>>=20
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 369626f8c8d7..47fb5c673c8e 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
>>=20
>> static void register_smram_listener(Notifier *n, void *unused)
>> {
>> +    CPUState *cpu;
>>     MemoryRegion *smram =3D
>>         (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>>=20
>> @@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier =
*n, void *unused)
>>     address_space_init(&smram_address_space, &smram_as_root, =
"KVM-SMRAM");
>>     kvm_memory_listener_register(kvm_state, &smram_listener,
>>                                  &smram_address_space, 1, =
"kvm-smram");
>> +
>> +    CPU_FOREACH(cpu) {
>> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
>=20
> It is worth mentioning in the commit message that directly sharing
> MemoryRegion in CPUAddressSpace is safe.
>=20
>> +    }
>=20
> I still think such CPU_FOREACH in machine_done callback is not the
> best approach - it's better to initialize all the address spaces in
> kvm_cpu_realizefn(), and not to go far away from cs->num_ases, as I
> said in the previous discussion.
>=20
> But it's still good to fix this bug. So, with other comments
> addressed,
>=20
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>=20

Tested-by: Kirill Martynov <stdcalllevi@yandex-team.ru =
<mailto:stdcalllevi@yandex-team.ru>>=

--Apple-Mail=_4C7F47D6-E202-466E-8E1F-1DAD5E09F5E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 30 Jul 2025, at 11:11, Zhao Liu =
&lt;zhao1.liu@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div><blockquote type=3D"cite">@@=
 -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error =
**errp)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kvm_set_guest_phys_bits(cs=
);<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* When SMM is enabled, there is 2 address =
spaces. Otherwise only 1.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Only init address space 0 here, the second one =
for SMM is initialized at<br></blockquote> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;^^^^<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;initialize<br><br><blockquote =
type=3D"cite">+ &nbsp;&nbsp;&nbsp;&nbsp;* register_smram_listener() =
after machine init done.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;cs-&gt;num_ases =3D =
x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;<br>+ =
&nbsp;&nbsp;&nbsp;cpu_address_space_init(cs, 0, "cpu-mmeory", =
cs-&gt;memory);<br>+<br> &nbsp;&nbsp;&nbsp;&nbsp;return true;<br> =
}<br><br>diff --git a/target/i386/kvm/kvm.c =
b/target/i386/kvm/kvm.c<br>index 369626f8c8d7..47fb5c673c8e =
100644<br>--- a/target/i386/kvm/kvm.c<br>+++ =
b/target/i386/kvm/kvm.c<br>@@ -2704,6 +2704,7 @@ static MemoryRegion =
smram_as_mem;<br><br> static void register_smram_listener(Notifier *n, =
void *unused)<br> {<br>+ &nbsp;&nbsp;&nbsp;CPUState *cpu;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion *smram =3D<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(MemoryRegion *) =
object_resolve_path("/machine/smram", NULL);<br><br>@@ -2728,6 +2729,10 =
@@ static void register_smram_listener(Notifier *n, void *unused)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;address_space_init(&amp;smram_address_space, =
&amp;smram_as_root, "KVM-SMRAM");<br> =
&nbsp;&nbsp;&nbsp;&nbsp;kvm_memory_listener_register(kvm_state, =
&amp;smram_listener,<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;smram_address_space=
, 1, "kvm-smram");<br>+<br>+ &nbsp;&nbsp;&nbsp;CPU_FOREACH(cpu) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_address_space_init(cpu, 1, =
"cpu-smm", &amp;smram_as_root);<br></blockquote><br>It is worth =
mentioning in the commit message that directly sharing<br>MemoryRegion =
in CPUAddressSpace is safe.<br><br><blockquote type=3D"cite">+ =
&nbsp;&nbsp;&nbsp;}<br></blockquote><br>I still think such CPU_FOREACH =
in machine_done callback is not the<br>best approach - it's better to =
initialize all the address spaces in<br>kvm_cpu_realizefn(), and not to =
go far away from cs-&gt;num_ases, as I<br>said in the previous =
discussion.<br><br>But it's still good to fix this bug. So, with other =
comments<br>addressed,<br><br>Reviewed-by: Zhao Liu =
&lt;zhao1.liu@intel.com&gt;<br><br></div></div></blockquote></div><br><div=
>Tested-by: Kirill Martynov &lt;<a =
href=3D"mailto:stdcalllevi@yandex-team.ru">stdcalllevi@yandex-team.ru</a>&=
gt;</div></body></html>=

--Apple-Mail=_4C7F47D6-E202-466E-8E1F-1DAD5E09F5E9--

