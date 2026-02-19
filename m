Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2439C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBRo-0006bN-CJ; Thu, 19 Feb 2026 16:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRc-0006Tk-IA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:20 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRY-0006rU-Nu
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:18 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-824a9348603so593902b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536015; x=1772140815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbL0/Cj+Zw2YLIYH9Ytjn4ztkg7Hzhqk4/xrgyfn7TE=;
 b=cLPMJIY+d2mPN1yo1qYKE9ly0megTIhtT4ORHdA1ZXPKNG2W6/+0VrfxmUTtyxntAI
 mAW8Qn/3u42R1/S8cBilK9UmEE5J/xL/IYs52gYTYkZmamz3ssRK6i1EYTufAHzIEam3
 WX5abdIQcKPFxXQVBtK9FcsWOasNYUsrJOtdGlONg/cz6K4WXbnJN438ZU5OHDsKNjQ+
 vprLnxp5SUmCRekh4okYCwFvk9XbSHWZrEzafcVRwmgfHBAkgVOXFkqOt8LFIiH+Om6P
 F1aaeEBQ4JdVgtMBBuKf2U8OnRYobsFZ/sfvxu47erR0JeL00idawGYSxshT+K5aoeoa
 aSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536015; x=1772140815;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbL0/Cj+Zw2YLIYH9Ytjn4ztkg7Hzhqk4/xrgyfn7TE=;
 b=Un1kwvC4kduInJMjNVCikF6EHIKZ2yBrcYHhKWW4cfaoUljv40LvjL2+tC+IX9UHEJ
 XYCQg9Ia8jnSzI9z+QK3AQ0bi/UNFbb/jum7MLkaHRVoUc/G5pHNki54mO4hq1fUfw5/
 +TXJ9KRP7goGI3VYuiABs0blT7ToIWAJTAgxpiTiWKprzkhAVIKbYjO1B9cb/5b4LLkS
 HsRhOyX4+iyw1NoHlYl+oWIrvoPFz9LUxxDXQNmoegA+F3Ys7C8u9ODOc0qwDyh1FQVT
 qgaZLiQrw/0srob2zz7oNXQzg/z5g4BbXcoJuL17IdUpLQ5w4vy+ybBHwahdxMepGG+l
 gLrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxqjA2zEEMawLeDn2AxlisteB99PcX1LNQRjtMHCH/pKrzBx+44oMzeoYwgNTevTS56aINPZS6gno5@nongnu.org
X-Gm-Message-State: AOJu0YyMdjQjx0Y1W6Eg0yveGkk2bG5XRtEzntmcnz+vlTfFyJMimC+B
 PqxItZME/gBys74U9V4txYq9KeEWgHqc8UMs08hKSliAob96imGLIgR6FDkFPssxbll62MuBuso
 B3ay6WrI=
X-Gm-Gg: AZuq6aJTgFq8FKNALNPIOlqXr39TaBn2ujKLCfzagfqwWksIPMMA7ymAbdu/7oOmpPd
 2LQUqnM2wrjj3eE1z13UGTvYMJXHkCPKHO9171Nci/gOLl06zu5npusN3/B7hMlN2EF3RnQ6VJ6
 Sfzd01cRbq7H0t2gPQ5R7s8btOhfOd+uTBoauahLhMfbSD2SL5WzC5MObEVpHH+EjJQC/hFkndM
 Sj6fy/42FQqDw9NIwSy29DmHsI2fj/mL5D6YtajoU3jP7xqzRUvR5kTvX3rzNR+MDrDhZhLWbw8
 W3puyNd4FvFxObVUgrVq3+u+E/1D8B/+bkIfVJFtDh1DM2lH8A7OLR0hLO/oezvVDA70tsVIgW2
 UpdxIH833liJ2VA1zmkpeyvYh6+e9gs9+sDtHTl3QXS2Q/v/jXJpvEPAleZDXzYs78WavtMKbnL
 tz7QNp4VgOYm0dNnNonG7ac/gVu2oTWFc9tK3inI2hofaJVGj4BzXAZFBQOeE8Ig5E6Pjy
X-Received: by 2002:a05:6a00:cc7:b0:81f:23b5:dc33 with SMTP id
 d2e1a72fcca58-824c94f9c21mr22036871b3a.30.1771536014850; 
 Thu, 19 Feb 2026 13:20:14 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19782746b3a.6.2026.02.19.13.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:20:14 -0800 (PST)
Message-ID: <32932754-dc59-4393-99bb-d736dd11ad48@linaro.org>
Date: Thu, 19 Feb 2026 13:19:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/50] target/or1k: Use XML register definitions from
 GDB
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-23-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x443.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Import gdb-xml/or1k-fpu.xml from mainstream binutils, tag
> 'binutils-2_46' [*]. Register as CPUClass::gdb_core_xml_file.
> 
> [*] https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=gdb/features/or1k-core.xml;h=0d13f355f5296ae426794eb3003dcc18fbbd49d5;hb=refs/tags/binutils-2_46
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/or1k-linux-user.mak |  1 +
>   configs/targets/or1k-softmmu.mak    |  1 +
>   target/or1k/cpu.c                   |  2 +-
>   gdb-xml/or1k-core.xml               | 65 +++++++++++++++++++++++++++++
>   4 files changed, 68 insertions(+), 1 deletion(-)
>   create mode 100644 gdb-xml/or1k-core.xml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

