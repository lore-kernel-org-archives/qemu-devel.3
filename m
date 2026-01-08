Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F98D1D495
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxKQ-0006s1-KB; Thu, 08 Jan 2026 16:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKB-0006hm-SI
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKA-0004w4-3r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:43 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so1943854b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906821; x=1768511621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qHkC8PHqFUkuJoGGKdlEvYwHFfFMIyfHSVnCUOcjQg4=;
 b=bwib/XIewYFWOdVEZGpY4ZpGhA4XXWPPXmdmAiXuO19lTPFSke/B/hGDsidg2UMTYL
 dQyw5bvtmhe+LzSySohz+pkYp4oXZO7lZwNnTTojMJV8ML4I93WPR3vBzmAAD2T5Sz2w
 IALfKsCZrAwbZtu6VlhPuGVpTrN/YVyDeJr7eQwxSNxYajmKLcydOKx94qG7n6gKiTum
 FfudDQ/LoiJ4WpBwahmuuPRJJLEXZbQmbDypVr7vTAdgEY4Zh6XVfm+cnjyWQTH3Bkqd
 jPzLqOm+gq1OBVHhUAZYY1kj4yPcHULZ+LXTBLxwBetKUBw+bw7Eul7W/Kl2UVDzwV+N
 zLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906821; x=1768511621;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qHkC8PHqFUkuJoGGKdlEvYwHFfFMIyfHSVnCUOcjQg4=;
 b=vxmRiDFrv/VC2lJEvMtDpQ1nmknjGWjH8ypsqWv6zr9vd+0yspiyOUxisF8Ze18o3o
 SJhsu0DSztLKNJv2P33+xBTnE5bP8MDXRRzv1rdmwcA3wYaJtAlEMA81ucNpMMnSvGyj
 4FNSPbNs253bhjQzrvbcxTZDDNtDkozOcGB0hX/xqOprKCq4ex0A74kmZTWV9hexXtCA
 78M69WfsfYZdKDb758PIdIi3bh3LNsFzTFStOGWusToytYx8k/SPPXjoWqiZ7FvO3tsK
 P9llz7L3XFdOE5Ap98OuBg5diqsRtEL3+WKu2eHXWGPQsGeskszmxWgnR8GUvJZRFam4
 En3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXraOEdK1K9U2VvWVGc4m8/YIL+mlWf4ld4qnf+2GaLvBOCl7M1TBVIhKrl37pJoJFKnv5BVzUJ6nvl@nongnu.org
X-Gm-Message-State: AOJu0YzkEbFsfLvjDCnWkJwYyngPLTOnpAoMJgwlb1ezT83K5ER7sVEM
 I81krUIfBcJb5bDQEX5qlkS0USuMKFaaAPCiffwHbuIWF7zXyiNt5djkdCy8y26NFZs=
X-Gm-Gg: AY/fxX4jAi/mkid0vik3nuEkWDWa6yTy12xjUVYSkmpSKI0AmCrdSoJ8VOtbibOjkmq
 RIcMj6eeqaDSVr7rNdHcttotpEcr13dFH2Qiz8HJUZVSV2cLlmI7G2hC7Q40GZYix6iADVvtGY3
 S8R5Df135pvZOfCBo1g2Vlys8TZqvK/Mk/LyGSKAEvILuDsDOC2HBAb+AVSI836zx24udgAEukd
 bmArBXUs+Se4YJXiEeUD06T/1JcWFBIg/sxbQl2u8ZpjFYG9lrif7YOLn48opNszhpD5+Chrs7l
 a6NutDESg7wq9hyBINwqy+cBo3w7eyt44bWzKFOjsYieb3uhNuuWyYLGGPyyTe76ukjtz4JK47A
 MsEdx9kCtOMYHkCOhana4FpTxYfBc97sj/YTPDd3iVs60woNGT7m1oJN69CNDVa6Tk3JJWBMW2v
 91p8N/sGWbU1uXJZPr2E+stw/EsoAQmEpbswPT+AvhfOGlmWRDl1AyrXUR
X-Google-Smtp-Source: AGHT+IHOz3D9L05036qrujolhlK2cY96hW7IWPv2yvyk4NSB8YDfxtrBRA/z6+rR2AtMDRxmkHi6Wg==
X-Received: by 2002:a05:6a00:1bc3:b0:7bf:5011:d1e0 with SMTP id
 d2e1a72fcca58-81b7d862806mr6572897b3a.2.1767906820564; 
 Thu, 08 Jan 2026 13:13:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819baa195e4sm8464395b3a.3.2026.01.08.13.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:13:40 -0800 (PST)
Message-ID: <f30409e0-c130-4051-a805-6ec3e01fe490@linaro.org>
Date: Thu, 8 Jan 2026 13:13:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/50] target/hppa: Drop CONFIG_ATOMIC64 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/op_helper.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

