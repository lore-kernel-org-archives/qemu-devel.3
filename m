Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059DFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW59-00030P-FS; Fri, 08 Mar 2024 04:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1riW54-0002rx-Pb
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:59:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1riW53-0000pJ-4g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/N1ybf2WAfWTvcoHcNsy6Ny7vVSfwmnepRD4JNtdw6E=;
 b=emVprBCIZEtJRyNQBoe6i7hQCGFJTX2uzIdEOqFD2y8z5s2wGR+QNHp3LGGNQjOpq3jGXR
 /9tqBPDwjgK8XH6K5o4wndbhRGE3z37ztezv7Q19kOT55DLgfs950Q8puk6/CJKlMvHgnU
 JBe8HwdLthzmB4W0cR6O4MYZ5vCp20s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-_x5jbC_VP32JnbZIz0JQjQ-1; Fri, 08 Mar 2024 03:59:50 -0500
X-MC-Unique: _x5jbC_VP32JnbZIz0JQjQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e6d36db5dso750309f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709888389; x=1710493189;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N1ybf2WAfWTvcoHcNsy6Ny7vVSfwmnepRD4JNtdw6E=;
 b=NtKT/GrsDFpnc3ElScI88P6Fua2rDkvWWEmq8gNGLB3Zh0gbRi2H0XlYFfG8O17AzK
 x0KUsc5V+OtLa+xc1Aly9tzZ4+/8k5CZLWSWQ+WX00VCDwN4sqFHMnuO+16wia0UBSaj
 ECU0dCtFhnHiFgZH7IoSv5F5OtuA93X+gs3p7gBm7668rCQiCtyZ41n7Ux4fBNAvpRCE
 dEFEsPnPqxzvl1lRIFRqqXfSuW+kVFDOZuZOehSC2Hi4BqbTfs9UFRzl14feLRlR3jwg
 Bjy2deZcLfKXtDqWnTU0YqibDy9e8aBwqXiQJP0dnoDmuVD+sDFPyJWdXZnsySlntc97
 pF1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmg+00GxUsYC8w5JiE4rPGuqvJM6R5MWHNkrgBcbT49OMUHvg0u4X7ofH5BlsPC2Xs/BPDz+iR6bA8MzeTiFgoPNGh5YE=
X-Gm-Message-State: AOJu0Yyi2ahc3eu8F6ttBXWZgWtUMJyuIdUBZf+PgG2d2VYkRGsMX1J1
 VpwfclgqUWPlF6cGItryCujQd4bdQusKUqU7Fnqam7JW8uf6GpmYBhsvA7oYQ7fsYagkr0itaj7
 kr1yhDWczp+jkvZdcahptqCBUetAEdVYD8DHJRNpqzRuJC5r+/7qh
X-Received: by 2002:a05:6000:3c5:b0:33e:4590:8bd8 with SMTP id
 b5-20020a05600003c500b0033e45908bd8mr13431645wrg.60.1709888389205; 
 Fri, 08 Mar 2024 00:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPKMB7bVvo+LtqHUg4pcYZaB9WQILf2MSEPHDyZa0mOlugEfRwD8o/r6EUQeaRsuBQO7XUog==
X-Received: by 2002:a05:6000:3c5:b0:33e:4590:8bd8 with SMTP id
 b5-20020a05600003c500b0033e45908bd8mr13431619wrg.60.1709888388826; 
 Fri, 08 Mar 2024 00:59:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:3500:5cd0:78d9:ca49:21f3?
 (p200300cbc70735005cd078d9ca4921f3.dip0.t-ipconnect.de.
 [2003:cb:c707:3500:5cd0:78d9:ca49:21f3])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a05600ca08300b0041304100fa9sm5206380wmb.45.2024.03.08.00.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:59:48 -0800 (PST)
Message-ID: <ac1c7e46-9e8a-4a87-a3e1-e54f4f9421eb@redhat.com>
Date: Fri, 8 Mar 2024 09:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] physmem: Fix MemoryRegion for second access to
 cached MMIO Address Space
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
 <ZerADmIeh6XnbOkG@x1n>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZerADmIeh6XnbOkG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On 08.03.24 08:36, Peter Xu wrote:
> On Thu, Mar 07, 2024 at 03:37:06PM +0000, Jonathan Cameron wrote:
>> v2: (Thanks to Peter Xu for reviewing!)
>> - New patch 1 to rename addr1 to mr_addr in the interests of meaningful naming.
>> - Take advantage of a cached address space only allow for a single MR to simplify
>>    the new code.
>> - Various cleanups of indentation etc.
>> - Cover letter and some patch descriptions updated to reflect changes.
>> - Changes all called out in specific patches.
> 
> All look good to me, thanks.  Having the new functions' first argument as
> MemTxAttrs is slightly weird to me, but that's not a big deal and we can
> clean it up later if wanted.  I guess it's good to fix this in 9.0 first as
> it's a real bug even if not trivial to hit.
> 
> I queued it in my migration tree (with my "memory API" hat..).
> 
> I won't send a pull until next Monday.  Please shoot if there's any objections!
> 

Works for me, thanks!

-- 
Cheers,

David / dhildenb


