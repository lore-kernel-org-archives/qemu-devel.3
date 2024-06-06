Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8D9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7l2-0003oW-C5; Thu, 06 Jun 2024 03:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7kz-0003oE-Jf
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7kv-0001AJ-O6
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717659713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bS525T6xHEdOfq0j6atp44/4NsLHCgBQiX90Z+vbFes=;
 b=MtSUckHvMS5umkHD7POIxoatPZW1QANkT9XH+gTKUgPgfxdv/4KgRwmR3J+7lZAaFhmZRz
 98ls6uSONzVkfmtrPenNE7HRsgfhIxgO+AhIzEJpdIQi3u5bu+qYPcegzufV9TvIMy7eVp
 fy1s/0KGqEBO4aOv1sH8+ZXkHomZHvI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-qnWLZXr1Mdax6UIAbt8Wpw-1; Thu, 06 Jun 2024 03:41:51 -0400
X-MC-Unique: qnWLZXr1Mdax6UIAbt8Wpw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68eeececdcso23067766b.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 00:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717659710; x=1718264510;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bS525T6xHEdOfq0j6atp44/4NsLHCgBQiX90Z+vbFes=;
 b=HEzgyEXChNheoBXZujSlZ2+SwgOlw3NsS/58hHjsewKlpB9xDLWGMXO+NOTjmYkaCN
 9THGrWnzlhZfCnMmNm8QgqP28eOcayfo75kzP5V6AlwAJFU2D9gshnEdl/ngQOY1262k
 G2NHHy9eYYZZ2iUImTcmzjYL/oyN04fqlaWmPzHfWDeAukMz+fofgPG9WIuGXt0LWrBK
 YYO0eg+84HUp0lNtK7KFk+iOYnG9e+2sgNZl4r7iGIyafT0Xi32PRP3AAIApILDR67pH
 VGosAWKuOyUpQVVtpjxe19H5GIWeNn5aQfZaupczuDUT6B9/zC553AenykXcfWx3JNJ7
 Pyfg==
X-Gm-Message-State: AOJu0Yydtdq0k7UhZWsAD4p3JwgAALYUuE4eqgtUqf3Lf6jYpqPai3yN
 OvKoDPhBzT8+NiCMrPKTgbQAtlsWu+/+GzVq8TRHsG7SQ7lJKI0JMxHssY7g1ZGnEqmIYwhfPit
 QiSF45lLASYu0f4l4Ktn1Lya3bkNTXgKVUjsyOKw54gIpGkTk4/ga
X-Received: by 2002:a17:907:ca2a:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a699f87f0c8mr252533766b.37.1717659710465; 
 Thu, 06 Jun 2024 00:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNLcWoYHBVo/MeBuBLbH5bdkVfKrCymLQTaWjHV/RC1pbEnk6/b/iKpj7VwH/dakUdwRUAhA==
X-Received: by 2002:a17:907:ca2a:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a699f87f0c8mr252532466b.37.1717659709916; 
 Thu, 06 Jun 2024 00:41:49 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.115.112])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6c8070eaf7sm57647566b.172.2024.06.06.00.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 00:41:49 -0700 (PDT)
Message-ID: <a9271307-dee6-43f7-ba96-89d29310e43d@redhat.com>
Date: Thu, 6 Jun 2024 09:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240605152549.1795762-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240605152549.1795762-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/5/24 17:25, Zhao Liu wrote:
> Compiling without system, user, tools or guest-agent fails with the
> following error message:
> 
> ./configure --disable-system --disable-user --disable-tools \
> --disable-guest-agent
> 
> error message:
> 
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
> /media/liuzhao/data/qemu-cook/build/../util/error-report.c:38: undefined reference to `error_vprintf'
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
> /media/liuzhao/data/qemu-cook/build/../util/error-report.c:215: undefined reference to `error_vprintf'
> collect2: error: ld returned 1 exit status
> 
> This is because tests/bench and tests/unit both need qemuutil, which
> requires error_vprintf stub when system is disabled.
> 
> Add error_vprintf stub into stub_ss for all cases other than disabling
> system.

Should be "other than enabled system emulation", but...

> -if have_ga
> -  stub_ss.add(files('error-printf.c'))
> -endif
> -
>   if have_block or have_user
>     stub_ss.add(files('qtest.c'))
>     stub_ss.add(files('vm-stop.c'))
>     stub_ss.add(files('vmstate.c'))
> -
> -  # more symbols provided by the monitor
> -  stub_ss.add(files('error-printf.c'))
>   endif

... these should be left in, since it's possible to build with 
--enable-guest-agent --enable-system.

The best and easiest solution is simply to move error-printf.c to the 
unconditional section at the top of the file.  I queued the patch with 
that change.

Paolo

>   if have_user
> @@ -76,6 +69,9 @@ if have_system
>     stub_ss.add(files('target-monitor-defs.c'))
>     stub_ss.add(files('win32-kbd-hook.c'))
>     stub_ss.add(files('xen-hw-stub.c'))
> +else
> +  # more symbols provided by the monitor
> +  stub_ss.add(files('error-printf.c'))
>   endif
>   
>   if have_system or have_user


