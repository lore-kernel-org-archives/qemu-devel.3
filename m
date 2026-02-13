Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45437EF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy3V-0002rh-ML; Fri, 13 Feb 2026 13:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3T-0002qD-A0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:15 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3R-0001WR-Nu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:14 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-824ac5d28f9so1021847b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007892; x=1771612692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E3wuhGK2bkpQUIDhY2SDv4KQPI1/dMb+AGd8OCoy9Z0=;
 b=GDvLGmaoCQXqWqvMhKlxh7h0z/CQwic9W0OUzvS8vMXSeN0f4hGUwbYbTX/dYRcVUB
 dhbtcaRorJGBLDRom/l9P0Rbvg4zJHtIlMsyCPCy23szB55f2FDJu8kNafmYH4mOeGv4
 uM0NF7VXEvVJWZk2WDW+bDIiz3ofgBTY/739zY4mn0J5YoXtZMfB5XKCuynwDo217ErI
 U0VeWGQkpPck2LU94xuf20LStPxGtyNcdlgfx/orAlUMRoXEkU+AoFSHnDRtWxgcrof/
 WLP8QeK7MZfJ0VtsbS7pZhqPpREjZ7/9rwHgpYWhzaO6Z5m1lg5HpjKqA9+KpaXkuaZL
 CRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007892; x=1771612692;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3wuhGK2bkpQUIDhY2SDv4KQPI1/dMb+AGd8OCoy9Z0=;
 b=d0gcpKRYb0lLemMf7iyPqxMriHxGWbsB9Jmgq2pGXolJbyyv7f+4f+I9wg9ZaRcTdM
 gDKBZI4oeHxFcGqT5MEX4ODipUZWykO4CaQeD9rZR1e0gVVvEV179GmyTBwNF86Y5Pw4
 jBIu/nJ8T7Src9ftg/q+wT3JGNbyYBRM+tAdGhX60eY0SzH5lK9L6dvaZ0Yakb0xkco2
 aXrJ46LJijRxkPw9oZTp60bURVOHyRB9YgsSDD0YPmQp2T6cC/bTKGpG8QyrYG/BJMs8
 xHiAmDhd5nis+HTjH4KQb0J9l6Ikd/vMhwdut625uwlH4nheyE5gsxibn5jF81xfU6Vn
 VNWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvnydvOlIlIdaSB4VcLkKIVk2OJvBS4RKyChHttZE8NKupUza+AWY5/6jbnXGMQBpx1XtMQiV+s/vK@nongnu.org
X-Gm-Message-State: AOJu0YzSkcmVlkRXwUvP7DMvCjIIk75XiFHujRi8b8iGJTkvf8HKbSeG
 FWiof+ZfKDX+KFspQSwX+vv6Yw25qgEdUwYzyW7F03zpAgUVIAMmU5TccrAxhm4PR0qshf/h4+u
 8DtAw
X-Gm-Gg: AZuq6aJUbuFJ3RsgomRysRh198vlNJhKahS7N1s3sPdl9jyMkHi1fbnnMBK481JMmlO
 NHa/GwqUtBv+vwYTUf437XZiRyve7llhLeibLPujbbsJTsXK5BTQxiXw3ns+KKkIIJP0wFGSjG8
 Zc4VZN4JzOgNhuER9j7Z9ddUgmBNBbK9cuoOEYmEQPf+4FcqVK27FfTA7XqfLAZOPAB1xnDONRS
 IR/r2ERJRi50vmietrkIvSDBxGMENCxtr3xIQg29bSwge+KgjXU095pOgSGN5txMorKFj2r9B91
 1iFMqnWMLnXkDJRDLpXz4yiF0jRTWZKykBp6MzHF/n1LG2b+RdYHRl/Wuft7kfcxPQhbrebUIq1
 ATVMnS/SmbILbH/LTQLUd6kQ5wYTWrIMZJbJC2VZgh7xu4q4jY8Lm/5MLdqxBQF2XQf4JGiq5yy
 3cu/jgT1eF5Rf2eyQKniRWX1XT+cw+UuutI19cH/peytr98XkgmhSVcqwYZshxsTlo5U9n
X-Received: by 2002:a05:6a00:992:b0:81f:57a1:68f with SMTP id
 d2e1a72fcca58-824d9611632mr194368b3a.47.1771007892126; 
 Fri, 13 Feb 2026 10:38:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431fesm3372078b3a.20.2026.02.13.10.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:38:11 -0800 (PST)
Message-ID: <ff08ef7f-c3de-43da-8dbe-c00c722ecef5@linaro.org>
Date: Fri, 13 Feb 2026 10:38:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] page-vary: Build set_preferred_target_page_bits() as
 common code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <20260213182713.44924-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213182713.44924-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2/13/26 10:27 AM, Philippe Mathieu-Daudé wrote:
> set_preferred_target_page_bits() doesn't have any
> target specific restriction anymore; move it to
> the common counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   page-vary-common.c | 10 ++++++++++
>   page-vary-target.c | 10 ----------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

