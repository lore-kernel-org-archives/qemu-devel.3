Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A83C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 11:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rET-0000jQ-Q9; Fri, 03 May 2024 07:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1s2rES-0000jE-Fi
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:37:40 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1s2rEL-0006p7-6d
 for qemu-devel@nongnu.org; Fri, 03 May 2024 07:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1714736253; x=1746272253;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dxkrvDCZNoTH6UzikNB5h5QEWMplJ94dcTU6BIAt1iM=;
 b=HiXnqK5U9Q6rC0wxMjo9ZEGjbvyI13VZt4y4TJQ8u4DAWb9BehC1xAkY
 XxZ+5AlE/E7H/VCC8N/CdnjKpxxH6YN4rcdAsZU027MSgFMdnrdJqHy98
 A1aHeobU1firv8JRRv9vwNAok19ZSeMvGE/FAvms3VGpAm8gCODHOS/eE
 IhSrxjzNYWMBwK3na17RZC1Y7tNEMw3HLEExvDRgFBMchaism+rQyixhd
 7GzBQCQQrG40g/T0qyjIxkoC/FREomkqioF4eBh9qMWWrzdOkdRRW1GEF
 dUNOzcDv34ZmlbEVjHF3ZvHGk0qK+YWHtu7InsIzZ/m1poNiB67LdtaMZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="157295852"
X-IronPort-AV: E=Sophos;i="6.07,251,1708354800"; d="scan'208";a="157295852"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2024 20:37:30 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CF596C6909
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 20:37:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0DA8920806
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 20:37:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 901FE2008BCE1
 for <qemu-devel@nongnu.org>; Fri,  3 May 2024 20:37:26 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id EC6DE1A0002;
 Fri,  3 May 2024 19:37:25 +0800 (CST)
Message-ID: <f9e1c047-192b-4d50-8588-5a90bfe7e96b@fujitsu.com>
Date: Fri, 3 May 2024 19:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
To: Alison Schofield <alison.schofield@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
In-Reply-To: <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28358.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28358.007
X-TMASE-Result: 10--8.932000-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eHchRkqzj/bEC/ExpXrHizw0tugJQ9Wdwwvz
 nYJVXoOYa/8aZGNpfqY65m9meG/WS9fk7hbCEuNogvmNrsT46HIQARQHZYEjpND0fCJzqdHb1a9
 Gw6X1fIgreMjPCBtKqxPT4WWiXjYzIQPGoj5DOk5f2SdIdby5dcdvO1Rp+sgmqRTAHcwAECdm2e
 55IVZ1oM2JZjaQ73l9ZcW/i2O53DhdInhzedP5B1hRyidsElYkRYYm6fbhZvXRnp8Qx+pp65hj4
 4rNETuJIvrftAIhWmLy9zcRSkKate2aXYCZD9Vi3IFFT9wqfr19LQinZ4QefNQdB5NUNSsiDrBA
 jvbPhh50HSe131POnsZW5ai5WKlyS8vbBiSyYXmfus/r6APjpOYSCtCVlxicSPNjBqdf6x+OGgM
 3MsQ7s35uyI/OFesN886gGzbqib5WV8McR6Zfhr93LmVDgtT58wykF/dkuej3FzhuUqY+wb77j9
 TR8omKbFWdBw/YcNq7b6knBzvluw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa3.hc1455-7.c3s2.iphmx.com
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



在 2024/5/1 5:00, Alison Schofield 写道:
> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
>> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
>> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
>> unaffected.
>>
>> If userspace was doing its own DPA-to-HPA translation this could lead to
>> incorrect page retirement decisions, but there is no known consumer
>> (like rasdaemon) of this event today.
>>
>> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
>> Cc: <stable@vger.kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Hi Ruan,
> 
> This fixup is important for the Event DPA->HPA translation work, so I
> grabbed it, updated it with most* of the review comments, and posted
> with that set. I expect you saw that in your mailbox.

Yes, I saw that.  Nice fix!

> 
> DaveJ queued it in a topic branch for 6.10 here:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.10/dpa-to-hpa
> 

That's good!

> *I did not create a common mask for events and poison because I wanted to
> limit the changes. If you'd like to make that change it would be welcomed.

Ok~


--
Thanks,
Ruan.

> 
> -- Alison
> 
>> ---
>>   drivers/cxl/core/trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index e5f13260fc52..cdfce932d5b1 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>>   #define CXL_DPA_VOLATILE			BIT(0)
>> -- 
>> 2.34.1
>>

