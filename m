Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45892C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3uF-0004oP-VQ; Mon, 03 Mar 2025 06:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3uD-0004gk-LP
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:24:17 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3uC-0007EF-2N
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:24:17 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso3755584f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741001054; x=1741605854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WriM2vatkaDTy39QXjQ2gjezMe5fOsQ2lomIQZderWI=;
 b=rfVdyPw5qhL+kGn9NdV5GLW597KGgKFn/GaNe4v4LvXYF15HPG0pTt8N6ir3T/gc2W
 r0wz/VPcK6XKz+pQ8wMv7KG1xrgi4O+iBAGvbYHTNpasKQP1gz5p96SpfKUhin6aLt9+
 crIzt64c26dkS8VF6ilAD4q5W+c1Ziy2Z+EhJ0hT7QWf3lOvmdjV7obCeoygJk/qZHHm
 QLhRlhstI5hdAJHXyqSVMvoAsyIMKmtqyUnxdfUQq94Cepy8us67Sl6T0QtaCD+7ccns
 qHppr8WMtO5DAdsL6TovyPPBU9gi/MC4a87buFVAF3/o1kYXRxQQzatSMXad0r9OzkxE
 sTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001054; x=1741605854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WriM2vatkaDTy39QXjQ2gjezMe5fOsQ2lomIQZderWI=;
 b=A2jNg/7esoGxpj2ZjDMJJWhGDUtbzXc9/OajEl5T512edMyp2z4g2TnSKhZmROsVrC
 tcx0XaI/Pf3ozVm99vSXC/ZT/nm/H+Sv7kmYYTUGAiTNhiLkCawMVxUCnyO2K7dn2uyJ
 mgSMrHeqabPhftuvb0p5277Iif46BZC+GTenIz5eu/BijGlL0huAp8RsrPC5rtfNutVp
 gjUFAlNxmcHiUBKFkH4bbtDBUWQOCsga8FeOHPnFf5Jbc54JQ3Dua+T2JsxKIpmeVVDD
 zj+HPegJzJLxSESSY6TK0701Lt4efm3yvkU4BueUYepTlphN6jUnO+VZ1yZGwrv0ibx7
 Eu4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWOaHizxXDaMz17GEYD9Pgw5S4crT7kNMBVoEOmzlAgPu6YMrHGGFBT8N1YWC3rrK0YDcqFkmGnAF@nongnu.org
X-Gm-Message-State: AOJu0Yw/oToiqxyE7NGrGl6qcwR+WA+xff2wMaljkTRNYU7Z8QpKlvyw
 skvz4iGQL3+eYvQfPB//x6fjyPF7I1R5YVWRPCy18+vpNsJ/YgPTMx+/1kBUpynHbk3NiOWYSbO
 KbvaSAg==
X-Gm-Gg: ASbGnctXptHvW864vZKPQaWd/dPN+FHaQDn5ZnSoxgEJaV2cgozQvLT+L6zfu9WqeTr
 CV4oeGHVHbjvM9NBVS6ByX8h2FrlDwNvNiXcNI5Pn01+HETJz1chpNeN2IiDQV9GoiKGyb5hL9S
 3VKVFrnj/Cj/4XDua0VAgxAcN6pjq5PcD2C/tnS0IHAfMZJxZz0cVvk8Kk4v3hfplX+U+O+2ybw
 1kW963R08wbEN7BwRlFgSJXnDolG7guNfugrYuJ5bEB749NXhPCcU62XUESqpKc4BNAtPLoPmjQ
 zuZ6W0sslbN28soxD49oUIFnPEn6P/0ZzRHwi3X9Y9a2xsqQ69SBXX0vv+pqWEPZmzgSc3T1K37
 NKD68JhQpuUTC
X-Google-Smtp-Source: AGHT+IE257ol4ltroC+dD21JHlX3Ogi8KT2f8fvmelTiDBHZI070oCRc8c2QAtn1wydtRpmQ6kK17A==
X-Received: by 2002:a05:6000:1fa6:b0:391:952:c758 with SMTP id
 ffacd0b85a97d-3910952cc74mr2769638f8f.6.1741001054451; 
 Mon, 03 Mar 2025 03:24:14 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484451fsm14446779f8f.63.2025.03.03.03.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:24:14 -0800 (PST)
Message-ID: <c9e66883-2893-4247-8c31-253330da7fae@linaro.org>
Date: Mon, 3 Mar 2025 12:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/nvram/eeprom_at24c: Remove ERR macro that calls
 fprintf to stderr
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <637b92984795a385b648a84208f093947cc261e4.1740839457.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <637b92984795a385b648a84208f093947cc261e4.1740839457.git.balaton@eik.bme.hu>
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

On 1/3/25 15:35, BALATON Zoltan wrote:
> In the realize method error_setg can be used like other places there
> already do. The other usage can be replaced with error_report which is
> the preferred way instead of directly printing to stderr.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/nvram/eeprom_at24c.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


