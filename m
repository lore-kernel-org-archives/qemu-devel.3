Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF9CA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOWu-0007yj-C6; Tue, 02 Sep 2025 06:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOWs-0007xB-JQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:46:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOWp-0002gu-VI
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:46:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b869d3560so25218085e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809978; x=1757414778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jyeSynXhC1do2xMh/D+SFuuy1ST3z9sIyVTE1lDs2Bc=;
 b=q0/9qageiYUYbNrYUbVsCpJxHIUmlnVuzJH+cWhZlNMzOAE7yGfSwgsdK0qu7pA8hA
 oJmn/AXDlCQclA6MLDXMFeTcgcZ/XjmX3hD0xvkPGtmVAfu6umBRQE3z1eJU1MaZUJpQ
 lf8jNHW/ZgU4BjIe1S3MBgUwnMjAC0l9PRlneb4QYj0AGAIiEK5dprbzL0jtIdXZRUSO
 ud6/9NOGyuQDN5JJOWS8/R4TX1zMOtzkOnxL25D7uBOccK15OV6GEYGktgJ8qACY+LkL
 qMs7ir6+wJbP5FqHOUuv0LyaMOnKa4dB5Sa3RP6b2Ag+BPqD66g3nBreFQqbWIkpKhlI
 10Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809978; x=1757414778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jyeSynXhC1do2xMh/D+SFuuy1ST3z9sIyVTE1lDs2Bc=;
 b=Tp580kZHcdvx6DX2v+xNg7UZlJq+2OUnKcyI9xm7RjpLUuSxJibEKV50h7kJyXr57I
 Ktgh+rg0vcgDF4dORLFpFqSUOa9Z57jZQbGqwrO4nBYCXNG9JqNofat0AwR4q0ylxoXp
 3xOdIqhoFYHW2BdwGWY0nRsmyyf/lA91aaqp2cHzVMgOzYGo1rngHKwlJyIH+0SKwzVZ
 6iUkzD3uM4LSGNalwgGoFLgmVWGe3iXaYjBaKOrBNHElEOL8xZBfTwD72zX3GqEwYfic
 OmHnIUYkefNfySZBX9boomE0b+FYhxMhyyOm1SITbm+xPJtGCowkFcZj4MDo4mEdZNQh
 CFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVU++DQV3ozWvKGfI/za0Ij/ZHCPYfVIXzehSfEvqKM0UtDHE0PHuAf0a7+tqHfPCoS189VeDIhLIZ@nongnu.org
X-Gm-Message-State: AOJu0Yx3u1G0xXC27oGaq/cBFAMcf7j1agBKZa7gxq9IWPQ/gY2Ds/Zc
 yboGNSvJbm6t9XwoXr0OdjoSJHlbIayonjvZ+hZZnUkKdl2wjUePEjl85UmzBtK6gnk=
X-Gm-Gg: ASbGncskxlHp2ULt3a1vGXWPIr8UZhd2QH2E48U5UNcqDLCeuQfqA+yH2giGpUJcjcv
 l8ZYjs6VbjZXzU8BFVM6bJHzxr7PoQCiwti1RCPg/b1idatG2J7jq2F1fMgjmdfZK1sTF+DC5UC
 2HquIjnQgwKYiZpBu52tYtozMJpa0ZVQS3laovx7gWcSPneogJpRmDw4y0y+UFk2ONNCgPYTUq7
 bijekBxH7BNYtOZJdYmqYDYUcTrezE6VPsdhAGOQVJWroeqayP7FQK5Idqv8ffi+bJ43LuZ+p9E
 moC/MbRCtmXFLEq/IUzqyJwFuvQH/khwwSAD88AryLcVbb11osjcpdjcZpF8JdXVlaaoZXJbtX+
 myqq8LeMdwuOFplWg78hZbM9vSQ3gy1JF9CegGUWSdfIldTQHBhqBKnZFAbp1V2fdWLNCf3+e/A
 CP
X-Google-Smtp-Source: AGHT+IFZ/oT90yOVy92D64FNy9GErHJXDgsZsNr8xgyGra0M2XN8+XqyBJbqGuV0Xgw8wtn3S2B3TA==
X-Received: by 2002:a05:600c:c162:b0:45b:8352:4475 with SMTP id
 5b1f17b1804b1-45b85598a56mr82693565e9.36.1756809978192; 
 Tue, 02 Sep 2025 03:46:18 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d729a96912sm7256191f8f.8.2025.09.02.03.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:46:17 -0700 (PDT)
Message-ID: <ddcb9471-c8fb-4c82-b0c3-002b084c0578@linaro.org>
Date: Tue, 2 Sep 2025 12:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/mips/loongson3_virt: Include 'system/system.h'
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250901064631.530723-1-clg@redhat.com>
 <20250901064631.530723-4-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901064631.530723-4-clg@redhat.com>
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

On 1/9/25 08:46, Cédric Le Goater wrote:
> Files using serial_hd() should include 'system/system.h'. Fix that.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/mips/loongson3_virt.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

