Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA5C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4WK-00065K-JB; Mon, 19 Aug 2024 11:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sg4WI-0005xy-L9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sg4WG-0003nH-1p
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724082126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tM9h6W/PnnE62R4+j8dnJpxSI7OW44Uz22gLBMK/k6k=;
 b=BOT0wqFnA6m7KLy4AnUTApdcreoCdY6wxL10KvEawi1VFzxtvds/bYB0Wml8YXPzopRuNG
 qxgoCS5pD5RuXQNo2BkPygMjF7t7ULaQfGMM0L3NvKbcFVW++rrbp8PkoLHI95P9gh98RK
 I6nc3jMdVXvfpdUs16qbWOx7QwJk4ZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-OAm7OlMnMx2qjZPD_Me4Xw-1; Mon, 19 Aug 2024 11:42:05 -0400
X-MC-Unique: OAm7OlMnMx2qjZPD_Me4Xw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso2608317f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724082124; x=1724686924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tM9h6W/PnnE62R4+j8dnJpxSI7OW44Uz22gLBMK/k6k=;
 b=xS7NdakhrDffR84RRcW48E37S9NiwygWSXJU0w2muev7qYZjgpzG7AJ98uQBzD8fi6
 6I+Gvo/rpYjZGlYqAzAUgpEdTxPsABuZhVLWev73GkSLTvE9QmURpM+iLC0B5b+/0wXU
 Uunor7hCw2bQGXw0whBPP5JzpmTCDbWQWD/fxQ0ai9iIr7htvlHItaSdUKD0e/aj9tSr
 n2qhCR8p3EeIwAgi/HpQ/5TuHiEy1C6tl9aH5MFae0g4gGQknQR9G6sc6yt1YUcL63SC
 9mExxGk4ChCWO3aOIPrgWjjlrI3lb8geyGVfZGHPTNt/Q3r9jt58OXNL8zrhRm7aaJRI
 fZXg==
X-Gm-Message-State: AOJu0YxErm2AkbKcZFQKO4p6k5+vYkCskBxBFJ2SiVmxB5kHFXGTVcL0
 uJZG1SsrYUJDTudKSw/txJO+6iLmjwMzwOQHbOt18cKVHCH97RwzBf8+p2Y4dXPjiaERZwIDLiy
 tCDZvqeWLEXnfmeGQO/sPBv9Se0hzgadnqS5ryBFTot0DSgNn7Jra
X-Received: by 2002:a5d:68c4:0:b0:36b:a3f1:6333 with SMTP id
 ffacd0b85a97d-371a73eabbfmr4401630f8f.24.1724082123617; 
 Mon, 19 Aug 2024 08:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVJPw05cUcdO172J/TE6RtiF+7IuxXPkWbVpeD6QsCyK/OAnfn5Y5kXHrIcgpN3142ynkMxA==
X-Received: by 2002:a5d:68c4:0:b0:36b:a3f1:6333 with SMTP id
 ffacd0b85a97d-371a73eabbfmr4401603f8f.24.1724082122648; 
 Mon, 19 Aug 2024 08:42:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:5b3:2639:43bc:ddde:5f19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a2eesm10855976f8f.19.2024.08.19.08.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:42:01 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:41:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com, pjp@fedoraproject.org
Subject: Re: [RFC-PATCH v2] vhost-user: add a request-reply lock
Message-ID: <20240819114137-mutt-send-email-mst@kernel.org>
References: <20240808095147.291626-3-ppandit@redhat.com>
 <20240819120248.170180-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120248.170180-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 19, 2024 at 05:32:48PM +0530, Prasad Pandit wrote:
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
> 
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
> 'postcopy_end' message while it is trying to update
> IOTLB entries.
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

makes sense.
Acked-by: Michael S. Tsirkin <mst@redhat.com>
But do not post v2 as reply to v1 pls.

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
> 
> v1: https://lore.kernel.org/qemu-devel/20240808095147.291626-3-ppandit@redhat.com/#R
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


