Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC3D3E792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTfFp-0005E0-Ls; Thu, 11 Dec 2025 06:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vTfFl-0005Df-Lz
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:54:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vTfFj-0002WX-Iw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:54:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CAEA8596A08;
 Thu, 11 Dec 2025 12:54:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GK0xPWw1AU3n; Thu, 11 Dec 2025 12:54:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7AA9D5969F7; Thu, 11 Dec 2025 12:54:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7915F5969FF;
 Thu, 11 Dec 2025 12:54:26 +0100 (CET)
Date: Thu, 11 Dec 2025 12:54:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/11] ati-vga: Implement HOST_DATA transfers to
In-Reply-To: <DEV1B7KO3P1T.1WB3D1SLTKAD4@jablonski.xyz>
Message-ID: <fd3eb2a9-14df-b107-76e3-e0add2bff477@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <DEV1B7KO3P1T.1WB3D1SLTKAD4@jablonski.xyz>
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

Hello,

On Wed, 10 Dec 2025, Chad Jablonski wrote:
> Hey BALATON, just a friendly ping on the v3 HOST_DATA series. If there's
> something I can take a look at as far as hardware validation or anything
> else let me know! In the meantime I've been getting familiar with CCE and
> poking at the microcode a bit.

I haven't missed it but I did not have time to test and review it yet. I 
hoped somebody else could also help out but I still intend to review it 
when I have more time. For the CCE I've restored the ticket I got about it 
before here: https://codeberg.org/qmiga/pages/issues/3 which has the info 
I've collected so far that may help but I could not find info on the 
microcode of these older ATI cards, Only newer versions seem to be known 
that are linked in the ticket. So unless you can find out how it works the 
way to go may be to parse the packets directly the same way as Xenia 
emulator does and not trying to run the microcode but it would be nice to 
emulate the micro engine if the microcode can be reversed or understood 
enough. Newer versions of the microcode appear to have short segments for 
each packet type that do simple operations, mainly stuffing data in the 
command FIFO so that FIFO may also need to be implemented first then 
another possible improvement is to run the drawing engine in a separate 
thread asynchronously fed through the command FIFO as it works on the real 
chip.

Regards,
BALATON Zoltan

