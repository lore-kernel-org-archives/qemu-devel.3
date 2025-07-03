Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BB8C83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 06:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDL1-0001bo-0Y; Thu, 03 Jul 2025 02:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXDKy-0001Zy-Dq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXDKw-0004BB-15
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751523739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8MmwHKGuBoDy7o5IE96NmoPGYvWIIWNLi7gbQUFWMRo=;
 b=Yk6Hm6iplqV+9Hzy5QfbNRD+TtRxsMcN+qhALtklcLgUk1yB00W3ydlnrv0s3kq32l90OP
 Im+/oYNBQQtY8nGzshjXWrQuAKu2DqwbXGNSGKjKLNSQyWk/2MD5nKXnYYlg3De7Uo0YBL
 3+l2+/G8x0fkSooQyRuWKPNg5hdm7mk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-fEjp3OkDMzOZ4A8VnFQkVg-1; Thu, 03 Jul 2025 02:22:18 -0400
X-MC-Unique: fEjp3OkDMzOZ4A8VnFQkVg-1
X-Mimecast-MFC-AGG-ID: fEjp3OkDMzOZ4A8VnFQkVg_1751523737
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso3096896f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 23:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751523737; x=1752128537;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MmwHKGuBoDy7o5IE96NmoPGYvWIIWNLi7gbQUFWMRo=;
 b=sjMYr9nqe/lozQS2sAngxpoMxLohJ1eR368qMg7tGaGnotx3sQQH8jtnXFtz1TUVAD
 7WuOBTFGe2l2N+HLebu/j2UpIwUEeCQKa6PjVSVouZE4EkjdYOCvig6LBuBcTrnRqxkh
 wy8+Ex9GZO5v3v7nFNATH+u8zj7il5zbgyCIE9jF9Lz2bV5baj5BRYn/DLmQp2lCv94i
 2cc7h9PYHeryq0FrIAy2ZwfNHiW5OLM8VK+r5gMM8sPbGHKgIgBzuUSBiTZ6ZMduN0Ni
 cgvn5GRL6T2Vb9sa1KRhmXL57FJPfasGErBI3spIrbyAXLNKK5tyXdinIlTaQnDDTRam
 tO4A==
X-Gm-Message-State: AOJu0YwAqt/ZmM1iIkRW7ytFciMPfeCap/5hinZvuQQT9Gu7Pxb2uNbY
 RGdXo5Bz1cjUeqX+BNG4cxkD7MIiCUM3j3o+wz9W3E+0a4lVOhkclbiBHoxBuSGKMprBgbKWxRs
 1AYtmwW12qTHCw68Lc8IdGpiR7Jog7P6M5aYPQMgpETavXR4WxePVOEkyvpQrCp3pciNyLP6ogL
 8C+klUjycgIg1cQ8yKnOY/UsXfIYR3mGAvCA==
X-Gm-Gg: ASbGnctW6gdq2/gC1mDF6nwG8Fc7gZh5ywcrlqy7iDh9cRcgGjcEOwFrtfV9+7zexbN
 UmP1EwKDvPHPHeSRCnqe1cPsOpWrmsoRKN5pIwBA1sKScYQ9LeKmYxK501KS/kZB004k/UuG6SG
 H57uqTHg0nN3aaTKVJXMV7YZLVMyj3U9nSXvRykcYbX1Q9BBelrvO/hfeJodndC8Erelj6GceRs
 DGwfKze65L8J33LhiebMUVGZJGM3tBsGeJepZv2vp/L4zPZnzlRve4GmUefs2UTuCaSWoTWRAkX
 5cH96bhqmrRS+g1VX5iniXayjSDcFQFqAu6cvZzaDxHI1oBllKn5MXX55bQ1
X-Received: by 2002:a05:6000:25c7:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3b1fe0f0915mr4400726f8f.5.1751523736863; 
 Wed, 02 Jul 2025 23:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJzpjZ7VIubWwGGIXPRZFCnyQTeKLrPkrN2dosQo2PTUP36/CEZvYVx5BWEVEcP0o7ikqgWw==
X-Received: by 2002:a05:6000:25c7:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3b1fe0f0915mr4400696f8f.5.1751523736316; 
 Wed, 02 Jul 2025 23:22:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm16966015e9.31.2025.07.02.23.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 23:22:15 -0700 (PDT)
Message-ID: <9ff50c09-07c6-403e-956d-9e660e471abf@redhat.com>
Date: Thu, 3 Jul 2025 08:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: prune quilt source files for cscope
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250630172048.519182-1-clg@redhat.com>
 <53990724-f80d-48e3-bab7-604aa4f3e92d@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <53990724-f80d-48e3-bab7-604aa4f3e92d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/2/25 23:41, Cédric Le Goater wrote:
> On 6/30/25 19:20, Cédric Le Goater wrote:
>> Both quilt, to apply patches, and cscope, to navigate in the code, are
>> useful tools. Make sure source files that quilt saves when applying
>> patches are not taken into account when building the cscope database.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Makefile b/Makefile
>> index c92a3cf7857a..74c2da203720 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -227,6 +227,7 @@ distclean: clean recurse-distclean
>>       rm -Rf .sdk qemu-bundle
>>   find-src-path = find "$(SRC_PATH)" -path "$(SRC_PATH)/meson" -prune -o \
>> +    -path "$(SRC_PATH)/.pc" -prune -o \
>>       -type l -prune -o \( -name "*.[chsS]" -o -name "*.[ch].inc" \)
>>   .PHONY: ctags
> 
> if no one objects, I will add it to the vfio queue.
> 
> Thanks,
> 
> C.
> 
> 


Applied to vfio-next.

Thanks,

C.



