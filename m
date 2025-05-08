Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3FC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzdg-0005ix-Cz; Thu, 08 May 2025 07:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCzde-0005ii-JS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCzdc-0006C7-LT
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746704523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eIHFmceNVxzZ14FnlLIiH7mBywOAsu0YaYKeHPGLvLg=;
 b=dIK7Mh3deNBbkQbCIQeD/rfGsjcO69b6XvmRiGNwJN2V+GsOlxpIpCWWdyW64z1mAOO+l5
 MqloGm4CfV70BKb4UV9sAdFbZfE79oYxTr2oQso/ss51vjtDcfs/yT5DnHIVHSTJ4lJFRk
 6TEZHxBJk8oPUg2UhOs030AOPL74D18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-YX0nVZ6rORCslrfTregrAg-1; Thu, 08 May 2025 07:42:02 -0400
X-MC-Unique: YX0nVZ6rORCslrfTregrAg-1
X-Mimecast-MFC-AGG-ID: YX0nVZ6rORCslrfTregrAg_1746704521
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eed325461so4236365e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746704521; x=1747309321;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIHFmceNVxzZ14FnlLIiH7mBywOAsu0YaYKeHPGLvLg=;
 b=a/uPBn8UvJ7GvRb2QWaPhG6def4DHebzefW8/qD2IOybUxlE5bzpzbY4OSGGkO/fvO
 iz+0oVpZuGvmOhCbJhNBFSIyS2IHn/TuEaI4nqGFFSRFIq4xV/DgCpXaXkfqmf71eGrz
 ezsEEJc799Usj894UnRUsJq2W+QcxeiK+8z9j4hYQ3mu6/EhUHUVYh0smM802LMPJ3Lm
 9HAZcc3AeChuzjZxuz6Je0KPyRrEwhDkYEDSdufpk6jp6HITES7Z1b0MDtmtjSk0mxS4
 rjBk74qHx7oGWJ6d1UWhud8PtlwT+l2CjSl+eucmhqUG0xW7Ja4NpHvPQxRtsRLTR2vc
 kxdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBGnzYAy4PYsViNHLg/rlcGtjBsULMtK+df8lPOsTrFCxxEeVHin38oR/LRZ2hm11LpP63HPhDa8fC@nongnu.org
X-Gm-Message-State: AOJu0Yy0BvKJh8bsNbKTt2ox3lxcOW6uKUgQwng5ddwAQ5XiCBqdgkX8
 Xue+Cicf/hS97+B+kV72+p3d70WPNLPPUvH063W2icrcNO6AGyxSaHfd58ZMiFYZDXDKHEv8hQI
 8LTwlQRoNY1ovYIr5mdMPELzUrA0K9ulL/DLLNyCUW3Of2SVAQmP2
X-Gm-Gg: ASbGnctGw7y/cLF8IDDAmXEDkStxYpzO6j4ysj/1KdqXT3/wrZt2NytojYUTV149oIC
 8Qnbu2FW0umNO12aIuoqBBDyLwgJ6hXm1rTkUHJPXqpIFwFIXII+rWqAevJiuGQAmCuQMTggjs6
 cfBP00vZB7kr36M4KpFXcvXIkIX0f42qiqUmGXTSj7HnFWQ3u1Dg0oEBMRyccNNM0VEejVLnOPS
 0k+nUEf5rxaOPdowFNA3IrhXi3dWpsi3AYvw/zLX3TbRCRD6Jz1P0hszrrrxI3nTkCcaxHvFoqJ
 7qDCDbSpAcxFLeqhB+Chtc1rzBE52TdHDyIKYbg2OZBuyIR7BFet
X-Received: by 2002:a05:600c:8716:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-441d44bbf09mr62954015e9.2.1746704521069; 
 Thu, 08 May 2025 04:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdWA/a4YAz4f7I4F5ujHatNN5cxQNQETQCu8pMqnpYC2elH+qM7BCBeu+JYmm0Nlmdamz0mA==
X-Received: by 2002:a05:600c:8716:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-441d44bbf09mr62953615e9.2.1746704520686; 
 Thu, 08 May 2025 04:42:00 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3af15bsm34760555e9.30.2025.05.08.04.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:42:00 -0700 (PDT)
Message-ID: <f86654a5-66e4-42d5-9a26-7db7a1edf875@redhat.com>
Date: Thu, 8 May 2025 13:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] hw/i386/pc: Remove pc_compat_2_7[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-13-philmd@linaro.org>
 <2e2f4b39-d7f1-4817-947f-106558c1621c@redhat.com>
 <1bd065b9-32ff-46d9-8131-b06e75017243@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1bd065b9-32ff-46d9-8131-b06e75017243@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On 08/05/2025 12.40, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 8/5/25 09:55, Thomas Huth wrote:
>> On 02/05/2025 20.56, Philippe Mathieu-Daudé wrote:
>>> The pc_compat_2_7[] array was only used by the pc-q35-2.7
>>> and pc-i440fx-2.7 machines, which got removed. Remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   include/hw/i386/pc.h |  3 ---
>>>   hw/i386/pc.c         | 10 ----------
>>>   2 files changed, 13 deletions(-)
>>>
>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>> index 4fb2033bc54..319ec82f709 100644
>>> --- a/include/hw/i386/pc.h
>>> +++ b/include/hw/i386/pc.h
>>> @@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
>>>   extern GlobalProperty pc_compat_2_8[];
>>>   extern const size_t pc_compat_2_8_len;
>>> -extern GlobalProperty pc_compat_2_7[];
>>> -extern const size_t pc_compat_2_7_len;
>>> -
>>>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>>>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>>>                                                    const void *data) \
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 7573b880905..ee7095c89a8 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
>>>   };
>>>   const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
>>> -GlobalProperty pc_compat_2_7[] = {
>>> -    { TYPE_X86_CPU, "l3-cache", "off" },
>>> -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
>>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
>>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
>>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
>>> -    { "isa-pcspk", "migrate", "off" },
>>> -};
>>> -const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
>>
>> I'd really appreciate if you could provide clean-up patches for 
>> TYPE_X86_CPU, too. Otherwise I'm pretty sure we'll forget that there is 
>> some clean up possibility here.
> 
> Well TBH it is too exhausting to keep rebasing these patches without
> feedback from maintainers.

Ok, fair, if it's too much right now, it can of course also be done by 
someone else later.

> I'll respin a v4 with Zhao and your comments
> addressed but without touching the TYPE_X86_CPU properties. If
> maintainers prefer to remove dead code in one go -- something I
> certainly understand from a maintainer PoV -- I'll let someone else
> do it, taking over my series.

Since the x86 maintainers seem to be busy with other stuff right now ... I'm 
currently preparing a machine type cleanup pull request that contains 
Daniels patches to automatically disable the old machine types, and my own 
patches to remove the old s390x machine types. If nobody objects, I could 
also add your patches (at least the reviewed ones) there. Michael? Paolo?

  Thomas


