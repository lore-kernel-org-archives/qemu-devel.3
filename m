Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B5CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUDy-0002Ql-4D; Tue, 04 Jun 2024 09:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEUDw-0002Q8-Cl
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEUDt-0004jl-Tg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717507748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idwwIERg7Mw/f6gGngRRl1zIOtqAuOsWXrl53httcpo=;
 b=SNz5M8aOW6IGPCfEi5/E8jeQFWCDSm9KGML9SKW6owQ7SlZiOrmPC60l/WcbeVe0pSxp7Z
 r8Uy/f0kwb8GZQyZwdFGi5tcgY2jE78Wgf3GNBY9/c5duWeVtnBLvvKp0tBlDaN6BCaHZp
 I2cGrQNXiXQ9KQXOlM/6wS/oTcUp/9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-E_3WLa6PMQ2x21ZMU1Hz_g-1; Tue, 04 Jun 2024 09:29:07 -0400
X-MC-Unique: E_3WLa6PMQ2x21ZMU1Hz_g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42108822a8eso30797615e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507746; x=1718112546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idwwIERg7Mw/f6gGngRRl1zIOtqAuOsWXrl53httcpo=;
 b=jjZkH7WXkibOJDIV5jj+DZnV6qgEaa9iz2PK3DGHubCu9I5tuWxFeoLQ3XHEsMiBl6
 iSqW4ZTdZ6r5KoSQ49BChlxkB/QWoJcY2vHEse1VqI8lydGf8hsDixb/piAncijTxaJF
 nR9wndcj9+dY1qwaQZdkORuxzUUSCciPL9cxZ84NiSCUBC3q/hezpVWChPgISB6QuqFp
 ShWNURAlD064cneIaeVy0GGo9RU76XPtGia0Uy9gCDzQq4V/kv6mFmTBzR6H/UPrUVwZ
 t/zCikKZP9+vMqYSwi2eBQ8v3UR9j2q5mcvAg1NapZK++nTidHn0l2lPy+WVMsrFCCxv
 MOHw==
X-Gm-Message-State: AOJu0YyEEvOteDnPmb6GgMubDwD95kbmVKn0q+oiBX78TBMtPNFJ2et9
 5HBfGriotsaOPhy+RwZP15CFyXgXbP0ywB1FapS6+zhaJmi6GKaBAp8YhJtyzZmVWbvCqCzxdSK
 aFMR/kXVDka1Lbqkup/sGmtISmtF7BIhpB5iTCZYbLJc11jhCgM9N
X-Received: by 2002:a05:600c:5122:b0:421:4b0a:5006 with SMTP id
 5b1f17b1804b1-4214b0a5ffemr18434915e9.7.1717507746112; 
 Tue, 04 Jun 2024 06:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlK/ZSMes2jI0vqTr4H97cPOcKFQw9BheZAT3+VIfLkKFAPHQ8FzjTPKiVBcWbvs82j1nfcw==
X-Received: by 2002:a05:600c:5122:b0:421:4b0a:5006 with SMTP id
 5b1f17b1804b1-4214b0a5ffemr18434605e9.7.1717507745679; 
 Tue, 04 Jun 2024 06:29:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-171.retail.telecomitalia.it.
 [82.53.134.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214fdf4953sm18509675e9.25.2024.06.04.06.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 06:29:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:29:00 +0200
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
Message-ID: <ce2y4sfbkestr7s43p7ranrcfe5a5zlptl3miqerhv4ll3tymx@gsi57jktsngu>
References: <20240528103543.145412-1-sgarzare@redhat.com>
 <20240528103823.146231-1-sgarzare@redhat.com>
 <87sey0k6z7.fsf@pond.sub.org>
 <xxu5zcocmr6jkwot2lq4atvbozjjykqnvlb5m3fofadzffmxmh@6n43s2i5cjge>
 <87zfs2z7jo.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zfs2z7jo.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 03, 2024 at 11:42:35AM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> On Wed, May 29, 2024 at 04:50:20PM GMT, Markus Armbruster wrote:
>>>Stefano Garzarella <sgarzare@redhat.com> writes:
>>>
>>>> shm_open() creates and opens a new POSIX shared memory object.
>>>> A POSIX shared memory object allows creating memory backend with an
>>>> associated file descriptor that can be shared with external processes
>>>> (e.g. vhost-user).
>>>>
>>>> The new `memory-backend-shm` can be used as an alternative when
>>>> `memory-backend-memfd` is not available (Linux only), since shm_open()
>>>> should be provided by any POSIX-compliant operating system.
>>>>
>>>> This backend mimics memfd, allocating memory that is practically
>>>> anonymous. In theory shm_open() requires a name, but this is allocated
>>>> for a short time interval and shm_unlink() is called right after
>>>> shm_open(). After that, only fd is shared with external processes
>>>> (e.g., vhost-user) as if it were associated with anonymous memory.
>>>>
>>>> In the future we may also allow the user to specify the name to be
>>>> passed to shm_open(), but for now we keep the backend simple, mimicking
>>>> anonymous memory such as memfd.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> ---
>>>> v5
>>>> - fixed documentation in qapi/qom.json and qemu-options.hx [Markus]
>>>> v4
>>>> - fail if we find "share=off" in shm_backend_memory_alloc() [David]
>>>> v3
>>>> - enriched commit message and documentation to highlight that we
>>>>   want to mimic memfd (David)
>>>> ---
>>>>  docs/system/devices/vhost-user.rst |   5 +-
>>>>  qapi/qom.json                      |  19 +++++
>>>>  backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
>>>>  backends/meson.build               |   1 +
>>>>  qemu-options.hx                    |  16 ++++
>>>>  5 files changed, 162 insertions(+), 2 deletions(-)
>>>>  create mode 100644 backends/hostmem-shm.c
>>>>
>>>> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>>>> index 9b2da106ce..35259d8ec7 100644
>>>> --- a/docs/system/devices/vhost-user.rst
>>>> +++ b/docs/system/devices/vhost-user.rst
>>>> @@ -98,8 +98,9 @@ Shared memory object
>>>>
>>>>  In order for the daemon to access the VirtIO queues to process the
>>>>  requests it needs access to the guest's address space. This is
>>>> -achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
>>>> -objects. A reference to a file-descriptor which can access this object
>>>> +achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
>>>> +``memory-backend-shm`` objects.
>>>> +A reference to a file-descriptor which can access this object
>>>>  will be passed via the socket as part of the protocol negotiation.
>>>>
>>>>  Currently the shared memory object needs to match the size of the main
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 38dde6d785..d40592d863 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -721,6 +721,21 @@
>>>>              '*hugetlbsize': 'size',
>>>>              '*seal': 'bool' } }
>>>>
>>>> +##
>>>> +# @MemoryBackendShmProperties:
>>>> +#
>>>> +# Properties for memory-backend-shm objects.
>>>> +#
>>>> +# The @share boolean option is true by default with shm. Setting it to false
>>>> +# will cause a failure during allocation because it is not supported by this
>>>> +# backend.
>>>
>>>docs/devel/qapi-code-gen.rst:
>>>
>>>    For legibility, wrap text paragraphs so every line is at most 70
>>>    characters long.
>>>
>>>    Separate sentences with two spaces.
>>>
>>>Result:
>>>
>>>   # Properties for memory-backend-shm objects.
>>>   #
>>>   # The @share boolean option is true by default with shm.  Setting it
>>>   # to false will cause a failure during allocation because it is not
>>>   # supported by this backend.
>>
>> Ops, sorry, I'll fix!
>>
>>>
>>>However, this contradicts the doc comment for @share:
>>>
>>>   # @share: if false, the memory is private to QEMU; if true, it is
>>>   #     shared (default: false)
>>>
>>>Your intention is to override that text.  But that's less than clear.
>>>Moreover, the documentation of @share is pretty far from this override.
>>>John Snow is working on patches that'll pull it closer.
>>>
>>>Hmm, MemoryBackendMemfdProperties has the same override.
>>>
>>>I think we should change the doc comment for @share to something like
>>>
>>>   # @share: if false, the memory is private to QEMU; if true, it is
>>>   #     shared (default depends on the backend type)
>>>
>>>and then document the actual default with each backend type.
>>
>> Yes, I had already seen your comment to an earlier version and sent another separate patch:
>> https://patchew.org/QEMU/20240523133302.103858-1-sgarzare@redhat.com/
>>
>> Is that okay?
>
>Looks like I'm going through my post-vacation review backlog in
>suboptimal order...
>
>Replied there!

Thanks!

>
>>>> +#
>>>> +# Since: 9.1
>>>> +##
>>>> +{ 'struct': 'MemoryBackendShmProperties',
>>>> +  'base': 'MemoryBackendProperties',
>>>> +  'data': { } }
>>>
>>>Let's add 'if': 'CONFIG_POSIX' here.
>>>
>>
>> I think my response to your review at v4 fell through a crack :-)
>> https://patchew.org/QEMU/20240508074457.12367-1-sgarzare@redhat.com/20240508074457.12367-11-sgarzare@redhat.com/#z3lbtmkn6zlwdhdea7owav3mblttxr3asrmlilwxmkla67tdby@732gn3uuupoq
>
>Dang, it did %-}
>
>> I'll bring back my doubts here:
>>
>>   Do you mean something like this:
>>
>>   { 'struct': 'MemoryBackendShmProperties',
>>      'if': 'CONFIG_POSIX',
>>      'base': 'MemoryBackendProperties',
>>      'data': { } }
>>
>>   I didn't because for MemoryBackendMemfdProperties and
>>   MemoryBackendEpcProperties we have 'if': 'CONFIG_POSIX' only later in
>>   the ObjectOptions union, so I did the same.
>>
>>   Should we fix them as well?
>
>Yes, please.

Okay, I'll send a separated patch for them and fix 
MemoryBackendShmProperties here in v7.

I saw some examples to follow in qapi/char.json.

>
>The QAPI schema's primary purpose is to define the QMP interface.  The
>tooling lets you define QAPI types that aren't actually used in the QMP
>interface.  We use this intentionally, e.g. to generate types & visitors
>for complex QOM properties.  Accidental use is also possible, say when
>we define a type unconditionally, but use it only conditionally.  We
>then end up generating dead code.  No big deal, but let's avoid it
>whenever practical.

Got it, thanks for the info and the review!

Stefano


