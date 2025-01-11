Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B30E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWSpu-0002zN-Ll; Fri, 10 Jan 2025 23:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tWSlH-0008CA-Lu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 23:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tWSlF-0004y2-Br
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 23:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736568366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qj+9mz/QvIa3LS+3FXk+hh3iv5MxugOp9C8kJzQEK0=;
 b=jRpudCc9k09QoTgTuhFEO+Z8UewI+BvG7uNS8CDGlF7+5WcbsIMxXLuSKMMLrL6cjV5lVJ
 /ReZvXCh4TytUPBasYiMDiM7SOmAVGa5cxhiy3436MH65TnTRIlahZtuiuGlObvaHFxEu9
 ov+tmznd/X/ClxpRaIyAUg3Hm7su4C4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-vR_MUTl0PdqLO_IC_tdXdQ-1; Fri, 10 Jan 2025 23:06:02 -0500
X-MC-Unique: vR_MUTl0PdqLO_IC_tdXdQ-1
X-Mimecast-MFC-AGG-ID: vR_MUTl0PdqLO_IC_tdXdQ
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b864496708so678311185a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 20:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736568362; x=1737173162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qj+9mz/QvIa3LS+3FXk+hh3iv5MxugOp9C8kJzQEK0=;
 b=tFZcHHEDV0NUnWjCLJX0CPKADovTD/XjslINIQWcuJ4a4FYFA4AOc9oHgsnzeLKmM+
 FDsScRS4Bvsh4XIJjSNraKvBtzyMI/xDP4E8/j+Ip/NkL/iGqtslaRkpD6TGGWqrSFLv
 h15YObRrkjIMCuZ0+sTVt7OvexXNfqYgC8c3tJaHi0XupEiMDMsqA4c2Shc+ccSKvXaD
 zkrd20rhW8qjFVIxpw26Cu1RD+5LdBqetZCA3tRXvtji3IAc67rU6R8thEO1kRYqWROX
 eiB2sQmswIDdgyfHZ3q2tZ2BRhR0OZZWjqZRs/xTD7G+vBcGGkrOcc8LltTuYwfBLnsN
 dULw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX7kMtT6mxH8fvNy1khDSLxB9r21Ij0DW5nXBkMz0MRMbK0gYf+Kn11y1F7JVnt+5ZzTvvMQV3+i+z@nongnu.org
X-Gm-Message-State: AOJu0Ywu/IOhtSWTHcVVxOrGoEopRBDahiMBbzLH2HmVzr7dmCs5IkMZ
 ey5WE6XG13cL7RSs3c+ch/mIgcvgc7NEO6lpKVYLkKQAYHg4EcgauY8eVhutDRmETQGd18V+Dhx
 6J9f4IL3MvFE0RRn0yFN/FiJmGzfaGi6lJSEI/yNxKMOLQI0jMwv0
X-Gm-Gg: ASbGnctP9EcG/B/gXk1nZwL37PwDhdguw2Ml1YAHQS5UNi6KBdEFhn0vQ3tm/KhcJTx
 FsuE9K6oCb+Q3eS7xooUVT49U5ZuRrSS1Og5I+PSaWmtYeHmUNlJEw4fX6m+uGZP9XUgIbFKmp+
 PKLoW81hTc/E4o/o9Kk32ks2HAA2F0uZ5RMEmxMj4kASIuwoBiPiBuJ41dslNIHD9VobusaJw5p
 21aX+Fgd08zjtw9XiC2JQ9Mc876OfWaVfX5Z50GXp1KogI5Ma97
X-Received: by 2002:a05:620a:4407:b0:7a9:afef:33e6 with SMTP id
 af79cd13be357-7bcd97893a1mr1770827385a.34.1736568361821; 
 Fri, 10 Jan 2025 20:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuKxx4vMEE1KgX2pAn/AcY5CiRLkCSSfxU/YHIYRiBxgzOXEOSUodQiCgxnhO6YhBSz+2oPA==
X-Received: by 2002:a05:620a:4407:b0:7a9:afef:33e6 with SMTP id
 af79cd13be357-7bcd97893a1mr1770825485a.34.1736568361537; 
 Fri, 10 Jan 2025 20:06:01 -0800 (PST)
Received: from [172.20.4.54] ([12.177.140.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce350e0e6sm242400285a.96.2025.01.10.20.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 20:06:00 -0800 (PST)
Message-ID: <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
Date: Fri, 10 Jan 2025 23:05:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nicolin,
Hi!


On 1/8/25 11:45 PM, Nicolin Chen wrote:
> On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
>> And patches prior to this commit adds that support:
>> 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
>> SMMUv3")
>>
>> Nicolin is soon going to send out those for review. Or I can include
>> those in this series so that it gives a complete picture. Nicolin?
> 
> Just found that I forgot to reply this one...sorry
> 
> I asked Don/Eric to take over that vSMMU series:
> https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
> (The majority of my effort has been still on the kernel side:
>   previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
> 
> Don/Eric, is there any update from your side?
> 
Apologies for delayed response, been at customer site, and haven't been keeping up w/biz email.
Eric is probably waiting for me to get back and chat as well.
Will look to reply early next week.
- Don

> I think it's also a good time to align with each other so we
> can take our next step in the new year :)
> 
> Thanks
> Nicolin
> 


