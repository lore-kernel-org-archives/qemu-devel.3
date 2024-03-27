Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2285C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQRn-0006TT-75; Wed, 27 Mar 2024 06:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpQRk-0006SY-Pw
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpQRj-0006kn-8r
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711535029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xEB09L3kQUuujKNUgQZHZTF8TZmyJtPV+blF2KEbII4=;
 b=Y9ZJdVzKBUysGprqUfJlwKFKwnpwiPOQ9AMF7JcCVZjXQWl1GTsaXdoI9q4zXqgjr9gUWJ
 RXIKsh1879UoRmnnCvHsSyjYg8KGUecWcTmRJ75cdi3dFkQuz+oKfaRV/H6jb+KmSYLOZY
 aMU9ndQRZ5xLaufiX6mfnBrQ/CV/woY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-WuaNsiCXPti3q9CZpll02A-1; Wed, 27 Mar 2024 06:23:48 -0400
X-MC-Unique: WuaNsiCXPti3q9CZpll02A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4488afb812so339397466b.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 03:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711535027; x=1712139827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEB09L3kQUuujKNUgQZHZTF8TZmyJtPV+blF2KEbII4=;
 b=s/VohJyd+yxCQW+bARu8QHBN2L4G7IBOeKW87lSFSSPB7isnYx4g5GBSZksYFUWLFI
 zkrGXXYD2+aPqeSxuJWKEDm4xYbCx4+29mY986w+tLp4IZsxxWSH0Ev9eA5iiCuTRrNP
 MrfLPDMlVK/W6jbtLYUpFE3UJ5e5DK26eP4sclcTW8ouXoxwrSW4+HPEKtArUeQEJRtv
 BwPyfdwb65T8O8gsgW6VvTVzCzGN9BQtZuZdB0CfnRbaRrm5LwXMACi7pDEAujIL5NTX
 tMzaBDNZwISYLGXpH+ibqvm5Wwq+NoOKNGFBScd9dmOjwer5nMHKqPQwaOcModutteNW
 /GUQ==
X-Gm-Message-State: AOJu0YwrVicZSfwFB9/poA4VEqeJbhFvpizNPT6cHT8guC0MLK1n4oXu
 juU9c8qL+A3759g/ck+GbmfObdAhPafqURpOZClEEGHKpUsv17yJJi0yX4VpNGFdieGzJN7B3zS
 JYTw1FkhxDdVPbordJpZQ6fIWM7ghJNjbfTY1Evrd/Yv3bw5PW0nS
X-Received: by 2002:a17:906:b305:b0:a46:69f2:5219 with SMTP id
 n5-20020a170906b30500b00a4669f25219mr2547834ejz.65.1711535027055; 
 Wed, 27 Mar 2024 03:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAvhEVMZWx6o4ntCnTSnZsj16HYBdwBrdlX0dNvj5Uy/eKA+wOvPwCVCQaMaSppRsB6qFE1g==
X-Received: by 2002:a17:906:b305:b0:a46:69f2:5219 with SMTP id
 n5-20020a170906b30500b00a4669f25219mr2547797ejz.65.1711535026687; 
 Wed, 27 Mar 2024 03:23:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 oy4-20020a170907104400b00a4df4243473sm1718145ejb.4.2024.03.27.03.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 03:23:46 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:23:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, 
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 09/11] hostmem: add a new memory backend based
 on POSIX shm_open()
Message-ID: <ymzdrrltjqubqydcyu4sygcx3g3tfqqkwgziopfisjd2aanlrb@vmufyrqdmkqf>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-10-sgarzare@redhat.com>
 <462b8b02-5585-45b9-b725-27b8c84d0d1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <462b8b02-5585-45b9-b725-27b8c84d0d1d@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Tue, Mar 26, 2024 at 03:45:52PM +0100, David Hildenbrand wrote:
>>+    mode = 0;
>>+    oflag = O_RDWR | O_CREAT | O_EXCL;
>>+    backend_name = host_memory_backend_get_name(backend);
>>+
>>+    /*
>>+     * Some operating systems allow creating anonymous POSIX shared memory
>>+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
>>+     * defined by POSIX, so let's create a unique name.
>>+     *
>>+     * From Linux's shm_open(3) man-page:
>>+     *   For  portable  use,  a shared  memory  object should be identified
>>+     *   by a name of the form /somename;"
>>+     */
>>+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
>>+                    backend_name);
>
>Hm, shouldn't we just let the user specify a name, and if no name was 
>specified, generate one ourselves?

I thought about it and initially did it that way, but then some problems 
came up so I tried to keep it as simple as possible for the user and for 
our use case (having an fd associated with memory and sharing it with 
other processes).

The problems I had were:

- what mode_t to use if the object does not exist and needs to be 
   created?

- exclude O_EXCL if the user passes the name since they may have already 
   created it?

- call shm_unlink() only at object deallocation?

So I thought that for now we only support the "anonymous" mode, and if 
in the future we have a use case where the user wants to specify the 
name, we can add it later.

That said, if you think it's already useful from the beginning, I can 
add the name as an optional parameter.

>
>I'm also not quite sure if "host_memory_backend_get_name()" should be 
>used for the purpose here.

What problem do you see? As an alternative I thought of a static 
counter.

Thanks,
Stefano


