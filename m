Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BCACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b3z-0002HJ-E7; Tue, 14 Oct 2025 05:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8b3w-0002H4-95
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:11:20 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8b3q-00018j-3z
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:11:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0232280725;
 Tue, 14 Oct 2025 12:11:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4BLWnR1Fn4Y0-SfBt6hOe; Tue, 14 Oct 2025 12:11:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760433065;
 bh=zggkHftzRrSJgenlFKNUmQdS1mAZGUNrVi3IPjbgUBk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TsSJeAKji/qqi7fzCh3AHLs1x4nU00bs++ySf1kyMdno9z8U0+c6fgNRM0ok8KtG+
 j9GoP2QsZudZfAQX2ANri5Fq6m2mXHT8Tn93q2jibCQYactaDMzN1N8Z2pWvUuMFqg
 EP3AYNAPooPJxmwZxm8HLNuChw5NPRVZ+Lko/ZrY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0a05f02d-6841-435a-9828-04b170c7cf3a@yandex-team.ru>
Date: Tue, 14 Oct 2025 12:11:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] vhost: make vhost_dev.features private
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-7-vsementsov@yandex-team.ru>
 <CAFubqFvwnjZA16H8_rJ_miuPU0Wf2RqtYkV_Fr8YRhjDmP+QwA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFvwnjZA16H8_rJ_miuPU0Wf2RqtYkV_Fr8YRhjDmP+QwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 13.10.25 22:52, Raphael Norwitz wrote:
> There are places where the code switches logic to set/check
> features_ex rather than _features. If I'm reading the code correctly I
> don't think it makes a functional difference but it does make things
> pretty confusing.
> 
> I'd suggest having vhost_dev_has_feature() check _features rather than
> _features_ex or add a separate call to check
> vhost_dev_has_feature_ex()? At the least there should be a comment
> explaining that checking the start of _features_ex is the same as
> checking features because of the union definition?
> 

Hmm agree.. Honestly, I just don't like the split into features and features_ex,
IMO, it would be better always use _ex semantics, and then rename it to old
name without suffix.

And if keep split semantics for now, it's better to follow it consistently.

> On Sat, Oct 11, 2025 at 7:24 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> It's hard to control where and how do we use this field. Let's
>> cover all usages by getters/setters, and keep direct access to the
>> field only in vhost.c. It will help to control migration of this
>> field in further commits.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/display/vhost-user-gpu.c |  7 +++----
>>   hw/net/vhost_net.c          | 18 +++++++++---------
>>   hw/virtio/vdpa-dev.c        |  2 +-
>>   hw/virtio/vhost-user-base.c |  8 ++++++--
>>   hw/virtio/vhost-user.c      |  4 ++--
>>   hw/virtio/vhost.c           |  6 +++---
>>   hw/virtio/virtio-qmp.c      |  2 +-
>>   include/hw/virtio/vhost.h   | 27 +++++++++++++++++++++++++--
>>   net/vhost-vdpa.c            |  7 +++----
>>   9 files changed, 53 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
>> index 79ea64b12c..146620e0a3 100644
>> --- a/hw/display/vhost-user-gpu.c
>> +++ b/hw/display/vhost-user-gpu.c
>> @@ -631,17 +631,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
>>
>>       /* existing backend may send DMABUF, so let's add that requirement */
>>       g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED;
> 
> Here's one example of where things get confusing to read. We are now
> checking g->vhost->dev.features_ex rather than g->vhost->dev.features.
> 
>> -    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_VIRGL)) {
>> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_VIRGL)) {
>>           g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED;
>>       }
>> -    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_EDID)) {
>> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_EDID)) {
>>           g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_EDID_ENABLED;
>>       } else {
>>           error_report("EDID requested but the backend doesn't support it.");
>>           g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLED);
>>       }
>> -    if (virtio_has_feature(g->vhost->dev.features,
>> -        VIRTIO_GPU_F_RESOURCE_UUID)) {
>> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
>>           g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
>>       }
>>
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index ca19983126..323d117735 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -54,8 +54,8 @@ void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
>>   {
>>       virtio_features_clear(net->dev.acked_features_ex);
>>       if (net->backend == -1) {
>> -        net->dev.acked_features =
>> -           net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
>> +        net->dev.acked_features = (vhost_dev_features(&net->dev) &
>> +            (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
>>       } else if (!qemu_has_vnet_hdr(net->nc)) {
>>           net->dev.acked_features = 1ULL << VHOST_NET_F_VIRTIO_NET_HDR;
>>       }
>> @@ -282,15 +282,15 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>       if (backend_kernel) {
>>           if (!qemu_has_vnet_hdr_len(options->net_backend,
>>                                  sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
>> -            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
>> +            vhost_dev_clear_feature(&net->dev, VIRTIO_NET_F_MRG_RXBUF);
>>           }
>>
>>           if (!qemu_has_vnet_hdr(options->net_backend) &&
>> -            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
>> -            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
>> -                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
>> -             goto fail;
>> -         }
> 
> ditto here.
> 
>> +            !vhost_dev_has_feature(&net->dev, VHOST_NET_F_VIRTIO_NET_HDR)) {
>> +            fprintf(stderr, "vhost lacks VHOST_NET_F_VIRTIO_NET_HDR "
>> +                    "feature for backend\n");
>> +            goto fail;
>> +        }
>>       }
>>
>>       /* Set sane init value. Override when guest acks. */
>> @@ -298,7 +298,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>           virtio_features_from_u64(features,
>>                                    options->get_acked_features(net->nc));
>>           if (virtio_features_andnot(missing_features, features,
>> -                                   net->dev.features_ex)) {
>> +                                   vhost_dev_features_ex(&net->dev))) {
>>               fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
>>                       " for backend\n", VIRTIO_FEATURES_PR(missing_features));
>>               goto fail;
>> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>> index efd9f68420..e1a2ff433d 100644
>> --- a/hw/virtio/vdpa-dev.c
>> +++ b/hw/virtio/vdpa-dev.c
>> @@ -224,7 +224,7 @@ static uint64_t vhost_vdpa_device_get_features(VirtIODevice *vdev,
>>                                                  Error **errp)
>>   {
>>       VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
>> -    uint64_t backend_features = s->dev.features;
>> +    uint64_t backend_features = vhost_dev_features(&s->dev);
>>
>>       if (!virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM)) {
>>           virtio_clear_feature(&backend_features, VIRTIO_F_IOMMU_PLATFORM);
>> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
>> index ff67a020b4..cf311c3bfc 100644
>> --- a/hw/virtio/vhost-user-base.c
>> +++ b/hw/virtio/vhost-user-base.c
>> @@ -118,9 +118,13 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
>>                                    uint64_t requested_features, Error **errp)
>>   {
>>       VHostUserBase *vub = VHOST_USER_BASE(vdev);
>> +    uint64_t backend_features = vhost_dev_features(&vub->vhost_dev);
>> +
>>       /* This should be set when the vhost connection initialises */
>> -    g_assert(vub->vhost_dev.features);
>> -    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
>> +    g_assert(backend_features);
>> +    virtio_clear_feature(&backend_features, VHOST_USER_F_PROTOCOL_FEATURES);
>> +
>> +    return backend_features;
>>   }
>>
>>   /*
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 3fd11a3b57..9f26515fd4 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1252,7 +1252,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>>   {
>>       int i;
>>
>> -    if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
>> +    if (!vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
>>           /*
>>            * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
>>            * been negotiated, the rings start directly in the enabled state,
>> @@ -1469,7 +1469,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
>>        * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
>>        * specific.
>>        */
>> -    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
>> +    if (vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
>>           features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>>       }
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 414a48a218..773b91c0a0 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1603,7 +1603,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>           }
>>       }
>>
>> -    virtio_features_copy(hdev->features_ex, features);
>> +    virtio_features_copy(hdev->_features_ex, features);
>>
>>       hdev->memory_listener = (MemoryListener) {
>>           .name = "vhost",
>> @@ -1626,7 +1626,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>       };
>>
>>       if (hdev->migration_blocker == NULL) {
>> -        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL)) {
>> +        if (!vhost_dev_has_feature(hdev, VHOST_F_LOG_ALL)) {
>>               error_setg(&hdev->migration_blocker,
>>                          "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
>>           } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
>> @@ -1900,7 +1900,7 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>>       const int *bit = feature_bits;
>>
>>       while (*bit != VHOST_INVALID_FEATURE_BIT) {
>> -        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
>> +        if (!vhost_dev_has_feature(hdev, *bit)) {
>>               virtio_clear_feature_ex(features, *bit);
>>           }
>>           bit++;
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index 82acb6d232..33d32720e1 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -817,7 +817,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>           status->vhost_dev->nvqs = hdev->nvqs;
>>           status->vhost_dev->vq_index = hdev->vq_index;
>>           status->vhost_dev->features =
>> -            qmp_decode_features(vdev->device_id, hdev->features_ex);
>> +            qmp_decode_features(vdev->device_id, vhost_dev_features_ex(hdev));
>>           status->vhost_dev->acked_features =
>>               qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
>>
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index e308bc4556..e4e4526ca8 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -98,10 +98,11 @@ struct vhost_dev {
>>        * offered by a backend which may be a subset of the total
>>        * features eventually offered to the guest.
>>        *
>> -     * @features: available features provided by the backend
>> +     * @_features: available features provided by the backend, private,
>> +     *             direct access only in vhost.c
>>        * @acked_features: final negotiated features with front-end driver
>>        */
>> -    VIRTIO_DECLARE_FEATURES(features);
>> +    VIRTIO_DECLARE_FEATURES(_features);
>>       VIRTIO_DECLARE_FEATURES(acked_features);
>>
>>       uint64_t max_queues;
>> @@ -403,6 +404,28 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>>                              struct vhost_inflight *inflight);
>>   bool vhost_dev_has_iommu(struct vhost_dev *dev);
>>
>> +static inline bool vhost_dev_has_feature(struct vhost_dev *dev,
>> +                                         uint64_t feature)
>> +{
> 
> For simplicity should this be:
> 
> return virtio_has_feature_ex(dev->_features, feature);
> 
> ?
> 
>> +    return virtio_has_feature_ex(dev->_features_ex, feature);
>> +}
>> +
>> +static inline uint64_t vhost_dev_features(struct vhost_dev *dev)
>> +{
>> +    return dev->_features;
>> +}
>> +
>> +static inline const uint64_t *vhost_dev_features_ex(struct vhost_dev *dev)
>> +{
>> +    return dev->_features_ex;
>> +}
>> +
>> +static inline void vhost_dev_clear_feature(struct vhost_dev *dev,
>> +                                           uint64_t feature)
>> +{
>> +    virtio_clear_feature_ex(&dev->_features, feature);
>> +}
>> +
>>   #ifdef CONFIG_VHOST
>>   int vhost_reset_device(struct vhost_dev *hdev);
>>   #else
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 74d26a9497..0af0d3bdd3 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -256,15 +256,14 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
>>   {
>>       assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>>       VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
>> -    uint64_t features = s->vhost_vdpa.dev->features;
>>       int fd = s->vhost_vdpa.shared->device_fd;
>>       struct {
>>           struct vhost_vdpa_config hdr;
>>           uint32_t supported_hash_types;
>>       } config;
>>
>> -    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
>> -        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
>> +    if (!vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_HASH_REPORT) &&
>> +        !vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_RSS)) {
>>           return false;
>>       }
>>
>> @@ -585,7 +584,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>>        * If we early return in these cases SVQ will not be enabled. The migration
>>        * will be blocked as long as vhost-vdpa backends will not offer _F_LOG.
>>        */
>> -    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
>> +    if (!vhost_vdpa_net_valid_svq_features(vhost_dev_features(v->dev), NULL)) {
>>           return 0;
>>       }
>>
>> --
>> 2.48.1
>>


-- 
Best regards,
Vladimir

