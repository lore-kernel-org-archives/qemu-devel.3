Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA0DD42B88
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArss-0005fr-UD; Tue, 12 Nov 2024 09:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tArsp-0005fa-U7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:28:43 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tArsm-0007bU-Ew
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:28:42 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so63031205ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 06:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731421718; x=1732026518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQcDI8fUgXMRlsPAUnoF2lGP3I11kFSL55yqcOC+SCI=;
 b=xxcZ8KJX3Kh34PjAY1gjUR1vVCWold7EUacWRvF4TqihYxftEGz5bS0J7l2kIGyU22
 6foKPgNruI8Y7LOyl8Dy49KywDeHGYclMJFbvZ0bioITUk0cKtURIbHWLKAzeYtXpVZS
 iGJ8XRMMCu+SKCeq3GSAu2pyOigYjgChKSiTnzQQ9sqTfie8M6nh34ejvV6Jxjf39qoG
 Yq2k9MfPDiRfW5O2+tPURhoRoACqKGDiwGGpi+QIlDJtiZZte+bMGK60xe7fUTjo5eXN
 NC+CPEIJ7NdfuBYWD3uNAWOkmxC2SXcLzHteN/WJcMXEi8aWmBzK+af6JwSwzu9cX+/E
 M5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731421718; x=1732026518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQcDI8fUgXMRlsPAUnoF2lGP3I11kFSL55yqcOC+SCI=;
 b=cWqEzlEiMz0eYmgR4p4eJsAH4Lzws0Vkp8Jjuci6ADPEnrPfH8oLsRg/2ZL7WENNn+
 PJctBASdnLXLDAWQ7s+4SXy5c4xgtO0qwGo61KdKdMYzpVIV2q7QFyJYV6VqPiwjA+NR
 HX6lPnx+H3XxcYMYtIdfhgFzTeXiuBOFk8/BiWpn4pT0zK0un9yledTAuo5kT8L7DH0h
 vI6ewUN5SR9Mef+qxY5Xpq2ZrVi3S5aZTkdRdsnBpMo6xoYKNe220OfTvSAziMNFPCzd
 AEfORFRwMrWUL6RrCEHs7tuMA/HZ4FsHgMIkoxWkrxnQ121pFdaHObSassUDurQFNEvr
 eNsg==
X-Gm-Message-State: AOJu0YyI0Ddv/USsYB+vsuQSw0VwdCaMF0S8AZ6r7kHjyB42bIclrnAN
 +kEtaAuUkwMowWBmA/VJG3OkCVqEcmy2fFNi240Xq3xhJJ58DnaiZ22NYO3Rh06uabw13kyfE1/
 P
X-Google-Smtp-Source: AGHT+IH9aUqGgXW1VNXnUZ1zjXaVZaW1OXk54Rz9q5VfqRJVwH0zlIYTzRW6vZzMDrra0KxqKZUWAA==
X-Received: by 2002:a17:903:2287:b0:20c:c631:d81f with SMTP id
 d9443c01a7336-21183524f65mr230736215ad.21.1731421718598; 
 Tue, 12 Nov 2024 06:28:38 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e5a040sm92127795ad.209.2024.11.12.06.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 06:28:38 -0800 (PST)
Message-ID: <9132ecd1-a128-4ec8-86f1-b00b7f2b7338@linaro.org>
Date: Tue, 12 Nov 2024 06:28:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/mips: Introduce decode tree bindings for
 nanoMIPS ISA
To: qemu-devel@nongnu.org
References: <20241111224452.61276-1-philmd@linaro.org>
 <20241111224452.61276-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241111224452.61276-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 11/11/24 14:44, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<f4bug@amsat.org>
> 
> Introduce the nanoMIPS decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.h              |  2 ++
>   target/mips/tcg/nanomips16.decode        |  8 ++++++++
>   target/mips/tcg/nanomips32.decode        |  8 ++++++++
>   target/mips/tcg/nanomips_translate.c     | 14 ++++++++++++++
>   target/mips/tcg/nanomips_translate.c.inc |  7 +++++++
>   target/mips/tcg/meson.build              |  3 +++
>   6 files changed, 42 insertions(+)
>   create mode 100644 target/mips/tcg/nanomips16.decode
>   create mode 100644 target/mips/tcg/nanomips32.decode
>   create mode 100644 target/mips/tcg/nanomips_translate.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

