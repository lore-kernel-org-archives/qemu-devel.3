Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD98DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKuS-00020g-Fr; Wed, 29 May 2024 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sCKuN-0001zp-QM
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sCKuH-0007g9-Qm
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716995280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YzHZ7DypgLAxSTB6Emhk7U8e66B70o9dTjWLa7M2934=;
 b=DTj0Qe00XfMmDEETvcpmcLgt8IkmN9mviqR1WzPJkvbKfzOMASgZfRpxtY7S3vWURWIzID
 CkF4+Wsp5lWyVKpjaqOUKlLaUKSORl9XGw8CzuRF2WytCChXrIPp0rq7FT3vN06DVlsaIo
 UozrT+4azWj3ZjByucLySNuCS5jU0aI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-wgMLcH8XNn6y3uoS2eSKyQ-1; Wed, 29 May 2024 11:07:58 -0400
X-MC-Unique: wgMLcH8XNn6y3uoS2eSKyQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e95abb5ae9so17250801fa.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995277; x=1717600077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzHZ7DypgLAxSTB6Emhk7U8e66B70o9dTjWLa7M2934=;
 b=Rxu+NHCg5Lql1hRWxQMmMbrN6EpUsE9AikLFD0559gBRmLBXag8GwOOu7BwOUFKNG6
 trTcTNK8Y4ZV/bh/N+RMsZCtwnOioNzzo2fG3ZSzGl3iphZV+J2b9iXTKbJxhQhsSUpn
 kVoDJYik91DKWxtggM7SJUx4pKtUZbcFxYiTqbsMZH9aXK4CP5pSjfBPL4P+4nq8+1j0
 qCLkCe4rkpjluyOQBwmvtbNbDOlV3dTWQjHzUcaFyqLFITXm033Z3mq/t1C5P/hDelol
 KdpgCf7zq337cEpdxsCrbrqAFCdIDgsp27cObF6uRA/F3+ON1RKp2UPa8CrhDxEQn5tn
 xInQ==
X-Gm-Message-State: AOJu0YyGuw4fCUx6G6fFS8n/YlLk8B6dHDFeQ/PO3+AWUnlTulSfMzh1
 u6NtkU9NMq2KTVwuMsnWsPWviWGkeXdkqwl4HiNkLNoX86kZefGMUPs3cM7Q88zrXdgPowiJvIV
 vyaDMgXTkyEa+1/+VufXnMwh3z0fGE45I6zWS3U1Q4SeQvpWuYWdL
X-Received: by 2002:a05:651c:1992:b0:2de:7046:b8f8 with SMTP id
 38308e7fff4ca-2e95b096d5fmr123625871fa.5.1716995276783; 
 Wed, 29 May 2024 08:07:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvIYyCdLdBGq0WzLoxdYWpzJ8aAUguYHgThD0nNlX4+ZBoAxj+7QC8tkULlnrSS9CgQsNr2Q==
X-Received: by 2002:a05:651c:1992:b0:2de:7046:b8f8 with SMTP id
 38308e7fff4ca-2e95b096d5fmr123625481fa.5.1716995276185; 
 Wed, 29 May 2024 08:07:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08abd8sm15033929f8f.32.2024.05.29.08.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:07:55 -0700 (PDT)
Date: Wed, 29 May 2024 17:07:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, gmaglione@redhat.com, 
 Raphael Norwitz <raphael@enfabrica.net>, Laurent Vivier <lvivier@redhat.com>, 
 Brad Smith <brad@comstyle.com>, slp@redhat.com, stefanha@redhat.com, 
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 10/12] hostmem: add a new memory backend based on
 POSIX shm_open()
Message-ID: <xxu5zcocmr6jkwot2lq4atvbozjjykqnvlb5m3fofadzffmxmh@6n43s2i5cjge>
References: <20240528103543.145412-1-sgarzare@redhat.com>
 <20240528103823.146231-1-sgarzare@redhat.com>
 <87sey0k6z7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87sey0k6z7.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 29, 2024 at 04:50:20PM GMT, Markus Armbruster wrote:
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
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v5
>> - fixed documentation in qapi/qom.json and qemu-options.hx [Markus]
>> v4
>> - fail if we find "share=off" in shm_backend_memory_alloc() [David]
>> v3
>> - enriched commit message and documentation to highlight that we
>>   want to mimic memfd (David)
>> ---
>>  docs/system/devices/vhost-user.rst |   5 +-
>>  qapi/qom.json                      |  19 +++++
>>  backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
>>  backends/meson.build               |   1 +
>>  qemu-options.hx                    |  16 ++++
>>  5 files changed, 162 insertions(+), 2 deletions(-)
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
>> index 38dde6d785..d40592d863 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -721,6 +721,21 @@
>>              '*hugetlbsize': 'size',
>>              '*seal': 'bool' } }
>>
>> +##
>> +# @MemoryBackendShmProperties:
>> +#
>> +# Properties for memory-backend-shm objects.
>> +#
>> +# The @share boolean option is true by default with shm. Setting it to false
>> +# will cause a failure during allocation because it is not supported by this
>> +# backend.
>
>docs/devel/qapi-code-gen.rst:
>
>    For legibility, wrap text paragraphs so every line is at most 70
>    characters long.
>
>    Separate sentences with two spaces.
>
>Result:
>
>   # Properties for memory-backend-shm objects.
>   #
>   # The @share boolean option is true by default with shm.  Setting it
>   # to false will cause a failure during allocation because it is not
>   # supported by this backend.

Ops, sorry, I'll fix!

>
>However, this contradicts the doc comment for @share:
>
>   # @share: if false, the memory is private to QEMU; if true, it is
>   #     shared (default: false)
>
>Your intention is to override that text.  But that's less than clear.
>Moreover, the documentation of @share is pretty far from this override.
>John Snow is working on patches that'll pull it closer.
>
>Hmm, MemoryBackendMemfdProperties has the same override.
>
>I think we should change the doc comment for @share to something like
>
>   # @share: if false, the memory is private to QEMU; if true, it is
>   #     shared (default depends on the backend type)
>
>and then document the actual default with each backend type.

Yes, I had already seen your comment to an earlier version and sent 
another separate patch:
https://patchew.org/QEMU/20240523133302.103858-1-sgarzare@redhat.com/

Is that okay?

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

I think my response to your review at v4 fell through a crack :-)
https://patchew.org/QEMU/20240508074457.12367-1-sgarzare@redhat.com/20240508074457.12367-11-sgarzare@redhat.com/#z3lbtmkn6zlwdhdea7owav3mblttxr3asrmlilwxmkla67tdby@732gn3uuupoq

I'll bring back my doubts here:

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
>> @@ -985,6 +1000,8 @@
>>      { 'name': 'memory-backend-memfd',
>>        'if': 'CONFIG_LINUX' },
>>      'memory-backend-ram',
>> +    { 'name': 'memory-backend-shm',
>> +      'if': 'CONFIG_POSIX' },
>>      'pef-guest',
>>      { 'name': 'pr-manager-helper',
>>        'if': 'CONFIG_LINUX' },
>> @@ -1056,6 +1073,8 @@
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
>> index 8ca7f34ef0..ad6521ef5e 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -5240,6 +5240,22 @@ SRST
>>
>>          The ``share`` boolean option is on by default with memfd.
>>
>> +    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>> +        Creates a POSIX shared memory backend object, which allows
>> +        QEMU to share the memory with an external process (e.g. when
>> +        using vhost-user).
>> +
>> +        ``memory-backend-shm`` is a more portable and less featureful version
>> +        of ``memory-backend-memfd``. It can then be used in any POSIX system,
>> +        especially when memfd is not supported.
>
>This actually explains the purpose, unlike the doc comment in qom.json.
>Same for the existing memory backends; can't fault you for doing your
>new one the same way.  We ought to fix them all.  I'm not demanding you
>do it.

Okay, I'll try to fix all of them separately.

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
>Not this patch's fault: documentation for -object memory-backend-epc is
>missing.

Good point!
I don't know epc, @David do you have any thoughts to write here?

Thanks,
Stefano

>
>>      ``-object iommufd,id=id[,fd=fd]``
>>          Creates an iommufd backend which allows control of DMA mapping
>>          through the ``/dev/iommu`` device.
>


