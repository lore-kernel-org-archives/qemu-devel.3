Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9BBD44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fGE-0001OQ-Rl; Wed, 06 Nov 2024 07:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8fG9-0001Mw-78
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8fFx-0007NT-KW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730896521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IK6ouOgNc7l69NwfUk2UQAa9snd/Q7TWkZ+6+gaQLYI=;
 b=TB2MzgBcFPos7CrrYKZnFfDTCeEqOngmZYKOekW702mPkOE50azHutYTz0NtshoJ7x+WMY
 Bp6qOnkMQAHk5yGbhmb8wBcN5zsi5kALNls29WyT5hZ5FUg9TgvfHdTEuNxo18qSNJvV61
 aMnWk0WJsgN3KaW2EUobMt8/fk05aq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-XYQgqGExN6y4ogTk8eIgNg-1; Wed, 06 Nov 2024 07:35:17 -0500
X-MC-Unique: XYQgqGExN6y4ogTk8eIgNg-1
X-Mimecast-MFC-AGG-ID: XYQgqGExN6y4ogTk8eIgNg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so48827945e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 04:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730896516; x=1731501316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IK6ouOgNc7l69NwfUk2UQAa9snd/Q7TWkZ+6+gaQLYI=;
 b=KC4BLlcgXE7bQ8BEjpZY2efWdQJf4Sk6doRIlPebB7rO+t9FhzpBLeukbRnetkePR7
 ofwQeyrjnCVEAxKJXLcCAwZiwTTfnQfBgJ2baWIDPTqCFY4hhptk9a+B31FMOSUEu5YR
 q9nACmTw0icXGiXGmeSfzcN4zYPV2UQCJB529/qKbMDYqHNI1af6u1cqIHVgQXo5QCjt
 zAI7CePWXQLvp9+snCFNfBZCuix8lqKcGZwY/Uyruotyip4LP+g6ZqnwJN68hhYxvVIA
 RlpftZ73budpBOV+sVV9ZXaSaMYHWwSu//hcVr3Wt6WI2TCa5AuGiwAVsgGanyeV0AOV
 zxVA==
X-Gm-Message-State: AOJu0YwXG0b/meW1yH8VCE8Xadw8Tr7gOvU4FdRFbqi0OGB8ZDLzoVK5
 2lURyjPXTql6yMZ+1aX4Rzf4DwDep9Kzk/qcNICdOu9ALqTOCTHwH622hffbaFqsReySnoVDE4D
 z7lI+5u/kmUBm5ubScd8Sj5ulR8KYEUJ7YVT8/Jch3qMZhyLuD239fcpIKERgG7NhiOPWUAJ6gG
 ICjIVXMGaiYzlVtlcrHkYPCoZ88YU=
X-Received: by 2002:a05:600c:4f85:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-4327b6fd60dmr196080905e9.11.1730896516563; 
 Wed, 06 Nov 2024 04:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1n2+XwtEVS5o6IIFDd6NmlqgPR9Ttb8DJLA+fV0OrEh0DdLh4SqnE7WqeN5W8srwZVNmlbrUm6AuTdD53gSM=
X-Received: by 2002:a05:600c:4f85:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-4327b6fd60dmr196080715e9.11.1730896516265; Wed, 06 Nov 2024
 04:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
 <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
 <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
 <CAE8KmOy48HPqW4VLJmf+ofZq+K1nM3tza3Sp4nX6sAreV0bxOg@mail.gmail.com>
 <p4ryblk3o63lao45cplo2ws6l5thcmt52phue63benvwhjrdud@53ta327k6mhj>
In-Reply-To: <p4ryblk3o63lao45cplo2ws6l5thcmt52phue63benvwhjrdud@53ta327k6mhj>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Nov 2024 18:04:59 +0530
Message-ID: <CAE8KmOy+VM6o7F08vgkCs3HQK5_j8dW-wbLz-4tew6UqoSVRFg@mail.gmail.com>
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

On Wed, 6 Nov 2024 at 17:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
> For vhost_set_iotlb_callback() that is true because for now we go to
> that label only if the callback is defined, but this is not the case for
> hdev->vhost_ops->vhost_dev_start().
>
> Anyway if in the future we add a new step that need to go on that label
> we may forgot to remember that, so since it's not a hot path, I'd add
> both checks as we do in vhost_dev_stop().

* Okay.

> IIUC in vhost_dev_stop() we already call both of them with a 'false'
> parameter, so that functions should be already prepared or am I missing
> something?
===
static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
{
    ...
    if (started) {
        return vhost_user_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                          VIRTIO_CONFIG_S_DRIVER |
                                          VIRTIO_CONFIG_S_DRIVER_OK);
    } else {
        return 0;
    }
}
static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
{
    /* No-op as the receive channel is not dedicated to IOTLB messages. */
}
===

* vhost_user_dev_start and vhost_user_set_iotlb_callback() don't seem
to do much when called with 'false' parameter.

Thank you.
---
  - Prasad


