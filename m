Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF9606D81F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVQAPgW1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jerYm3xD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIH3-0005Ld-5x; Fri, 06 Nov 2026 06:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIGz-0005Je-6l
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIGt-0002eF-Fi
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793965094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vxedVB9T0G83yMeRDfIDyzcOuTFvsBZ3LW5A8WJJi1c=;
 b=hVQAPgW1ZGs3zVkgJbnC5j7xPQIqb6VK/ZDMFghM2szH/1TQGgEKvyH9lUzi/OQ/O0A3ga
 v3bRk+0MnucR+isP13/ZrittJ89itjOKpfvuH3kxg7Cx4W0Samsjx1dbFiqkNlTZ0Id6bu
 1eCed9+xZH9ppOztW0EasXcVkWY08co=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-SfGUlY7MPwmHd2bLP4hWTw-1; Fri, 06 Nov 2026 06:38:12 -0500
X-MC-Unique: SfGUlY7MPwmHd2bLP4hWTw-1
X-Mimecast-MFC-AGG-ID: SfGUlY7MPwmHd2bLP4hWTw_1793965092
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-49034831bb3so386914f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793965091; x=1794569891; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vxedVB9T0G83yMeRDfIDyzcOuTFvsBZ3LW5A8WJJi1c=;
 b=jerYm3xDF4ETMmeRXWCTRWRO+3uSUL/7WBNBI4mcemKQPodCyN14Jj5Vw1C50CvoZu
 gjYntoAknIXt6iQZBUUYD4vewRKpQNRvc77AgzW/ZkTCWKcM141DxUg80/00jjHMTRKw
 H0hn8csWi3pg2vE47QXvL7qmJ8ejHrMl0PcmPa4IKldIRulEstKD/p3qwUu3QuK0b9jR
 ki68W82DYwMy72u8GAGabfvWVJXVkt8FkmC1PZqabsVqOaFNW4iwothb53Mw5hzqVTak
 V5gOdrNJe0zo7K/hVBoFIJa1IFrEUMUhkdGWIaC1Avrip58/782Jr/CmO8YMOX4Bzwl0
 Wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793965091; x=1794569891;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxedVB9T0G83yMeRDfIDyzcOuTFvsBZ3LW5A8WJJi1c=;
 b=Jh5VWIsxY2uzxuYE+Ht9EJmbdZyXxioYQyXbxCOvjfdr2+44t9q6IRoGzlCEpRr0AW
 xrVWVzcBaeIlZ6akN4tLASPl0USLbJZecxiBELDhicYBxMjsoQ520Lr3V6vVdjK9pOTv
 thaorq+SW1aLH4SjEEsMBJusSn0p5pNgOvOOR9vQwOQ+BKkkOrxJ8v1L5LP6JUsDRDmh
 2TdGdCL3iTUytg813urJitaYbibyleVIF5srREC6L1S18M3j6Zy9X1RvOuuKQ+tRSKAQ
 zQLt6bYUVlEKV71Yp9r5Psii+q8c8BmMwB2h41FV89T8nJA29Ku5gIwj7utG1TjXG4uJ
 kx+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA4obB+ZNm9a9u2P9UUE1FbMNcjndNTbrhIHe9PvjiNRVy7KIOdgxA2CkXQIIlCbFnAx6Bee/l0hAm@nongnu.org
X-Gm-Message-State: APuU4Z+DP+JE/MTU7HCkhhdoySAU5aw7yKS4j4+Kdkk6jqjdKidjPX+T
 4mviOynlh/kCG8olrZnrJ42qhQ7GJrtComHUnhokdlQGRd4aj2gNPQIuNpZtbZRBVTeKnh+r2sJ
 l0OfRM5cMYxdGGHOSW+koERgxT1+fE6zeyAWWbe+uE3q+2nLbKNUhBEZ6
X-Gm-Gg: AYBFou3oXoY86j7SvLrTCpwjab5INFJdVFfIkuMkYMSD6BWpcgiLaWKc2fu6bjDII8r
 S1Aho7DWlvf+dh1Uh/e1qQMSUxCi8BHMytzG+4w6AlT5lwoRmemrJz0qKDwnJdBKLDa2rvrzZ4t
 5yUV9Z1Qeb8X17Bf2gdrHhOIMdd3y0I98btwH0rFS71ye+cHlHOIgppHcy0IHdIvK2EfUArFf8A
 36l/e6+55xkdS00q/ZucRdCGicwDOxiSH9tIQsgguNJbQKBqq/F89DyErSumb4fSKMlrlK52EB+
 +WTsmc4K6A5NWr0enC37qDK2f3hDWOkEs9gOclZIG5FOX5/Oqn6pNlZzdF8HODx8Ddvxp+kD5Jk
 UywKkz8Xqz+X4/vSdzTAM2y10Pbz2p7ZXC7WN83Nm+lmLmvP8Lk+h7fp8zC6LK6gqyfW/2ZAIRJ
 pAfPpmF3rqqA==
X-Received: by 2002:a05:600c:630c:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4b6db1c5edcmr35283165e9.3.1793965091634; 
 Fri, 06 Nov 2026 03:38:11 -0800 (PST)
X-Received: by 2002:a05:600c:630c:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4b6db1c5edcmr35282835e9.3.1793965091308; 
 Fri, 06 Nov 2026 03:38:11 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6df5eab6esm65073015e9.1.2026.11.06.03.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:38:10 -0800 (PST)
Message-ID: <b3820b45-7d26-4b4a-aec7-cfcd5aaf5d96@redhat.com>
Date: Fri, 6 Nov 2026 12:38:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] hw: mark all virtio CCW devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> These are all intended for use in a virtualization scenario and must
> provide a security boundary.
> 
> Acked-by: Eric Farman <farman@linux.ibm.com>
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
...
> diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
> index d8612f7cd13..08d3ee577b4 100644
> --- a/hw/s390x/virtio-ccw-9p.c
> +++ b/hw/s390x/virtio-ccw-9p.c
> @@ -64,6 +64,7 @@ static const TypeInfo virtio_ccw_9p_info = {
>       .instance_size = sizeof(V9fsCCWState),
>       .instance_init = virtio_ccw_9p_instance_init,
>       .class_init    = virtio_ccw_9p_class_init,
> +    .secure        = true,
>   };
I wonder whether we really want to include virtio-9p in the list of secure 
devices ... but in case we reconsider, I guess that can be refined later, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


