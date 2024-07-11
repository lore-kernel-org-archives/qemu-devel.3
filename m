Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881F3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvvk-0006NW-2c; Thu, 11 Jul 2024 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvvj-0006JX-1H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvvg-0007eT-EA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720712515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWLSM8ZEXT80/iRiMyNxUDiDBunsEtenw83AUcvn6YQ=;
 b=T9if7byBHXDwSm7KJW7BX6VtZkvSls31XJrNoonsPn9VKexmTa93WLusRw2LmUj+yc1zaV
 Qlu5m5Ms8ad/pk1sENiJnC2gFBX0LhgggCJsUrpBj1VWNGiyL61mR5Bet7ZcZ+Snai0Yv1
 d63y13ukpaHYrubMdCnj2TgjbwONh6Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-LQ2BsAoRN_CozvRw9dq4Sw-1; Thu, 11 Jul 2024 11:41:49 -0400
X-MC-Unique: LQ2BsAoRN_CozvRw9dq4Sw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-448335bb53aso590311cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712508; x=1721317308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWLSM8ZEXT80/iRiMyNxUDiDBunsEtenw83AUcvn6YQ=;
 b=FmDyESh9KKdgUdcpLZITk4E1FZFmSUUYOxyO/fiOrrWKR58LnChYE9E/+XDL12v3af
 /ZfrDEqPUI8zqLJn8Wdu7JQJZD5fv5/BCbHjP5Cv/odUyfufaF2TaupiVbSrfRjc6EcC
 q9eS+K84xYnC94KDOLgcAFINGlb0iBDjErLSHemNpbXJJ51r9ZJ10c/AP4fyEuJ/DJiE
 HHFJB0yWYzi/Baawu3FhWriu7He0JBa6ffgbJ/Zv8eNC5czSsnyy5j0ok/cJ3sLHCuXy
 OMwPOxTs+tBZWWNmG9M2nz4Q4CGGl+/8e16nF/kxpfjZQPTNcTKhVOk788/+je4UOI61
 U0ng==
X-Gm-Message-State: AOJu0YwpC07dE/iiqPedLNymGI8sqby/Fva8qFDocgGzvqa3U6IQKsuS
 6gfI/SgbdV2hFKCG84Id7hOJSMvnwJGy0pOEgoyPvIkoNdMzFazzT9Q/mmVttdElD7t6NlPihyF
 eQRQp2qdGKHo41ugP6cF4UMlLeRLaFfVKNj/O92wo8bSZ9VdU7FKB
X-Received: by 2002:a05:620a:20c9:b0:79e:fc14:c53 with SMTP id
 af79cd13be357-7a1471f7a44mr253990285a.7.1720712508527; 
 Thu, 11 Jul 2024 08:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOeShMSuR9ZwJ13Ke5zcQdASk3stkJjl+yn+Z1Wu39H7iZkMpVyrTPxFr+WPo/82PT3xKxGA==
X-Received: by 2002:a05:620a:20c9:b0:79e:fc14:c53 with SMTP id
 af79cd13be357-7a1471f7a44mr253988685a.7.1720712508217; 
 Thu, 11 Jul 2024 08:41:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18ff6756sm303291985a.2.2024.07.11.08.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 08:41:47 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:41:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
Message-ID: <Zo_9OlX0pV0paFj7@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711131424.181615-2-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jul 11, 2024 at 06:44:23PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> QEMU threads use vhost_user_write/read calls to send
> and receive messages from a vhost-user device. When multiple
> threads communicate with the same vhost-user device, they can
> receive each other's messages, resulting in an erroneous state.
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
> Here fault thread seems to end the postcopy migration while
> another thread is starting the vhost-user device.
> 
> Add a rw lock to hold for one vhost_user_write/read cycle
> and avoid such race conditions.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  hw/virtio/vhost-user.c         | 423 +++++++++++++++++++--------------
>  include/hw/virtio/vhost-user.h |   3 +

I apologize if I suggested WITH_QEMU_LOCK_GUARD when we talked.. I don't
remember which one I suggested, but in this case IIUC it'll be much easier
to review if you use the other sister function QEMU_LOCK_GUARD()
instead.. That should make the diff much, much less.

-- 
Peter Xu


