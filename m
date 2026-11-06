Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F5606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dFxQT19j;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XQCYTDHQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPKET-0006Lf-2x; Fri, 06 Nov 2026 08:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xPKEP-0006II-5M
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xPKEN-0002L0-KH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793972625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/yhkFy/HZO/OM6W03NxKw6qdi5JN0/Dlgok27o6BYo=;
 b=dFxQT19jpqFEQzt4WFfYGHL7TmyQeAG5a2gWgKTvZitzIqFjDTOQgiJXxRU8E2krhkCiVS
 RPBbA51PrZ4UtjZJeVsGkKxdN43H+cpXOz+4JBho3TyfW869CGFIdWbFzcJlRnAaO9d907
 T4u+Zmab2NkZ8Tm1hiyI9xKNbPMAHY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-ws8rSB-xO4ebQLdoVNz5mA-1; Fri, 06 Nov 2026 08:43:43 -0500
X-MC-Unique: ws8rSB-xO4ebQLdoVNz5mA-1
X-Mimecast-MFC-AGG-ID: ws8rSB-xO4ebQLdoVNz5mA_1793972622
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a35db2d6b3so6129775e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793972622; x=1794577422; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h/yhkFy/HZO/OM6W03NxKw6qdi5JN0/Dlgok27o6BYo=;
 b=XQCYTDHQUNs8NbRSaf6VU8y0dTA6yv0cGsAbaYXgAjIO/DCkdmkGvuT16bt0nMmj3X
 jSQmimPJg0yMOkjpcMegVAPGHh97uEWqN43nWLM2E8iqHZN8jvKQPoRZYrzghkuny/Zi
 XQy1PRfxoMbJMFVHNanL07m0Kn4Jt9gXjhIqg16L3O4VyROgtaBOZuRSzB0kikhFtNDH
 RTUQCdKAC25qH3CASEEriO7EksjHSKdEuVkzp9oKKLxFfQOw7NcPCunVSfmO0Ko7AJ3T
 wTi701vdJrwzxRNo9QHxbIw69NsuwhzulC6W5F1kM5EI1pXAxcwvBDpz7nzErx/dUvJr
 YIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972622; x=1794577422;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/yhkFy/HZO/OM6W03NxKw6qdi5JN0/Dlgok27o6BYo=;
 b=GCv4W680GZBZqDa2UCEA0V0Zd3XNpryOp7gtesrjpfLnXPQnehpD9+03RS8SL7+k26
 YxlN6JqcsvhGkn4QCpIZZFfEDzHm3qMqFQ9AJ6gabG/9K8PZ9dTysvxbgnBM9EeKqcbw
 rPfw1C0FFM3RtEF2/6yJIJo0NISiewlq4mVCNIMnb+eR4doNj3vkQsxEElat33NeIurv
 Ez7/RwCTXa1s9a2lO1v+Cwr8jqJ79wG4jvLZU7vJc1GPyifqoe7Iv2VvIGPK7aDOTPGU
 5AZvd7t0UwbQm2rxrJ/PmrFeY2RFPjdSgNq5FCUVdtCZ8cfzXIfxqcgEaqsw87y0FidP
 1yTw==
X-Gm-Message-State: APuU4Z/WSplkjyXUoBA76BlPvlREDPgQmTgvyytgjzd9qj2XRL/TAC86
 ESkPnl1sjZsZu1ss3YVadrL92uzC6c1+851K/au/Yq+v38rRR1ZnxcWLLzBbhgBPMtIJgijdLv2
 0aJe3YbzxZSeHoYKE7hATu4A3mUMoGBOmT1UGARFC+l5fTeo5ncxuM5S3
X-Gm-Gg: AYBFou1aZte9/S5ioO4VRpkqnWAoCDZAf5u6ZUjGpuLkYvgMp44z33w27ZWQYTgxwRN
 wQ/ZbxeLuV8NhWX09NAHv32qXALyt8LMo1QzaOjRijUT3SddzIAlRR/So2xcwDygdyZF3p+aRgR
 q6Z2i5+u5aZpZ6bpjpjOmLUtvZ01lRDwW9oHHQA3xlrWzSLRtYyaEdPZX6K05TVWcvIrsKM14IK
 t5oZDggyOQJbcY5QbstBqC0oI5PvxzxFDDb4XEyhZPSipAZMFzxUW00AxBRsMxicNyTIrpl55Ca
 Bp7S3ua3ph10eEh1pklKMkuMzzOiL+cqu3iAB9z+odZj9uGssblnHmWF+khFKeh6zRmkj8gMpAY
 ThzlVRdd/lOuqIZ3HEl/6PcCzxzOds9N7z/PWeH4P9sotynSKeAwLSWawCt5hcXNNUQOQGesY3l
 sxdLlZM+hz
X-Received: by 2002:a05:600c:608a:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4b6d82b2c9cmr45633305e9.0.1793972622392; 
 Fri, 06 Nov 2026 05:43:42 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4b6d82b2c9cmr45632865e9.0.1793972621997; 
 Fri, 06 Nov 2026 05:43:41 -0800 (PST)
Received: from leonardi-redhat ([176.206.36.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d72333f9sm3829569f8f.29.2026.11.06.05.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:43:41 -0800 (PST)
Date: Fri, 6 Nov 2026 14:43:39 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Alexandr Moshkov <dtalexundeer@yandex-team.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] backends/vhost-user: fix memory leak when
 vhost_dev_init() fails
Message-ID: <au3Zc6oyL4td-qf3@leonardi-redhat>
References: <20261105162443.232929-1-sgarzare@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261105162443.232929-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 05:24:43PM +0100, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>vhost_dev_init() clears the struct vhost_dev in the error path calling
>vhost_dev_cleanup(). So, to prevent memory leaks, we need to keep a
>local reference to the vhost_virtqueue array and deallocate it in case
>of failure, just as most other callers of vhost_dev_init() do.
>
>Discovered while reviewing a patch by Alexandr Moshkov fixing the
>same issue in vhost-user-fs.
>
>Fixes: f24bb7287ddb ("Add vhost-user-backend")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi


