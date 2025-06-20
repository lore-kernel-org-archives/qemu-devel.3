Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE502C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScLX-0007XE-EC; Fri, 20 Jun 2025 10:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScLU-0007Wp-Ug
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:03:57 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScLR-0004dy-6Z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:03:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNzbk2kH6z6L6Lg;
 Fri, 20 Jun 2025 21:58:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D74C14027A;
 Fri, 20 Jun 2025 22:03:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:03:44 +0200
Date: Fri, 20 Jun 2025 15:03:42 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Message-ID: <20250620150342.000055aa@huawei.com>
In-Reply-To: <20250619151619.1695-2-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
 <20250619151619.1695-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 19 Jun 2025 16:16:13 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with Maintenance Operation Subclass, LD ID and
> ID of the device head information.
Hi Shiju,

Wrap a little longer - this is sub 70 and should aim for about 75 for
commit descriptions.

> 
> Add updates for the above spec changes in the related CXL events
> reporting and QMP command to inject CXL events.

Main comment in here is we need to keep these new parameters as optional
as we shouldn't go adding required stuff to qapi and perhaps more importantly
they are actually optional for most events.

Jonathan

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b5482f58a3..0787a9bfca 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1780,12 +1780,18 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>  
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp)
> +                             uint8_t length, uint64_t timestamp,
> +                             uint8_t maint_class, uint8_t maint_subclass,
> +                             uint16_t ld_id, uint8_t head_id)
>  {
>      st24_le_p(&hdr->flags, flags);
>      hdr->length = length;
>      memcpy(&hdr->id, uuid, sizeof(hdr->id));
>      stq_le_p(&hdr->timestamp, timestamp);
> +    hdr->maint_op_class = maint_class;
> +    hdr->maint_op_subclass = maint_subclass;
> +    hdr->ld_id = ld_id;
2 bytes so 

       stw_le_p(&hdr->ld_id, ld_id);

> +    hdr->head_id = head_id;
>  }
>  
>  static const QemuUUID gen_media_uuid = {
> @@ -1825,7 +1831,9 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>  }
>  /* Component ID is device specific.  Define this as a string. */
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, uint8_t class,
> +                                        uint8_t subclass, uint16_t ld_id,
> +                                        uint8_t head_id, uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channel,
> @@ -1863,7 +1871,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>  
>      memset(&gem, 0, sizeof(gem));
>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            class, subclass, ld_id, head_id);
>  
>      stq_le_p(&gem.phys_addr, dpa);
>      gem.descriptor = descriptor;
> @@ -1907,7 +1916,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>  #define CXL_DRAM_VALID_COLUMN                           BIT(6)
>  #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
>  
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
> +                               uint8_t class, uint8_t subclass,
> +                               uint16_t ld_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -1950,7 +1961,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>  
>      memset(&dram, 0, sizeof(dram));
>      cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            class, subclass, ld_id, head_id);
>      stq_le_p(&dram.phys_addr, dpa);
>      dram.descriptor = descriptor;
>      dram.type = type;
> @@ -2010,7 +2022,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>  }
>  
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, uint8_t class,
> +                                        uint8_t subclass, uint16_t ld_id,
> +                                        uint8_t head_id, uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
> @@ -2049,7 +2063,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>  
>      memset(&module, 0, sizeof(module));
>      cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
> -                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            class, subclass, ld_id, head_id);
>  
>      module.type = type;
>      module.health_status = health_status;
> @@ -2284,7 +2299,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>       * Event Log.
>       */
>      cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> -                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +                            cxl_device_get_timestamp(&dcd->cxl_dstate),
> +                            0, 0, 0, 0);
As below - we'll need to pass in the validity flags as well for subclass, ld-id and head-id
 as we don't really want to do that bit of computing 'flags' at each caller.

>  
>      dCap.type = type;
>      /* FIXME: for now, validity flag is cleared */
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index c1a5e4a7c1..263d8b4609 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -14,7 +14,9 @@
>  #include "qapi/qapi-commands-cxl.h"
>  
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
> -                                        uint8_t flags, uint64_t dpa,
> +                                        uint32_t flags, uint8_t class,
> +                                        uint8_t subclass, uint16_t ld_id,
> +                                        uint8_t head_id, uint64_t dpa,
>                                          uint8_t descriptor, uint8_t type,
>                                          uint8_t transaction_type,
>                                          bool has_channel, uint8_t channel,
> @@ -23,7 +25,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          const char *component_id,
>                                          Error **errp) {}
>  
> -void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
> +                               uint8_t class, uint8_t subclass,
> +                               uint16_t ld_id, uint8_t head_id,
>                                 uint64_t dpa, uint8_t descriptor,
>                                 uint8_t type, uint8_t transaction_type,
>                                 bool has_channel, uint8_t channel,
> @@ -38,7 +42,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 Error **errp) {}
>  
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> -                                        uint8_t flags, uint8_t type,
> +                                        uint32_t flags, uint8_t class,
> +                                        uint8_t subclass, uint16_t ld_id,
> +                                        uint8_t head_id, uint8_t type,
>                                          uint8_t health_status,
>                                          uint8_t media_status,
>                                          uint8_t additional_status,
With suggestion below, this will gain bool has_xxx parameters like
qmp_cxl_inject_general_media already has.

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 831fdefbac..fc6ec82670 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -827,7 +827,9 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
> -                             uint8_t length, uint64_t timestamp);
> +                             uint8_t length, uint64_t timestamp,
> +                             uint8_t maint_class, uint8_t maint_subclass,
> +                             uint16_t ld_id, uint8_t head_id);

I think we need to add bools for the presence of maint_subclass, ld_id and head_id
or we have to modify flags at each caller which is rather ugly.
It's fine to just fill maint_class in with 0 if not set though as that has
no valid bit.

>  bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
>                                      uint64_t dpa, uint64_t len);
>  bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 758b075a64..4d9cfdb621 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
>  
>  /*
>   * Common Event Record Format
> - * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
> + * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
>   */
> -#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> +#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
> +#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
> +#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4)
> +#define CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5)
> +#define CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6)
> +#define CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7)
> +#define CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
As below - here we have the 3 valid bits.

>  typedef struct CXLEventRecordHdr {
>      QemuUUID id;
>      uint8_t length;
> @@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
>      uint16_t related_handle;
>      uint64_t timestamp;
>      uint8_t maint_op_class;
> -    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +    uint8_t maint_op_subclass;
> +    uint16_t ld_id;
> +    uint8_t head_id;
> +    uint8_t reserved[0xb];
>  } QEMU_PACKED CXLEventRecordHdr;
>  
>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8f2e9237b1..c38585d3c8 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -42,6 +42,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -73,7 +85,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +	    'class':'uint8', 'subclass':'uint8',
> +	    'ld-id':'uint16', 'head-id':'uint8',

This is a bit of a problem as we should maintain backwards compatibility.

ld-id, head-id etc are optional anyway so should be "*ld-id" and we should
then check has_ld_id and set the valid bits appropriately.

For class and subclass we should make them optional in this interface
and follow the guidance to set them to 0 if they aren't explicitly set.
Actually on closer inspection subclass is also optional and has a valid flag
so the only one we are making optional in this interface that isn't in the
spec is class.

Also good to use fuller name to make it clear these are about maintenance
classes.  Maybe maint-op-class and maint-op-subclass

Similar comments apply to the other cases.

 
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> @@ -93,6 +107,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
>  #     Event Record, Physical Address.
> @@ -132,7 +158,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +	    'class':'uint8', 'subclass':'uint8',
> +	    'ld-id':'uint16', 'head-id':'uint8',

>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> @@ -154,6 +182,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
>  #
> @@ -184,7 +224,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint32',
> +	    'class':'uint8', 'subclass':'uint8',
> +	    'ld-id':'uint16', 'head-id':'uint8',
>              'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',


