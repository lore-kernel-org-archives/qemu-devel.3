Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC33FC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmak-0008UK-1K; Thu, 14 Mar 2024 11:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rkmaX-0008SK-2R
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:01:50 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rkmaU-00080B-MP
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1710428502; x=1741964502;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=T2g5Yd7YALitTC2Ds+N/7bgA3HC76TP1GfD4fOlxj88=;
 b=b/F9QjbwSu+mcaghxUYfa+Nwh4oaq+Q2aWgRDeP+jhYNWoeY6z88tGsd
 uopA8fi8zieI1dEbcTYF6lQbsB95Q1iS3vxo0coP1fBcJjQ0g87510ulY
 uEbaACSgsrFOHadLEwSeMn09CTMUuFsEPk4vEmzRk5ahF24G+evrcHZe8
 7QUxUlbkXIe11jRL2QRuc0Ch+8nia79driXgJxF7bRl/pmtE+awZzsQmj
 wJRoZHKS9zSVK5fF4fXs7WFILsBk7TfnblG4wpck8fJxijulB54LvX8/w
 FK1prb9qwzeHU/QFzNhNITMb1pSKYyGw5Dj3VNYq841+TIQElsddC/mC8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="139885379"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; d="scan'208";a="139885379"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 00:01:35 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F41DD4802
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:01:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AD269D52A5
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:01:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 429156B4E0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:01:32 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 545B51A006A;
 Thu, 14 Mar 2024 23:01:31 +0800 (CST)
Message-ID: <6ffd2214-5309-4e71-b745-ba64c46cdc0e@fujitsu.com>
Date: Thu, 14 Mar 2024 23:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] cxl/core: add report option for
 cxl_mem_get_poison()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
 <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.007
X-TMASE-Result: 10--8.645100-10.000000
X-TMASE-MatchedRID: X+fKKgQJwrGPvrMjLFD6eJTQgFTHgkhZQTMEQWnELEU61nHU3L1mvwYE
 LASKZobWjhyWkMlRInD9k/FBDAgpqGRByQkQLdDaN70wXhI0DX6Uq+GQ/zyJdOjMOEZ5AL0SK2q
 s1bgqDPiFgt2tSPnIRqepbdVIZ/l3v1l2Uvx6idoVD3y1ctYHYd07eT8GLfmrUEhWy9W70AEgBw
 KKRHe+r23IUdaCIBq715B/S7LI1esUTo5EFSG/ld90NZ/UlwhguLwQYjn2sGE=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



在 2024/2/10 14:49, Dan Williams 写道:
> Shiyang Ruan wrote:
>> When a poison event is received, driver uses GET_POISON_LIST command
>> to get the poison list.  Now driver has cxl_mem_get_poison(), so
>> reuse it and add a parameter 'bool report', report poison record to MCE
>> if set true.
> 
> If the memory error record has the poison event, why does the poison
> list need to be retrieved by the kernel? I would expect it is sufficient
> to just report the single poison event and leave it to userspace to
> react to that event and retrieve more data if it wants.

The GMER has only physical address field, no range/length of the POISON, 
we can't get the poison range from the single event record.  Since the 
POISON range is injected by one command, one GMER is sent to driver, we 
have to use GET_POISON_LIST command to get the length.


--
Thanks,
Ruan.

