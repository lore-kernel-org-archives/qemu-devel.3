Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48932C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmj7-00020w-7k; Thu, 14 Mar 2024 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmj2-00020P-1b
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmiz-0001Co-76
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pj3aaqN19j56qx4MelVBDieuga/+og8o6ZW80EXc2Mc=;
 b=B5PY0lwFyKLvFi9zK2UJtoyFdDmJfnn9MXlUOO7JOT61TiwIcVHGtNRsaou+gL6+WpRL5K
 JYugjoIao50SPWVkif3HFeKe/CbsDWxXHl9TcOGSY84BjnJOk8dYxwacU8QuBIEHS5WJpM
 wrCXCxiQK50V0BzzYBn0BPL+gaJmX4E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AdilCfpYOuucKOsZ-W5xpw-1; Thu, 14 Mar 2024 11:10:22 -0400
X-MC-Unique: AdilCfpYOuucKOsZ-W5xpw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-60a0151f194so17789707b3.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710429022; x=1711033822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pj3aaqN19j56qx4MelVBDieuga/+og8o6ZW80EXc2Mc=;
 b=MOwE43PeQ2PvPC7loX1QCsyHkYdvKXtp9nHrQp2p6wJmIyNdxwmh5LypMRAb0H38/N
 lEMc8bGc7VoLA4avbkCp+0AUKfpeIsqym3dNMQujd0HQH9xw/MkuIpD+T5Q/Y17olg5E
 CtHiNYCivxe8W5GXj+sZjJejW+uv3yuZbCqBuwvAFGGD4NEbRMbmFTHSxUPwKJ0NEwbQ
 qJzZjAwIXccqAYEdwzAQpqo1o9ofWEHYeLD3bfJZ1wk+KWQdyGTVOO3RhNNwC3A2D4ho
 URR+7C8S1/V7yj97qiXrn4Pr31iWQXFlehYvtiGluH+PdHmznsTgePgrGcDxhflTkL4C
 /E3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlrJMWbqoal4z/kcRV/nC501+EJk0CuiUoTk5MKvz5fmruSB4Uxx6e4OKPMtrJ00rdd8dI3Y7RSee2ieLwu4lFG4wtvXo=
X-Gm-Message-State: AOJu0YxNFgoKe++zwVou1Miu+ZfwH5fBbjHhQHL0IhRy/3IibqE7ph+W
 boco/cm65sPBJbdbrUza9pH+5H0rp11Qu7i3c74EE9d8rzC0dpo70sXfi5ZqdwWNlK5r0YqJyhi
 yL1MZfDbWT2KVK05jZwiv+qIzGD1mcZnql0XzB2YNSeYsIEJqGZnXkFaE+wIa3LCXNTZ+makS/Y
 dLg6MoZ/8weUzocCXaAD846vnERSOVBHDm3HM=
X-Received: by 2002:a05:690c:3413:b0:60c:d234:5c78 with SMTP id
 fn19-20020a05690c341300b0060cd2345c78mr870537ywb.4.1710429022051; 
 Thu, 14 Mar 2024 08:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExXbQgi7wca5rENcsFtd/VX7cEArG91TSGIc5MPu9U05jXnf1WlIX5idkJBYMt7syEeb24AI2NJ72fJ4iNMZ8=
X-Received: by 2002:a05:690c:3413:b0:60c:d234:5c78 with SMTP id
 fn19-20020a05690c341300b0060cd2345c78mr870518ywb.4.1710429021813; Thu, 14 Mar
 2024 08:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
 <CAJaqyWfOaYmX-6qo-O2xWjge5av_2MDLnQVO41XLskLQC6nXsQ@mail.gmail.com>
 <6022175.lOV4Wx5bFT@valdaarhun>
In-Reply-To: <6022175.lOV4Wx5bFT@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 16:09:45 +0100
Message-ID: <CAJaqyWcuU_kQpCN+U3ejWgfm+zBv3Mofe0zyi-RB+rbqgDHEgg@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 1, 2024 at 7:29=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote:
>
> Hi,
>
> On Friday, March 1, 2024 1:10:49 PM IST you wrote:
> > [...]
> > You can add the recently published
> > "virtio-live-migration-technical-deep-dive" :) [1].
> >
> > [1]
> > https://developers.redhat.com/articles/2024/02/21/virtio-live-migration=
-technical-deep-dive
>
> Thank you. This resource will help me cover a lot of ground.
>
> > [...]
> > There are few other tasks pending for QEMU in general and SVQ in
> > particular. I'll add them as gitlab issues by today.
> >
>
> That would be nice. I'll keep an eye out for the new issues.
>

Hi Sahil,

It's being hard to find a good self-contained small task related to
the project to be honest. As it would be out of SVQ, would it be ok
for you if we start straight to the task of adding the packed vq
format to SVQ?

Thanks!


