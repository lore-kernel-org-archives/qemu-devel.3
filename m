Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806F6C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBt1-00074p-VS; Wed, 28 May 2025 04:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBsz-00074O-Qq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBsp-0004gt-VK
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748419888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZfuZIxJifr6GsTZe5HReQfo7a+bt/GT06vAE5L+324E=;
 b=MASng7nvJhZ5j0LW21HUt4UIDaDoSw7osdVKcbOxhIBvD1VnGOtKvLz/9MjiFbQ1uvPvCR
 P/8IhSE92uH8zHWnJozZ0R74deE6g58w9BSEz4CPzAI0r4+06CfpFAvW5ZM9PEImsnucIc
 XzXYJ2frMRBDP1ag+G06uot0vY4pmw0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-d6RExHelNCO9Cy2RvvqDWQ-1; Wed, 28 May 2025 04:11:26 -0400
X-MC-Unique: d6RExHelNCO9Cy2RvvqDWQ-1
X-Mimecast-MFC-AGG-ID: d6RExHelNCO9Cy2RvvqDWQ_1748419885
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-602e863492cso5156153a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748419885; x=1749024685;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfuZIxJifr6GsTZe5HReQfo7a+bt/GT06vAE5L+324E=;
 b=Lj6g0ybwRkweCARVq/51yecw96HTkEYc5YO19hh/YPWa8kXpfap3YNENJpMajUR6bz
 vSaIUgt+CRy/sGdA7afODqKIzvNAC4BiqrTHwDrHUXVrUlhIPvKM/zYdsgIhg8o7Sdog
 jOZsorRF7yKJ84Fg5X3ExgaQk5Ph7R7QuHMDC3OmbOQjQyVEvtTEE5ZZxMct09NIkvUn
 epDBCDdCpFCwijkFgjq6qtZWXdSJNA29udjLXeKw9y+JXGJpItM3QJHMf/DUjS7/TcCS
 UzbjerIBekj0IeK6aK7JG7vzhBJbiP180lNbyqxL2i81zsjw+7AGZLMCTsVRNciBRDOd
 jUKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+CC04y55+GA5g1DsI47OLfug27DQFee2riPAkcZSn0apzzHLtX22FJr8BkQLiT94O5SpYlbXU7YUw@nongnu.org
X-Gm-Message-State: AOJu0YyMBNt4sv+/OJYA8hNj4HG6Dknr9mmYq02h63nBJKzH0HXMZhdX
 qrBZsCioZuwN9/9Wp7hohbyH6UtTZ+yuHx3BQfeCi7VmrDQM8j7j4hLRQwdR61GeLIm+b98EPFL
 Oqw0lqJzmlYCVdDyOwnQC6kfoo/JT8+hnVAGUu43gMo8gsob8w+flzY2m
X-Gm-Gg: ASbGncufSD/Bmqrf75bGhD6HY51R14C+c0ZqVdWK1W+xVT0rsB8d+u/OayihyIPZnox
 dIjq5E760CJPdUtSOZVT9ut0/rWKdnoR5MmvzrQohprI358Bst4rWMCYiiTala6RjL3OiCci63u
 O7HQnAOOq9a9DhOE7bFbJUCfiYtGoq6URiZnh2Mohy1/8k4LJMk+KWMCWmAhfCPMPeOb82x/rsf
 k/bKOygs/jB7opK3c8d0dPLcocnRe0MzNPFPP5w2w7DjBkQSiN8F7AJ6rl+xOuwa6a7om2+bvjY
 hAAl7OlqxpZs9NNCkEiyngjqklG+0UpG0CKwdPKF3+MuQ+uAwz3R
X-Received: by 2002:a05:6402:5112:b0:604:e74d:3615 with SMTP id
 4fb4d7f45d1cf-604e74d367bmr6110001a12.26.1748419884977; 
 Wed, 28 May 2025 01:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXB01BRkZZ8i7b/n6JYWKefRz+EF+BQ2MKyZ2zB+X2xMt/rd05NmleNjA/Zr9QQHjfyZFgIw==
X-Received: by 2002:a05:6402:5112:b0:604:e74d:3615 with SMTP id
 4fb4d7f45d1cf-604e74d367bmr6109972a12.26.1748419884537; 
 Wed, 28 May 2025 01:11:24 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6051d608cd8sm422996a12.38.2025.05.28.01.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:11:24 -0700 (PDT)
Message-ID: <60beed5e-2cf3-4b4a-b717-7ccae1df1fa7@redhat.com>
Date: Wed, 28 May 2025 10:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <5a9ec134-d4cb-49d5-8747-437616e3c36a@intel.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5a9ec134-d4cb-49d5-8747-437616e3c36a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/05/2025 05.01, Xiaoyao Li wrote:
> On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
>> (series reviewed)
>>
>> Since v3:
>> - Fixed 2 issues noticed by Thomas (floppy fallback, e1000)
>>
>> Since v2:
>> - Removed qtest in test-x86-cpuid-compat.c
>>
>> Since v1:
>> - Fixed issues noticed by Thomas
>>
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series only includes the 2.4 and 2.5 machines removal,
>> as it is a big enough number of LoC removed. Rest will
>> follow. Highlight is the legacy fw_cfg API removal :)
> 
> Overall it looks good to me, except the below 4 patches
>>    target/i386/cpu: Remove X86CPU::check_cpuid field
> 
> This one gets hard NAK because it changes the default behavior of QEMU.
> 
>>    hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>>    hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
>>    hw/block/fdc-isa: Remove 'fallback' property
> 
> I'm not sure about the three. Because Unlike other properties removed by 
> this series, the property name removed by above three patches don't have a 
> 'x-' prefix.
> 
> It should be OK to remove properties with 'x-' prefix, but I'm not sure 
> about the ones without it. There might be user using them explicitly. If so, 
> remove them needs to go through standard deprecation process.

As discussed in another thread, we have a lot of properties that are meant 
for internal use, though they are exposed to the user (and "x-" was 
originally meant for experimental properties, not for internal ones). I 
assume these properties here are such internal ones, so I think it should be 
ok to remove them now without explicit deprecation. We did this in the past 
already for the older pc machine types, too, and so far nobody ever 
complained AFAIK. So I suggest to remove them now, and if someone comlains, 
we can still revert the corresponding patch.

  Thomas


