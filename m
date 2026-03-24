Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AA1F532CB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 03:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4sGI-0006Vm-Bq; Mon, 23 Mar 2026 23:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sGG-0006VR-NP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:16:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4sGD-0006Os-6H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 23:16:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35b88a4f123so2364604a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774322211; x=1774927011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kiIKXuCPvyAHNddXS0qqhzacmveeGDjRpNLclwSiWG0=;
 b=qKgez1yNdQvdaCRGVcZCKodwk9eHiBp5zO9X2dm1+ARyX4pgnYKqqpn60dI28Qy+wZ
 GXHRdsJ3BoJIL15ksUZZ+0Sxv7dQrugnh5joe5ckdiFXZtRUTeuv+BmkaxQjnZ82ES2w
 jhn1Kk+o2TDMi/kF1689IEUOOAJqrrWB+0X+8U71LsekJX4xolj4R0tUzQvVS4Wqtdcq
 j4QYQV8jsnZvFp8ylD1CebdOLxgI+eWea6nKZNb24s6+9JqKbpoVbfmRE/6wFPw7q6ee
 eB6aKI7a6RsGUhuygt/mp3jSQH0m+vt2MsAk1s3ASzbCPAJXgFkVOOPNzb1jjo+bPaPd
 pJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774322211; x=1774927011;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kiIKXuCPvyAHNddXS0qqhzacmveeGDjRpNLclwSiWG0=;
 b=UqWrBQTotVm8mseKTb5+//OjCBBVFgrrwDvCz0ceBvsR/5uGKq/PsP6jq4TOV9I41c
 BFfJ/2cgha2/rN3ipBMHqZWO1SC6U04B1LhV1ZrPdtBOBLBZYE7vJRpT272P9vNoOl09
 /vdiCmXnF7PP0170BylUPjQdoY2jo8Vx1UC5yS0jquRhOvBkTxyKS+49FibNnPlT7Xud
 m2We6KUKyDVf9Ao7eT2ZfwikDM15qhyAP3NPCrcN4OogcDUc2BqcPYjBoovHbfDaLiW4
 POTgfE20kAz36dKrDuO0ROy6n2m59I6WVVE1hHr/Y/6TL/lCmZNp3LF9ovLQjbYnsOp5
 5NzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvp6f31R64jZsspO9cPc8sBLuk4SVgB9EuAMXvcXt1UYkzZ53PgMGNSK1WjuRyXuibRwxKioS44uQQ@nongnu.org
X-Gm-Message-State: AOJu0Ywk40UvO/xBbOpSyaGhUhzWjZIxuDBwvFi+sCov6pGPTHgrDLCd
 /AX8EPf6jVZx9qqcZyqEaNSIkjJHHnLqbJ4T7v3uNosyW4FSUzcdVXJEoHO06TwGq6s=
X-Gm-Gg: ATEYQzwWP0s71KEp3ZM0B3MhkWHU9xELnNiLjHo7+ou6vZEqcz4k5Kwt2d279rpyH6A
 BzI8o6jaTAiS7myCB4nbw+e3dnMdBiahPpXG+P+xaelrl8hHPlm4IDgP/GJVa4bhYfb/Ya90/j3
 ZpWVqJhn87TY7mkpGqDoojvyDjcbRZoojx1CAkfex0314HrJgdMoqAj2zzeGB3XG06YjymmBfYz
 E+n4F3VhSmHSa5XKQn9OXLnPbzxxqFu9NXqfTPRgKMSAscRpaUYCBVDTzUtqiKwzzKEqjmitH5Z
 7xf2iVmAQWpPZ3oOSwl1Eg9rD7XT7DcBNCNR3AtrNgjnTsMY600/COeVLcifhb/rFme/B7VgUHY
 vuzHFsFM1uoFBXXiDdxOQekyg/Rezyo8Vqe/cYR9sgLuddI56XNJE2OBbBvk+QvVWMSWKv/KG66
 dKRkuWkHrMyvZhnHuWUU5BAvzAWOknRJZck5nY8naS/x6cSaokAE5tPXwQ96bbxIq6EQE5chzf0
 J17wjA=
X-Received: by 2002:a17:90b:528b:b0:34a:c671:50df with SMTP id
 98e67ed59e1d1-35c009133c0mr1468363a91.17.1774322211312; 
 Mon, 23 Mar 2026 20:16:51 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c03172ec1sm553756a91.16.2026.03.23.20.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 20:16:50 -0700 (PDT)
Message-ID: <0ae1679b-fe47-4209-a540-43f2f23058ba@linaro.org>
Date: Mon, 23 Mar 2026 20:16:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] monitor: Correctly display virtual addresses
 while dumping memory
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260323095020.66658-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260323095020.66658-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/23/26 2:50 AM, Philippe Mathieu-Daudé wrote:
> While reworking the address format width in commit 6ad593a75a8 we
> introduce a bug, leading to addresses being displayed with too many
> zeroes:
> 
>    $ qemu-system-ppc -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>    (qemu) x/x 0xfff00000
>    00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000
> 
>    $ qemu-system-ppc64 -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000
> 
> Correct the format width to restore the previous behavior:
> 
>    $ qemu-system-ppc -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    00000000: 0x00000000
> 
>    $ qemu-system-ppc64 -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    0000000000000000: 0x00000000
> 
> Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in memory_dump()")
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

