Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5796F1075277
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38p7-0000t1-Me; Thu, 19 Mar 2026 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38p6-0000s8-E8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38p4-0000pe-QG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7cLxMYNgXnfzz+PN/QWKG8UKjJ1/reoqJ1cH5s+c4Fk=;
 b=Y1y3X78iVB8S3jtGl+7WfbJZqlnDfZJfKzkniOBbztVolDddUDHyT5ZJJV7USrTL4c2e4C
 kGxGJY9qaf99qclbFh8A0bZmYnIiQdMWDfHOq+VIl2rgjlPKtdJVBN1M9/mV/NBPi95MtS
 PLnPLwWvampM7n2pIGcRomRLVMXZLxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-pm90BEFdO42wNBe0Y4RmUw-1; Thu, 19 Mar 2026 04:33:40 -0400
X-MC-Unique: pm90BEFdO42wNBe0Y4RmUw-1
X-Mimecast-MFC-AGG-ID: pm90BEFdO42wNBe0Y4RmUw_1773909219
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b3a41c62bso934403f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773909219; x=1774514019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7cLxMYNgXnfzz+PN/QWKG8UKjJ1/reoqJ1cH5s+c4Fk=;
 b=G8/drxUUmcgBASaXkJieV59wqTIgGAtz23uCNf44RZmqQXV2r1cPqNd+mqy6QIX1F4
 YXBiu1V9+DqMOsVqOiWPis/Y38nrdwvL/XKgHnJEh0WXVJ5zQiABvxH2XEqhcYb+/BqC
 rbIAew4mpz8WlTJYLYeOey0Vs5y4OC58IZnn9jn86dW0pklYUzLREgjdtqZ1yVB1VE0i
 lFHLV+Fa+94QUQhXU9x7+kGtDG/rLbOwwC8LmqbP01qVVIcLWxhiZnoYfJcmoqCel4nT
 Tyfbu+0SLTeJdkqCpsEvUPZOXvmbSPfNJ9Kz+9vjMBMrncEjKRHDlj7tWOo1pJONIAym
 /3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909219; x=1774514019;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cLxMYNgXnfzz+PN/QWKG8UKjJ1/reoqJ1cH5s+c4Fk=;
 b=R/kEQmtvC0TBA0uMRpdGtMOgn6wErh4u0q3Gyl/fLfQl/NMa//MlGMItpoZSTlfU66
 OohXjaShNA9iV/w4vayWr8TIQw2/viOiNPiQB/eN0KRXscKKNkDZoiXY3YtpbDi/GAsM
 5Q5d1HamL52CjM35vUZ2+/TkxSN9tO/4Vz9EN3A8Nd03xAYt3qLHf9XNkKwLFazHAiRf
 uk+RWzRuDKV3L4Fip3I2gsPVKP3YKVTUtSXWGWmEWgdhMwfoQvtw2+WP8ZlBF676yyMA
 KRxvTtpgfX8eUFvn/sSC6XCfJog1OwRd5rYcRNV64QgWyE5su7PZSysiOAHhS8EOFUZq
 R7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvhBA8oTL++DdjiSM8rBky66zXbcD0SxfG+dUi5LkoMqskm55FoM5obk3mH5NqAmZIYfxuyYHfYEUm@nongnu.org
X-Gm-Message-State: AOJu0Yw518b7TguCItqYWZ/P1Tdx9eF4Qln43o5+dYqOEwlW9W4AEcE0
 LvF8Kk5or2lMf921Bo3DBDtFaUQ7JLic9Fl9AtD5KfL2BUjxhefRLuqwSx4hsgTQDJALMSCDB8w
 We9IBCO9ssy/Bd3AZTTz0I5B4jajeTRAiuPaMUt7dQ7FcJi9t3RqsPDTr
X-Gm-Gg: ATEYQzy4oGk0GVhqu5mIIrxNpzCq7XMrHzT/Fym8ET1vMgR17/3Xc3sLsKunJzW6KAC
 T8O88nsmRgSbThVTWa/HOpn+PKWpzIOJ+9oywereO0OXjCAX0cWVmleMC9R0vLJva2En05gXleI
 She6D4/+O+gjcRO/KNCA093pNQ80ifpimFC3+66L0HpwAWNy52H/CBj22xAyHks52cx5Vhurd+c
 vIp0pQ9G6r4d1nf1ZlLNaJHDAnHuGeMV7/ZSHPSYVXgh10RY5MC/hVtwaqzWUVXA4po26cdGMy4
 XOpkAO128VxlqJu2gP6dZ3zsxe40wUt4/3mlQXnIrTefEdABtL5EDBbl6M3BL3cVAMmy1zF8hmU
 IolV36zPvbildJYUru1inNJI4ekaFD22P+X07r2nYs/rJ0jjGAbJ0zelq0E/8
X-Received: by 2002:a5d:584e:0:b0:43b:495a:a760 with SMTP id
 ffacd0b85a97d-43b527a4af6mr11257299f8f.5.1773909219234; 
 Thu, 19 Mar 2026 01:33:39 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:43b:495a:a760 with SMTP id
 ffacd0b85a97d-43b527a4af6mr11257247f8f.5.1773909218682; 
 Thu, 19 Mar 2026 01:33:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518986fcsm13503461f8f.26.2026.03.19.01.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:33:38 -0700 (PDT)
Message-ID: <24e4d1f4-a51c-40e0-be50-54a561cc1b2b@redhat.com>
Date: Thu, 19 Mar 2026 09:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/vfio: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/18/26 18:47, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.
> 
> v5
> --
> 
> - Fix extra SoB in "hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD"
> - Rebase on top of master and remove pixman/opengl details in commit description
>    since it's now already merged.
> 
> v4
> --
> 
> - rewrite commit description for "hw/vfio: eradicate CONFIG_IOMMU from sources"
> 
> v2 (sent as v3)
> ---------------
> 
> - use global stub_ss (fix some missing dependencies in this case)
> - move kvm_enabled() guard check on function calls
> - s/Vfio spapr kvm/VFIO sPAPR KVM/
> 
> Pierrick Bouvier (8):
>    hw/vfio/listener.c: remove CONFIG_KVM
>    hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>    hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>    hw/vfio: eradicate CONFIG_IOMMU from sources
>    hw/vfio/pci.c: eradicate CONFIG_KVM
>    hw/vfio/ap.c: use full path for target specific header
>    hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>      hw/vfio/kvm-spapr.c
>    hw/vfio: all vfio files can now be common files
> 
>   hw/vfio/kvm-spapr.h          |  12 +++
>   hw/vfio/pci.h                |   2 +
>   target/s390x/kvm/kvm_s390x.h |   2 +-
>   hw/vfio/ap.c                 |  11 +-
>   hw/vfio/ccw.c                |   9 --
>   hw/vfio/helpers.c            | 172 -------------------------------
>   hw/vfio/igd-stubs.c          |  20 ++++
>   hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-spapr.c          |  47 +++++++++
>   hw/vfio/kvm-stubs.c          |  34 +++++++
>   hw/vfio/listener.c           |   4 -
>   hw/vfio/pci-quirks.c         |   5 -
>   hw/vfio/pci.c                |  39 ++-----
>   hw/vfio/spapr.c              |  30 +-----
>   hw/vfio/meson.build          |   6 +-
>   15 files changed, 328 insertions(+), 257 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/igd-stubs.c
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-spapr.c
>   create mode 100644 hw/vfio/kvm-stubs.c
> 



Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


