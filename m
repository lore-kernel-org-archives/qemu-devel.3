Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFF3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unwJh-0000j3-Dt; Mon, 18 Aug 2025 05:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1unwJg-0000ih-6g
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 05:38:12 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1unwJc-0000EZ-Dc
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 05:38:11 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0CFFB80832;
 Mon, 18 Aug 2025 12:38:00 +0300 (MSK)
Received: from smtpclient.apple (unknown [2a02:6bf:8080:41c::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wbMVKP0GkKo0-cBE0NjYi; Mon, 18 Aug 2025 12:37:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755509879;
 bh=w1fd9EqwoiAMY/qoHprGievSwm7Qkod026M8CmAx120=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=bB/6MxcGc0NFBQS6BtCMAjUMGrPV86Z5hPTi0OFkUJaAKDxfL7YZoqu2SbP7THgEM
 sM+kcitLWokxk5+SI458S+lfD5hqXRXN+x/nNolUpTaHSkj/yY1UFw/xaOuuXBut76
 hPEaWgcpJtMG5Vn6mrFBzGPM0T7spRfYW9eAk6m4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <A73BFF41-0C1D-40E4-87E1-1DE5A86B83EA@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C2135662-E16C-4991-996A-F30BE93F23D3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Date: Mon, 18 Aug 2025 12:37:48 +0300
In-Reply-To: <aIro0jw/CjMssy/v@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
To: Zhao Liu <zhao1.liu@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com> <aInTujVM5hr6/cJw@intel.com>
 <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com> <aIo4MxukAiY0OSGE@intel.com>
 <e5bde045-01b6-4f81-bc25-fd4312de7fe8@intel.com> <aIro0jw/CjMssy/v@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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


--Apple-Mail=_C2135662-E16C-4991-996A-F30BE93F23D3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Paolo,
Would you have time to share your thoughts about this set of patches?

> On 31 Jul 2025, at 06:53, Zhao Liu <zhao1.liu@intel.com> wrote:
>=20
> On Thu, Jul 31, 2025 at 12:11:41AM +0800, Xiaoyao Li wrote:
>> Date: Thu, 31 Jul 2025 00:11:41 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
>>=20
>> On 7/30/2025 11:20 PM, Zhao Liu wrote:
>>>>>> +        cpu_address_space_init(cpu, 1, "cpu-smm", =
&smram_as_root);
>>>>>=20
>>>>> It is worth mentioning in the commit message that directly sharing
>>>>> MemoryRegion in CPUAddressSpace is safe.
>>>>=20
>>>> It's unnecessary to me. It's common that different Address space =
share the
>>>> same (root) memory region. e.g., for address space 0 for the cpu, =
though
>>>> what passed in is cpu->memory, they all point to system_memory.
>>>=20
>>> For cpu->memory, there's the "object_ref(OBJECT(cpu->memory))" in
>>> cpu_exec_initfn().
>>>=20
>>> But this case doesn't need to increase ref count like cpu->memory, =
since
>>> memory_region_ref() provides protection and it's enough.
>>>=20
>>> This is the difference.
>>>=20
>>> So it sounds like now it's more necessary to clarify this, no?
>>>=20
>>=20
>> clarify why smram_as_root doesn't need to be object_ref()'ed =
explicitly like
>> what cpu_exec_initfn() does for cpu->memory?
>=20
> When you're referring cpu->memory, you should aware where's the
> difference and why you don't need do the same thing.
>=20
> This is necessary for a clear commit message, and it also allows more
> eyes to check whether it is correct and whether there are any =
potential
> problems. Providing details is always beneficial.
>=20
>> As you saide,
>>=20
>> cpu_address_space_init()
>>  -> address_space_init()
>>     -> memory_region_ref()
>>=20
>> it already ensures the ref count is increased.
>=20
> Yes, this is what I mean.
>=20
>> Why cpu_exec_initfn() increases the refcount of cpu->memory, is
>> totally unrelated to cpu_address_space_init().
>  ^^^^^^^^^^^^^^^^^
>=20
> The validity of cpu->memory must be guaranteed, as this is a =
prerequisite
> for everything else. And isn't it mainly related with the CPU address
> space??
>=20
> It can be said that because the pointer to system_memory needs to be
> cached in CPUState, such a ref is useful, thereby ensuring the safety
> of the next address space stuff.


--Apple-Mail=_C2135662-E16C-4991-996A-F30BE93F23D3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Hi =
Paolo,<div>Would you have time to share your thoughts about this set of =
patches?<br id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 31 Jul 2025, at 06:53, Zhao Liu =
&lt;zhao1.liu@intel.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
16px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Thu, Jul 31, 2025 at 12:11:41AM +0800, =
Xiaoyao Li wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Date: Thu, 31 Jul 2025 00:11:41 +0800<br>From: =
Xiaoyao Li &lt;xiaoyao.li@intel.com&gt;<br>Subject: Re: [PATCH 1/2] =
i386/cpu: Enable SMM cpu addressspace<br><br>On 7/30/2025 11:20 PM, Zhao =
Liu wrote:<br><blockquote type=3D"cite"><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_address_space_init(cpu, 1, =
"cpu-smm", &amp;smram_as_root);<br></blockquote><br>It is worth =
mentioning in the commit message that directly sharing<br>MemoryRegion =
in CPUAddressSpace is safe.<br></blockquote><br>It's unnecessary to me. =
It's common that different Address space share the<br>same (root) memory =
region. e.g., for address space 0 for the cpu, though<br>what passed in =
is cpu-&gt;memory, they all point to =
system_memory.<br></blockquote><br>For cpu-&gt;memory, there's the =
"object_ref(OBJECT(cpu-&gt;memory))" in<br>cpu_exec_initfn().<br><br>But =
this case doesn't need to increase ref count like cpu-&gt;memory, =
since<br>memory_region_ref() provides protection and it's =
enough.<br><br>This is the difference.<br><br>So it sounds like now it's =
more necessary to clarify this, no?<br><br></blockquote><br>clarify why =
smram_as_root doesn't need to be object_ref()'ed explicitly like<br>what =
cpu_exec_initfn() does for cpu-&gt;memory?<br></blockquote><br =
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
display: inline !important;">When you're referring cpu-&gt;memory, you =
should aware where's the</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
!important;">difference and why you don't need do the same =
thing.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
none; float: none; display: inline !important;">This is necessary for a =
clear commit message, and it also allows more</span><br =
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
display: inline !important;">eyes to check whether it is correct and =
whether there are any potential</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">problems. Providing details is always beneficial.</span><br =
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
none;">As you saide,<br><br>cpu_address_space_init()<br>&nbsp;-&gt; =
address_space_init()<br>&nbsp;&nbsp;&nbsp;&nbsp;-&gt; =
memory_region_ref()<br><br>it already ensures the ref count is =
increased.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Yes, =
this is what I mean.</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
text-decoration: none;">Why cpu_exec_initfn() increases the refcount of =
cpu-&gt;memory, is<br>totally unrelated to =
cpu_address_space_init().<br></blockquote><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 16px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;^^^^^^^^^^^^^^^^^</span><br style=3D"caret-color: =
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
text-decoration: none; float: none; display: inline !important;">The =
validity of cpu-&gt;memory must be guaranteed, as this is a =
prerequisite</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 16px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 16px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">for everything else. And =
isn't it mainly related with the CPU address</span><br =
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
display: inline !important;">space??</span><br style=3D"caret-color: =
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
text-decoration: none; float: none; display: inline !important;">It can =
be said that because the pointer to system_memory needs to be</span><br =
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
display: inline !important;">cached in CPUState, such a ref is useful, =
thereby ensuring the safety</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 16px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">of the =
next address space =
stuff.</span></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_C2135662-E16C-4991-996A-F30BE93F23D3--

