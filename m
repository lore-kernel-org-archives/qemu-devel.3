Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91D7C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhc3V-0008DT-1W; Tue, 05 Mar 2024 16:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rhc3P-0008Cb-RZ; Tue, 05 Mar 2024 16:10:28 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1rhc3M-0007nQ-Qj; Tue, 05 Mar 2024 16:10:27 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id BAEFAA05F2;
 Tue,  5 Mar 2024 22:10:19 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id ZBwWOZoPIht6; Tue,  5 Mar 2024 22:10:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 41566A06E0;
 Tue,  5 Mar 2024 22:10:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 41566A06E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709673018;
 bh=XBjsdGyNVybnDL3wiGl2pO0JAxHdvVjEyRQhNTwnuxM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=MfaWOMWfMuo9/nyOlvUtuscm0PpPLjAcD3NvxCOR2oIeeDnNojpnb/3TLBiSHTlmT
 pCSgCDiDKsrJzZ4cIfJaG87kcxbVi/DnLoNsvEK2/OW8vN0HsDJqo6dn0adHVmDn5z
 LaEJwLHnuZ8IMpYeCPWnbYnzKK70hGe8VgCH+GAs=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id mlaoc7-txKBg; Tue,  5 Mar 2024 22:10:18 +0100 (CET)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy3.enst.fr (Postfix) with ESMTP id D9130A05F2;
 Tue,  5 Mar 2024 22:10:17 +0100 (CET)
Date: Tue, 5 Mar 2024 22:10:15 +0100 (CET)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: peter maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Message-ID: <266035206.1369214.1709673015960.JavaMail.zimbra@enst.fr>
In-Reply-To: <CAFEAcA9cW0W8pcD6-HBrF2V9t1ewvAR+bB5+khSrWT5-gcxUcQ@mail.gmail.com>
References: <20240224105417.195674-1-ines.varhol@telecom-paris.fr>
 <CAFEAcA9cW0W8pcD6-HBrF2V9t1ewvAR+bB5+khSrWT5-gcxUcQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add device STM32L4x5 GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:80.125.0.74]
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF123 (Linux)/9.0.0_GA_4597)
Thread-Topic: Add device STM32L4x5 GPIO
Thread-Index: 0NjsMYnvrFNIaPyyjAkgrN0dkn4BEw==
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ivarhol-21@enst.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Le 5 Mar 24, =C3=A0 17:10, peter maydell peter.maydell@linaro.org a =C3=A9c=
rit :

> On Sat, 24 Feb 2024 at 10:54, In=C3=A8s Varhol <ines.varhol@telecom-paris=
.fr> wrote:
>>
>> This patch adds a new device STM32L4x5 GPIO device and is part
>> of a series implementing the STM32L4x5 with a few peripherals.
>=20
> Hi -- I think this patchset is basically good to go, but it
> didn't quite apply cleanly on top of the RCC v6 patchset.
> If you could rebase it on current head-of-git (where the RCC
> device has just landed) and send it out within the next few
> days then we should be able to get it into the 9.0 release.
> (Softfreeze is 12 Mar, and patches need to be in pullrequests
> by then, so the patch needs to get on the list a little before
> softfreeze.) Otherwise we'll be able to put it in for 9.1.
>=20
> thanks
> -- PMM

Thank you for the information, I just sent a new version based on master.

Ines

