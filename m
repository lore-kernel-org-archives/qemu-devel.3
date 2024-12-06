Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTue-000846-RP; Fri, 06 Dec 2024 03:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJTud-00081n-4I
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:42:11 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJTub-0001Vf-1E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:42:10 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 2268F1814C8
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2024 09:42:06 +0100 (CET)
Received: (qmail 28677 invoked by uid 990); 6 Dec 2024 08:42:06 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 06 Dec 2024 09:42:05 +0100
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 08:42:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.499932) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.099932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=/VAl0p2o5RuRA+Dq3JgaMsutRVu8kwOsZc4LvSuJWvo=;
 b=lqxawnjNvqJuh76BwhT6aatwUO/xfqr1/+8AKBM7gvzauksjTQiVUxS1hsuYSpkW3txRSMkpcc
 QV93gXmBZl86wsJCOOwnvaqymFMMdgRWhgHop7U/gtA6D6B2jEkhB64fpEHFTiRPailjT7CbkgYm
 3p3S4rGCcy+2P0DroopBPRMexsUP1STwoYcgInCK9hHM0ROFXrOMviTsKm0ADNMWnmRInjYKUMb2
 ngn92URMjiuEjty7UWDurpX+y3ZWsZYmXC5AcFlRCiLfKe81zaem980wDziO+rUgK/uI4ki+xz4d
 CItn21dToQiFlF35301tyus9VfOLVdeIVvg2ydAl44fZMvjt2GMvll7pHEIPGTV9zJUYy6IW3eWv
 Xx4rv3WvqH0Hvq6+a2ZSM8YZU1dMqUpAszCkb5zzsv43+5a6n72KEucDPjhI1z663+4F3uHFmFiO
 o8DvpwPjCBE9e7TetSWRmOadOfi2+LXoGa4QCnVH9BFopLH0z6S8Zkzdmf849YaoYFiGH8vwg84e
 GyM7X0Xj+ajtmgGChEbEmcv2knQh3TdHAxpg1xctc/CGEoz/jzir6tFUv+X4YjDyJEhWvRyG8Ech
 5jWeC7Cv5qr+hC5GjLfTSwdp3i1KmO12bzx+Cqz8qf98OaZ6lROdoVL1O/i1JXoDGfoCiKYJSzcE
 s=
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

December 5, 2024 at 11:28 PM, "Pierrick Bouvier" wrote:
> On 12/5/24 13:22, Julian Ganz wrote:
> >  December 5, 2024 at 6:30 PM, "Pierrick Bouvier" wrote:
> > > We can store the next_expected pc for each instruction (from curren=
t_instruction + insn_length), and we should be able to compare that with =
the expected from_pc.
> > >  This is mostly what contrib/plugins/cflow.c does.
> > >=20
>=20> >  With that, we can test from_pc.
> > >=20
>=20>  I'm not confident that this will work reliably for branch, jump an=
d
> >  other "interesting" instructions. But I can have a closer look at th=
e
> >  cflow plugin and try to figure out how that plugin handles those cas=
es.
> >=20
>=20It won't work for latest instructions in a tb (because we don't know =
what will be the next one), but should be good for all the others cases.

IIUC qemu will schedule interrupts "opportunistically" between tb
executions. If that's the case we'll observe interrupts exclusively
after the last instruction in a tb. That strikes me as a serious
limitation.

Regards,
Julian Ganz

