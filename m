Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B825FC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwI3W-0001sE-Bb; Tue, 18 Aug 2026 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwI3T-0001rc-PL; Tue, 18 Aug 2026 07:32:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwI3R-0000oJ-O6; Tue, 18 Aug 2026 07:32:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67IBVjKM069137
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Aug 2026 20:31:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HGztCwXSzmO+tRApV6D6qoPijGlMR+1m3KpNzRiLiyg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787052706; v=1;
 b=GF1KW2ZAiNcjeYMqOfdLwnas2aCKru8PiNTPhri/o/0c/u9dCSs6q9h9o4HOLdOV
 YosHhUxd1BO10huDkzOKgBuSvBFXFrS1dHWGdBNddUtAQ+++/S2ldfO3mv6/5oud
 1xYLZ+Os+tlSkxVLr07NSLTqJUZslvKhUnFOZ6kFlvabqg2ixXroptCQGA6Fadx3
 0SwGXpkn7o2YmpnsrJ7jQ5vln1fpjAphhBEbI+BaUZxkzEdosHS1xGdQzUc6WZaj
 fjVB90U6LLdduvWfmy8DoBucOz+5vl7IOZdcQ1WMr9KGJmbXiqJVIUSl73gcv3qE
 zdCjN4uB2RoM36ICPtn4+A==
Message-ID: <7838ab96-38a7-48ea-8a4c-3f7784559e1d@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Aug 2026 20:31:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/13] hw/virtio/vhost-user: send isolation regions
 to device
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-8-948aae960abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2026/08/18 14:12, Connor Kite wrote:
> Adds features to fill a vhost_user_set_mem_table message with the
> addresses of isolation memory regions corresponding to bounce buffers
> and vrings.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 7e9233e174..e1e5cba53d 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1140,7 +1140,77 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
>       }
>   }
>   
> -__attribute__((unused))
> +typedef struct {
> +    VhostUserMsg *msg;
> +    struct vhost_user *u;
> +    int *fds;
> +    size_t fds_size;
> +    uint64_t vring_iova;
> +    size_t vring_size;
> +    bool vring_node_visited;
> +    size_t *idx;
> +} IOVATreeTraversalArgs;
> +
> +static gboolean vhost_user_fill_msg_reg_from_tree(gpointer key,
> +                                                  gpointer value,
> +                                                  gpointer data)
> +{
> +    IOVATreeTraversalArgs *args = data;
> +    struct vhost_user *u;
> +    VhostUserMsg *msg = args->msg;
> +    DMAMap *map = key;
> +    uint64_t offset;
> +
> +    assert(args && key && value);
> +    if (!args->vring_node_visited) {
> +        args->vring_node_visited = true;
> +        return false;
> +    }
> +
> +    u = args->u;
> +    assert(*args->idx < args->fds_size);
> +
> +    args->fds[*args->idx] = args->u->iso_mem_ctx.fd;
> +
> +    /*
> +     * If the number of regions is fixed, it would be wasteful to use one for
> +     * only the vrings. The first vhost_iova_tree element is always
> +     * reserved for the vrings, so we can simply combine the first and second
> +     * elements, which are contiguous in IOVA space, when sending regions to
> +     * the backend.
> +     */
> +    if (*args->idx == 0) {
> +        offset = u->iso_mem_ctx.vring_hva_addr - u->iso_mem_ctx.shared_mem_addr;
> +        msg->payload.memory.regions[*args->idx].userspace_addr =
> +            args->vring_iova;
> +        /*
> +         * The size from the iova tree is inclusive, so 1 is added to it.
> +         * args->vring_size is exclusive, so no addition is required.
> +         */
> +        msg->payload.memory.regions[*args->idx].memory_size =
> +            args->vring_size + map->size + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr =
> +            args->vring_iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
> +    } else {
> +        /* Use 128 bit operation in unlikely case of negative iso_iova_offset */
> +        offset = int128_get64(int128_add(int128_make64(map->iova),
> +                                        u->iso_mem_ctx.iso_iova_offset)) -
> +                (uint64_t)u->iso_mem_ctx.shared_mem_addr;
> +
> +        msg->payload.memory.regions[*args->idx].userspace_addr = map->iova;
> +        msg->payload.memory.regions[*args->idx].memory_size = map->size + 1;
> +        msg->payload.memory.regions[*args->idx].guest_phys_addr = map->iova;
> +        msg->payload.memory.regions[*args->idx].mmap_offset = offset;
> +    }
> +
> +    assert(offset + msg->payload.memory.regions[*args->idx].memory_size <=
> +        u->iso_mem_ctx.size);
> +    (*args->idx)++;
> +
> +    return false;
> +}
> +
>   static int init_isolation_regions(struct vhost_dev *dev,
>                                     VhostUserMsg *msg,
>                                     int *fds, size_t *fd_num)
> @@ -1159,6 +1229,7 @@ static int init_isolation_regions(struct vhost_dev *dev,
>       DMAMap *map;
>       DMAMap vring_map;
>       int r;
> +    IOVATreeTraversalArgs trav_args;
>   
>       msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
>   
> @@ -1244,6 +1315,27 @@ static int init_isolation_regions(struct vhost_dev *dev,
>           }
>       }
>   
> +    *fd_num = 0;
> +    trav_args.idx = fd_num;
> +    trav_args.fds = fds;
> +    trav_args.msg = msg;
> +    trav_args.u = u;
> +    trav_args.vring_iova = vring_map.iova;
> +    trav_args.vring_size = total_vring_size;
> +    trav_args.fds_size = nregions;
> +    trav_args.vring_node_visited = false;
> +
> +    vhost_iova_tree_foreach(u->iso_mem_ctx.tree,
> +                            vhost_user_fill_msg_reg_from_tree, &trav_args);
> +
> +    msg->payload.memory.nregions = *fd_num;
> +
> +    assert(*fd_num == nregions);
> +
> +    msg->hdr.size = sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size += sizeof(msg->payload.memory.padding);
> +    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
> +
>       return 0;
>   }
>   
> @@ -1251,6 +1343,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
>       struct vhost_user *u = dev->opaque;
> +    bool memory_isolation = u->user->memory_isolation;
>       int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>       size_t fd_num = 0;
>       bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
> @@ -1262,6 +1355,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>       int ret;
>   
>       if (do_postcopy) {
> +        /* Postcopy is not supported with memory isolation yet */
> +        if (memory_isolation) {
> +            return -1;
> +        }
> +
>           /*
>            * Postcopy has enough differences that it's best done in it's own
>            * version
> @@ -1278,6 +1376,24 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>           msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
>       }
>   
> +    if (memory_isolation) {
> +        ret = init_isolation_regions(dev, &msg, fds, &fd_num);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        ret = vhost_user_write(dev, &msg, fds, fd_num);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        if (reply_supported) {
> +            return process_message_reply(dev, &msg);
> +        }
> +
> +        return 0;
> +    }
> +

This bypasses vhost_user_fill_set_mem_table_msg() below and suppresses 
the error saying: "Failed initializing vhost-user memory map, consider 
using -object memory-backend-file share=on"

However, vhost-user doesn't work even with memory isolation in such a 
case because vhost_user_no_private_memslots() always returns true and 
that makes vhost_section() filter private memory out. This restriction 
is unnecessary with memory isolation and can be removed instead of 
restoring the error.

This also lacks handling of VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, 
and will overflow fds and VhostUserMemory::regions when 
VHOST_USER_GET_MAX_MEM_SLOTS is larger than VHOST_MEMORY_BASELINE_NREGIONS.

Regards,
Akihiko Odaki

>       if (config_mem_slots) {
>           ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
>           if (ret < 0) {
> 


