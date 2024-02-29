Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263EC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfc3m-0005Ye-7b; Thu, 29 Feb 2024 03:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfc3c-0005Vf-14
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfc3a-00083e-Il
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wx+AkhU8MI5zY2thsIZeEcMDm0VENVFATriIWkvIUN4=;
 b=VGPZVlhcCrk/yw1gTOE1Rh+QMIIqSkrf0z7cVDRmu+XuRURKqUh6SQXsmglcmAhkPsq/RN
 JDBxgDxVkf8ymUuMP1QLKGe2m2KPu0eomVKJSQ+1hge3NcFSyJbRpe+p9snjWvim22SCLd
 EswDnOsxfTGs/YNJkgL0M7/Tg60b+qo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-sULdlrxNNMKGQZKcLP4DAA-1; Thu, 29 Feb 2024 03:46:20 -0500
X-MC-Unique: sULdlrxNNMKGQZKcLP4DAA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78319f64126so95860285a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709196379; x=1709801179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wx+AkhU8MI5zY2thsIZeEcMDm0VENVFATriIWkvIUN4=;
 b=UR0sfC3HCbOa1J3IAIYfeUVKACC/SjfI3hHgUQRx8oTJaZjVtPxhe6DWhh/zgX7+6b
 kpypxqFl+G6ZWiClOxDBuojKP58VCmFzVe+l6IIhDRu3pVRPV1yW8jJP8L0d2HsnQI+P
 P/KT5mu+VlJrbBDDdnnBu/cNvKo0RaE8jf3seWyA06WMcMDPQNjYmaDjJYURbqsa6yDw
 vbyZdrbxuQbV+hzwyU+N8TuwTkXmJZ2LYDqfrTw2zJkzz3CTg3ZcaJ3rwZRTFxdZ/Ime
 Z6tF67tlEvBJ8jPWEalVWuoJo9jbGQXZkIQ1CYT/i+Qou1AMkTBXHu7iY2J1FZ1zwfRV
 9jPA==
X-Gm-Message-State: AOJu0YwjBvLMGCp+Ptsc9J6s6k2JmLFGQ47GvL9DuKzr8XZuSXV3hAJT
 D3syzrEFWDACc08P68CkWDkEIK1w2aIeDMG6Gum770KnP66GOmNex4nXNciUSMlfRREuC2vG8Bh
 6czlySrpCYM1qKRgDpM3IwD4X0zRgwis4KFmKX+moys7UeEb/bKlk
X-Received: by 2002:a05:620a:621c:b0:787:caf2:e1b1 with SMTP id
 ou28-20020a05620a621c00b00787caf2e1b1mr1482180qkn.51.1709196379641; 
 Thu, 29 Feb 2024 00:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRc1lLItSg+EGxFkgpirBP3S/JpLQRdWxjOJDYiXkJkOi+J/EdVOoBMe4B79dFwTuhU0kY9g==
X-Received: by 2002:a05:620a:621c:b0:787:caf2:e1b1 with SMTP id
 ou28-20020a05620a621c00b00787caf2e1b1mr1482154qkn.51.1709196379374; 
 Thu, 29 Feb 2024 00:46:19 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 r4-20020a05620a03c400b007873fe9f4bcsm461053qkm.52.2024.02.29.00.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 00:46:18 -0800 (PST)
Date: Thu, 29 Feb 2024 09:46:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Message-ID: <n4ujr63ecazp5nfncu6xmpzf72zfrez4mq6jacfb77tc6bzcoi@w6g3llcj7l6o>
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
 <1dbd722f-d8e2-43a2-a76d-7889e002f7d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1dbd722f-d8e2-43a2-a76d-7889e002f7d8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 28, 2024 at 01:01:55PM +0100, David Hildenbrand wrote:
>On 28.02.24 12:47, Stefano Garzarella wrote:
>>Add a new `shm` bool option for `-object memory-backend-file`.
>>
>>When this option is set to true, the POSIX shm_open(3) is used instead
>>of open(2).
>>
>>So a file will not be created in the filesystem, but a "POSIX shared
>>memory object" will be instantiated. In Linux this turns into a file
>>in /dev/shm, but in other OSes this may not happen (for example in
>>macOS or FreeBSD nothing is shown in any filesystem).
>>
>>This new feature is useful when we need to share guest memory with
>>another process (e.g. vhost-user backend), but we don't have
>>memfd_create() or any special filesystems (e.g. /dev/shm) available
>>as in macOS.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>I am not sure this is the best way to support shm_open() in QEMU.
>>
>>Other solutions I had in mind were:
>>
>>- create a new memory-backend-shm
>>
>>- extend memory-backend-memfd to use shm_open() on systems where memfd is
>>not available (problem: shm_open wants a name to assign to the object, but
>>we can do a workaround by using a random name and do the unlink right away)
>>
>>Any preference/suggestion?
>
>Both sound like reasonable options, and IMHO better than hostmem-file 
>with things that are not necessarily "real" files.

Yeah, I see.

>
>Regarding memory-backend-memfd, we similarly have to pass a name to 
>memfd_create(), although for different purpose: "The  name  supplied 
>in name is used as a filename and will be displayed as the target of 
>the corresponding symbolic link in the directory /proc/self/fd/".
>
>So we simply pass TYPE_MEMORY_BACKEND_MEMFD.

Okay, so I guess it must be unique only in the process, while for 
shm_open() it is global.

>
>Likely, memory-backend-shm that directly maps to shm_open() and only 
>provides properties reasonable for shm_open() is the cleanest 
>approach. So that would currently be my preference :)

Thank you for your thoughts, I think I will go toward this direction 
(memory-backend-shm).

It was also my first choice, but in order to have a working RFC right 
away, I modified memory-backend-file.

Stefano


