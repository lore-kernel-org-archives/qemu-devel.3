Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BA8E98E0F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuST6-0001yk-4T; Mon, 23 Feb 2026 04:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noodles@earth.li>)
 id 1vuST3-0001xi-M4; Mon, 23 Feb 2026 04:43:05 -0500
Received: from the.earth.li ([2a00:1098:86:4d:c0ff:ee:15:900d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noodles@earth.li>)
 id 1vuST1-0006R2-7d; Mon, 23 Feb 2026 04:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
 s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9ymKpjRsQ6bvntSKxYqhAwsEpGCESXE+LwKohyBPFBI=; b=xGYAxiCBN6H+xbYWZ8b7QsPxtj
 zN16sG0uFLdYrw0gZ8qiOCRvEbeyb/ZHU5XA5xShuEaAFpqjKtdvUMWPljCHMiTBPgCA+kpJ6xpoJ
 UEfZZ7lf1JZ35PpaVYPpy6hjwclMOtV2WWjzgkX8iAPYcjcUnAumoifdmWj9lI1mU5lSc+A7si7Lj
 P6i8PMDVWwGSehfndB72dYBDPL3ysSo9dfzHXkOP0NZ51qbQ46tOADmi7nG9eYD4rncuD4TJakqs4
 yl842zOeQ58IrO9DsCOTbLbHQihahDwuzTneNPr4xoFbbkVk+RiG06cwbkJmuLAEpBUXvVvnzVMgC
 y2RTDESQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
 (envelope-from <noodles@earth.li>) id 1vuSSu-007mbt-2r;
 Mon, 23 Feb 2026 09:42:56 +0000
Date: Mon, 23 Feb 2026 09:42:56 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: NVMe: Add SPDM over the storage transport support
Message-ID: <aZwhIMzkMgu94JeV@earth.li>
References: <aZiXdwyWO6MMsnXA@earth.li>
 <9fb564e200841e2ee4244f1a848120a928cdf024.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fb564e200841e2ee4244f1a848120a928cdf024.camel@wdc.com>
Received-SPF: pass client-ip=2a00:1098:86:4d:c0ff:ee:15:900d;
 envelope-from=noodles@earth.li; helo=the.earth.li
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Feb 21, 2026 at 01:38:49AM +0000, Wilfred Mallawa wrote:
>On Fri, 2026-02-20 at 17:18 +0000, Jonathan McDowell wrote:
>> On Fri, 3 Oct 2025 21:39:41 +1000, you wrote:
>> > This series extends the existing SPDM support in QEMU to support 
>> > the DSP0286 SPDM Storage Transport [1] for NVMe. SPDM Storage 
>> > Transport uses the NVMe Admin Security Send/Receive commands, as 
>> > such, support for these commands have also been added.
>>
>> > With the addition of a new `spdm-trans` CLI argument for NVMe 
>> > controllers, users can specify `spdm_trans=nvme` or 
>> > `spdm_trans=doe`.  This allows for the selection of the SPDM 
>> > transport. The `doe` option is the current default, `nvme` would 
>> > select SPDM Storage Transport for the controller, where SPDM 
>> > communication happens over the NVMe Admin Security Send/Receive 
>> > commands.
>>
>> > Support for DSP0286 already exists in `libspdm` [2] and support for 
>> > the QEMU SPDM server is being upstreamed for `spdm-utils` [3]. This 
>> > series was tested by using `spdm-utils` as the qemu SPDM server 
>> > with SPDM Storage Transport support built with `libspdm` v3.8.0, 
>> > and `spdm-utils` also as the SPDM requester.

>> Do you have a pointer to the correct spdm-utils version/branch to use 
>> for testing this? I tried wilfred/spdm-storage-v4, which appears to 
>> be the latest, but it fails to build, and the footnote in your mail 
>> is dangling.

>You should be able to use [1] in the host to setup the response server
>for QEMU. So after cargo build:
>
>```
>$ ./target/debug/spdm_utils --qemu-server --spdm-transport-protocol=storage response
>```
…
>Sorry for missing links and different branches... all of this should be
>upstream soon!

Thanks, the pointer to your add-spdm-storage-upstream-v6 branch is 
exactly what I needed to get things working.

root@debian-qemu-efi:~# nvme security-recv /dev/nvme0 --secp=0xe8 --spsp=0x0004 --size=32 --al=32
NVME Security Receive Command Success
        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        0000: 20 00 00 10 00 00 00 00 66 00 00 00 00 00 00 00 "........f......."
        0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"

>[1]
>https://github.com/twilfredo/spdm-utils/tree/wilfred/add-spdm-storage-upstream-v6

J.

-- 
   < fivemack> it is bruter-force   |  .''`.  Debian GNU/Linux Developer
     than a really really stupid    | : :' :  Happy to accept PGP signed
   elephant [on his Python suduku   | `. `'   or encrypted mail - RSA
               solver]              |   `-    key on the keyservers.

