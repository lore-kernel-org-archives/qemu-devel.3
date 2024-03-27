Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E81C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVOD-0004AW-L8; Wed, 27 Mar 2024 11:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpVOC-0004AA-Gw
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpVOA-00013k-VY
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711554029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jd2kzX9bY5VToVoZrifZ4A7pscMiI3zgmIk6ytk44MA=;
 b=a+mnlO2N7po6w5jGiR9q+F0f5d3flL+uhgkw8X6kvG2rFFeCFN72ApzCYaNwQgMSr/XUK+
 bFUNCvZe8Cftt/GOXSeCVGPJQLfqK0iM17oNVFIKdjItX6AYH5MU4Fb/Nx44xVAgagMeo7
 1mrlb565E36kTTGOkdqH3paEqwJ6j70=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Tu6DPtP-P6me2sOmLd3Mkw-1; Wed, 27 Mar 2024 11:40:27 -0400
X-MC-Unique: Tu6DPtP-P6me2sOmLd3Mkw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56c3dc8d331so455448a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 08:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711554026; x=1712158826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd2kzX9bY5VToVoZrifZ4A7pscMiI3zgmIk6ytk44MA=;
 b=OlhVr+1BE1/u696+QPgOQG3tGDg81WhsPkxiNo3hzPPJeAwspSL4MqPBzLymMr8P8H
 5k+tlFpkczRnEO2V2B6HfbF+ErhrHTwI15SQsUhTD0nCA1uUlvr9gQAAzy9V/f9vBt1y
 xK+xXbM44oBFV4TgzRElDa8v+PmCljYAKk9p8svcjt+HDB5943JOx9QcItOY7ngF1Gfu
 juuLAucVSghsYjMuO+tz41pcFi8+RSuSPz5zjn0a9OdwF3dwOn65cXsLqmRjrI2HeLJJ
 mc/pjoxm0iPnTYN8k06T+48FIQn1lZIrBrYfQDqIw3iN58tQDRQRDbFz1GJrnet9mGpG
 rbmQ==
X-Gm-Message-State: AOJu0YxB2AC6AOOiO3pT4IA3nnhY5HZW0+hL9+4JpFogp64+YLJgFuO7
 dSECppRUi7sos1qE96dL1jscJNPLzH0VkvqFY8P3CX/Vv6fAv6t263mk8gPdR0ZEgjU8UYwEpMO
 /9zxLiBEtvKRd/lLQDZ72wf54uBWfyQz7dX06uqa8gpBxqKjhHnBe
X-Received: by 2002:a50:d71a:0:b0:565:59a:a103 with SMTP id
 t26-20020a50d71a000000b00565059aa103mr120234edi.33.1711554026691; 
 Wed, 27 Mar 2024 08:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGphzzZ//KuVgjdI90S4/edNsUSOnXhE/xdsqDEoljPeE57nFAeMhVuszu4PlHVcna/EbiY4A==
X-Received: by 2002:a50:d71a:0:b0:565:59a:a103 with SMTP id
 t26-20020a50d71a000000b00565059aa103mr120213edi.33.1711554026306; 
 Wed, 27 Mar 2024 08:40:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 i35-20020a0564020f2300b0056c4a35dbeesm155111eda.49.2024.03.27.08.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 08:40:25 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:40:20 +0100
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
Message-ID: <dsjlixhniz2z7i7ku5u2wwxgqpwhgpntwiauujkj352psrfwtn@7krwrc5wkktq>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-10-sgarzare@redhat.com>
 <462b8b02-5585-45b9-b725-27b8c84d0d1d@redhat.com>
 <ymzdrrltjqubqydcyu4sygcx3g3tfqqkwgziopfisjd2aanlrb@vmufyrqdmkqf>
 <9573d288-257e-4e1b-9721-c7799db01190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9573d288-257e-4e1b-9721-c7799db01190@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Mar 27, 2024 at 12:51:51PM +0100, David Hildenbrand wrote:
>On 27.03.24 11:23, Stefano Garzarella wrote:
>>On Tue, Mar 26, 2024 at 03:45:52PM +0100, David Hildenbrand wrote:
>>>>+    mode = 0;
>>>>+    oflag = O_RDWR | O_CREAT | O_EXCL;
>>>>+    backend_name = host_memory_backend_get_name(backend);
>>>>+
>>>>+    /*
>>>>+     * Some operating systems allow creating anonymous POSIX shared memory
>>>>+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
>>>>+     * defined by POSIX, so let's create a unique name.
>>>>+     *
>>>>+     * From Linux's shm_open(3) man-page:
>>>>+     *   For  portable  use,  a shared  memory  object should be identified
>>>>+     *   by a name of the form /somename;"
>>>>+     */
>>>>+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
>>>>+                    backend_name);
>>>
>>>Hm, shouldn't we just let the user specify a name, and if no name was
>>>specified, generate one ourselves?
>>
>>I thought about it and initially did it that way, but then some problems
>>came up so I tried to keep it as simple as possible for the user and for
>>our use case (having an fd associated with memory and sharing it with
>>other processes).
>>
>>The problems I had were:
>>
>>- what mode_t to use if the object does not exist and needs to be
>>    created? >
>>- exclude O_EXCL if the user passes the name since they may have already
>>    created it?
>
>I'd handle both like we handle files. But I understand now that you 
>really just want to "simulate" memfd.

Right, maybe I should write that in the commit message and 
documentation.

>
>>
>>- call shm_unlink() only at object deallocation?
>
>Right, we don't really do that for ordinary files, they keep existing. 
>We only have the "discard-data" property to free up memory.
>
>For memfd, it just happens "automatically". They cannot be looked up 
>by name, and once the last user closes the fd, it gets destroyed.

Yep, I see.

>
>>
>>So I thought that for now we only support the "anonymous" mode, and if
>>in the future we have a use case where the user wants to specify the
>>name, we can add it later.
>
>Okay, so for now you really only want an anonymous fd that behaves like 
>a memfd, got it.
>
>Likely we should somehow fail if the "POSIX shared memory object" 
>already exists. Hmm.

`O_CREAT | O_EXCL` should provide just this behavior.
 From shm_open(3) manpage:

     O_EXCL  If O_CREAT was also specified, and a shared memory object
             with the given name already exists, return an error.  The
             check for the existence of the object, and its creation if
             it does not exist, are performed atomically.

>
>>
>>That said, if you think it's already useful from the beginning, I can
>>add the name as an optional parameter.
>>
>>>
>>>I'm also not quite sure if "host_memory_backend_get_name()" should be
>>>used for the purpose here.
>>
>>What problem do you see? As an alternative I thought of a static
>>counter.
>
>If it's really just an "internal UUID", as we'll remove the file using 
>shm_unlink(), then the name in fact shouldn't matter and this would be 
>fine. Correct?

Right. It's a name that will only "appear" in the system for a very 
short time since we call shm_unlink() right after shm_open(). So I just 
need the unique name to prevent several QEMUs launched at the same time 
from colliding with the name.

>
>So I assume if we ever want to have non-anonymous fds here, we'd pass 
>in a new property "name", and change the logic how we open/unlink.  
>Makes sense.

Exactly! I can clarify this in the commit description as well.

Thanks for the helpful comments!
If there is anything I need to change for v3, please tell me ;-)

Stefano


