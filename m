Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C27CEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQEO-0000jw-Dt; Tue, 18 Nov 2025 13:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQEG-0000ib-FG
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:15:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQED-0007NF-FI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:14:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779a637712so24059855e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489695; x=1764094495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fg/GYqzgLZzk92puUiy3bQjDzNjrRN5QklkwllHRiF4=;
 b=bLyg3aVdAvJe4jZLdpoM9m5JNXQdklHq3fyvmboKursz2LukKjM/GYqvOlK8huGot+
 FpW2+QyGHuaCmwRddIvsBGvjrb7HP0Cu2PoWyuKl1tdty63CoDouTwbdaGad2hXavXRD
 KHB93+QuucR36dH+UupFBZQxHvhwTdKLNTcAE+KXzuSHFvU5uggdAgekMTa9hrMqv8Mf
 6Er4qFks0C0IhHk5Xfltky/4zKCQDXjl3zrfCUy3pIhLh15tiMcncsUKXgPP5Xd8yGZI
 hcLj4mr42G2hU0nB4QEhEi81Jhw0al/+sxADebyrYH9jYf7L8/gA9P+nMmf5vuTXgOgX
 MbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489695; x=1764094495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fg/GYqzgLZzk92puUiy3bQjDzNjrRN5QklkwllHRiF4=;
 b=KK376pncvOAfJYYu9u65A3CcbHsR804TVIisZganYXGeAKvPymqcofZmJOv0wO3U+C
 t4feNTlFDiBvpvytBw2dB9gSgtr5wFsVpHCFVP64HreR+QybumnhVMyfqNP5LMUa8C4F
 QDNj5CcyaW2ZlgVYgkLe1Z5M1N81Q0M4Pe8Hcty9RdEIVJaxfKlDCD+X9Wvzn/dN22Nk
 8e1JPvREiEx4imdMoY22W6Lj3x5uof+1lWex+ewbI9aQtGh6dcctpBlBeXzTZutCxCDd
 KzqTR2RcOl1wYBkWx9Fp4fgk2f3cisCy/iE/1I3ku7gChHcAY5Y+jJqXAFefY0UWtDIA
 G5zw==
X-Gm-Message-State: AOJu0YyiDHLc7Pkw2rf33XzXhy/qhuk6tZghk0qrkRdK2s9JLuMeL/Aa
 U70+84VunJYo9CNVPzhN9UaxorgqG2/5D3h/hE52F0WEb58EqdWQSwstTaEaZFeoMrRDfrysq5V
 UQI3Y38R6yQ==
X-Gm-Gg: ASbGncsDmDGB7wv4AkPmM6uybYMdgbQT1BFVPdnL3WlPmQlenLoHO9Z+3Rirbx2tJIU
 PMeDZcSvIsVeJEmHrTnlDYO4Y6TT+QXhBSKht/bP8578vlqGBl2NrjEQR21Kzg++haH/prqcqdu
 IZCivMax1c4yWt1p/nYGtumfA25h3c343PtyAxseUM9rVIKFLFdRgHzn+svFxyAMOALUSXS7ggH
 ajLVortvJS+PslO435+5wfQJui43oDPOvIVWbOr1jRQqjZVINAg6qRi2v0MmF3ptY7EPXkE2J98
 auo3XewujOIAoKnsgZHJWXnjk9J5n+i8LlJbhiyt9yF21vQ/oIYGhONCx0xlkOw/5TwvHTp51KR
 wMv2bDAwdZXk62N3y8HtuJeFnDGzpdRFT8C5pF9qL74137bsEfQfXZxx3XYgjMHStOhJ8QGOUR3
 tML9ULYeYW49KnS6brWNfxOQsyLsUbKygxaMNhAWPo8O9+bscEu28z5w==
X-Google-Smtp-Source: AGHT+IFkL0mFz0fiCVFR34JaTZoI0f//4TiRkX1BdtM2YjhaE0cQX/daQbfZNp5QgYFGTJHelWYVCg==
X-Received: by 2002:a05:600c:4f84:b0:477:af07:dd17 with SMTP id
 5b1f17b1804b1-477af07de8dmr19207155e9.24.1763489695512; 
 Tue, 18 Nov 2025 10:14:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b102a3a1sm3391485e9.9.2025.11.18.10.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:14:54 -0800 (PST)
Message-ID: <89eca882-7ab5-42ce-8de9-0324dc934eff@linaro.org>
Date: Tue, 18 Nov 2025 19:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v3 0/2] docs: Update around MIPS/PPC host removal
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
References: <20251117171236.80472-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251117171236.80472-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 17/11/25 18:12, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    docs: Correct release of MIPS deprecations / removals
>    docs: Mention 32-bit PPC host as removed

Series queued, thanks.

