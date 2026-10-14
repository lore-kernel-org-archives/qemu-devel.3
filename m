Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3934ECC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuHc-0000Ad-KK; Wed, 14 Oct 2026 04:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xGuHV-0000A3-Kb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:24:14 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xGuHR-0002EZ-7K
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:24:13 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so1061152266b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791966247; x=1792571047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E77zUabWfnWHHLgTNO0YwCzccziQx5/PzVOktJEn4XU=;
 b=aypEhdxYbi/UpDHGwN9ain4lrQh98G/V6ceCUzKd4YbtHqmFDTV2a+WcKA/k6HFtRt
 BvbwsgeaJVrTz2wkEw5D5yQJqPLXmLwtoYrGcPjgZBL0EKxK9/e1iR3PyNSmulfRQ923
 dKoKuaL7/ZqOt4aEdP1sPW3RbNVa4t1+hlS9j6ncckSh7zrusoGI/UEsXnRgt5PSnqjM
 94kb/OFYss2FSHKfV//L5nqjusenw3WdhSG6/FRHcIz4KHnKai4+/lk4RabG4LNgiMpB
 85+MR0kiKrjpTiNsTOKj/rjZZbVcP4ngLuDchrPEsgSYGItChM5cVAw0c2bJcFalfeIL
 k4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791966247; x=1792571047;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E77zUabWfnWHHLgTNO0YwCzccziQx5/PzVOktJEn4XU=;
 b=mpbmNS1Yn2zhFDcu+hgVz55PKz5DxzLaw3qP//h/EwYWVCQc30FlvWKKgScTaoDzvi
 hsJrNfdIBUVo/0x1vijU7gsnvIrVc5zpfPxNEA2q4LWf437FmxUYbJP1Ao9kIpPUZR7h
 /w1XGBrZcQfcg6MmNrRiKcQBmFLhbKJMbT10igC8CNJIEmd/atHqIePYKQ4cTJzjOGbW
 gjRG68jDU0IUK05VopB9IINNC+UsSpi2LN6BHf9iC/C49x35iOtUZEFOzHHlzxsHWqEP
 3c1OOqaT2LSr+YYRNJ5HS/Qo9D4hMucprWNYU5plg3E4m2vkqk2W+qDQ+WtdVn7q2uOc
 yPzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpRWOw9XK8S7u4DYZJVeCHE0PZNamoJnqdCbKFPIgX0zP37uZrOm7bHjYN+50VGN9jiTro+e9Rhk7r@nongnu.org
X-Gm-Message-State: AFq9FYLRO5c00jpGZsDq6g6NUqO8T8ttzg4nw6sr9jmWFJw66bTPwrue
 dEnRFwK2Bbb3gLVHFlxIcOwoT1YBEgy9MMVqaT/YHrSDKeh6uFPOpdFD
X-Gm-Gg: AYBFou1FsYiqHmpImGQD8BbymCSusWcaTPdYBrP9L3Sq9/so1A8s/biH8DQoYfV0vor
 MixByMrGhYU9PyxUki0x8oE9EsgiKLTB1AYORfBtMFWlufcUh8yMcV9Y9wHp7fBnSfhcYOoZ/Lx
 diUzDLQO2kh/T9mYa6bgTjtRAtTb+6J4uWqYbWhKQDYlT+XErc8bDGy3EY7OSz75N9K54wfVSbG
 bgbM/lPLA+TRNEQzKVfush26fVa7x4d+hHoH39jAU/lrMSau8LOMxfYXWPWCh8zPxzSZtA+6fjK
 IFKOuqZYAUOWe+KYAzJmaj2qwiK65kMqUsE4SuH/0+pYne6/T/SctqrOf2n+OJq4Dvz1G2pzQHG
 mHKqwBrZbfLp3g2cPh6d/Et0Ejf7rx2t5TQjsNEvs9HkxHt1bgfsp4HT0Vfl9lOcfklnEv08naB
 WJbmWEqPXaKz6Rcgv1OQjuiYLZ0GBc54sCame8I5QliSvMCmTAsfKL2EINiRogB5672QEX2C0ck
 bJuZ7lYdmInYQRrA6Ci7SvJf/N/5HP7GX1HdAdL9Q==
X-Received: by 2002:a17:906:730f:b0:c2d:d4dd:8b5 with SMTP id
 a640c23a62f3a-c31a9fc0b88mr1422037866b.19.1791966247252; 
 Wed, 14 Oct 2026 01:24:07 -0700 (PDT)
Received: from [192.168.1.130] (93-143-204-231.adsl.net.t-com.hr.
 [93.143.204.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31b8c4b407sm635010866b.0.2026.10.14.01.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 01:24:06 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
X-Google-Original-From: Ruslan Ruslichenko <ruslichenkor@gmail.com>
Message-ID: <ea850fd3-1712-470d-a010-465aae705690@gmail.com>
Date: Wed, 14 Oct 2026 10:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] hw/core: Implement Remote Port Memory Master bus
 transactions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
 <20260915160044.345788-12-ruslichenko.r@gmail.com>
 <8f0cfc4a-060c-41a9-81e4-111e0019392f@oss.qualcomm.com>
 <981c4de8-2b09-49df-bcfa-c1f4fdbf3cfb@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <981c4de8-2b09-49df-bcfa-c1f4fdbf3cfb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe,

On 10/13/26 18:10, Philippe Mathieu-Daudé wrote:
> On 2026-10-13 18:09, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 2026-09-15 18:00, Ruslan Ruslichenko wrote:
>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>
>>> Implement the core access handlers for the Remote Port Memory
>>> Master device, which enables QEMU to initiate memory-mapped
>>> transaction to remote peers.
>>>
>>> The patch adds support for:
>>> - Translation of QEMU memory region read/write into Remote Port
>>> read/write packets
>>> - Support for propagating of transaction attributes
>>> (Secure, MasterID)
>>> - Synchronous response waiting with optional timeout (timeout
>>>    configuration to be added within later patches)
>>> - Add trace events for monitoring TX/RX bus transactions
>>>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>>> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
>>> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>> ---
>>>   hw/core/remote-port-memory-master.c | 191 +++++++++++++++++++++++++++-
>>>   hw/core/remote-port.c               |   5 +
>>>   hw/core/trace-events                |   4 +
>>>   include/hw/core/remote-port.h       |  11 ++
>>>   4 files changed, 207 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote- port-memory-master.c
>>> index 4b0283f9fe..41ef1df518 100644
>>> --- a/hw/core/remote-port-memory-master.c
>>> +++ b/hw/core/remote-port-memory-master.c
>>> @@ -29,18 +29,201 @@
>>>   #define RP_MAX_ACCESS_SIZE 4096
>>> +static int rp_mm_get_timeout(RPMemoryTransaction *tr)
>>> +{
>>> +    RemotePortMap *map = tr->opaque;
>>> +    RemotePortMemoryMaster *s;
>>> +
>>> +    if (!map || !map->parent ||
>>> +        !object_dynamic_cast(OBJECT(map->parent),
>>> +                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
>>> +        return 0;
>>> +    }
>>> +    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
>>> +    return s->rp_timeout;
>>> +}
>>> +
>>> +MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
>>> +                                       struct rp_peer_state *peer,
>>> +                                       RPMemoryTransaction *tr,
>>> +                                       bool relative, uint64_t offset,
>>> +                                       uint32_t def_attr)
>>> +{
>>> +    uint64_t addr = tr->addr;
>>> +    RemotePortRespSlot *rsp_slot;
>>> +    RemotePortDynPkt *rsp;
>>> +    struct  {
>>> +        struct rp_pkt_busaccess_ext_base pkt;
>>> +        uint8_t reserved[RP_MAX_ACCESS_SIZE];
>>> +    } pay;
>>> +    uint8_t *data = rp_busaccess_tx_dataptr(peer, &pay.pkt);
>>> +    struct rp_encode_busaccess_in in = {0};
>>> +    int i;
>>> +    int len;
>>> +    int rp_timeout = rp_mm_get_timeout(tr);
>>> +    MemTxResult ret;
>>> +
>>> +    if (tr->rw) {
>>> +        /* Data up to 8 bytes is passed as values.  */
>>> +        if (tr->size <= 8) {
>>> +            for (i = 0; i < tr->size; i++) {
>>> +                data[i] = tr->data.u64 >> (i * 8);
>>> +            }
>>> +        } else {
>>> +            memcpy(data, tr->data.p8, tr->size);
>>> +        }
>>> +    }
>>> +
>>> +    addr += relative ? 0 : offset;
>>> +
>>> +    in.cmd = tr->rw ? RP_CMD_write : RP_CMD_read;
>>> +    in.id = rp_new_id(rp);
>>> +    in.dev = rp_dev;
>>> +    in.clk = rp_normalized_vmclk(rp);
>>> +    in.master_id = tr->attr.requester_id;
>>> +    in.addr = addr;
>>> +    in.attr = def_attr;
>>> +    in.attr |= tr->attr.secure ? RP_BUS_ATTR_SECURE : 0;
>>> +    in.size = tr->size;
>>> +    in.stream_width = tr->size;
>>> +    len = rp_encode_busaccess(peer, &pay.pkt, &in);
>>> +    len += tr->rw ? tr->size : 0;
>>> +
>>> +    trace_remote_port_memory_master_tx_busaccess(rp_cmd_to_string(in.cmd),
>>> +        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
>>> +
>>> +    rp_rsp_mutex_lock(rp);
>>> +    rp_write(rp, (void *) &pay, len);
>>> +
>>> +    if (!rp_timeout) {
>>> +        rsp_slot = rp_dev_wait_resp(rp, in.dev, in.id);
>>> +    } else {
>>> +        rsp_slot = rp_dev_timed_wait_resp(rp, in.dev, in.id, rp_timeout);
>>> +        if (rsp_slot->valid == false) {
>>> +            /*
>>> +             * Timeout error
>>> +             */
>>> +            rp_rsp_mutex_unlock(rp);
>>> +            return MEMTX_ERROR;
>>> +        }
>>> +    }
>>> +    rsp = &rsp_slot->rsp;
>>> +
>>> +    /* We dont support out of order answers yet.  */
>>> +    assert(rsp->pkt->hdr.id == in.id);
>>> +
>>> +    switch (rp_get_busaccess_response(rsp->pkt)) {
>>> +    case RP_RESP_OK:
>>> +        ret = MEMTX_OK;
>>> +        break;
>>> +    case RP_RESP_ADDR_ERROR:
>>> +        ret = MEMTX_DECODE_ERROR;
>>> +        break;
>>> +    default:
>>> +        ret = MEMTX_ERROR;
>>> +        break;
>>> +    }
>>> +
>>> +    if (ret == MEMTX_OK && !tr->rw) {
>>> +        data = rp_busaccess_rx_dataptr(peer, &rsp->pkt- >busaccess_ext_base);
>>> +        /* Data up to 8 bytes is return as values.  */
>>> +        if (tr->size <= 8) {
>>> +            for (i = 0; i < tr->size; i++) {
>>> +                tr->data.u64 |= ((uint64_t) data[i]) << (i * 8);
>>> +            }
>>> +        } else {
>>> +            memcpy(tr->data.p8, data, tr->size);
>>
>> I don't understand this direct memory access.
>>
>> Shouldn't this be handled by the FlatView and end as a subpage_t
>> leaf instead?
>>

Thank you for the catch!
In fact this is a leftover of handling MemoryTransaction's: https://lore.kernel.org/qemu-devel/20260205195824.2610192-14-ruslichenko.r@gmail.com/,
which were used for RemotePort memory access in v1 patch series.

In Xilinx tree, large access sizes are possible thanks to downstream patch: https://github.com/Xilinx/qemu/commit/063b379d47856e1e0f71f93974157b76d51a3106,
which is not present in upstream.

For Remote Port v2 series, switched to standard (read|write)_with_attrs to simplify things for now, so those need to be cleaned-up.

--
BR,
Ruslan

>> Doing some archeology to understand:
>> https://lore.kernel.org/qemu-devel/20170204115048.GM12995@toto/
> 
> I meant v3:
> https://lore.kernel.org/qemu-devel/1493391576-29401-1-git-send-email-fred.konrad@greensocs.com/
> 
>>
>> Amusingly a related backtrace:
>> https://lore.kernel.org/qemu-devel/CAKmqyKOqbJ+-t0SeyZDzDM9RLEQX63WM3- wyJTbiMGHRKtHPYQ@mail.gmail.com/
>>
>>> +        }
>>> +    }
>>> +
>>> +    trace_remote_port_memory_master_rx_busaccess(
>>> +        rp_cmd_to_string(rsp->pkt->hdr.cmd), rsp->pkt->hdr.id,
>>> +        rsp->pkt->hdr.flags, rsp->pkt->hdr.dev, rsp->pkt- >busaccess.addr,
>>> +        rsp->pkt->busaccess.len, rsp->pkt->busaccess.attributes);
>>> +
>>> +    if (rp_timeout) {
>>> +        for (i = 0; i < ARRAY_SIZE(rp->dev_state[rp_dev].rsp_queue); i++) {
>>> +            if (rp->dev_state[rp_dev].rsp_queue[i].used &&
>>> +                rp->dev_state[rp_dev].rsp_queue[i].valid) {
>>> +                rp_resp_slot_done(rp, &rp- >dev_state[rp_dev].rsp_queue[i]);
>>> +            }
>>> +        }
>>> +    } else {
>>> +        rp_resp_slot_done(rp, rsp_slot);
>>> +    }
>>> +    rp_rsp_mutex_unlock(rp);
>>> +
>>> +    /*
>>> +     * For strongly ordered or transactions that don't allow Early Acking,
>>> +     * we need to drain the pending RP processing queue here. This is
>>> +     * because RP handles responses in parallel with normal requests so
>>> +     * they may get reordered. This becomes visible for example with reads
>>> +     * to read-to-clear registers that clear interrupts. Even though the
>>> +     * lowering of the interrupt-wires arrives to us before the read- resp,
>>> +     * we may handle the response before the wire update, resulting in
>>> +     * spurious interrupts.
>>> +     *
>>> +     * This has some room for optimization but for now we use the big hammer
>>> +     * and drain the entire qeueue.
>>> +     */
>>> +    rp_process(rp);
>>> +
>>> +    /* Reads are sync-points, roll the sync timer.  */
>>> +    rp_restart_sync_timer(rp);
>>> +    return ret;
>>> +}
>>> +
>>> +MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
>>> +                         struct rp_peer_state *peer,
>>> +                         RPMemoryTransaction *tr,
>>> +                         bool relative, uint64_t offset)
>>> +{
>>> +    return rp_mm_access_with_def_attr(rp, rp_dev, peer, tr, relative, offset,
>>> +                                      0);
>>> +}
>>> +
>>>   static MemTxResult rp_mm_read(void *opaque, hwaddr addr, uint64_t *data,
>>>                                    unsigned size, MemTxAttrs attrs)
>>>   {
>>> -    /* TBD */
>>> -    return MEMTX_OK;
>>> +    MemTxResult ret;
>>> +    RemotePortMap *map = opaque;
>>> +    RemotePortMemoryMaster *s = map->parent;
>>> +
>>> +    RPMemoryTransaction tr = {};
>>> +
>>> +    tr.opaque = map;
>>> +    tr.rw = false;
>>> +    tr.addr = addr;
>>> +    tr.size = size;
>>> +    tr.attr = attrs;
>>> +
>>> +    ret = rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
>>> +                map->offset);
>>> +
>>> +    if (ret == MEMTX_OK) {
>>> +        *data = tr.data.u64;
>>> +    }
>>> +
>>> +    return ret;
>>>   }
>>>   static MemTxResult rp_mm_write(void *opaque, hwaddr addr, uint64_t data,
>>>                                     unsigned size, MemTxAttrs attrs)
>>>   {
>>> -    /* TBD */
>>> -    return MEMTX_OK;
>>> +    RemotePortMap *map = opaque;
>>> +    RemotePortMemoryMaster *s = map->parent;
>>> +
>>> +    RPMemoryTransaction tr = {};
>>> +
>>> +    tr.opaque = map;
>>> +    tr.rw = true;
>>> +    tr.addr = addr;
>>> +    tr.size = size;
>>> +    tr.attr = attrs;
>>> +    tr.data.u64 = data;
>>> +
>>> +    return rp_mm_access(s->rp, s->rp_dev, s->peer, &tr, s->relative,
>>> +                    map->offset);
>>>   }
>>>   static const MemoryRegionOps rp_ops_template = {
>>> diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
>>> index b4c9fa1528..6a6effdd19 100644
>>> --- a/hw/core/remote-port.c
>>> +++ b/hw/core/remote-port.c
>>> @@ -39,6 +39,11 @@ static void rp_event_read_and_process(RemotePort *s);
>>>   static void sync_timer_hit(void *opaque);
>>>   static void syncresp_timer_hit(void *opaque);
>>> +uint32_t rp_new_id(RemotePort *s)
>>> +{
>>> +    return qatomic_fetch_inc(&s->current_id);
>>> +}
> 


