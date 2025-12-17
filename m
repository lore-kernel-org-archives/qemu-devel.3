Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9ED65C60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtDg-0003MJ-Nr; Wed, 17 Dec 2025 10:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtDd-0003Lx-VN
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:13:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtDc-0008AV-E1
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:13:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so3617164f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765984415; x=1766589215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZkE6yqJjDnFrhWGjDK+rUGNkEfh+rRqvReNLGEhB2A=;
 b=nx5vl59aJS1TueGEo7UGi3XMCl6DXNvISP3NhYqlQ0pE7TQiCh4gslyRCTP1yxNhW9
 aVd/LZAklqAj0pHd6eil1+Puw5uE0djRsCdn9xTY/CUAqak1fDOocrHNkxBCajoYmfKK
 8CLe04GWrNlwJT/JfBZoBQuO5TDPPuupdiNHSASh4evJEBmig2y55sHg5l/H7IqkYhMo
 //pAyauLKgRNMkOFd1S/xBhTJnbUcK7HgvwCLI8fr3/nMip4jkLCTnsNfYyuQHgX2DFS
 EVz5+bqElUmJRn4a3S5Rk+7yLf9cWAF73v5oefdjxNFQMFTE57QKA0IuXMMuI8sccYaK
 H0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765984415; x=1766589215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kZkE6yqJjDnFrhWGjDK+rUGNkEfh+rRqvReNLGEhB2A=;
 b=oCLqceZkWFgim1QxB2GoClFOLMoVeqZVv4UeWnj1BagfQkn8Pkz+wrepqw/nJwlWas
 cbBzv5DBpYqBgYRBvkvQI36IzetA5ADT9VYC4cP0uREXMwpS1rQAZODWmBTLIbj+lUHA
 TazbOwTdTLYs7jyZznP6pmdw+FCJiooC/71pGKra/S7IPCZgEcHRIgHKqm9y9AKK0o7d
 ru03fd9xptw4KuTtiwnmwD0jGHWYSPnia4t//skHg5jrB2FB6J2x7pwmRFR/3jS63UUG
 TANtv6X/qi8BF1hyqJBnUeJxyd5qz+n3lSlLEP3QM0NXT3vibRXjaNYosDX+nh+WKEYK
 VFtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfkzP+sVMdYHAd51TNF/Y6a/mKpSMQAuklhPLg/sHdjMKGbq+2kHN3FsSQoZ4K24EYzEJnnsVu7MCQ@nongnu.org
X-Gm-Message-State: AOJu0YxLqQNuE79vkPT0VvuKqwW/1t69jZ99q/Y21m2SfxiVnEKNRlNN
 Fo5eGd4zm2Hap2JQlXBQmaPFloLaG7l1sok+UnJpnTMeG1Q/fwodq7LHfMbEVaJ8PV4=
X-Gm-Gg: AY/fxX74WAbh+QmSEismqUXKEy2SrTSNrCXEOmz7bII6PFArwCBgI085IPIrnME8/zD
 gGJc9u1ygumHGk+Plafocf6IzQhZ0NEKib/ttVecZm/eb3I02PjBe8VKxb2B7o+Jeb3zzeFO89J
 rEHa29X41UOGQz/PhVrQhlIvM7YoyRvg2TgXdmzRq9XYQw+Uv1F9JkXbnlPrmasyvo19z5pQMvO
 1axxJEExvM1aX8rW9ulgMH/7PganCJRhz5zts/5chUxPE/NUS1AcOCYJ8PKk6BytSCWWkwSG2/8
 6nFWaqBnE8p+ud7oTFeV6igLLrLbf9El+4UfwpSgzTRO278esFaxWdcKLrNUsdmx61HsGLBz2Nc
 HBiauR8cDZSm+6IVVMPFAMCK6JjSd6RtFBQ4ajDWz3toD2OAh4Zx+T/ig8TlCUzhngQQyu48XI4
 +quicmgDAmO2h908dEMSZjtq0MkMJidyKPyodaCja2mvv7phLk9JGetA==
X-Google-Smtp-Source: AGHT+IF99FaOmVnQaow6S7Dj9nd7MY+wlEa5/d7lhOSDx6SwpcAEUFmSD7Kv++xBOrb8KLaXwwsueg==
X-Received: by 2002:a05:6000:4382:b0:431:1d4:3a6d with SMTP id
 ffacd0b85a97d-43101d4429amr10000183f8f.48.1765984414706; 
 Wed, 17 Dec 2025 07:13:34 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310adf701csm4844203f8f.42.2025.12.17.07.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 07:13:34 -0800 (PST)
Message-ID: <cdbf0791-235b-46a3-8caf-cc039864706d@linaro.org>
Date: Wed, 17 Dec 2025 16:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/riscv: Compile once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-14-d24a4048d3aa@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-14-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/12/25 00:51, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/meson.build | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Easy :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


