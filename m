Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79F7C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiFn-0007HA-7d; Mon, 08 Apr 2024 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiFk-0007GG-UI
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:13:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiFj-0006jr-50
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:13:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso5373106a12.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556788; x=1713161588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yyVXW/tOOcf178Yz/V/TmnBdgySH90rpKbBwDkRWcg8=;
 b=D7sccBouJSo0LikM1aeW1PINb4nRgf6wDaLSS5ej7RGRUkoRBuOIvbcXCeugx98yYE
 orhqESJEGd9UJZCqNFEvUGbGytufde6vEkQuRJZ31EDHXl4HeILg61CyoNzvi0ixituD
 UyyInl+1Hg/s9/H8O7sZg7QmRIi6ef39umeJ7jCIHp3WQaOcduH+w/x/f43RXhJ5JtKI
 X65zINOvYUK4mburGAvUme1iMHjAJNj5z6ooQvx+TlWsArNbcA/EQUl2PZwfszdbwFRU
 Z0mKpm0eyx0dRvvx9kdaWFex0DO2OJeyeE4az82t6bFUpmJO+l7ml/YGzz62VmfVktnu
 Gefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556788; x=1713161588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yyVXW/tOOcf178Yz/V/TmnBdgySH90rpKbBwDkRWcg8=;
 b=NR3CJ+9+4Dw4rs5ILiTcdm20TSgN7GeYUNJSU0Z/ctlqziV7Bq9YnEVvb7GdgfZNMT
 ZvaLk4LSxHjg/NfLDu+3Zc4R6C7I+WuvsAvd+G+3e/MA8zGsxA0j1FuiigmcDpcjJW1h
 UauqNCyWbphxl84EhXReXRq/O0n3u35QcPiniW6xjI/iXJSL9Dnk1HKFVoDMKyP9wo30
 MVgvOzEW/djDGJ0LzFD/aL0lw852nX4QrF0Sx1RnBtRZHxWW5nrjXVd27/glzC21x1vU
 e4sAreFMGbIW2Np9XuNo1eZdIpdjDcZHB6/qVwRtp22wgsM8EwpSGSRysGehKi9GTFiP
 TsDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULvSuJke+YGJp75R2i5+7eFFDjXgkee5ZlLY9cjB0mzecvYsNTaa46nbyjydP8RuUDuW4DQYChaCQgOusKpLRLFPxB1P4=
X-Gm-Message-State: AOJu0YzjqbLK7YgTP5y3TbdmDDlAt7jel3v/yv3b9stGnP7XO0F5nklJ
 NhtD/nQyNNgXK6sxN37i51WI9KtZvtC0BKsXPv7SHr1gFifJv5F4eZATLoEKCBc=
X-Google-Smtp-Source: AGHT+IHLe236STgkc0K97DkpWNrjCr0nGKvr+Cpxm1ntbJYrS9+Iqdo5GyxZJblU5FqKxteaTLyr/g==
X-Received: by 2002:a17:907:6d0a:b0:a51:a259:a796 with SMTP id
 sa10-20020a1709076d0a00b00a51a259a796mr6602519ejc.56.1712556788525; 
 Sun, 07 Apr 2024 23:13:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 el1-20020a170907284100b00a51ce6730b5sm1546216ejc.84.2024.04.07.23.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:13:08 -0700 (PDT)
Message-ID: <d17878e8-91c4-4628-9be0-43261ca35b50@linaro.org>
Date: Mon, 8 Apr 2024 08:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Add TCGContext.emit_before_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> Allow operations to be emitted via normal expanders
> into the middle of the opcode stream.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  6 ++++++
>   tcg/tcg.c         | 14 ++++++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


