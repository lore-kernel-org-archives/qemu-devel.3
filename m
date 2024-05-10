Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9668AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Mhg-0002EH-Gh; Fri, 10 May 2024 05:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5Mhe-0002DS-Jd
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s5Mhc-0006lB-O4
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715333888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQhTI03BVATvSInONLlixQvSte1ObADZzyV0KxjM1a0=;
 b=W32ZSbr8XUFfl0gZGGS8/jtOZPZUxvPHKc8XqrMk/k+/c/RKxVyCc3gkAqexuA099ihHrp
 4K2zx9f4MLju6Buf3lrhoLyvm/m6Uhk9uuJIxBQCOW2lF2S7Jz3gdaps1xKxRMYuEm2prA
 8naEZ2DV6sBt3zrOmr0zcGmbV6a7HF0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-JrtrKLGIOHm-oG6m1Z9zqQ-1; Fri, 10 May 2024 05:37:18 -0400
X-MC-Unique: JrtrKLGIOHm-oG6m1Z9zqQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e233a3d4b0so18682831fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715333831; x=1715938631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQhTI03BVATvSInONLlixQvSte1ObADZzyV0KxjM1a0=;
 b=Q2gSDxbMaVtyZV9qOuLD/D7YAG3lWyljZA57G25+wKYIdonSU2x+Jrm0kvc8xZaIsB
 ra0jtuSLbREEJQ9lUHNIhsum0vccwslNvA6FYRVWSlX4naI6sMs3ps5P1ZpLK/+M4gwj
 DmrZXI9nxK2gB1Zg/PglFqFeTESsPtbNj3mRix1y29dJI0sy4L+q/cD1sTQatQjnwmak
 6Lotry4fFC/Zv8zXgbpTuMwadZqBVM1BwDEHZX6kvGZTeL4ohNZJ04noUcfW+arXyURK
 7Iq+qYoHViGteKOtN34OxvLosQxJpuv+rzvH02jTjG+005DWKuTH+OlR8kcshdmY/feH
 ky3g==
X-Gm-Message-State: AOJu0YzFcR/beGBNvJUKsORGvhnE0jalY2JMeyu9jzKm1aQWv/7jgwtn
 amRrzNDKuaxum2PfSEj5dLlkpv6DalZSc2hrpE3fM+QlcPt2UgbitdI0V+mZ1mrgQLVoVF6NGQf
 aaUMoUhBPqkaT+NXfBTVE3q0XA4OyD/tbLsMZnrxSC5SWS2NE1nmp
X-Received: by 2002:a2e:2c13:0:b0:2e1:e8fa:4f56 with SMTP id
 38308e7fff4ca-2e52028e665mr11879521fa.42.1715333831541; 
 Fri, 10 May 2024 02:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMOpY639QzCXuxQWaMTchJeBixjWB0UQGzhZVUVUO8HZ0O8Pde3imufqgCh1zwnvBrq5syWQ==
X-Received: by 2002:a2e:2c13:0:b0:2e1:e8fa:4f56 with SMTP id
 38308e7fff4ca-2e52028e665mr11879151fa.42.1715333831030; 
 Fri, 10 May 2024 02:37:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it.
 [87.12.25.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccfe1277sm55580605e9.42.2024.05.10.02.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 02:37:10 -0700 (PDT)
Date: Fri, 10 May 2024 11:37:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 gmaglione@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 10/12] hostmem: add a new memory backend based on
 POSIX shm_open()
Message-ID: <z3lbtmkn6zlwdhdea7owav3mblttxr3asrmlilwxmkla67tdby@732gn3uuupoq>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-11-sgarzare@redhat.com>
 <87y18kcy56.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y18kcy56.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Wed, May 08, 2024 at 01:59:33PM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> shm_open() creates and opens a new POSIX shared memory object.
>> A POSIX shared memory object allows creating memory backend with an
>> associated file descriptor that can be shared with external processes
>> (e.g. vhost-user).
>>
>> The new `memory-backend-shm` can be used as an alternative when
>> `memory-backend-memfd` is not available (Linux only), since shm_open()
>> should be provided by any POSIX-compliant operating system.
>>
>> This backend mimics memfd, allocating memory that is practically
>> anonymous. In theory shm_open() requires a name, but this is allocated
>> for a short time interval and shm_unlink() is called right after
>> shm_open(). After that, only fd is shared with external processes
>> (e.g., vhost-user) as if it were associated with anonymous memory.
>>
>> In the future we may also allow the user to specify the name to be
>> passed to shm_open(), but for now we keep the backend simple, mimicking
>> anonymous memory such as memfd.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4
>> - fail if we find "share=off" in shm_backend_memory_alloc() [David]
>> v3
>> - enriched commit message and documentation to highlight that we
>>   want to mimic memfd (David)
>> ---
>>  docs/system/devices/vhost-user.rst |   5 +-
>>  qapi/qom.json                      |  17 ++++
>>  backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
>>  backends/meson.build               |   1 +
>>  qemu-options.hx                    |  13 +++
>>  5 files changed, 157 insertions(+), 2 deletions(-)
>>  create mode 100644 backends/hostmem-shm.c
>>
>> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>> index 9b2da106ce..35259d8ec7 100644
>> --- a/docs/system/devices/vhost-user.rst
>> +++ b/docs/system/devices/vhost-user.rst
>> @@ -98,8 +98,9 @@ Shared memory object
>>
>>  In order for the daemon to access the VirtIO queues to process the
>>  requests it needs access to the guest's address space. This is
>> -achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
>> -objects. A reference to a file-descriptor which can access this object
>> +achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
>> +``memory-backend-shm`` objects.
>> +A reference to a file-descriptor which can access this object
>>  will be passed via the socket as part of the protocol negotiation.
>>
>>  Currently the shared memory object needs to match the size of the main
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 38dde6d785..52df052df8 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -721,6 +721,19 @@
>>              '*hugetlbsize': 'size',
>>              '*seal': 'bool' } }
>>
>> +##
>> +# @MemoryBackendShmProperties:
>> +#
>> +# Properties for memory-backend-shm objects.
>> +#
>> +# The @share boolean option is true by default with shm.
>
>This contradicts the doc comment for @share:
>
>   # @share: if false, the memory is private to QEMU; if true, it is
>   #     shared (default: false)
>
>Your intention is to override that text.  But that's less than clear.
>Moreover, the documentation of @share is pretty far from this override.
>John Snow is working on patches that'll pull it closer.
>
>Hmm, MemoryBackendMemfdProperties has the same override.

Yep, I followed @MemoryBackendMemfdProperties and 
@MemoryBackendEpcProperties.

>
>I think we should change the doc comment for @share to something like
>
>   # @share: if false, the memory is private to QEMU; if true, it is
>   #     shared (default depends on the backend type)
>
>and then document the actual default with each backend type.

I agree on that, but I think we should do in a separate series/patch.
If you prefer, I can send that patch.

>
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MemoryBackendShmProperties',
>> +  'base': 'MemoryBackendProperties',
>> +  'data': { } }
>
>Let's add 'if': 'CONFIG_POSIX' here.
>

Do you mean something like this:

{ 'struct': 'MemoryBackendShmProperties',
   'if': 'CONFIG_POSIX',
   'base': 'MemoryBackendProperties',
   'data': { } }

I didn't because for MemoryBackendMemfdProperties and
MemoryBackendEpcProperties we have 'if': 'CONFIG_POSIX' only later in
the ObjectOptions union, so I did the same.

Should we fix them as well?

>> +
>>  ##
>>  # @MemoryBackendEpcProperties:
>>  #
>> @@ -985,6 +998,8 @@
>>      { 'name': 'memory-backend-memfd',
>>        'if': 'CONFIG_LINUX' },
>>      'memory-backend-ram',
>> +    { 'name': 'memory-backend-shm',
>> +      'if': 'CONFIG_POSIX' },
>>      'pef-guest',
>>      { 'name': 'pr-manager-helper',
>>        'if': 'CONFIG_LINUX' },
>> @@ -1056,6 +1071,8 @@
>>        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>>                                        'if': 'CONFIG_LINUX' },
>>        'memory-backend-ram':         'MemoryBackendProperties',
>> +      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
>> +                                      'if': 'CONFIG_POSIX' },
>>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>>                                        'if': 'CONFIG_LINUX' },
>>        'qtest':                      'QtestProperties',
>
>[...]
>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index cf61f6b863..2226172fb0 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -5227,6 +5227,19 @@ SRST
>>
>>          The ``share`` boolean option is on by default with memfd.
>>
>> +    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>> +        Creates a POSIX shared memory backend object, which allows
>> +        QEMU to share the memory with an external process (e.g. when
>> +        using vhost-user). This backend mimics memfd, allocating memory that is
>> +        practically anonymous. This is useful when memfd is not available.
>
>This actually explains the purpose, unlike the doc comment in qom.json.
>Same for the existing memory backends; can't fault you for doing your
>new one the same way.  We ought to fix them all.  I'm not demanding you
>do it.
>
>The text could perhaps a bit clearer.  What does "practically anonymous"
>mean?  As far as I understand, memory-backend-shm is a more portable and
>less featureful version of memory-backend-memfd.  Say that?

Yeah, I see, I'll fix it with your suggestion!

>
>> +
>> +        Please refer to ``memory-backend-file`` for a description of the
>> +        options.
>> +
>> +        The ``share`` boolean option is on by default with shm. Setting it to
>> +        off will cause a failure during allocation because it is not supported
>> +        by this backend.
>> +
>
>The "will case a failure" part is documented only here, and not in
>qom.json.

I'll add it also in qom.json.

>
>Not this patch's fault: documentation for -object memory-backend-epc is
>missing.

Oh right, I don't know anything about it. Should we ping Sean 
Christopherson <sean.j.christopherson@intel.com> who added it?

Thanks,
Stefano

>
>>      ``-object iommufd,id=id[,fd=fd]``
>>          Creates an iommufd backend which allows control of DMA mapping
>>          through the ``/dev/iommu`` device.
>


