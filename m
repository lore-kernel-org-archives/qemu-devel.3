Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E75EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC02p-0004nv-Lc; Tue, 28 May 2024 12:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sC02n-0004mv-Ii
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sC02m-0006JN-2r
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716915082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRXMCcs9PjelsqZxVXsU6AqyPIUdE+LbXgDgo2OujXQ=;
 b=Ur2iRt7EbHkz5KxZVb5rVfox4wBwVrYt3zkw3nTnqfg78QpxtT2D90eBxBdwLrh/IesvDg
 jGjXoX9uisx02/J1vmXXS6Z0dpIYiN8DL4TRvzE6NrWdfA9lZFHbVyGsB8+zNmQUGJYdQt
 7U8dh5tfKph083LA4Tor2x+3DSogh6I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-g-xIruSzP02SEkDENLUM3A-1; Tue, 28 May 2024 12:51:21 -0400
X-MC-Unique: g-xIruSzP02SEkDENLUM3A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5295b9d6218so1205519e87.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915079; x=1717519879;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BRXMCcs9PjelsqZxVXsU6AqyPIUdE+LbXgDgo2OujXQ=;
 b=BjtICz0bJ+Af+A1Dpa4fO5eFZaxUKJmt/X0xSYKiTCvfGmtnHD32wJk4JbKJx7B1hw
 +y5j7skF/CeZI0OhfN8lSLU0+vR5lIGVm0/SPicVR6T617b9hTUeY/mZVLZeB3V7X8K4
 Ilqg3avYpdP/pbhfvl94Azzvoq2Pg7n37GuOmJNXRsAef42xKBDZAk+4SjGRSbzxUde+
 1lCpXR4VFBnz5wVtQF/sjKH8pZw28QePGqpJNLd6uoeGkEUM1OdcFBE0ux1MHa0G7BxN
 NyptT+PkW4rkGiw0ZwlNOCbEgJc444AXJlhjLMP9u9OhhqGnCP7ntwmyH1ZdMnN0Nw2Q
 CLww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqS0kaCo7fdyk45wGp1J1sIo0MszzSsqO4clVHYw8EprV1fo2FWAhdZGLYXXJmdAY7dQi51HEL8JgMukKPS7tKwN9d04=
X-Gm-Message-State: AOJu0Yx7ZG7Ny4mum8kkW9TzW/yoi4NW0tnjcruU5mmnzVhwa/DAdBkh
 JLryARScntHKSVNcNo9G45D/W+BWGmBQvpqVyR91zp763no8tcnSW1JkdIZKb5HYByuAGE/zEIn
 BgQIAXLStDw+oqhxT81keu7o4WpxvQBypvNK261qwy6Ku8GAsEXCociHyYcSf
X-Received: by 2002:ac2:5a5c:0:b0:524:6385:6883 with SMTP id
 2adb3069b0e04-529650a43c0mr7429067e87.37.1716915078715; 
 Tue, 28 May 2024 09:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpFLZLO1M2KOF1NDSQmNHMWFrS4ODZFY9dbO7VzGO/hL2etnKYHT7BC7Hh2BjSg7CcVEJIoQ==
X-Received: by 2002:ac2:5a5c:0:b0:524:6385:6883 with SMTP id
 2adb3069b0e04-529650a43c0mr7429007e87.37.1716915076166; 
 Tue, 28 May 2024 09:51:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e?
 (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de.
 [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d1a0517asm3362785a12.45.2024.05.28.09.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:51:15 -0700 (PDT)
Message-ID: <5e9a1ca9-b9b8-44f0-9e0c-b56ae0b2c0fc@redhat.com>
Date: Tue, 28 May 2024 18:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] osdep: Make qemu_madvise() to set errno in all cases
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1716912651.git.mprivozn@redhat.com>
 <4d8a74a512bf55f39c5d1be115b1c52b6a632e09.1716912651.git.mprivozn@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <4d8a74a512bf55f39c5d1be115b1c52b6a632e09.1716912651.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Am 28.05.24 um 18:15 schrieb Michal Privoznik:
> The unspoken premise of qemu_madvise() is that errno is set on
> error. And it is mostly the case except for posix_madvise() which
> is documented to return either zero (on success) or a positive
> error number. This means, we must set errno ourselves. And while
> at it, make the function return a negative value on error, just
> like other error paths do.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   util/osdep.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index e996c4744a..e42f4e8121 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -57,7 +57,12 @@ int qemu_madvise(void *addr, size_t len, int advice)
>   #if defined(CONFIG_MADVISE)
>       return madvise(addr, len, advice);
>   #elif defined(CONFIG_POSIX_MADVISE)
> -    return posix_madvise(addr, len, advice);
> +    int rc = posix_madvise(addr, len, advice);
> +    if (rc) {
> +        errno = rc;
> +        return -1;
> +    }
> +    return 0;
>   #else
>       errno = EINVAL;
>       return -1;

Interesting, seems to be correct

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


