Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C0FD1812E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0NxX-0001fX-S6; Mon, 14 Oct 2024 12:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NxV-0001eg-8k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:30:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NxS-0000er-PF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:30:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so37716025ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728923409; x=1729528209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sM/+wg+lewZaOlG0yp5MfWesiXMh/bUkZ2f4TzA9W3Q=;
 b=YNS3dOWFNVimKRONb7U6/DaXlKRJuQBEoh9+91PZpZmYrDkLP0KSxiIQ9+coRLJM+6
 DRMArCVj5PZnaWLkruotWdC6j1zx5WWlNBIbxcPnBXTj5/NoXzE+/8x8JQkyGiEJyLB+
 mlHxLoFW12XtDG/SfuODuEBo3Icm1G5YjWMeW5jutN7IWGLYwI/21BjFSSiDJTh6htfx
 SKJGY/GnQcpFu5jSvlcNIlXLzsGGBD3JiHvipMuLfnCGPH7KqcUjSWZRxUHUdnHZ+3L/
 xz/SwRSBwlIT/H8YX9v0z/h1HhCUTTpbLGf/tDRQT0Vxd2mmGJ00p3Zqe1af/dEcZi87
 8qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728923409; x=1729528209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sM/+wg+lewZaOlG0yp5MfWesiXMh/bUkZ2f4TzA9W3Q=;
 b=gj7I0eSS5bgbNshpRuU2XA5dVYNns1VpJ7dO0PuPtW3h1cv270ZpVzs2IBy91LOonn
 DEXb+PN7OPZKSdKbeO87C3NcFBJQMGVcDoCcd+tpQGdjE/DwPmG5ldi29/wp+Ziaggpe
 lr+OLk6fzD5tNcsbZQZe4rL12oU1oVHf0BEIqj/txjp83U6aYB7CAjB3Yxw039RngTsK
 5DUrxrkK1mP472S9ND/s0fItds7cO6XgbSl5vO26U+w8JuGpGkolpYnPnr4wvWo4RMRU
 ciFGWoO73+18gc4wEd5148dOua/5vhlxb/tLplrX76rBDbinF2ZZKFcye8KSyBESC6A0
 JY9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkCZfDGLkSlzmcK0Kf54BynGm0iqzHsAiAgAFJ8b2+6hVFb55XQ/+dlDh2OU/oV15o4AoV3pmtPrgZ@nongnu.org
X-Gm-Message-State: AOJu0YzP4do7Z59uSklHBZa9OWnInqSG2o8/ySTGrE4bVocMRyLak+2M
 Fc6WgC49IWx1EJD33SQVQHJ55R05l38JikkCOoIF4TjBHyIuTNI7FiWlwGwmJHs=
X-Google-Smtp-Source: AGHT+IFVrhIY/xMM4MKBiLrcaYGC0SM6HOnu2tAlA9MYAziZqAqdViBcs1iQeNgHyp9O9Yk/EUkwXg==
X-Received: by 2002:a17:903:2445:b0:20c:bea0:8d10 with SMTP id
 d9443c01a7336-20cbea0921emr130597695ad.20.1728923409115; 
 Mon, 14 Oct 2024 09:30:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c311f3dsm68004845ad.234.2024.10.14.09.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:30:08 -0700 (PDT)
Message-ID: <301dc926-4b67-4ea9-8562-e93499fef3f2@linaro.org>
Date: Mon, 14 Oct 2024 09:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] arm/tcg: add decodetree entry for DSB nXS variant
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
 <20241014-arm-feat-xs-v1-2-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-2-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/14/24 03:48, Manos Pitsidianakis wrote:
> +static bool trans_DSB_nXS(DisasContext *ctx, arg_DSB_nXS *a)
> +{
> +    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> +    return true;
> +}
This is missing the feature test:

     if (!dc_isar_feature(aa64_xs, ctx)) {
         return false;
     }


r~

