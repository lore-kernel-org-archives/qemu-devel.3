Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FDBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIj4-0000qj-7E; Mon, 15 Jul 2024 06:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTIj1-0000iB-Fl
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTIiz-0003El-Rs
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721038468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ClE7MssEkXPSJEJY2pJm4BRiFz4q2oFbFGcFlO5/nM=;
 b=Ob4uIu3Klma+hRhVNHURC0HHQgAiYU/2Jse4byAa+OoB8FpjM/rQpjMehve9K14sx48Otw
 1GFN5HnxpfGaa9Jt4YibKWGpkv/CyR09Oq3WeUdpOmvdXJFAxT+R8MEJHKy4By2u86WjG3
 022f1DhKSaqGmk6aKFhZzI3Mix6rwz0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-RrJ1s6uCMMWLKAiwdORRvw-1; Mon, 15 Jul 2024 06:14:25 -0400
X-MC-Unique: RrJ1s6uCMMWLKAiwdORRvw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42668699453so39182655e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038464; x=1721643264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ClE7MssEkXPSJEJY2pJm4BRiFz4q2oFbFGcFlO5/nM=;
 b=pY7MoLG/82QCk42e3hxTZOGWsMNE1P0HkZQ3p9WHdasxPEROmGKCLV0MlgmS86re7V
 n3M1YCsxc2eIPA9k02aXi1Sr1K0pmlFYKl108yiN1uKIPx4gMfzaUBvjxSrLmvCHD0CG
 U8ZLWYqtHHibTE3KZJvZf5afbx+UbIRtwI5n8AJ3N9X2P0g1wB4BOWYAHlGNV5vGbUD6
 ypVqWYGIVewSnvK/wHUtbKHVuHQ9PrSD2q+CJunbLh1BUTrdzdDPiitSNsqGBzxtlQzh
 iW1SxxP8Qz/rwjYmbwTHVbSm9aP5GGrvbgelQBXhfV3aE3gQkgK5JEl/6VG2nXe+mL1D
 FCdw==
X-Gm-Message-State: AOJu0Yzl214hG+jQdcOEFAoxQzkK0H4t+TQ/s+V+Xt2nch4oZ5UjpgrZ
 ArovBQSFWKJHCgF7Jjd379npxqH6zrq5BYnQnA2/fT4gnsmf6wzOUZD4skQqWx0aksAif9O+jqi
 LafJ5eJUwWPqWXuXsbHmWX4ILBtW5NFL7giLR56ghIVcvPBGbj6V0Uy7cjeJbJkevTF8QqnWOP+
 7LyK4F54SQr/hFhg3+zbGmQZrbSW8=
X-Received: by 2002:a05:600c:4f8d:b0:427:9dae:2768 with SMTP id
 5b1f17b1804b1-4279dae2866mr82820055e9.38.1721038463868; 
 Mon, 15 Jul 2024 03:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhYVJKn/uCKrKnoI3KOFZKe7gpdSbiEPh/Kx4FemTcT6wtteckA1uUtgMr1lk6SEtnPdf5FH0OnrKimDAUbk8=
X-Received: by 2002:a05:600c:4f8d:b0:427:9dae:2768 with SMTP id
 5b1f17b1804b1-4279dae2866mr82819865e9.38.1721038463564; Mon, 15 Jul 2024
 03:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
In-Reply-To: <Zo_8fpKH8oBA8WV1@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 15 Jul 2024 15:44:06 +0530
Message-ID: <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, 11 Jul 2024 at 21:08, Peter Xu <peterx@redhat.com> wrote:
> Hmm, I thought it was one of the vcpu threads that invoked
> vhost_dev_start(), rather than any migration thread?

     [QEMU=vhost-user-front-end]  <===========>   [QEMU=vhost-user-front-end]
                            ^
                                    |
                            |
                                     |
                            |
                                     |
                            |
                                    V
[external-process=vhost-user-back-end]
[external-process=vhost-user-back-end]
===
vhost-user-protocol:
    -> https://www.qemu.org/docs/master/interop/vhost-user.html#vhost-user-proto

* It is not clear which thread calls vhost_dev_start() routine, it
could be a vCPU thread.  Sending 'postcopy_end' message to the
'vhost-user-back-end', hints that the device was being migrated and
migration finished before the device set-up was done. The protocol
above says

    "...The nature of the channel is implementation-defined, but it
must generally behave like a pipe: The writing end will write all the
data it has into it, signalling the end of data by closing its end.
The reading end must read all of this data (until encountering the end
of file) and process it."

* It does not mention sending the 'postcopy_end' message. But it talks
about the front-end sending 'VHOST_USER_CHECK_DEVICE_STATE' to the
back-end to check if the migration of the device state was successful
or not.

> I remember after you added the rwlock, there's still a hang issue.
> Did you investigated that?  Or do you mean this series will fix all the problems?

* No, this series does not fix the guest hang issue. Root cause of
that is still a mystery. If migration is ending abruptly before all of
the guest state is migrated, the guest hang scenario seems possible.
Adding vhost-user-rw-lock does not address the issue of end of
migration.

* From the protocol page above, it is not clear if the front-end
should allow/have multiple threads talking to the same vhost-user
device.

Thank you.
---
  - Prasad


