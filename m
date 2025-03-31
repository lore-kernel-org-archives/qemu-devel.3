Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0294C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFsq-0004Ls-VF; Mon, 31 Mar 2025 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzFsk-0004LH-37
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:12:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzFsg-0004zy-N0
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:12:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so2217101f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743430369; x=1744035169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qstB2b6UBNQQzD1RzzmfHt8Qv/7sHDlDzUB0yNZXE2Y=;
 b=LMLh5xtdn9EEWVDYU9W/kyKjFOC08VJKh5a5cvG0ccUmbVEd/hAXqKFrV4H7WN4gEw
 i61J/9kIHGTG84xYB6rdpr/gDvdMr3uXIqHvP2I3jFdjuXrY6v68mLMOBmU2n1Vnva6L
 opI9kX6RvOPqPRRq9ASW20nCfrCWWhYG5ddV7Adzt3embMoRwx+CThv51kzQhObZXu7C
 SsHfNFuSvhtY43GUBHg18sPrB6pctQtFG973nQl4TKuoMRtBKUzX9mQ7iTxvJr5ly4WK
 qcG4OatS1cZQzCrG1P9n53eg0U01HYvkL9Ll5+986+Gbhn6iB80Cz11l5isicIeDjVLD
 4hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430369; x=1744035169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qstB2b6UBNQQzD1RzzmfHt8Qv/7sHDlDzUB0yNZXE2Y=;
 b=kmA6lx9a6dw0I83fTqKGkSjzzrHNut9jre0gHxDS7twZl3Hb09jlmZPwInwuQKnyLp
 6kJ6IYXML77wxxWDx96QBmZDS00wMuHVJzRH14q+slod17tDH2AeN5YDUgoFiUqYnfJ1
 LO2fCZ6T1YXIJ6QIRURd1I9P78XnIpnW1s/I6U8YKCnICf2g/iOT2AjeUjcVS58enOPH
 BvHsWqtAGiTSCgyae5vPzbo54J9bfCaAlOm+memGFaYT/hHKohMRohrBd5Ow/T2ElbKv
 CUAuEdiaCdG5vHe0hOGLMR2SNyhJpEt7S7A19dXi1c1H9yRDwj5I2VOzIqQRIzsdFQuz
 5euQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/4rgV5F/rbxHQkQL5RFWnwj7lwGQC0BNOyOHqj1K/FxYHTUq10AHK3wxIcM79U8+yqQMpfnsHA1am@nongnu.org
X-Gm-Message-State: AOJu0Yy0qytOo3CUwVKFfY1pdCIUTPhdVhEBb9w+BJE0v+hX0xpbrecn
 W3OxzM2xtIxcUU9fNqE0qwGdsW53sqg5LuWef8995uANkDuO6wwPAErQZkR3deE=
X-Gm-Gg: ASbGncvShLTEQunU55/IPAEgZ0ztQ0EY564qktEglmaj6Za1lO4ra6BapXimS18tj5w
 B7uLd79CwUHkSV2AEJRGXuKDBVd43m6vUThuxqwS17KDvhAQ0/bpUN613E5ZiqfmGlq5IGmssil
 pAIcjylvTANo7RWIs0qfByvrjTNyFhbFC1pRu/C2+OvLxMgmuj/5GiLKnYdBlqqZUFCpJixbzFD
 BVEWBwjCy1NyNqrRcuPyOPLxfypqw0TTf+/Rh5u6XlT4q6jkfokvlNnEeiYOoLSd1C3as3BJj7k
 QmXE3e7wrnuiD33EddGlId9QiOGHo0vIpA3fhjKWIxf5fxz9d9Vn/mg+lP4Zao3TIPpwEZC1cmw
 idsZRoVQJX+Vp
X-Google-Smtp-Source: AGHT+IE+eL683MqTQu2XGYjcNN9QRLy3XOahJgTqL/0eNSmu51MTmlUgchbuHKZaxRy3vJ1CQU9RLw==
X-Received: by 2002:a05:6000:401f:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-39c120de319mr8081254f8f.20.1743430368692; 
 Mon, 31 Mar 2025 07:12:48 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b665707sm11626085f8f.38.2025.03.31.07.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 07:12:48 -0700 (PDT)
Message-ID: <3e11587f-176f-40f4-866d-c0f0129b3953@linaro.org>
Date: Mon, 31 Mar 2025 16:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/mips: Revert TARGET_PAGE_BITS_VARY and bug
 fixes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328175526.368121-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/3/25 18:55, Richard Henderson wrote:

> Richard Henderson (3):
>    target/mips: Revert TARGET_PAGE_BITS_VARY
>    target/mips: Require even maskbits in update_pagemask
>    target/mips: Simplify and fix update_pagemask

Series queued, thanks!

