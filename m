Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE3D4661E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTPP-0003WN-PD; Thu, 15 Jan 2026 14:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTPN-0003UL-Me
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:53:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTPM-0000nR-6e
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:53:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so8143115e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768506806; x=1769111606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyuAt08zLTT6cT4HzTZ8dzSryrV2/NU9Nv9qwkCJbcg=;
 b=dVBN8BdM1eX3Az+tF2CRQXpFlCIRPHGnzkHTCTxLTcKaRF19YbkDCX1jHWFNrZxoo0
 KHZb99oy2vxEuNpa/kWWe8s/1/DDebQgdFLttcSUaOZmfVdqWmKl2fAecryw0Ti8MIUL
 x8NeJ2kGJiuBk7pGuARxPyjh/U2Km4bJVOPfyvySKGqzDXuKB/ztc2HDDVn5vPBeVCh5
 r0mxeapvRhD2bt7Te6cup33H10klj7A8zY0uxzXwwoq1SVVGpxnCymneIFmCPPGj2+xV
 AASzHkisPef6qDYaI6fQFFO5sfCwzAVV2MzgqUfrrkLtDkxWRJ8z/PXgaD4qYqvGXxje
 QGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506806; x=1769111606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyuAt08zLTT6cT4HzTZ8dzSryrV2/NU9Nv9qwkCJbcg=;
 b=nYnkvHZPOicS7SgRRXEucyJAAst0rKwmo6L08EwKJKaiX9maAxFMf4kBiB6aP1AUPO
 IQPIOyASHeX6T2rvDB+JM6bt8xQb4LIkCLtfAFReyX/LlDeq9F6KCZmlDb73DbLoVND8
 SNNUVwkzQiW4b5ev+1DVXtSiv2w9eRiIixmBNQUC7LrbUwHtUMVu3EyNGKTIs14sNm+1
 RTuZEqe/FCCSDKLTwzbtVwtSysR5E3Y4xWTYHHtd24q9empqgHTo64mUZ0hDrWjl0PZs
 H1226RIp+M/BwTB6aQkpi30uKKmprsTyMVrdRfAcJoTx5ILmow8bR37E6JdTGzCbE+1m
 LxaQ==
X-Gm-Message-State: AOJu0YwImgZPySOwSC248jLay8Z/VJE6YJ6tVRnXCsn0tsn43LjsTyDu
 n4ay2Hst0WD4xPHLV4+aOlBxiTWJ1FgBRQVfy8tbDV4d7gFtKdKvyhWOLM75HwJ47XsRznhSiRf
 +ypYUjcw=
X-Gm-Gg: AY/fxX4Unz2oj0BupNwx764utkpQB97yP/QOwxv3zgMlw1Xeb5dULbGR1I8HADevier
 qO1hMTXxD1pHgUdQf0JMBNVWkowG/l5dr9SMOwQv9TY/vlnpIpdiW2i3Zk1WdnqrrFUuDrqgqQ6
 ZvuK7R9F8cQY13Nsv4Nf5/T/XxcnpjunPDKKodvmq3XEwTFxpl1vrtxPnzRrz8y4AxwNPYpDe1U
 ocU9ZQHuRHdSwZ4ZtrW4iWD5Tcd1AqOqJBHE28t3p4PN6YWELPHzGRFaHMiFmO3YiY+7mqpwFdS
 YvxGUrb7XOg4vLhA+whBX02USfJrBQ0ty+5K6/4+4+NC1XwOQszex88y5UnQyxKnNNQ4cRmYQ7L
 h025j6oAjVXmu+wYTCtmoIZJUH98EoIqJEZRXZBKV1LZS0Y/dtRySUN7ezZ/OaoyZiqju8Sn9A3
 Kuykb+1di3zopEvy/ixKz8xN2GhCGYsqHten0aP5iCAVqtvemWYl6ssMIzd2hEXkXP
X-Received: by 2002:a05:600c:3b9f:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-4801e2f2989mr11046875e9.6.1768506806179; 
 Thu, 15 Jan 2026 11:53:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e9ee5c3sm2203215e9.2.2026.01.15.11.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:53:25 -0800 (PST)
Message-ID: <12379570-0b83-4ebf-92fe-609d6327c700@linaro.org>
Date: Thu, 15 Jan 2026 20:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20260113203924.81560-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260113203924.81560-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/1/26 21:39, Philippe Mathieu-Daudé wrote:
> Fix typo to avoid the following build failure:
> 
>    target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>    target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no member named 'vcpu_dirty'
>      988 |     qcpu->vcpu_dirty = true;
>          |         ^~
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Untested.
> ---
>   target/i386/nvmm/nvmm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued via accel-next tree, thanks.

