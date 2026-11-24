Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C93606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=GBsXan3L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVlbK-00076k-Ka; Tue, 24 Nov 2026 03:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVlbH-000741-QO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:10:03 -0500
Received: from smtpout8.mo539.mail-out.ovh.net ([51.210.91.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVlbD-0002zv-Nu
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:10:02 -0500
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4jYb7w3szVz4Dwr;
 Tue, 24 Nov 2026 08:09:48 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <aurelien@aurel32.net>; Tue, 24 Nov 2026 08:09:48 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.110])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jYb7w0Qhdz1xqZ; Tue, 24 Nov 2026 08:09:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 2D3329421AC; 
 Tue, 24 Nov 2026 08:09:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003600335fe-df3c-490b-8935-daa458e95dc3,
 8999D460E3350DC70288BFBB7677D99C31D99569) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d515161e-f382-4937-a342-4d21e16332eb@kaod.org>
Date: Tue, 24 Nov 2026 09:09:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
To: Utkarsh Verma <uverma@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5065423684397542607
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEZm84HoMj45sO/1x7YFO/ArULT2E04AS0QUOzHFkA7dYcGZyNVpVilCSAWYgem4C9ROrNfR/r3oTWHTX2cKifnCSLPpfKAqgP5V3AHJMVCP+RYrUteosKPn3w1kUz1T2GZ9ZAS602v3L1lONs3/QY175xMwAiNlKgHwDcICIJItKljq5Ia4W68XEd4+orGiKReK11WHT6ayykZkikFqzSTQ1E9aatrzyzVDCY2LiADSLizUCiSzeh8YVqmBzuDkMuymVeYNLb09SnEYVaLe8vHVfO9moJ26Q90QJciGHsyzbNArECenM0C1c6ofHM5MuGX9nmX9BEJ3VvNSlt10OmDOeOQiNibBuMXWN8ynv/preNWvbat1Bj9yk1hHwhZQcc1LjplAkw+CU2qxpc5LfZJLAZ2cf2lQsinTwwHNvQSd7zRPdZ5SHZ+qTQOhtdp8mMzq9E3DrJ0fUraE/nTBuK7eEYz2cc7bTdpbkrk79qsZocAZzr4fVRw69ftz7QTzTLsKNirWSLA6tCkL4ycm8BPSZqZfhwsWghRSNLOmwSKEjfAKxszVDeR7R0iuRS/1fTmEzdm4rF0Io13ccEr9HQ45R7GDjnuEZwcxvTmvdT2u6V4WiS4Mjd7wyiB4y9HEFbMGCEX0Ym1DvwjrK6LHq6AwrwGVLjwyRkRh2RrBNaARg
DKIM-Signature: a=rsa-sha256; bh=gejiQBEZE8DX5Y6ZwHO/I/SjRJjUQYTxsqVb5kLCkUw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795507788; v=1;
 b=GBsXan3L5qM+I7zlAi1Qy2jgpBsQk25f05FcaA+6gicRFsnQlRdqLmFvcRh1cE+b27vzxZb6
 tHOB2RmPzjYgLRIe+ylqJCXTmiLXy5x0WaWS3jPmZpWOJ3C3mGbUdT28YImCiMhFQ1ZGP2u/kiy
 mSgpmm1JOyz9D6jJ5pYXxCtrZ7NMU/ecxWQrSfhWep5idgF5dJ5WuahCjAO6ootZzeO938gQGu+
 OuQJg1lmIoXesfhsNhIHsgVxPiIK6P3GFeUojTBzwV4Mp1VsrvoUJbDl1OE9dRsTeTDB91GXZVq
 GDDbxqO5tpHxq2uIu1oc+MoN/VRM6QFsRYa29LMvuhxeQ==
Received-SPF: pass client-ip=51.210.91.47; envelope-from=clg@kaod.org;
 helo=smtpout8.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/24/26 06:59, Utkarsh Verma wrote:
> Hi Philippe,
> 
> On 11/23/26 11:02 PM, Philippe Mathieu-Daudé wrote:
>> Hi Utkarsh,
>>
>> On 23/11/26 18:14, Utkarsh Verma wrote:
>>> Hi Hervé,
>>>
>>> I wanted to check whether you are still interested in maintaining the PReP machine in QEMU.
>>>
>>> Your name is currently listed as the maintainer for PReP in the MAINTAINERS file. However, we haven't seen much recent maintenance activity for this subsystem, and I wanted to check whether you would like to continue in this role.
>>>
>>> If you are still interested, it would be great to have you continue as the maintainer. Alternatively, if you are no longer actively involved or would prefer to step down, please let us know.
>>>
>>> In the absence of a response, we are considering sending a small MAINTAINERS cleanup patch to remove your name from the entry and mark PReP as Orphan, so that the file accurately reflects its current maintenance status. This would not affect the PReP implementation or its functionality.
>>>
>>> Please let us know your preference.
>>
>> Are there any PReP patches pending review / left unattended?
>>
>> This machine works well enough, is tested; what is your issue with it?
> 
> This is more about reflecting the correct status in MAINTAINERS file as the currently listed maintainer (Hervé) have been inactive for about 3 years, although the patches are getting reviewed by other community members.

yes. That happens very often for tree wide changes. Nothing worrying.
PReP being an old and stable machine, not much is happening.

Debian still boots :


     >> =============================================================
     >> OpenBIOS 1.1 [Jun 29 2026 21:11]
     >> Configuration device id QEMU version 1 machine id 0
     >> CPUs: 0
     >> Memory: 128M
     >> UUID: 00000000-0000-0000-0000-000000000000
     >> CPU type PowerPC,604
     milliseconds isn't unique.
     Welcome to OpenBIOS v1.1 built on Jun 29 2026 21:11
     Trying hd:,\\:tbxi...
     >> Not a bootable ELF image
     >> switching to new context:
     loaded at:     04000400 04015218
     relocated to:  00800000 00814E18
     board data at: 07C9E870 07CA527C
     relocated to:  0080B130 00811B3C
     zimage at:     0400B400 0411DC98
     avail ram:     00400000 00800000
     
     Linux/PPC load: console=/dev/ttyS0,9600 console=tty0 ether=5,0x210,eth0 ether=11,0x300,eth1 ramdisk_size=8192 root=/dev/sda3
     Uncompressing Linux................................................done.
     Now booting the kernel
     
     Debian GNU/Linux 3.0 6015 ttyS0
     
     6015 login: root
     6015:~# uname -a
     Linux 6015 2.4.18 #15 Tue May 20 15:11:37 AKDT 2003 ppc unknown



Kudos to Mark for the OpenBIOS support !

  > It will be good to have someone listed in the MAINTAINERS entry for PReP who is active in the community or we should change the status to orphan, so that it encourages others to step up to maintain it.

Do you plan to step forward as a PReP reviewer ? You could start
by contributing some changes. That would be a good first step to
show your interest in QEMU support.


Thanks,

C.



