Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnbh-0005ZO-PT; Mon, 22 Jul 2024 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnbg-0005UJ-F2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:37:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnbe-0004aB-Ol
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:37:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so1918235f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721633833; x=1722238633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wh1X5/gGdqYMAPh7t9IoUo4Tg3NDFI0W4MCYycRmw74=;
 b=KSla/KENgPPXwI4OlXRx8ZzMEMOCzPgwpdFMeQB0Hhe/AsrqP9x1NAl2YKUX9+NNcL
 Xuj4YOybwl7R/MpYfgFiDxPdDBXBPs01RfKVJcS/tJQqmAWlVUb+tVt7hT6ZuamCfoXh
 M3GVbLNdQQQ9AxH3DXAGiDwA2hrVF73qD0eDECJSX+YoYgMJ/tUVdb0OFT7gl28rjN6Z
 D7+eF/OFw22+drCXNqRODSyhnBD/lYjoH9qjqWB0Cmw2EeL5U6MtQRtBkMoHms7M9kLr
 JmJ0w0iAZrn9uC1iZzlOu1e3botPMShWmUjcJdP+d4ajn6M+4HgvZDMc61xQ+XOwNsY+
 /9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721633833; x=1722238633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wh1X5/gGdqYMAPh7t9IoUo4Tg3NDFI0W4MCYycRmw74=;
 b=VYg1eLSaIUZVKPK7xTM7Gw+sZtHO6vowYLGHlBGjR9dnA/NWKOJiCpQ7J2FJwtdQ/6
 Kozh2k7Z6siWMUQEM6iCfqcvSzcRQ79juJR73KNpNquK1ijoI2q4SbU6C6jYXdsy8yi4
 aBhWjZVf5//O+1qEVXE/hjx1Xe0scgW251bVBowk9XvcQ3ud8X/T0HY7Zhdwxueh4QlG
 o4X546DK0Ri+l8ZpJOfVaY9ki9SxqPc6OrI9i5NwN1JtOAPR87MHjxtTV2b7u98fjzad
 +ywjD1VYfL9SF7SMUJgdIqcPs/wwe0oZEtM4VPKtdHhOkHIolAHGR1RcUXPO14MB5xTT
 gC8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAEoyiG/oeQiBOI8rSMwR5wB1iIL5lJ351Qje6sk7Xh9rXBFnJk4DH1QVLNmfzlzWZ7QlonHryr2nSG75vQi6lC41pLMU=
X-Gm-Message-State: AOJu0YyyzfMQ+mLzJqmVYvrTf5/YUT6UOEKQ3uyb/19ICttCSAddM1oO
 h0czQ/s+W9wK+me8Z6wN3v39YjC0EmSLOBlFAAx1B6fXCFpYPAX3lyad5A3T9GlWeukABzuf1dB
 z
X-Google-Smtp-Source: AGHT+IF+64tAoIC+o6BIK2C9o0CY8GFb1oFxzQVFQ7PppJzMho4fCrRvQy/G8NN+Xua7q2aSrtrqAg==
X-Received: by 2002:a05:6000:4029:b0:367:9854:791d with SMTP id
 ffacd0b85a97d-369bb2a1bdbmr4415233f8f.43.1721633832874; 
 Mon, 22 Jul 2024 00:37:12 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed28dsm7648982f8f.104.2024.07.22.00.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:37:12 -0700 (PDT)
Message-ID: <3d5d891c-7e8b-4b13-8fe2-c30c5d2223e1@linaro.org>
Date: Mon, 22 Jul 2024 09:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] make range overlap check more readable
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 22/7/24 08:59, Xingtao Yao (Fujitsu) wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Monday, July 22, 2024 2:43 PM
>> To: Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>; qemu-devel@nongnu.org
>> Subject: Re: [PATCH 00/13] make range overlap check more readable
>>
>> Hi Yao,
>>
>> On 22/7/24 06:07, Yao Xingtao via wrote:
>>> Currently, some components still open-coding the range overlap check.
>>> Sometimes this check may be fail because some patterns are missed.
>>
>> How did you catch all these use cases?
> I used the Coccinelle to match these use cases, the pattern is below
> range_overlap.cocci:
> 
> // use ranges_overlap() instead of open-coding the overlap check
> @@
> expression E1, E2, E3, E4;
> @@
> (
> - E2 <= E3 || E1 >= E4
> + !ranges_overlap(E1, E2, E3, E4)
> |
> 
> - (E2 <= E3) || (E1 >= E4)
> + !ranges_overlap(E1, E2, E3, E4)
> |
> 
> - E1 < E4 && E2 > E3
> + ranges_overlap(E1, E2, E3, E4)
> |
> 
> - (E1 < E4) && (E2 > E3)
> + ranges_overlap(E1, E2, E3, E4)
> |
> 
> - (E1 >= E3 && E1 < E4) || (E2 > E3 && E2 <= E4)
> + ranges_overlap(E1, E2, E3, E4)
> 
> |
> - ((E1 >= E3) && (E1 < E4)) || ((E2 > E3) && (E2 <= E4))
> + ranges_overlap(E1, E2, E3, E4)
> )

Please add to scripts/coccinelle/range.cocci.

> 
> then execute the command:
> # spatch --macro-file scripts/cocci-macro-file.h --sp-file range_overlap.cocci --keep-comments --in-place --use-gitgrep --dir .
> 
> but some of the matched cases are not valid and need to be
> manually judged.
> 
> there may be cases that have not been matched yet.


