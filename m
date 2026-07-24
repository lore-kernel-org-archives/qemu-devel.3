Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52031C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDh0-0003xK-II; Fri, 24 Jul 2026 07:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnDgx-0003wb-UC; Fri, 24 Jul 2026 07:03:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnDgu-0008GR-C9; Fri, 24 Jul 2026 07:03:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66OAupKN038437
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 19:56:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2pdlWsSuVpsai6GC/EcJ3GSskJCjCX7woWYIN6lY3Pw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784890612; v=1;
 b=Jie1BZVT3UyiZpwZUzpjOjAxeDQJ9MYLewSWI3W5hrZwLJG/bL7lEYrAW8ODapS1
 wGLkFACE3K9HbZ6vZfDCt+kq7ihjEhhu4Bqfy5qYfca/2aEGd2TF6la7IDRVBaQg
 6VIjEjlFufC0pmmq/8tuDnjGe+C7mSNIrcSXPdcufMRVQBzP7ibZ5FZqkLibX3OO
 hh4p0HO+Dez11obf/NKHfnQyYLqXumd0EWsOwSZ+oJtiuDyRFRnUaeWp0seMQF9v
 ZaQIfKS2LVMGR5CAWmap/Bp9DdsSxKsb9vO8sRBRdn7Tz+wjmyszpEhLrYxE8EwB
 3IMPvyNA8aDJvW04hZFvQA==
Message-ID: <283bc630-2538-469b-a296-7da57d2e4c3a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 19:56:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: ConKite <connorkite@gmail.com>, qemu-devel@nongnu.org
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
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
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

On 2026/07/24 7:30, ConKite wrote:
> In support of future work to add a memory isolation mode to vhost-user devices, a
> qdev property, "memory-isolation", is added to all vhost-user devices. This is
> simply a bool representing whether the mode is active or not.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This and the next patch add interfaces before implementation. Perhaps 
it's better reversed.

Regards,
Akihiko Odaki

> ---
>   hw/block/vhost-user-blk.c            | 1 +
>   hw/display/vhost-user-gpu.c          | 1 +
>   hw/scsi/vhost-user-scsi.c            | 1 +
>   hw/virtio/vhost-user-base.c          | 3 ++-
>   hw/virtio/vhost-user-fs.c            | 1 +
>   hw/virtio/vhost-user-scmi.c          | 1 +
>   hw/virtio/vhost-user-vsock.c         | 1 +
>   include/hw/virtio/vhost-user-base.h  | 1 +
>   include/hw/virtio/vhost-user-blk.h   | 1 +
>   include/hw/virtio/vhost-user-fs.h    | 1 +
>   include/hw/virtio/vhost-user-scmi.h  | 1 +
>   include/hw/virtio/vhost-user-vsock.h | 1 +
>   include/hw/virtio/virtio-gpu.h       | 1 +
>   include/hw/virtio/virtio-scsi.h      | 1 +
>   14 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 2e5b3ae1b1..9830dc6c35 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -631,6 +631,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>   
>   static const Property vhost_user_blk_properties[] = {
>       DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBlk, memory_isolation, false),
>       DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>                          VHOST_USER_BLK_AUTO_NUM_QUEUES),
>       DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 57360898ca..6d0ede672a 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -659,6 +659,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
>   
>   static const Property vhost_user_gpu_properties[] = {
>       VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
> +    DEFINE_PROP_BOOL("memory-isolation", VhostUserGPU, memory_isolation, false),
>   };
>   
>   static void
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 5070178dc2..c1a0393220 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -346,6 +346,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
>   
>   static const Property vhost_user_scsi_properties[] = {
>       DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VirtIOSCSICommon, conf.memory_isolation, false),
>       DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
>                          VIRTIO_SCSI_AUTO_NUM_QUEUES),
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 90bd2903db..d2a74a2860 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -409,7 +409,8 @@ static void vub_device_unrealize(DeviceState *dev)
>   
>   /*Define common qdev properties.  Inherited by all children*/
>   static const Property vub_properties[] = {
> -    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation, false)
>   };
>   
>   
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 209993918a..3d980d814b 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -410,6 +410,7 @@ static const VMStateDescription vuf_backend_vmstate = {
>   
>   static const Property vuf_properties[] = {
>       DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserFS, conf.memory_isolation, false),
>       DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
>       DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
>                          conf.num_request_queues, 1),
> diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
> index 02dc088ea9..d514d89392 100644
> --- a/hw/virtio/vhost-user-scmi.c
> +++ b/hw/virtio/vhost-user-scmi.c
> @@ -287,6 +287,7 @@ static const VMStateDescription vu_scmi_vmstate = {
>   
>   static const Property vu_scmi_properties[] = {
>       DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserSCMI, memory_isolation, false),
>   };
>   
>   static void vu_scmi_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
> index c2cd376e73..89aa789e22 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -154,6 +154,7 @@ static void vuv_device_unrealize(DeviceState *dev)
>   
>   static const Property vuv_properties[] = {
>       DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserVSock, conf.memory_isolation, false),
>   };
>   
>   static void vuv_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
> index d5d2f081ae..29bc40736c 100644
> --- a/include/hw/virtio/vhost-user-base.h
> +++ b/include/hw/virtio/vhost-user-base.h
> @@ -25,6 +25,7 @@ struct VHostUserBase {
>       uint32_t num_vqs;
>       uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
>       uint32_t config_size;
> +    bool memory_isolation;
>       /* State tracking */
>       VhostUserState vhost_user;
>       struct vhost_virtqueue *vhost_vq;
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index dee848cfd8..8126447a86 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -30,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserBlk, VHOST_USER_BLK)
>   struct VHostUserBlk {
>       VirtIODevice parent_obj;
>       CharFrontend chardev;
> +    bool memory_isolation;
>       int32_t bootindex;
>       struct virtio_blk_config blkcfg;
>       uint16_t num_queues;
> diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
> index 5699ea03a1..bf71990b9c 100644
> --- a/include/hw/virtio/vhost-user-fs.h
> +++ b/include/hw/virtio/vhost-user-fs.h
> @@ -28,6 +28,7 @@ typedef struct {
>       char *tag;
>       uint16_t num_request_queues;
>       uint16_t queue_size;
> +    bool memory_isolation;
>   } VHostUserFSConf;
>   
>   struct VHostUserFS {
> diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
> index 30ab0d7ab7..d346b42ed8 100644
> --- a/include/hw/virtio/vhost-user-scmi.h
> +++ b/include/hw/virtio/vhost-user-scmi.h
> @@ -19,6 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
>   struct VHostUserSCMI {
>       VirtIODevice parent;
>       CharFrontend chardev;
> +    bool memory_isolation;
>       struct vhost_virtqueue *vhost_vqs;
>       struct vhost_dev vhost_dev;
>       VhostUserState vhost_user;
> diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
> index 5db6938b8b..6288b26fa4 100644
> --- a/include/hw/virtio/vhost-user-vsock.h
> +++ b/include/hw/virtio/vhost-user-vsock.h
> @@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserVSock, VHOST_USER_VSOCK)
>   
>   typedef struct {
>       CharFrontend chardev;
> +    bool memory_isolation;
>   } VHostUserVSockConf;
>   
>   struct VHostUserVSock {
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index b9bad27c97..707612c3a4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -277,6 +277,7 @@ struct VhostUserGPU {
>       CharFrontend vhost_chr;
>       QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
>       bool backend_blocked;
> +    bool memory_isolation;
>   };
>   
>   #define MAX_SLOTS 4096
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index b6028bb5cd..47fdc3785c 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -59,6 +59,7 @@ struct VirtIOSCSIConf {
>       char *vhostfd;
>       char *wwpn;
>       CharFrontend chardev;
> +    bool memory_isolation;
>       uint32_t boot_tpgt;
>       IOThread *iothread;
>       IOThreadVirtQueueMappingList *iothread_vq_mapping_list;
> 


