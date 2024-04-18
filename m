Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxNek-0006J3-By; Thu, 18 Apr 2024 05:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rxNee-0006GR-V0
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:02:08 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rxNeZ-0000Uk-9P
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713430918; x=1744966918;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uDJwwFOuP/hupsK1Xl66DmKRvm8/ULIM+uZHIuIdS24=;
 b=G1qlkR52GtlkfX7WvafIcT5yRGht2CMHJ8XV6J40k6eVQLJLSRKtjXRX
 wY57OydQr1NhKFCN0WZSUb/AnxQTcjTq4vH3Hbw2uejgvR80qILyFogDp
 TO1cq0F7mwuEyZSZyu2Q21FI934hL0vb+9MVvRelpot2zicz+qsWyXZ4c
 BXn4T2mV29gmT1tsihORwqeHt4srI3xYW4udZPQxH/fxxkHrwsc/ZBDFV
 Z7tnb0YdJRQ6rWOs85P1JmHmh6po/G5bisM0jxx9CTL9D5oyW+GPgAG4k
 PxVc7zKw9EIY/hpwt4onIJhfBEkB9pS3PY4zT5wLALmvABUY0C4uO1Aol Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="134797092"
X-IronPort-AV: E=Sophos;i="6.07,211,1708354800"; d="scan'208";a="134797092"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 18:01:51 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EA74EB3E22
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 18:01:49 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BAA7D6216
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 18:01:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B9A76227A93
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 18:01:48 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E36F11A000A;
 Thu, 18 Apr 2024 17:01:47 +0800 (CST)
Message-ID: <57182a01-0fc9-4c03-a99d-3a17faced5ff@fujitsu.com>
Date: Thu, 18 Apr 2024 17:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Dave Jiang <dave.jiang@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
In-Reply-To: <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28328.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28328.005
X-TMASE-Result: 10--23.167500-10.000000
X-TMASE-MatchedRID: 9xvWjox81uOPvrMjLFD6eJTQgFTHgkhZ2q80vLACqaeqvcIF1TcLYANw
 091XoRE6tdBbZHtILeuNZCQJKjBBDuQJzj0xQdQ4vHKClHGjjr3DCscXmnDN78+WYjg3WzyKZ28
 gEzxS4tLh6irq2fTMTeuIRaLznvypzroGAhCVDDVYUconbBJWJDzLhqT0KeNiL31P64kiV5HoKE
 r2irJf5CL637QCIVpi8vc3EUpCmrXDiZmOF0V5Fd+pUF0HsjxRBPY4SegK3jy8GLW9IO2MLTpPt
 Z9ix6SwbSL9AN4UjlsdjcJQBafotb9ZdlL8eonaRjjVhf+j/woNlf30fAUOwiq2rl3dzGQ1A/3R
 8k/14e0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



在 2024/4/18 1:30, Dave Jiang 写道:
> 
> 
> On 4/17/24 12:50 AM, Shiyang Ruan wrote:
>> Currently driver only traces cxl events, poison creation (for both vmem
>> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
>> could handle poison pages in time.  Per CXL spec, the device error event
>> could be signaled through FW-First and OS-First methods.
> 
> Please consider below for better clarity:
> Currently the driver only traces CXL events. Poison creation (for both ram
> and pmem type) on a CXL memdev is silent. The OS needs to be notified so it
> can handle poison pages. Per CXL spec, the device error event
> can be signaled through the FW-First method or the OS-First method.

Thanks, this is better.

> 
>>
>> So, add poison creation event handler in OS-First method:
>>    - Qemu:
>>      - CXL device reports POISON creation event to OS by MSI by sending
>>        GMER/DER after injecting a poison record;
> 
> Can probably drop the QEMU changes and this is the kernel commit log.

Ok.

> 
>>    - CXL driver:
>>      a. parse the POISON event from GMER/DER;
>>      b. translate poisoned DPA to HPA (PFN);
>>      c. enqueue poisoned PFN to memory_failure's work queue;
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>>   drivers/cxl/cxlmem.h      |   8 +--
>>   include/linux/cxl-event.h |  18 +++++-
>>   3 files changed, 125 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index f0f54aeccc87..76af0d73859d 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>   
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt)
>> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
> 
> I think this needs to be changed to __cxl_report_poison() and the function below to cxl_report_poison(). Otherwise it goes against typical Linux methodology of having the __functionX() as the raw functionality function called by a functionX() wrapper.

This function was designed to do the real reporting work, and could be 
called at other places (actually did in previous version).  Now that it 
is called only below in this version, yes, it's better to change the names.


--
Thanks,
Ruan.

> 
> DJ
> 

