Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088BCC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOAw-0000GC-24; Mon, 12 Aug 2024 02:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAv-0000Bf-03
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAt-00023m-Fc
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso38803675e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442698; x=1724047498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4A9GIQBcli147kPhv8lD9pxeK0t+3sYoQnuj9bcSMaw=;
 b=ZOtjEw+shFZm9nwgQp7S65DB81i8ARYwmWa/Ra43f5f5EwaxVlWrAGn2kssF8owwcu
 ++NxKl2/rUZhGRnXYqOnGftWDMOwARDjcl2o2t+AbE6wL5xr7PrYH0jfPaSv/r1weirj
 HsV7twJLcUyWruLlZKu4LFsIGkve+rU0YH+UIxsVoV4FzejB9DYUwby8Tr5Oz4RS+xPD
 XidQmgGfjT64lIxJ5KEkNKhEWdh1qpVqS3+cLGJGJhYJ7sIdHHWDtETWd1Odhnj7YQFT
 fEgSb9yZxbaTx51/Y2Vdw9i9ZjXj7UZyB+cRIlD6JKBAWHNBTLdO3MFvZ5gnbdEzCqFo
 JVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442698; x=1724047498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4A9GIQBcli147kPhv8lD9pxeK0t+3sYoQnuj9bcSMaw=;
 b=t/jFx9xZ4++S0s13H1QRR3qSHTvhe80MrHNc3XvBBhSeEBU4sgWGpoZ5tLwysxPrWz
 r+396zjXXgHHEJPEhxbm2uaegdZFrhR+RMLNUIKlqBoiFOnyRQ+z/edLTx6YOOyDzVqO
 fqtJEaTwuN771Q8AIE536N95Xt2eSn/W63Kggj4WwI+0Ajigd7kXtjWZBslN98R5OTso
 1e1IQiY9IJkAWFqgOUzu2QsJcBBoellrGfVcZ68wzvfDgXoByPCEmz/DI3MC3nQehc3n
 L1LJzLYdIfB5gyHb9eudtg0qF3nCiZ/uxqsqKZ79LFgOm9UgiwhKkeY4GrI94F/tUmfw
 S+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZTSt528joZ2cMSFSMtdP+0Z4a1hQjM01d5p3/mNemiOCp+5dKGE6DnEnz5KvOUUDKjm8AdUMmpNS4mBEKhD2ZNdRVaS8=
X-Gm-Message-State: AOJu0YyVqx3Kb7NSdIbfWNY0LYhAzUZOWXcoNukrF3gYHAec8nTFtbbk
 LMFgPZ6cXmZtszDSKxCEWweFRs/Y3mzmusw+7zLIWK+bqpDNThG4JdnCqfJO2TRHxN4ZVB5Fv5k
 R+MA=
X-Google-Smtp-Source: AGHT+IGCvJJ5MI7TlDkxfHvxvs+EKVU7PFd3GwmBdfOYd6/dvQvOhdiB5cyM1VHOaafxneJyWW5hWQ==
X-Received: by 2002:a5d:6ac8:0:b0:364:ee85:e6e4 with SMTP id
 ffacd0b85a97d-36d60159d62mr8150220f8f.53.1723442697927; 
 Sun, 11 Aug 2024 23:04:57 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:04:57 -0700 (PDT)
Message-ID: <cfdf84bd-409e-4589-b89e-34c57f188e41@linaro.org>
Date: Mon, 12 Aug 2024 07:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/m68k: Implement packed decimal real loads
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20240812004451.13711-1-richard.henderson@linaro.org>
 <20240812004451.13711-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812004451.13711-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/8/24 02:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/helper.h             |    2 +
>   target/m68k/fpu_helper.c         |   89 +
>   target/m68k/gen-floatx80-pow10.c |   30 +
>   target/m68k/translate.c          |   22 +-
>   target/m68k/floatx80-pow10.c.inc | 4933 ++++++++++++++++++++++++++++++
>   5 files changed, 5066 insertions(+), 10 deletions(-)
>   create mode 100644 target/m68k/gen-floatx80-pow10.c
>   create mode 100644 target/m68k/floatx80-pow10.c.inc

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


