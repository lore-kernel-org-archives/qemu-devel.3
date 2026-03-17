Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EACFEDA0D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aLh-00024g-3k; Tue, 17 Mar 2026 15:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aLL-0001tL-Be
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:44:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aLJ-0004DG-8k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:44:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso150661b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776679; x=1774381479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrzn/NaXAUAkKILyvixoXIZeYN2/7g25Sn9zh5MyHY4=;
 b=Lde84pPjEqF7BollTE4Lv3Fc5Qg0Uvi9SlVsGQgQq6ocjZMpNv+BRARbouZmWmZQZL
 32NgMgo1yWFyb+AXoKMrcBB/lHcg4hc6K4Zzem/WNgFTX6kFzn2UFdJuplAH1/RiCpR7
 doiQsqIIcGw/HY4p0Vt9IASeT1cxi4TfYVBrqVm5vCdmOGTvmY9T74AFu+Mt522HSPKF
 LgWCBQvVD56C0kOuP3JA567ADPTqxZGwyrNAjH3WEs3LT40VPcV2rTf56IzK6SZ5R6WC
 qUm+KBYGwW5RJIqvNvIVO6/kVt87Vsqap9tTeowj9+EduovCEfOBQ4ikt0vJfl7HQ17+
 5Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776679; x=1774381479;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qrzn/NaXAUAkKILyvixoXIZeYN2/7g25Sn9zh5MyHY4=;
 b=qu/26p8YXI5mSRLqMIqi9jIuWcuneFRELEOIE90ve8bKHojQQ9HhMwOgisRs1aQabw
 8OAcEI9XKfJtlIfaYFjvhJcCh+46aW4CzZr+zPKMjkogmFwHMdCht3t0FKgUorpdD+8Q
 Wq19ziZvzK43Tjq7aFuEhEzi0Wf3A/PsaAOLBA+JjR6MiwtsFrxK2FczKeAzTRDnv0wL
 G1ikT5IV038IA60LVR5xQQWK+dGlo9pHPE0kMN31u5xjKINm1a/mV1nPjGU2H+2qW9QN
 XgVRqkCQNfqQA5yii7L7gLpnAXAaXswTJg/9GKYa9EvWLl/7OysxB6vnucURt5WmQuX3
 JpNA==
X-Gm-Message-State: AOJu0YzKb1kPrEBpQszKbmThKQ+OhT+gidEW+1jFEOhdvPNDEoObzPcM
 njaQUieRhPL/ruDqVcIv2oDqkXzTtcOT4JykTuZ+L2wnW0Zvjtpy7zVg59tuNyDiH1CUHBOpgtA
 ohgVh7UI=
X-Gm-Gg: ATEYQzyRgt/L+soUsXFOtFWJNk1dHa/mTBgpTw1JOQwBiy8r2Csb4d+uRCMfexQY5gk
 ppiNEucqfq7/gq1ifTA7OyoiocKgvD5gYVuaAFLVPQEwPFp7AB9BH0i8CbzCNsIVVevNM6761va
 38dE92MmWLemGiqY9JpJOykD92GE7aD3jY8g9uOb8r/hauRPl/WbiT8nAh+SXeLmoGsyw054kVt
 MZy6UjKyzKfcLNFhCcltfelnrBFRDloxPTboDqEcIoB3Eoq+tXe/vkOrL6CBTVw1075sMpXHW59
 YQF/Z56LbxHVRvbqI0Fh+asY2bZF9gu4GQ05J+3AmWEGKn/mUjnHc/0GAt0pYNgHC7utW3dL4vE
 9ZZ3k8wTiEgfq+eeKZ7iUfP2n0vuqHKYe4+fwU0VNJbbPrw0wOlD+kvQZanya9MOlyg8affILTF
 SCWQXHEQ2hF5GmubOLF1QnSS6rG63VSJW+Ez1TT3BZOhQ2L8Gmj+Wt8UTpnGV5jeBWADmk2f3+z
 a1vLM0=
X-Received: by 2002:a05:6a00:2ea8:b0:829:f777:daf1 with SMTP id
 d2e1a72fcca58-82a6a1e5ddamr770965b3a.30.1773776678829; 
 Tue, 17 Mar 2026 12:44:38 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb993asm230818b3a.36.2026.03.17.12.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 12:44:38 -0700 (PDT)
Message-ID: <e8d71443-25f0-4fbe-a1b7-906b3ba7564b@linaro.org>
Date: Tue, 17 Mar 2026 12:44:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] hw/vfio: single-binary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 eric.auger@redhat.com
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/15/26 12:08 AM, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.
> 
> v2
> --
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

Sent v4:
https://lore.kernel.org/qemu-devel/20260317194241.869568-1-pierrick.bouvier@linaro.org/T/

Regards,
Pierrick

