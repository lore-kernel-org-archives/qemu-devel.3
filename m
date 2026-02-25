Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FCCFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMcV-0002sp-6A; Wed, 25 Feb 2026 16:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMcT-0002re-6R
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:40:33 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMcR-0004RW-Nd
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:40:32 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2adff872068so142755ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772055630; x=1772660430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzUHQe/3bZXXU3luwKhL0L8k0oQVcJqaT4DGZBaYs+8=;
 b=PZfvMx682YrmWW60+OWy820BvM/xg8vhFixT4VUmtb1Ff//GGgHNDL6VBJ6lYBlYo1
 tOXUKE12z0fG8YplWpiev8gL5hY9Mza5+3rY1B7h2orYOS/SHUzGnpmOy5z11+t4H4Sh
 J855b0sc7mc4/F6JCM26j5Hne5ij5VXOSOgu+BKvh7V1tFiy3lK8R0OzhJi0OZKqIGJr
 f2vkuFt27YYoF+OWvXXO+sk9VoNNHn7BEXESId6AZHdD0SktquBZWAsW3Y5JxSILJ7PF
 LyS+lLK+IO8d0xyhP3ABY1Tb+GlEwRL7cOwFc9MKAhnDxztyrej5lFKowrX7e8KG6Gcx
 Wx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055630; x=1772660430;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzUHQe/3bZXXU3luwKhL0L8k0oQVcJqaT4DGZBaYs+8=;
 b=V20p6EOhnDwTOx/9cYWrY0hOIAfL17MMms+3mhlk7M/FkNuZl7sKcKiLF85mwp7it5
 9tZsjjpkQMh/e/axrsbzAr+xSoPCvk+QjvWt3bnB19AC4yeKA8ZLN8YraNrjoAIDsRdW
 9S0gYXG0vmvfu6F4YGtSUH6t0oMPAHuW+fBneX8LLT66fOdqJDKDqvL9rlzkv/DosekH
 l7+V4A2vj6rlbC7xOJssXiC05SRE4vgYiZKsn7W9+/U5QBEHhO5fH2P1vFexkRAeRW6y
 F8s9fsNfoE4Fcctze5hBCmMwEOQFft6cyjgXIZpq6EZcfvxWQhfBzNhnOL9DcAwVxDZ0
 qpnw==
X-Gm-Message-State: AOJu0YwpKQM58Rmeb74Ovd6yNwfgiwpZsv/eAwpexB/hmiVvybzjo6m+
 wjzDx37JUE13uK3d+l6MC4bmtwXhQIYirWsz4t4vxiQ7Tatef62UZIxkrbisV2xZPOA=
X-Gm-Gg: ATEYQzzQvPNH9AsR81pNQXGolH0lPnWEsM7VUVCXvyF44sBn7EhQ/7emAIA1AKG1LNj
 +AfDTkViDMtzIZmRqQ8bIn19IMmT1JpUAtCkb7Rvi46FLZ4grp9tg3qV+muh7jIjVywCPZHepIt
 oIB4tpTc9Iz/C7usDhCTJSKD3Mqr+AZ7//KT6WZigMgpROpof8qCKEgnhkYWjEreuze3jdZSe6p
 bMOKYquRP0yNy2desozwqa/2lmiiNBhHvGWsnKCJVwMrdlrB+HRbyVARYnasg+7CuIc0bWrNfdf
 0zEN+6bY8WbWP1PQTClbXpJav64A7VXn+LYGd9UYnflFPVYyXm12BNIMERYlK7G1cQ2b5gU5lgn
 oKqyP/mC89mp7/5AjXU0BsP7WOfc0sBoO21EJAElGT+e4MHn6x3ktwDWfzKPIViDYXU3X2l4WI0
 ACMwz0zOkKU0OewAWtn9UFzMuqEIfwZ7Mpx/wsqFI9vO+jBfCzHJEXwi2Dl9Ta+nNVAbR95SDYg
 WE2cuA=
X-Received: by 2002:a17:903:1b6d:b0:2aa:d5e8:f4e2 with SMTP id
 d9443c01a7336-2ade99bec80mr16982785ad.18.1772055630235; 
 Wed, 25 Feb 2026 13:40:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5e1174sm1903025ad.41.2026.02.25.13.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:40:29 -0800 (PST)
Message-ID: <d573d2a3-17ba-457e-85a5-a5b5022c086a@linaro.org>
Date: Wed, 25 Feb 2026 13:40:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/21/26 2:17 AM, Tao Tang wrote:
> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
> and return CERROR_ILL when stage-1 translation is not implemented,
> matching the architecture requirement (IHI 0070G.b, page 176).
> 
> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

