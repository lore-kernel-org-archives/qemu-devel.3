Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRp4-0003om-VR; Wed, 27 Mar 2024 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rpRp2-0003nv-PS
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rpRp0-0005Sl-EX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711540317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tZxIk883K52+BJOcJYXzrC/AO1hFfo143fxjN6Dhwl4=;
 b=bVptjcAT6Vh4X6vbcePgedOfjsfkJBKTHVRHm0xdY8GrzJgnOxqnA2St5cYZq/f5qXEveq
 YcxfKMCgn/o/MG2DZtqr0XnkyTGKRf2S7wjIr8F9Ti23Cb+mb77PWbMc96nlY+vlgUdd7D
 o4S9GAIzODcNnNo00DEh0sycXju22qI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-x1XYhA2hOZWsV_jXTv9pJg-1; Wed, 27 Mar 2024 07:51:55 -0400
X-MC-Unique: x1XYhA2hOZWsV_jXTv9pJg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5159dbd6be4so4402728e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 04:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540314; x=1712145114;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZxIk883K52+BJOcJYXzrC/AO1hFfo143fxjN6Dhwl4=;
 b=IPVTXvAn8APp3vnV/e44m2uITZXItK6kjEynLk3SUw2oqF17p+KcjahV4xhmTI7mIU
 IPIGq9NDtnVLfaMx4lZbxxIU2h//VMRiKhFMyvydHzz4HOcAFuMFvI96DPVmYn/7R2nv
 66bPGTuWdFsXOjqOwI7haISHFFoJaczCgesPmirt/HXl034mkBOk1SzH02HEFADZw180
 97RoomWYmsOrTOaCaNZ1t37DlwRWAtUn+4SNlZ1ScGAhxZEWJoAgncro1lzyFUNvd34k
 D+hby6mXqga8IegwE78lWdqfnE+wYF4E6WLdW9mn+InLOpCz5zcryDqbRxpY+sMLeMpa
 heiA==
X-Gm-Message-State: AOJu0YwF6+H5UGig6fX+xXPGsEpW4Q5oumdXkzJIiDt19bSrp8U0jzs5
 CbSw1EPHO8bcWnXn4az84cSFt7PWZXlmled50SuKFX0M4yCpsaCdJpVBVPxZnVHX+UuAfdQYWnd
 gNmyqrW9fpz7F7USW0FPr5pMSkhL1zc4Fw7dBlxPwvHQq1p4tMwgM
X-Received: by 2002:ac2:538a:0:b0:515:acdc:fcd5 with SMTP id
 g10-20020ac2538a000000b00515acdcfcd5mr1483019lfh.69.1711540314315; 
 Wed, 27 Mar 2024 04:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2lJcyt6gujUpVCPohFkLafMTexLoBL5qcU0tcgWWUkRw+CPnAEvntB0otZsagWc+dRcuXUw==
X-Received: by 2002:ac2:538a:0:b0:515:acdc:fcd5 with SMTP id
 g10-20020ac2538a000000b00515acdcfcd5mr1483008lfh.69.1711540313825; 
 Wed, 27 Mar 2024 04:51:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf?
 (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de.
 [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
 by smtp.gmail.com with ESMTPSA id
 bo15-20020a056000068f00b0033ec8f3ca9bsm11303753wrb.49.2024.03.27.04.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 04:51:53 -0700 (PDT)
Message-ID: <9573d288-257e-4e1b-9721-c7799db01190@redhat.com>
Date: Wed, 27 Mar 2024 12:51:51 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ymzdrrltjqubqydcyu4sygcx3g3tfqqkwgziopfisjd2aanlrb@vmufyrqdmkqf>
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

On 27.03.24 11:23, Stefano Garzarella wrote:
> On Tue, Mar 26, 2024 at 03:45:52PM +0100, David Hildenbrand wrote:
>>> +    mode = 0;
>>> +    oflag = O_RDWR | O_CREAT | O_EXCL;
>>> +    backend_name = host_memory_backend_get_name(backend);
>>> +
>>> +    /*
>>> +     * Some operating systems allow creating anonymous POSIX shared memory
>>> +     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
>>> +     * defined by POSIX, so let's create a unique name.
>>> +     *
>>> +     * From Linux's shm_open(3) man-page:
>>> +     *   For  portable  use,  a shared  memory  object should be identified
>>> +     *   by a name of the form /somename;"
>>> +     */
>>> +    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
>>> +                    backend_name);
>>
>> Hm, shouldn't we just let the user specify a name, and if no name was
>> specified, generate one ourselves?
> 
> I thought about it and initially did it that way, but then some problems
> came up so I tried to keep it as simple as possible for the user and for
> our use case (having an fd associated with memory and sharing it with
> other processes).
> 
> The problems I had were:
> 
> - what mode_t to use if the object does not exist and needs to be
>     created? >
> - exclude O_EXCL if the user passes the name since they may have already
>     created it?

I'd handle both like we handle files. But I understand now that you 
really just want to "simulate" memfd.

> 
> - call shm_unlink() only at object deallocation?

Right, we don't really do that for ordinary files, they keep existing. 
We only have the "discard-data" property to free up memory.

For memfd, it just happens "automatically". They cannot be looked up by 
name, and once the last user closes the fd, it gets destroyed.

> 
> So I thought that for now we only support the "anonymous" mode, and if
> in the future we have a use case where the user wants to specify the
> name, we can add it later.

Okay, so for now you really only want an anonymous fd that behaves like 
a memfd, got it.

Likely we should somehow fail if the "POSIX shared memory object" 
already exists. Hmm.

> 
> That said, if you think it's already useful from the beginning, I can
> add the name as an optional parameter.
> 
>>
>> I'm also not quite sure if "host_memory_backend_get_name()" should be
>> used for the purpose here.
> 
> What problem do you see? As an alternative I thought of a static
> counter.

If it's really just an "internal UUID", as we'll remove the file using 
shm_unlink(), then the name in fact shouldn't matter and this would be 
fine. Correct?


So I assume if we ever want to have non-anonymous fds here, we'd pass in 
a new property "name", and change the logic how we open/unlink. Makes sense.

-- 
Cheers,

David / dhildenb


