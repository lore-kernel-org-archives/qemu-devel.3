Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175E6C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnG70-0003ZK-3b; Fri, 24 Jul 2026 09:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnG6x-0003Y9-Dq; Fri, 24 Jul 2026 09:38:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnG6u-0008Si-HR; Fri, 24 Jul 2026 09:38:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66ODX4EU091774
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 22:33:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1zW6Tv1h4d8+uZR56utH7MO8nsBorHhTP/SbCJgwdOk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784899985; v=1;
 b=KqfJDV4oVAaXNpq1gyJ0Bp9ArlbU3lKuAhKbpKznY56uKJbu5C8jbqu1iGG3eAgp
 RaI1zCIa1m7WNM39CzsjeTWGRUkg1wTOR4VaSdRcVkzGJSf0M0fnrDklV+X0BPQd
 Kc+TQSxhlz1LOaZrl8cDHZbST1Zc2t1azo5eCR1F1GrSyTw7CzFgw+N7QKu0fOSn
 feVnaIArQucANAJuKax1VhDu49fwcJQemwnpXit7FHQDfO3dtXWK283frbVXVpmZ
 XzFcXM2ZB1s+8e8e1fQj/inlctrWO6Wd8RXzWlS4VNs2L28L7muTt+zMtgca7Wws
 A0YunDNv2LX6msrJuHUGgQ==
Message-ID: <a0580312-28d3-4cac-82d3-20b211b7038a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 22:33:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
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
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
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

On 2026/07/24 7:30, Connor Kite wrote:
> Adds features to fill a vhost_user_set_mem_table message with the
> addresses of isolation memory regions corresponding to bounce buffers
> and vrings.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 710cf966f8..acabfb7f1c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -625,6 +625,21 @@ static void vhost_user_fill_msg_region(struct vhost_dev *dev,
>       dst->mmap_offset = mmap_offset;
>   }
>   
> +static void vhost_user_fill_msg_region_iso(VhostUserMemoryRegion *dst,
> +                                           const struct vhost_user *u,
> +                                           const struct vhost_memory_region
> +                                           *iova_reg)
> +{
> +    assert(u != NULL && dst != NULL && iova_reg != NULL);
> +    uint64_t offset;
> +
> +    offset = iova_reg->userspace_addr - u->iso_memory.base_addr;
> +    dst->userspace_addr = iova_reg->userspace_addr;
> +    dst->memory_size = iova_reg->memory_size;
> +    dst->guest_phys_addr = iova_reg->userspace_addr;
> +    dst->mmap_offset = offset;
> +}
> +
>   static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
>                                                struct vhost_dev *dev,
>                                                VhostUserMsg *msg,
> @@ -1136,7 +1151,33 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
>       }
>   }
>   
> -__attribute__((unused))
> +struct iova_tree_traversal_args {
> +    VhostUserMsg *msg;
> +    struct vhost_user *u;
> +    int *fds;
> +    size_t *fd_num;
> +};
> +
> +static gboolean vhost_user_iova_tree_traverse_funct(gpointer key,
> +                                                    gpointer value,
> +                                                    gpointer data)

It is a bit odd naming. Functions usually do not have "funct" or similar 
suffixes.

> +{
> +    struct iova_tree_traversal_args *args = data;
> +    struct vhost_memory_region msg_region;
> +    VhostUserMemoryRegion region_buffer;
> +    DMAMap *map = key;
> +    args->fds[*args->fd_num] = args->u->iso_memory.iso_fd;

This may overrun the buffer because *args->fd_num is not checked as done 
in vhost_user_fill_set_mem_table_msg() for the non-isolation case.

> +
> +    msg_region.guest_phys_addr = map->iova;
> +    msg_region.memory_size = map->size + 1;
> +    msg_region.userspace_addr = map->iova;
> +    vhost_user_fill_msg_region_iso(&region_buffer, args->u, &msg_region);
> +    args->msg->payload.memory.regions[*args->fd_num] = region_buffer;
> +    (*args->fd_num)++;
> +
> +    return false;
> +}
> +
>   static int init_isolation_regions(struct vhost_dev *dev,
>                                     VhostUserMsg *msg,
>                                     int *fds, size_t *fd_num)
> @@ -1234,6 +1275,24 @@ static int init_isolation_regions(struct vhost_dev *dev,
>                                         map->translated_addr);
>       }
>   
> +    struct iova_tree_traversal_args args = {
> +        .fd_num = fd_num,
> +        .fds = fds,
> +        .msg = msg,
> +        .u = u
> +    };
> +
> +    vhost_iova_tree_foreach(u->iso_iova_tree,
> +                            vhost_user_iova_tree_traverse_funct, &args);
> +
> +    msg->payload.memory.nregions = *fd_num;
> +
> +    assert(*fd_num != 0);
> +
> +    msg->hdr.size = sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size += sizeof(msg->payload.memory.padding);
> +    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
> +
>       return 0;
>   }
>   
> @@ -1241,6 +1300,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                       struct vhost_memory *mem)
>   {
>       struct vhost_user *u = dev->opaque;
> +    bool memory_isolation = u->user->memory_isolation;
>       int fds[VHOST_MEMORY_BASELINE_NREGIONS];

This needs one more element for vring.

>       size_t fd_num = 0;
>       bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
> @@ -1268,6 +1328,24 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
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

This does not cover the postcopy path.

It also allocates memory that is never sent for vq_index != 0. The 
isolation regions need to be shared by all vqs. Please see 
vhost_user_write() for the context.

Regards,
Akihiko Odaki

>       if (config_mem_slots) {
>           ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
>           if (ret < 0) {
> 


