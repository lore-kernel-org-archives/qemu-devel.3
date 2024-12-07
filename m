Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CD0E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 13:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJv3c-0003li-I6; Sat, 07 Dec 2024 08:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJv3b-0003lT-G3
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:41:15 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJv3a-000581-4u
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:41:15 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id B8425180C07
 for <qemu-devel@nongnu.org>; Sat,  7 Dec 2024 14:41:12 +0100 (CET)
Received: (qmail 19083 invoked by uid 990); 7 Dec 2024 13:41:12 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 07 Dec 2024 14:41:12 +0100
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 13:41:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <4193e06c04c188b9e212e347e710b92db68740d2@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Richard Henderson" <richard.henderson@linaro.org>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
 <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
 <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.011686) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.388313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=2J9HLLfO8SXniPB3yEN755Jz1nNdaVvdRfw9VNt56GQ=;
 b=s3gPrU/2AeIa+wVV4Co9VtbNh1+4h9jtSzMWrq4+VlIUxmzqOPi7A1vFxBupC0bGYWfS9evkMK
 HWbvrxVFZ8qMf2Htd9G5pBLPaww/j1w71WClS8cMU5j1D1/zRWQ/f3cEUIxUu2DKqH4U/KCyc6cm
 2C1cABIFPoWPqkuNp9/mxI9EfYS4LaSgIMhdFCz7WzrF4ORoX81CY57dpJcV0lBNQeUdvUIh2CxC
 jIygGlr0PqXaLyS3g2Et1+YYCSvU2Ez2yAHHNgjo17AZQOAKvDzYZhj5dznOcpVgiiKMFukTYJOT
 mzANSEpw+g3B5++6rveYRbxxJC/dvYUVT5qoUcecDyGzR4pkghlgPsnwpnEtLl/9Q+2HPQRePRhn
 oHJX47uqa2alEfWAkinMvmFC/MzkYEPfDQj+u6wusf2YRAbrhK5Of0akZzYl8uFmoWGOeh+A7Kwl
 YIlRw6pBMyfl6/2L5Ekoxelrf6FloSaZYUH5Vp6tyKFPX7roEU70nEwaogXr6PQxp/BgkHzGZn58
 bvTfGiFMbGRJG9b10ARhbv+X/rQzECXUY8GmdwsVSaL84ovZ4/24bh4sCzx1fuatxPf3UKzKWZcJ
 tAq0kBVu63nBwwZXzIotYiHIi62lOB0qPozu2Dg4SxtGBZpoACu71SXaH/drTtMjBQOPvCnVgXNz
 s=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Richard,

December 6, 2024 at 8:42 PM, "Richard Henderson" wrote:
> On 12/6/24 13:02, Pierrick Bouvier wrote:
> > On 12/6/24 00:42, Julian Ganz wrote:
> > > IIUC qemu will schedule interrupts "opportunistically" between tb
> > >  executions. If that's the case we'll observe interrupts exclusivel=
y
> > >  after the last instruction in a tb. That strikes me as a serious
> > >  limitation.
> > >=20
>=20>  To reuse fancy vocabulary, maybe we should have a distinction betw=
een inferable > interruptions (interrupt instruction) and uninferable int=
errupts, triggered by an external > event.
> >  In the latter, it *might* be acceptable to not provide a from_pc (le=
t's say a value 0), > because there is no useful information in itself, e=
xcept creating random edges in the > control flow graph, which we don't w=
ant to do.
> >  What do you think of it?
> >=20
>=20I think you both are over-complicating things.
>=20
>=20Always, env->pc (or whatever) within cc->cpu_exec_interrupt *is* wher=
e the interrupt is recognized, and *is* where the discontinuity occurs. R=
eport that.

Glad to hear. This means what I na=C3=AFvely did for most targets should =
be
correct at least in this regard.

Regards,
Julian

