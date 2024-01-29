Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294FC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 06:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUKxV-0007vx-FC; Mon, 29 Jan 2024 01:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rUKxT-0007vp-A6
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 01:17:27 -0500
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rUKxQ-0004K6-Qz
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 01:17:26 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4D083902976
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 06:17:22 +0000 (UTC)
Received: from outbound2c.ore.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 01EDB902AE0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 06:17:21 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1706509042; a=rsa-sha256;
 cv=pass;
 b=WMPDnMMiPH5NnOuvFj2adyPb3LkUGxT+D7J5N8E7RhTjiJfHr20Xvi9fVJtJcy+0UO4oNZ
 pG8Xj/dreCdL9LCgXbH5LlioONwaSByj1l1CK6RuesW0HmBuF7Lyc2l0o+pWNVNjGqDwlS
 en78QATWwc2NQCsu+r05ZpJmcErGcttsV2gT1xHiPm5n0EPOD0m5aiTdjFIV4zPyaHVwik
 Y9vsFzlnnzMRS+z2Y8He43XAZLgdBjB6JJh3VbfSlMILlVQFJASdlYzZ1FUgCeRLYM6loQ
 T8XUQvbyjw/8WCYg18ki4h+ddP8pS/KYE7D9SyuDw0C87Pf6gE6hhbyKgGLJ6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1706509042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=8BbmoawTpUEHEQnZI8chcmPPisoVb92bm0Fqr22NSq8=;
 b=wJ5w3ytaK2Tx0UNNDJivcZbNQ5k4VGSXXTcfwR5N9cINWbTVv9TwpX/AoX0nY5UWC9HyYm
 b+oxPVM83BR8l84zYzH6GakyDWqSkfoCGAPDdsM5rxt3Gi8qlkdXjoQQoEMF8nv/4VlsH8
 E/wOT8UpcHX5AZKXf4J9/1n4cquIvFnLwm5Rd9LTq6NiN2TtH6H4r6G5fkY+nYNGw8tviq
 ufzG9lluA+qk+X1LKVB+VJ1HHh1MTw1kaM5BXVuBHqGecTCmcNopS/pVflNShuvMg9YgtE
 6j9XZByCEzALdHj55JYs6VKT5yEvwTqILln24BqU95EaSIu7IKE/gh/NI15PGg==
ARC-Authentication-Results: i=2; rspamd-6fdd97fffb-jn9zs;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Tasty-Suffer: 233bf86b0b2fd9cd_1706509042206_2990369730
X-MC-Loop-Signature: 1706509042206:1400005610
X-MC-Ingress-Time: 1706509042206
Received: from outbound2c.ore.mailhop.org (outbound2c.ore.mailhop.org
 [54.186.10.118]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.22.97 (trex/6.9.2); Mon, 29 Jan 2024 06:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1706509041; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=fovIY7F4snkPu3KcA+OmVrihUf404gxa9mYxXrXMdYG4fQeIa8j52nookmjmFypUn5uu6QJRYboWF
 +zo+FvQXk9ICWBf4QCk8pWFChyNC0/KJYj0kWVZFMcLpWQLAukVfWJWlW3fxvhFaANG2QcGB/ylqAl
 Vvp4J2ArO7XK99orlVMNUFbZNWrHuGzF6ZxBh6plaYMNE5aCRd7RatGyJuzDTXzYZBLyNMHC3lgzYD
 fxe4DKjnFqpZZn+6vlYRd4Ifbig860u1mKgtMzD3VYidPTjH/lmpVKhDmvxLpwLptFrlQuYdXgBktF
 +BGMQw1AFLRJmn0clpIRlAvbMXPq7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=8BbmoawTpUEHEQnZI8chcmPPisoVb92bm0Fqr22NSq8=;
 b=nOSB5uu21LxRf1H8FUj7aiPHGdwZEMMUKPnesGM1AV6HvtD6kiRs2+nbMyFRe+Z8kTgR3P3KgxaTY
 vxmpeBs8os+j2RU4yhkLE9vfdvNv2YKddibIvi/uPxXqdXZp04Gis9D1FVX+H02PdsvlZA0qQ4zlD/
 EMVQA6bMRwpikfJTfN3+vYwhXTJqKwcNqEWorRlnDBWfEuv34O9YmWiEyV5DQxe0CBOM2M9zNPs+6k
 93xmMe8nsuA8CHS5RYisBtePVwAYJLuXy7648f9JWBAY8500RECkqlFGx1OOrpIAKrKxWZAbNPA/XH
 79WFtsRsxFLxc0IsSoH0jgFUg74KNTA==
ARC-Authentication-Results: i=1; outbound4.ore.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=HvzYFXy1; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=8BbmoawTpUEHEQnZI8chcmPPisoVb92bm0Fqr22NSq8=;
 b=TGtsUkInLJKQcdfqYRtn6AxePun1d1AoWKsEKzaFnjrXzdwacYfTxNjqLsFLNUz2e4re8Qi6QigQL
 5wxQsgnjZ4oYcKridyvErapp+J1Pt31c0C++zLRQ2IqQgLcfQ31Fg+yO13YfT6pqMmDvEyV6bfov92
 dmydtIJoyKR1atdU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=8BbmoawTpUEHEQnZI8chcmPPisoVb92bm0Fqr22NSq8=;
 b=iZ87u09my28lQT7p8+DqA78PZzlSLCn2+ChWiDFuBk4YOgZ+KVZap6oC9foISOiT/RltpbXj8U4+1
 4Mo1+8Zp1zo2ALDjqCEVw/Cr9PspU+pQk5t9RDQqbTuAErwEyKkTGX0mrAx5e2jF1x7I4Q4X35Y1HM
 bjcm4g4YDp7No5yyTHf78KtL55XqAQdl+GKy+nKZxY5s32GwPVv4lTn9zp6J1wdrsJ+/gthLmdV0Vw
 8cgXNrWgFoObSJ30cOx5+m5NDmf+aEIXeNnVhtrgy2N4HbYd9AluBO1swsT4DWmCjjzcTkjOOBK7Cq
 xDHGdR4v0yInetmBcv5W6ufvkIGPKFg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0c804ea3-be6e-11ee-8042-2b2b5a144ce7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound4.ore.mailhop.org (Halon) with ESMTPSA
 id 0c804ea3-be6e-11ee-8042-2b2b5a144ce7;
 Mon, 29 Jan 2024 06:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8BbmoawTpUEHEQnZI8chcmPPisoVb92bm0Fqr22NSq8=; b=HvzYFXy1rCEUH7XIgbqdXzbRtf
 UP9XIVicn4KioLfDJhUM8WLmcqUDCOeVp524/lHaaCWPZvG3/yvJZHTN6pUDhauFOGH90fOYh0dmF
 +E/5nbxLKsoAkgI5VlvY8hZE13Shv3sWosG9VFeSnkn2yI1sIQFA/AVGQFjByb9LsbpijljjHVrGg
 GC6mGJUVitouxmFs6phONxYv4RHfGK8PggRiubVsl80hFO3DJ6afLWHvbuHTNlCR2uc4dmAEo38/x
 sZyKiEDoM3NuKpkIuLZkglIK12RhpBKY3/BoL+KIBi5Cv9ctGWTYvtO2n9p+8qbVRb5C9cQ2onh25
 DMhysR0A==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rUKxH-000aoZ-1n;
 Mon, 29 Jan 2024 07:17:15 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  deller@gmx.de,  Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add missing decrement of reentrancy
 counter
In-Reply-To: <a7ee1d55-f550-4ad9-9907-f9dd13600aa0@redhat.com> (Thomas Huth's
 message of "Mon, 29 Jan 2024 05:16:00 +0100")
References: <20240128202214.2644768-1-svens@stackframe.org>
 <a7ee1d55-f550-4ad9-9907-f9dd13600aa0@redhat.com>
Date: Mon, 29 Jan 2024 07:17:14 +0100
Message-ID: <87bk94k6j9.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 28/01/2024 21.22, Sven Schnelle wrote:
>> When the maximum count of SCRIPTS instructions is reached, the code
>> stops execution and returns, but fails to decrement the reentrancy
>> counter. This effectively renders the SCSI controller unusable
>> because on next entry the reentrancy counter is still above the limit.
>> This bug was seen on HP-UX 10.20 which seems to trigger SCRIPTS
>> loops.
>
> Out of curiosity: What happened there before we introduced the
> reentrancy_level fix? Did it end up in an endless loop, or was it
> finishing at one point? In the latter case, we might need to adjust
> the "reentrancy_level > 8" to allow deeper nesting.

Without the reentrancy counter it was triggering the insn_processed
limit. The HP-UX scsi driver seems to spin on some memory value during
some SCSI writes (CDB with command 0x2a). So it is spinning in an
endless loop until the insn_processed counter will trigger the exit.
In HP-UX you will see a SCSI command timeout error in the kernel log
- at least i'm assuming that's related, but can't say for sure as
there's no kernel source available.

