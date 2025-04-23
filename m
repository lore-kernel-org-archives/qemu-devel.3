Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC05C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7aW2-0002P0-43; Wed, 23 Apr 2025 09:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1u7aVz-0002MV-7F
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:51:51 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyicong@huawei.com>)
 id 1u7aVw-0005ff-EC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:51:50 -0400
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZjL8m5Pqzz1d0lZ;
 Wed, 23 Apr 2025 21:50:32 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
 by mail.maildlp.com (Postfix) with ESMTPS id CA7F6140292;
 Wed, 23 Apr 2025 21:51:31 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Apr 2025 21:51:31 +0800
CC: <yangyicong@hisilicon.com>, <qemu-devel@nongnu.org>,
 <anisinha@redhat.com>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <peter.maydell@linaro.org>,
 <prime.zeng@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v3 3/5] hw/acpi/aml-build: Build a root node in the PPTT
 table
To: "Michael S. Tsirkin" <mst@redhat.com>, Alireza Sanaee
 <alireza.sanaee@huawei.com>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-4-alireza.sanaee@huawei.com>
 <20250423084013-mutt-send-email-mst@kernel.org>
Message-ID: <295deb78-d530-d6cc-dffc-51b4cfad17b9@huawei.com>
Date: Wed, 23 Apr 2025 21:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20250423084013-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=yangyicong@huawei.com; helo=szxga08-in.huawei.com
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

On 2025/4/23 20:41, Michael S. Tsirkin wrote:
> On Wed, Apr 23, 2025 at 12:41:28PM +0100, Alireza Sanaee wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently we build the PPTT starting from the socket node and each
>> socket will be a separate tree. For a multi-socket system it'll
>> be hard for the OS to know the whole system is homogeneous or not
>> (actually we're in the current implementation) since no parent node
>> to telling the identical implementation informentation. Add a
>> root node for indicating this.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> 
> so how does the topology look before and after this change?
> 

for a 2 socket system, the PPTT processor hierarchy tree before this change will be like:
[Socket 0]          [Socket 1]
   ^                    ^
   |-----------\        |-----------\
[CPU 0] ... [CPU 1]  [CPU 0] ... [CPU 1]

after this change there will be a root node in the tree:
[Root Node]
    ^
    |-------------------\
[Socket 0]          [Socket 1]
   ^                    ^
   |-----------\        |-----------\
[CPU 0] ... [CPU 1]  [CPU 0] ... [CPU 1]

> 
>> ---
>>  hw/acpi/aml-build.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 560cee12a24b..3010325ca423 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>>      int64_t socket_id = -1, cluster_id = -1, core_id = -1;
>>      uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
>>      uint32_t pptt_start = table_data->len;
>> +    uint32_t root_offset;
>>      int n;
>>      AcpiTable table = { .sig = "PPTT", .rev = 2,
>>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>>  
>>      acpi_table_begin(&table, table_data);
>>  
>> +    /*
>> +     * Build a root node for all the processor nodes. Otherwise when
>> +     * building a multi-socket system each socket tree are separated
> 
> is separated?
> 
>> +     * and will be hard for the OS like Linux to know whether the
>> +     * system is homogeneous.
>> +     */
>> +    root_offset = table_data->len - pptt_start;
>> +    build_processor_hierarchy_node(table_data,
>> +        (1 << 0) | /* Physical package */
>> +        (1 << 4), /* Identical Implementation */
>> +        0, 0, NULL, 0);
>> +
>>      /*
>>       * This works with the assumption that cpus[n].props.*_id has been
>>       * sorted from top to down levels in mc->possible_cpu_arch_ids().
>> @@ -2175,7 +2188,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>>              build_processor_hierarchy_node(table_data,
>>                  (1 << 0) | /* Physical package */
>>                  (1 << 4), /* Identical Implementation */
>> -                0, socket_id, NULL, 0);
>> +                root_offset, socket_id, NULL, 0);
>>          }
>>  
>>          if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
>> -- 
>> 2.34.1
> 
> 
> .
> 

