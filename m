Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20439C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrrV-0003ib-Jq; Mon, 08 Jul 2024 13:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrrU-0003fk-6V
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQrrR-0003NG-Vz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720458548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wI4dcONFNpTlPb+n+mVHHHm9UMhgB4awWZCFEdENkw=;
 b=GOvmdknf6JQ6TEw06QrufhFLJcCcNULX+0IIDZhdEysEuSNRZhLC2qneg9JJml6/EoUqUp
 gnCiUU97shqkpw63xGaxcHZzAc28GxMyhVWMFAo5YvuJyJlM1o8kKYCfbXhvlVtrUWRZjp
 nRFBoXOe/33/VM2jcZWTLJr0+MkPXGI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-xJu06LsjP0SM6vcUPMilCw-1; Mon, 08 Jul 2024 13:09:07 -0400
X-MC-Unique: xJu06LsjP0SM6vcUPMilCw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7035c3667aaso2282703a34.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720458547; x=1721063347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wI4dcONFNpTlPb+n+mVHHHm9UMhgB4awWZCFEdENkw=;
 b=d/ylDDI1rYPPVqB3JK/hqcpYkRdtJPzXLuT5Z6M455ir3JbSNI24oLAAil1pkoGRYI
 VbhsEYOlKl6aCJFZBfAa+40vw4Yc1tKRifHomaU/djIDsdqxnsrUT0kAJbbmsorPgNWT
 iCLBnd8P55Chih6BaUstoIGT114s5bhYBJfj2RotiaQDXMxy7Le4ZrM1ZU+h8lgMBY0N
 8OlErz4bkfXbb9xJl/Ts7+aE4BBfcjsGHwWnMtBYSwMS1qB+qgtjE91/0OzSaHdJqkck
 GK/at76OijXxCYczRWQHkUw2nGxJ9goJDrgV5tM6tr+DJpxihIwQwRcBN1a7ejNrCt6m
 vnaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8r5lQ4sgI3VH2ahwiA8sHVmQyaG8/LRd7ZshD7SSUn1p9GUIFlaKeTjIGoPO0ttxROl7RPxFTWsrxZQsue6A5/xifo4I=
X-Gm-Message-State: AOJu0YxdnXvL7DxR+LfhA9TNWG+MJsXCIz56PMsw67PHYiWnYZLi7jdk
 Rke4ZalP1U3zT8v3Ua7e92vRdYroCpxzWvndb+36KSbj9FfILJ/ldfzR2MlqYCQGkqPixJXnJVO
 x5cpy6UZmrtDSsAhZJaqr8qu2L4klY/t0d+KB+0kU3bgZH18QBu4w
X-Received: by 2002:a9d:784d:0:b0:703:5d05:9291 with SMTP id
 46e09a7af769-70375a17aa3mr65715a34.18.1720458546756; 
 Mon, 08 Jul 2024 10:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFESwpew7XeB+jk27miiD4k6NdjfkSVTL7r42XjyeCtM/ZxVYVLH4c8m8fe0EVf6unYYJzmWw==
X-Received: by 2002:a9d:784d:0:b0:703:5d05:9291 with SMTP id
 46e09a7af769-70375a17aa3mr65690a34.18.1720458546381; 
 Mon, 08 Jul 2024 10:09:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba73dfbsm1118386d6.96.2024.07.08.10.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 10:09:05 -0700 (PDT)
Message-ID: <f2a17216-1a03-4c84-85af-8c3145f305ae@redhat.com>
Date: Mon, 8 Jul 2024 19:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] hw/arm/smmuv3: Advertise S2FWB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-19-smostafa@google.com>
 <20240704183658.GO1693268@myrica>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240704183658.GO1693268@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 7/4/24 20:36, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:40AM +0000, Mostafa Saleh wrote:
>> QEMU doesn's support memory attributes, so FWB is NOP, this
>> might change in the future if memory attributre would be supported.
attributes here and below as reported along with v3
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  hw/arm/smmuv3.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 807f26f2da..88378e83dd 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
>>          /* XNX is a stage-2-specific feature */
>>          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
>> +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
> Why is this check needed?
>
>> +            /*
>> +             * QEMU doesn's support memory attributes, so FWB is NOP, this
> doesn't
I have just seen your reply on my v3 comments. I still do not understand
why we expose this bit at this stage.

Thanks

Eric
>
> Thanks,
> Jean
>
>> +             * might change in the future if memory attributre would be
>> +             * supported.
>> +             */
>> +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
>> +        }
>>      }
>>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>


