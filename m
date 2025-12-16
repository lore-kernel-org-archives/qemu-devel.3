Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9FAD5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 00:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVIiP-0004ce-Ro; Mon, 15 Dec 2025 19:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIiO-0004cJ-Mz
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:14:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIiL-0006Jp-OI
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:14:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29f30233d8aso38837325ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765844092; x=1766448892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OuFEIS57RimBz1m6D5sz7mKNjCdSjMvI7LQMzNKUMOU=;
 b=V+y4LyLMTvwBZ/nTmj4bfoDwpQ9BCQdARgIncd45IOVd13afI/8MEI7FXeTEpvicyr
 wWj8T0vmxH26BwXGCuwK/hiYGN+kEFlyODTVyPzGmtb8qNOnN4SE/245+P0ADdgbzmeu
 qAI7mn8CMvvw82ENmfJYoJReKlS294gJ+PgshIdoTKsQ/A+8CdK5x/mJLdnJ2Sqysn2w
 5GxTKlMAk24hwaC705twQBNpi8itYdhOUY+jd1mLR8/TjwmFwX6MrqWchX0kN/gS5d9r
 rrFfyHcFjxxUA2eDd//xQHQBuisZs02DFWH2ZAc4GotGPxANqmh8ZCkJVINDp++SWW10
 Yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765844092; x=1766448892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuFEIS57RimBz1m6D5sz7mKNjCdSjMvI7LQMzNKUMOU=;
 b=h2syHnMgOAJ9dW3XqvzFlW3AA/1IUpol8/1w1pIDmbJqp7OLKpBoVP46NEn00spwyo
 5w8pgBOhaEoHI/yuaerUXPpeOwa5M8g7iedNHYArd06HxUchdC0+peXpjiZt8TLNAT7w
 lQ/eAM1PM8ocYAVozJ6bchfkPDkNAu/OYKH4RrqSwM5Eep0WYwa9snX1c1pdbOo5SurC
 9ed9FblDF3fzhEuc8Wm0cmofw3I8ymq0LZYr70zQm9D5qAmsoOLGHvrzr+l1Pv3a4DR8
 yMIOIuZkwZcfR2pmfJQMb9MpZ3NBh2rF721lHNBLr8Q2SFw7C+W8uSuo5/kk/fjT94BN
 f+2w==
X-Gm-Message-State: AOJu0YyNoIfY9H+0UtJpbfMgYykAea6pRBNKa8SXZx2IBnCzbwfaHIA9
 FCShuThNjjXgUzsXVVE7HdBuk45yvsRlux2G/DDpbQKDaUgfTjXcLm5sOWfkzj7yCxLUUtNKYHj
 Q3UtFDtI=
X-Gm-Gg: AY/fxX4KW/whbmWr1ErJOG6vX02STb7ZNzwFfXXt6gsrLX9BPrmeymyPu9NOxK2iR89
 Lppdd6BCybX/vX0YiNufHacH6OgvYmuz+8PS8cEcOy6+cmr4jANitZg4VZizSN0lS5E/GbzXSBe
 v9zmQJqD3AZzcsa5iwVvP/tqyr3290kQyOnL513xhz+LELQpkoVQQTqQ+KEFS74UduXmSihfM7q
 +NyF3q3Nhgg4G23OSloIwEEpcNgcyk7NsbapUz7eSXIQWDHSGZoul/7kjvpcLC5Yy9RQEepz523
 zImpIlE0jMkHNK10mvXQKhNKyiEl0x2eBvnrThP/U6Jbw5bUFhd14Ms/B7doR9s1rOHbTeq9pl0
 KMN4ZtiCRO77tEApCVgFNLJv6qo4Oh/UaaL84+i2y7mIAyuog/oUpeUko7LKOybuQ/QKYaEhnPq
 Jy9Xmz/DTzEgsxRZTgrnOYdW0tYOZbg1Mxy+gL2PInXbVPTTlpyYW4icI=
X-Google-Smtp-Source: AGHT+IGHNo3ZV5ywMGyqmovUCNnh4r7CoQy/Qp6sEhSiCvSp4Qbz9lRB7gwW+mAiY2i/CS+gH76MyQ==
X-Received: by 2002:a17:903:2445:b0:2a1:2ed4:ca1e with SMTP id
 d9443c01a7336-2a12ed4d1ebmr17214875ad.34.1765844092146; 
 Mon, 15 Dec 2025 16:14:52 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29f2e40765csm104702855ad.0.2025.12.15.16.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 16:14:51 -0800 (PST)
Message-ID: <7e841ef8-fa50-4ee9-9370-5cc6c23d4a5c@linaro.org>
Date: Mon, 15 Dec 2025 16:14:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org
References: <20251216001053.784223-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216001053.784223-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/15/25 4:10 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 52 insertions(+), 9 deletions(-)

v2
--

- Fix rebase on top of master
- rename memory and secure-memory address space with
   "smmu-memory-view" and "smmu-secure-memory-view".
   If someone prefers any other name, I can change it.

