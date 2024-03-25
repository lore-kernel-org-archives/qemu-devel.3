Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A34DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 05:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rod0P-0005Om-Oc; Mon, 25 Mar 2024 01:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rod0H-0005Nq-RZ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rod0G-00010S-0t
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711344969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TgtQ+DMtiPQkrYAgbAtmlSjXgOjNaIxWS+xe0Zj6hc=;
 b=F4Cdfu9HDHKtpyIQ9/HtJ5dFtKSytNaetQj7cBY2MYjVXIgksBTTP+2LEI8hOXpqhSxV7L
 ukOPoRggegDpKHHZHN6pPP3hs0reINbsxhpc/yQn8NtDPvrRv/2dEK0Zm6ZuIUw4ewtkoN
 u9GT8KQnnElTAlHecJd5EGZngyKgohM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-2bjqM9YsN1KTJCJ98503vg-1; Mon, 25 Mar 2024 01:36:05 -0400
X-MC-Unique: 2bjqM9YsN1KTJCJ98503vg-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e67a83e7efso1089413a34.0
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 22:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711344965; x=1711949765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8TgtQ+DMtiPQkrYAgbAtmlSjXgOjNaIxWS+xe0Zj6hc=;
 b=IEBk0To1uyITZ4vJTxFWp/q0GWzqQDGx91mwgz/DSoji5OgTURH2UjMJtR21thy/tC
 g92j3VuecKd06cwozQt3svvBxGtCFggIxfmlLe5pSC5nxybqTywi+CL0tQKekJywm6Fa
 NtbgRo68ESztKoJXuN1RRdsRy8uccUkMT1D2ZWqVb0hhWHA4lVOAgijIHomNA2IAqHW2
 6Kd2D62mFJjuisNWcyX1Hl9fdvoUbPBRso4M5Z+XpOqbUNbITyWeonSLsMZ/zFNVtiul
 W+CYZN0DEvvkPUSCVjeeMb0qvBjQXviKYUk1JppcH4la78tXQIBnulhPRp8ckmShHmNz
 s07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ6duw0lM1Nj4WQBrTqSR8AgSnEpCtk+RwisbSBCeDwuYdf2xBd+aZ9HUzP6cQs3DxkvMdgGv4HxgxTMKBTiGLOMD6zGU=
X-Gm-Message-State: AOJu0YwTnr8S9T/ckiSTRyPNUwzvGYjUzNKcs6nJcyMvxRv13+q/xxyn
 RULZh1wnzVN/yrQQ/QnRTYky5JiPGa/cWJb/kb3YFyKBLRm7fnajmRUrDYdkkaN00Ct/cpdABYw
 QScs45IhO6pJwXKC0pUx7sBFQtONwlpTIPKIFszcOzofhzn8D9jkx
X-Received: by 2002:a05:6808:1588:b0:3c3:cd59:8bca with SMTP id
 t8-20020a056808158800b003c3cd598bcamr2572140oiw.1.1711344964746; 
 Sun, 24 Mar 2024 22:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt9oJb2ITIcGjhwp3JVbL956AzSVHe3VrG3isWxPLgundOEN5rJCSjnl5ChB1nirQXPylzVw==
X-Received: by 2002:a05:6808:1588:b0:3c3:cd59:8bca with SMTP id
 t8-20020a056808158800b003c3cd598bcamr2572113oiw.1.1711344963897; 
 Sun, 24 Mar 2024 22:36:03 -0700 (PDT)
Received: from [10.72.116.135] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa79903000000b006e6b4613de1sm3417819pff.104.2024.03.24.22.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 22:36:03 -0700 (PDT)
Message-ID: <1881554f-9183-4e01-8cda-0934f7829abf@redhat.com>
Date: Mon, 25 Mar 2024 13:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240312074849.71475-1-shahuang@redhat.com>
 <Zf2bbcpWYMWKZpNy@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Zf2bbcpWYMWKZpNy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Daniel,

Thanks for your reviewing. I see your comments in the v7.

I have some doubts about what you said about the QAPI. Do you want me to 
convert the current design into the QAPI parsing like the 
IOThreadVirtQueueMapping? And we need to add new json definition in the 
qapi/ directory?

Thanks,
Shaoqin

On 3/22/24 22:53, Daniel P. Berrangé wrote:
> On Tue, Mar 12, 2024 at 03:48:49AM -0400, Shaoqin Huang wrote:
>> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
>> which PMU events are provided to the guest. Add a new option
>> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
>> Without the filter, all PMU events are exposed from host to guest by
>> default. The usage of the new sub-option can be found from the updated
>> document (docs/system/arm/cpu-features.rst).
>>
>> Here is an example which shows how to use the PMU Event Filtering, when
>> we launch a guest by use kvm, add such command line:
>>
>>    # qemu-system-aarch64 \
>>          -accel kvm \
>>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
> 
> I mistakenly sent some comments to the older v7 (despite this v8 already
> existing) about the design of this syntax So for linking up the threads:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg04703.html
> 
> With regards,
> Daniel

-- 
Shaoqin


