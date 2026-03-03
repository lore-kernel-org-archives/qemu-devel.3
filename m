Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D345DE67A85
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJzJ-0007oq-L2; Tue, 03 Mar 2026 02:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vxJzH-0007kg-Qt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vxJzF-0001Qr-37
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772522166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY7akMrUrduOG4Bs1kPpPqfOirAWMhrrpPkghpuD0ag=;
 b=R6v/PywB7BM3IlBQv23bPMxPPZlsLGi3zl0F38ypC/TBKuK8t+WmWbyuPCfuCxgKGT7Hsg
 3J5TbCEpnjd2fx9MB8yPqxSJotQx/OQe6IiwiwloCnIIgdvH81guGDV/m9CYaPtNEYwxIy
 zlhsgcedaAVYD2GresOWCNnlXKn1RMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Wq_giNIHMAS1FiYWkHo-Jw-1; Tue, 03 Mar 2026 02:16:04 -0500
X-MC-Unique: Wq_giNIHMAS1FiYWkHo-Jw-1
X-Mimecast-MFC-AGG-ID: Wq_giNIHMAS1FiYWkHo-Jw_1772522164
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b4e653d2so1804915f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772522163; x=1773126963; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gY7akMrUrduOG4Bs1kPpPqfOirAWMhrrpPkghpuD0ag=;
 b=cHYNztXCfHOUXTAhppJE38IQFgtYJbDtihST0n2wv716mxYkf/A965lQAfw49weFIE
 j5C75U59zFXN/AES59KG9lIU+sJiuLryM8x5vUsn2RryB2J5T9dlpmAQN3CMyERRJmOh
 JR/LQPYJZTQx8+0c9Q4b5u/F4eGJ1YNaEvPWXKcQu4UDMxDpvECf6GTIrTpt+UoWhTzi
 bjainhavQODTwq71vIY6mNWOocIkGxavtMN5x+L+n5JqFrptGTTgBKUw77aPF7KI8hSj
 vmeArnZ8EhrZnmDfSXXeF7mJgjIbOyq/q7/Y5FbP1+DfpuQ3D5TJXaG6VyrOjpxZeqWz
 n4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772522163; x=1773126963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY7akMrUrduOG4Bs1kPpPqfOirAWMhrrpPkghpuD0ag=;
 b=ikrozuN/ardO0cqQ4HDl/ax2FJHty06Gx7klSVOkvaAZ0YxrIfqItf1B2LqJzWTq4y
 XERkKYWKIyjz/44wLSWDFRKulhFh0mBeAnSa3Ayo9vr+OnDdaf62381pPCyjaiK10KHk
 QP17xX0E86/HY/MjMbywRAkB5lqcDZPMTYpdqRNrKUySljAPnKDw59oeF+98G4fr48N0
 SuohaN59VMfHEcKyRaUMTy+yNVEagcp3kKmQmZSTJIupWWzRMWZB7//GwezqSMiGDJrr
 lvdoapCwCa8fQiatv9yDQ/aABRKKcLGUJq3oyvw/zFAb+n1TzOeHNzjRW7yf3NNrt9/g
 pVXg==
X-Gm-Message-State: AOJu0Yxo5ggUHWThWBOITnlEGC/EX10+rFxvt2JoBPgdwWb2zU7C15qJ
 pMCIh3gnNm/hBUX84lt2TtnVZQl8W4xs8dTHo1UBpt1ebe4vA4JCPVb2CzxHHoHOiUHNoA97LEZ
 EhcXFm3YTXIK1cWlMdHgUtVqimf4SQFFAsMZYl/nOEDmp4cIERquhH/4Z
X-Gm-Gg: ATEYQzwx1wvc86nsMdeXMj8iZry/SlwvwQZ1h4beGmf8LgXltlwql8nuEJ4j96TPfPa
 6DosI5sjf01bTa9Dq2t3odz8y5iClmUQtkpN55JyKBTEl1UfHzuNkfl7Jq4iAd5yhU8NvvzfLCv
 pntnIvuzFzJuZGNuIWm0PR4EdYAFJhtG+fbrdLS1TUm9oJU4aGtFVRrWIyjqT7T4N4UDzJXYzq1
 pSi1eDgs/yMnZb7N88hDdJGWu9gYiliCgmNpXt20w/xBarRdi6nnp6ZbnZJtW8D5BX8lYpMP/7M
 ibkHuG43SlyWSGdga/DPpHL4rAHH0/2V+E2KOPmXltzWdXB+OAgRVR51fLIbMbBjD81B0vEQchu
 LPFKz2IBz0VkceForojw2BwZImaIRoxOVpB8JubSTYqNCfQ==
X-Received: by 2002:a05:6000:288e:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4399ddd8836mr23520822f8f.6.1772522163556; 
 Mon, 02 Mar 2026 23:16:03 -0800 (PST)
X-Received: by 2002:a05:6000:288e:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4399ddd8836mr23520772f8f.6.1772522162870; 
 Mon, 02 Mar 2026 23:16:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b485a0b6sm17126830f8f.39.2026.03.02.23.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 23:16:02 -0800 (PST)
Date: Tue, 3 Mar 2026 02:15:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user: document vhost_user_read() message handling
Message-ID: <20260303021118-mutt-send-email-mst@kernel.org>
References: <20260303041723.7410-1-mohamedaymanworkspace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303041723.7410-1-mohamedaymanworkspace@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 03, 2026 at 06:17:23AM +0200, Mohamed Ayman wrote:
> Add a detailed documentation comment for vhost_user_read() describing
> its message header validation, payload size checks, and error handling.
> 
> This clarifies how complete vhost-user messages (header + payload) are
> read from the character device and how protocol violations are handled.
> 
> No functional changes.
> 
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>


This all seems unnecessarily verbose.

> ---
>  hw/virtio/vhost-user.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index bb8f8eab77..157a869b35 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -300,6 +300,20 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
>      return 0;
>  }
>  
> +/**
> + * vhost_user_read:
> + * @dev: The vhost device state
> + * @msg: Pointer to the vhost-user message structure to populate
> + *
> + * Reads a complete vhost-user message (header and optional payload) from 
> + * the character device.

use imperative voice: Read ...
what "the character device"?

> It first reads and validates the header, checks 
> + * the advertised payload size against maximum bounds, and then reads any 
> + * attached payload directly into the message structure.


repeating implementation here does not make sense.

> + *
> + * Returns: 0 on success,
> + * -EIO or -errno on read failure or short read,
> + * -EPROTO if the protocol flags or payload size are invalid.


we usually do not document specific errors.

> + */
>  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>  {
>      struct vhost_user *u = dev->opaque;
> @@ -307,12 +321,13 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>      uint8_t *p = (uint8_t *) msg;
>      int r, size;
>  
> +    /* 1. Read and validate the message header */


obvious from function name
`
>      r = vhost_user_read_header(dev, msg);
>      if (r < 0) {
>          return r;
>      }
>  
> -    /* validate message size is sane */
> +    /* 2. Validate that the payload size is sane to prevent buffer overflows */

how is this better?

>      if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
>          error_report("Failed to read msg header."
>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
> @@ -320,9 +335,13 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          return -EPROTO;
>      }
>  
> +    /* 3. If the header indicates a payload exists, read it */


this one is ok.

>      if (msg->hdr.size) {
> +        /* Advance the pointer to the start of the payload section */

too detailed, it's clear as is.

>          p += VHOST_USER_HDR_SIZE;
>          size = msg->hdr.size;
> +        
> +        /* Block and read the exact payload size */

exact?

>          r = qemu_chr_fe_read_all(chr, p, size);
>          if (r != size) {
>              int saved_errno = errno;
> -- 
> 2.34.1


