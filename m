Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C119C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siXkG-0000QW-97; Mon, 26 Aug 2024 07:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siXkF-0000Q0-4s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 07:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siXkC-0003WG-DW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724671123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VjXWNlognirEp1Z6ho26/xSVDfYIZzIShcgtjl5pBUI=;
 b=B2ofvVMRkWg1IbJanygWr49E/W2k5w3Rp6hgJj0qMNUgRjTz/6MlXkmcJlgGuqOUu/Z5EO
 hpFZFwdEO3f9FiF4GVhATtbW/H3Qw7oioNOLU7oaNPhdlgp1/Hze7Hx0YEKXYGNMASmmgR
 Ic/vs6XjP0qSPWnEAf/JxLZP5VE6eCk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-4akYpkl9OzuEh0cg7bFbLw-1; Mon, 26 Aug 2024 07:18:41 -0400
X-MC-Unique: 4akYpkl9OzuEh0cg7bFbLw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42808685ef0so40313775e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 04:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724671120; x=1725275920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjXWNlognirEp1Z6ho26/xSVDfYIZzIShcgtjl5pBUI=;
 b=S5p8yERugZ0tkCzIxHoa15L2L7znd18ZBKoLT28LZRNJZyWF0hvasa2yBGyz5F9xAd
 vTkZL5H/ePQW4mTMpQPl5LsTHPRYDsxH0BSKvvWC+TUynlZ3SdLB9ZH5D6l/Gr4ieIM0
 L59xrDO+A5lyvJHmQU9X9mcBZZJTi9oO7b1+q27fSiyaA+VPN61tXoGh05O+8XxLYbmb
 KgjOv53ZzV4WK/zG19H5zx2kbFJ+PqcoXSv+7Tf4QhLUR6GLRWpsBHOlC1G72aqJnYZ7
 EqRKKbDeyFfms0YCaEagi0ONHZYGy9DzU5spXGlVT4qaK0uqsk+ZYHnEZwEqYGzezirE
 QnWQ==
X-Gm-Message-State: AOJu0Yzw49vhI67aSR6+Ed+SKu9WuaaI1q4hkfBtiVFxbfLZIY8jsQst
 5BiXcgaVjBbYdbv9zr2NHC6zPXpjKJdJWKfTuQ03Spm8OYO/fOVZL/597LYaj4/PcuyJDbjReMM
 DmYnGwBXurkjO/j2HLlUpwDbDyXpnLkPSW0UKHgu6NaiVfQvpuSo4Ir7icSWrK9kZD2HzcA3qED
 0CajFmqOYDFlpw/yha30NHdCdsIKg=
X-Received: by 2002:a05:600c:310e:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42acc9fdcf4mr71450245e9.23.1724671120588; 
 Mon, 26 Aug 2024 04:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgZiEBUbrGNPjLzqSpuDLwPPm0eYe2BHMZmfBMnxPZc+oKEFY05GRAehq+fN8DRfBEsU/fiNDT8SXxAWoOZB8=
X-Received: by 2002:a05:600c:310e:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42acc9fdcf4mr71450045e9.23.1724671120079; Mon, 26 Aug 2024
 04:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-16-farosas@suse.de>
In-Reply-To: <20240823173911.6712-16-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 26 Aug 2024 16:48:22 +0530
Message-ID: <CAE8KmOwNRMJktPadF1r86U0tRTF_ZsJ14CSjVJMcrKyFW-8isg@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] migration/multifd: Register nocomp ops
 dynamically
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 23 Aug 2024 at 23:12, Fabiano Rosas <farosas@suse.de> wrote:
> Prior to moving the ram code into multifd-nocomp.c, change the code to
> register the nocomp ops dynamically so we don't need to have the ops
> structure defined in multifd.c.
>
> While here, move the ops struct initialization to the end of the file
> to make the next diff cleaner.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9f40bb2f16..e100836cbe 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -287,22 +287,12 @@ static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
>      return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>  }
>
> -static MultiFDMethods multifd_nocomp_ops = {
> -    .send_setup = multifd_nocomp_send_setup,
> -    .send_cleanup = multifd_nocomp_send_cleanup,
> -    .send_prepare = multifd_nocomp_send_prepare,
> -    .recv_setup = multifd_nocomp_recv_setup,
> -    .recv_cleanup = multifd_nocomp_recv_cleanup,
> -    .recv = multifd_nocomp_recv
> -};
> -
> -static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
> -    [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
> -};
> +static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
>
>  void multifd_register_ops(int method, MultiFDMethods *ops)
>  {
> -    assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
> +    assert(0 <= method && method < MULTIFD_COMPRESSION__MAX);
> +    assert(!multifd_ops[method]);
>      multifd_ops[method] = ops;
>  }
>
> @@ -1701,3 +1691,19 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
>
>      return true;
>  }
> +
> +static MultiFDMethods multifd_nocomp_ops = {
> +    .send_setup = multifd_nocomp_send_setup,
> +    .send_cleanup = multifd_nocomp_send_cleanup,
> +    .send_prepare = multifd_nocomp_send_prepare,
> +    .recv_setup = multifd_nocomp_recv_setup,
> +    .recv_cleanup = multifd_nocomp_recv_cleanup,
> +    .recv = multifd_nocomp_recv
> +};
> +
> +static void multifd_nocomp_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_nocomp_ops);
> +}
> +
> +migration_init(multifd_nocomp_register);

Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


