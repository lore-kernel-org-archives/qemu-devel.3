Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0FAC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raD5o-0004ax-TT; Wed, 14 Feb 2024 06:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raD5k-0004Yd-KW
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raD5h-0004z7-U7
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707908770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uxUshFnM5rHy7Qz/vURLJbCFY+VwWnlR3kFTIxVE0tM=;
 b=cZx0U8mjz9xzhL+17G2+qxtzz6M2jZQx4NZVFjB4mx7I+5d33dTeha6o3Uif6KTZz19cJz
 hmnXSBoeSag/XWTdDDoKMcG/Zljw5zffQxS9TYu2MVTf5ftmJTizEZY/U9RJ7jwT7qysO1
 3G1RPaPzlClAmwAJAc8IXgX8MeGRC48=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-pLEf-JHWOYSRkobVmi6esw-1; Wed, 14 Feb 2024 06:06:08 -0500
X-MC-Unique: pLEf-JHWOYSRkobVmi6esw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d0ffb02493so24347161fa.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707908766; x=1708513566;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxUshFnM5rHy7Qz/vURLJbCFY+VwWnlR3kFTIxVE0tM=;
 b=KlY9JYZBoxODSHQr1+wKnTikktpMwyt0xwsQ341LlESAH+5HCZu5YEaaHDqOF5LtAl
 tdmZhr/q+zvFySqlU6fH6Ye+M4uW1bUHoVEprex9vXZdvLtqMZ0QdHLI5dS+EOEdcLPe
 FhxVIIFCfSuzdeTOCC61Ca7xrr49LMxr/hWc4gjuViHQvDk/c3tTJ+wM+mRqD6xQxXR0
 FI1WD083wlxhYQSRHDbrBXX/6pnvgXEZ/vIf8y/NCTv/KN1IR31cZpvgMDTPkeS9gJNY
 lsPr9j/N5Md+p32S9/EBYURjN9BiurH4RXh0PI79Kma6c0f+S/2IpOmoEstFjmBwonyR
 Huog==
X-Gm-Message-State: AOJu0YyyU0cmmdcW/WnCnuRU/+HkHV8HVBCE4Y+FRzqv78yDdMl1/45h
 bAMefYDE4LAB5AcHF1nasf7Aror6b64B1JoDZRPnMfJifnfAp25Uh2HLsGlXbJefOC3Q4Wly5su
 W/NukzHDHtFNTjEywW8Mi03mPY+7mZSF4FiuN2PYWOiC3PE2OLcmI
X-Received: by 2002:a2e:b60e:0:b0:2d1:788:60ff with SMTP id
 r14-20020a2eb60e000000b002d1078860ffmr1736420ljn.16.1707908766732; 
 Wed, 14 Feb 2024 03:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqh9Euu7ReYM7SAFcUcwhSgK09VL0SUCg9s8LNntTZ0DwqsEzNXZtrDXa70FEYA+gH1ZMjQw==
X-Received: by 2002:a2e:b60e:0:b0:2d1:788:60ff with SMTP id
 r14-20020a2eb60e000000b002d1078860ffmr1736391ljn.16.1707908766154; 
 Wed, 14 Feb 2024 03:06:06 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e?
 (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de.
 [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a7bc4c7000000b0041079d336c7sm1589434wmk.39.2024.02.14.03.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 03:06:05 -0800 (PST)
Message-ID: <49e7475d-59b8-4c6b-9d8b-10803ed792de@redhat.com>
Date: Wed, 14 Feb 2024 12:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] libvhost-user: support more memslots and cleanup
 memslot handling code
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
References: <20240202215332.118728-1-david@redhat.com>
 <20240213123259-mutt-send-email-mst@kernel.org>
 <35a8c2e1-e20c-4d68-b7b7-0bd488bc3ac9@redhat.com>
 <20240213133708-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213133708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On 13.02.24 19:55, Michael S. Tsirkin wrote:
> On Tue, Feb 13, 2024 at 07:27:44PM +0100, David Hildenbrand wrote:
>> On 13.02.24 18:33, Michael S. Tsirkin wrote:
>>> On Fri, Feb 02, 2024 at 10:53:17PM +0100, David Hildenbrand wrote:
>>>> This series adds support for more memslots (509) to libvhost-user, to
>>>> make it fully compatible with virtio-mem that uses up to 256 memslots
>>>> accross all memory devices in "dynamic-memslot" mode (more details
>>>> in patch #3).
>>>
>>>
>>> Breaks build on some systems. E.g.
>>> https://gitlab.com/mstredhat/qemu/-/jobs/6163591599
>>>
>>>
>>
>> ./subprojects/libvhost-user/libvhost-user.c:369:27: error: comparison of
>> integer expressions of different signedness: ‘long int’ and ‘unsigned int’
>> [-Werror=sign-compare]
>>    369 |     if (!ret && fs.f_type == HUGETLBFS_MAGIC) {
>>        |                           ^~
>>
>> So easy to fix in v2, thanks!
> 
> 
> I think there is another problem around plugins though.

There is a wrong checkpatch error:

https://gitlab.com/mstredhat/qemu/-/jobs/6162397277

d96f29518232719b0c444ab93913e8515a6cb5c6:100: ERROR: use 
qemu_real_host_page_size() instead of getpagesize()
total: 1 errors, 1 warnings, 81 lines checked

qemu_real_host_page_size() is not available in libvhost-user. But I 
could just change that code to not require getpagesize() at all.


Apart from that, I don't spot anything libvhost-user related (some qtest 
timeouts, a "error_setv: Assertion `*errp == NULL' failed."). Did I miss 
something?

-- 
Cheers,

David / dhildenb


