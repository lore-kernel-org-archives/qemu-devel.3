Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51374C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuEL-0004CQ-MD; Wed, 02 Jul 2025 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWuEI-0004CD-RM
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uWuEH-0000XD-7S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751450291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlIdRH/kisgVtNYcO4KLq+w4r7Avn7pCszxJlcyTCcY=;
 b=IVw0lReTtJtD7hmoN+rjjXRZhlu/JAhDbYnY9pG8UluDc3bZkTHQU2lHqluPGOO/g8OHsQ
 4AbOcp+NpNxCW2SCV+oB2bdOI+r3EVVrsddQ1rTec/jPWif7f265rL5zatoItfZF/88Ian
 /n96RGJHaTjzRWLc2UH8j7jysVErUFc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_RdWjclkM9id8oabZyF7Xw-1; Wed, 02 Jul 2025 05:58:10 -0400
X-MC-Unique: _RdWjclkM9id8oabZyF7Xw-1
X-Mimecast-MFC-AGG-ID: _RdWjclkM9id8oabZyF7Xw_1751450288
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so63607235ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 02:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450287; x=1752055087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlIdRH/kisgVtNYcO4KLq+w4r7Avn7pCszxJlcyTCcY=;
 b=kbIwFoa1PO40aBSzzTlqQUGB5BlH62NrSBVTEQwswCzRy3L204MFdWandzhGjp5dGj
 Z6l/SgWfOs9fnj8zToQ4pPVR2+HPUtmlknjd5j0wWT9fUei0dwDdMNXMwOY9VowFzqrF
 w2NmTUcbne9P42vWVcAE9/mEKPyy719BqlvHIZ3Zyr6afNXqxuqMkS4wGr4JPDFGTnth
 bdGD44wBkKNGLDMz4T7LDaq4t3DGwpHi8OA+z/PV5X/RZHULYPcql+wtIrpBqk7bCsLX
 X1ckznPNmUrW4V1CXZT4UFV8iy0Kfo8ao2oS/8ObNU/HR/H6oq7gl9cN7M/tDqnPEsPM
 8ZPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfVbCb7p24gfWYd9F5Rl09fS5/aHeeR3KPUKBhRTR8Hem2i4mhUWZkMFwWmesXKbcsc+PTYQocAwCZ@nongnu.org
X-Gm-Message-State: AOJu0Yx7HJRYVv9hngr8mvmzE+ggmjHmSl1ZZph+J4IGbDQNe3NvyD7Q
 M2gAC85isRYDaTN2XPWsiSYWtAkkfKO8VD/5mkBLWcShXoGrQzYGtz9MrXZDLK5Dm9VrieDlyg5
 OFTbZAySduj6IdhXthaqIcja0iWXh3B9htquur06p5BQg6QgT51kTjrEh
X-Gm-Gg: ASbGnctBWOgrXKp1edqVOwAUg2PcVUs+aolQcJm9Sz9vGuKheEL7beUj/Mjtmn8GP+h
 Xt1J3C/Oe0wMVNVkx6h+BTb2Rf2VfT2edbEvnemJPrQFw1UIIJqqtW6l85jU7GiDc5tNK0CSDGh
 ihosLowW/WUfo4M0ZIOxST57M9CRiUGHlgo6DkzHpzZROdj6+1sL/zqB0T3gDM2iKWxU7jo/z3m
 S+l5kXm+pVl+LfYWs6hDaNVY9Ai8Ya4lm5SnN2ljv7IBMCmiLK05YN8DCZ+XfOdRGmyRVqUC7gG
 LD/HjT9nWiYZT0095yam+IkEQA==
X-Received: by 2002:a17:903:1aee:b0:234:cf24:3be8 with SMTP id
 d9443c01a7336-23c6e4ffe2amr38746825ad.28.1751450287639; 
 Wed, 02 Jul 2025 02:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIOSv5USJuOAyLnzov29h5wO/W+lyhr7cMnR+jAmnGHsJYHDE5R0EGxQl+829ZkbwjV2bHaw==
X-Received: by 2002:a17:903:1aee:b0:234:cf24:3be8 with SMTP id
 d9443c01a7336-23c6e4ffe2amr38746495ad.28.1751450287304; 
 Wed, 02 Jul 2025 02:58:07 -0700 (PDT)
Received: from [10.72.116.77] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f21e0sm126690275ad.74.2025.07.02.02.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:58:06 -0700 (PDT)
Message-ID: <33f10216-4d04-456e-95d6-23cf5469922c@redhat.com>
Date: Wed, 2 Jul 2025 17:57:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] hw/i386: Add the ramfb romfile compatibility
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250702085616.2172722-1-shahuang@redhat.com>
 <20250702085616.2172722-3-shahuang@redhat.com>
 <dec256c0-d0a5-49d7-b5ce-a025eaf27f8c@redhat.com>
 <36d469be-d9fd-48c9-8106-2db885e6fe39@redhat.com>
 <etie67k64lfoaaqhuym5ayse6ejbwmdqrbm6n3ja5raqqsuupm@j5tev5gtzsqx>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <etie67k64lfoaaqhuym5ayse6ejbwmdqrbm6n3ja5raqqsuupm@j5tev5gtzsqx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
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

Hi Gerd,

On 7/2/25 5:52 PM, Gerd Hoffmann wrote:
> On Wed, Jul 02, 2025 at 05:28:01PM +0800, Shaoqin Huang wrote:
>> Hi Eric,
>>
>> On 7/2/25 5:08 PM, Eric Auger wrote:
>>>
>>>
>>> On 7/2/25 10:56 AM, Shaoqin Huang wrote:
>>>> Set the "use-legacy-x86-rom" property to false by default, and only set
>>>> it to true on x86 since only x86 will need it.
>>>>
>>>> At the same time, set the "use-legacy-x86-rom" property to true on those
>>>> historical versioned machine types in order to avoid the memory layout
>>>> being changed.
>>>>
>>>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>>>> ---
>>>>    hw/core/machine.c             |  2 ++
>>>>    hw/display/ramfb-standalone.c |  2 +-
>>>>    hw/i386/pc_piix.c             | 10 ++++++++++
>>>>    hw/i386/pc_q35.c              |  3 +++
>>> If I understood correctly, Gerd said we needed to set the prop to "true"
>>> on microvm too? I don't see that change.
>>
>> Yes, I try to do that. But I didn't see there are any machine type in the
>> microvm like q35. I'm confuse about it, How should I do that?
> 
> Just add them to microvm_properties[]

Thanks a lot. I currently know how to do that.

Thanks,
Shaoqin

> 
> take care,
>    Gerd
> 

-- 
Shaoqin


