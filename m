Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F243E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJJ5-0001bP-Mp; Thu, 05 Dec 2024 16:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJJ1-0001b3-Fs
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:22:39 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJIz-00050Q-1U
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:22:38 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 190D01803F5
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 22:22:34 +0100 (CET)
Received: (qmail 2535 invoked by uid 990); 5 Dec 2024 21:22:34 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 22:22:33 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 21:22:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.281825) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.118174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=327/Whnuy2DK9rlIKFXu7Rj0LfjXWBgCFmve2ej5Bek=;
 b=QixXAzRf5X2QL0geclfvS3xGM0VRV9a7UQfI88o929/FpXuaWF2LEWyJh+gVkz2VUgdzrdpaed
 uyViIOUM8sZTcjSMVjv7eKUIROBVyyBQj3gyCTN44EwLn0V2wO67sJSYpfMFS+pinhEjT+2u2VKx
 9tyw2X1qLpYjyttP8hpogOlXoa6VnhnRyJ8aDPQROlzQkZAuwlrQ0Va5LhGiLEY3U+OPaHt1bTR/
 qaYGi2JPLdfBcvy1BT2uOr1NfBh+ul13pnU2oEtyEzkNJdKI9bb+h3gE53ERl90sbutQpdJNR8qC
 XSgVeIqyThLQzE8k038iF1SkrAXdGp6S9dzavxADX1YBtEyX1OGfFu93qeiDHR+vFFcVRNt5Fayg
 WjgmnYgAQQt0xqaQBadKWWzXNtZlrE6iP7j/FgxONv7DBnHzorXG/X+x4E418x+DW1Ku6/PV1quv
 TdiTrDuqfx3P+Hm34M6inTLpqPFh/HAFLyvt3KsuT3lAW75Ff4AWWythFQuNkj37bYBKCIwjRyOj
 z7UYSkfbYpoh1Q9IVVXFyDXgqv/VB24bYOLZh60cuHxoLaA2Q9S9/VV5qApSe87RiwKQkw7rs7Dz
 BqLvQHagu0VLCOBevSRI3wL8M0oyXvTv6kqdLTomwTETRAxvByCzx9H1pgwHjO5fA38OkUUw73pc
 k=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Pierrick,

December 5, 2024 at 6:30 PM, "Pierrick Bouvier" wrote:
> On 12/5/24 05:10, Julian Ganz wrote:
> >  December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
> > > Trap target PC mismatch
> > >  Expected: 23faf3a80
> > >  Encountered: 23faf3a84
> > >=20
>=20> >  From what I understand, it means that the next_pc we have is inc=
orrect.
> > >=20
>=20>  Yes, this is indeed incorrect, and also a perfect example why this=
 test
> >  plugin exists. There are likely other errors lurking in target speci=
fic
> >  code. Did you happen to also log interrupts? Do you remember what im=
age
> >  you used?
> >=20
>=20I used exactly this:
>=20
>=20./build/qemu-system-aarch64 -plugin ./build/tests/tcg/plugins/libdisc=
ons.so -smp 4 -M virt -d plugin -m 8G -device virtio-blk-pci,drive=3Droot=
 -drive if=3Dnone,id=3Droot,file=3D./debianaarch64.img -M virt -cpu max,p=
auth=3Doff -drive if=3Dpflash,readonly=3Don,file=3D/usr/share/AAVMF/AAVMF=
_CODE.fd -drive if=3Dpflash,file=3D./AAVMF_VARS.fd
>=20
>=20The arm64 image is a vanilla debian stable I installed.
> AAVMF* files come from qemu-efi-aarch64 debian package.

Thanks! I will have a closer look and include a fix in the next iteration=
.

> > Btw: this also illustrates another issue I have with from_pc: we can
> >  test the behavior for to_pc, but doing this meaningfully for from_pc
> >  via a plugin is next to impossible because the instruction it points=
 to
> >  is not observable via an exec callback. At least not in the general
> >  case, even not if we only consider a single type of event.
> >=20
>=20We can store the next_expected pc for each instruction (from current_=
instruction + insn_length), and we should be able to compare that with th=
e expected from_pc.
> This is mostly what contrib/plugins/cflow.c does.
>=20
>=20With that, we can test from_pc.

I'm not confident that this will work reliably for branch, jump and
other "interesting" instructions. But I can have a closer look at the
cflow plugin and try to figure out how that plugin handles those cases.

Regards,
Julian Ganz

