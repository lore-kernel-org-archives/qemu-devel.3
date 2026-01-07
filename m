Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2892D0D148
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXBp-0000Mj-Cj; Wed, 07 Jan 2026 12:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdXBY-0008Lz-Lx
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdXBW-0006N2-Ts
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767806341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64RrdxvAKYYJgTbhdD0EGa88AiPSZcXVP5exX6iWJ8A=;
 b=FiyhhVwWy1gxYsiMfxWKTFqdIFBtw2oub4Lxr7+fCnii0z5XlAKpGDWlX/onpo1oJFIr2b
 qU7w2z8n1fuPH66BuQf3qwYOobIeBgzt8XYLV7Eel6wy1cmLxO4RRWc7rAYh1rEgczfIdK
 bZB3gtkcrdjiNS+0Mz1F2Br1Aue3hek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-eab-VOAUM3ONUmvGhC6wiA-1; Wed, 07 Jan 2026 12:19:00 -0500
X-MC-Unique: eab-VOAUM3ONUmvGhC6wiA-1
X-Mimecast-MFC-AGG-ID: eab-VOAUM3ONUmvGhC6wiA_1767806339
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so21448735e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767806339; x=1768411139;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64RrdxvAKYYJgTbhdD0EGa88AiPSZcXVP5exX6iWJ8A=;
 b=l7z40LUYHSTlD4jfQnYgoLNgWRIUtE9xwAlM6RF2USVbOWUUoYfeoqRL8Ur9dzNxj9
 YQLVY63u9/WHl+9eD3Fqz5CFKFmb2jnGV2ib35DhJ5QP9r+YUgcTJ5EumIqXxiiKo401
 17jsSbtYZeKdK1HYAYl/AVXeMpWORY/LptVmFAacp4UpDff2geayazKgQRqCLN4yqSTG
 vqRNJikEHbCh07+vqQr4fGUo0T+b8Nzy0a9GWg/qxI9o0SZbmccMc1HSA/IQqlaj3awx
 ta/dema2mztRbRRhuGJLsVRxZ32pqkfDlFd05f0paWGvOKFBHuX7EESqHEa5ZHSa557f
 6hxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo9pC0uV46yH5FmTqlHjPxbSFszhqRstFgxke/bRwOv649XpHHumGNSHSw3HwV0FxHsZgC3QSxpmQ0@nongnu.org
X-Gm-Message-State: AOJu0YxuRiXCn1nEYtoJt6FEwJi1yMRCjVhCKEG9PqPew1kHXrXuhf4l
 aY5dSBSP5TGphvZSSjmxsrOxwcdCJUr228iURPr+JuM2fezYTmP949gImhM3BcJMtGk+sz57bJH
 xaE7dBGEmocM/Im8zgXyuvx7fkuYCBm3osuspoc+RODLwNjY0pNHUubfO
X-Gm-Gg: AY/fxX54fAn/cmI+aFMDKkJF9Qyh5cprAksaQtIDtq+IVFMKlM3IvQRuxL82vr4NpEQ
 IZvdDtjnB1WGnezLYulVHMtZ/Kcrhudowha98sSednLrbxEX5qeeTe5BlJ1K8ddbfmtoM0YHb0L
 i8fGEu94kKehsuKf+A/Z1aK4p4r7fl+qR4WEYoUHBetx6SpWirqxZ559MSjRFeqaqMDQ2lZdcBr
 1Mn4j775TZF97fXFgm3H8Rq7eGApgRn5ujZCFm6jsT62DSUpXzQXX9l+vcXWZGIg1l6TMC0nwzh
 wXB2mr5nXKP4EKzTECEs/Ukw5b2cFM4cagpLg+MKp9vOzTvg6R8oBb/OnthGl/aARv0rVJLtT+a
 0Q+g6csxwqdYv1apAlDcAEdoluvTxxCr97r5v9h/9aeQNuC4UnLCFvtw1WA==
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d84b18037mr43264525e9.9.1767806339112; 
 Wed, 07 Jan 2026 09:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPccdgTwmA7sQEuGvMtJOU6f6xMtodyUwdjuqZDrK+880/R8URQRwitnjLSa3YLNcv9QpKnA==
X-Received: by 2002:a05:600c:4e8a:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d84b18037mr43264215e9.9.1767806338720; 
 Wed, 07 Jan 2026 09:18:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f418538sm106206055e9.5.2026.01.07.09.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 09:18:58 -0800 (PST)
Message-ID: <fabb6573-a927-4ed4-a3c6-a83619866d19@redhat.com>
Date: Wed, 7 Jan 2026 18:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] hw/arm/virt: Declare AArch32 DBGDTRTX as safe to
 ignore in incoming stream
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251222134110.3649287-1-eric.auger@redhat.com>
 <20251222134110.3649287-9-eric.auger@redhat.com> <87a4z9p8y1.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87a4z9p8y1.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 12/23/25 3:30 PM, Cornelia Huck wrote:
> On Mon, Dec 22 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> With the new infrastructure in place it is now feasible to teach
>> qemu that it is safe to ignore a sysreg in the incoming migration
>> stream. So with the plan to revert commit 4f2b82f60431 ("target/arm:
>> Reinstate bogus AArch32 DBGDTRTX register for migration compat) from
> <pedantic> Missing closing '"' </pedantic>
>
>> qemu 11 onwards, let's add a compat in 10.2 machine options stating
> QEMU 11.0?
>
>> that this reg is safe to ignore. from 11.0 onwards we will not need
>> that register anymore.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - add a comment related to DBGDTRTX (Connie)
>> ---
>>  hw/arm/virt.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ec0af8e6e7..00948887a2 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -100,6 +100,15 @@ static GlobalProperty arm_virt_compat_defaults[] = {
>>  static const size_t arm_virt_compat_defaults_len =
>>      G_N_ELEMENTS(arm_virt_compat_defaults);
>>  
>> +/* Register erronously exposed on 10.2 and earlier */
>> +#define DBGDTRTX 0x40200000200e0298
>> +
>> +static GlobalProperty arm_virt_compat_10_2[] = {
>> +    { TYPE_ARM_CPU, "x-mig-safe-missing-regs", stringify(DBGDTRTX)},
>> +};
>> +static const size_t arm_virt_compat_10_2_len =
>> +    G_N_ELEMENTS(arm_virt_compat_10_2);
>> +
>>  /*
>>   * This cannot be called from the virt_machine_class_init() because
>>   * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
>> @@ -3536,6 +3545,7 @@ type_init(machvirt_machine_init);
>>  
>>  static void virt_machine_10_2_options(MachineClass *mc)
>>  {
>> +    compat_props_add(mc->compat_props, arm_virt_compat_10_2, arm_virt_compat_10_2_len);
>>  }
>>  DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
>>  
> Hm, maybe rebase this on top of the new machine types?

definitively

Thanks

Eric
>


