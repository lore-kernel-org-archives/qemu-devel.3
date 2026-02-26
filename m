Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED456FC5935
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZio-0005ww-1k; Thu, 26 Feb 2026 06:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vvZil-0005wd-P8; Thu, 26 Feb 2026 06:39:55 -0500
Received: from mailcow.dlhnet.de ([2a01:b1c0::44ca:22ff:fe9b:798c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vvZij-0001lR-It; Thu, 26 Feb 2026 06:39:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0AD3546ACE9; Thu, 26 Feb 2026 12:39:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlhnet.de; s=dkim;
 t=1772105980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BYii1giY01zqkKFhniadKeEnHWieRiossP9rcaQ0Zbg=;
 b=ZyvstNYDTmnHgDFtvOcwzc+KvbOYqwLaSRBa4XVFszXbOAMQDcQiNRyINa2BgsWUGsj7OT
 4vkP1FH1lHOlZnYICAgAuDGXZGTAVuYtVQutQnLy0AnawnLydjPxmrhmGr45wzUdZXv4Np
 71Zpdevp8CVyBtfTilPrlWJ6/+eZpEHKcyBjci7B1ReSyEnlPVNydwjUcRrUv6iBugMRdi
 I2TIpaUFA057JbxgKTmQrkbIRnuPInQhZhP+OdrQZVgSSSkxJSErUVkbY0hUG6g6tIHET4
 OhSLqcvKS4nqDQEcbo/T4yIrQ7hesGD9WuUEYztKIFd2ylY7YkDoWKJ3grK+cw==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: block/nfs.c and libnfs vs Fedora 43 (was: Re: [PULL v2 00/19]
 Python patches)
From: Peter Lieven <pl@dlhnet.de>
In-Reply-To: <aaArdNcA8Iq9DrBA@redhat.com>
Date: Thu, 26 Feb 2026 12:39:28 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CD4D8E7-54EA-4A69-97E0-9FB693FE0CFF@dlhnet.de>
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
 <aaArdNcA8Iq9DrBA@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Last-TLS-Session-Version: TLSv1.2
Received-SPF: pass client-ip=2a01:b1c0::44ca:22ff:fe9b:798c;
 envelope-from=pl@dlhnet.de; helo=mailcow.dlhnet.de
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



> Am 26.02.2026 um 12:16 schrieb Daniel P. Berrang=C3=A9 =
<berrange@redhat.com>:
>=20
> On Thu, Feb 26, 2026 at 10:44:58AM +0000, Peter Maydell wrote:
>> On Tue, 24 Feb 2026 at 18:14, John Snow <jsnow@redhat.com> wrote:
>>>=20
>>> The following changes since commit =
afe653676dc6dfd49f0390239ff90b2f0052c2b8:
>>>=20
>>>  Merge tag 'audio-pull-request' of =
https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 =
14:03:50 +0000)
>>>=20
>>> are available in the Git repository at:
>>>=20
>>>  https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>>>=20
>>> for you to fetch changes up to =
4e55bb4be53bc7a5e3fe1429af12d2e3090049a5:
>>>=20
>>>  python: add setuptools and wheel dependencies (2026-02-24 13:11:29 =
-0500)
>>>=20
>>> ----------------------------------------------------------------
>>>=20
>>> ----------------------------------------------------------------
>>=20
>> Hi -- it looks like this pullreq may have broken the "coverity" job
>> that (run on a separate schedule from main CI) does a QEMU build to
>> upload to the coverity scan service:
>>=20
>> https://gitlab.com/qemu-project/qemu/-/jobs/13264087007
>>=20
>> It fails during QEMU configure:
>>=20
>> Dependency libnfs found: NO. Found 16.2.0 but need: '<6.0.0' ;
>> matched: '>=3D1.9.3'
>> Run-time dependency libnfs found: NO
>> ../meson.build:1150:11: ERROR: Dependency lookup for libnfs with
>> method 'pkgconfig' failed: Invalid version, need 'libnfs' ['<6.0.0']
>> found '16.2.0'.
>>=20
>> I'm guessing this is because:
>> * the coverity job runs on the amd64-fedora-container
>> * we just upgraded our Fedora container to F43
>> * coverity configures with --enable-libnfs
>=20
> Do we really need to be hardcoding configure options ?
>=20
> It is a pretty random subset of options, compared to what gets
> enabled in the build.
>=20
> Originally we had the hand-built Dockerfile, but now nearly all
> our dockerfiles are auto-generated by lcitool, so we get the full
> set of QEMU deps on every distro.=20
>=20
> There is a risk that we break a meson/configure chck somewhere,
> but IMHO that's not something our coverity needs to be validating
> directly. If that happens and we later fix it, coverity would
> pick up any flaws that weere introduced in the window it was
> broken.
>=20
>> * in meson.build we enforce libnfs < 6.0.0
>> * F43 ships with a newer libnfs
>>=20
>> The "not libnfs v6" restriction was added by thuth in
>> commit e2d98f257138 in 2024 because of a big API change in
>> libnfs v6. The theory was that this was a temporary hack
>> until somebody updated block/nfs.c to handle the new API.
>> Over a year later, nobody has touched block/nfs.c...
>>=20
>> I guess for the moment we should fix the Coverity build
>> by dropping the --enable-libnfs (and accepting that we
>> don't scan block/nfs.c any more). For the longer term:
>>=20
>> * does anybody want to update block/nfs.c ?
>> * or should we mark it as deprecated and plan to eventually
>>   drop it, given that the set of supported distros you can
>>   build it on is rapidly shrinking ?
>=20
> MAINTAINERS file marks it as "maintained" but given the ongoing
> brokeness that feels outdated :-(
>=20
> In Fedora we've been carrying a patch to QEMU to enable libnfs
> v6.
>=20
>  =
https://src.fedoraproject.org/rpms/qemu/blob/rawhide/f/0002-nfs-Add-suppor=
t-for-libnfs-v2-api.patch
>  =
https://src.fedoraproject.org/rpms/qemu/blob/rawhide/f/0008-Revert-meson.b=
uild-Disallow-libnfs-v6-to-fix-the-bro.patch

Sorry, I was not aware of any build problems so far and as I wrote Peter =
earlier I was some time out of Qemu development, but that changed =
recently.

Is there a reason why Ronnie=E2=80=99s patch never went upstream? =
Surely, it was incomplete without the fix in the build scripts.

I do not see any issue with both patches. If there are issues at all I =
would suspect a problem introduced in libnfs v6.

In general I found nfs in userspace really useful especially if it is =
only used for ISOs or qemu-img jobs.

A broken NFS server mounted in the host can easily bring down a lot of =
things including a VM that has a ISO mounted from it.

Peter=

