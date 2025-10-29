Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C1CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3af-0005Vw-5r; Wed, 29 Oct 2025 06:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE3ad-0005VQ-17; Wed, 29 Oct 2025 06:39:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE3aX-0000AU-Ja; Wed, 29 Oct 2025 06:39:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62DD5597301;
 Wed, 29 Oct 2025 11:39:27 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id th4EJ_aPMPxk; Wed, 29 Oct 2025 11:39:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 097085972FF; Wed, 29 Oct 2025 11:39:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 07D305972FD;
 Wed, 29 Oct 2025 11:39:25 +0100 (CET)
Date: Wed, 29 Oct 2025 11:39:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/sam460ex: Update u-boot-sam460ex
In-Reply-To: <b131d419-15a8-4b4a-8dbd-c6f4988679fa@linux.ibm.com>
Message-ID: <aedc6da1-605d-9c23-69b7-d93649fcd2cc@eik.bme.hu>
References: <20251028151923.10DBB5972E5@zero.eik.bme.hu>
 <ee77b09f-7a12-4d52-b5f6-2d4b5b711448@linux.ibm.com>
 <f4c3bbb6-9a54-69ff-0d54-481ab4a55579@eik.bme.hu>
 <b131d419-15a8-4b4a-8dbd-c6f4988679fa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 29 Oct 2025, Harsh Prateek Bora wrote:
> On 10/29/25 15:28, BALATON Zoltan wrote:
>> On Wed, 29 Oct 2025, Harsh Prateek Bora wrote:
>>> + Thomas
>>> 
>>> Hi BALATON,
>>> 
>>> I am unable to fetch it with b4 am, and I do not see it appear on lore 
>>> also, not sure if its due to the binary size.
>>> 
>>> harshpb:patches$ b4 am 20251028151923.10DBB5972E5@zero.eik.bme.hu
>>> Looking up 
>>> https://lore.kernel.org/r/20251028151923.10DBB5972E5%40zero.eik.bme.hu
>>> Grabbing thread from 
>>> lore.kernel.org/all/20251028151923.10DBB5972E5%40zero.eik.bme.hu/t.mbox.gz
>>> Server returned an error: 404
>>> harshpb:patches$
>>> 
>>> I guess you may need to send a PULL SUBSYSTEM req like Thomas did for 
>>> slof:
>>> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/
>> 
>> Hi Harsh,
>> 
>> You should be able to download mbox from
>> https://patchew.org/QEMU/20251028151923.10DBB5972E5@zero.eik.bme.hu/
>> and git am that. This was tested by somebody else and worked.
>
> Yes, git fetch from there seems to work, thanks.
>
> If needed
>> I could try to split the binary into another patch or send you the patch 
>> again. Maybe lore does not store large files?
>
> Having only binary file update into its own separate patch may be better
> as a best practice, so other patch gets non-binary changes for easy review.
> Also, maintaining the date stamp may also be helpful in some cases.
> Let me know if you think otherwise.

Which date stamp maintaining are you referring to? I can split the patch 
in two later today or tomorrow if you want and send a v2 but not right 
now. For that to compile and work after each patch it would need to add 
the new binary in one patch then remove the old one after changing its 
usage. Or maybe even 3 patches: first updating submodule, then adding 
binary rebuilt from that then changing usage and removing old one. I think 
this would make the series larger as git now seems to contain binary diff 
between old and new versions but if these are in different patch it may 
still add the removed binary as a binary patch. So this only works if the 
old and new binary is the same name or renamed in one patch but then that 
would break if the usage is not updated in the same patch. So maybe patch 
one to update submodule, patch 2 to add binary with old name and patch 3 
to rename the binary could work but does that worth the hassle and any 
better than this single patch?

Regards,
BALATON Zoltan

