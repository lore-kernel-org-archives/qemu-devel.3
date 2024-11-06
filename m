Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA45BD44D53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8eT6-0000qA-5m; Wed, 06 Nov 2024 06:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8eSy-0000pO-7A
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8eSv-0007f8-0Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730893485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0X7swszX/w9slhUhXplUUT7/P37Crj342idQArutwc=;
 b=QssBLftL1XcoCvGI1gWAvIFLJzA8FUiWEHTas50xzyPcMEh+qMfvJCGzU52x8x1ZG9wbly
 ARiLA3iU8MGUZ8izpMH2ZaxGHrmJrWOw8tLBsEfJT9qCZCmboFJrYELQPIBe3+lPxu0lNO
 r6g1KMP/upU2Nf0exj/KtQ0ekQhsq44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-lKHYOgxbO-ClgmwkQElYVg-1; Wed, 06 Nov 2024 06:44:42 -0500
X-MC-Unique: lKHYOgxbO-ClgmwkQElYVg-1
X-Mimecast-MFC-AGG-ID: lKHYOgxbO-ClgmwkQElYVg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso43687185e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 03:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730893481; x=1731498281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0X7swszX/w9slhUhXplUUT7/P37Crj342idQArutwc=;
 b=qo6Y8bq10spo2AH3IoWcxPm1ANs5IRJsdyj703/79GUhaWXMqEFmwFithN/KrWkwhk
 iWDg8JH9V8W/28RcqXhdIKoNarVjKRU6v1UKVgoG/+DSnCGdZlJvjXkC5d0Wr/wef4cm
 yvrC6SXazXG9VBKSod/B7P2qAN8pzHhh6sMc/etxCVpjipZuAVEryZ73cnQsp0R4fLJt
 P7OUiTWYxnivsxF1gNWNVqjBayDpVzgp8HqffQURbanFo9kiMT5QE2V1JcNSUIy8USYW
 4I5w7QBBWIzTHD91OTkwamKP4lMkk4cybKHBtY93N71hXaGPKIEz2aNUNc27Yx8hqc7S
 sbFw==
X-Gm-Message-State: AOJu0Yzy+IemZGcZaA5Y5YDOoj+N13jcZoX1bYSlQ6BhMhywEhqZVYIy
 30pWwWzZoB2pMaVozkPt0OYVEyyRSvwdtWvT+1hRdxA8RGHxUirr+WD1cnrRD/0BgjmJQaN35Y7
 HPgKjV5SDIDXlrDa6x/Nxs8pJEvTOSQJvIMr4AOfmJsisk3O3FO27RUcGQh4PXqZ6HLFldguwWX
 MUCDqPchyFBVz3HTCNjFNzB4Vtp3s=
X-Received: by 2002:a05:600c:1ca9:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-4328323f576mr165154265e9.2.1730893481206; 
 Wed, 06 Nov 2024 03:44:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCKotslR6IIo1D6DNh1eCY9u1COQOHyx2Vrhw7VHB1sxQNL2qsFctqIk1X6tzkXwTd+wCjkiwgXUFJ+VZDGTc=
X-Received: by 2002:a05:600c:1ca9:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-4328323f576mr165154105e9.2.1730893480895; Wed, 06 Nov 2024
 03:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
 <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
 <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
In-Reply-To: <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Nov 2024 17:14:24 +0530
Message-ID: <CAE8KmOy48HPqW4VLJmf+ofZq+K1nM3tza3Sp4nX6sAreV0bxOg@mail.gmail.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 6 Nov 2024 at 16:05, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >+fail_iotlb:
> >+    hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> > fail_start:
> >+    hdev->vhost_ops->vhost_dev_start(hdev, false);
>
> This should go before the fail_start label, since it should not be
> called when vhost_dev_start() fails.

* I see, okay.

> Also we need to check if that callback is defined.

* That check is already done while reaching the 'goto fail_iotlb;'
statement, no? OR maybe we only check for:
hdev->vhost_ops->vhost_dev_start() function?

> >* Looking at the vhost_vdpa_dev_start(), when it is called with
> >'started=false' parameter, it calls the vdpa_suspend, vdpa_stop etc.
> >functions. ie. probably other ->vhost_dev_start() and
> >->vhost_set_iotlb_callback() functions need to take appropriate action
> >when called with 'started/enabled=false' parameter.
>
> We already call them in vhost_dev_stop(), so I guess we are fine.

* I meant vhost device functions like vhost_user_dev_start() and
vhost_user_set_iotlb_callback() need to take action when called with a
'false' parameter.

Thank you.
---
  - Prasad


