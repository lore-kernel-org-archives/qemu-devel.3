Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D466CE63F21
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 02:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vroF5-0005r7-Jt; Sun, 15 Feb 2026 21:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vroF2-0005qz-KN
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 21:21:40 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vroF0-0002px-LE
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 21:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771208490; x=1771813290; i=deller@gmx.de;
 bh=nHQxijp6IOrrdb8UEKg8lkS2A+dBv5D3yE9z1KAEAv0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=c2vlZobj3mzj5pGjXF7sdqi+hr1WQuLNT5ORsH64mZL1bI678m8cOBTXiQIQb3/T
 skCr80FelIBPyubtxEp23qIeYPY7Lrta8CEJYscTqj6oxu4OzW6x56FHEwEyuM3Yu
 RY1xBIlLQWcXxhLDRpAVzFCxATKaOFKqXHG2+0bldx2rsu8ZMzDOwoRORyKxfDjxu
 YGEPwd5nfdCSSZaqt1mN7Dsx8KWjbthdyLOLq2ogFaMcLRf+APSfAJG+WPudUJPvh
 yZ+vjzGGRthjH3Lnt73DlpncrGgD42maQ/6h6J3LTaa1lZ6EzTUmMPeM6qHpkPlfz
 CYSh6GEmsO2ELCzq3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.52]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1vn7972Y2V-00G8L6; Mon, 16
 Feb 2026 03:21:30 +0100
Message-ID: <52f5c3e9-e54c-4301-848a-1c134953c542@gmx.de>
Date: Mon, 16 Feb 2026 03:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
 <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
 <93c80b9e-7eb9-45f2-bdd7-a769e2935ba1@gmx.de>
 <CAJSP0QU7TJ5Y2gAy=ipk4=7hrqejifJJ8YcDz2LsbiQbWL5Kig@mail.gmail.com>
 <5befbced-8aaa-46e2-8875-88d681854aee@gmx.de>
 <CAJSP0QUwP1L5YQH=_u5AFS++iQXZFK8r9H6xkg5KAHoJa0evsw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QUwP1L5YQH=_u5AFS++iQXZFK8r9H6xkg5KAHoJa0evsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iz1xIhmy+yijJ3cLXbjewWVxYZvR8Qcs214QgcVIC3SJX2efPp4
 hDFw9rgWpV5Sl2Iad8LsJ1AhXvV0So8GVz0RlCL5IVXc9NCGicguibadwtdQIcwvUAKSvP+
 JLfgM3YPNZPNraduaap4GVVR6eqc8UezRSCub3zDHzQdF301I1HuRQF4tdBY2KReWRLADdX
 SefX1ycRKVaJL6OKz6wVQ==
UI-OutboundReport: notjunk:1;M01:P0:SUy4sHA1MnY=;jbUKtopdr4k2nceLyh6ocd26px2
 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
 w1wPX9GYuu8WLRYEdLPUwvRFVYk23
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/15/26 21:31, Stefan Hajnoczi wrote:
> On Sun, Feb 15, 2026 at 1:25=E2=80=AFPM Helge Deller <deller@gmx.de> wro=
te:
>>
>> Hi Stefan,
>>
>> On 2/10/26 19:23, Stefan Hajnoczi wrote:
>>> You can still propose an idea before February 19th.
>>>
>>> The Linux scsi_debug driver has support for emulating a tape device,
>>> so that may already be usable with QEMU but I'm not sure.
>>
>> It is interesting, but it is only available with Linux hosts,
>> and doesn't seem to handle existing TAPE files or can be
>> used to permanently store things (e.g. it handles everything in RAM).
>>
>>> If you have a use case for SCSI tape emulation in QEMU then it sounds
>>> like something that would fit GSoC.
>>
>> Here is my proposal.
>> I hope this is OK?
>=20
> Thanks, Helge. I have added your project idea to the wiki and edited it:
> https://wiki.qemu.org/Google_Summer_of_Code_2026#SCSI_TAPE_device_emulat=
ion

Great, Thanks!
 =20
> The intern needs to research the project idea and come up with a
> design before the coding period starts. You can make this easier by
> specifying more of the design so the intern has less to figure out. I
> think your project description contains enough pointers so that a
> motivated applicant can discuss the details with you during the GSoC
> application phase.

Ok.

> Two pieces of information that could help focus this project:
> 1. Do you have any tape data files for reference that you want QEMU to
> be able to access?
> 2. Do you have a particular guest OS in mind?

My current goal is to allow emulating MPE (an old operating system
on the hppa architecture). This OS is installed via an install tape,
which I may provide to the applicant for testing.
But I think for this project it's sufficient if the applicant uses
standard operating system tools to backup the current system, e.g.
mt or baccula on Linux, and something else on Windows....
I'll add that info to the Wiki.

Helge

