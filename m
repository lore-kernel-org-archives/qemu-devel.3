Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF99C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGYG-0004zv-3F; Wed, 31 Jul 2024 17:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGYE-0004uJ-Tx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:08:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGYD-0001fS-3L
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:08:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so40997555e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722460079; x=1723064879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0A+P3SmHdS/9j6MmMFPW42jch3drvq8aoahoIRsD9l4=;
 b=l5RUpdDHxQqIGrARSnY6y+A7VtuIyi1PQ+OnHAfELhzdSwVNcJra7tj3L6h/OdB4Sk
 LMgraPcMNq9ik9hDoavHhDd8mR59mYrIv+kqG4/8htWgJJqLHP1hjzfyoHJDGBQbZI1Z
 +AphcDv8YPbs/CSWz14codsyzVO2CAHyqGEh9lg3rqFs+/O96HjC1tWAExE0a7X7U3LH
 3F+THHXqY5Ad9Ium5ot2QKw1ztW8QpcMA4c3m8AesQZUgOhRWzd8D48V6LVmi7xL6qnb
 r/3AHwuVv+l2gGG9kgEc5XGl5uv5fjRZ5nvJo1EyE/YQgdDc1h1D4XAPR8DNb43aoTpy
 qpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722460079; x=1723064879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0A+P3SmHdS/9j6MmMFPW42jch3drvq8aoahoIRsD9l4=;
 b=fp3N/MqItmqqmgn/9Cf4wYhItuPLPszAG8ZX1EMCBg4PHDHYsEVuiY8t7fMs6Yo7Pu
 1g/2418+4eWgiCEFJ1xEPMZS2fQ+tCcI9uZC8Cu68ML8UziUtIQ9T7LkO+xaDD/IXzPA
 9ljj2FRTQPGVLIkqTfqk6lh6XxEtSwV/+2VJOnOVdvPpcBReh8oTaEptEINWYl+ANOgJ
 VdDUWwtr8+tM/2dK+rqdeqrPqj7s8FwHjmS0gKoFex5GTuYu3wHGOOarzrT241qtGtHJ
 6Z9oExCqJmuf6dw+N3GhCFWJrLigOkW9cHxWqh9L4oeaINAt/SqEHbPBVpzcvM/x5ysX
 9oDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfO+psym0o7GNPOGD7h0CbJQJ7f29LNbmAVc219JBchSbFaLmR/v3V11ze+RvMQtq2GzTEvXe7dsNikoaAXQ8sAlw3gsY=
X-Gm-Message-State: AOJu0YyP8zScdv3M5OKpulSJx5AFUlYF+9HCFzHv9xV+jmtDoZbvKFU5
 Ex2Uz51xr09tIqpbIncst3yrF9JXzdNoGACT2ODsEsRnCQuJXEBiYzVMjH4MHTTb8SOqlmGZj3G
 q
X-Google-Smtp-Source: AGHT+IHEALno4qTHubtHn+asuXbvRaR8IR+Mu6ckLs6oqVI/beSP9x20oG+Du5QgLtk6qSnX3xqacQ==
X-Received: by 2002:a05:600c:3ba7:b0:426:593c:935f with SMTP id
 5b1f17b1804b1-428a99dff79mr4133145e9.1.1722460079182; 
 Wed, 31 Jul 2024 14:07:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b5fbb25sm34107125e9.0.2024.07.31.14.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:07:58 -0700 (PDT)
Message-ID: <fe26dcae-7784-4285-89c2-ee27a1de7014@linaro.org>
Date: Wed, 31 Jul 2024 23:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Don't leak memory in
 amdvi_update_iotlb()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240731170019.3590563-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731170019.3590563-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/7/24 19:00, Peter Maydell wrote:
> In amdvi_update_iotlb() we will only put a new entry in the hash
> table if to_cache.perm is not IOMMU_NONE.  However we allocate the
> memory for the new AMDVIIOTLBEntry and for the hash table key
> regardless.  This means that in the IOMMU_NONE case we will leak the
> memory we alloacted.
> 
> Move the allocations into the if() to the point where we know we're
> going to add the item to the hash table.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with 'make check' and 'make check-avocado' only, but the
> bug and fix seem straightforward...
> ---
>   hw/i386/amd_iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


