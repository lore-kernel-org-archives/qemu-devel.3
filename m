Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B5FC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6zy-0003zG-GQ; Fri, 01 Mar 2024 12:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rg6zw-0003lZ-O2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rg6zv-0000op-1Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709315317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTTjVnUQSj5ym4AyEk2AfhV6NkUqqLnFCzLcylUcINs=;
 b=OoSvbjLoLRA3PflXLPhxAjYGXb/WggaB8sPoPh6+ObXW+ZRP1K1GONnV+woCzjIb8CyaSV
 vBYj7dFSMzlfwHMjoSqvll9U0wZhSrurFxhlXqcF3wUgv+ttTRZ1uI1C5v67colvSvup/z
 J0eCDXlj6QuALrtIUhu9OdxO4snpyiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680--lCnfjIwOeK_iFRPJ-8m8w-1; Fri, 01 Mar 2024 12:47:28 -0500
X-MC-Unique: -lCnfjIwOeK_iFRPJ-8m8w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412c7f1ca35so5533785e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709315247; x=1709920047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTTjVnUQSj5ym4AyEk2AfhV6NkUqqLnFCzLcylUcINs=;
 b=mdQFcKUqk1lN37RGuk/zc/fQ0Fa3Mm9hCEs2A5nG4lgRjFd1bpDjNG8e1ckqZFBh8t
 71qeZUSdudFwxkF3ecTvj7K1LZrKsrS0wOfffFC/lZlelH1kLAQcUrrUGd0tknMGUecn
 Bu8M04IJHGl6EL4dqF/T1vzJpKZ0CBlvfnRt0DyMtWsd5A/A7xnuSbOIOz85ytAkZ7PL
 jcGcTmETS3ASy0IxmZ8MxitqFgi07m+HpiVPhznF6mdBl42HVZu8ZpgSjgrBKFDdzPod
 qZhSNQgMLyQD2iezwm0vsXEiH0LTLXN6UgsUCByV2wG8R4c/RzsXf76NmY+iTLxJ5PiL
 5oow==
X-Gm-Message-State: AOJu0Yza9subF/bRo8sFnh9nIrNFPoiu61DVDiDopC5Lc9DJ8/2cR4RC
 DZSUb4xzV6YmmbIMHOkVgTsjxI0zn6oA29wdV/7bcxKVIinFSHNzntw8cdw+iG1W5eV7pkW+AWQ
 q8McpfHJ/4bXSOyeP/LkvXeq6UwOoatO7foP/mq6JeNyGq3z6f4fqp6MsIaPDU0M7H5wgydIUUq
 FB0GfJ1Tj6gxeL93NCiDuA3hPC7EY=
X-Received: by 2002:a05:600c:3ac7:b0:412:b782:9001 with SMTP id
 d7-20020a05600c3ac700b00412b7829001mr2377237wms.18.1709315247109; 
 Fri, 01 Mar 2024 09:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkuWUbm/39F3qpYX6Wzfvy2FZo7YsvdRM3oiv2ajHMVih928FTPb4oP1nHad5jTq5UZAAksytEUZXiAjT+Q0c=
X-Received: by 2002:a05:600c:3ac7:b0:412:b782:9001 with SMTP id
 d7-20020a05600c3ac700b00412b7829001mr2377220wms.18.1709315246805; Fri, 01 Mar
 2024 09:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20240301091524.39900-1-peterx@redhat.com>
In-Reply-To: <20240301091524.39900-1-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 1 Mar 2024 23:17:10 +0530
Message-ID: <CAE8KmOz_5-DtSO2BHpBXgD2kJUjwsLaqKguOcWgfXC2efB2rWA@mail.gmail.com>
Subject: Re: [PATCH] migration/multifd: Document two places for mapped-ram
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Petr,

On Fri, 1 Mar 2024 at 14:46, <peterx@redhat.com> wrote:
> +         * An explicitly close() on the channel here is normally not

explicitly -> explicit

> +         * required, but can be helpful for "file:" iochannels, where it
> +         * will include an fdatasync() to make sure the data is flushed to
> +         * the disk backend.

* an fdatasync() -> fdatasync()

* qio_channel_close
    -> ioc_klass->io_close = qio_channel_file_close;
     -> qemu_close(fioc->fd)
      -> close(fd);

It does not seem to call fdatasync() before close(fd);

    - qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC, ...)

Maybe the qio_channel..() calls above should include the 'O_DSYNC'
flag as well? But that will do fdatasync() work at each write(2) call
I think, not sure if that is okay.

> +         *
> +         * The object_unref() cannot guarantee that because: (1) finalize()
> +         * of the iochannel is only triggered on the last reference, and
> +         * it's not guaranteed that we always hold the last refcount when
> +         * reaching here, and, (2) even if finalize() is invoked, it only
> +         * does a close(fd) without data flush.
> +         */

* object_unref
    -> object_finalize
      -> object_deinit
        -> type->instance_finalize
         -> qio_channel_file_finalize
          -> qemu_close(ioc->fd);

* I hope I'm looking at the right code here. (Sorry if I'm not)

Thank you.
---
  - Prasad


