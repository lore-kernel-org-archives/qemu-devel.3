Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AC4C7EE2E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 07:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjZnP-0000sD-Pf; Thu, 29 Aug 2024 03:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjZnO-0000rK-6r
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 03:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjZnL-00023R-QH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 03:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724917333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1Yhj6uEE9DQ8yDNkqNsKglVlgClvml+Hj+o/cfmPLk=;
 b=IQcK+UHxblXr3JVk/q1XjXqfqgMYxaWidbEwFYrzBgpE4xC3sztG2JC+eAVhDKlPblQOsk
 ml31scxqPMJH7voprybbVRlzRDdH/mUKLpTGUslmRssVN+64KjtDsJBXemYmiXBVRyljs1
 JbfG515n4CisBtIghrw+S2LNqwZ+wHE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-UXUZRIJuNcWcxpHv3DR4bQ-1; Thu, 29 Aug 2024 03:42:09 -0400
X-MC-Unique: UXUZRIJuNcWcxpHv3DR4bQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8683bd9e67so31902666b.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724917329; x=1725522129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1Yhj6uEE9DQ8yDNkqNsKglVlgClvml+Hj+o/cfmPLk=;
 b=EcgkRYVVWHauWTz715xwrhw9hPb4jVkg3Oq5TuxGH2yYtMEgt71hplstvDAGJrfpQO
 ofNWXuHe/EWpUHFNEs5WKG3n6LlZezF4+4HBDMCxJltB828HY3KLwyFBaEQqmHoUHFxY
 6mUydPW8hct65tZ0BewgrfUcdA/ksswIFKcA05g76W6edI30Cm6mKZx4JBUZC47Oa8+z
 S3kEzoBx4KCCb83wVGez3RP9YfpZaPafZhHubJn5mZIliZGZvZgtgh4+jWGWlID8FHHL
 cqGArOPctDCTg+/oU1eiHsZnhq2EfHgWMi2CEdfKZFfT/8h305hjMnBeDCwGvHh5oEcy
 KK2A==
X-Gm-Message-State: AOJu0Yw6hlvdYfsF4hqwVQhQxZ1KNEqNGmLDH0fohYVAjnqQFRFHrcEK
 HE9GvudlE2SniZnj9iIl/nSakQOV56QGp+NDZm+p+gaN38SP7Tw/T5YQYyKrMfa8CECau5+zNd+
 rnjS5UlhqbK+wk9qBvXPuuO8e5EIIEd2Z9arNQfkEbTsvTgwxWnve
X-Received: by 2002:a17:907:d8c:b0:a86:a30f:4b0d with SMTP id
 a640c23a62f3a-a897f930927mr159352266b.38.1724917328531; 
 Thu, 29 Aug 2024 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg08OD686LS8TBxtmDh27vv9AXJNsPBPM0YN7v59bfOeP82o2Eiyn2JjEDm86vQX+ayUJXcw==
X-Received: by 2002:a17:907:d8c:b0:a86:a30f:4b0d with SMTP id
 a640c23a62f3a-a897f930927mr159348566b.38.1724917327701; 
 Thu, 29 Aug 2024 00:42:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989196751sm41506766b.121.2024.08.29.00.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:42:07 -0700 (PDT)
Date: Thu, 29 Aug 2024 03:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <20240829033717-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828100914.105728-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 03:39:14PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> QEMU threads use vhost_user_write/read calls to send
> and receive request/reply messages from a vhost-user
> device. When multiple threads communicate with the
> same vhost-user device, they can receive each other's
> messages, resulting in an erroneous state.
> 
> When fault_thread exits upon completion of Postcopy
> migration, it sends a 'postcopy_end' message to the
> vhost-user device. But sometimes 'postcopy_end' message
> is sent while vhost device is being setup via
> vhost_dev_start().

So maybe vhost_user_postcopy_end should take the BQL?

>      Thread-1                           Thread-2
> 
>  vhost_dev_start                    postcopy_ram_incoming_cleanup
>  vhost_device_iotlb_miss            postcopy_notify
>  vhost_backend_update_device_iotlb  vhost_user_postcopy_notifier
>  vhost_user_send_device_iotlb_msg   vhost_user_postcopy_end
>  process_message_reply              process_message_reply
>  vhost_user_read                    vhost_user_read
>  vhost_user_read_header             vhost_user_read_header
>  "Fail to update device iotlb"      "Failed to receive reply to postcopy_end"
> 
> This creates confusion when vhost-user device receives
> 'postcopy_end' message while it is trying to update IOTLB entries.
> 
>  vhost_user_read_header:
>   700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
>  vhost_device_iotlb_miss:
>   700871,700871: Fail to update device iotlb
>  vhost_user_postcopy_end:
>   700871,700900: Failed to receive reply to postcopy_end
>  vhost_user_read_header:
>   700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
> 
> Here fault thread seems to end the postcopy migration
> while another thread is starting the vhost-user device.
> 
> Add a mutex lock to hold for one request-reply cycle
> and avoid such race condition.
> 
> Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>


CC Author and reviewer of the offending commit.


> ---
>  hw/virtio/vhost-user.c         | 74 ++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user.h |  3 ++
>  2 files changed, 77 insertions(+)
> 
> v2:
>  - Place QEMU_LOCK_GUARD near the vhost_user_write() calls, holding
>    the lock for longer fails some tests during rpmbuild(8).
>  - rpmbuild(8) fails for some SRPMs, not all. RHEL-9 SRPM builds with
>    this patch, whereas Fedora SRPM does not build.
>  - The host OS also seems to affect rpmbuild(8). Some SRPMs build well
>    on RHEL-9, but not on Fedora-40 machine.
>  - koji builds successful with this patch
>    https://koji.fedoraproject.org/koji/taskinfo?taskID=122254011
>    https://koji.fedoraproject.org/koji/taskinfo?taskID=122252369
> 
> v1: Use QEMU_LOCK_GUARD(), rename lock variable
>  - https://lore.kernel.org/qemu-devel/20240808095147.291626-3-ppandit@redhat.com/
> 
> v0:
>  - https://lore.kernel.org/all/Zo_9OlX0pV0paFj7@x1n/
>  - https://lore.kernel.org/all/20240720153808-mutt-send-email-mst@kernel.org/
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..7b030ae2cd 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -24,6 +24,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/uuid.h"
>  #include "qemu/sockets.h"
> +#include "qemu/lockable.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/cryptodev.h"
>  #include "migration/postcopy-ram.h"
> @@ -446,6 +447,10 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>          .hdr.size = sizeof(msg.payload.log),
>      };
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      /* Send only once with first queue pair */
>      if (dev->vq_index != 0) {
>          return 0;
> @@ -664,6 +669,7 @@ static int send_remove_regions(struct vhost_dev *dev,
>                                 bool reply_supported)
>  {
>      struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
>      struct vhost_memory_region *shadow_reg;
>      int i, fd, shadow_reg_idx, ret;
>      ram_addr_t offset;
> @@ -685,6 +691,8 @@ static int send_remove_regions(struct vhost_dev *dev,
>              vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
>              msg->payload.mem_reg.region = region_buffer;
> 
> +            QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>              ret = vhost_user_write(dev, msg, NULL, 0);
>              if (ret < 0) {
>                  return ret;
> @@ -718,6 +726,7 @@ static int send_add_regions(struct vhost_dev *dev,
>                              bool reply_supported, bool track_ramblocks)
>  {
>      struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
>      int i, fd, ret, reg_idx, reg_fd_idx;
>      struct vhost_memory_region *reg;
>      MemoryRegion *mr;
> @@ -746,6 +755,8 @@ static int send_add_regions(struct vhost_dev *dev,
>              vhost_user_fill_msg_region(&region_buffer, reg, offset);
>              msg->payload.mem_reg.region = region_buffer;
> 
> +            QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>              ret = vhost_user_write(dev, msg, &fd, 1);
>              if (ret < 0) {
>                  return ret;
> @@ -893,6 +904,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>                                               bool config_mem_slots)
>  {
>      struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num = 0;
>      VhostUserMsg msg_reply;
> @@ -926,6 +938,8 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>              return ret;
>          }
> 
> +        QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>          ret = vhost_user_write(dev, &msg, fds, fd_num);
>          if (ret < 0) {
>              return ret;
> @@ -1005,6 +1019,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                      struct vhost_memory *mem)
>  {
>      struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num = 0;
>      bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
> @@ -1044,6 +1059,8 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>              return ret;
>          }
> 
> +        QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>          ret = vhost_user_write(dev, &msg, fds, fd_num);
>          if (ret < 0) {
>              return ret;
> @@ -1089,6 +1106,10 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
>          return 0;
>      }
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -1138,6 +1159,10 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
>          }
>      }
> 
> +/*  struct vhost_user *u = dev->opaque;
> + *  struct VhostUserState *us = u->user;
> + *  QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> + */
>      ret = vhost_user_write(dev, msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -1277,6 +1302,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>          .hdr.size = sizeof(msg.payload.state),
>      };
>      struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> 
>      VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
>      if (n) {
> @@ -1669,6 +1696,9 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
>      };
>      memcpy(msg.payload.object.uuid, uuid, sizeof(msg.payload.object.uuid));
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -1889,6 +1919,9 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
>          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
>      }
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, &sv[1], 1);
>      if (ret) {
>          goto out;
> @@ -1993,6 +2026,9 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
>          .hdr.flags = VHOST_USER_VERSION,
>      };
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          error_setg(errp, "Failed to send postcopy_advise to vhost");
> @@ -2051,6 +2087,9 @@ static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
> 
>      trace_vhost_user_postcopy_listen();
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          error_setg(errp, "Failed to send postcopy_listen to vhost");
> @@ -2080,6 +2119,9 @@ static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
> 
>      trace_vhost_user_postcopy_end_entry();
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          error_setg(errp, "Failed to send postcopy_end to vhost");
> @@ -2372,6 +2414,10 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
>      }
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -2396,6 +2442,10 @@ static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
>          .payload.iotlb = *imsg,
>      };
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -2428,6 +2478,10 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
> 
>      assert(config_len <= VHOST_USER_MAX_CONFIG_SIZE);
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      msg.payload.config.offset = 0;
>      msg.payload.config.size = config_len;
>      ret = vhost_user_write(dev, &msg, NULL, 0);
> @@ -2492,6 +2546,10 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
>      p = msg.payload.config.region;
>      memcpy(p, data, size);
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -2570,6 +2628,10 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>          }
>      }
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      msg.payload.session.op_code = backend_info->op_code;
>      msg.payload.session.session_id = backend_info->session_id;
>      ret = vhost_user_write(dev, &msg, NULL, 0);
> @@ -2662,6 +2724,9 @@ static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
>          return 0;
>      }
> 
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          return ret;
> @@ -2757,6 +2822,7 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
>      user->memory_slots = 0;
>      user->notifiers = g_ptr_array_new_full(VIRTIO_QUEUE_MAX / 4,
>                                             &vhost_user_state_destroy);
> +    qemu_mutex_init(&user->vhost_user_request_reply_lock);
>      return true;
>  }
> 
> @@ -2769,6 +2835,7 @@ void vhost_user_cleanup(VhostUserState *user)
>      user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
>      memory_region_transaction_commit();
>      user->chr = NULL;
> +    qemu_mutex_destroy(&user->vhost_user_request_reply_lock);
>  }
> 
> 
> @@ -2902,6 +2969,9 @@ static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
>          return -ENOTSUP;
>      }
> 
> +    struct VhostUserState *us = vu->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, &fd, 1);
>      close(fd);
>      if (ret < 0) {
> @@ -2965,6 +3035,10 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
>          return -ENOTSUP;
>      }
> 
> +    struct vhost_user *u = dev->opaque;
> +    struct VhostUserState *us = u->user;
> +    QEMU_LOCK_GUARD(&us->vhost_user_request_reply_lock);
> +
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index 324cd8663a..e96f12d449 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -67,6 +67,9 @@ typedef struct VhostUserState {
>      GPtrArray *notifiers;
>      int memory_slots;
>      bool supports_config;
> +
> +    /* Hold lock for a request-reply cycle */
> +    QemuMutex vhost_user_request_reply_lock;
>  } VhostUserState;
> 
>  /**
> --
> 2.46.0


