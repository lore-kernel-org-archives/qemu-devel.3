Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88002E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 06:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snBfm-0007A2-Sr; Sun, 08 Sep 2024 02:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laster@dlaster.com>)
 id 1sn8Pu-0002ad-1H
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 23:16:46 -0400
Received: from [50.198.229.123] (helo=mail.dlaster.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <laster@dlaster.com>)
 id 1sn8Pq-0000qh-Ct
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 23:16:44 -0400
Received: from [127.0.0.1] (IDENT:1000@malaika.dlaster.com [172.16.0.37])
 by mail.dlaster.com (8.14.3/8.14.3) with ESMTP id 48839S7f011895;
 Sat, 7 Sep 2024 23:09:28 -0400
Subject: Re: How to run qemu
To: Kenneth Adam Miller <kennethadammiller@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
From: Donald R Laster Jr <laster@dlaster.com>
Organization: Personal Mail
Message-ID: <c9856d31-c88d-7593-c457-f88c6463063c@dlaster.com>
Date: Sat, 7 Sep 2024 23:09:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0
MIME-Version: 1.0
In-Reply-To: <CAK7rcp_qUmp7k6dqo62KqNpAuNgVznWiCxgBrhf4V7PT5=YDhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 50.198.229.123 (failed)
Received-SPF: pass client-ip=50.198.229.123; envelope-from=laster@dlaster.com;
 helo=mail.dlaster.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.946,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Sep 2024 02:45:17 -0400
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

Ken,

   Lookup starting the gvncviewer tool after you start the virtual machine.  To get the display for the VMs I run gvncviewer and sometimes spicec.

   Don

Kenneth Adam Miller wrote on 9/7/24 4:58 PM:
> Hello,
> 
> I've got qemu built and now I need to figure out how to run it with what I've got. I have a vmlinux and a bzImage that I want to serve as the kernel that QEMU runs with, and a single binary, let's just call it literally `program`, that I want to issue a command to run once QEMU boots with the kernel.
> 
> I tried to figure out how to run the QEMU on my own, and made it as far as this:
> 
> ./qemu//bin/debug/native/qemu-system-x86_64 -enable-kvm -m 2048 -display vnc=:89 \
>          -netdev user,id=t0, -device rtl8139,netdev=t0,id=nic0 \
>          -netdev user,id=t1, -device pcnet,netdev=t1,id=nic1 \
>          -L ./qemu/pc-bios \
>          -boot c -kernel $HOME/workspace/kvmctf-6.1.74/bzImage/bzImage
> 
> It runs, but there isn't any output to the screen to show it booting, and QEMU runs the processor hard indefinitely. I need to be able to see standard output and to be able to type into the console to enter the command, and I don't know how to get it to or why it isn't showing that already. Also, once that is working, I need a way to put `program` into the QEMU session so that it can be run. Can someone help me? I think I need to make an img file that can boot but I don't really know how to do that either.


