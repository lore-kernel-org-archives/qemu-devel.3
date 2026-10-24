Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A5606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=SP86FlH0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKe13-0008WR-8B; Sat, 24 Oct 2026 11:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKe0x-0008Vi-4c
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:50:35 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKe0v-0006sc-G9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792857021; x=1793461821; i=deller@gmx.de;
 bh=IgzHnp4F3fUv1fIKgsOeB/ovK6Gp+dm2wlNboKQIcDA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SP86FlH08l7RLvYFkX2VQVv/bKLSrBhkRIxwunEJFnVNrI6JZr6JrR5NjkgMyzxm
 TDLnbmN6+Nv/s3tSEBa95F6NYY8JUMqJicrjRYtWzIPNsa15txjmAqcZXUlIEs3aH
 VrzaLbp5IMuS6s7Fuc/gIAcTpwTenbMgZk0wMFRimI8FghdcbCmq9NzG9wWgncVKb
 T2rEsDXQgKyARtLGtN2SSabrSJ/qU2qFUgRP17eiG3p+Ijs+1gCmyRC992K4faMUr
 NvMfp1Nc++yOQ7bBTHHerLA4M0FSEZbTA/EQ63OuDWcYEeAt0BNC35P1CiBjZW+GN
 RcC+UhMOQONLixGyUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1wnGBW1cg3-00gy3A; Sat, 24
 Oct 2026 17:50:21 +0200
Message-ID: <49597e72-68a8-45f9-9e26-e598d29971d2@gmx.de>
Date: Sat, 24 Oct 2026 17:50:17 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user/vdso: reproducible?
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <c9bcda59-f2f9-4036-8aeb-1e36e1b68498@tls.msk.ru>
 <3653de48-cda5-4dd5-957f-fe86a069a2ad@gmx.de>
 <30a5032f-d82d-440b-90d2-259cbe004755@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <30a5032f-d82d-440b-90d2-259cbe004755@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rD8+lhU3boDnmhPZgXsxrwEpYeo5JAnS9dQdb/gWkzsBmJKhCCh
 qDp5k3O8ADSBVgIMZxzlNEzbm+AviEsnTVboedC9Ye4QpnXCxpm6RW6lKt2TMIgeCm8OcIT
 x5ksqN0ErgP+zFH6C3f/J0h9yUVnNDXL5U2gC9uBAb+7nXTvipAxBYz3Qg/eFZrSNwBzCCh
 nL7lsw08k+L7c1aZHBm9g==
UI-OutboundReport: notjunk:1;M01:P0:DO+riF/23Fw=;awrjqPTGlWxj3DPyG7WP4g34gn2
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 17:20, Michael Tokarev wrote:
> On 10/24/26 16:34, Helge Deller wrote:
>> On 10/24/26 07:51, Michael Tokarev wrote:
>>> Hi!
>>>
>>> Once again I'm trying to fix a long-standing issue in debian & ubuntu =
with
>>> vdso files build.
>>>
>>> One of the requirements here is to build everything from source, ensur=
ing
>>> the things can be rebuild and are reproducible (that is, the shipped b=
inaries
>>> can actually be produced from the provided source and not something el=
se
>>> with a hidden backdoor).
>>>
>>> It'd be nice to just build the vdso.so files during regular package bu=
ild.
>>> But this does not work correctly neither in debian nor in ubuntu infra=
structure
>>> due to several reasons.=C2=A0 The main problem is that to build all vd=
so files,
>>> one need to have cross-compilers for all architectures on every host
>>> architecture for which qemu-user packages are produced, which is probl=
ematic
>>> (especially for lower-power, or "small", architectures).
>>>
>>> Additionally, llvm/clang, which can produce binaries for multiple arch=
itectures
>>> and is available on all host architectures on debian, does not handle =
sh4 and
>>> hpps which are currently needed to rebuild vdso files in qemu, so it i=
s also
>>
>> I assume you meant "hppa" instead of "hpps".
>=20
> Yeah, just a typo.
>=20
>=20
>>> =E2=94=82 -cc0Lcfxq.o
>>> =E2=94=82 +ccuckKYd.o
>=20
>>> So basically, the difference is just in the temporary .o filename
>>> used during the build process, and that name is random.
>>
>> Is there a way to use a static name instead, e.g. tell the Makefile
>> not to use a dynamic file name?
>=20
> Well yes - either use explicit separate compile and link command lines,
> or use -pipe (this eliminates this name entirely).

So -pipe is probably the best alternative of both.
 =20
>>> After stripping both files from debug info (aarch64-linux-gnu-strip),
>>> things becomes exactly the same.
>>>
>>> Can't we strip them during build anyway?
>>
>> If you strip them, you loose the ability to debug at runtime in the gue=
st.
>=20
> Sure.=C2=A0 These object files contains very little code, it's mostly ju=
st a
> symbol table,=C2=A0 nothing more.=C2=A0 There's nothing to debug in ther=
e really.
True, but the symbol table resolves the entries to the VDSO while debuggin=
g.

Either way, if dropping the symbol table is the easiest way to resolve
the reproduceable builds, then I'm ok with that too.

Helge

