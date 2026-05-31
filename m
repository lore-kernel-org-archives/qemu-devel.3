Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F6FCD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo4J-0004XO-Px; Sun, 31 May 2026 17:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo4F-0004X5-IW
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:51:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo4E-00023C-3y
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:51:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490a7682635so7793355e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780264292; x=1780869092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLQNLAC9ZcyqI3Bh/A8PXt33vU6AT1v0tdepQfuvIyM=;
 b=OQ3JiLXDBycoBghfev3/iv3wNR5WbepSoZ9zw622zTsWr3o0Q/NDXxJpwVrf29lIeZ
 rWAuYe2Do2qo77ch5q5LdObdTFFX68lIEgFH2uoP+/GGFMxsJBZzgyNwYW16Zcpqh4t+
 rP7gu1DhPi4PhRis9r1RaeTXNQiysl6cMDJE8lrPvecFj7Fhygp0P4IKYE3POWp6EEJ0
 DSqiNN0LCz/FKqQcrvtIZGYhc8LXdFiee5YRDZVbgO9Gvfq8APfnlPkfqHMYgNooVZ7S
 TUGwo5BhDqKGQkZWjVVO+NTGMTYDkiijw8AcyJh/NH1oY+n+BVGAvGZhJ1YO7sBNZLCd
 2XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780264292; x=1780869092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LLQNLAC9ZcyqI3Bh/A8PXt33vU6AT1v0tdepQfuvIyM=;
 b=mlMcdlQEx9o0SGKoxCMwobsC++gPnI3iRFvq38uZH2Mru/2eP289/GaEH55aCMXA4T
 4bLbKLV0Dv8i5H8ZIfVVTHFVTmipEgNUdzQg9DGDKZp9DIElQZopI9EqyeECYc5OjwXW
 1c7mRNjVD+6CCIlEpapZdEPnLb+4+s9EHheOcFA8t0eYiFC/KHZug3xYd6u2iblG3ICA
 O4OmhIRvAdvTMuF5F09sT+W9B/TNQx1bbCTqKoSh/uIPiXKa6rYufo7DGFuspTT1pJm+
 15z20apbufNBf3e+dONn3v/ICVPuomF21C1QRLsSEKD+Ycl0PJEv9qQMo6clAGbl+egj
 rYBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86BxOPQtlWevnm8m/zL3rOLefxQa6eUrBbI5+dNe+aYBJIYdp3y/koOe5z8Yw8xdUChkze9XjV5kQ3@nongnu.org
X-Gm-Message-State: AOJu0Yyl0msvI0uxoGhw4oLJaN56my6CmHK4CHXa2r7jDhYICl03sro3
 rcdcDuq90Ex0ZYbrcXBQovCFZmCCX7zHeEX/3MXB9DleeWUmYbeh3cfA9q9mbVTGA0WAssHEirr
 D2/68SIJpXQ==
X-Gm-Gg: Acq92OEMEtJktSmbS6HvmtxdLnBbbYHuuU7imLRFwqJYNzCWvNOvbU9wALk5esxTi7O
 32Jx4I80RKf5ibKvDila6Llchx3ioBhJK+l8hIRbN/GRyA3VYlrgGDS9FhawEHlmjAiePzHLSle
 /yhEA7BHMPpkyl2plkzFrAZDmSb5bEtSv0SkZKtPPVsQ7SjzyXPwhJGgz5FpGs5myUx7NXl3dtN
 ieXTB7NMq7FG3kS9hrWQ6umztnzZnek8T0Me25DxV6GmfQJKbAkM1opHVxdjN1dIJ7/0oo1VgTh
 akkBgzzW8Z/SeHBm6xTnSYE464NVy/reMCULnkkTGnfxLpHAQt61MgQWjfFtgaOvOHAVayklnb+
 n1Rj+ocjDtV7hpa4U1etMWL5BWNOxKJV8TsBOks+57JSL1uInszjSHIfNlmUSNWGAX4BaiZPDco
 sJcb2Gv0XFVBA/IgI0v/kg5v3sWLPIsiwI0XtDVN1nKYRFdDiHaf8v5Aadwz06xWi1wZfbe/nPT
 lrS
X-Received: by 2002:a7b:ce03:0:b0:490:5527:3be2 with SMTP id
 5b1f17b1804b1-490a29647aamr111836945e9.32.1780264292592; 
 Sun, 31 May 2026 14:51:32 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490aab4f87esm2906455e9.22.2026.05.31.14.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:51:32 -0700 (PDT)
Message-ID: <65f1025a-b3b3-441d-91b4-33ceb677e635@linaro.org>
Date: Sun, 31 May 2026 23:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] include/user/guest-host: Include missing cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/5/26 23:12, Richard Henderson wrote:
> This file uses CPUState without including the required header.

I see in cpu_untagged_addr_vaddr():

     const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;

s/uses/dereferences/?

Anyhow:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/guest-host.h | 1 +
>   1 file changed, 1 insertion(+)


