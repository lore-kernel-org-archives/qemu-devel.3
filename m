Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF1C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twogf-0005eT-8y; Mon, 24 Mar 2025 16:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twoge-0005eE-LH
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twogc-0008TT-Nb
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742849177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S5L4+6/vbtfGTA8KMNusrlJJngxELA/9UtveDeNuCXo=;
 b=HPbpx88ez9RNTFcvqwIxvhLdZrJ3OTOIGXylOvsqQZbG77zhhydNyLOok9Dx3V2EzOg0kz
 84OQQ8Pdj2FZe0brY8uJXa2cEL1oADkjhXdaLlGTiaouWLhJIM+D3IlWP+Oh0YwKyscsxd
 Z3zAEiubsQaayLu5HEwlTQwYGQSW7AQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-hxnaCnvcO1KF9jjocZQn0Q-1; Mon, 24 Mar 2025 16:46:14 -0400
X-MC-Unique: hxnaCnvcO1KF9jjocZQn0Q-1
X-Mimecast-MFC-AGG-ID: hxnaCnvcO1KF9jjocZQn0Q_1742849173
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131851046so2034764f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849173; x=1743453973;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5L4+6/vbtfGTA8KMNusrlJJngxELA/9UtveDeNuCXo=;
 b=MF5fEpOi2slTstgo/Gr+LxsYHFS2Urs9SFcCh4SnU4CeWneNEv/2fnV6gadmAynFD6
 hAo0PK3cR3GuJZ6kSu8FUe7ik8lpvdWPplTTsnjvdi9N0HwLXoarVlfxp4lKKomG5bWP
 5JMga6B95C1YYlmJmoXsBM2x/na+4aNrXiVXs3QTjBpphDBDC08pSakD0tZOaSVSy7u4
 W5qZ7usZlIn7+vIO1qOmDeXGda46VaM1oZ2u9+hpxpvMpwC2sC/Oa6E1uDpESXbUl0O8
 unHGufBxkTnfKTViH5EfY1ESgItPR/OoSefLvMqDr6cYCAO9FoInB6FAo4sNOycGv6g2
 rseA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOKDg1LHvT+INX2m+WXKNTB5wHvOBkRthtoDz2xk+RkI7z52rRkxkUWN6yd09Ere+dy0UAWv53tiIm@nongnu.org
X-Gm-Message-State: AOJu0Yyk1sBKV/I4dLb0lfc/qcmuX9pEDGQgKGNLz33Q/fg3f/1Y346X
 I85kWjaOD01q9qmvNqMYLmmZi0X84MzCaBLmotOit6g3ApMg0HxUVyoQZmb8mnQAuwn7Rnou/3P
 8Q2tmIr4JiGW6Tm51EbRGqvmtLujZGyzmw+1BHVkP0H/lj55Q92/U
X-Gm-Gg: ASbGncvch3oTv+iORsyTflSg/KYQ2l1UXL1TdFNCJCtnYwynXRF1hhj/4u7jW6v+ryd
 KX6gOXfJZlQJ2qT/z277RwBPhDph+0jeRDD8VTDpW0FlYtam10FmGmIV7JdRzA0lz4iiZ9hX/0R
 Moorx0tFXAdj1q1yA9mAib11KSgYDAVwU6dRTRmmpYf1QBNjW3VkonnWvN/i8RpF8KKvqrw2XcQ
 qlS/YtXY3wv76JbMfF9hz6PW3vX2Qn7yJgnPBr/3h6DVfM9K+LkhMo1skZGjploBP52ar1dFS/f
 behIV8kC0tOdCLuCp3dhST07YjrQrIGqnRKd+rn1/xE4Io4Uwlz5Kw==
X-Received: by 2002:a5d:64c6:0:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3997f93bf86mr11278564f8f.45.1742849172883; 
 Mon, 24 Mar 2025 13:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVQPr2SR6smlql9CMOCwRLs/p6t4UQ8SFockv8ky4sCLp6/JyxwKPPZACQ3zO3NON6yj/2zw==
X-Received: by 2002:a5d:64c6:0:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3997f93bf86mr11278550f8f.45.1742849172495; 
 Mon, 24 Mar 2025 13:46:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b3ff7sm11712442f8f.48.2025.03.24.13.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:46:12 -0700 (PDT)
Message-ID: <2616d3e5-443c-477f-a024-317fadb76a59@redhat.com>
Date: Mon, 24 Mar 2025 21:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] aspeed queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250323174541.406860-1-clg@redhat.com>
 <08930285-903b-4413-bd6e-20a14b2d15bb@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <08930285-903b-4413-bd6e-20a14b2d15bb@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/24/25 21:36, Michael Tokarev wrote:
> 23.03.2025 20:45, Cédric Le Goater wrote:
>> Jamin Lin (1):
>>        hw/misc/aspeed_hace: Fix buffer overflow in has_padding function
>>
>> Steven Lee (1):
>>        hw/intc/aspeed: Fix IRQ handler mask check
>>
>> Troy Lee (1):
>>        aspeed: Fix maximum number of spi controller
> 
> Is there anything in there worth to pick up for stable series?


you are fast !

- "aspeed: Fix maximum number of spi controller" is QEMU 10.0 material.
- "hw/intc/aspeed: Fix IRQ handler mask check" was merged in QEMU 9.1
- "hw/misc/aspeed_hace: Fix buffer overflow in has_padding function"
    was merged in QEMU 7.1

The last 2 deserve to be backported IMO. They will need some massaging.


Thanks,

C.



