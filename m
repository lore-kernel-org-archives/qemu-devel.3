Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108F0C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tic1k-0005ka-1c; Thu, 13 Feb 2025 11:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tic1h-0005iP-Qa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tic1g-0000bm-6L
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739463915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EXhNMHfv7CLCW1I+qL87LnHn2870+kNbR6MQwWll9E8=;
 b=bpPiUU84YKd4giYL+HX2RVfRSEr9xNBK/DkvuSZ9T4+y0dq3kIOktcUdm4KtyN/3pRie2V
 2pdbgKubA7tEOLAolGHX1pg12exZxSSw4dttFgq3NfY9qAt4UVWeaAGLRYqlSNQ3qBM1Ra
 WRaPVRWXxbrtLruyBlu0RQ0DEV0mlXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-CbRBznlqMe-Zw6oAvbweWA-1; Thu, 13 Feb 2025 11:25:13 -0500
X-MC-Unique: CbRBznlqMe-Zw6oAvbweWA-1
X-Mimecast-MFC-AGG-ID: CbRBznlqMe-Zw6oAvbweWA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394c489babso6054875e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739463912; x=1740068712;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EXhNMHfv7CLCW1I+qL87LnHn2870+kNbR6MQwWll9E8=;
 b=GgsSEelhiatuOYvlLzI+qHQxV0khKWocMDohV2tKa8ekX8l4tivfdaYxQCwelrd9sj
 TxJsSuDFzbDcmjauqDOtg5u+jNo24sOxFj3H6/SQIK2aqo77LmIG50P7UdYsFDXEOTbC
 ETpVRLQSF0ZmEF9hnZZkPg2Z1tNZEQr807ciT9DPEjfkvuCWed4621neCqBw1lRM9Wrd
 JYIoff1Y6vKITaQ6m/H26Yr5iIPHvA6iWYD2LQd7bAUW6MtD+tdwN0aEQzZc6dNvyani
 Fcv+juAejsfqQo9eJYLGS4z7tQyNBcXFggNOLzTT9Jk3zKbGRLuB/EDXj9LCIcPUjh8q
 aiBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv5eAGY2GNucxlxcF9H2D9rwgn9Y9+4Zxdsp3tDtbBXeuK9/LEMQnMsX7xF4EoDzLdSN7eXGy9M3pf@nongnu.org
X-Gm-Message-State: AOJu0Yy7ejn68ty3Q23RII40lNCWBDGcgLlOWHVVfuxO3tnSyCdXwD19
 40aXLvdWlIaVfzUJ/xZSX9lXpCCA6xfVtNvsgyKO0gZbvJC0ACQRKXMsJ5iHiJVv+370IxNkvNN
 9ztoHdKCyVWRF3Mhz1XTUZwI0v9Q71yNYd30Hr8go3jlKwcEs/dnf
X-Gm-Gg: ASbGncvI5r32HqGjk257iCDqSOjXemA86Bfgu4OZG/i+IfkatGjhCzxN+0WvMvugqqJ
 x5Xm2vj/F9Zifw3cX3i7HkXUl2nLmB8yaKXnT3MLqcaM7azjaozXUkqqh4bNM5yyCM/YWUAdJ50
 zRxuS8CvlhU/MvkNM9hOzie7DKDpxvLPahqa8seNApsgVR8GsHjEhoDGv+k4hc1f8bu1uE75O0Q
 lHnVDxnLDWll11dO1j+uEeKSqq3zhPh2nGf5ZuuA/reRRjts/ZIAH4DX7vqUAjeYBVjwJWBzw0t
 p2pyc8gR5taDMIkF67xWMO5dd72HcPkQ6eSzyjbXI6zXvBFqPhSCBZVkC+4hGD7g0+fySj2rnl4
 1YRbGwUxP4rCxR/8+wywkmhoKUOBpTQ==
X-Received: by 2002:a05:600c:34cc:b0:439:4696:c071 with SMTP id
 5b1f17b1804b1-439601a7096mr46616985e9.19.1739463912461; 
 Thu, 13 Feb 2025 08:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD8eF6as7rCwtssuthp9X+mFsme827Wr0JunCjzr/QGDrReFWIcKlcEOeH0GrIbnBKDSV80Q==
X-Received: by 2002:a05:600c:34cc:b0:439:4696:c071 with SMTP id
 5b1f17b1804b1-439601a7096mr46616565e9.19.1739463911989; 
 Thu, 13 Feb 2025 08:25:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:100:347d:db94:161d:398f?
 (p200300cbc7180100347ddb94161d398f.dip0.t-ipconnect.de.
 [2003:cb:c718:100:347d:db94:161d:398f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7c7sm53816095e9.27.2025.02.13.08.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 08:25:10 -0800 (PST)
Message-ID: <c1f5c4d2-d131-452f-b414-169bb6685f07@redhat.com>
Date: Thu, 13 Feb 2025 17:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
To: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: gaosong <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <30c1c330-32d1-fa36-c0ca-670c94a06736@loongson.cn>
 <87a5aqhxpt.fsf@pond.sub.org>
 <20250213171705.6dde38cf@imammedo.users.ipa.redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250213171705.6dde38cf@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13.02.25 17:17, Igor Mammedov wrote:
> On Thu, 13 Feb 2025 12:48:30 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> gaosong <gaosong@loongson.cn> writes:
>>
>>> Cc: Markus
>>>
>>> hi, Markus
>>>
>>> What is the difference between CPU_MODEL_EXPANSION_TYPE_STATIC and
>>> CPU_MODEL_EXPANSION_TYPE_FULL?
> 
> the only difference is that 'static' expansion will not report properties
> not mentioned in hard-codded CPU model definition see: builtin_x86_defs
> 
> while 'full' will iterate over/report all rw properties of CPU object
> created from provided model name.
> 
>> I don't know :)
>>
>> Here's the documentation:
>>
>>      ##
>>      # @CpuModelExpansionType:
>>      #
>>      # An enumeration of CPU model expansion types.
>>      #
>>      # @static: Expand to a static CPU model, a combination of a static
>>      #     base model name and property delta changes.  As the static base
>>      #     model will never change, the expanded CPU model will be the
>>      #     same, independent of QEMU version, machine type, machine
>>      #     options, and accelerator options.  Therefore, the resulting
>>      #     model can be used by tooling without having to specify a
>>      #     compatibility machine - e.g. when displaying the "host" model.
>>      #     The @static CPU models are migration-safe.
> 
> Looking at related x86 code above description sounds like a fiction.

On s390x, which added that interface, that is how it's work.

It resolves to "-base" models that are fixed for all eternity.

x86-64 probably didn't adhere to the description because they were not 
interested in adding stable base models.

-- 
Cheers,

David / dhildenb


