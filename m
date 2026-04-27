Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6736EFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSvk-0006Oq-MR; Mon, 27 Apr 2026 16:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSvf-0006KJ-Nz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:51:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSvd-0000S2-VQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:51:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d73422431so9917313f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777323099; x=1777927899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aulM67d7BFDT3oHj42wERv13MKSp4HizLxeczOWAJ0Y=;
 b=OAo+cmj1eWwcY/1XwPVFLBEulpLQveI1YKqNB2ketnU8Bow1dY4grmXpAtorMdJaRP
 LpFQG/h8C/ZPrgI1qLHvt0ugih629/m297LKfFfVFnAHv8jNdnFzDfaT5ncbxNhjNklo
 a0+znsT8s7g4R86Jnue9fmhiLy/PnwnQnu3v1kuWSU90wno4QM4nK6ysQfyn6NmLnSPL
 uotKlGJWqi6B37QbKpb4VxGpCAHyh5QZczWQIC6G848L0OEqTATHkjpuuH0Jfr6ykvDw
 F4l7ItFOK6da+y2EWYp8M86FEWnSmiv0SfCvVpycWE2wFTua0DhtjrrAiJv3hJLrq3+W
 uYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777323099; x=1777927899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aulM67d7BFDT3oHj42wERv13MKSp4HizLxeczOWAJ0Y=;
 b=tQ0XQV6iG1CIO89ADOTI9Ig980FPmtl4d00vixnjMZmjbSWBOz7cZymagxDpERrIER
 dMo2+EzKWOEXHjj3quafKSTumaBDjZck19J2RSBvoA8VvG4XatljXZExCQ43NkoRCsx4
 T9SjIn8Cms+lbRRwFAqSRcRKCeMbf8o6dNfWri3s15MWvAhYqrWkmKYcOMQTWLCGbBxs
 ctbLOY03zqFXNe4XEZY+wm4XFDHkcvh8P1Au8wgbNmy376yqoemdh63NexQBHWPmKRWs
 U7lDJwu7jQi9N6GGul5tGJopAb9fU8m0NHLLj8mZWRSd5UvP1Nj+3t/JSWZ7Xwgu8/id
 MM2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v/yJhgXZ3iFM1ug4oLfSvyH6SeiHh3/CvQqB0qkZuUKCdCtqjqzxRMuVxT8KO1nnb19oNRxa4we7G@nongnu.org
X-Gm-Message-State: AOJu0YywJHdruEuv7ookXocDYcMhA/uCBGdBvNMxzAs2XqcYDMpUfeMp
 hsfLqXcoMCIGuDP8SEIyQrctlEfMczCHbY7f20x67fRSuGasIi98Cm0D9HI4Ag5z9Mg=
X-Gm-Gg: AeBDieurSAqU+XNL8zPUQqXAqEv++VjQ1fSS1I6OKDbeJ8EwcQPRzcHc1bvcYenxWIc
 EL/IBwgIfJ3g2TdD/9FEaCSYLa0tIR7ivBIe1AphhP3bjhG6cFZdWfPhTXmQ0hDNKFujsNl9WiS
 c/a7bp+1BOtmq5ugMbpscW0AU8ECuPN6WMEVOWpzjz5R/23Djx0Hjfs6bF6pB4f8qNq21MKqhwt
 5TA91UPd+vdMag5ESCUcK+pgvRbpODjwOdwqXokew5m6cPNkfmjGLKiI2skYdTcXOwZYXSLWkHn
 gU6rztbNj7CdqwWMTuzscj+H6YrFLCYtIwvKdl6780Xgv8P8opkH5LH84QE5RQJfcKaQU3cSUYT
 VnlwGntjCBvkG08nVgd+8rJRbeu/vY4pYuKef1r9yGZbz9fmhWa4W43dQLSJYy2aUz+FfhmjxVM
 YmKFfYUWcrQFlstP0yhIocWhCTowAH3uNR8HMjhZcAOzZrT1NYyOjeheZiFXLcovE7tSsI/iZpP
 nMA
X-Received: by 2002:a5d:64c9:0:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-446481b0205mr637402f8f.21.1777323099411; 
 Mon, 27 Apr 2026 13:51:39 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d4fa52bsm1040482f8f.15.2026.04.27.13.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:51:38 -0700 (PDT)
Message-ID: <c479b485-66ea-4e75-a971-793feb5c6dea@linaro.org>
Date: Mon, 27 Apr 2026 22:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/41] hw/riscv/virt: free flash devices and OEM strings
 on finalization
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-39-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-39-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/4/26 21:42, Marc-André Lureau wrote:
> Add instance_finalize to free the two pflash devices (when unrealized)
> and the OEM ID strings allocated during instance_init. Fixes leaks
> found by ASan.
> 
> Fixes: 71eb522c4063 ("riscv/virt: Add the PFlash CFI01 device")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/riscv/virt.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

