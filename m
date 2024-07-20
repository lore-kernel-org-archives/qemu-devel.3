Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80C1C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFWs-0002ll-QY; Sat, 20 Jul 2024 15:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFWm-0002kq-Sa
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFWl-0000YY-IU
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jao95MfY9a/cb4YeucJJNMxFdgAkrK2Ta+MAO64ibeU=;
 b=UFU3iem81XqTSQc2M2N/r3LEIjdqceuAj4zXBY9gnjBbB6V2ns4Xk3lQBW/REdQcQJWNHe
 N6xTHYLV3A7Hdm/BQVOt6CRiq6Flz5Jdm7IaJ+IM0PZKiweH1jtVYv+QHrST9qcHcLKovf
 nhUPXJavnO+4V3JXPj3X2eMoTVbQXdw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-91VOzHXzMXeTRak64dRlqA-1; Sat, 20 Jul 2024 15:13:53 -0400
X-MC-Unique: 91VOzHXzMXeTRak64dRlqA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so19569555e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502831; x=1722107631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jao95MfY9a/cb4YeucJJNMxFdgAkrK2Ta+MAO64ibeU=;
 b=BtHqsShhYbu/iKhWvv/rz8PzzXlCfH1ujSfbUTZ5cVCE6/aT+0StMnc53rcwTcPZwB
 ICHnUqHQsPFlxC3dcAVd3ZzosE0uzLHr+D29sUjOIK7ZMFwSrKpVLBUW+O/IkMgqIC8W
 xQg5hgVFs6ToiwXRFLze5c5vOjuToDBfcTDRGqfE/uxFsyA/yZaEFnQqH9NQ5qIAueSt
 61R8w0tjYUV8ONM6LmpTUQEvXaZabUcEVflAXGAezIy4Hsq6Y8T7gHNGNnivBo7U9mRd
 8gcY2EIKgbOQDy0LYXzFAUWUQxC4R5/THnZnv9AgnrTxWPt5eJqPib3rhlMhd8+K+lLt
 prgQ==
X-Gm-Message-State: AOJu0Yy4z/+1bhcSgN2kJEpsZH6lv9tHtiN1EwnTVZsISB2rpGIGuZL+
 D2XoBP4st9ZYPmBNRcXg8smVqg82qdE7NNQXotZawWVQc8W+8aFHTgzWu5IvfDnaD7x81jKdz0N
 E5Xrrg/Aa0rv9k/UTiJf+26iq74zBzqQq5S4/LpdyFpTLZXvorl50mfMtItyVexs=
X-Received: by 2002:a05:600c:1e11:b0:426:5b84:86d2 with SMTP id
 5b1f17b1804b1-427dc52808cmr16469065e9.20.1721502831518; 
 Sat, 20 Jul 2024 12:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ObbLgaW1BjUPl5Q75yL9od6RZkJSjhe/HakFe8TQB1/njOR75HqzWuDAZuqSO+5T8gRTcQ==
X-Received: by 2002:a05:600c:1e11:b0:426:5b84:86d2 with SMTP id
 5b1f17b1804b1-427dc52808cmr16468905e9.20.1721502830895; 
 Sat, 20 Jul 2024 12:13:50 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071c5sm66717225e9.27.2024.07.20.12.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:13:50 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:13:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH] vhsot-user: Remove redundant judgment
Message-ID: <20240720151228-mutt-send-email-mst@kernel.org>
References: <20240710074041.85984-1-xiangwencheng@dayudpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710074041.85984-1-xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 10, 2024 at 03:40:41PM +0800, BillXiang wrote:
> From: BillXiang <xiangwencheng@dayudpu.com>
> 
> Send only once has been supported in vhost_user_write by vhost_user_per_device_request
> 
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>

I am confused by all the patches. Is it on top of your
other patch or instead of? Because that one added
the vq index check.
If we are going to check vq index it's likely cleaner to
always check it.

And again, typos do not inspire confidence. How was this tested?

> ---
>  hw/virtio/vhost-user.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..04e3568b7e 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -446,11 +446,6 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>          .hdr.size = sizeof(msg.payload.log),
>      };
>  
> -    /* Send only once with first queue pair */
> -    if (dev->vq_index != 0) {
> -        return 0;
> -    }
> -
>      if (shmfd && log->fd != -1) {
>          fds[fd_num++] = log->fd;
>      }
> -- 
> 2.30.0


