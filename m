Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA26C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GVn-0004tu-GE; Fri, 25 Apr 2025 06:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GVl-0004qN-Qh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:42:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GVk-0000Sf-3i
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:42:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so15133115e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577741; x=1746182541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EMa5YDqvt7rUbmf/BLQxC8RZNnMybCZ7CYFM+2JJQ1Y=;
 b=r2yvOAjo0bLVpFZt080ekrf9sVTVweyLaMAbaxHhDVkw8SMd8siGTva863Jml6EPN+
 x+UyxNrBa+FNiJDxHSkwKztYiGakjXYRkLf8tzwlOnZ6MctnUX3nU+nPGA1RgM4xbOwX
 PznUXEb/pFoL7sALJIE0/Jbmy8U/I+kWVoWc6sReFfLrkOZlv8bMhgZDJTksiKtYG2GQ
 ZJ9/ndTUNF/dvhudD+0mAfnVznqkm9Xo56vIw70PaHEtXcQCWkJbw0zGZZcRH+o1FNcZ
 JszxpBafp24DxjtlaNOHiJQlS0uylueooIe9FuJxAkOHCmNeGtfrvU21yf6ydgu63Tq3
 1S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577741; x=1746182541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EMa5YDqvt7rUbmf/BLQxC8RZNnMybCZ7CYFM+2JJQ1Y=;
 b=El2dWlBD45OZ6m5cXfJ8l3UAA4naUgappzCxCHkr9bcTGvyPkwjuBtn7IFd3e/PQbK
 T0m77SvEPynEHaZDtbEGASgiCsAMopU3Nvo+JsdXDdXQdQkUH9reErB8o/N7xvSIlXgr
 ZkQY3roG8jSwQV0AInjuVKz0P2gXlPfifWi/TfSL73luj0Sb0xEsfvQckdgdTgS7CgaJ
 /yj+DNsV0v6mTUZxQ0j2IqoTwfUHVyMIVjcyYvHohksUmk5kCgNd26WRkn0gitBnpYVM
 ybHD6LEnAl6/NALIKA0PjPXGwU3CeQ9NZNhSsiwi+DgAeGHAc2sw9/ssCBReNdF5vmkU
 RV+Q==
X-Gm-Message-State: AOJu0YxeVRSNnctdEyDsMAyzqMDKNUke8nXHEuY4vdV1KVqjeSGZJ0ZY
 1RB9Hh5ZUllOXHNgz9Ju1P1XxAt50jfZzDWvuGRhTKXZ35+IXDGihX+sMkmMDBGDCkcwSgv95dw
 i
X-Gm-Gg: ASbGncv2snJosJyPzk4GFzFskbLskzgKDZW4+6ZBEtrlPbZOEdaQkpefa8vHev0QmPD
 DYrb7memGgsfzbakITCIyj4YjbxGvOCKzpGcEutvltlDuz89meNhuHyCoSJZhSviPNVN/WdhyzB
 7pBd9si1uwjrPtKDSALQS3zUD48wL3NVSfndxA4x3FY5BGgQaQmHxJGm8vfxXVinGXYZvuQmzqO
 m41JwR0Iq1kKc7jIiGnEgfXUI3etPfe5Jul0D2tw3q5tRScsIGwGpJ8WcQWQuVs35B74klolXW7
 tYSzWFS49FBF/657kggydh9SQKSW4Gu6kjcnLTNkh7Wb/hIlqRE9VMXiSRUPHqFeD2EdYqTU4ZG
 CzJoYkF8y
X-Google-Smtp-Source: AGHT+IEL2Z2Qz5//Odz1WcfyWLUBlLvg49qVxEqjot01dzOxIe42BqkmHQ/3QC0E94D2jLUvpeEIPw==
X-Received: by 2002:a05:600c:3d9a:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-440a66ac6bbmr11279905e9.27.1745577740882; 
 Fri, 25 Apr 2025 03:42:20 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc199fsm2006316f8f.55.2025.04.25.03.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:42:20 -0700 (PDT)
Message-ID: <b0a61c9c-2496-4322-a78b-2d2f5a11d63a@linaro.org>
Date: Fri, 25 Apr 2025 12:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] qom: Constify class_data
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424194905.82506-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424194905.82506-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/4/25 21:48, Philippe Mathieu-Daudé wrote:

> Following Richard's suggestion [*], make QOM class data *const*.
> 
> [*] https://lore.kernel.org/qemu-devel/f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org/
> 
> Philippe Mathieu-Daudé (6):
>    hw/misc/edu: Convert type_init() -> DEFINE_TYPES()
>    qom: Have class_base_init() take a const data argument
>    qom: Have class_init() take a const data argument
>    qom: Constify TypeInfo::class_data
>    qom: Constify TypeInfo::interfaces
>    qom: Make InterfaceInfo[] uses const

Series queued, thanks.

