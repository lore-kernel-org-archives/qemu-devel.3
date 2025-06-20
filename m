Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47BDC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScUl-0001Hy-0G; Fri, 20 Jun 2025 10:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScUi-0001HS-D4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:13:28 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uScUf-0006Cx-Ki
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:13:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNzvV6rfYz6M4y6;
 Fri, 20 Jun 2025 22:12:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E246140446;
 Fri, 20 Jun 2025 22:13:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:13:16 +0200
Date: Fri, 20 Jun 2025 15:13:14 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/7] hw/cxl/events: Updates for rev3.2 general media
 event record
Message-ID: <20250620151314.0000535c@huawei.com>
In-Reply-To: <20250619151619.1695-3-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
 <20250619151619.1695-3-shiju.jose@huawei.com>
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

On Thu, 19 Jun 2025 16:16:14 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
> table has updated with following new fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 
> Add updates for the above spec changes in the CXL general media event
> reporting and QMP command to inject general media event.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
This has the same constraints on not changing the qemu api stuff
in a non backwards compatible way.

So make them optional parameters and fill them in with what
we'd get if the device didn't support cme. These only really
make sense if we have memory event type 5 anyway:
Advanced Programmable Corrected Memory Counter Expiration

We don't need to enforce that in the interface though.

I don't mind if we do the incompatible 'counter expiry'
and a count of 0 for a type 5 event.  We could check for that
specific condition given the spec calls it out and reject the
injection but perhaps we are better leaving it fully flexible
so we can poke the OS with that invalid state.  Any real
test paths will set it appropriately so the counter is non 0
when we signal the event.

> ---
>  hw/mem/cxl_type3.c          |  9 +++++++++
>  hw/mem/cxl_type3_stubs.c    |  3 +++
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  qapi/cxl.json               | 14 +++++++++++++-
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0787a9bfca..410ff445d0 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1813,6 +1813,7 @@ static const QemuUUID memory_module_uuid = {
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
>  #define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
>  
>  static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>  {
> @@ -1840,6 +1841,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device,
>                                          const char *component_id,
> +                                        uint8_t cme_ev_flags,
> +                                        uint32_t cme_count,
> +                                        uint8_t sub_type,
>                                          Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1898,10 +1902,15 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>          strncpy((char *)gem.component_id, component_id,
>                  sizeof(gem.component_id) - 1);
>          valid_flags |= CXL_GMER_VALID_COMPONENT;
> +        valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
>      }
>  
>      stw_le_p(&gem.validity_flags, valid_flags);
>  
> +    gem.cme_ev_flags = cme_ev_flags;
> +    st24_le_p(gem.cme_count, cme_count);
> +    gem.sub_type = sub_type;
> +
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
>          cxl_event_irq_assert(ct3d);
>      }
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 263d8b4609..b2a11bded8 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -23,6 +23,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          bool has_rank, uint8_t rank,
>                                          bool has_device, uint32_t device,
>                                          const char *component_id,
> +                                        uint8_t cme_ev_flags,
> +                                        uint32_t cme_count,
> +                                        uint8_t sub_type,
>                                          Error **errp) {}
>  
>  void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4d9cfdb621..352f9891bd 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
>  
>  /*
>   * General Media Event Record
> - * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
> + * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> -#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
>  typedef struct CXLEventGenMedia {
>      CXLEventRecordHdr hdr;
>      uint64_t phys_addr;
> @@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
>      uint8_t rank;
>      uint8_t device[3];
>      uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t cme_ev_flags;
> +    uint8_t cme_count[3];
> +    uint8_t sub_type;
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>  
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c38585d3c8..dd01d50c25 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -82,6 +82,16 @@
>  # @component-id: Device specific component identifier for the event.
>  #     May describe a field replaceable sub-component of the device.
>  #
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @cme-count: Corrected memory error count at event.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
> +# @sub-type: Memory event sub-type.
> +#     See CXL r3.2 Table 8-57 General Media Event Record.
> +#
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> @@ -91,7 +101,9 @@
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> -            '*device': 'uint32', '*component-id': 'str' } }
> +            '*device': 'uint32', '*component-id': 'str',
> +            'cme-ev-flags':'uint8', 'cme-count':'uint32',
> +            'sub-type':'uint8' } }
>  
>  ##
>  # @cxl-inject-dram-event:


