Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A45C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIdQ-0003GY-I2; Wed, 28 Feb 2024 07:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rfIdP-0003GH-Lk
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rfIdN-0002vF-NL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709121720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aWRwAn9NIQRn5Xz9QITdQ9YGgC39gu54Twx4ltMtZFU=;
 b=Cs55XV2ROhQxnHdRIXEdy9hctMrex32Zw5mMOH0GESmHY0p/TDY/6zcMsjJHuGoCrskFt9
 04+p1kb8a/tRz2hFeHUrzZrVDp++udndzDaKxe5KiYge41g7V/CIf6KcyhoZTlG+jywEav
 mA55NUg2mmRhX4VBQmiJGYVyUETanBw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-D3q8d1FlMJSg0C8Df_LOHw-1; Wed, 28 Feb 2024 07:01:58 -0500
X-MC-Unique: D3q8d1FlMJSg0C8Df_LOHw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d782af89dso2133555f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121717; x=1709726517;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWRwAn9NIQRn5Xz9QITdQ9YGgC39gu54Twx4ltMtZFU=;
 b=cvUfoQpNpkrLmJXlAaIo+r2F1JPT0AwYkuMVNfhyIXBXDDHwJD/L3idOVIWT7HBywj
 ckux4x7gKqYJnJW8RczWPdR+D+QLkbAnMKFHKvSf5F671kCJrFzUN4b6KAZUQ6BfgoUa
 UfD9CVwdSrRAvDPHqApHs6fnT7L9lX3/3z4OzC6g2lGEh9uA+GnAkhaLyh2Lv4Azj6zm
 fjA8a09zq+vVVXEsti4xwED/m8PTS3TtS1AzuVo0B6V21kIa64ldx0oo78UUPhcD4zxF
 I6dt5rd0ViTYHXDNnrjUxJ+g9iriAaT4T9cQdm6+Vo7iTYekCEz6D+zxWGAg6vgvmZp8
 iK2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpMmx5GjqG26u+JO9aocxKzargCOY3+x6N0PRdjSneTT6K5qm+JCOf3ItrR/ny7rpIcx1aX7tC0cC0P3/tk87nXjzjAM0=
X-Gm-Message-State: AOJu0YzqGFgCtTN6up8Fid0ccn9KRIGY2OVdSXHnrGqap3JKmpkmQzlB
 Q89spH1ZJ8X3etT4MQZqkJ/7vuI/tZTDoJj/Gr+cRF3yoZImjIh6jZeBfDc2uRlHxV99V8ngXkA
 MuIEJa5XvSleA7ZoCizxS/QD/oko2ak4PCRltkMTMog6ZH+/5m3zf
X-Received: by 2002:a05:6000:229:b0:33d:2f2f:b135 with SMTP id
 l9-20020a056000022900b0033d2f2fb135mr7871074wrz.46.1709121717550; 
 Wed, 28 Feb 2024 04:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5hZiWqLnn7BnaBukrv23hA6d6SJCFYEFUr6XgF+pqUUal56M9waHofdAaZREQzZ/BJPHNQw==
X-Received: by 2002:a05:6000:229:b0:33d:2f2f:b135 with SMTP id
 l9-20020a056000022900b0033d2f2fb135mr7871037wrz.46.1709121717037; 
 Wed, 28 Feb 2024 04:01:57 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
 by smtp.gmail.com with ESMTPSA id
 ck12-20020a5d5e8c000000b0033d9f0dcb35sm14753990wrb.87.2024.02.28.04.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 04:01:56 -0800 (PST)
Message-ID: <1dbd722f-d8e2-43a2-a76d-7889e002f7d8@redhat.com>
Date: Wed, 28 Feb 2024 13:01:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 stefanha@redhat.com, gmaglione@redhat.com
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240228114759.44758-10-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28.02.24 12:47, Stefano Garzarella wrote:
> Add a new `shm` bool option for `-object memory-backend-file`.
> 
> When this option is set to true, the POSIX shm_open(3) is used instead
> of open(2).
> 
> So a file will not be created in the filesystem, but a "POSIX shared
> memory object" will be instantiated. In Linux this turns into a file
> in /dev/shm, but in other OSes this may not happen (for example in
> macOS or FreeBSD nothing is shown in any filesystem).
> 
> This new feature is useful when we need to share guest memory with
> another process (e.g. vhost-user backend), but we don't have
> memfd_create() or any special filesystems (e.g. /dev/shm) available
> as in macOS.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> I am not sure this is the best way to support shm_open() in QEMU.
> 
> Other solutions I had in mind were:
> 
> - create a new memory-backend-shm
> 
> - extend memory-backend-memfd to use shm_open() on systems where memfd is
> not available (problem: shm_open wants a name to assign to the object, but
> we can do a workaround by using a random name and do the unlink right away)
> 
> Any preference/suggestion?

Both sound like reasonable options, and IMHO better than hostmem-file 
with things that are not necessarily "real" files.

Regarding memory-backend-memfd, we similarly have to pass a name to 
memfd_create(), although for different purpose: "The  name  supplied in 
name is used as a filename and will be displayed as the target of the 
corresponding symbolic link in the directory /proc/self/fd/".

So we simply pass TYPE_MEMORY_BACKEND_MEMFD.

Likely, memory-backend-shm that directly maps to shm_open() and only 
provides properties reasonable for shm_open() is the cleanest approach. 
So that would currently be my preference :)

-- 
Cheers,

David / dhildenb


