Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F06E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7PR-0008L6-3R; Tue, 24 Dec 2024 11:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7PI-0008JD-9h
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7PG-0001N1-Ds
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735056313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VuJOa2t6EWTxB0pbvBANQMl8GZxoC3FY4AiW3fyZHYM=;
 b=EOUzE3tjsJpR53/nw3pgHsS9uQvEfs6tA4e8KSJ6b6fY2NcykKsAALQSVOHTkcEBEsTYkk
 TB0HMOdtwTDSVt3mYxYmdSo29TuyOkJCaf8Zy9JnT9bC1Chi3q4yvAWbFf3gpkry1U6ILr
 PEuPjAqKmh//v5S1jKjVG+sOZvul9Uw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-0n_SjnMNMcWm2mq4BwKZpg-1; Tue, 24 Dec 2024 11:05:11 -0500
X-MC-Unique: 0n_SjnMNMcWm2mq4BwKZpg-1
X-Mimecast-MFC-AGG-ID: 0n_SjnMNMcWm2mq4BwKZpg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3d9d6293fso4434428a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 08:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056310; x=1735661110;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuJOa2t6EWTxB0pbvBANQMl8GZxoC3FY4AiW3fyZHYM=;
 b=mh4u17jgBkvLE+wvDd7dOaKCa73pmEey/qw0uFHy0GlVoRb6+iBDZqfIAbiBf63Dqj
 r1kLyE78bBz7L6iOLANgjDZM9e+hjkA7oSUJQqQAeHvGR/bZ6uFHYU3x88lF3Tm1+2ga
 y9n3YdFxF4m/WB2wXFoNXaBp6BLi0Xp278VV+RN7aBw/xJaE3Z2iwCNbEUoHTxzSwNji
 my+WoNpOkQqBV0k3EkBt3R+Dg/Ql+TyRWoz58pNB1Vj8zPpA4zjA7OY0/yJOxwFNyCq8
 ECA36PH1m6Cxekzd0UkvQmV4z8b/2Erwkivhrz2M50x2xXzXyS9kK23shTEjLp+DJYPP
 BgoA==
X-Gm-Message-State: AOJu0YxAUMMSOrpb/E9kNOVt+4yMZedSJe0k3twEypaLc6gQs12sOGLl
 9qFpAcFx3XK/qF3mTMu6CA6aPzh5NwR8FQ8cAMwJc2wW5fTSYRqOzU+q+3iUhK9Qccd44u7VVBD
 4Y/Ty+OlVeqBQ6KzQfKYiGxD3STzpJA5TYCWMsYJYJNtjIeuNxcvG
X-Gm-Gg: ASbGncuTD110WOTQ4SJYSW2nyp90sSovvNRkPvbWRXYEVldz7vFMUnWEu/c+7bPfMAV
 R70QRMCLY96ROJ2MMOWUIPDXU3TS6XB9dpADdWUZEsSGm2TeXwVz76uHc/fx02au0wyh0rcylIg
 7Uqb+tZTzAD0rprNoCl14m9CXX9Ekm03YE+j9yb0taeYkvU2Iwi2hajmrbAKvtf8Qr0m78WriuD
 0weWwdEp1d7e7Jk7ypyNRbKbJzCaARqXerM6t9X0Xd4066xvIO9lZeJcPgc
X-Received: by 2002:a05:600c:82c3:b0:434:f819:251a with SMTP id
 5b1f17b1804b1-4368a8b68f2mr22603395e9.9.1735056299562; 
 Tue, 24 Dec 2024 08:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ufPZc3eVNu/dvuVB0W+Sc4nkuhLK7WbbM1CIT9lKPHfDE/cU/rJqRfM+aATZf+ClryaltA==
X-Received: by 2002:a05:600c:82c3:b0:434:f819:251a with SMTP id
 5b1f17b1804b1-4368a8b68f2mr22597135e9.9.1735056293789; 
 Tue, 24 Dec 2024 08:04:53 -0800 (PST)
Received: from [192.168.10.27] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-436611ea423sm174711365e9.2.2024.12.24.08.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 08:04:53 -0800 (PST)
Message-ID: <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
Date: Tue, 24 Dec 2024 17:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241219083237.265419-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241219083237.265419-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/19/24 09:32, Zhao Liu wrote:
> Hi folks,
> 
> This is my v6. since Phili has already merged the general smp cache
> part, v6 just includes the remaining i386-specific changes to support
> SMP cache topology for PC machine (currently all patches have got
> Reviewed-by from previous review).
> 
> Compared with v5 [1], there's no change and just series just picks
> the unmerged patches and rebases on the master branch (based on the
> commit 8032c78e556c "Merge tag 'firmware-20241216-pull-request' of
> https://gitlab.com/kraxel/qemu into staging").
> 
> The patch 4 ("i386/cpu: add has_caches flag to check smp_cache"), which
> introduced a has_caches flag, is also ARM side wanted.
> 
> Though now this series targets to i386, to help review, I still include
> the previous introduction about smp cache topology feature.
> 
> 
> Background
> ==========
> 
> The x86 and ARM (RISCV) need to allow user to configure cache properties
> (current only topology):
>   * For x86, the default cache topology model (of max/host CPU) does not
>     always match the Host's real physical cache topology. Performance can
>     increase when the configured virtual topology is closer to the
>     physical topology than a default topology would be.
>   * For ARM, QEMU can't get the cache topology information from the CPU
>     registers, then user configuration is necessary. Additionally, the
>     cache information is also needed for MPAM emulation (for TCG) to
>     build the right PPTT. (Originally from Jonathan)
> 
> 
> About smp-cache
> ===============
> 
> The API design has been discussed heavily in [3].
> 
> Now, smp-cache is implemented as a array integrated in -machine. Though
> -machine currently can't support JSON format, this is the one of the
> directions of future.
> 
> An example is as follows:
> 
> smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die
> 
> "cache" specifies the cache that the properties will be applied on. This
> field is the combination of cache level and cache type. Now it supports
> "l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
> cache) and "l3" (L3 unified cache).
> 
> "topology" field accepts CPU topology levels including "thread", "core",
> "module", "cluster", "die", "socket", "book", "drawer" and a special
> value "default".

Looks good; just one thing, does "thread" make sense?  I think that it's 
almost by definition that threads within a core share all caches, but 
maybe I'm missing some hardware configurations.

Paolo

> The "default" is introduced to make it easier for libvirt to set a
> default parameter value without having to care about the specific
> machine (because currently there is no proper way for machine to
> expose supported topology levels and caches).
> 
> If "default" is set, then the cache topology will follow the
> architecture's default cache topology model. If other CPU topology level
> is set, the cache will be shared at corresponding CPU topology level.
> 
> 
> [1]: Patch v5: https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@intel.com/
> [2]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20241010111822.345-1-alireza.sanaee@huawei.com/
> [3]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Alireza Sanaee (1):
>    i386/cpu: add has_caches flag to check smp_cache configuration
> 
> Zhao Liu (3):
>    i386/cpu: Support thread and module level cache topology
>    i386/cpu: Update cache topology with machine's configuration
>    i386/pc: Support cache topology in -machine for PC machine
> 
>   hw/core/machine-smp.c |  2 ++
>   hw/i386/pc.c          |  4 +++
>   include/hw/boards.h   |  3 ++
>   qemu-options.hx       | 31 +++++++++++++++++-
>   target/i386/cpu.c     | 76 ++++++++++++++++++++++++++++++++++++++++---
>   5 files changed, 111 insertions(+), 5 deletions(-)
> 


