Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25722E63F08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 18:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrgoG-0004mG-Ll; Sun, 15 Feb 2026 13:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vrgoC-0004m6-5s
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 13:25:28 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vrgo7-00072E-4U
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 13:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771179916; x=1771784716; i=deller@gmx.de;
 bh=Ilb6d/UGU5FGe08Kk0mFuApZztIUg/smf/gKx9/evBI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YGOtVWAUmjDm1hzUdvqd8TcwNLQghHVxdSHufcIGWorywaXkD4KyrPgFj09l8jvp
 ckVVzbwyTdUHfFmFBriTZj+fLZdO2M7WWYrrCdzqgWzQoK57aV3j4UiEfA8MM33JP
 +HLYRbgHxNdbiYT06Rt+7EzryTxlZA9tRei2mh2TRBWs/zP4WzaeqbfEyHw0zr+To
 d87QiuCnvNcSW0kavL/8dbwtmI5ErupVCGbM0zXviBIRfyc7h+BbiOgwsB9GVTW6s
 LSOgNfRZnJ/5cJ5Svy2y7dL48OdGT8Gc5dwpRu0dFi0TUBkoh5FQ70zYi++ihH/Po
 tsjanRGUmj/h9g6NuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.52]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1wJ0bD0olz-00NTmW; Sun, 15
 Feb 2026 19:25:16 +0100
Message-ID: <5befbced-8aaa-46e2-8875-88d681854aee@gmx.de>
Date: Sun, 15 Feb 2026 19:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
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
X-Provags-ID: V03:K1:0hhdmElUhCtia7EknSM1DFS+D6BilRrMGQtxSllDI8q/pNzhDSa
 uHZYqYKy62By+Lh0zYDtd2KidgOsj+TqLfXe6mJxJX2no9tR4+04y0d97kIq/fJK+YmhmVe
 lp9+sEzLBzI2lyp0wx8BWpPLIIr0R1fCGysmB6TgOmTE5dOgq8R87kibWqc8318S3FUfvBs
 l/HpZOeH/6//mGEmUgagw==
UI-OutboundReport: notjunk:1;M01:P0:mw7qmJvPYLk=;zOYYeNYL6xuDY8jfdZ9zPOPJv6O
 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
 zkDzcgYIYN0oYflhM=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Stefan,

On 2/10/26 19:23, Stefan Hajnoczi wrote:
> You can still propose an idea before February 19th.
>=20
> The Linux scsi_debug driver has support for emulating a tape device,
> so that may already be usable with QEMU but I'm not sure.

It is interesting, but it is only available with Linux hosts,
and doesn't seem to handle existing TAPE files or can be
used to permanently store things (e.g. it handles everything in RAM).

> If you have a use case for SCSI tape emulation in QEMU then it sounds
> like something that would fit GSoC.

Here is my proposal.
I hope this is OK?

Helge

 =20
=3D=3D=3D SCSI TAPE driver =3D=3D=3D
 =20
'''Summary:''' Development of an emulated SCSI TAPE driver
 =20
Qemu provides functionality to emulate SCSI hard discs and SCSI CD-ROM dri=
ves,
but lacks an emulated SCSI TAPE drive. Goal of this project is to develop
an emulation for a SCSI TAPE drive which is backed by a file in the
filesystem, similar to an ISO file which is used to emulate a CD-ROM drive=
.
At the beginning of this project the applicant should summarize the curren=
t
status of Qemu regarding TAPE drives, e.g. describe how to use passthrough
to physical drives, or by using the Linux kernel scsi_debug driver. There
might be other options too.
As second step the applicant should check existing code for SCSI hard disc
and CD-ROM emulation and analyze what is missing to support a SCSI TAPE
in addition. Maybe the existing code can be extended or a new driver needs=
 to
be written?
A very important step is to decide how the emulated tape data should be
stored on disc. There exists already various libraries to handle TAPE
data, e.g. the tape library from the SIMH project. It might be useful
to rely on such existing libraries than to implement everything from
scratch. The applicant should check other projects and do a proposal
for the best approach for Qemu.
As last step the participant should write code to emulate a SCSI
TAPE drive, add a testsuite to be used during build time,
and document how to use it.
Throughout this project communication with the qemu SCSI developers
on the mailing list regarding next steps is required.

  '''Links:'''
* https://en.wikipedia.org/wiki/SCSI* https://en.wikipedia.org/wiki/Tape_d=
rive
* https://sg.danny.cz/sg/p/sdebug.html
* https://superuser.com/questions/1434214/using-qemu-to-emulate-dos-with-p=
assthrough-scsi-access
* https://simh.trailing-edge.com/docs/simh_magtape.pdf
* https://github.com/simh/simtools

'''Details:'''
* Skill level: intermediate
* Knowledge of SCSI protocol is beneficial
* Language: C, Script


