Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE6FC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v2s-00027Q-4Q; Mon, 06 May 2024 05:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v2g-0001zb-Fc
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:53:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v2a-0006cT-Au
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:53:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b869326daso11619775e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989225; x=1715594025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3MXBECi884L5d0aW1y4r22YZZuFnhM5zOy+PcayxA4=;
 b=UwTKIZJp7PSp1QgzvSoPNhlZOneW4OWkrIu/sF3B3cHQsbOLXKtSZe01POkIJ/oa2S
 HPUyK3oxtHH2EtKOO8AfJUHc7kC1pFkm8OkNPtjAHGwLHM9R89+pIYzEgDUDvA4RX8cL
 BfIGt89BwzPf9VAa1y8Bg250aN42dZhP1bnovLVjPdZcMI1HtLIy5SO/8YB3ykpiGBkU
 yM2r96Q+WePhTJQ+rHI7aHhtAFqxmOkdj1zpig1nsA4ut0EoIzls8+cpAx/nAVU+dVM1
 kUGHziK2li0JHful60rMt1Bt/oUc50bFV74k2XehYX4pEKYbemNfmKcQIu+iJerm/C/v
 bAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989225; x=1715594025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3MXBECi884L5d0aW1y4r22YZZuFnhM5zOy+PcayxA4=;
 b=XXMHlrbzYl3LOWTsyjOxD5MshNwSEAWp58jcVmdDySKOY9ZnQZN0S0tA2AdMerQF08
 JsO6VMUbd7l8admnrsdbY37iMcAdv1n4IYLAgL+npAk19q7EnwkKyPAFx56wG6F5rAmE
 l5CJR52KbhU+TU8Q1bhXMewg+OuAnqKVstyVWo3mamPhnmBmrKE6JkRFDl/JRFxTnHmR
 nAtIQXBN8FMk3fnv3cgzBlLD6047e9j75NdPzEHFgYbEMCV+Kl+UOcPI3QX4PtG8f/sf
 MSyTEYf+jflcE0LQYsCGvkdmixYQ4IYDEc4KWxftb4b/UgHfl0NwixIGuFwazSCc+OEN
 ruWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBK556UFcSJ1HAIi7NO+M50t3JEf6O8C0ZjDPOVuzmXwToEFr5pPYOSNVw7NHEZ4YaXsBpYBmAk4C6J/aR2zrewxelaBA=
X-Gm-Message-State: AOJu0YxHBIju3ZTfhuwbN5x4MHaY1EbJw6tgrhoXujl7Gk0z+bESLSWX
 IsxLIFkvkAprAReux6gP5qzVkMF6XutZ6DlXfnZhz0OvD1nsLQ0mPFFQCEVWcXEOmXZf8+uF3JT
 l
X-Google-Smtp-Source: AGHT+IF16S4BEzauRTbWJC0iDOTjOLBHJaJTfN9M9AvFa6XZRi9Sy9mQaph2LBneCeJ++5YUspTtfQ==
X-Received: by 2002:a05:600c:3150:b0:419:f241:633b with SMTP id
 h16-20020a05600c315000b00419f241633bmr9657877wmo.8.1714989225374; 
 Mon, 06 May 2024 02:53:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c4e9300b0041bab13cd60sm19278191wmq.3.2024.05.06.02.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:53:44 -0700 (PDT)
Message-ID: <c42978d2-cc54-413c-bdba-3d0adf1cc6ab@linaro.org>
Date: Mon, 6 May 2024 11:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] xen: mapcache: Refactor xen_map_cache for
 multi-instance
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-5-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Make xen_map_cache take a MapCache as argument. This is in
> prepaparation to support multiple map caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


