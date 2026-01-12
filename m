Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1342CCF45D3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfPQr-0002SC-5h; Mon, 12 Jan 2026 16:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPQo-0002Qw-2A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:26:34 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPQm-0007Kv-MA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:26:33 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so725409b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768253191; x=1768857991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0Fnf1Ebxm4+F8ZeH3U8WPfvJmOgzaEH/ZCE02wiDrE=;
 b=hIVSXVyL2gQax2b1XLnhKIevF/Q5ZwkWCDgjbEZbnOW7OBz/Ct6kijRvqpsA/BwHH8
 9ICHCqkrl0PvTI2sH7atENmkIOtRzmhqmYhus0IPKw3ERHZVep0WAtwzx7000HWdckJ2
 S9m0lTSvVw/Q3SOFi/vcl7M5JY6PvPh32cY8uKF6Q98S9YIyg05vky4YPoXuPOGW8mlP
 bisCnuEkSvEmZPPuMZvO3Nx+9/atrdz/qrxl2Venspw1t8dwDw5fP47cUKEPMDM9rEMs
 9gDijX3MN9KpLXxRk9axXJG8VCi7XiiCOSMXWrZUQ7zyYkHklg2nQWCD/FI5rgdAA0PS
 JRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768253191; x=1768857991;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0Fnf1Ebxm4+F8ZeH3U8WPfvJmOgzaEH/ZCE02wiDrE=;
 b=QQH45Mvn7PKEe2FzxBZBMF2CSOO5YA7pVmWbCCtYKK1xyJdE/RoweaDZ58MFOJwEtV
 oDkcsKYoBUblFKxlrWAFHB9SMxSoW1RcTGxk4EKQKr4rTm9oEtk6FCSewyMhYx5BMSuo
 ChhaALGJWHzuaBQlaUmRyyuHH7azolr9mx7T0Nesqjw3sFGkn/tQ04blAxvT406Wx0gt
 1lxHUHCxlw7KZpEzJmtMV7Kk5MXHenPjeCCDob36JQnXaUiZ8OCjy8IYrDQY0I+9YiKK
 0JzmqS0TxPsstRBnhp5lYVj2zGkjeHTKgCFF2jSkJYDZCjuOHzCybcIRrrzQc4FB0FWO
 GHXw==
X-Gm-Message-State: AOJu0YxLyi16FA3x6IdtFJZG45n+30659Rzvm1Qxz17ZMOYbIr12oLCr
 1xrQld/BjENZ3wtQc7PipF1WVwUSuKrhV7X8Ot/qdERevRkgiYamf1seKmzCXVlF6FY=
X-Gm-Gg: AY/fxX5ch7fJ24KLStqZsFdH1BdUuENpp4sD2LWnQMZWFCJxgkrA/bmJukFkJFeI+tS
 9GN0qV0H2HtFzmQoldvopJQYy9wVddqZIqdeLAQWwVr9ryYnmJ2JoyPv3F9P2tIc4QA9sNU67id
 xvZzxHXh5IB+hazOQlBfN5jO82mJFSyoG32Wkue5AMc30ZCdK9GehUmzsYQkUeS4I6UaPX22owJ
 RZKrEXrHGAL/wV/cKP8N9t8BpHTCu77HLDbZkFqFTDto2TBKQq3zzHFNYS5mlICvEsdklGMfYca
 f4BDFM4C78deHf+XyqQ046bkHrWEz9XWsX1eaNR6m6Si3+Sbx1Dtud96D0rbOgQz1ZD++vGKigk
 Gr/qDRGcV5iy/Ob+Ie19/QC70OyOmanGrOhlZ0XSQZN/Y0+r1vN/EJ4fOJBKOVrLbymKuC5qE9/
 3tBKwxT74dCS6evsf20L1ER0c5VUBc+zWoE02SkA==
X-Google-Smtp-Source: AGHT+IEauoiZGADlvt4KYwdH7hDjViWSWOuvgT0Djzq37euAtyHk7j+42ID+dgGv9PFJ4xf+Tq/Y9A==
X-Received: by 2002:a05:6a20:16a5:b0:38b:d93f:b78e with SMTP id
 adf61e73a8af0-38bd93fc023mr435944637.13.1768253190967; 
 Mon, 12 Jan 2026 13:26:30 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f6d3sm18150516a12.9.2026.01.12.13.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 13:26:30 -0800 (PST)
Message-ID: <5583ceb6-31dc-4a0d-b291-f4eb7ada2cef@linaro.org>
Date: Tue, 13 Jan 2026 08:26:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20251229231546.50604-1-philmd@linaro.org>
 <20251229231546.50604-2-philmd@linaro.org> <87v7hcd0i8.fsf@pond.sub.org>
 <f904ee62-3cc2-4657-bb09-71e933df9092@linaro.org>
 <87h5sribl9.fsf@pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87h5sribl9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/12/26 17:33, Markus Armbruster wrote:
>>> Pardon my ignorant question: is HWADDR_PRIx appropriate for vaddr?
>>
>> The print argument is gpa + offset, and hpa is hwaddr.
> 
> So, hwaddr must be at least as wide as vaddr?
> 

They're both uint64_t, always, just with different names.


r~

