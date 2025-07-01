Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08614C8303F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdbG-0004QL-OT; Tue, 01 Jul 2025 12:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdbF-0004Ps-27
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWdbD-0002vY-2q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751386364;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NkSCYgm+5mmXaHIh6/iab5ImzUVQL7sPGLKwXT8E+0=;
 b=TVlc0oHoYafhTvo06PWM96+bu3uNcUeznVcw/0Q7gORdZIgKu1D+enAsVvq80ZfW4Cb3X+
 OenZ0ZDl7rNW/z7jsmWKss1C72Q4sw580YpIyYAxn80/wCwg9hZUeW8dMQ8twZxJCcH16t
 Ctqxeaq+d7hadwQI2R8hpDDZXyAo9mg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-0ba2zpqgPrC6363fExDkrQ-1; Tue, 01 Jul 2025 12:12:43 -0400
X-MC-Unique: 0ba2zpqgPrC6363fExDkrQ-1
X-Mimecast-MFC-AGG-ID: 0ba2zpqgPrC6363fExDkrQ_1751386362
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4539b44e7b1so18330015e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751386362; x=1751991162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NkSCYgm+5mmXaHIh6/iab5ImzUVQL7sPGLKwXT8E+0=;
 b=npOLSRp17td36EDT+JXwPvXCXCYjidd82pQp8Sm7P3BvdaPj/w1FP7dxy+rMHmd5fF
 wu7CkPq+8poW1JNvx35SGQlNDnfSGsOBGMsOT5+uZ+OzGEcaixxSufL2xLZY+OWYg5Al
 wkAKTJTp0jT6z+hRJdAC5rOwWBdN0xh8WXDBt2OrAl511ckQU+1fu6SiTQyonGCewJij
 SHSO49yo4hqCB6wq4cDmvXMqmqBiHfRx3YoIBx8ZU1yj75lCA5BJ/5ZcN4vaq37+umld
 EwCyRasUUaO/GCxZh/+aguULCk12H/uiUu4rO14M1wms8ohTbLUW9R1MwJfCpvrWTKjm
 JP+g==
X-Gm-Message-State: AOJu0Yx8cu6otRG2MO1jAHIVp+tpnlLgac7efdW2hUUAntyfEV1t1ePE
 nrji+NshzSOBCO3yedyHawBwlTWhkHbfAuSE+KqWVL5qSwqTpzFQkw1SPEGffhKuai6G9btAH0Y
 7aGS4Ah55F6oLsIaPBmy3i5J3QWkx4I3k4LIZhbFjytto4IHfPZe5vnp6
X-Gm-Gg: ASbGnctB2aY4x4Te63MEUuKny1yKq1GfM/Z3QObdxBhSTvdXUtytqFFgiBFDlpfekbV
 dJaBrTiinLw7HtLymxxe2ofaL/lb7x4aRQkFpUdV0O7hummhk8xDbVp6t5uMzS+UME/KLIfYGFi
 d4e64adf+jFMGfDs8KEd74P9Rg/HcLc3KVl8ALgzzJsUiIw3bavd/B9tV7iex010QF7MzSHlg3i
 KcNcY0+G7ti5D7XfpRIoSHMXb8n9uMikMrT7Iq2MvO4tqT9URE+v48QwtNHPeAl8/laeG+f4KSk
 4Hlv6F68jvWvnVdenxeShGwv66s5vIYd8etQQg3S5mLpxv3i7dCdcg9k+we/urQJug866g==
X-Received: by 2002:a05:600c:3b22:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-4538ee3343dmr201835555e9.4.1751386361493; 
 Tue, 01 Jul 2025 09:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUxtPdWyJP+Gh38lQd6OscAC/exsnY5TcmCtIrtDeSaT4JNW56f9ovA5tFf9G042kRjDh+1Q==
X-Received: by 2002:a05:600c:3b22:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-4538ee3343dmr201834985e9.4.1751386360971; 
 Tue, 01 Jul 2025 09:12:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c1easm198790095e9.3.2025.07.01.09.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 09:12:40 -0700 (PDT)
Message-ID: <954f10cf-3de4-4067-878c-f0bb07e9dbe0@redhat.com>
Date: Tue, 1 Jul 2025 18:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v16 3/5] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-4-Jonathan.Cameron@huawei.com>
 <128e59be-4038-4a19-8cca-3be3d6446e0e@redhat.com>
 <20250701165222.0000068f@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250701165222.0000068f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Jonathan,
On 7/1/25 5:52 PM, Jonathan Cameron wrote:
> On Tue, 1 Jul 2025 17:34:36 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Jonathan,
>>
>> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
>>> Code based on i386/pc enablement.
>>> The memory layout places space for 16 host bridge register regions after
>>> the GIC_REDIST2 in the extended memmap. This is a hole in the current
>>> map so adding them here has no impact on placement of other memory regions
>>> (tested with enough CPUs for GIC_REDIST2 to be in use.)
>>>
>>> The CFMWs are placed above the extended memmap.  Note the confusing
>>> existing variable highest_gpa is the highest_gpa that has been allocated
>>> at a particular point in setting up the memory map.
>>>
>>> The cxl_devices_state.host_mr is provides a small space in which to place  
>> s/is//
> Fixed. Thanks.
>>> the individual host bridge register regions for whatever host bridges are
>>> allocated via -device pxb-cxl on the command line. The existing dynamic
>>> sysbus infrastructure is not reused because pxb-cxl is a PCI device not
>>> a sysbus one but these registers are directly in the main memory map,
>>> not the PCI address space.
>>>
>>> Only create the CEDT table if cxl=on set for the machine. Default to off.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>> @@ -1895,6 +1917,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>>      if (device_memory_size > 0) {
>>>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>>>      }
>>> +    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
>>> +                                                    256 * MiB),
>>> +                                           BIT_ULL(pa_bits)) - 1;  
>> in hw/cxl/cxl-host.c, there seems to be a loop on fw windows? I guess
>> those windows only exist if cxl option is set. In the positive,
>> highest_gpa will be changed only if the option is set, which is fine.
>> Indeed we have requested_ipa_size = 64 - clz64(vms->highest_gpa). So we
>> shall not modify this if cxl is not set.
so do you confirm highest_gpa is unchanged in case cxl/fmw option is not
set ?
>>
>> What I am a bit concerned with is that it"consumes" some high memory
>> without making it explicit in extended_memmap. Shouldn't we book some
>> dedicated space there? Sorry I am jumping very late in the review, maybe
>> turning things worse & noisy :-( Eric
> No problem with late review - whilst it looks late we had a several year
> gap at one point in updating this series!
>
> How much to book?  It's effectively infinite much like device memory.
> Would be odd to book the minimum which is 256MiB given any useful system
> is going to have a lot more than that (they are usually a few TiB but
> may be much larger than that).
>
> Would a comment after 
>    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }, 
> such as
>    /* Any CXL Fixed memory windows come here */
> be enough?
yes at least it deserves a comment I think. Then it must be understood
that it may prevent new regions from being added in the high mem range.
I am definitively not the most knowledgeable guy to decide whether it is
critical. I have not checked CCA impact on the layout for instance.

Thanks

Eric
>
>  
>


