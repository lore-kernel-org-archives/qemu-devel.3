Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF410775FD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2v3i-0006Qf-VG; Wed, 18 Mar 2026 13:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2v3h-0006QO-6R
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:51:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2v3f-0006X7-3u
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:51:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82985f42664so159753b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856309; x=1774461109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D8VwQsjTlJDi5ucgxTXX6mOVHw9bDdMkxIxuW3l8Uf8=;
 b=XmBLh9TT1FD1OV6HFqnK3FaS/UcaIfGLPhxx66764o3YMczdZODMQLpGOsiKEEgYYt
 XT5DUjr1AWvShaSdLtkX0/vUgY5w99qpJ/XWBy8BBE6Dsz5vzBNuNbXZFG3py2gerLic
 YJknfFlAmEyN+oAYwsx1ufOyaYYYalPlW+iddr/9yEurLRmribckgQaQF3lKdYIk7fQF
 aNU28KyCJCSdY8stlv3WedqwmJ2gnShOuMftE2JaRAlv5xP6DoNw/SyHiGkC2RHF3J4L
 wU8QeJ1GDQNciK3+UfKFVnSnwK8E7I1c+fmCUE1Z8T4z09jeKUlsnz0bclFgNGcdEio8
 /iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856309; x=1774461109;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D8VwQsjTlJDi5ucgxTXX6mOVHw9bDdMkxIxuW3l8Uf8=;
 b=oUQZhErtYLTwFoP+PGo8NKQjmVRfTbhXcIz/QijiQMCTMvHHziMd+ELomRj2ardWGR
 RU3mL5ZjUsidOVVOMLOVIrdPOtQOvISxr7f9KmXl08qGdjQBF4lptIvwTp3fph9kVRPB
 iLgUezKhkeg/I2u0IT6zOwYzM8VlvYfQ/YKKn7G1sKA8UMfbNooz8D2ONmgbLWDvR4Dd
 KDTmQeD1YODg0JV7XjpyK+8CpU+bfuTjf9HLuUhjFU1XBEr6G0yjXIaJFzn9JM2jpApC
 KbselnRDsvlF7teMoD9waQOAoU7OtsFd2llEEsbZyvcTOl1ALPbX2JXcwmH8/eIdQ7zr
 zw5w==
X-Gm-Message-State: AOJu0YyF5ffCNEJbxhC1Gis4Yt/Qc8lRRqCMFe/zk30aM5h7ID5Xc6nU
 yE8v0c2jduCImg1cabJOzOrw72wR28RulXLMU/ekiZDlOYXdsxcA8xgANV6fRxhbxNZNcL6XXRU
 5olifSJ0=
X-Gm-Gg: ATEYQzz3N72dSsTrXbXxA/LTC2Vnj3TslP9RrTaSj3YBPqYhwBuMQwUdnt9GuvlfXo+
 90IvsZz4QUWc1pC8iw+jrxEJS9iIJOPE4/GgraBeHI8xGEZNfP9k1JFCdjoxk8dC5o6a0pERJH9
 Qlm0pA/UlPTZ7Evj3TDNQ5zVOhAz8GfaUjFxCr9EDt5ztDfbNQFKX+ZYAxwRZgwBRAx7XT6s9Sj
 AKz+iOTUh7GnMKDS9MwajZFHYg+pEw0sX0O3PqEaudMlJJPsWRDkL8CMqo4LRCPevIEYm00wfdu
 oN6rZV545PMBktMgUcJQeq7FSsYx/wjWpirfKglpiqnogUP1+ILmx8K+EyNnXAAMdzHh60tDWpE
 fHAJK0mR44088OWJmBqP52dcYhx2dpbkzczX1OCT+TAh4r9udpChr1EsOoXhKdhJ2D4NAA3zcsk
 u9A2v0mGn40XIskLNil+RpGrzHZx5Od2Mga3ERntvmqTCjBByMk4tkvh2MXvH97ZFdh8wQ
X-Received: by 2002:a05:6a00:1808:b0:82a:ea3:c16f with SMTP id
 d2e1a72fcca58-82a6aed0719mr3898988b3a.53.1773856309300; 
 Wed, 18 Mar 2026 10:51:49 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b565930sm3341132b3a.14.2026.03.18.10.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 10:51:48 -0700 (PDT)
Message-ID: <8bd16969-9102-4d0c-8006-42d1251e14cb@linaro.org>
Date: Wed, 18 Mar 2026 10:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] hw/vfio: single-binary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/17/26 12:42 PM, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.
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
>   meson.build                  |   2 +-
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
>   16 files changed, 329 insertions(+), 258 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/igd-stubs.c
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-spapr.c
>   create mode 100644 hw/vfio/kvm-stubs.c
> 

Sent v5, with commit description fix and rebase on top of master:
https://lore.kernel.org/qemu-devel/20260318174733.1717643-1-pierrick.bouvier@linaro.org/T/#t

@Cédric, this should give you a clean series to apply when the tree will 
reopen.

Thanks,
Pierrick

