Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EACCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSH9m-00038m-U3; Wed, 27 May 2026 12:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSH9j-000385-T5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSH9W-0003te-PM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779899425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmaVEarjl+29HjUmp4g0LDPMRPfL+U1HfCPbEe43AKU=;
 b=LM8MSn1/8gsLTcrnip5mzBTJPs2O2I9YGvr5Y5Iat4BBae68pRfEUmH7bJDaLh4FyJYzto
 QtbKxCh3ahwQKanoMaWe9Vd326uKOlMjja8fhvjO9cjcf2ZcHXNXXfj0dcHn8D8nZGvE7f
 8k49Tc0ez1rAaeKyqxiMcFiqoRQRY4o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-VoRYBxFZNJeG6bZ0jZ5YRA-1; Wed, 27 May 2026 12:30:23 -0400
X-MC-Unique: VoRYBxFZNJeG6bZ0jZ5YRA-1
X-Mimecast-MFC-AGG-ID: VoRYBxFZNJeG6bZ0jZ5YRA_1779899422
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so90565005e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899422; x=1780504222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmaVEarjl+29HjUmp4g0LDPMRPfL+U1HfCPbEe43AKU=;
 b=cctzsbuhMObFLycEnQLKyvlStjzzLV8h+tsSBm7utS+QDv2pCyamlMDWGmWq6Scdwg
 k0+Lqzo38C2HvblgJofNjc7yTTrbL9mTvQVwiHmjPph6kgX4bgLtlnaKCZZuWo93Khvm
 6wT//iyCUrqsoo0SjYA4YdnPjgzakQUKbMWc+51s37vc0iHJUkW1nH1qB1noYx6N/WHj
 n8ILYxqc/hbatu0PuHkKnY2nzyfnf4JD4Kp+2b/c3YOYXwlI0MtWjsTS9lAv+sxh2gT6
 RMQQFi9LK6TNS4cezRbenMFKS1ngYdlOwIknzme6yfz9o43gbWosPgld8y5CJZxa8IOi
 kKNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y11hgU9UnRCofonrsR7T2eWBGAYlL9nDCIMioj0UoSAtlNpSX8PpeZ8SvPjZ5dc9063otUCHllPrN@nongnu.org
X-Gm-Message-State: AOJu0YwWJvyWY8+WziiFf1wRig0qvPBr+5pn4a5FL1ytKNhTcTUyIOuG
 CvoLIpjewTl5ULyrA2NUpOJjCMMPGqnpp1sCYjxg9GXJMgvt3o3+AGJOLj/kZQJZsUScGKe1R7f
 DcRm8A+iFGfCoSDE9J1dQRqpMJSa/xPuDjaeZufbjQgQItq9nRSMvJc4N
X-Gm-Gg: Acq92OEdF9O3aKS8BV1pZ722rc7++nPxl1kzMQFFlQMI/8Z/utyqUY/RG+U5NBnek9/
 VeMsIWlv2q+jOI6mgLvG6rEfxjjRl9e80L8/WbPQmtGS+6qeSjkB4HF1Qny7yxOy5d7iYTMgdi9
 vSrgwef+E23itgIS4lKLn1Wm8jNoBfE464ob2FQWiXlg6+p8ZQu7JUskPy1zOpia8Yhq/dKdV/F
 qY0/A4GbuK9BHaLgFLPd/nOmyGW65BN/Gb+VKwCJkcD085MMZJ9sAmdushzBKRQMeqNcQPS9nj5
 cOW+oQUWMY0rqDvlZ0CcglY5B5TegycC2cga7HZczvhQ2q+PEwkecCnHu3V0x8GwmwjV9cXeV+O
 YRA9fPt6GDafCrx+2GMlHCr+nJ0tieVdodsoaearjtRGal7cF3/mfwtZIpqyNZGcpaiP0Hg==
X-Received: by 2002:a05:600c:46c6:b0:490:4927:3777 with SMTP id
 5b1f17b1804b1-490492738a4mr354193355e9.2.1779899421633; 
 Wed, 27 May 2026 09:30:21 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:490:4927:3777 with SMTP id
 5b1f17b1804b1-490492738a4mr354192575e9.2.1779899421146; 
 Wed, 27 May 2026 09:30:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809b7619sm20632265e9.25.2026.05.27.09.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:30:20 -0700 (PDT)
Message-ID: <1cf36575-a542-49a2-a23f-2357184da8fc@redhat.com>
Date: Wed, 27 May 2026 18:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-16-eric.auger@redhat.com>
 <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
 <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
 <6CA1EBCE-BA44-42A1-81D3-1A723C6F0CC3@nutanix.com>
 <72f22825-d810-4fa1-8fc5-123ae06af91e@redhat.com>
 <3A56B398-0213-4962-B27C-96F716DAB799@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3A56B398-0213-4962-B27C-96F716DAB799@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 5/27/26 6:16 PM, Khushit Shah wrote:
>
>> On 27 May 2026, at 9:31 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> but if a field is RESx why don't you want to overwrite it? Are there
>> cases where a field is RESx depending on a condition?
>>
>> Thanks
>>
>> Eric
>>
> There are cases where fields are RESx based on conditions.
> but too complex to get into those (CCSIDR for e.g.). 
>
> What I meant is when we want to realize a model, 
> 1. If we don’t account for RESx fields how will we know which fields Res0 or Res1.
why would you care. Those fields are not exposed through props so host
has the good value, Res0 or 1, no?
> 2. In future what if RESx field becomes a defined field? Instead of maintaining:
>>
>> +    if ((!strcmp(reg->name, "ID_ISAR0_EL1") && i >= 28 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_ISAR5_EL1") && i >= 20 && i <= 23) || /* RES0 */
>> +        (!strcmp(reg->name, "MVFR2_EL1") && i >= 8 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_PFR2_EL1") && i >= 12 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_MMFR5_EL1") && i >= 8 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_AA64FPFR0_EL1") && i >= 2 && i <= 7)) { /* RAZ */
>> +        return true;
>> +    }
but you still have to care with old kernels which expose those fields as
writable. If the value becomes non RESx, you won't have any mismatch
anymore so I think you're just fine. Effectively either we keep this
patch for we just turn the warnings into trace points

Eric
> We can just maintain one cpu-idregs.h.inc and have RESx in that.
>
> Warm Regards,
> Khushit


