Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A2E107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15GL-00025K-P7; Fri, 13 Mar 2026 12:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15GI-00024k-NI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:21:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15GD-0007Eu-Ok
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:21:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1008308a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773418871; x=1774023671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wJQLXV0/kls6KGSs1w/JPbtWs+9dcazzYd8dqaI4eDk=;
 b=PNOBOTY/oDBUj+AXUYAuRanEsHYQa69PjPBaQOvRquNwpOoySgy5XUGlPRtcqYxpca
 qZwz9wyX+D2xL0oSP+WExl4x0gy2lIDsQYqqfcfmf3/7nt0kz0Jss2J8pP9xbbuIXAoy
 /AUAYBs0YNXp1cHospggtwZ9dLVFUHYP4+KqKCCBeTw+u6mzE8RI2/qw/jca/FmMsG9j
 opLnmY+/RtfUcU4WWwtsVnbM6vQcriESIr+oabVQxP/lS/Xz50CHusIw23OozAFuh4R+
 VTepDfTF1034NNS3cVS4uLDipJ0XaUmr10CH9vmk92vEV4nify+8j1joq1NKmS/F930w
 edLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773418871; x=1774023671;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJQLXV0/kls6KGSs1w/JPbtWs+9dcazzYd8dqaI4eDk=;
 b=HklT9AEVYuX9ts+ybsZJ9dnS9aBM12puuwTSFqQ+19F6aTvQl3AoRwyRxaE0bUAQFn
 K6nXqY7bUVAr2f9IgO3ppUUKqRELQobgZeBMB6s6Wqja3ueOxI+7B528jekLOs8qMwvJ
 FJQ4EgyrGiaRykuT0b3TIYtCnfAHS/B4J5xq4oxmZCSOCWUgwCicTC9xtITOcX/Y3CPJ
 zh1uj3btjZbAIJ8s3BJlvOwyVsfJYPMcmG8YsMQFmZ3zThbP2y8XnwpGiLRCZv8SfxpF
 deXbDGvDuaAwbLsU8oxbMWpJm/ly2YRXi7lMoUGqFySBdFK7FBUEatct6U/rq68YRAuQ
 cwFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVdkq/SDFdh2vTN8cyrjWPVjG2iqaFDGY98A7Y8FqjiNLU9+EHTNRRVTEbI5+U43YtETGhbLFQwurB@nongnu.org
X-Gm-Message-State: AOJu0YwORCR5vuXWC8qKzBve/8uArAUiIfQeGMYJZRDQF04rjdkCuuEa
 jdFq3ZxeNfev6QC1bzqzoEfuHcTs6GD98zqzGAANzKKaax1bTmNNleVErqJMRcIBYklMoO0jF42
 35LYh13A=
X-Gm-Gg: ATEYQzwO2nTH0C2s7feRFPmN7Yi9FvTQjdV08zG8qsn+twOBnVVIJ+XhQM5trCgep6X
 EChNSNt8PAsnMGGr/2D9HGH0Wfz8HK70t+fgCkbcPTulgAoz2gxDWU7P5AlQQqCHYVS7rCnQE/Q
 xSPuozXu9OlBnjyjybq8QTSnUUBm3VkNRydOy0rHRmXVc3sjtjXXCFiAEgG7rLaSrmSwNqKP1Hj
 nF/DQWO8Vifa0z1ymUKGOrAXYxXafjcHtdiyDdCMbO9aEkEHAV0vUXyjAc4EYqnZASSrwZwt4v2
 HP93RCf1Bf4x4XLfINohlADKsaYC816jdAYgeGiImUIjPO6NWTptNuls/Qg5PHP8qxd+1+VgYqm
 snoVqIv+XkiXCDVSO2AiWrYGxK28YKkN4GHJMGIBuQOfeqXgY0Mu8Y8lYYv6AIjZq1H3yuNctmG
 HD8YG7N7x2ztN4HdRySdFlRxoeIclThEhFOUhH94sWLO0cfrPExSAz2xe2hfA7lgzFDU98
X-Received: by 2002:a17:90b:1b0d:b0:359:8ef8:7a77 with SMTP id
 98e67ed59e1d1-35a21e9856fmr3731369a91.9.1773418870625; 
 Fri, 13 Mar 2026 09:21:10 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24406a1asm2879767a91.0.2026.03.13.09.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:21:10 -0700 (PDT)
Message-ID: <ca606d67-5cc5-4811-bf69-567a16d0b391@linaro.org>
Date: Fri, 13 Mar 2026 09:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/vfio: single-binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <c3e743e7-94da-4395-a757-396aa5d334e5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c3e743e7-94da-4395-a757-396aa5d334e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/12/26 10:32 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> This series makes changes to hw/vfio to compile files only once.
>> Changes are pretty straightforward and are mostly extraction of kvm/other config
>> specific functions to proper files.
>> This is the last hw/* subsystem that needs to be changed for single-binary.
> 
> There is another file in hw/s390x:
> 
> ../../hw/s390x/s390-pci-vfio.c: In function ‘s390_pci_read_base’:
> ../../hw/s390x/s390-pci-vfio.c:153:52: error: ‘TARGET_PAGE_BITS’
> undeclared (first use in this function); did you mean ‘TARGET_LONG_BITS’?
>     153 |         vfio_size = pbdev->iommu->max_dma_limit <<
> TARGET_PAGE_BITS;
>         |                                                    ^~~~~~~~~~~~~~~~
>         |                                                    TARGET_LONG_BITS
> 

Thanks for changing it in your series.

