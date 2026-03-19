Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631E1091916
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KEN-0001v0-IM; Thu, 19 Mar 2026 16:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KEM-0001ur-La
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:44:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KEL-0001jk-3M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:44:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-829ac8d56c5so1047395b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953071; x=1774557871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSlTmCdvPiWnlSY3Nn9dcgExUE6PK8A1+laEVxu2EnM=;
 b=HCD180sBTI+lD/F+oBh5ZoL6/B3egcisyckRlg2ZnTNRaXgQtKpPaP4hZDDCUwYQqa
 C/Q/oKskW1u3DvpPTTwGchVeTXN4xevrh07sirMA8xD0gZ6maopWdk0oYvG8K42pxn3e
 WnuhkptKvxhwa9fw+jE5OtfNzNWM9yWxoeqaNaIm0mElUSNDDNXNH0zn4AnacUQoBVcf
 RAWJ7l0B/4hDWdHCFoMBc5wl07g3mvc0MUuCO6nEEcOKV78SpQ+aov37CGcXaGLGTACA
 qXk6UHCxfynsoPv6Wjherp8QpPU903xwH3+GBSfTQ2dFvK6u8A0Fc8GbJhspGVQ2c8rG
 jYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953071; x=1774557871;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSlTmCdvPiWnlSY3Nn9dcgExUE6PK8A1+laEVxu2EnM=;
 b=m7peAK70ElenHQ7SZ2fLdMhkTm27tlkNJHiJRaINNXcFt1nkfOMt89AsA+VGIqE8nf
 T+BUanqvmsJqXyPOqmvT8h9EBYbTmd6nJ6kA1WfGQJPWwaexOT/PGJWGLVO4IW2J1dkg
 QC0t5EnkXYLxAWaIaB7wR2T17VuGEeecyuW+EKv3OW1pQGum3OmeJ+7MWxdHJbsvoJfc
 oPwXEBQ0H+i0YFa0f549d/gwFIYlqt0liaWnQRdwRNk2ZJxWB0Hpv8D8L5X6vOTMAsxw
 12Vgk2vAHhmhCX/vnk8cOVcMn3X2YbgALNivQRH1eL0zLG96xTvwYK/ElSmgpo7SLUca
 +wGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Z0zYAG4/8t+hY7wafWaqYmNryqgJvKoV18R5GCLFobAh07jvtYQpNzPjEWPZl9dQZNGV5PtvRAYf@nongnu.org
X-Gm-Message-State: AOJu0YyjLJO3aWzsSo/ro0zY431VRr7QUDlONKlWqezFklwpWkGfdNky
 8QqHVotywykaO0WWyOYpleqK3M/eFb7XFgyOUoeMKO3kR2FWI5ze4XRuGPvY5x9mU9I=
X-Gm-Gg: ATEYQzzyeBlE1B/1GnUAxOfAPIRyRFu4APyYCvnCLiiZlxGrTm33J8/eDatGywbyeYx
 /ObKqlpbOzJbZlxp5bGom8Xxcb1ca4BK6O90SJBb2LXJCPzjKPOX+s/Ri8YejYuV/AW2Gj+zz9E
 DDSI5GGgw6rDXK/0BLzyPl+ho6kAOfnRfjWCj26AMJVWTVvqkIVvQ6jevoutmTJRINtA4UJHJ2R
 2vibfVzFRLOb+fm+zsaSLNIe5LsKruLA8GcxiloVidUxLLeks7EhECcm9snP7rc0mMJsHqmfhF+
 tdW+k9d6pvvpEiSlDxNza613NHzNOzg23DaNtQBEIO5BOFjbwic3bJi7lvFyX4HeDgjKUfmLSri
 YC3Ny3I1Hjufe6+EAOKuBnqJdfYf0+dAyBMtIGuIOb7cbpTDd7muHsDWAGyiNoJHCRkSxiBgwNB
 U/g5GvvjaA/qQ3CT/kWAlZdBrZyWLZ2J3WIcBxLKIYjfAeOtUcYjVmQkH+5NI36aTQbXqb
X-Received: by 2002:a05:6a00:198d:b0:828:f1d9:22cc with SMTP id
 d2e1a72fcca58-82a8c234f59mr495768b3a.20.1773953071234; 
 Thu, 19 Mar 2026 13:44:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03aa9619sm99129b3a.6.2026.03.19.13.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 13:44:30 -0700 (PDT)
Message-ID: <87fff3a3-5025-4640-a163-43efa1c394d2@linaro.org>
Date: Thu, 19 Mar 2026 13:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 0/8] system/memory: Constify various
 AddressSpace/MemoryRegionCache arguments
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260319191017.12636-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/19/26 12:10 PM, Philippe Mathieu-Daudé wrote:
> When structures are only accessed read-only, it is safer to mark
> them const to protect against invalid API (ab)uses. This is also
> an useful hint to compilers.
> 
> Philippe Mathieu-Daudé (8):
>    system/memory: Constify various AddressSpace arguments (flatview)
>    system/memory: Constify various AddressSpace arguments (checks)
>    system/memory: Constify various AddressSpace arguments (xlat)
>    system/memory: Constify various AddressSpace arguments (flat-range)
>    system/memory: Constify various AddressSpace arguments (notify)
>    system/memory: Constify various AddressSpace arguments (cache)
>    system/memory: Constify various AddressSpace arguments (access)
>    system/memory: Constify various MemoryRegionCache arguments
> 
>   include/system/memory.h                 | 32 +++++++++---------
>   include/system/memory_cached.h          | 20 +++++------
>   system/memory-internal.h                |  5 +--
>   include/system/memory_ldst_cached.h.inc | 15 +++++----
>   system/memory.c                         | 18 +++++-----
>   system/physmem.c                        | 44 ++++++++++++++-----------
>   6 files changed, 73 insertions(+), 61 deletions(-)
> 

Series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


