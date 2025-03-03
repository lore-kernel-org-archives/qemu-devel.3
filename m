Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B8C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5WM-0000gw-17; Mon, 03 Mar 2025 08:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp5Vv-0000Vu-P5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:07:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp5Vr-0004Zs-6K
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:07:17 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA05C4E6010;
 Mon, 03 Mar 2025 14:07:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VJDE4UOPcpPW; Mon,  3 Mar 2025 14:07:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF9094E600E; Mon, 03 Mar 2025 14:07:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AE1DF74577C;
 Mon, 03 Mar 2025 14:07:10 +0100 (CET)
Date: Mon, 3 Mar 2025 14:07:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Fam Zheng <fam@euphon.net>, 
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] usb-storage: Allow manually adding SCSI device
In-Reply-To: <0128cd62-b5d7-4aa1-b169-2a7717d33113@redhat.com>
Message-ID: <7ddd1ca2-7055-d3cc-0442-8e866cc6e8d7@eik.bme.hu>
References: <20250303-usb-v1-1-70f700a181fd@daynix.com>
 <0128cd62-b5d7-4aa1-b169-2a7717d33113@redhat.com>
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

On Mon, 3 Mar 2025, Paolo Bonzini wrote:
> On 3/3/25 11:28, Akihiko Odaki wrote:
>> usb-storage automatically adds a SCSI device, but it limits
>> configurability of the added SCSI device and causes usability
>> problems as observed in:
>> https://gitlab.com/libvirt/libvirt/-/issues/368
>> 
>> Allow manually adding SCSI device when the drive option is not
>> specified.
>
> I might be misunderstanding what you're doing, but can't you do that already 
> with usb-bot?

That's quite an obscure device I haven't heard of yet. Could it be 
possible to make -drive media=cdrom,if=usb,file=some.iso do the right 
thing whatever is that for users' convenience?

Regards,
BALATON Zoltan

