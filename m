Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DBCCF45BC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfM9G-0000RG-Hu; Mon, 12 Jan 2026 12:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfM93-0000Ju-2U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:56:02 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfM8x-0006Xi-1N
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:55:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso48134645e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768240535; x=1768845335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axMRkTREiAESIqegvVDIG+0UtrKi+edL7fRRI4/LDro=;
 b=ZdlQ6B9anKETNB1oVKhyLyuLzaTSyaSZDrTua6F2rsnZ1FeT0yHUs9vZPwe1QtPTPm
 SthR7Tqx9sT9vO722haPGvI+21MrmitP/XcNMc+skbnrS1IvN5TYajrap2pZ/0w8hyLK
 o7wghF3MNAHEJaMDIuxWUrB3Gl7HvBCnfeK/ovd/KT5NHH8iwSiO/IGIa8YPSB7b+vsp
 2h5RkF6X9c/Qtzvuz4oFYSakd1zKyszq3zffqrZq5IVkEl0lc+/j/+XgNiFidJSCXoi6
 HVpwgcfL2S2amGSpNse90M9pEQDnsspsAjNbaJR+X+Us6KQ6HlvSOqMTRVQ5QqpXrlx6
 0DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768240535; x=1768845335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axMRkTREiAESIqegvVDIG+0UtrKi+edL7fRRI4/LDro=;
 b=BIM3rvHgUADDnRMS8lhghMiPCxWinBy8Vtecdf3a53VvFafCkEarkYUlVvnz3LZoIS
 a5fV9iD8GCN6w9sXABwfaRrWJRSz0vTqgTWdI+9g4Jpxq4bfy/8z8SwcuBNhliufohy1
 j0QiJpdAifIh11kRybC4N7vp9FkjdYV4xoKYfMn86uW9kYaGGTsKCuut5TnLp+pVaYx+
 xKzQblLlY81oc1227sWEJhsP4I+aVnZBicPFAlFO6rsstHFl3vUDBCJaU+8S1K6jKjie
 bhY/uPXvuA4O2NOlqlHeblRLkgkgoIWJhP03PkT5ujF7TmOUspkfXDFyV1xl0jtZeyvp
 GE7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXggl0O8QtFs0wYQWXpjZLXz3/Zax/EDiqL/VspfWekKL3brFf1BIMqKky/ezCeJ+gl/QTcj0Ab0QFm@nongnu.org
X-Gm-Message-State: AOJu0YxgfjvV6NoLSHlKvunKnjzS5hqS/dePkoVIp5kbt8hF7o0tmMEG
 McUMxPN9nVtgrk5Oj0aQAYpQ1tuAMIgyNDpb4VeUql4mITHEVp+QphqpfsviaDD+Aeo=
X-Gm-Gg: AY/fxX5j1QyxbipuLFnFb5ShdmRdc9ftiR/DhjqHck7VH8zV0AwhOX01K4VY2JQN7wQ
 AZ4o2XI3VhdSLrL2s/BjKM3DwNZQwE566qTeIeqMMZxA5septsbuQqclk2z02DG1YDNtefDxEOh
 H2y5Wlni6siUWA+9YzGUE23gjq0urxe8qIWPJzCN3HwAPMNvUr1YllVEiBWjqpkLEUajTqnQ9Mp
 xDiLJFSH0F2eEnnr3ZnPR0vPj2XmV6LuEZkRzrPmJcawlZHwwN2gDExfePSF93rrrllvQkEbDTR
 X8gohAj1xbcYvRF2pTEuXt9H3d+cBUyo+PH1Q6u7JbeJgrVK/K+1h7AXwpb6uSdz53CfKpCWzfZ
 6oNM558m+2057Ef8NdWmlAMasUgKyXcbZ6o1/vRQ6FbODTwY5i+1epObYkncc9SC3aDTlldYU79
 kVQ2IUS1EM+PSNmlWqWB12VoTUiUk3CqJmwU1TxyJqgj5YQWW0uUXXYqcezL1BfHd0
X-Google-Smtp-Source: AGHT+IHgiCtDDBGt7ZYevP/JqhMmnoDNZW5Prk8HtTWQtJ8c2t79l70mTVAN9kbnBfcDsddReREnVw==
X-Received: by 2002:a05:600c:4707:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47ed7c15d42mr3626305e9.11.1768240535474; 
 Mon, 12 Jan 2026 09:55:35 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm361749195e9.0.2026.01.12.09.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 09:55:34 -0800 (PST)
Message-ID: <6a32c2ec-f888-4e00-9405-1db101f5860a@linaro.org>
Date: Mon, 12 Jan 2026 18:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/hexagon: Widen MemLog::width to 32 bits
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com
References: <20260112154048.27799-1-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112154048.27799-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/1/26 16:40, Anton Johansson wrote:
> MemLog::width is a uint8_t value mapped to a TCGv (32 bit), the only
> reason this currently works is because MemLog::width is padded to 32
> bits.  Widen the field to uint32_t and fix the size of the TCGv
> operations as well.  Use uint32_t when referencing and passing around
> the field, as valid values are asserted in commit_store().
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> 
> --
> Changes in v2:
> - Removed truncation to uint8_t, valid values of 1,2,4,8 are checked in
>    commit_store() already.
> ---
>   target/hexagon/cpu.h       | 2 +-
>   target/hexagon/genptr.h    | 2 +-
>   target/hexagon/op_helper.h | 4 ++--
>   target/hexagon/translate.h | 2 +-
>   target/hexagon/genptr.c    | 6 +++---
>   target/hexagon/op_helper.c | 8 ++++----
>   target/hexagon/translate.c | 4 ++--
>   7 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


