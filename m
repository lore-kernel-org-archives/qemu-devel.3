Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA2EC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfT1-00038Z-Hq; Fri, 07 Mar 2025 16:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfSu-00037w-ES
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:42:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfSs-0000aW-PL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:42:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso14482245e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741383760; x=1741988560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xICXpK4AkzzXp8D95iBIVj3ycydZUIppiKjRCR4yXjU=;
 b=fkKoy6cat2AtothrPCFgWfGEBHZrrAjzQW2QjfHlGBBHPfBg1NtD5GmoS0FJ+WpC+A
 JhnPW6cmx0XO2T9js6orrgcYIt90Xqm5nxP8trKIjboPEIKZ17j4LrueC3/3aUuUYC35
 YwZXV8tzpG/hD9zuVEvdDoO8k2L1mrwbIinHlvgw2W/rhKyz4Yx8gLG8i8FL+Nyfpi8v
 lu5X9L8mhWJx6LPevXewOiMA9u53jG2jI4mNC1tbLuX4RdlActa5YQPDmd5hpZIS1Dlg
 7bz2ewWBXbuHTPjc+vP9IAzgIZK/2IHC7jwYvBUUOdMPLpNXFrOpixMed874Sxj/gvSi
 pHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741383760; x=1741988560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xICXpK4AkzzXp8D95iBIVj3ycydZUIppiKjRCR4yXjU=;
 b=k6RNObNAgTlu5tqFrC2lKhX/7hn8mQgtPpw94cMtb3Xf0pvGsAcFgq0qYlh4CD1HS3
 DYU8BVxCqwPbqtTuH5QWJra5BzmSM8BOAaK6tyu9IR3gZoAHloZ7Hx1HUZzsXdpwRXLD
 Te4kHNuW4ra5DHJVDHmIsY+ewGpyWm+QUs+4/4y4sDYgV6YUr4nghKltDuNMt/WwCIU8
 4bAyT9Ys27DyhQ5hmfw6aq5JdmoDigb0rXpLSiu313MKH17/o7ztPDrYAoEX1PdBoyK0
 vwgs/5d4h9LK6hf+HIsqvtmfoBJ/yqPUwOx/48KEba/+5N6fT2VsD1YXYwJd1Zl5ZjwN
 PU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4t/rHQMkmbJ0v0rg6s8vB9TIWVv1Uk46EqAhyDNSFeDaC8eMwSVtQPv0GNrms5N/r4cvHknf6vX/G@nongnu.org
X-Gm-Message-State: AOJu0YzonDRHUoKKsj1lZ9vGWbqf2piuj2Nqu44ANlJLwArG5m7IuGAZ
 KrJohM8+pp6I1RZ8WZ0qSaxDPuAu5CNqfpyDYzrcZXyTIliDTRkUBQQhT4NJ6T8=
X-Gm-Gg: ASbGncvs84vpBgEr0no9PDWdWCLkX3uqZ67S9wvSwBq2z5K481+uBEYBmZkOYxv4WwV
 vL3/Il9PB/GbItkjFz3cZLlEy/3VcA9Bjy4r8P6yAFBmQ8F/09EaoTaakimn7x8cQFXydoOnZyb
 XN3dbR20TN7Y/aOQFG7JXGB+MmYryY2OU66O6+nw+7/GJBruFnAa8zWWbpE5WUPUviEiefZserA
 aJE2FK483Ld6o2GbhIdjAocH1HPBzZ+fSRV/mw17wRDWd5i9xeLZFUBJiSlG9K/fjobHtH7+nPs
 5vgw0hEDkzm/C3YfqF5MuMktjdY5Xld3nEsAXSoH+xWv6SyoM9+Ze3DCXLwb3raYX8OBQO63Ylb
 vgVC0TiTEDN79
X-Google-Smtp-Source: AGHT+IGSums4kvaO8BBe0zXJQaSPxe82Cr8lsvc1thjB8j1A337v8rSoKDhY+g+ZNR46TfFZrp6rIw==
X-Received: by 2002:a05:600c:3b8f:b0:43b:c1ba:2186 with SMTP id
 5b1f17b1804b1-43c5a618f09mr37659015e9.18.1741383760370; 
 Fri, 07 Mar 2025 13:42:40 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da097sm65360615e9.17.2025.03.07.13.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:42:39 -0800 (PST)
Message-ID: <81700a00-f4ae-4eca-8752-b3f46e6adc82@linaro.org>
Date: Fri, 7 Mar 2025 22:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] accel/tcg: Compile more files once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 7/3/25 19:56, Richard Henderson wrote:

> Philippe Mathieu-Daudé (6):
>    exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
>    exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
>    exec: Declare tlb_set_page_with_attrs() in 'exec/cputlb.h'
>    exec: Declare tlb_set_page() in 'exec/cputlb.h'
>    exec: Declare tlb_hit*() in 'exec/cputlb.h'
>    exec: Declare tlb_flush*() in 'exec/cputlb.h'

Thanks for taking these...

I'll rebase my "move that API to softmmu/tlb.h' on top, the
other patches left in my previous series becoming 'move to
softmmu/probe.h'.

