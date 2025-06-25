Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E95AC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 15:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSPM-0006mY-4O; Wed, 25 Jun 2025 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSPJ-0006m9-96
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSPH-00066D-NA
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750866683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WwJcT+y4+IiOInb68EGrUFqISkG0rwX7JpsHThrVm5Q=;
 b=gNMrq9iOKHzWDphfiCj/gVbwxjFxwtUr67UA/WnBu8jjiXk0BWtd0hEoWIIxd9dKgYB52v
 SYBwhk8KpxYZh8stx/1MhIdEZgsh3zEZNa7SxJz8KzocjjEICf9e5B6fsiVCoV4Tf6kiUu
 iRDdDMX1Q7H5b8jI+atcwj+KTzq8t2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-oYkZ7-lPNNGWwM2XegB4Kw-1; Wed, 25 Jun 2025 11:51:21 -0400
X-MC-Unique: oYkZ7-lPNNGWwM2XegB4Kw-1
X-Mimecast-MFC-AGG-ID: oYkZ7-lPNNGWwM2XegB4Kw_1750866681
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so11269155e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 08:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750866681; x=1751471481;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwJcT+y4+IiOInb68EGrUFqISkG0rwX7JpsHThrVm5Q=;
 b=IpwrcK8F3MK8QQDCiy0xYP13MWZ4fu4vr3su1/1KZ9LaGot9N1+y74Yjt82dhBI6oj
 35D/B+q2uk2Ck8A+M4hb0+SUnG/AWuTKMEc1tyeWMI1c2aV2sF0JtV+c/KInbBy+honi
 9r1JdjxLT4q5Lud/ofkp7ZI5L9F/KoZW8+wmafD5mdDZDgKOTXt+hPXKkcDvsHlUJEN2
 ayCmlC5PuwnP8wNrQUIBPi8DElc35gJbkuzkvwl4A7GuW1TfulHGBKszRsSpDnheuOJW
 02QQ25foummpXe+rX9xV+uZem5W0vlsv512t+Cf+swGeBWB8mIcRFYRnbzWoctcr889c
 yYJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDc1JzsEyVjuxEDyqn6kaiNseknHl+fSbg13Un+lc25vD0ORZfT8KG7/zFIno5vVd0q3JJN7ZRiaNu@nongnu.org
X-Gm-Message-State: AOJu0YxT33ekyL1J0reGrFx2zZAk1TMLMGKjVhC8ysk64sjQbZPKX8L4
 X+Tus/JOy7FwQEtKLbmdQODQ7H7XIhUwgjIUkZUxIfB46ws72YDnvWMe8vlus1lgDcKldjPBaRK
 OwUKv260XxbXgUlYqx8FJBXzVXuorhNkkbDjsgwmsr2IFKEDZgk3uPC61
X-Gm-Gg: ASbGncubkBQvVcFq5vaXC9MKZM2Q/7F71HldQ8aUGofG3lGqmQs4fXSBiJ16ixVicw+
 Y5oVQ8NiE7eNzmuFMc0pLoISJn74gcfSSnGfWLjbM/IGBOKGN5tJXKno1SQIYLS6us89FzfRWzj
 sXM3BaYTpcjqinXbd2X2l/YnHtkYbXlKrxIEhNbRT1L7B7jDEemmn5/qUxM8oxK29mBzJKvTXFM
 TKLW3tmdy+O428Z2uBWt2/xEE2HsVmOsv0ysZuF5eM394gQhE46nULipWmL6Zi8SUAk2OveN6ef
 UIHX7P7NLuAOPeCQ2CZY0empfZqaUzhIpZ9KMT8AdQTm1MSJOgjCtJAsk9KWRJk=
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45381af6a8fmr38696555e9.16.1750866680686; 
 Wed, 25 Jun 2025 08:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu8W2kq8VC4kH3zSw3okewyJlaIlkNd+yfMS3o4NM37ERtGlMjfe9qPE5jCtedQDa0WqO6Iw==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45381af6a8fmr38696215e9.16.1750866680331; 
 Wed, 25 Jun 2025 08:51:20 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80ff561sm5059639f8f.68.2025.06.25.08.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:51:19 -0700 (PDT)
Message-ID: <b80fb93d-f596-4ffb-9dff-2ecc5d8a1f56@redhat.com>
Date: Wed, 25 Jun 2025 17:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] libdecnumber: replace FSF postal address with
 licenses URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.03@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250613.qemu.patch.03@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 13/06/2025 18.39, Sean Wei wrote:
> Some of the GPLv2 boiler-plate still contained the
> obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   libdecnumber/decContext.c     | 5 ++---
>   libdecnumber/decNumber.c      | 5 ++---
>   libdecnumber/dpd/decimal128.c | 5 ++---
>   libdecnumber/dpd/decimal32.c  | 5 ++---
>   libdecnumber/dpd/decimal64.c  | 5 ++---
>   5 files changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


