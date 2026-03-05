Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAC0F47CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyDNR-0004sK-9N; Thu, 05 Mar 2026 13:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyDNB-0004bi-SC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:24:41 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyDNA-0007r3-AD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:24:33 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82742aa5a3eso4310845b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772735070; x=1773339870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=al4V87LhvJIWGToQpLOyP3Za8pZMY81ZYX1u4+05wP0=;
 b=wyqjJOTH9S53+USOEz/fXhvBRXIWxUoITslE23vQy2kWFnx1QoVFCrXbPsp5JRTmPe
 5Y9FQZ7zLSzvJ3NvoJjZyttmWDvx8ypWGKqpRNkb1VoPOuFPVWkJJ7/xLWI1z1RpU5wJ
 w0BK8AZw+g6fZxJHNP7SJa8Mw9VmtinGyNG+NdhA37cOfOwUyZzb2N84x4tefkdby6C/
 7/lWZBBKuz8vvvmKzcpXN599b2ic9Pe/0IXGM2ZJVL7+epCZ9360r4GA21iaqhKuPjR8
 hZtUt3duCA+HgpNDBqOWywboPv9II/LTXlqHfOE5E1DCGeuOPClDScXmcsryFfe2IJje
 zG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772735070; x=1773339870;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=al4V87LhvJIWGToQpLOyP3Za8pZMY81ZYX1u4+05wP0=;
 b=hW74IhNKWsMQRv5tzb56HBEtLaZzTLmMGm+/G7HJkFXRDEaMsGuLSD5qrU07GK64zH
 qOLTbGHvMeAClsjc0vY2bj/gGLgJvaBaW+lEnmAaEkREyyI64C+fxiGxobBipjdUHyyf
 pXkyLTy05odS5+Pw2sOY8LUEJiKfwotZAfFPO6pnV1t2P8fQxaa5Y1tUV1axg1WnWxK3
 Hh5tv/Z50m3TKRkkY39Q8fbn3aK5THsDZrRIcpcEDA+lgMHct9KXsd5u+R21t2/CVx0i
 xtXWtTqC520556/iREB6iX3mqaRWUL6kOOPKwI1r0zdw/3++wrw71uSK/iGwzPFKA92K
 CGnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ0Ns9L8tiJrYnkQCDleLymLphaFQEcSiw/Fsj4X+p7yHAfA/dI/zdic301jMFnI0Nk1Q0L1emv+Ed@nongnu.org
X-Gm-Message-State: AOJu0Yx1LIcGCJGu3aLVobvLqCNqUIuaNQK35gJTa64FQoZpG/MjOHiy
 A+b/72Q8ILMkk0VVlr3v3IFf2YsYF87rXzo9fPc9VKtR2yHP5cRyyGHxQwMeh1lIi00=
X-Gm-Gg: ATEYQzwQj/oRtGbZabXeHF8yarSJ6Do38W6+gxWH3ddhFUSXm82GU0mZdOS5EMYov5o
 TnybbISPgNCT8jpDGRZKgkP1NfJF9dT3uiyK95l9pUaCLDjiTKRVX9lc16JtB6ly8qVUpEfF6tK
 CnoHK05+VDflCn9c45cXdygbPFFN82WdHDhTtqwSpxa0R8W3O00goQViXOVW1iVZk4VbwHgVnUE
 7Xm7YvWA9Q9r15F1xjD3RQ4AcftJW91MAee9KioBIsQB7MUZfmiR77GL+yhdwwy5lqMZFHkj4pm
 4InaSLfDGlrKznv6y+W75nKG4JYX0z8BmGk0uAaGbI5LGmf9MbAwbV7zD6x1jJmR9hpGkTOoG3Y
 TqUFLc4bkalz/qTxdKhKx/CSrOmU+azHmcrGucNZ47RnfUEG655LrM5Od68nlVDyysgPXwcSFa2
 iMJLJKqMTvOeAUHKHj2x0H+k1s/ipX1YOwQrqpnHGy0e5sXR0gb0vSZRlmv0kWqaL25UD/
X-Received: by 2002:a05:6a00:4399:b0:829:6e26:7d7a with SMTP id
 d2e1a72fcca58-82972cef979mr6266079b3a.38.1772735070243; 
 Thu, 05 Mar 2026 10:24:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297b151ba8sm4361828b3a.40.2026.03.05.10.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 10:24:29 -0800 (PST)
Message-ID: <f3de6b98-fc12-49cf-8399-cc651d563a7e@linaro.org>
Date: Thu, 5 Mar 2026 10:24:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] tests/tcg: add tests for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-5-4c3adba52403@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305-setpc-v5-v7-5-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/5/26 2:06 AM, Florian Hofhammer wrote:
> The test plugin intercepts execution in different contexts. Without the
> plugin, any of the implemented test functions would trigger an assert
> and fail. With the plugin, control flow is redirected to skip the assert
> and return cleanly via the qemu_plugin_set_pc() API.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   MAINTAINERS                                        |   1 +
>   tests/tcg/arm/Makefile.target                      |   6 +
>   tests/tcg/hexagon/Makefile.target                  |   8 ++
>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>   .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>   .../{ => plugin}/test-plugin-mem-access.c          |   0
>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 134 +++++++++++++++++++++
>   tests/tcg/plugins/meson.build                      |   1 +
>   tests/tcg/plugins/setpc.c                          | 109 +++++++++++++++++
>   9 files changed, 273 insertions(+), 3 deletions(-)
> 

Thanks, it looks good!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

