Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6ACC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYWM4-0002MW-R1; Mon, 29 Jul 2024 15:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYWM2-0002Km-V3
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 15:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYWM0-0004Lc-TN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 15:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722282499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+pe+UxBOiqOwWi0C7+6rB0d5llyMe//VeX8i3Twkdcc=;
 b=NtL7l6FYl2e2JyDwJcfMRFqm0vSX1g/f14OWu9z9hPy181Z0YkidnhimvhfJC+NvBba0mx
 ZePK5zYQatgvPVIMb86HboKiMV2rlj6SFPjDXdaRbCgBSSSqEIPQ/yt973vHsYLSyh5od1
 skss9pGKQ1Z1qICLy60nGB8wh0O+vBw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-nxjaBsEDPWiKZPi-LEbcJg-1; Mon, 29 Jul 2024 15:48:17 -0400
X-MC-Unique: nxjaBsEDPWiKZPi-LEbcJg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36841edbc32so1399644f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 12:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722282496; x=1722887296;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+pe+UxBOiqOwWi0C7+6rB0d5llyMe//VeX8i3Twkdcc=;
 b=Q/KDYMmPiz2TWyyLgfdTjVMCO2ya2bALbsjcyn19yxfItYMsD5xk96znmGHaNIeqNa
 8f+OoZ5u+bkRB4/U33zRKfsFzr6oRm1fgE24l4aoCTLjqOANjf8j0wHihJ2KWcXrlqUm
 AV7zMKU9Ngvdh66WR8/iHXJ7XUh+4F6F44FHoQp0+EkHAMe0h5IkaoSYyCYjDYfB6Y+V
 S4U5pHS2PNmombH9srR8GyMH2YNQ1mkwJcEMkrhhUiTFI9nk6A2R7EOTgFGkmzO5s9RN
 o5AJPiulfrg9LJcVfREYcpilEfraZTxyL6bLWeTRqP++2+3wHihlKafxzW7Kgyb4Dvsg
 2tMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbnh6nGfeiS1h5plpmxX7A5AHMrz9lMMdQYxV5IV8Lp7FF+EgPp8Lk7aMzKXy6Zv9L9Lr7yZecLNqSM3OIh3FGah6Mejo=
X-Gm-Message-State: AOJu0Yx+JYFQOZ2qtOIpPCzGUS49TKvNMeSj2aIB4KaCyYtYk7lVsbMj
 qJt0vkM8Qyld76aMGOE873dzPuRgA1w6Lue6i0jWOn/nu1I6bZE5xYq33qjgaxFKyOUzWeg4brA
 NCKARi4ComNJwZ5E2wPriUyfyEwvOrRT+keAC/dbPowbCz8ZvEwBq
X-Received: by 2002:adf:fa0f:0:b0:368:3717:10c7 with SMTP id
 ffacd0b85a97d-36b5cee324fmr5030825f8f.4.1722282496674; 
 Mon, 29 Jul 2024 12:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZXpKiDOJ/BnjRlba3KMGFiJwLHfEsKZbiZMYIGCoXMieFRG72zBydjXO2XuyG3UFjLsTIJA==
X-Received: by 2002:adf:fa0f:0:b0:368:3717:10c7 with SMTP id
 ffacd0b85a97d-36b5cee324fmr5030816f8f.4.1722282496298; 
 Mon, 29 Jul 2024 12:48:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:e100:8ba:76bc:e880:d17?
 (p200300cbc732e10008ba76bce8800d17.dip0.t-ipconnect.de.
 [2003:cb:c732:e100:8ba:76bc:e880:d17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857dc2sm12910101f8f.77.2024.07.29.12.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 12:48:15 -0700 (PDT)
Message-ID: <4c99a6a4-77f3-4661-8d16-8a8cd59b1113@redhat.com>
Date: Mon, 29 Jul 2024 21:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
To: Collin Walling <walling@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
 <87a5i0cmht.fsf@pond.sub.org>
 <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
 <4f617078-e88d-4006-a56b-6bed684e577b@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4f617078-e88d-4006-a56b-6bed684e577b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


> 
>> +    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
>> +    s390_get_deprecated_features(deprecated_feats);
>> +
>> +    if (delta_changes) {
>> +        /*
>> +         * Only populate deprecated features that are a
>> +         * subset of the features enabled on the CPU model.
>> +         */
>> +        bitmap_and(deprecated_feats, deprecated_feats,
>> +                   s390_model.features, S390_FEAT_MAX);
>> +    }
>> +
>> +    s390_feat_bitmap_to_ascii(deprecated_feats,
>> +                              &expansion_info->deprecated_props, list_add_feat);
>>        return expansion_info;
>>    }
>>    
> 
> Eh, just a small nit above due to a typo I made.  Other than that, gave
> it all another run-through just in case and everything is still good.
> 

Fixed up, thanks!

-- 
Cheers,

David / dhildenb


