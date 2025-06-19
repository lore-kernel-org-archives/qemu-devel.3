Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB9C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 09:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSBle-0006FC-PV; Thu, 19 Jun 2025 05:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSBlV-0006Ej-Tp
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 05:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSBlQ-0004qR-Rs
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 05:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750326055;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgIO8oizntYZXkxpJgcEY7P1RygKVLeXPs5Y6uuqVJA=;
 b=N6QA9uMtQ4E3uoFx84nIfyvd+XAX3HWsIYjzTRuSh70C4W3zAbi+mMvZZtOSLvbxDh7t+B
 z37l6KKzGwRBJ3ffzgyQgbEieHMTxVsN+wDmoZaQZtm+0n8pQwkF6WDQ85Fjji5ZiziK4S
 hVTsOwCHc6+btfbT+UvCcHmZpvNmUOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-jJ5wqQg5OGOUvWarTeh3og-1; Thu, 19 Jun 2025 05:40:53 -0400
X-MC-Unique: jJ5wqQg5OGOUvWarTeh3og-1
X-Mimecast-MFC-AGG-ID: jJ5wqQg5OGOUvWarTeh3og_1750326052
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso3228245e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 02:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750326052; x=1750930852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zgIO8oizntYZXkxpJgcEY7P1RygKVLeXPs5Y6uuqVJA=;
 b=gN4zviD24vkTSedqB2J3q6s9IbufJX22rerlUONrdMUdcNMo4usp2w+aN7OAyBAmk2
 DyEsZavf0R3SAuGVXeycHiIW7cXXsUSdzDY0K5W4QVJO/uJ4n6RfF8wt4aL1N7s6Mi19
 z3m0Yfl57wxSfX+lDMzUc9G2pzaMX3rp/ahwdjP8fvSXnDmC3bq6taAy6cWTqHOzrI7p
 rn0mr5s29IdEH0XLwfYlCu+a1CwAg3rpiA44pSS0m+hCrEGQYrXgqeuEHB7VyVMMyu55
 G+GM/7JQeYLEpEMux11FW0ZPzB0oGP+K+ti5yCERzMpl1ah9qWGM/K2Nbe2KCmJPspgg
 WjXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDGKy0Rj9+pk5zNQ8YJBwfTKUEJ3DL+asmtYFClftpjpRxWtkyWWQOAleK3goArYE/I8rMecziz2RG@nongnu.org
X-Gm-Message-State: AOJu0YyTgf+mdbJOxg3gHrwwUsDGhQyWpKmMeYx1BtDjpMJIXnZ5HFZd
 T3a3XMmQXnGmt8HIje60RV7eR5xRf06Xkkfvkg4pSrPfLOyk0ciiMERJaeBqqZWEJCuJAllm4Br
 0r8chWQVKaxpaFibSRToTXnKQezqHoXXvyglTZNh8R8uPKZfLxpe+mSo+
X-Gm-Gg: ASbGncvSaUtFguvnmm7HUVgWeT+bM/ZT50g4c/hK/67qjWtm08mloo9RP8A4uVkIB10
 4DIbauFNGxQmqnZ8RNJwtZZYjaRc1Q0Ykfx2iDd3OlyD6azTcU29pkYA82GvZTnHdp4SdU/kInb
 9ffPqW46SixEgFKcHaqAcvU/Ec22k3IVHPFWfYbXVGyNO+AK2YZnod+UK72Z3CjRLXfUJ8rzrbq
 FAfoVY0z/UtcLENE3cM+K2GaWAHjU96n9pbeXscb2z0ZmduU3vt7DMT5dpyafhArOzkhpJ5E1gc
 e4klmqxu/4j0BsvFBWtaFBW6kqpDzqKTO2tGH965Tq3TC7hHiB/pLCUDlMshpVpe5H5yDQ==
X-Received: by 2002:a05:600c:8b85:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-4535ec78fb7mr27581915e9.8.1750326052247; 
 Thu, 19 Jun 2025 02:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENftwl4QnuQsvDEYo5p8WVM3xk0uxKtC2zT/SMRi8xfex2q1azMXc9relA7BpdrSE27R7/bA==
X-Received: by 2002:a05:600c:8b85:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-4535ec78fb7mr27581595e9.8.1750326051756; 
 Thu, 19 Jun 2025 02:40:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45359c1772csm32970795e9.0.2025.06.19.02.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 02:40:51 -0700 (PDT)
Message-ID: <5b9715a1-f3a5-4ac9-820f-510f9e1040ec@redhat.com>
Date: Thu, 19 Jun 2025 11:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alyssa Ross <hi@alyssa.is>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
 <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
 <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
 <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Miguel,

On 6/17/25 5:50 PM, Miguel Luis wrote:
> Hi Eric,
>
>> On 17 Jun 2025, at 15:41, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>
>>
>> On 6/17/25 5:23 PM, Miguel Luis wrote:
>>> Hi Alyssa,
>>>
>>>> On 17 Jun 2025, at 14:17, Alyssa Ross <hi@alyssa.is> wrote:
>>>>
>>>> Eric Auger <eric.auger@redhat.com> writes:
>>>>
>>>>> From: Haibo Xu <haibo.xu@linaro.org>
>>>>>
>>>>> Up to now virt support on guest has been only supported with TCG.
>>>>> Now it becomes feasible to use it with KVM acceleration.
>>>>>
>>>>> Also check only in-kernel GICv3 is used along with KVM EL2.
>>>>>
>>>>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>>>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Hi!  From what I can tell, this will produce an error on hosts that
>>>> don't support nested virtualization when QEMU is invoked with -accel
>>>> kvm:tcg
>>> I didn’t know '-acell kvm:tcg’ could be used as a fallback mechanism between
>>> acceleration modes. May I ask whether do you manage the ‘-cpu’ type for ‘-accel
>>> kvm:tcg’ with cpu ‘max’ ?
>> Does it exist?
>> qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg
> Maybe Alyssa is referring to ‘-M virt,accel=kvm:tcg,virtualization=on,gic-version=3’ ?
>
> The above didn’t triggered any error. Anyhow if the above does what Alyssa’s saying 
> we would just be missing the check for || !tcg_enabled() in this patch, I believe.
You meant you would report an error only if !tcg_enabled()?

In practice tcg_enabled() does not seem to be set when trying kvm first.

Refering to the ancestor of this feature - which I did not know I
acknowledge-,
https://patchwork.ozlabs.org/project/qemu-devel/patch/1275954730-8196-20-git-send-email-aliguori@us.ibm.com/
it is said:

kvm|tcg tries kvm and fallbacks on tcg if kvm support isn't available

It does not state that each option is evaluated with kvm_enabled() and in case it fails enabling one because the host does not support it, it falls back to TCG.

I checked for instance with already integrated MTE option and if the host does not support it, it does not offer the capability to fall back to TCG.

Adding Peter in TO to get his feeling on this.

Thanks

Eric

Besides

>
> Miguel
>
>> Alyssa, didn't you mean -accel kvm or --accel tcg
>>> But more importantly, is this what you’re referring to?
>>>
>>> Although,
>>>
>>>> -machine virtualization=on,
>>> should work for both '-accel kvm’ and ‘-accel tcg’.
>>>
>>>> but I don't think that's the ideal
>>>> behaviour.  It would make more sense for it to fall back to the first
>>>> permitted accel option that does support running the machine as
>>>> configured, so if hardware nested virtualization is not supported, it
>>>> should fall back to TCG.
>>>>
>>>> I maintain an OS development environment that includes scripts for
>>>> running images in QEMU, where running KVM on those images is a
>>>> requirement.  Currently, those scripts simply force TCG on aarch64.
>>>> With this change, to take advantage of KVM NV support, I'd have to try
>>>> to identify in the script whether NV would be supported.  QEMU would be
>>>> in a much better position to determine this and fall back to TCG if it's
>>>> unsupported, like how the -accel option with multiple values usually
>>>> works.
>>> Thanks,
>>> Miguel
>


