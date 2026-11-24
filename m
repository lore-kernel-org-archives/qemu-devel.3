Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205160A2625
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=EX/VD4SW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVm71-0004SX-6a; Tue, 24 Nov 2026 03:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVm6v-0004SE-LZ; Tue, 24 Nov 2026 03:42:45 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVm6s-0003uG-Vl; Tue, 24 Nov 2026 03:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795509752; bh=XYX9M0TzCt4X18d+w5dAa3dhbYVXE4LDZXm7ZrxhhMc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EX/VD4SWatIYZui1+0H+CTOhqMsnvmUfGViWRFFhJ1ETjCHHIUkSWN6qVLhGKENjA
 qJX8JbW7s7NoZU2SCo4/NuvyMl6peW+5GzVhu0em+tavXoJFwbJcgKmaOCXk2kSDy0
 btV8zyDt4INHlKorLlRWFSEkAK9BOWihl04oXyME=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 02471203B0;
 Tue, 24 Nov 2026 09:42:29 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4983F21E6A04; Tue, 24 Nov 2026 09:42:38 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Utkarsh Verma <uverma@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  qemu-ppc@nongnu.org,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Thomas Huth <huth@tuxfamily.org>,  Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,  Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Chinmay Rath <rathc@linux.ibm.com>,  Amit Machhiwal
 <amachhiw@linux.ibm.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
In-Reply-To: <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com> (Utkarsh
 Verma's message of "Tue, 24 Nov 2026 11:29:38 +0530")
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
Date: Tue, 24 Nov 2026 09:42:38 +0100
Message-ID: <87mrqyhb7l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Utkarsh Verma <uverma@linux.ibm.com> writes:

> Hi Philippe,
>
> On 11/23/26 11:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Utkarsh,
>> On 23/11/26 18:14, Utkarsh Verma wrote:
>>> Hi Herv=C3=A9,
>>>
>>> I wanted to check whether you are still interested in maintaining the P=
ReP machine in QEMU.
>>>
>>> Your name is currently listed as the maintainer for PReP in the MAINTAI=
NERS file. However, we haven't seen much recent maintenance activity for th=
is subsystem, and I wanted to check whether you would like to continue in t=
his role.
>>>
>>> If you are still interested, it would be great to have you continue as =
the maintainer. Alternatively, if you are no longer actively involved or wo=
uld prefer to step down, please let us know.
>>>
>>> In the absence of a response, we are considering sending a small MAINTA=
INERS cleanup patch to remove your name from the entry and mark PReP as Orp=
han, so that the file accurately reflects its current maintenance status. T=
his would not affect the PReP implementation or its functionality.
>>>
>>> Please let us know your preference.
>>
>> Are there any PReP patches pending review / left unattended?
>>
>> This machine works well enough, is tested; what is your issue with it?
>
> This is more about reflecting the correct status in MAINTAINERS file as t=
he currently listed maintainer (Herv=C3=A9) have been inactive for about 3 =
years, although the patches are getting reviewed by other community members.
> It will be good to have someone listed in the MAINTAINERS entry for PReP =
who is active in the community or we should change the status to orphan, so=
 that it encourages others to step up to maintain it.

I agree.

