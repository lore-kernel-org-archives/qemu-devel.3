Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00569D2595C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 08:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vke65-00029P-5o; Tue, 27 Jan 2026 03:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vke61-000264-0c
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 03:06:45 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vke5y-0005IY-Gm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 03:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769501197; x=1770105997; i=deller@gmx.de;
 bh=mt4MfRoEPpw6/7P6jDEzIOeyOo1xtBNXe82hXHj7fRc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EviSxn24Kwa1fhD3fze6hBa72fSRwPFV4gPksysOWDXH3GDM40vxVLb8kW79V8Ia
 I4eWreU33OUwNJGjsvjsHspxSuizVJFu/kdg7qkh5UGinGcjryZM/09HfkdN/jiBJ
 tdMhNZJXHOfExhaufw5QbdJkQE0LEx66xtPCqGVS5LHPsxvKD9o1JbHMk8J35K7M1
 cuGONJcF584ZjE/gxFbifWcAgDTIMcnYtszRju71LPd1rTpgH14ku5xhm6PI+em2A
 anmSCpxyzusnTD9CqmyV459qI8nym4LsZVh2l6Nm1V6LVuFZ2f/e/S9L+QvFKYiOi
 7jPQmivQmybc9yDYmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1vfxvm0JJv-006Cym; Tue, 27
 Jan 2026 09:06:37 +0100
Message-ID: <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
Date: Tue, 27 Jan 2026 09:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
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
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TQY/DY1sTeA+YR3iI5rz9liOvUqqZAJTu948bmK9NngboTUEZUk
 wczHxSURNm9TtA1j3VUmWCujrF+309aIxF8t43RzzQOFIAr4DKz7UyQvLk3V/im5Px7Fe8i
 0jH8Q7RoTxsylWIBB6hGxOLMn5j7lOUd7476nrvN7JEegxOEj+9GhP4k7fc7xX4ymSrQi5o
 75TpZT5fUrMTz5CQlKJmQ==
UI-OutboundReport: notjunk:1;M01:P0:DWEen8WLr3Y=;dgbSCJ2FHKg26wmAZvRbE+ofRPN
 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
 V5LtwJAgmcs5zG5o9nPk2RGnqBqh+QvUUw/ZvR
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On 1/26/26 23:29, Stefan Hajnoczi wrote:
> On Fri, Jan 23, 2026 at 3:44=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>> Hi
>>
>> On Thu, Jan 22, 2026 at 7:46=E2=80=AFPM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> On 1/22/26 3:28 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>> Hi
>>>>
>>>> On Thu, Jan 22, 2026 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
>>>>>
>>>>> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
>>>>>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
>>>>>>> Once we have written some scripts that can build gcc, binutils, li=
nux,
>>>>>>> busybox we've opened the door to be able to support every machine =
type
>>>>>>> on every target, provided there has been a gcc/binutils/linux port=
 at
>>>>>>> some time (which covers practically everything). Adding new machin=
es
>>>>>>> becomes cheap then - just a matter of identifying the Linux Kconfi=
g
>>>>>>> settings, and everything else stays the same. Adding new targets m=
eans
>>>>>>> adding a new binutils build target, which should again we relative=
ly
>>>>>>> cheap, and also infrequent. This has potential to be massively mor=
e
>>>>>>> sustainable than a reliance on distros, and should put us on a pat=
hway
>>>>>>> that would let us cover almost everything we ship.
>>>>>>
>>>>>> Isn't that essentially reimplementing half of buildroot, or the
>>>>>> system image builder that Rob Landley uses to produce toybox
>>>>>> test images ?
>>>>>
>>>>> If we can use existing tools to achieve this, that's fine.
>>>>>
>>>>
>>>> Imho, both approaches are complementary. Building images from scratch=
,
>>>> like toybox, to cover esoteric minimal systems. And more complete and
>>>> common OSes with mkosi which allows you to have things like python,
>>>> mesa, networking, systemd, tpm tools, etc for testing.. We don't want
>>>> to build that from scratch, do we?
>>>>
>>>
>>> I ran into this need recently, and simply used podman (or docker) for
>>> this purpose.
>>>
>>> $ podman build -t rootfs - < Dockerfile
>>> $ container=3D$(podman create rootfs)
>>> $ podman export -o /dev/stdout $container |
>>> /sbin/mke2fs -t ext4 -d - out.ext4 10g
>>> $ podman rm -f $container
>>>
>>> It allows to create image for any distro (used it for alpine and
>>> debian), as long as they publish a docker container. As well, it gives
>>> flexibility to have a custom init, skipping a lengthy emulated boot wi=
th
>>> a full system. As a bonus, it's quick to build, and does not require
>>> recompiling the world to get something.
>>>
>>> You can debug things too by running the container on your host machine=
,
>>> which is convenient.
>>>
>>
>> Very nice! I didn't realize you could export and reuse a container that=
 way.
>>
>> I wonder how this workflow can be extended and compare to mkosi
>> (beside the limitation to produce tar/fs image)
>>
>> For qemu VM testing, it would fit better along with our Dockerfile &
>> lcitool usage.
>>
>> I wish a tool would help to (cross) create & boot such (reproducible)
>> images & vm easily.
>=20
> Hi Marc-Andr=C3=A9,
> I would like to submit QEMU's GSoC application in the next day or two.
> A minimum of 4 project ideas is mentioned in the latest guidelines
> from Google and we're currently at 3 ideas.=20
Stefan, I can provide another project, if needed.
I was struggling if I should make it a GSOC project, or just do it myself =
when
I find time somewhen. My main concern why I did not yet brought it up yet,=
 is
that I think it's so specific that it will be hard to find a good candidat=
e.
It's about adding a new machine type to the hppa/parisc
architecture to allow running the historic "MPE" operating system [1].
I have prepared some wording for the project already, but am still waiting
for some feedback from some contacts I have.
So, if you need another project, I can provide one... :-)

Helge
[1] https://en.wikipedia.org/wiki/HP_Multi-Programming_Executive

