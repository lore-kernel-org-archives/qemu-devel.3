Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CE2C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvse-00038S-I9; Thu, 11 Jul 2024 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvsc-00037x-Qc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvsa-0004x7-U6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720712323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoGaGfB2xUiHkUePcLBSQuhXjT1w3kY94K41qa+eHv0=;
 b=BJ0H05mqUuP5+hAeSGoLwjl4dtb9hVq4Oe7IwtREH9K6Ypnn/I3UMQCperBAiwk0j0dRwq
 xitoeuerM/RYsxwZACW8hkEkuj+Wifb3zhWMOJapF/Kt5N57mqpWC30M4/PTtCOb+2HFPe
 3601rZnaIS88qMcoEI/8LONQd3O9tbk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-opbbuesTM26ncmUF6EzoQQ-1; Thu, 11 Jul 2024 11:38:41 -0400
X-MC-Unique: opbbuesTM26ncmUF6EzoQQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44a731cb5baso2542481cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712321; x=1721317121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoGaGfB2xUiHkUePcLBSQuhXjT1w3kY94K41qa+eHv0=;
 b=mwn0Nb7+MaVX846LgrE1M4nsOE5EyKvCVCtw4ytqBFyORrKnlvvTFZ+C8uQ0xH1FR+
 Bui5MV/fJJCRHhILM9PGoaddX6v8tsICg5IIzxQ/3PA3t/MX5AT5yxNb0Ub0VrHkZemx
 SsW2cev9Hpp2G4HNN4hc2Jo4ow8hlu7NFcgyzffBhjXViWqP2WmRwxAF6V2Tj4wfbiBz
 Dc7AAFCf/r4O3lR8sFZN9jo8i3VOaxJP9FOYteCdnOl14J+8A8hQYW9e7GQONd01VEO0
 B7naG6+bY735K63SE5bCdc+oK/tbpHEyeMu0fS91meQhJ1Hea+YzJKosQxJz/vSg8OWn
 9L1w==
X-Gm-Message-State: AOJu0Yz+TNCkjn9kuA40tuH35se33qvT9uVgbdcpTTRkMOeJYniypDH9
 X5ctQ8kpvqzpHVvxH9GBgNFWOYpQv1RTWpbxFX5iYdkMhIuT4sbdqh3kl7uDQg4DbAd+e+1Gd8J
 fSxe1qVXpy3NwnyXJ5bokoNIMB7mI7uMeIdAgqfpol7MO4QCWvxH8
X-Received: by 2002:a0c:edd0:0:b0:6b5:600:acc8 with SMTP id
 6a1803df08f44-6b74b1610c6mr29617216d6.1.1720712321173; 
 Thu, 11 Jul 2024 08:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuNXXs0VcfB3vRKVHv5xitnvMijsqQCPEy30yBAxlQLnoVEz9ewP3C+samVeNnC2F+49AyEg==
X-Received: by 2002:a0c:edd0:0:b0:6b5:600:acc8 with SMTP id
 6a1803df08f44-6b74b1610c6mr29617056d6.1.1720712320868; 
 Thu, 11 Jul 2024 08:38:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba74bdcsm26565426d6.97.2024.07.11.08.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 08:38:40 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:38:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <Zo_8fpKH8oBA8WV1@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711131424.181615-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 11, 2024 at 06:44:22PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * virsh(1) offers multiple options to initiate Postcopy migration:
> 
>     1) virsh migrate --postcopy --postcopy-after-precopy
>     2) virsh migrate --postcopy + virsh migrate-postcopy
>     3) virsh migrate --postcopy --timeout <N> --timeout-postcopy
> 
> When Postcopy migration is invoked via method (2) or (3) above,
> the guest on the destination host seems to hang or get stuck sometimes.
> 
> * During Postcopy migration, multiple threads are spawned on the destination
> host to start the guest and setup devices. One such thread starts vhost
> device via vhost_dev_start() function and another called fault_thread handles

Hmm, I thought it was one of the vcpu threads that invoked
vhost_dev_start(), rather than any migration thread?

> page faults in user space using kernel's userfaultfd(2) system.
> 
> When fault_thread exits upon completion of Postcopy migration, it sends a
> 'postcopy_end' message to the vhost-user device. But sometimes 'postcopy_end'
> message is sent while vhost device is being setup via vhost_dev_start().
> 
>      Thread-1                                  Thread-2
> 
> vhost_dev_start                        postcopy_ram_incoming_cleanup
>  vhost_device_iotlb_miss                postcopy_notify
>   vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
>    vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
>     process_message_reply                  process_message_reply
>      vhost_user_read                        vhost_user_read
>       vhost_user_read_header                 vhost_user_read_header
>        "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"
> 
> This creates confusion when vhost device receives 'postcopy_end' message while
> it is still trying to update IOTLB entries.
> 
> This seems to leave the guest in a stranded/hung state because fault_thread
> has exited saying Postcopy migration has ended, but vhost-device is probably
> still expecting updates. QEMU logs following errors on the destination host
> ===
> ...
> qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
> qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
> qemu-kvm: vhost_user_postcopy_end: 700871,700900: Failed to receive reply to postcopy_end
> qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
> qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
> qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x8 instead of 0x5.
> qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
> qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x16 instead of 0x5.
> qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
> qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
> qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
> ===
> 
> * Couple of patches here help to fix/handle these errors.

I remember after you added the rwlock, there's still a hang issue.

Did you investigated that?  Or do you mean this series will fix all the
problems?

Thanks,

> 
> Thank you.
> ---
> Prasad Pandit (2):
>   vhost-user: add a write-read lock
>   vhost: fail device start if iotlb update fails
> 
>  hw/virtio/vhost-user.c         | 423 +++++++++++++++++++--------------
>  hw/virtio/vhost.c              |   6 +-
>  include/hw/virtio/vhost-user.h |   3 +
>  3 files changed, 259 insertions(+), 173 deletions(-)
> 
> --
> 2.45.2
> 

-- 
Peter Xu


