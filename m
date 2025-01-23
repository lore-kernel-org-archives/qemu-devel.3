Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFB7C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 22:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5OC-0000Eg-SC; Thu, 23 Jan 2025 17:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5O2-0000E6-E4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 17:09:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Ny-00055E-GQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 17:09:16 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436341f575fso15562855e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737670151; x=1738274951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=toakulm61GOmz1C+G6Cl0lHLUwBaHc7++f3+BYu1QlE=;
 b=v/Ya+V4gLFJtMjmS9jHPOSsNJaAmfm0THYg8muOaZqHHSa7p4YcIjvjc3w8ovxwp9A
 HHFpjSs2h+zjT5v/RXGyL54suh70LT9gniO/2AUP8tRnTrgKrTeXinZxqX2uqjdHKyv/
 hUYzy/YHqHvvQFPFD7Wzm9Xcd3WldGQZrQq+/vom0UrwzB71x7Lt08oriRbKo7PpmWD5
 Ufgi96fo1H11tde/hQBMhKWsa6SUiU5sH63LBVsdb2DncRNvXcnX7w59i3Y8GpnnEf5E
 hEQsUj4ut2lFM6sb3MNtVjLara3jYhkTFeT72DTrQAx8yYCh/UbapN1L5Pf8Tq5RB3NL
 AfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670151; x=1738274951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=toakulm61GOmz1C+G6Cl0lHLUwBaHc7++f3+BYu1QlE=;
 b=v6usjSCJ/k03qGwTTmXJxLeC1HF+B9fX+N/uEbKTvms9vnqJsoqWP/EGM2ytNexMML
 UyKZD07mXYV1MeScBdq0M5udUp579mvV0nAkc29ktjQ7CSsFdeG6KayZdDByNTfDDjEd
 6X66iKtUl/dDMjSDLWIOxzdq932aowN1YKUD10NJ84tkpc3UZcfJlnaER7ABTokL6AUz
 8QkKolfs2Qoobw+/fKN1AN8ASg7fSTyovaMMP0NgUmmQmSzV6/Olklg1J5zqEgqWUKiB
 M4v0nhVt9t/eR34Vwvd5CWJDNMMailemh+oLunzIQ2xQ11B2UlnSNVMHGs8ZKb1jMYYJ
 ZDVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKdmndVHE4evRzL2tVRpITS2WIDIAZnKRzR3U+hUYaF8Sb0OxrKsxcJ8RL2+xC9u5OeoJHbpnU01Yz@nongnu.org
X-Gm-Message-State: AOJu0Yx/xZykNsAAE8gu0nHjy9wF+DFyyAuHUfdr5/9RvZLHyIVooD/k
 V4n6//3ZAVcl1vuKd+buw9YEv+JDM3Wig0U5HX85zGtfb7I0kTdzcknROd3rOzw=
X-Gm-Gg: ASbGncu1nDXkNTpMHTjV62e5COkgnsBNW+mA8Kk6ioQoM+1mC0GfTXU09Y4Q1HW3fV2
 gVsrZ4kYM6kTcET7v5Ll9k8v9mDezGGGIvjzszMElYhuRzPB2cfXv2JjP9FUdD1IsCOd+7YC3kG
 Nt9YFI+uqBe5uHjB2p1a7WBWH0SGqG0sZYLWc9N6iIAZpa8pdJKBQDJ1fCZaEcxZKlhhrJslyFw
 3M15dZqiYbkGPZ7piOmItZpzVkukYgMCG08tfiF+nxC+bfD/Gh8EKyX9y8Tzp+u3z5EcIkjMScP
 3djb9fgEWh9KiAZYO6yQY1KnRkaq3y0bRBj89OluakISm/Oe
X-Google-Smtp-Source: AGHT+IEgwNfyFVjEC06KcZmhd6zPizj/s2bcBB/LXfAVoz5OCX6vwrl1aCd/u/Q+2V/mR9EvdYJ0Tg==
X-Received: by 2002:a5d:47a3:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38bf5649664mr25655957f8f.5.1737670150778; 
 Thu, 23 Jan 2025 14:09:10 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0ecsm4617695e9.30.2025.01.23.14.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 14:09:10 -0800 (PST)
Message-ID: <afabb48c-2bf9-42dc-9aa9-f4341285ec38@linaro.org>
Date: Thu, 23 Jan 2025 23:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-ehci: Fix debug printf format string
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20250123214831.401B54E601A@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123214831.401B54E601A@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Zoltan,

On 23/1/25 22:48, BALATON Zoltan wrote:
> The variable is uint64_t so needs %ld instead of %d.
> 

Actually the format is PRIu64.

Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/usb/hcd-ehci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 6c4c14c895..23b3e20fdb 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2287,7 +2287,7 @@ static void ehci_work_bh(void *opaque)
>               ehci_update_frindex(ehci, skipped_uframes);
>               ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
>               uframes -= skipped_uframes;
> -            DPRINTF("WARNING - EHCI skipped %d uframes\n", skipped_uframes);
> +            DPRINTF("WARNING - EHCI skipped %ld uframes\n", skipped_uframes);

Should we take the opportunity to convert to warn_report()?

>           }
>   
>           for (i = 0; i < uframes; i++) {


