Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E9ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4O8-0002bB-Qy; Tue, 10 Sep 2024 13:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4O6-0002aC-V6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4O5-0001iS-BC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725988243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2Vq/bu6PKXAAo63Rx2C4qJetDow9YwZuTQ1r+BP9I4=;
 b=dqR7Yza1W2JgfKRejB9YNAaNWOp3bpwURKAZGyBlckHq4QPrkjFhWMAsYMDuOsk2+/jbtK
 EXYaYj5ICAZJ+fPYNujKk29tuC+KVKlQwFKeBeQBzE5EoJN1sflaJj8/8yMVz5L6h0Tuv7
 PV9ryji+R2wh8xoijbR5aBj6zn3hFCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-WOCVtgQ2MsegCaJ4k1S0NA-1; Tue, 10 Sep 2024 13:10:41 -0400
X-MC-Unique: WOCVtgQ2MsegCaJ4k1S0NA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c35b8e38so2617868f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988240; x=1726593040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2Vq/bu6PKXAAo63Rx2C4qJetDow9YwZuTQ1r+BP9I4=;
 b=dTF5RbjqAE/R7bmp+Fa0tzk86Fxo7GDARb/AMnjB4e9vZhVtoxnFjv733POKTi2DgR
 cLCM5RW2wwOyk0emDpSSXRyOjxnpeBXRrztwo6RKqf8CkI9brfi02HtXjnpTSKFSwRGv
 ofex1DE3VOviE7HAzKctcSDcYESTanKXhMdW/fVd48L9uaHKZJxfZviy+xf2aiEBHcMD
 1zotLPHXRfIHdYiSgsKag2xLs+ahD498l757NAMajNQYG/WjJ049LGQ/gdShA8+eOFeR
 yxPdmHSIjm9t0tR8pg3fZhrxjfRca8PazRQ2bjz1TWpRRd1gpJaqxwxjcp2SfDgC9bmU
 dkXg==
X-Gm-Message-State: AOJu0YzEYe2f4KOkAjSnCyxOssJS7ifouxGQRaMy6GkUP/4paZW/xXdF
 YGjtp7JLhFBJOp6CAfDqASE7xysn2239TZJrlHrldNQcmMlOWbgNw0M3Ofc0J5B0JhP07/B0rt7
 FaMJGU6BIO7cYHQh3HbDIKvfAtXDgFNtEkPqj3z0Lv3vuwDqDrV76
X-Received: by 2002:a5d:54c8:0:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-378896c8049mr10278838f8f.57.1725988239770; 
 Tue, 10 Sep 2024 10:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj11+mZqW0nk1LE3XRXpDDYKPn/taopMMQeMmNRceru15ERhK30Z71ph+KIEQCxgw6pMvebw==
X-Received: by 2002:a5d:54c8:0:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-378896c8049mr10278818f8f.57.1725988239078; 
 Tue, 10 Sep 2024 10:10:39 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665649sm9461155f8f.42.2024.09.10.10.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:10:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 0/2] Postcopy migration and vhost-user errors
Message-ID: <20240910131008-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828100914.105728-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 28, 2024 at 03:39:12PM +0530, Prasad Pandit wrote:
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
> the migrated guest on the destination host hangs sometimes.
> 
> * During Postcopy migration, multiple threads are spawned on the destination
> host to start the guest and setup devices. One such thread starts vhost
> device via vhost_dev_start() function and another called fault_thread handles
> page faults in user space using kernel's userfaultfd(2) system.
> 
> * When fault_thread exits upon completion of Postcopy migration, it sends a
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


So are we going to see a version with BQL?

> * Couple of patches here help to fix/handle these errors.
> 
> Thank you.
> ---
> Prasad Pandit (2):
>   vhost: fail device start if iotlb update fails
>   vhost-user: add a request-reply lock
> 
>  hw/virtio/vhost-user.c         | 74 ++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c              |  6 ++-
>  include/hw/virtio/vhost-user.h |  3 ++
>  3 files changed, 82 insertions(+), 1 deletion(-)
> 
> --
> 2.46.0


