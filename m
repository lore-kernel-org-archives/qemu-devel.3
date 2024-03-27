Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC13C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPu2-00014A-LY; Wed, 27 Mar 2024 05:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPu1-00013d-Aa
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPtz-00060i-TC
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711532938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1UQkypibsieyW5RAtcoMZs1s43WqN5lVIYVjYbct6Q=;
 b=ERtLmg9Z5/ag9Hwi7vRMjRulbytIY9FBtz/IQTH98locY9UiNxZvwvdbyYUphzC9iWMase
 Kr5NBerBeIfsPXEXTNsSeB5s8EIuziUJGAMD2b4m7aQ/m80xMHKKaCLUggdp2XOEsJX0//
 rO/rvN3lxMHxQAblVvPhkvr5cGFGtew=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-zWE83fv_OfO9edm6W37kCQ-1; Wed, 27 Mar 2024 05:48:56 -0400
X-MC-Unique: zWE83fv_OfO9edm6W37kCQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5689f41cf4dso4386795a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711532935; x=1712137735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1UQkypibsieyW5RAtcoMZs1s43WqN5lVIYVjYbct6Q=;
 b=p7B+G9ennBkksGGEk8nkorotBcrnkJLncPzAapk+tlVkxKMkXE2iowj61baQ012+Sm
 76RvFac3UiDf2ceZ3xwNn7a8KD0Inhcp+OtJoh54dVbP+p7Wx9o+WQ1v5Ik4xotLtZG9
 hlmh8gCnv0L3KF+Gxpk15sNdqTbH6mf9nKB8m3VTQCqPVr658uVszGzFWNR2j9EZd11Z
 fOF1i2mr/FZGKzA63EdM74sHf4i6VKzH6W4M4qIs4w4cRvE6dgf7E9QWgBYylSm4p9vP
 MeJH5Hdb63BDkF8vNexUx26hARwPH7G0jw9xl8UjD6Nr962d0DQ/GEu0CUQBbDgCIhwn
 e+tQ==
X-Gm-Message-State: AOJu0YzenWl1kwCXGwMv1NxyDx1JUEAloAzbSohqnxqBXO3Yxc5kCD9b
 exwDM0fZDRrh93SahtR7j7m71NygiR4HUAlltsiepiGdaTMAnpOT5XWfckL1Nb3Vu7wQYtNha3o
 78dg8Abu1XPQZNfg+/TMW3M8edP4t/FhlJMuvjM5jgBtyab5tcRxz
X-Received: by 2002:a50:d71e:0:b0:568:cdf3:5cb2 with SMTP id
 t30-20020a50d71e000000b00568cdf35cb2mr637374edi.30.1711532935730; 
 Wed, 27 Mar 2024 02:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnTetmFqqzKg2lE36w9BF3BE6JgJek8vvTZF4Wn+vQejeaBYcz8wW+Bks+1SjLg0P5NuUEZw==
X-Received: by 2002:a50:d71e:0:b0:568:cdf3:5cb2 with SMTP id
 t30-20020a50d71e000000b00568cdf35cb2mr637348edi.30.1711532935413; 
 Wed, 27 Mar 2024 02:48:55 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 c13-20020a056402100d00b00568abb329a3sm5122881edu.88.2024.03.27.02.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:48:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:48:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 04/11] vhost-user-server: don't abort if we
 can't set fd non-blocking
Message-ID: <x5hjumv6dfqam4d7dvgzi4cw6yhdlnjxrxbpgkm5476z54he2p@ei3ivej3g5wx>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-5-sgarzare@redhat.com>
 <img3eawf5augdcdnrw6i2bteobxo46wjibdfzugnfikgpi7xuk@2izhutalpmwg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <img3eawf5augdcdnrw6i2bteobxo46wjibdfzugnfikgpi7xuk@2izhutalpmwg>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 09:40:12AM -0500, Eric Blake wrote:
>On Tue, Mar 26, 2024 at 02:39:29PM +0100, Stefano Garzarella wrote:
>> In vhost-user-server we set all fd received from the other peer
>> in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
>> if we fail, it's not really a problem, because we don't use these
>> fd with blocking operations, but only to map memory.
>>
>> In these cases a failure is not bad, so let's just report a warning
>> instead of panicking if we fail to set some fd in non-blocking mode.
>>
>> This for example occurs in macOS where setting shm_open() fd
>> non-blocking is failing (errno: 25).
>
>What is errno 25 on MacOS?

It should be ENOTTY.
I'll add in the commit description.

>
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  util/vhost-user-server.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
>> index 3bfb1ad3ec..064999f0b7 100644
>> --- a/util/vhost-user-server.c
>> +++ b/util/vhost-user-server.c
>> @@ -66,7 +66,11 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
>>  {
>>      int i;
>>      for (i = 0; i < vmsg->fd_num; i++) {
>> -        qemu_socket_set_nonblock(vmsg->fds[i]);
>> +        int ret = qemu_socket_try_set_nonblock(vmsg->fds[i]);
>> +        if (ret) {
>
>Should this be 'if (ret < 0)'?

I was confused by the assert() in qemu_socket_set_nonblock():
     void qemu_socket_set_nonblock(int fd)
     {
         int f;
         f = qemu_socket_try_set_nonblock(fd);
         assert(f == 0);
     }

BTW, I see most of the code checks ret < 0, so I'll fix it.

>
>> +            warn_report("Failed to set fd %d nonblock for request %d: %s",
>> +                        vmsg->fds[i], vmsg->request, strerror(-ret));
>> +        }
>
>This now ignores all errors even on pre-existing fds where we NEED
>non-blocking, rather than just the specific (expected) error we are
>seeing on MacOS.  Should this code be a bit more precise about
>checking that -ret == EXXX for the expected errno value we are
>ignoring for the specific fds where non-blocking is not essential?

Good point, maybe I'll just avoid calling vmsg_unblock_fds() when the
message is VHOST_USER_ADD_MEM_REG or VHOST_USER_SET_MEM_TABLE.

These should be the cases where carried fds are used for mmap() and so
there is no need to mark them non-blocking.

WDYT?

Stefano


