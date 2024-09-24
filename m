Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4ADCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4Sc-00078D-Lq; Tue, 24 Sep 2024 08:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1st4SI-00073v-Hw; Tue, 24 Sep 2024 08:15:48 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1st4SC-0002Vk-CO; Tue, 24 Sep 2024 08:15:44 -0400
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 3F928138017B;
 Tue, 24 Sep 2024 08:15:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 08:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727180137; x=
 1727266537; bh=sDkZYUlEebev3X8Gg5i5IXsRDNbMpGeW6LuIFlF1sK4=; b=p
 roNbykpQynV/Zwl3LHRmGMux4AHu8feuAnHHqEasvUtLFwj+crvrQ3MkCRts18bF
 0CH1NPkiR71QMripLGNF/8aicOuHGT9Of88D2gt+GfMkO/eDd4evPGcRkyfBVYE1
 VyQ8/CkYL3Fv+R4B+adsd9R/qgoOIp46VCuYBMl6tip7QZanIYDtYaPHlHW8nrXo
 ILebJsmzGBL1x6n0k67fy+PcmFJMEP11nxJnsd58XEu9ISk2G02rUspgzhkZDJ4x
 gwQOYAC3nAcmt9R7El5cCRmXhFfQ+Wd/BZ97cSnfkkqPht2Rszlbk7TkH4i4nieS
 ZYNWoms50lvsw3Z/K8adQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727180137; x=1727266537; bh=sDkZYUlEebev3X8Gg5i5IXsRDNbM
 pGeW6LuIFlF1sK4=; b=MyRwWLdcYz4mjOOKNa9FIGox4osnrc+yfp+naGqYTS0i
 kZa5qacDrVSWN93SeQK0TQF6pWmbg1anfJ8dYW7+sBhO1+AV5DM0rJ/uXosXVYWz
 uBI34Ia+BkdCb0Fh8OVi1d5VrcNyOLSGK1h6EIXI22nrE7X7N9aKsxSLfHL23EjT
 krT6Sq2UtEFAb/eGBWyLnl2L1mAK7W9FZFmpp30B44PIuQMcqsIGWEsoJbMxTV/J
 prYAPO52vK80UduXtoFB/6WC4hjCH5ugisKFZzJQZeE7+cY9iPVdjcSJrODDxQM7
 vC2qlqkuD3rk0vKks4X5iy7EV62hyDAUqKYbMjE7Mw==
X-ME-Sender: <xms:aK3yZrZ6V67KDc55H5TwuCbNE3bnoiZtEkiAnL6NeL4Ru8eqzncoLg>
 <xme:aK3yZqbfPA_y-gotSeMosxafTyHGHFnBRcXKCiWxKjWozHPDVjlepKGuLd5-98pGm
 NeoFuL0uBeKkWynJ7g>
X-ME-Received: <xmr:aK3yZt-1Qkb5d-s9_7ATb_vWo0hOwXSvwlh3MK7f7drSwnCLcNFNRrpgk5LflA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepveejtdejteevfefhffehiedvffdvudelvdeigfek
 feevledtieetffehgeeggfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmhhsoh
 hnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtph
 htthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:aK3yZho2RSrPd_CmKjdMP5JguOWQ7MBi_0NpkLA6g7u9FuGaEMisDA>
 <xmx:aK3yZmopT9Yr7n_L4DGddLVyF5x68Cufhcd8pkjY7ZfnCOSC5nMtfw>
 <xmx:aK3yZnR6iPm9_YFpPVHbGSvO6ZETRQPp679nKefmMnRkeBr4g2asQg>
 <xmx:aK3yZursrcpF3U14JzeDZYXE6FQThNNEhQsD2ZaLjlbYs6h-lO81tw>
 <xmx:aa3yZjDse9K73OufB_BFElCf-Q8DG4JGu7HkIyYRBnQQYVRh_gNOLDuq>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 08:15:35 -0400 (EDT)
Date: Tue, 24 Sep 2024 14:15:34 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/1] hw/nvme: add atomic write support
Message-ID: <ZvKtZkmZNuw9_Qzf@AALNPWKJENSEN.aal.scsc.local>
References: <20240920000721.993119-1-alan.adamson@oracle.com>
 <20240920000721.993119-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920000721.993119-2-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sep 19 17:07, Alan Adamson wrote:
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
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h |  12 ++++
>  2 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 9e94a2405407..0af46c57ee86 100644
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
> @@ -254,6 +257,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
>      [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
>      [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
>      [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
> +    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,
>      [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
>      [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
>      [NVME_HOST_BEHAVIOR_SUPPORT]    = NVME_FEAT_CAP_CHANGE,
> @@ -6293,8 +6297,10 @@ defaults:
>          if (ret) {
>              return ret;
>          }
> -        goto out;
> +        break;
>  
> +    case NVME_WRITE_ATOMICITY:
> +        result = n->dn;
>          break;
>      default:
>          result = nvme_feature_default[fid];
> @@ -6378,6 +6384,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>      uint8_t save = NVME_SETFEAT_SAVE(dw10);
>      uint16_t status;
>      int i;
> +    NvmeIdCtrl *id = &n->id_ctrl;
> +    NvmeAtomic *atomic = &n->atomic;
>  
>      trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
>  
> @@ -6530,6 +6538,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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

le16_to_cpu()'s needed here.

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
> @@ -7227,6 +7251,80 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
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

This needs to be a `continue`.

> +        }
> +
> +        /*
> +         * Walk all the requests on a given queue.
> +         */
> +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> +            req_rw = (NvmeRwCmd *)&req->cmd;
> +
> +            if (((req_rw->opcode == NVME_CMD_WRITE) || (req_rw->opcode == NVME_CMD_READ)) &&
> +                (cmd->nsid == req->ns->params.nsid)) {
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
> @@ -7243,6 +7341,9 @@ static void nvme_process_sq(void *opaque)
>      }
>  
>      while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
> +        NvmeAtomic *atomic;
> +        bool cmd_is_atomic;
> +
>          addr = sq->dma_addr + (sq->head << NVME_SQES);
>          if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
>              trace_pci_nvme_err_addr_read(addr);
> @@ -7250,6 +7351,28 @@ static void nvme_process_sq(void *opaque)
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

I don't think this needs to be protected by a lock. The nvme emulation
is running in the main loop, so a Set Feature cannot be processed at the
same time as this. I think that is what we are expecting to guard
against?

If I/O queues were processed from an iothread, this would be needed, but
then we also need to take the lock when processing the feature and a
bunch of other stuff might become more complicated.

For now, I think it can just be dropped since if we enable the user to
attach an iothread, my intention is to reduce such complexity by
disabling all the "faked" features of the device.

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
> @@ -7259,6 +7382,11 @@ static void nvme_process_sq(void *opaque)
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
> @@ -7362,6 +7490,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
>      n->outstanding_aers = 0;
>      n->qs_created = false;
>  
> +    n->dn = n->params.atomic_dn; /* Set Disable Normal */
> +
>      nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>  
>      if (pci_is_vf(pci_dev)) {
> @@ -8138,6 +8268,8 @@ static void nvme_init_state(NvmeCtrl *n)
>      NvmeSecCtrlEntry *list = n->sec_ctrl_list;
>      NvmeSecCtrlEntry *sctrl;
>      PCIDevice *pci = PCI_DEVICE(n);
> +    NvmeAtomic *atomic = &n->atomic;
> +    NvmeIdCtrl *id = &n->id_ctrl;
>      uint8_t max_vfs;
>      int i;
>  
> @@ -8195,6 +8327,31 @@ static void nvme_init_state(NvmeCtrl *n)
>                          cpu_to_le16(n->params.sriov_max_vi_per_vf) :
>                          cap->vifrt / MAX(max_vfs, 1);
>      }
> +
> +    /* Atomic Write */
> +    id->awun = n->params.atomic_awun;
> +    id->awupf = n->params.atomic_awupf;

This is missing cpu_to_le16()'s.

> +    n->dn = n->params.atomic_dn;
> +
> +    qemu_mutex_init(&atomic->atomic_lock);
> +
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
>  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> @@ -8675,6 +8832,8 @@ static void nvme_exit(PCIDevice *pci_dev)
>          nvme_subsys_unregister_ctrl(n->subsys, n);
>      }
>  
> +    qemu_mutex_destroy(&n->atomic.atomic_lock);
> +
>      g_free(n->cq);
>      g_free(n->sq);
>      g_free(n->aer_reqs);
> @@ -8734,6 +8893,9 @@ static Property nvme_props[] = {
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

