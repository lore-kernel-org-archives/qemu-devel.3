Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13615C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufISC-0007kM-3V; Fri, 25 Jul 2025 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufIRm-0007Uh-0q
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:26:51 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufIRh-0007U6-2z
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:26:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpTBX59DTz6M4V2;
 Fri, 25 Jul 2025 21:25:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1BB591402FE;
 Fri, 25 Jul 2025 21:26:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 15:26:36 +0200
Date: Fri, 25 Jul 2025 14:26:35 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <fan.ni@samsung.com>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 6/7] hw/cxl: Add Maintenance support
Message-ID: <20250725142635.000014fa@huawei.com>
In-Reply-To: <20250721172228.2118-7-shiju.jose@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-7-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
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

On Mon, 21 Jul 2025 18:22:27 +0100
<shiju.jose@huawei.com> wrote:

> From: Davidlohr Bueso <dave@stgolabs.net>

I tweaked the title to mention Post Package Repair.  If anyone is ever
looking for that particular maintenance command they might want to know
it is in here from the title.

> 
> This adds initial support for the Maintenance command, specifically
> the soft and hard PPR operations on a dpa. The implementation allows
> to be executed at runtime, therefore semantically, data is retained
> and CXL.mem requests are correctly processed.
> 
> Keep track of the requests upon a general media or DRAM event.
> 
> Post Package Repair (PPR) maintenance operations may be supported by CXL
> devices that implement CXL.mem protocol. A PPR maintenance operation
> requests the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support PPR features
> may implement PPR Maintenance operations. DRAM components may support two
> types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
> (sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
> but the repair is lost with a power cycle.
> 
> CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
> maintenance operation and section 8.2.10.7.1.3 describes the device's
> hPPR (hard PPR) maintenance operation feature.
> 
> CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
> configuration.
> 
> CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
> configuration.
> 
> CXL spec 3.2 section 8.2.10.2.1.4 Table 8-60 describes the Memory Sparing
> Event Record.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
2x SoB for Shiju.

Main question I have on this is why we currently track things marked
for maintenance in injected error records, but don't act on that in any
way.  I'm also thinking we could easily pass on any provided geometry so
the sparing record reflects what was injected if that's where it came from.

If we do PPR on something not injected we might still want to make some
plausible geometry up.

> +static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
> +                            uint8_t class, uint8_t sub_class)
> +{
> +    CXLEventSparing event_rec = {};
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &sparing_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            1, class, 1, sub_class, 0, 0, 0, 0);
> +
> +    event_rec.flags = 0;
> +    event_rec.result = 0;
> +    event_rec.validity_flags = CXL_MSER_VALID_CHANNEL |
> +                               CXL_MSER_VALID_RANK |
> +                               CXL_MSER_VALID_NIB_MASK |
> +                               CXL_MSER_VALID_BANK_GROUP |
> +                               CXL_MSER_VALID_BANK |
> +                               CXL_MSER_VALID_ROW |
> +                               CXL_MSER_VALID_COLUMN |
> +                               CXL_MSER_VALID_SUB_CHANNEL;
> +
> +    event_rec.res_avail = 1;
> +    event_rec.channel = 2;
> +    event_rec.rank = 5;
> +    st24_le_p(event_rec.nibble_mask, 0xA59C);
> +    event_rec.bank_group = 2;
> +    event_rec.bank = 4;
> +    st24_le_p(event_rec.row, 13);
> +    event_rec.column = 23;
> +    event_rec.sub_channel = 7;

At some point we should cycle back and make up some 'geometry' for the
memory so we can map different DPAs to different places.  This is fine
for now though.

> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                         CXL_EVENT_TYPE_INFO,
> +                         (CXLEventRecordRaw *)&event_rec)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +}
> +
> +
> +static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
> +{
> +    CXLMaintenance *ent, *next;
> +
> +    QLIST_FOREACH_SAFE(ent, &ct3d->maint_list, node, next) {

If we did want to generate the right geometry to match the injected
event we'd want to retrieve it here (having stashed it in the ent)

> +        if (dpa == ent->dpa) {
> +            QLIST_REMOVE(ent, node);

What is this actually for at the moment?  We track them on a list but
don't enforce anything with it?  I don't think we should enforce this
as you can issue PPR on stuff that was never in error if you like.

> +            g_free(ent);
> +            break;
> +        }
> +    }
> +
> +    /* Produce a Memory Sparing Event Record */
> +    if (ct3d->soft_ppr_attrs.sppr_op_mode &
> +        CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN) {
> +        cxl_mbox_create_mem_sparing_event_records(ct3d,
> +                                CXL_MEMDEV_MAINT_CLASS_SPARING,
> +                                CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING);
> +    }
> +}

>  /* Component ID is device specific.  Define this as a string. */
>  void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          uint32_t flags, bool has_maint_op_class,
> @@ -1715,6 +1756,11 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>          error_setg(errp, "Unhandled error log type");
>          return;
>      }
> +    if (rc == CXL_EVENT_TYPE_INFO &&
> +        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
> +        error_setg(errp, "Informational event cannot require maintenance");
> +        return;
> +    }
>      enc_log = rc;
>  
>      memset(&gem, 0, sizeof(gem));
> @@ -1773,6 +1819,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
>          cxl_event_irq_assert(ct3d);
>      }
> +
> +    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
> +        cxl_maintenance_insert(ct3d, dpa);

Same as below.

> +    }

>  
>      memset(&dram, 0, sizeof(dram));
> @@ -1935,6 +1990,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
>          cxl_event_irq_assert(ct3d);
>      }
> +
> +    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
> +        cxl_maintenance_insert(ct3d, dpa);
We make up the geometry details for the sparing record, but we 'could'
store them here if they were injected and hence spit out an appropriate
sparing record?

Do you think it's worth doing at this stage?

Jonathan

> +    }
>  }
>  
>  #define CXL_MMER_VALID_COMPONENT                        BIT(0)



