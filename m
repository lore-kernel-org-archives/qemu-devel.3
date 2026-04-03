Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C01E88D72
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nXi-00085Y-Tx; Fri, 03 Apr 2026 19:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nXf-00084S-Sk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:03:08 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nXe-00076M-Bk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:03:07 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so1920306a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775257385; x=1775862185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hsivbn7rMtSX1Wpwc4u9nHMupS5bTAGgoRYgjyvTsIM=;
 b=eS1WVkepgQtA09S45r49ipQORCoIV6JD7lkig2OA/HBdynry5h2Y32QTnMqvdixds9
 TTGdpPt6ugN0CcqtDPFqX1Ha4M4yLhk1BJhhPKOQRnj55SwT0ebw77BrxthQllDGNGQr
 wXfOZ/h6Jlp0dKZCT/fqk9ARpVLhD2GOc2blo3wlTFJDfZ/RYjfy3k3N9GKvbEfkI20z
 hD4e0beSIZ9dDTTbxkM7ijjAkhEUvs+O8LmZJY0mMfXAhTRVQ2KDJEQCjcxQYIvvUYxD
 ZVfS1EvVw4l8S9+BgdBFVtjVDB+fJiH2xJ4pN3RlCfADC5RdF7vZivJW0zBAdsmC8tP7
 IRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775257385; x=1775862185;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hsivbn7rMtSX1Wpwc4u9nHMupS5bTAGgoRYgjyvTsIM=;
 b=h/oVXAn1O2tMD0OCXPOTio21X+4Xxmp+MMbKCg7M04qbBINeiv0aPowYtQw3QqB1gb
 +GaINt2mw+QJmP50XVYVZAFB0+fx9tuqfPgpNv2cmTTHqEc9XBlvah1tn4MiGGkHNISr
 /U6UnkZs46Y2Jcd6ZBnUIVsCowqrp/P/1JSokqLdoPJvP/ItTJfKGW+xQFN5fcpPbLnQ
 HbOBcqMHO37PMm2mStMvq9f5xLoDgSvqCWg5njuFKlNuID/9oC6XGv5pdji8MPbTO9XM
 dWZKWj16aqv9GxORFNoq4ZCP5siUATSCZJBTONuFW4npTicOqiFbicx0UUz/5US7ogkQ
 U9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKuaz4AIsgTQYTz1muzMdQHQguM0CfTSePCVlOKc7bPDnPUoiAaw+40qZUWJWl7SVt0jZcfjuuH3Ue@nongnu.org
X-Gm-Message-State: AOJu0YzLTt8NYwpvWWcfKVWe4CL/I2dRMM/1FeCb0bhR1DFFqzAjkBPn
 7tJEbSe3/kfjkwlfXO4XTWsBK0u7oj4Td/VMRmZ5Lq91gHa3XzRIKVAT5sTySqfaauGGC2gok+v
 v0Bh0168=
X-Gm-Gg: AeBDiet4dzCFFCgwojm5vIM+d3qFVFFgojWyyWWaN4CGRi+0BvxPDkgyxnNNu5/dzRJ
 7L1atfMBnLujeLF8mfw+eti4uPlsD4ppNzv67ogXR8g4Fuc8/7ZR/sqiWsgDkuaRfMrjePUxXKV
 +ZReDGBBUV6F3evLZFCcUx/ynYPZ+PSSKGA+w+P4KJ5sc775fJSqu/rtNIELLcyqnm1cGXLeTbe
 wx7NLkTNFpvroz2RePno3BZF4MBeunxObPEPSgSc371MKA6I+II9CxRZpq7TJ0CWaeiSA+cmYR1
 wng+7w+6h1y4MbI0gUYAMBCR+FEGMfBylBtGgYPeLy1saZzga7nLNHuZaZg9mspNnI7dG6vGyzh
 b2in20vDLPM6dH39V03dbXqkW7VAmGIy28x1VPdqKkzZYn9lsWCYhZTBnL26mzvURQkRWPl2wjK
 aXtRBlinv07JMo3kmjC3hx1b+5gaTHgJzj+zF64fOAQSBTprua9sN9CZRF1FzGV1wI+D0fRzt57
 iqUjw==
X-Received: by 2002:a17:90b:55cb:b0:35b:b52d:f34d with SMTP id
 98e67ed59e1d1-35de679faa8mr4010649a91.5.1775257384560; 
 Fri, 03 Apr 2026 16:03:04 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de52435c5sm1128391a91.4.2026.04.03.16.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:03:04 -0700 (PDT)
Message-ID: <92f7b756-cf71-43d7-93f8-78b7d23844b0@linaro.org>
Date: Sat, 4 Apr 2026 09:02:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] linux-user: Fix incorrect sign-extension of guest
 addresses
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <099e8d07-985f-4cac-b0e2-99067e81b26e@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <099e8d07-985f-4cac-b0e2-99067e81b26e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 4/3/26 18:32, Michael Tokarev wrote:
> I'm picking this up to 10.2.x stable series (as was intended,
> though only the second patch is actually needed there), TOGETHER WITH
> two other patches by Richard, from this patchset:
> 
> https://lore.kernel.org/qemu-devel/20260128010715.347776-1-richard.henderson@linaro.org/
> 
> 813dbe869f accel/tcg: Don't pass NULL to get_page_addr_code_hostp
> 0039e5fd22 accel/tcg: Fix uninitialized hostp in get_page_addr_code_hostp
> 
> I could've fixed up the 8330da591e "Provide g2h etc" patch instead, but
> somehow it felt that picking up two previous patches in this are is
> better.  Not that it makes significant difference.
> 
> Richard, is that okay with you? :)

Yes, that's fine.

r~

