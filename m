Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560BFC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVQB-0005X1-NU; Wed, 27 Mar 2024 11:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rpVQ9-0005Vr-JE
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rpVQ5-0001H6-Ul
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711554149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QgjXZQyN7YOMykU1pTN+FjDfZJO3X4pgLq2uGbabgdc=;
 b=ZYJKFUnjTtJZbJKdDpPFgHkki0nt6I3EDQEsLXy+92SfNS39rctuYS01Nwmp+2PwD7Iveo
 DMRWWRWQrZugb4CCBeTn5fdAJ3KTpQRc5OrFZpg++yrbsTDwlqB6yFApbs6dlup0WwfWHk
 Lehqiykh7fL9vO5ONjWP2JvGyntm+Yk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-2rKoupYENRGI7TxLORiLKw-1; Wed, 27 Mar 2024 11:42:27 -0400
X-MC-Unique: 2rKoupYENRGI7TxLORiLKw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4148b78d733so14742455e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 08:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711554146; x=1712158946;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgjXZQyN7YOMykU1pTN+FjDfZJO3X4pgLq2uGbabgdc=;
 b=BrFwixw5ZcPFqTZWNBBZvkZht0NdgLkNoFnuErBOZ/YREj3L8MOMmDq4udNMgWrmKg
 h3ZDUndsVQkliteC1OAXtQ49/PjXnrVi00AAc7lDGlDcYikZaM5n9aObkaOIEPS1rI9S
 cWp3r6+Qr+LOfluvlSmgYvfQ8vk1ils482Fz5UJtZ4Wk6/CyHw+5El8q0fKrB4+TVRlD
 If0huw1aYPiTuOP8YHBA1k7d3jujmfWF9A26H1aqrqau73gjH2Z+chlq99JLSY4ba0V+
 TSihDiTVIMVyXDROQLNOhyBK1bLtqs2CjzL4YBGrfDVCCapRLz9n/p+0LS5GbmA1keYQ
 xHDw==
X-Gm-Message-State: AOJu0Yy1l5UmBseEudVy9rsguahRLQOwBF3pLsFqFHL7Jj68AIMLzSyc
 bHnB6jfOROpXcQcMA8Y1mbxgD5dsTb/CmDiEL6cxJnlDSv09r5gAQxPWMEBOeHVenjnpPxRcT/r
 i3B0+fOJlRcTcrNWI420LNSSbVPDVXbq0B7ntbcd3iNgNfyGJq3oN
X-Received: by 2002:a05:600c:a42:b0:413:fea7:bd19 with SMTP id
 c2-20020a05600c0a4200b00413fea7bd19mr289010wmq.15.1711554145947; 
 Wed, 27 Mar 2024 08:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfxsoilvJS19F8NY1xHRmzqhPzpPIx/hTPy1oEk7NSM2X/6sfzY+WPc/fa7M/pyGtKlPc2w==
X-Received: by 2002:a05:600c:a42:b0:413:fea7:bd19 with SMTP id
 c2-20020a05600c0a4200b00413fea7bd19mr288968wmq.15.1711554145423; 
 Wed, 27 Mar 2024 08:42:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf?
 (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de.
 [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c311300b00414957185ebsm1725190wmo.27.2024.03.27.08.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 08:42:25 -0700 (PDT)
Message-ID: <24326aaa-4a80-4e85-85e7-4703da4a5d27@redhat.com>
Date: Wed, 27 Mar 2024 16:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v2 09/11] hostmem: add a new memory backend based
 on POSIX shm_open()
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 gmaglione@redhat.com, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-10-sgarzare@redhat.com>
 <462b8b02-5585-45b9-b725-27b8c84d0d1d@redhat.com>
 <ymzdrrltjqubqydcyu4sygcx3g3tfqqkwgziopfisjd2aanlrb@vmufyrqdmkqf>
 <9573d288-257e-4e1b-9721-c7799db01190@redhat.com>
 <dsjlixhniz2z7i7ku5u2wwxgqpwhgpntwiauujkj352psrfwtn@7krwrc5wkktq>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dsjlixhniz2z7i7ku5u2wwxgqpwhgpntwiauujkj352psrfwtn@7krwrc5wkktq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

>>>
>>> So I thought that for now we only support the "anonymous" mode, and if
>>> in the future we have a use case where the user wants to specify the
>>> name, we can add it later.
>>
>> Okay, so for now you really only want an anonymous fd that behaves like
>> a memfd, got it.
>>
>> Likely we should somehow fail if the "POSIX shared memory object"
>> already exists. Hmm.
> 
> `O_CREAT | O_EXCL` should provide just this behavior.
>   From shm_open(3) manpage:
> 
>       O_EXCL  If O_CREAT was also specified, and a shared memory object
>               with the given name already exists, return an error.  The
>               check for the existence of the object, and its creation if
>               it does not exist, are performed atomically.
> 

Cool!

>>
>>>
>>> That said, if you think it's already useful from the beginning, I can
>>> add the name as an optional parameter.
>>>
>>>>
>>>> I'm also not quite sure if "host_memory_backend_get_name()" should be
>>>> used for the purpose here.
>>>
>>> What problem do you see? As an alternative I thought of a static
>>> counter.
>>
>> If it's really just an "internal UUID", as we'll remove the file using
>> shm_unlink(), then the name in fact shouldn't matter and this would be
>> fine. Correct?
> 
> Right. It's a name that will only "appear" in the system for a very
> short time since we call shm_unlink() right after shm_open(). So I just
> need the unique name to prevent several QEMUs launched at the same time
> from colliding with the name.

Okay, essentially emulating tmpfile(), but for weird shmem_open() :)

> 
>>
>> So I assume if we ever want to have non-anonymous fds here, we'd pass
>> in a new property "name", and change the logic how we open/unlink.
>> Makes sense.
> 
> Exactly! I can clarify this in the commit description as well.
> 
> Thanks for the helpful comments!
> If there is anything I need to change for v3, please tell me ;-)

Besides some patch description extension, makes sense to me :)

-- 
Cheers,

David / dhildenb


