Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33269CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFv4d-00073d-EG; Mon, 03 Nov 2025 08:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFv4a-000733-RN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:58:16 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFv4W-00013W-Lt
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:58:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E56455972FE;
 Mon, 03 Nov 2025 14:58:05 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fClST1Z5xhHA; Mon,  3 Nov 2025 14:58:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4076F5972F3; Mon, 03 Nov 2025 14:58:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F0C55972E3;
 Mon, 03 Nov 2025 14:58:03 +0100 (CET)
Date: Mon, 3 Nov 2025 14:58:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/7] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <20251103033608.120908-6-chad@jablonski.xyz>
Message-ID: <441b1bbc-3432-680f-80d7-09a256a62436@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-6-chad@jablonski.xyz>
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
> Writing to any of the HOST_DATA0-7 registers pushes the written data
> into a buffer. A final write to HOST_DATA_LAST writes data to the
> buffer and triggers the pending blit operation.
>
> The buffer for now is a static 4MiB and overflows are checked. This
> seems like a large enough value given what I've seen in testing. Future
> work could dynamically size the buffer based on the destination dimensions if
> needed.

I wonder where the real chip stores this information?

Regards,
BALATON Zoltan

