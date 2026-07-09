Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3431C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whiQG-0004MX-3q; Thu, 09 Jul 2026 02:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1whiQD-0004MJ-Ax; Thu, 09 Jul 2026 02:39:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1whiQA-0003P3-JI; Thu, 09 Jul 2026 02:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783579173; bh=b95LgVcwOIAhHAh3cUZCOSlsG8lLUgG0vuunq5D6UFE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kFlioFntuH4oBCU8fXs+a4DDu5mV6f+T1NPz0zKTkBtO0d5D7aR9yADsJN3RJKKYl
 1lP+SfR/k+gmp4n2kWXFwSDiCsijQc4dSW4pHEtA9lrvBqMreo0ExsqYVa2iTTGt0j
 n7DdTaK1HdyZWwW/stNWouHh+gXurZUQWaJl82agKMswIS+CLkCLC9nIaHEhHZUYsB
 URcPVqU9Ik2ra7pExLUwujyhSMOL2iy7yhomve485vuWzz20GWCjAZTYQvAqcYxjG8
 Qm6lI3vi+mNkb04U2YitSLkaALc3wK1JouaICt/sRehfFzG84tNkC4OuHK2HthMiZ0
 5IDB5a6rsrCsg==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 64C4D1BF9EC;
 Thu, 09 Jul 2026 09:39:33 +0300 (MSK)
Message-ID: <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
Date: Thu, 9 Jul 2026 09:39:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pvscsi: translate data endianness
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-s390x@nongnu.org
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> This patch improves the implementation of the pvscsi device by
> translating the endianness of the data sent or received from the guest.
> This ensures pvscsi can work on big-endian hosts with little-endian
> guests.

Hi!

Can we pick this one up for 11.1 please?
I know right to nothing about s390x internals so can't really review
the change.  But the fix seems to work, and it should be picked up for
the stable qemu series too, it loks like.

Thanks,

/mjt

> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   hw/scsi/vmw_pvscsi.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 11ae6b9b7474b9bc87621137eb7911361b5fd721..883dfe9b6b5dc687737de356da02fe5f68aea7ad 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -35,6 +35,7 @@
>   #include "hw/pci/msi.h"
>   #include "hw/core/qdev-properties.h"
>   #include "exec/cpu-common.h"
> +#include "exec/tswap.h"
>   #include "vmw_pvscsi.h"
>   #include "trace.h"
>   #include "qom/object.h"
> @@ -392,9 +393,18 @@ static void
>   pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
>   {
>       hwaddr cmp_descr_pa;
> +    struct PVSCSIRingCmpDesc cmp_desc_conv;
>   
>       cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
>       trace_pvscsi_cmp_ring_put(cmp_descr_pa);
> +    cmp_desc_conv = (struct PVSCSIRingCmpDesc) {
> +        .context = tswap64(cmp_desc->context),
> +        .dataLen = tswap64(cmp_desc->dataLen),
> +        .senseLen = tswap32(cmp_desc->senseLen),
> +        .hostStatus = tswap16(cmp_desc->hostStatus),
> +        .scsiStatus = tswap16(cmp_desc->scsiStatus),
> +    };
> +    cmp_desc = &cmp_desc_conv;
>       cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
>   }
>   
> @@ -402,9 +412,18 @@ static void
>   pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
>   {
>       hwaddr msg_descr_pa;
> +    struct PVSCSIRingMsgDesc msg_desc_conv;
> +    int i;
>   
>       msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
>       trace_pvscsi_msg_ring_put(msg_descr_pa);
> +    msg_desc_conv = (struct PVSCSIRingMsgDesc) {
> +        .type = tswap32(msg_desc->type),
> +    };
> +    for (i = 0; i < ARRAY_SIZE(msg_desc->args); i++) {
> +        msg_desc_conv.args[i] = tswap32(msg_desc->args[i]);
> +    }
> +    msg_desc = &msg_desc_conv;
>       cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
>   }
>   
> @@ -481,6 +500,9 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
>       struct PVSCSISGElement elem;
>   
>       cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
> +    elem.addr = tswap64(elem.addr);
> +    elem.length = tswap32(elem.length);
> +    elem.flags = tswap32(elem.flags);
>       if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
>           /*
>               * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
> @@ -759,6 +781,12 @@ pvscsi_process_io(PVSCSIState *s)
>   
>           trace_pvscsi_process_io(next_descr_pa);
>           cpu_physical_memory_read(next_descr_pa, &descr, sizeof(descr));
> +        descr.context = tswap64(descr.context);
> +        descr.dataAddr = tswap64(descr.dataAddr);
> +        descr.dataLen = tswap64(descr.dataLen);
> +        descr.senseAddr = tswap64(descr.senseAddr);
> +        descr.senseLen = tswap32(descr.senseLen);
> +        descr.flags = tswap32(descr.flags);
>           pvscsi_process_request_descriptor(s, &descr);
>       }
>   
> @@ -808,6 +836,17 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
>   {
>       PVSCSICmdDescSetupRings *rc =
>           (PVSCSICmdDescSetupRings *) s->curr_cmd_data;
> +    PVSCSICmdDescSetupRings translated;
> +    int i;
> +
> +    translated.reqRingNumPages = tswap32(rc->reqRingNumPages);
> +    translated.cmpRingNumPages = tswap32(rc->cmpRingNumPages);
> +    translated.ringsStatePPN = tswap64(rc->ringsStatePPN);
> +    for (i = 0; i < PVSCSI_SETUP_RINGS_MAX_NUM_PAGES; i++) {
> +        translated.reqRingPPNs[i] = tswap64(rc->reqRingPPNs[i]);
> +        translated.cmpRingPPNs[i] = tswap64(rc->cmpRingPPNs[i]);
> +    }
> +    rc = &translated;
>   
>       trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_RINGS");
>   
> @@ -831,6 +870,11 @@ pvscsi_on_cmd_abort(PVSCSIState *s)
>       PVSCSICmdDescAbortCmd *cmd = (PVSCSICmdDescAbortCmd *) s->curr_cmd_data;
>       PVSCSIRequest *r, *next;
>   
> +    PVSCSICmdDescAbortCmd translated = *cmd;
> +    translated.context = tswap32(cmd->context);
> +    translated.target = tswap32(cmd->target);
> +    cmd = &translated;
> +
>       trace_pvscsi_on_cmd_abort(cmd->context, cmd->target);
>   
>       QTAILQ_FOREACH_SAFE(r, &s->pending_queue, next, next) {
> @@ -862,6 +906,10 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
>           (struct PVSCSICmdDescResetDevice *) s->curr_cmd_data;
>       SCSIDevice *sdev;
>   
> +    PVSCSICmdDescResetDevice translated = *cmd;
> +    translated.target = tswap32(cmd->target);
> +    cmd = &translated;
> +
>       sdev = pvscsi_device_find(s, 0, cmd->target, cmd->lun, &target_lun);
>   
>       trace_pvscsi_on_cmd_reset_dev(cmd->target, (int) target_lun, sdev);
> @@ -892,6 +940,14 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
>   {
>       PVSCSICmdDescSetupMsgRing *rc =
>           (PVSCSICmdDescSetupMsgRing *) s->curr_cmd_data;
> +    PVSCSICmdDescSetupMsgRing translated = *rc;
> +    int i;
> +
> +    translated.numPages = tswap32(rc->numPages);
> +    for (i = 0; i < PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES; i++) {
> +        translated.ringPPNs[i] = tswap64(rc->ringPPNs[i]);
> +    }
> +    rc = &translated;
>   
>       trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_MSG_RING");
>   
> @@ -994,7 +1050,7 @@ pvscsi_on_command_data(PVSCSIState *s, uint32_t value)
>       size_t bytes_arrived = s->curr_cmd_data_cntr * sizeof(uint32_t);
>   
>       assert(bytes_arrived < sizeof(s->curr_cmd_data));
> -    s->curr_cmd_data[s->curr_cmd_data_cntr++] = value;
> +    s->curr_cmd_data[s->curr_cmd_data_cntr++] = tswap32(value);
>   
>       pvscsi_do_command_processing(s);
>   }
> 
> ---
> base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
> change-id: 20260605-pvscsi-endianness-c0d389d8274e
> 
> Best regards,


