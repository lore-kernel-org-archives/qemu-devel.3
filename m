Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F453CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBu6o-0006AH-Bj; Thu, 23 Oct 2025 08:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBu6R-000669-Bh; Thu, 23 Oct 2025 08:07:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBu6N-0004vD-5j; Thu, 23 Oct 2025 08:07:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70F8C5972DF;
 Thu, 23 Oct 2025 14:07:23 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rh0PakV93EZI; Thu, 23 Oct 2025 14:07:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6C9775972DE; Thu, 23 Oct 2025 14:07:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6AD1059703F;
 Thu, 23 Oct 2025 14:07:21 +0200 (CEST)
Date: Thu, 23 Oct 2025 14:07:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 00/12] Pegasos2 clean up and pegasos1 emulation
In-Reply-To: <764df5c7-55d3-48ec-a28b-0c837e13c595@linux.ibm.com>
Message-ID: <671f7ace-fe86-5443-40b7-d02dd16b922b@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <764df5c7-55d3-48ec-a28b-0c837e13c595@linux.ibm.com>
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

On Thu, 23 Oct 2025, Harsh Prateek Bora wrote:
> On 10/23/25 05:36, BALATON Zoltan wrote:
>> This series changes how the fdt for VOF is generated in pegasos2 by
>> moving the static parts to a dtb and only generate the changing parts
>> such as memory size and PCI devices programmatically. This simplifies
>> the code and allows simply adding emulation of Pegasos I which has a
>> different north bridge and slightly different memory map but otherwise
>> very similar and can be emulated by reusing parts from the amigaone
>> machine. The machine was tested with a Pegasos I ROM image and MorphOS.
>> 
>> The first VOF patch (submitted separetely before, the reviewed v3 is
>> included here) fixes handling the name property in VOF that cannot be
>> represented in a dts as that always takes the path as the name and
>> cannot accept an explicit name property but we need the name property
>> to appear when guest queries properties which previously was worked
>> around by adding it to every node.
>> 
>> Regards,
>> BALATON Zoltan
>
> Queued.

OK. In that case I can do follow up if needed but I still plan to send 
updated raven series and if time allows updated firmware for sam460ex but 
the latter is unsure if I can finish before the freeze.

Regards,
BALATON Zoltan


