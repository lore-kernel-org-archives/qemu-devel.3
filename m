Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B714C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 05:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPEQN-0000No-NC; Wed, 11 Jun 2025 01:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uPEQK-0000Ne-AC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 01:54:56 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uPEQC-0005Cy-Sw
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 01:54:54 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id F0349240101
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
 s=1984.ea087b; t=1749621285;
 bh=Wm1BMlC1IEsv77XI2FCCsXImrMpT1KGq732S77kZ8Hk=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:To:Subject:From:From;
 b=BgPiSm6pTgHPOrR7UPCVel6xqtw5VbF5gaJ8gkPTa3LOBMcYYB5iEAAaBRrYpVDxN
 ekh+lN8FTBM9B0KgvgGD46OJl0JklR/bpqJg0BntNQcSe5Cm217TN8cYtHPaKbgRpT
 u4Ld4/1wVoJD0b/xQ+eae265N04o8ibJcLbWZQktAp30w9MmwxyftxqzR7OayYJmDA
 64OuavWrJ6wXhGKuLRF6E8PzM2UHW2C8F3NjW41qqafvKJILnLU6PPrm83V2mniXWp
 OZ2dlDWmmcmc7SlbjIpONVM3CCURxx5FkV745HVN7SLmeiZdK2zdrRaZH+dyz1PtRr
 nvrp1Tsbbho1URUtovZf0WBDt7QXzoyIzurzdNbrjqG8zUiCifVG2Qm/FvShpZXGXu
 BcvIROE7f6l5kIPnRpgfWk0SonVWkJwb1cy51qhUkmyndTvLimq73qrDmg2NLHn79z
 p7BCUuPsuR5uJdk/hBJJ5f1NYTf33Y/75/C1cP3Tbop4EJxj/j2
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bHFH92sFcz6tyW;
 Wed, 11 Jun 2025 07:54:45 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 05:54:45 +0000
Message-Id: <DAJGZE8R43JD.1Y1H6T3G593IS@posteo.net>
To: "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH] pc-bios/s390-ccw: link statically
From: "Sertonix" <sertonix@posteo.net>
References: <DAJ1QOSAP9LS.342SQSM0UZU80@posteo.net>
 <4c8bb61a-d919-411b-afeb-eed15c4b2ab9@tls.msk.ru>
 <DAJ547978XGV.3LNJ0SI0X7GXD@posteo.net>
 <5c9cbee5-235b-4623-a119-0956b981f43c@tls.msk.ru>
In-Reply-To: <5c9cbee5-235b-4623-a119-0956b981f43c@tls.msk.ru>
Received-SPF: pass client-ip=185.67.36.66; envelope-from=sertonix@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed Jun 11, 2025 at 6:07 AM CEST, Michael Tokarev wrote:
> On 10.06.2025 23:36, Sertonix wrote:
>> On Tue Jun 10, 2025 at 10:32 PM CEST, Michael Tokarev wrote:
>>> On 10.06.2025 20:58, Sertonix wrote:
>>>>
>>>> Adding -pie to LDFLAGS caused s390-ccw.img to become dynamically linke=
d.
>>>
>>> Why do you think -pie causes it to become dynamically linked?
>>>
>>> /mjt
>>=20
>> The documentation (at least for gcc) states that the -pie option produce=
s
>> a *dynamically* linked position independent executable. (And I verified
>> that the patch changes the resulting binary from dynamically linked to
>> statically linked).
>
> Ok.
>
> Why I asked is because -pie by its own does not change "dynaminess" of
> an executable.

I am uncertain what you mean with "dynaminess" but I mean the ELF file
type, whether or not an interpreter is set and some additional sections
(like .dynamic) exist.

> -pie has been introduced for s390-ccw in commit d884c86dcd "s390/bios:
> Make the s390-ccw.img relocatable" (9 Mar 2015).  Before this commit,
> s390x-ccw.img has been dynamically linked too.  Now with current
> master (commit bc98ffdc75), removing -Wl,-fpie from LDFLAGS does not
> change the fact that the image is linked dynamically.

The prebuild binary before d884c86dcd was added in 553ce81c31e4 and shows a=
s
statically linked: (ET_EXEC is the ELF file type of static binaries)

~/src/qemu$ scanelf pc-bios/s390-ccw.img
 TYPE   FILE=20
ET_EXEC pc-bios/s390-ccw.img=20

and when the binary was rebuild after d884c86dcd in 2d5eeef1c0be it shows
as dynamically linked:

~/src/qemu$ scanelf pc-bios/s390-ccw.img
 TYPE   FILE=20
ET_DYN pc-bios/s390-ccw.img=20

(Same results with file(1) and readelf -l)

> On the other hand, people sometimes confuse the result of -static-pie
> as a dynamic executable, especially with older file(1) utility which
> reported it as dynamically linked.

Latest file(1) release:
$ file --version
file-5.46
magic file from /usr/share/misc/magic

> So my question was badly worded: what I wanted to ask is what makes
> you think that adding -pie to the link line makes the resulting
> executable to be linked dynamically.
>
> With all the above in mind, I think the commit message is misleading
> a bit.  But it'd be interesting to clarify how this image, being
> a dynamic executable, worked all these years, and why it has to be
> changed now.

As mentioned above this is only about the file metadata and doesn't
affect the binary code part of the binary. So it is probably just
ignored by qemu and shouldn't change the bhaviour of qemu. This is
mostly to fix the intend of the commit that added -pie and exclude a
libc dependant string from a binary that isn't libc dependant.

> I'm definitely not opposing to the change, I just am
> curious about this aspect and want a correct commit message.
>
> Thanks,
>
> /mjt


