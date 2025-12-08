Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E4BD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 12:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSabH-0005qU-DD; Mon, 08 Dec 2025 07:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vSab9-0005qD-SI
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:44:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vSab7-0002Fa-MY
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765197847; x=1765802647; i=laurent@vivier.eu;
 bh=OCd7Kd/X2kOUP0jgMfLVh6fUB/oPZmkH1O8TEC4YNiQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WVRvtDDiryXPr/jNr7EZN8Aqr+VEbWRfzY81YkOjzkj0uXs/2ZjpZPLWj3xdejW3
 tlSpSLxK0Tsn1Xb9yCHp38zLmhMEbdSxWnHQMGWzkMLS0Ah3kiF2+JT9eDJmFYwPM
 3oLzqUyYZXGb88N5NSPeBSwoSqgfXsFMsdbFMQTWAyazOIVoALLeyz+SJZGx91pcE
 hHip4ZlR7fJwyfcz5N0yilZg10gYB1y58it1UXy1iVfeDXVb4/svsXIwUN4MtbIom
 uzwGb0mdchu19S3Zu4uz62QljgCJ8VL9faZ/2mREVaPOSDgBH/+EvV1cmDQyNTBca
 0vGaND1R2gPjHpkp8w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mi2eP-1vxXl82qqv-00cW4C; Mon, 08 Dec 2025 13:44:07 +0100
Message-ID: <40e6c8dc-0194-4ce7-82dd-c07547e3ccce@vivier.eu>
Date: Mon, 8 Dec 2025 13:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/m68k: add working floppy controller for q800
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
References: <20251203064336.79847-1-mhjacobson@me.com>
 <ab79a32b-24b3-418e-a2c5-6427cf174d35@ilande.co.uk>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <ab79a32b-24b3-418e-a2c5-6427cf174d35@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OF20qpeGV0Bww9RcSrcnvoRVnwpp4wABhzB5M7k0StYzJk0gjWF
 ABswK61kVh7AWDo4a3XOpc09BJo2uzLEA3Y5Xly1mCNCUVfQwj/0h2a9UAZCzZ4SV1Ze81J
 SXulyoeJa703Hd6lGtpeuyLIVADTML0cTG1Vzarl8bOCAB4etCfXn37jevKjbdahUa2TaNa
 VRk55WJ+pyUpKcmFAsllA==
UI-OutboundReport: notjunk:1;M01:P0:SLHLEro5JAg=;gQCzFuguWmQgVoJNe9wt4NnRLyv
 WD2Q/r9KLIL4r31Bv4JwT6lZhWzpnLPpTl2AAtUfF63Obp6h7JepvfTbGSS+43raqm4y7c5R+
 sJWmZnm5OwjNAxtvKCxdvRz9aiUxua+o2f3Acw/Okpxzq/+ydHAJy0NVeIiNL8QKTl85Z/rfh
 /2mHAp2aYWUYp14MFzFoZdRsjZQ6HZoxc/FyLyhFlXFNIhTldqNNs7TIsvBPoBOZpc8hSUMRL
 38VjLZZ8k/WbcoMpNzrxB/hTY+wowCJrMI4f3lw8Gj6NY9mpXro4pgyqFB5OXcYxK68mmzni9
 kjJir1lluYGiKfB2ntPaz/zljZByRGjdi6fLZeNfqSbUWvwcO8JT+mUm+qa4rEQa2vd3yQa8c
 82oFp9riTKyvoJn8c2cRE2yy8W38GcjEDyMCPgTH4wPmSq89Pt6WFYXweIVr3Ke0E7V1L1fMd
 2PIXA3Q62XLIcu3O3g37bCeCS0b2mpfPpiyobX30GpOS6cRD37CVd97xUxMXtg8ABzH/5Somk
 GkCk9ZBKLBQpRA7ENDDjy0b39hwQ+qec5HrJufkr/uji/Xn38uAG3rKjZ45JuxYCle1lUU2VJ
 ehZ/Tv+YkbrCrf6egQd7kqJjmHvda1Ki4Kj4mdAn1FZ5X373CU31cnklmj/dZMoHbiGDbfAFd
 UfOxNGwjL6kEc79t8fp/ham6FT+WhyJYNDn11FnYAqdK1D8w+Q7KkWnvyVVLmAbGlvFHzzIi1
 5y3YhoTXKPfnHQdCSu+L5CxRNAtgE1YdDNufrF/qc+nnYHhrL0gbOsRZ0tHDixXCOiXsAUO3K
 HtysekOWlw3vGjEPS1zvUb7XqzZ02cYYMlGlw+W2ZGk4nGuIyzo9OMv/EGj19u0TmIqw6qDKO
 /XXs9uYykOSsEHRYwB31QqVGlKndaYkXFbWb782iPLd8S61PbZC5/+Uleol5ORocPE9RPbVwe
 JG0Se9JirH6hd1n2wjQh/9E1GLebb8k5lFlnNVAVYL7qdhX9ANaz4xJeo7V772IvhLc3azrKP
 BiI0k28aLz1dOtmmywc/3PypKkYXP6zOynAhET5Rq0UbhcTWk/EAxhKNBsOUfkfNB/4/sN5mA
 MmE94GyQG6s9yS0MikpiM2QLQ5Q28/JOBw1XoCveQnwI12J0rbke5Qfmx0miOeBGbswtnKpjU
 7jCEsC6Lnuc6o5XnGISBoIyJ4pv6UIABvz4/c9w/S3N+Mygo3MG4GcTbKY+9vhTXJRzlWZbWA
 MYZ6dmzCQcLtiZ+RVU91ZQm/rBNJ0dC8ufWrHtGdah4pRi6+bS5G/EhiM8wQpKViv6/kca2yG
 Ur7/Kz63//OgW6eNIT/A9EO2V/gD7CuL09DKTpNI+nwAxAAq9ksLmLnqRU0+Yhkb8bpMOukqF
 k+YWZc/lHTeY/mskvbpRIn/4+xuPJEnpaVYAuivyDQlSXMT5HZVgkuul49HQ6zIPiyTcAff1o
 8tpZmdNHNpQw5wIVhK0lcu08guNCaYWcIKm7oieFPuvJNSY9QzhX2R9JyzWg4FiGxam1B5/c3
 kWtBbzj6dKLNtMw/n0B2dajfikXM7zQEBL9Te6g6viZ/73WLPdUdvLZiwM39XpxfYtFCbLM80
 3p/XrecumP2TMEb+icp6et4Vioq/bZ6PQbeFqqRHfm+OFNAZVEkFT6o/JWe3/ej/vklOBUUVT
 nZ+u8Q9CuQe6iBjWLxSXA0NjB4iZgBbuwfHToqYMcQs9k7e4J7CykxGn08Rgo/2Lf7F78xLpb
 SKKffmkuYw/HNTI2Flk4GlJLv8nkgbQXnwmLbw1Gy1sl2+YURE36zWoY=
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 05/12/2025 =C3=A0 22:20, Mark Cave-Ayland a =C3=A9crit=C2=A0:
> On 03/12/2025 06:43, Matt Jacobson wrote:
>=20
>> [Please notify me of any process errors -- this is my first contributio=
n to
>> QEMU.=C2=A0 Thanks.]
>>
>> Implement the SWIM2 floppy controller for the q800 machine.
>> (For details, see: <https://archive.org/details/SWIMDesignDocs/SWIM2%20=
ERS/>.)
>>
>> Reading and writing work, and booting from a system disk works.
>> Tested with the Quadra 800 ROM and System 7.
>>
>> Future areas of work here could include:
>>
>> * Allowing for disk formatting/duplication to work
>> * Fleshing out the SWIM1 and hooking it up to the emulated drive
>> * Implementing the IWM for earlier machines (this could share code with=
 SWIM1)
>>
>> Matt Jacobson (1):
>> =C2=A0=C2=A0 hw/m68k: add working floppy controller for q800
>>
>> =C2=A0 hw/block/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 hw/block/sony_superdrive.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 940 +++++++++++++++++++++++++++++
>> =C2=A0 hw/block/swim2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 657 +++++++=
+++++++++++++
>> =C2=A0 hw/block/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +
>> =C2=A0 hw/m68k/q800.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>> =C2=A0 include/hw/block/sony_superdrive.h |=C2=A0 55 ++
>> =C2=A0 include/hw/block/swim2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66 ++
>> =C2=A0 include/hw/m68k/q800.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 8 files changed, 1740 insertions(+), 5 deletions(-)
>> =C2=A0 create mode 100644 hw/block/sony_superdrive.c
>> =C2=A0 create mode 100644 hw/block/swim2.c
>> =C2=A0 create mode 100644 include/hw/block/sony_superdrive.h
>> =C2=A0 create mode 100644 include/hw/block/swim2.h
>=20
> Thanks for the contribution! I've applied this patch and managed to get =
it to compile successfully,=20
> but I'm struggling to find a suitable disk image that works. Can you poi=
nt me towards both a GCR and=20
> an MFM image I can use for testing? I think this might be because the im=
ages I use here are simply=20
> HFS(+) images.

Perhaps you can try:
https://sourceforge.net/projects/emile/files/emile-rescue/emile-rescue-0.1=
2/

There was a time when the kernel and a ramdisk could fit on an 1.44 MB dis=
k...

> Some initial thoughts from looking over the code:
>=20
> - The basic implementation looks fairly good from what I can see, but I =
can see a number of places=20
> that don't match our code style guidelines. You can do a basic style che=
ck running "./scripts/=20
> checkpatch.pl HEAD~1..HEAD" from a git checkout with your patch applied =
which will pick up the=20
> majority of issues.
>=20
> - Having everything in one patch makes it harder to review: I think it w=
ould make sense to introduce=20
> the SONY drive in one patch, the updated SWIM2 controller in another, an=
d then a final patch to=20
> update the q800 machine to switch over the SWIM2. And maybe even an extr=
a patch to remove the=20
> existing SWIM1 stub? The stub was added with just enough implemented to =
allow Linux to boot.
>=20
> - Have you tested with an A/UX 3.0.1 boot floppy? A number of people are=
 interested to run AUX 3.0.1=20
> as per https://www.emaculation.com/doku.php/m68k-qemu-on-windows#running=
_qemu-system-=20
> m68k_with_a_ux_3x_guests_in_windows and it would be good to be able to u=
se the real floppy image here.
>=20
> - QEMU already has a fairly good Fifo8 implementation: is it possible to=
 use that or Fifo32 instead=20
> of reinventing it here?
>=20
> - It's worth updating the cover letter to include an example command lin=
e. I had to go digging into=20
> the patch to discover that I needed to add something like "-drive file=
=3D/tmp/=20
> Install.img,if=3Dnone,id=3Dfloppy" to attempt a floppy boot. Configuring=
 internal devices can be fiddly:=20
> I'm wondering if there is existing precedent in the way PC floppy drives=
 work that we can use to=20
> keep things consistent?
>=20
> - When booting a test Linux image I got stuck in a boot loop, both with =
and without a floppy=20
> inserted in the drive:
>=20
> swim2_mmio_read addr=3D0x1e00 size=3D1 reg=3D7 [HANDSHAKE] value=3D0x8 m=
ode=3D0xca setup=3D0x28 phase=3D0x74 fifo=3D0
> swim2_mmio_read addr=3D0x1e00 size=3D1 reg=3D7 [HANDSHAKE] value=3D0x8 m=
ode=3D0xca setup=3D0x28 phase=3D0x74 fifo=3D0
> ...
> ...
>=20
> Since the Linux maintainers make use of QEMU for testing, I think we nee=
d to get this working.=20
> Laurent - do you know if the 68K Mac kernel driver works on real hardwar=
e?

Well, I wrote it, and didn't test for a while.

It only supports read access. I wrote it to be able to boot linux from a f=
loppy and allow the kernel=20
to read initrd from another.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/block/swim.c

Thanks,
Laurent

