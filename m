Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C06EEB2714
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuZn-00009n-0P; Tue, 10 Feb 2026 15:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpuZm-00009b-9r
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:43:14 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpuZk-0005K3-EM
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770756190; x=1771360990; i=deller@gmx.de;
 bh=ApWtnawqsReUfHnrkz6coIjJ+o8bNGNwENwpPTHzKHs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hIxV0T4CpYbGnPDe0rvpEGEOTIGNEBXloOQ55tzEHkD8gLRU6mKP5d2Ac4K44eYV
 l6d0DhqhtxWLVcicHm68xfLG8F53w4EaaCuteptm4z4oe9cxBU1wu2u297d7OGM0G
 3OyKRHtvOj7ol2PFeXQCPcWS0CuewXF4mWQrYSpwRre0GCiqJOirc/onoHKsON8gy
 OyTk/f230boRBTyE7x4Aw3luOj69HF0z6TpqccoIFe4gsdVFKOtQatdYcHeADeiJL
 y+xgJfTUFETnowlhiFX95xh2hl31kQ0vh/4TSE00pKFcKzFoochWdT4d8cxUwXd+q
 bwP+UKcooc5/mZLsmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1wKFP22TGk-00PEo1; Tue, 10
 Feb 2026 21:43:10 +0100
Message-ID: <983e2a1f-ffbd-4033-bb50-49dc33b57fc1@gmx.de>
Date: Tue, 10 Feb 2026 21:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
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
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QU7TJ5Y2gAy=ipk4=7hrqejifJJ8YcDz2LsbiQbWL5Kig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zv9qa5Rm43rG+ToeYZhrwuTAVRf5LN6qY1H3pbtZOH8ibiuIHJp
 5gQrJTDjynsDVeJrm7wah3RiWPgm3afxi9j6m2h22gmxWfEDXrjwxPU1PjEkU8vidNNBYTc
 R0bM/3qFlLur5ZGHquqGvGndGfht7ZYoEo1KGkfJVfSLw03INxOzOWHdeBx4Da+W/x/N5Bh
 3W0WXko4Dj7JHBux55GZA==
UI-OutboundReport: notjunk:1;M01:P0:U+ktU+f7m6E=;uJfR23rY+wcPIipHyMKiEvbxZvP
 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
 wNnSt5Xbw5LhvYGpk=
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

On 2/10/26 19:23, Stefan Hajnoczi wrote:
> On Tue, Feb 10, 2026 at 12:45=E2=80=AFPM Helge Deller <deller@gmx.de> wr=
ote:
>>
>> On 1/27/26 15:18, Stefan Hajnoczi wrote:
>>> You are welcome to add the MPE project idea if you want to mentor it
>>> this summer. It's okay if you are still waiting on responses from
>>> people you are in touch with. Now that QEMU has at least 4 project
>>> ideas I can go ahead and submit the GSoC org application and you can
>>> still add your idea later.
>>
>> Is there still time (before the 19th) ?
>>
>> Instead of MPE, I wonder if there was at any time the idea to
>> add a SCSI TAPE emulation? I mean, not a pass-through driver,
>> but something which emulates a real drive, or at least the basic
>> SCSI TAPE commands. Maybe by utilizing the tape library from
>> the SIMH project?
>=20
> Hi Helge,
> You can still propose an idea before February 19th.

Great!
 =20
> The Linux scsi_debug driver has support for emulating a tape device,
> so that may already be usable with QEMU but I'm not sure.

Interesting! I will need to test it soon!
 =20
> If you have a use case for SCSI tape emulation in QEMU then it sounds
> like something that would fit GSoC.

For MPE the systems are usually installed via tape, so it would
be good to be able to specify a file with the copy of the tape
and show up as tape drive in qemu.
The scsi_debug driver might be useable for that, but it's probably
not as easy to set up like e.g. a harddisc in qemu right now. I assume
you will need root user too, so an own qemu driver might be better.
Will check....

Helge

