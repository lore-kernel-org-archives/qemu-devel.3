Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC3CFD9E1B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjkP-0004T8-1Z; Thu, 26 Feb 2026 17:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkN-0004SG-36
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:15 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkL-00063z-L3
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso9788705ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144532; x=1772749332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkssKqAeWEfUcLaTJT0ylHvWKLD0qOnmNVd8xO/dwDE=;
 b=kaN0UDxxsfX3YYm0a0+TEFK3tf4EFSuBLGIs+5EUaoFGD6pXEdRAsuhKKiVq+8ZeKj
 Mlwkynrmm02R7VpsT9VUK5uOIFgiIzBcnA3DcftDgq8MEFXmJdVL0KZoz3HfuaaC8La2
 Q0ru7XO6zv8XronM2mdFoGFlw/i25DEnbYoIZq52J9Dq1u3Su5N0tSd+p34ZBs1qtNUd
 pJOLi/e7TQvf55Ws5cnzwY0gqDOwfLku5mjmJjqvIHKCtdoneU/70VniN88a3NZPvKTb
 VMSNMVLKLe0qVBF52/JIO+7LbvH4HbAGRs2lfiyHqnj6BM0L9A0ZiO78Vcg6Ui4hJb4F
 gK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144532; x=1772749332;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wkssKqAeWEfUcLaTJT0ylHvWKLD0qOnmNVd8xO/dwDE=;
 b=nFQof/nKQ7HNkt5CqyMV5qZXcwb676fT963T6CJs3ggxnkibQBqTHB411mYWL4H5Zm
 8KiVHfEJ8XDqrvdsfj+9dO+YpN6SHaUQf+s6qdZ80KzwmT5w4bDxvm71UBTkcCMNqRhG
 ud7PcJgGAwAii3GD1NTMjrqweWCAgUfQjarBnXrxDQ7mdRkiMMF4a2ji9URV8d0lOo0R
 f5cNm67rih2jM2wK6cStv7adbFfugJAe158NIwbiWsyLZ3d+iuFzzKQhi5H8zxFbkjJX
 rmcjuUSKFnh6gA+WYWrWwR8MUCF3SNziC8R+udL/BwpGXBL6wHTEvuYN0pgvg/uI2wjz
 ONOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbPurRaZvrsLXbohdeceikd4EVRfEKa4xyQf/hZN7KZqX/c4s0P2Ww77PwvKof7eXJTjq0oxiE98bh@nongnu.org
X-Gm-Message-State: AOJu0YzH38gguqUvZPm3d4PhcnHvMm4O9TT7i5I7XB7cTMxbprqwu3sy
 7aOdfIueroZs8+2QPNr6U7Gctc5cMZaewOQt6Se7Uua/q6CR1aLk2XfacXrbRMerkXs=
X-Gm-Gg: ATEYQzxVwOxsAQTz4fnKh5+qS9rPCNom2t61L6v4ffHXtneGls810rrmy8ToJ7v7puy
 I45rZ2VW2b6DgTNuri7rGFFqxz9wkZczP7V9cFIgOYmaghmg/GDVjUGmtYtILU/EwZgUWqcbJKT
 Gvh/DkZ38gMdCuOCGlZ61bNwhZqMhqvrAGSipnz5+n9CHALlKEV40MEC2GHzq7pT5WzCoobmK4t
 cX/S4l0hEaZ4Zb7m6qoQwNyDCOVSlVaPyq5357qbKw2UOECv8myETKyYgp+kn1INF8bCTFtavPm
 8VYMatgOFK02JpjRsbfQqyIX3iw7aWyGdf10XNpaJMf4GnRlQrVKxC3SfmULAAypBj8LN2zqQll
 Uj7mFe7cCbKfwF1B0xSiPjkUlpSBRgphbS2ka+ThvbtC3HQVsApmNuUxe6ZyUrI2PDJDauX7dtm
 4TmBw9XCOUopclhkiayuaesoc2/XAV5flznuugoTFD7KgdjOSDr5MjeX6JDWeQ/m2euhF1
X-Received: by 2002:a17:902:da8f:b0:2ad:6e26:abbb with SMTP id
 d9443c01a7336-2ae2e4f7481mr4700095ad.54.1772144531924; 
 Thu, 26 Feb 2026 14:22:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6f2495sm51534305ad.85.2026.02.26.14.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:22:11 -0800 (PST)
Message-ID: <e7d228c5-2200-4fbd-944b-b2a0bb45187e@linaro.org>
Date: Thu, 26 Feb 2026 14:22:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] system/memory: Constify various MemoryRegion arguments
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> Mark the MemoryRegion structure const when is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h | 28 ++++++++++++++--------------
>   system/memory.c         | 34 ++++++++++++++++++----------------
>   2 files changed, 32 insertions(+), 30 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

