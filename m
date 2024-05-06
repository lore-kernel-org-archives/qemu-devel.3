Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01052C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v1v-0001iE-GE; Mon, 06 May 2024 05:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v1t-0001hy-CX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:53:05 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v1r-0006AM-Kq
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:53:05 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51f0f6b613dso2163372e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989181; x=1715593981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TPCl+61dRvUZ43xraXeNfSbdX7BxsyMvGiFdXcYoCwY=;
 b=yjzAH30bkSK3ALOM0vZ1KHtf7eA1NjSupkoyY5kXaRN1lgqD438orkMiBwqsUpxvTs
 SQ5J83M7mXH1P1GoLLAtjv8Zs+Me20yMbWFoG69heaFb1pO/4bL8vi4nn1vK+KtYi4IA
 QKzcaAyuGvAepL5+mrffMJqDTOB8iKC18a1GwERzBt5V+yVVx3F+fcww/69Xb4WqutKu
 RRlMvJxshdcznNqtixRLacCpS0JrZ8rP2lWPoSDHvtoRjLeoDazWm8hCPivOR0mQqU48
 lAV0KrWG/BSd2rNPB3XtCawj1lU537P43mzHGhc5Zx1gBCcec3itf2jEqOxNYFVRNVwb
 xU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989181; x=1715593981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TPCl+61dRvUZ43xraXeNfSbdX7BxsyMvGiFdXcYoCwY=;
 b=XS6Nm9zOvEjjz3PS5kPz3pPCsBVgKEBwH4dhr2Uysr7CC2unkWsVn4EuawEK+azuN0
 vMPrziC3rvmMRbroE7nE1H/4a6aAlpDvgaujCWQEF3HG1KvEcUXE4m7scESRSiHXUJz0
 3/37I0+93aWBccUJVnkUa2jZ1fHWadlCCAle8E4xwFJstmeKS45fx/trFhWgLayDYvJz
 BaKve1QZmtlqkN+MbeAnJqTY6TqQzdlUru1l58z3x6qvQHfoFUxCRwhTDPGZAOneTtQt
 19favFN8oiMVQXH5NZonc/h6usu0aFnxPf/PfP7IHbFlSILsOUoIIkGZvaA2i+5ibgbe
 jVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq6yGWse2pPt2TcdMS8JH0Dk6+WP8/zfHwdAaKIuRxr5lmSth31VDzmLMwABdqbQG54sUjTJ7CualImF7mY0nqHU+6FcM=
X-Gm-Message-State: AOJu0YzT5SFQszCGiVG3rl2tAHBQfUovvh5wRMJAVRzxkjb+kSv8cBw6
 3NUwIj/zhnxVzJcOOl13XN2ZGlpV5J4nfASUwwz9OZVzFi9Yzp+4EB8HQBDUC0M=
X-Google-Smtp-Source: AGHT+IE6VEab3Nb48zWWttMEjaLYBNaijuvXZUWASOQIGE7LaA6yDT6c1ODOLkonnCdy4GCZ52lmBg==
X-Received: by 2002:ac2:43bc:0:b0:51c:15fa:b08 with SMTP id
 t28-20020ac243bc000000b0051c15fa0b08mr5054250lfl.69.1714989181528; 
 Mon, 06 May 2024 02:53:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b0034e285d818dsm10325541wra.32.2024.05.06.02.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:53:01 -0700 (PDT)
Message-ID: <e43695d7-e13c-4bb3-a9ff-0a5739cbeb79@linaro.org>
Date: Mon, 6 May 2024 11:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] xen: mapcache: Refactor lock functions for
 multi-instance
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-4-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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
> Make the lock functions take MapCache * as argument. This is
> in preparation for supporting multiple caches.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


