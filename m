Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F63C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcEV-0005BY-1b; Thu, 29 Feb 2024 03:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfcET-0005AC-JU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfcEQ-0001bL-IU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709197053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Ux73laRPaYp+oQJzJp5gWWt0dU89eqh8wwqXBLMX9Q=;
 b=JocasIuE6UYa0fcro5xgFAhRzL5QUioFBoVvEyGVDSsxJ6Nk5iqIHS550ICS2ykRifpZPo
 qHEZqkMTeOMvPXVOfsukcY2/knSD30RIA2HpyucXE/j6y35VRl1XSWfUJAjO1pbmDaa6NO
 mNM8tdryh+KSfh+nQSMhus31bCwjM2s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Wn50zW60PNuQMXJ43jeAlQ-1; Thu, 29 Feb 2024 03:57:31 -0500
X-MC-Unique: Wn50zW60PNuQMXJ43jeAlQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-690316dcdb3so6319486d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709197051; x=1709801851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ux73laRPaYp+oQJzJp5gWWt0dU89eqh8wwqXBLMX9Q=;
 b=kXiwOsRFNqKGvqWB6/D8xgYSgsIgReUvOMkcOutSAspqx0RbWUQ3+JyxOCP5EnbLsN
 TdsKYVdCYzj8fY0YwFD+UH087tk1C/9eJEa3p73S0+1zizmqxIodEOGYFeYENVRT6YEW
 HtkQc0VX7P49ml5hzoMtk3N/M2YD+Kwxy0QJ+1D8y/SRP9MFpe9Sa5eoczycEnv6qRDN
 QvEMpCU/YsdzrhpExRFL4hsVs8y5l9KjDPi1qv+Dq02XkMH+PeqoUNRckj1GsmiSVzx0
 /LWSFDM54lkTBmlSAF68Be3ucWBRSIvN+ARwCHZGA2vZDATrnKjhGy4jNIuU3+vIyeDv
 tPhQ==
X-Gm-Message-State: AOJu0YxuxJzwe6TSkfioGaBYKFCTXTE0kh3JFHMj4/DJIszpL2jgySPX
 DPUYZ8wwGnWHVgzWX8PtiKuR8IwlOE1S2mob3t6x6XEv1PdhDfhUD9MaPL4KXP0C4LeB4o4RtSB
 wIFXbIE45cozTzsCedLuW83CgV2tavSze0HvLlmZE49u+9o4POeKjZbcw7blI
X-Received: by 2002:a0c:dd02:0:b0:68f:2d61:e72c with SMTP id
 u2-20020a0cdd02000000b0068f2d61e72cmr1619913qvk.28.1709197051057; 
 Thu, 29 Feb 2024 00:57:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkljVkxjRLRWjSZq0dvg+KycLuKwcUt4upjl+qggUMsPKqhpM3RWa7ltz0gLpkVAbdYgtPhw==
X-Received: by 2002:a0c:dd02:0:b0:68f:2d61:e72c with SMTP id
 u2-20020a0cdd02000000b0068f2d61e72cmr1619900qvk.28.1709197050750; 
 Thu, 29 Feb 2024 00:57:30 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 t5-20020a0cde05000000b0068fc55bcf6asm508655qvk.119.2024.02.29.00.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 00:57:30 -0800 (PST)
Date: Thu, 29 Feb 2024 09:57:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>, 
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Message-ID: <hxd362pwyrtanyw6xtjxiegru7z57btnaynaqxm5lysgzsm4u4@af36bjkqvc7z>
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
 <874jdswyzy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <874jdswyzy.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 28, 2024 at 01:32:17PM +0100, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> Add a new `shm` bool option for `-object memory-backend-file`.
>>
>> When this option is set to true, the POSIX shm_open(3) is used instead
>> of open(2).
>>
>> So a file will not be created in the filesystem, but a "POSIX shared
>> memory object" will be instantiated. In Linux this turns into a file
>> in /dev/shm, but in other OSes this may not happen (for example in
>> macOS or FreeBSD nothing is shown in any filesystem).
>>
>> This new feature is useful when we need to share guest memory with
>> another process (e.g. vhost-user backend), but we don't have
>> memfd_create() or any special filesystems (e.g. /dev/shm) available
>> as in macOS.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> I am not sure this is the best way to support shm_open() in QEMU.
>>
>> Other solutions I had in mind were:
>>
>> - create a new memory-backend-shm
>
>How would that look like?  Would it involve duplicating code?

I was looking at it just now, and apart from some boilerplate code to 
create the object, the rest in the end is pretty specific and a lot of 
things in memory-backend-file wouldn't be supported by 
memory-backend-shm anyway, so I'll give it a try for v2 by adding it.

>
>> - extend memory-backend-memfd to use shm_open() on systems where memfd is
>> not available (problem: shm_open wants a name to assign to the object, but
>> we can do a workaround by using a random name and do the unlink right away)
>
>Hmm.  Too much magic?  I don't know...

Yeah, I agree.

>
>> Any preference/suggestion?
>
>[...]
>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 2a6e49365a..bfb01b909f 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -682,6 +682,9 @@
>   # @mem-path: the path to either a shared memory or huge page
>   #     filesystem mount
>
>Does this need adjustment?

Good point. For now I think I will drop this patch and add 
memory-backend-shm in v2, but if I go back I will fix it!

>
>[...]
>
>>  #       writable RAM instead of ROM, and want to set this property to 'off'.
>>  #       (default: auto, since 8.2)
>>  #
>> +# @shm: if true, shm_open(3) is used to create/open POSIX shared memory
>> +#       object; if false, an open(2) is used. (default: false) (since 9.0)
>> +#
>
>Please format like this for consistency:

Sure.

>
># @shm: if true, shm_open(3) is used to create/open POSIX shared memory
>#     object; if false, an open(2) is used (default: false) (since 9.0)

I just noticed that I followed the property just above (@rom). Should we 
fix that one?

Thanks,
Stefano


