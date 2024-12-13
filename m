Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A15E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM700-00081k-86; Fri, 13 Dec 2024 09:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6zy-00081a-JN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:50:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6zx-0008Ea-35
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:50:34 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1368283f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734101431; x=1734706231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sQ27rwZAwst3GnfeSiFl0+1qiKo6UHcWiuA7e8DHk+g=;
 b=O1EmWlGMFCHdiVSwaP7QPeooWS+EhDPJmxwqyguz8SsPsu5G5cAJNT6oYTxyDI8kyi
 1ohGI5ObhOL/4uNtF+QikAPJhBOkfnY28EeZSaFatYlymA+ubwyLjn3V+CoDuJkSU+cO
 qgT2VZnYbZVl5wUwiww+sGNhBFQNQkwFbyjK8szo4EVSWG1HFrBMl+pc0MjDM/FBemL0
 f+nUTl9adfHiUe5+UyHckcRP8qGUbe1ZbIIKzCTtMiDP7TwPpoO7woY8RV7wWF9RoN2x
 zZB5O0b0C53tgRFjqs03sYaKExibn0f4+XV+bh4iLMyLWAmmWMCzQAVAK/7M7JB59oQe
 mYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734101431; x=1734706231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQ27rwZAwst3GnfeSiFl0+1qiKo6UHcWiuA7e8DHk+g=;
 b=PuxQulDnYzpWN6rh0GIyNHm08wl/xVLIW2K8RZukeO4I8FpDvIhd7dWXDOwtWaTR+z
 9nJW6a97EuqgVot1EAU0Aow+dMG06Z4aB5ybJ2JpzGIWwN2mZ2SC2+WhYc1Rv8hwZm0l
 oRLZpacHpnvVgDrOCODFsL9LTN7/mDlWQapzMR2UwyIbbF7flKwuPDmpsABeU0BZqIYk
 8Gl+axSI446j9OgmVoZGEknOpFjimVBJ5YVuD81a+aPQWmXivlDJ/Gk0fMMhLYj0qegR
 KOEtlid2qb4uVLpfusXODv0N+v2cs1gcPB10+jVV5EdUvTZLhlCXzA0yivcMxEQQu0Mq
 vfYw==
X-Gm-Message-State: AOJu0Ywpju8Jc6rL7wWiylcyYEdCwhuzfj6N0U0oafyl8Iyz2I51KBNu
 2CeGWuF43TJRDIV53HYnH7LSw8L4itHxmLYQdB4+oEKeCgfsnBvKPF5rkq3PV/TIEGl/L6zB1JC
 /
X-Gm-Gg: ASbGnctBbouSavo5rsBuo0REH8B/tMt+3rp/HWis3/KrVJyY8BRbEYJzinGkn3b3sWT
 JrotKDBlfIM8s2GGahDE91uqGdknWCG02bBknOh5+m82bWYd5rejtj3eYly0zT3kHdCaOsCzkPn
 pnHkAp6yTrC/N+QcJ9Fkrj4j2Lr9ERKj7AeNmqZA+U9mjyrigDS0Zq9BVVg3wnz2zScpO7tZMSB
 lzl4wdbtFONuyMPL9rE0T7O4iGqBoh4bie9FnKwkDZTykJfIxzSBiB4bTWhQZapEzd1OxjP/Tn3
 DMMNrXRS1I252npVdksRrjvLqMkWwg==
X-Google-Smtp-Source: AGHT+IHCIa9RkZGALVeg8w67ZU8SuPAbs25Tn9aZqdUvIoi/r7N5oZf8yJTMUIilSgmyHsrXUh9THA==
X-Received: by 2002:a5d:584b:0:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-38880adb122mr2316893f8f.35.1734101430910; 
 Fri, 13 Dec 2024 06:50:30 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c1ccsm7460861f8f.88.2024.12.13.06.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:50:30 -0800 (PST)
Message-ID: <6fdd8261-6f7b-45d3-9360-fc7b06bb6afe@linaro.org>
Date: Fri, 13 Dec 2024 15:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci-nec: Remove unused XHCINecState::flags
 field
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20241127122812.89487-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241127122812.89487-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 27/11/24 13:28, Philippe Mathieu-Daudé wrote:
> Commit b9599519a01 ("hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST
> flag") remove the last use of XHCINecState::flags but neglected
> to remove it; do that now.
> 
> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/usb/hcd-xhci-nec.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Patch queued.

