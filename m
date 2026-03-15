Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0E7D58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fdN-0005cp-8f; Sun, 15 Mar 2026 03:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fdK-0005cG-9J
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:11:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fdI-0000zT-LZ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:11:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a9296b3926so27881345ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558687; x=1774163487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9zL2+AxFN+vJHzIv/MVf0iX0GSGp3d9WWTGLq7fN3y4=;
 b=bPnIrKHJmfr26uFf1SfI45ycy9EzXP5zMBJ3SM5rNnkwco2VkRdUGaOwkElUiV+8/x
 v+KOdAHSu/m/xIvxnALckogDuBYWyCtUlgAZVF26i2HIJJSI+Itz4r5QVffgk9QyGQEg
 Z8mlv1CrwqQKv2dvrMPYI/scE53olK5O9/uCvzTnre+WgqdmQ0g7/yNcfggcaZxgmwoh
 cwS92qn+cbBLrSvRo8oUprs4SuBha46SHcU1AMlBUr7EsnpWZNDoN3JwRuunWIK2F31d
 QMzf69Wd4qByqRPXTuuXXIS2BfXzRbtaB4fMWvjkIc3H0EbXJsWkroVsksker6cQU1TO
 WI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558687; x=1774163487;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zL2+AxFN+vJHzIv/MVf0iX0GSGp3d9WWTGLq7fN3y4=;
 b=bhnrJx1wsv+oIb26wDWYbYQIaDuqSbeUim6OIqHmQa6U/FaaIrJq1hbkMFXQvSg7Oi
 PN9GYhlqF4Ps3TE3fnVkwWDj6K0rol/CEbVyKTdKrgqECDpzqnqfMFgCCVCf4AI4uw3P
 rdCOn30pQsN09lFt8AzuIO/meVJ1dblAymq434rJDWQ8pWzYITSE7WHP8u4z56qoOZGB
 u61sXMrU9bjBlMOdoIUz8rmefE5ZJmb4USTPHGW8wD6GXcBGAI692rN2UKKE6cK3w/EA
 hEnD2gPYz3Qpq5TQB+w0sPtZ9turdnf99/GpyO0Z8HWFbLGMEdqJUDtUMYls81DI0Rxk
 gGXw==
X-Gm-Message-State: AOJu0YwEOA9rBOv1eV7cGcW1mgyLIGEKjFXx5xzm5yJefT+wzREKbfcZ
 vm+snqgNBo6X7odWLh+fP/ExkidqvEIF44RdpV4OysgZAhms097yLrDFZBErWQf8NAR3hbHpHHT
 GFPLIEBw=
X-Gm-Gg: ATEYQzzxmG3aYBOTmIUOWNBCh17SesHzWnvP9W7D153eXRCOS5+WytrQ3HrdVa3ClHs
 fny2qTSWSgx4v80JrOk82UN7SlxSuD/GAGfUof7ojlXoiAftmuDo6WYFQd95QMW3fFWSa87y9aq
 1yTW2gB0zf5tcdGTA4QBP1bTbprxF61GvWpXSGKSAp4G3F5D774cGgVdQ7wLrfgMkIxN/XVJW+X
 jILsAfwTjMlaNRpu2yWWAE3qltrIJqivBnV8t2u3uqHBSaLFTnLe2n9tRinJhEB0jVNW/SD2Vg8
 WKQUpb2GmuzBmIIRtDXw92CKDIiS+KaLK99VYJrWeHyH4SWBD0oOLRRUXBkOKF/bDDrby9DHAuo
 LT4pfONH7WzpHSL+YHPkDTePmDICCbnRp47OI0mmAjA2pegZoQ1shKN7svCdvYEC8nA/JbA5Lgx
 rsthejf9/6xutmKvxy9XzqP8tldv53/UTxFt8MO1qDM8braWzP51PQUKNCA6tMMjFrReM=
X-Received: by 2002:a17:903:230f:b0:2a7:62d6:d049 with SMTP id
 d9443c01a7336-2aeca967e70mr97758175ad.8.1773558686525; 
 Sun, 15 Mar 2026 00:11:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0537ca58dsm6231665ad.49.2026.03.15.00.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 00:11:26 -0700 (PDT)
Message-ID: <7f5694ea-948e-4a67-b4b5-b8828ee082ce@linaro.org>
Date: Sun, 15 Mar 2026 00:11:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/vfio: single-binary
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/12/26 3:44 PM, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.
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
>   target/s390x/kvm/kvm_s390x.h |   2 +-
>   hw/vfio/ap.c                 |  11 +-
>   hw/vfio/ccw.c                |   9 --
>   hw/vfio/helpers.c            | 172 -------------------------------
>   hw/vfio/igd-stubs.c          |  20 ++++
>   hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-spapr.c          |  47 +++++++++
>   hw/vfio/kvm-stubs.c          |  35 +++++++
>   hw/vfio/listener.c           |   4 -
>   hw/vfio/pci-quirks.c         |   5 -
>   hw/vfio/pci.c                |  37 +++----
>   hw/vfio/spapr.c              |  30 +-----
>   hw/vfio/meson.build          |   8 +-
>   14 files changed, 331 insertions(+), 253 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/igd-stubs.c
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-spapr.c
>   create mode 100644 hw/vfio/kvm-stubs.c
> 

sent v2 (that turned into v3 when sending):
https://lore.kernel.org/qemu-devel/20260315070834.198331-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

