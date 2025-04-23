Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48023C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 14:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7atb-0006xK-5v; Wed, 23 Apr 2025 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1u7atX-0006x5-Bc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:16:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1u7atC-0000x8-6i
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:16:11 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZjLjV3ll5z2TS8P;
 Wed, 23 Apr 2025 22:15:26 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A93C140298;
 Wed, 23 Apr 2025 22:15:43 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Apr 2025 22:15:42 +0800
CC: <yangyicong@hisilicon.com>, <qemu-devel@nongnu.org>,
 <anisinha@redhat.com>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <peter.maydell@linaro.org>,
 <prime.zeng@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v3 4/5] hw/acpi/aml-build: Update the revision of PPTT
 table
To: "Michael S. Tsirkin" <mst@redhat.com>, Alireza Sanaee
 <alireza.sanaee@huawei.com>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-5-alireza.sanaee@huawei.com>
 <20250423083909-mutt-send-email-mst@kernel.org>
Message-ID: <6b783651-e952-ffe9-6c49-7ee9459741c8@huawei.com>
Date: Wed, 23 Apr 2025 22:15:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20250423083909-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=yangyicong@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.765,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Yicong Yang <yangyicong@huawei.com>
From:  Yicong Yang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/4/23 20:39, Michael S. Tsirkin wrote:
> On Wed, Apr 23, 2025 at 12:41:29PM +0100, Alireza Sanaee wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The lastest ACPI spec 6.5 support PPTT revision 3. Update it
>> by handy. This is compatible with previous revision.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> 
> 
> I don't get it. Why are you updating it? Which features
> from the new one are you using?
> 

no new features for this patchset. considered updating it to the latest ACPI
spec since we're going to touch the PPTT table and tested data.

>> ---
>>  hw/acpi/aml-build.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 3010325ca423..e5401dfdb1a8 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2155,7 +2155,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>>      uint32_t pptt_start = table_data->len;
>>      uint32_t root_offset;
>>      int n;
>> -    AcpiTable table = { .sig = "PPTT", .rev = 2,
>> +    AcpiTable table = { .sig = "PPTT", .rev = 3,
>>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>>  
>>      acpi_table_begin(&table, table_data);
>> -- 
>> 2.34.1
> 
> 
> .
> 

