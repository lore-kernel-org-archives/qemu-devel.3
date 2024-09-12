Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39DBEEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofPl-0000pl-Uw; Thu, 12 Sep 2024 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sofPi-0000V8-OZ; Thu, 12 Sep 2024 04:42:54 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sofPf-0008G6-Vr; Thu, 12 Sep 2024 04:42:54 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8D6931140449;
 Thu, 12 Sep 2024 04:42:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 12 Sep 2024 04:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1726130570; x=
 1726216970; bh=/fx6fxE0m9guVkHELhq7/qolufjuWvPLY1Wq54DMofc=; b=d
 DPOBCLdp1YR2YzBfQBJ8xagKOZ+O4H/HMNaB7O0tkYFCMipKvA6FtFrxGn6QC6Js
 Jn22BEa0lBZdj7XxQCfhxVXlb88BN6hRoBjkag1ZvqDHhkG18TJEAPnSMilZkIr7
 3zSJY1ICwe5TLUKJreiUBpqmcagAz0d2qFLmC/0g4HkdiPa3/789oogc9Mw1cLKu
 VcnFfBloLZ30h+lZKdl4sXmh0pG1vK9BSzWNIai6gu8thPS77uE7MZHbn4JQAAxI
 +E+dIBd41HfnOF4jVnrUWdyu/3PWyRVJBOpjG2iFOb/4WIjvy2a4O3LTgkG7E6HL
 7nnz0Vlau2UfOsVxA+AYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1726130570; x=1726216970; bh=/fx6fxE0m9guVkHELhq7/qolufju
 WvPLY1Wq54DMofc=; b=F01YP95HDttie1VQJsRtJDMl0k1/UmIOXhj+SiunW0fO
 6oz3Q0FENL7PMEHtUMIFIGc5kAGld9JSejivUkGpYe08p+mGGhLe7m1n00sR5K3F
 ZLKs/wdvHCgE7rDk8tS8w/7BoeXVx0lx3rpKOz0Kh8SzASKXjLVJwoQr293s2/8b
 ArjsBCcLqLBTmZxqEZ6wKipTzCYzG7qh4h1cBUUQ7ipEN6Ve0+Ru4N/8uF70XwLL
 0kUbgea8LbicoPc9pSq6dK1XiCfdhcnzHIkkZAltmfE9ZiuxWTRGwe1uXgTg8DF5
 2ZTELt75Kc+wjhAOrwLDWAE6SQ7xGlrPazD8KshoFg==
X-ME-Sender: <xms:ianiZlskiJTiBz0Zwr7NXXt0uvXQAvHoAzaKrsas6FY_QwJUkxDtng>
 <xme:ianiZudYe0SnxsFO1tjsoTf_BF3ON5L3W5Jrv8oxcbzUvxfEYhgMn5eOXVg8M2McW
 Yd4VJKTMxgOJ84JcoI>
X-ME-Received: <xmr:ianiZoy8uDgdsi4pSY3Y2km4v-38i148w6IU8h088HczQSAeL87xTeV32TDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepveejtdejteevfefhffehiedvffdvudelvdeigfek
 feevledtieetffehgeeggfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmhhsoh
 hnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ianiZsN7AZ7qcWJTNXarfPjFOhB8vO3FPGu4FN_eQDkUid8Fi2UGjw>
 <xmx:ianiZl-o2gmQ25Rn-uuy5Urw5oPcLFFc5kO1Q6n--tSsPzu0Rk7RqQ>
 <xmx:ianiZsWm2b8BXUIBptopkyBtt7tZC3JNW8SIrXeKq1pami1MKdnFSw>
 <xmx:ianiZmeRukFiNABAaJ6KYALailrGuP8dhpKwE-vmNyBAq49LAzMLQA>
 <xmx:iqniZomRFicVOvzET7GM7099WA7cnhTnPGmExl0aeV8brDOnSFP4eUTZ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 04:42:49 -0400 (EDT)
Date: Thu, 12 Sep 2024 10:42:48 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>, kbusch@kernel.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 1/1] hw/nvme: add atomic write support
Message-ID: <ZuKpiJ73xmL-KGoV@AALNPWKJENSEN.aal.scsc.local>
References: <20240820161123.316887-1-alan.adamson@oracle.com>
 <20240820161123.316887-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820161123.316887-2-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Aug 20 09:11, Alan Adamson wrote:
> Adds support for the controller atomic parameters: AWUN and AWUPF. Atomic
> Compare and Write Unit (ACWU) is not currently supported.
> 
> Writes that adhere to the ACWU and AWUPF parameters are guaranteed to be atomic.
> 
> New NVMe QEMU Parameters (See NVMe Specification for details):
>        atomic.dn (default off) - Set the value of Disable Normal.
>        atomic.awun=UINT16 (default: 0)
>        atomic.awupf=UINT16 (default: 0)
> 
> By default (Disable Normal set to zero), the maximum atomic write size is
> set to the AWUN value.  If Disable Normal is set, the maximum atomic write
> size is set to AWUPF.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>

LGTM. I can fix up the few nits below.

Keith, I'll let this linger a few days for you to comment :)

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
>  hw/nvme/ctrl.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h |  12 ++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c6d4f61a47f9..ac0efa95588d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -40,6 +40,9 @@
>   *              sriov_vi_flexible=<N[optional]> \
>   *              sriov_max_vi_per_vf=<N[optional]> \
>   *              sriov_max_vq_per_vf=<N[optional]> \
> + *              atomic.dn=<on|off[optional]>, \
> + *              atomic.awun<N[optional]>, \
> + *              atomic.awupf<N[optional]>, \
>   *              subsys=<subsys_id>
>   *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
>   *              zoned=<true|false[optional]>, \
> @@ -241,6 +244,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
>      [NVME_INTERRUPT_COALESCING]     = true,
>      [NVME_INTERRUPT_VECTOR_CONF]    = true,
>      [NVME_WRITE_ATOMICITY]          = true,
> +    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,

Looks like a typo; can fix when I pick this up.

>      [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
>      [NVME_TIMESTAMP]                = true,
>      [NVME_HOST_BEHAVIOR_SUPPORT]    = true,
> @@ -254,6 +258,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
>      [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
>      [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
>      [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
> +    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,
>      [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
>      [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
>      [NVME_HOST_BEHAVIOR_SUPPORT]    = NVME_FEAT_CAP_CHANGE,
> @@ -6294,7 +6299,10 @@ defaults:
>              return ret;
>          }
>          goto out;

Not introduced in this patch, but I'll drop this useless goto as well.

> +        break;
>  
> +    case NVME_WRITE_ATOMICITY:
> +        result = n->dn;
>          break;
>      default:
>          result = nvme_feature_default[fid];
> @@ -6378,6 +6386,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>      uint8_t save = NVME_SETFEAT_SAVE(dw10);
>      uint16_t status;
>      int i;
> +    NvmeIdCtrl *id = &n->id_ctrl;
> +    NvmeAtomic *atomic = &n->atomic;
>  
>      trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
>  
> @@ -6530,6 +6540,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>          return NVME_CMD_SEQ_ERROR | NVME_DNR;
>      case NVME_FDP_EVENTS:
>          return nvme_set_feature_fdp_events(n, ns, req);
> +    case NVME_WRITE_ATOMICITY:
> +
> +        n->dn = 0x1 & dw11;
> +
> +        if (n->dn) {
> +            atomic->atomic_max_write_size = id->awupf + 1;
> +        } else {
> +            atomic->atomic_max_write_size = id->awun + 1;
> +        }
> +
> +        if (atomic->atomic_max_write_size == 1) {
> +            atomic->atomic_writes = 0;
> +        } else {
> +            atomic->atomic_writes = 1;
> +        }
> +        break;
>      default:
>          return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>      }
> @@ -7227,6 +7253,79 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
>      trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
>  }
>  
> +#define NVME_ATOMIC_NO_START        0
> +#define NVME_ATOMIC_START_ATOMIC    1
> +#define NVME_ATOMIC_START_NONATOMIC 2
> +
> +static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
> +    NvmeAtomic *atomic)
> +{
> +    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
> +    uint64_t slba = le64_to_cpu(rw->slba);
> +    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
> +    uint64_t elba = slba + nlb;
> +    bool cmd_atomic_wr = true;
> +    int i;
> +
> +    if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
> +        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
> +        cmd_atomic_wr = false;
> +    }
> +
> +    /*
> +     * Walk the queues to see if there are any atomic conflicts.
> +     */
> +    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
> +        NvmeSQueue *sq;
> +        NvmeRequest *req;
> +        NvmeRwCmd *req_rw;
> +        uint64_t req_slba;
> +        uint32_t req_nlb;
> +        uint64_t req_elba;
> +
> +        sq = n->sq[i];
> +        if (!sq) {
> +            break;
> +        }
> +
> +        /*
> +         * Walk all the requests on a given queue.
> +         */
> +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> +            req_rw = (NvmeRwCmd *)&req->cmd;
> +
> +            if (cmd->nsid == req->ns->params.nsid) {
> +                req_slba = le64_to_cpu(req_rw->slba);
> +                req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
> +                req_elba = req_slba + req_nlb;
> +
> +                if (cmd_atomic_wr) {
> +                    if ((elba >= req_slba) && (slba <= req_elba)) {
> +                        return NVME_ATOMIC_NO_START;
> +                    }
> +                } else {
> +                    if (req->atomic_write && ((elba >= req_slba) &&
> +                        (slba <= req_elba))) {
> +                        return NVME_ATOMIC_NO_START;
> +                    }
> +                }
> +            }
> +        }
> +    }
> +    if (cmd_atomic_wr) {
> +        return NVME_ATOMIC_START_ATOMIC;
> +    }
> +    return NVME_ATOMIC_START_NONATOMIC;
> +}
> +
> +static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
> +{
> +    if (n->atomic.atomic_writes) {
> +        return &n->atomic;
> +    }
> +    return NULL;
> +}
> +
>  static void nvme_process_sq(void *opaque)
>  {
>      NvmeSQueue *sq = opaque;
> @@ -7243,6 +7342,9 @@ static void nvme_process_sq(void *opaque)
>      }
>  
>      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
> +        NvmeAtomic *atomic;
> +        bool cmd_is_atomic;
> +
>          addr = sq->dma_addr + (sq->head << NVME_SQES);
>          if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
>              trace_pci_nvme_err_addr_read(addr);
> @@ -7250,6 +7352,28 @@ static void nvme_process_sq(void *opaque)
>              stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
>              break;
>          }
> +
> +        atomic = nvme_get_atomic(n, &cmd);
> +
> +        cmd_is_atomic = false;
> +        if (sq->sqid && atomic) {
> +            int ret;
> +
> +            qemu_mutex_lock(&atomic->atomic_lock);
> +            ret = nvme_atomic_write_check(n, &cmd, atomic);
> +            switch (ret) {
> +            case NVME_ATOMIC_NO_START:
> +                qemu_bh_schedule(sq->bh);
> +                qemu_mutex_unlock(&atomic->atomic_lock);
> +                return;
> +            case NVME_ATOMIC_START_ATOMIC:
> +                cmd_is_atomic = true;
> +                break;
> +            case NVME_ATOMIC_START_NONATOMIC:
> +            default:
> +                break;
> +            }
> +        }
>          nvme_inc_sq_head(sq);
>  
>          req = QTAILQ_FIRST(&sq->req_list);
> @@ -7259,6 +7383,11 @@ static void nvme_process_sq(void *opaque)
>          req->cqe.cid = cmd.cid;
>          memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
>  
> +        if (sq->sqid && atomic) {
> +            req->atomic_write = cmd_is_atomic;
> +            qemu_mutex_unlock(&atomic->atomic_lock);
> +        }
> +
>          status = sq->sqid ? nvme_io_cmd(n, req) :
>              nvme_admin_cmd(n, req);
>          if (status != NVME_NO_COMPLETE) {
> @@ -7362,6 +7491,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
>      n->outstanding_aers = 0;
>      n->qs_created = false;
>  
> +    n->dn = n->params.atomic_dn; /* Set Disable Normal */
> +
>      nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>  
>      if (pci_is_vf(pci_dev)) {
> @@ -8465,6 +8596,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      uint8_t *pci_conf = pci_dev->config;
>      uint64_t cap = ldq_le_p(&n->bar.cap);
>      NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
> +    NvmeAtomic *atomic = &n->atomic;
>      uint32_t ctratt;
>  
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
> @@ -8574,6 +8706,30 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      if (pci_is_vf(pci_dev) && !sctrl->scs) {
>          stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
>      }
> +
> +    /* Atomic Write */
> +    id->awun = n->params.atomic_awun;
> +    id->awupf = n->params.atomic_awupf;
> +    n->dn = n->params.atomic_dn;
> +
> +    qemu_mutex_init(&atomic->atomic_lock);

We are not super consistent on this, but this should probably go in
nvme_init_state().

> +    if (id->awun || id->awupf) {
> +        if (id->awupf > id->awun) {
> +            id->awupf = 0;
> +        }
> +
> +        if (n->dn) {
> +            atomic->atomic_max_write_size = id->awupf + 1;
> +        } else {
> +            atomic->atomic_max_write_size = id->awun + 1;
> +        }
> +
> +        if (atomic->atomic_max_write_size == 1) {
> +            atomic->atomic_writes = 0;
> +        } else {
> +            atomic->atomic_writes = 1;
> +        }
> +    }
>  }
>  
>  static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
> @@ -8675,6 +8831,8 @@ static void nvme_exit(PCIDevice *pci_dev)
>          nvme_subsys_unregister_ctrl(n->subsys, n);
>      }
>  
> +    qemu_mutex_destroy(&n->atomic.atomic_lock);
> +
>      g_free(n->cq);
>      g_free(n->sq);
>      g_free(n->aer_reqs);
> @@ -8734,6 +8892,9 @@ static Property nvme_props[] = {
>                       false),
>      DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>      DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +    DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
> +    DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
> +    DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index 781985754d0d..4d8582e6f2a5 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -220,6 +220,12 @@ typedef struct NvmeNamespaceParams {
>      } fdp;
>  } NvmeNamespaceParams;
>  
> +typedef struct NvmeAtomic {
> +    uint32_t    atomic_max_write_size;
> +    QemuMutex   atomic_lock;
> +    bool        atomic_writes;
> +} NvmeAtomic;
> +
>  typedef struct NvmeNamespace {
>      DeviceState  parent_obj;
>      BlockConf    blkconf;
> @@ -421,6 +427,7 @@ typedef struct NvmeRequest {
>      NvmeCmd                 cmd;
>      BlockAcctCookie         acct;
>      NvmeSg                  sg;
> +    bool                    atomic_write;
>      QTAILQ_ENTRY(NvmeRequest)entry;
>  } NvmeRequest;
>  
> @@ -538,6 +545,9 @@ typedef struct NvmeParams {
>      uint32_t  sriov_max_vq_per_vf;
>      uint32_t  sriov_max_vi_per_vf;
>      bool     msix_exclusive_bar;
> +    uint16_t atomic_awun;
> +    uint16_t atomic_awupf;
> +    bool     atomic_dn;
>  } NvmeParams;
>  
>  typedef struct NvmeCtrl {
> @@ -619,6 +629,8 @@ typedef struct NvmeCtrl {
>          uint16_t    vqrfap;
>          uint16_t    virfap;
>      } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
> +    uint32_t    dn; /* Disable Normal */
> +    NvmeAtomic  atomic;
>  } NvmeCtrl;
>  
>  typedef enum NvmeResetType {
> -- 
> 2.43.5
> 
> 

