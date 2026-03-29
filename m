Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B44CF3D5E9
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 06:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6jYC-0000AR-3m; Sun, 29 Mar 2026 02:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1w6jYA-00007E-CB
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 02:23:06 -0400
Received: from p-west1-cluster6-host7-snip4-9.eps.apple.com ([57.103.67.112]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1w6jY7-0006fY-Oi
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 02:23:06 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 E934E18000DB; Sun, 29 Mar 2026 06:22:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1774765380; x=1777357380; bh=Xm/nFPoP9h4XJGGtZPES7KsyIKXWVmqS+FB5kUucgf0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=XCHHcrxz3kL7Rk56UW5FWAdl6kw3pTQJR7BF7mpZwkbrCe6YNI5o6E1djdPRx/zq2jBalxGIqVgDhzDFFRG+roYfvq3NUp42bIGQtpFZkdozJHZ3L7wDkY61Sk/xNJb9d7r1TBJCuSO5M3KwLXoX/dhXsNX0D7Rbj50Lz0uJcUjpX0ZXESSg44PGvpzylZw33P0SXQueIfQwqO14ai0E11REXZXOc/oLhDvfgGVPMo9G7sdt/FjDShHA7/BxNCkqy7vhB1GUyCZM7KeHTACnClhbnipUy85NjfjD8Jdg8MjvNIXCgi3Yi7+CU0Po960B7b0HOpvGwKsCfIod7Yt0VQ==
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 28EE318000D7; Sun, 29 Mar 2026 06:22:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH 0/1] hw/m68k: add working floppy controller for q800
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <ab79a32b-24b3-418e-a2c5-6427cf174d35@ilande.co.uk>
Date: Sun, 29 Mar 2026 02:22:55 -0400
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08A3610F-0AB2-400E-8BBE-B8DE32C89BEB@me.com>
References: <20251203064336.79847-1-mhjacobson@me.com>
 <ab79a32b-24b3-418e-a2c5-6427cf174d35@ilande.co.uk>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-GUID: zio0WmHs0wgDJNP6gUZTyFfM5Bc5bmRD
X-Authority-Info-Out: v=2.4 cv=GMsF0+NK c=1 sm=1 tr=0 ts=69c8c543
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=x7bEGLp0ZPQA:10 a=Z7GCepxVSdIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=j3sCMuMDAAAA:8 a=vG_k6K3vAAAA:8 a=VwQbUJbxAAAA:8 a=pcZqCyVeAAAA:8
 a=cplnpDx6AAAA:8 a=nZPjLQeURaRNFFABhdsA:9 a=QEXdDO2ut3YA:10
 a=a0UBubXhG_AzAa6FPyAw:22 a=tfW1Jdusjhd-N1e0D2n7:22 a=SGy6VSG0Ue1xmPAwIFl9:22
 a=bHwCOBSOUrNypjIvOSWD:22
X-Proofpoint-ORIG-GUID: zio0WmHs0wgDJNP6gUZTyFfM5Bc5bmRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA0NiBTYWx0ZWRfXxlEu4g01eKRE
 nkLwHNqiJGOVAywUmAR3iTAvxL0DMB28Sdi10+uEZdrKGnrvsGQltrNH6jDVPGONW1+Nm7cnnKs
 XMXF+BLdXyrsTgkxQjljYl9Ffii6by/CEZhAYWNWlm/R5K9yZgLdMT07bPTxMyoXbaa6NcXH/DH
 BxvWCMYQ5G1IDPp6+KY9g9YFzhdIA47Vw6Cw62cYc6eKka14P3GkLojJ59ltrQ4uzB61AM4k9XW
 mL2Kv2i+spKMEw7hzvDlbXZ53o8LEQdxojlpQnuPCGSCtBi+/e6pq1JomNgm1ZM9ofnu4n640MB
 14ItCPxl2xFFE5nl0CC+93Xcj1ZaL144GokOJFPFoXkGos3UgW10wQMUYbCCf0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603290046
Received-SPF: pass client-ip=57.103.67.112; envelope-from=mhjacobson@me.com;
 helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mark, Laurent,

Many thanks for taking the time to review.  (And sorry for my delay in =
response.  I'd still like to put in the work to get this over the finish =
line.)

I realize this is a large change, so I am more than happy to make =
changes to minimize the burden.  Responses inline=E2=80=A6

> On Dec 5, 2025, at 4:20 PM, Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk> wrote:
>=20
> I've applied this patch and managed to get it to compile successfully, =
but I'm struggling to find a suitable disk image that works. Can you =
point me towards both a GCR and an MFM image I can use for testing? I =
think this might be because the images I use here are simply HFS(+) =
images.

The Sony drive emulator here takes raw HFS(+) images and will generate =
the GCR/MFM encoding on the fly.  Here are a couple sample images to =
play with:

<https://mjacobson.net/files/mac-disks/floppy-800.img>
<https://mjacobson.net/files/mac-disks/floppy-1440.img>

> Some initial thoughts from looking over the code:
>=20
> - The basic implementation looks fairly good from what I can see, but =
I can see a number of places that don't match our code style guidelines. =
You can do a basic style check running "./scripts/checkpatch.pl =
HEAD~1..HEAD" from a git checkout with your patch applied which will =
pick up the majority of issues.

Thanks -- I was not aware of that script, and I'll ensure the next =
version passes it.

> - Having everything in one patch makes it harder to review: I think it =
would make sense to introduce the SONY drive in one patch, the updated =
SWIM2 controller in another, and then a final patch to update the q800 =
machine to switch over the SWIM2. And maybe even an extra patch to =
remove the existing SWIM1 stub? The stub was added with just enough =
implemented to allow Linux to boot.

That sounds reasonable.  I was considering leaving the SWIM1 stub so =
that it could eventually be fleshed out and hooked up to the drive, but =
I suppose it's not worth letting it sit unused.  A new version could be =
re-added in the future if desired.

> - Have you tested with an A/UX 3.0.1 boot floppy? A number of people =
are interested to run AUX 3.0.1 as per =
https://www.emaculation.com/doku.php/m68k-qemu-on-windows#running_qemu-sys=
tem-m68k_with_a_ux_3x_guests_in_windows and it would be good to be able =
to use the real floppy image here.

Good question.  Testing A/UX had been on my to-do list, but I hadn't yet =
gotten around to it.

On your prompting, I can now report that (with a handful of small =
bugfixes, which I will include in my next version), my A/UX 3.0.1 boot =
floppy boots and allows installation of A/UX, *and* both MFM and GCR =
floppies are mountable inside A/UX (3.0.1 and 3.1) itself.

Happily, the A/UX kernel does not have symbols stripped, and I was able =
to compile an old GNU binutils objdump for the m68k-unknown-coff target =
to analyze it!

> - QEMU already has a fairly good Fifo8 implementation: is it possible =
to use that or Fifo32 instead of reinventing it here?

Probably -- I just wasn't aware of it.  The only downside would be that =
the bytes would be out-of-line, but I don't think that's worth fretting =
over.

> - It's worth updating the cover letter to include an example command =
line. I had to go digging into the patch to discover that I needed to =
add something like "-drive file=3D/tmp/Install.img,if=3Dnone,id=3Dfloppy" =
to attempt a floppy boot.

I'll definitely include a full example command for v2.  You should be =
able to use just `-drive if=3Dfloppy,file=3D"some-floppy.img",format=3Draw=
`.  My full command is something like:

qemu-system-m68k \
  -machine q800 \
  -m 128 \
  -bios "Quadra800.ROM" \
  -nodefaults \
  -drive if=3Dmtd,file=3D"pram.img",format=3Draw \
  -drive if=3Dfloppy \
  -drive if=3Dfloppy \
  -drive if=3Dscsi,media=3Ddisk,file=3D"$1",format=3Draw \
  -drive if=3Dscsi,media=3Dcdrom \
  -nic user,model=3Ddp83932 \
  -audio none \
  -display cocoa \
  -name "Macintosh Quadra 800"

(Unless I'm trying to boot from a floppy, I tend to leave the floppy =
drives empty, since the ROM will auto-eject the non-bootable disks =
anyway.)

> Configuring internal devices can be fiddly: I'm wondering if there is =
existing precedent in the way PC floppy drives work that we can use to =
keep things consistent?


I *think* the above matches IBM PC emulation; you could even use `-fda` =
and `-fdb` if you wished.

> - When booting a test Linux image I got stuck in a boot loop, both =
with and without a floppy inserted in the drive:
>=20
> swim2_mmio_read addr=3D0x1e00 size=3D1 reg=3D7 [HANDSHAKE] value=3D0x8 =
mode=3D0xca setup=3D0x28 phase=3D0x74 fifo=3D0
> swim2_mmio_read addr=3D0x1e00 size=3D1 reg=3D7 [HANDSHAKE] value=3D0x8 =
mode=3D0xca setup=3D0x28 phase=3D0x74 fifo=3D0
> ...
> ...
>=20
> Since the Linux maintainers make use of QEMU for testing, I think we =
need to get this working. Laurent - do you know if the 68K Mac kernel =
driver works on real hardware?

> On Dec 8, 2025, at 7:44 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>=20
> Well, I wrote it, and didn't test for a while.
>=20
> It only supports read access. I wrote it to be able to boot linux from =
a floppy and allow the kernel to read initrd from another.
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/block/swim.c

I'd be glad to look into it.  Would you mind sharing your Linux disk for =
me to try?

I'm not too familiar with Linux's support, but SWIM1 and SWIM2 are =
*mostly* compatible, as long as the IWM sub-mode of SWIM1 isn't used =
(and, from my brief read of the Linux driver there, it isn't).

Matt=

