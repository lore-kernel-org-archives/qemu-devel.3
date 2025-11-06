Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289C4CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 22:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH8La-0006rY-CA; Thu, 06 Nov 2025 17:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vH8LX-0006r3-IR; Thu, 06 Nov 2025 17:20:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vH8LU-0001a5-Tq; Thu, 06 Nov 2025 17:20:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 876695972FE;
 Thu, 06 Nov 2025 23:20:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id otnEoP_YAvKD; Thu,  6 Nov 2025 23:20:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 818965972E2; Thu, 06 Nov 2025 23:20:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7FC0E5972E8;
 Thu, 06 Nov 2025 23:20:36 +0100 (CET)
Date: Thu, 6 Nov 2025 23:20:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yogesh Vyas <yvyas1991@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
In-Reply-To: <ebdb8442-3691-9bfe-dc0c-d3ecb3f5bf12@eik.bme.hu>
Message-ID: <01273d10-53ef-c49e-c3ac-ee97eefda0f3@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
 <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
 <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
 <26f74e6c-a89f-4be0-aa6c-78ad88e2cba3@gmail.com>
 <993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu>
 <38673ed9-4690-472b-9e0f-c8a736247097@gmail.com>
 <fd804cb4-d987-5e3d-24e8-0a4fb88e092e@eik.bme.hu>
 <5250e103-4dd1-44e4-9dcf-7c2df033ae10@gmail.com>
 <ebdb8442-3691-9bfe-dc0c-d3ecb3f5bf12@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-670479814-1762467636=:89733"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-670479814-1762467636=:89733
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Nov 2025, BALATON Zoltan wrote:
> On Sun, 2 Nov 2025, Yogesh Vyas wrote:
>> On 10/28/25 1:48 AM, BALATON Zoltan wrote:
>>> Trying to read invalid spr 1012 (0x3f4) at 00000000c0013f48
>>> [    0.000000] Using CHRP machine description
>>> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at 
>>> cff00000)
>>> [    0.000000] Initializing cgroup subsys cpuset
>>> [    0.000000] Initializing cgroup subsys cpu
>>> [    0.000000] Initializing cgroup subsys cpuacct
>>> [    0.000000] Linux version 3.16.0-6-powerpc (debian- 
>>> kernel@lists.debian.org) (gcc version 4.8.4 (Debian 4.8.4-1) ) #1 Debian 
>>> 3.16.56-1+deb8u1 (2018-05-08)
>>> [    0.000000] Found initrd at 0xc15a2000:0xc1b0b90d
>>> [    0.000000] chrp type = 6 [Genesi Pegasos]
>>> 
>>> Are you using this same vmlinuz-chrp.initrd?
>>> 
>>> $ md5sum vmlinuz-chrp.initrd
>>> a440d76c1d2ccfa86bdff6dba017cf39  vmlinuz-chrp.initrd
>> 
>> Yes, md5sum is same as you mentioned:
>> yogi@fedora:~/work/images$ md5sum vmlinuz-chrp.initrd
>> a440d76c1d2ccfa86bdff6dba017cf39  vmlinuz-chrp.initrd
>> 
>> Could you please share your Qemu configure command line?
>> I can try one more time if that's different than mine.
>> I used below configure command line:
>> '../configure' '--target-list=ppc64-softmmu,ppc-softmmu' '--enable-virtfs'
>
> I don't see how configure options could have anyhing to do with that but I've 
> tested that this works on my machine:
>
> configure --disable-download --disable-tools --target-list=ppc64-softmmu
> qemu-system-ppc64 -M pegasos2 -serial stdio -kernel vmlinuz-chrp.initrd 
> -append "---" -cdrom debian-8.11.0-powerpc-netinst.iso
>
> The configure options are just to only compile what's needed but it should 
> work anyway with your or any options too as long as qemu-system-ppc or 
> qemu-system-ppc64 is compiled. Can you test on a different machine?

Someone else reported a possible regression maybe related to this patch 
too but I could not reproduce that either. Can you check what configure 
says about FDT and if you're using some external FDT library? I've tested 
with the internal fdt included with QEMU which works and also with libfdt 
1.6.1 from my distro that also had no problems. I have no better idea what 
else could cause it than maybe some issue with some external libfdt 
version.

Regards,
BALATON Zoltan
--3866299591-670479814-1762467636=:89733--

