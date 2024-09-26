Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C8CDE03C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 21:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stwSD-0002Y1-7f; Thu, 26 Sep 2024 17:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stwS8-0002T9-QI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 17:55:14 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stwS6-0004Pf-M3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 17:55:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so1025029a12.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727387708; x=1727992508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fdgemor4lt2aGd89YRKtbPUBDU2mu8H6I+kpoQlnF3g=;
 b=aUcJAK7Aq+0suHYVq+SanO1VZsGYzeA7agv43rEukBB5i3PBsiG1Ydx+2S5Zi7YOOv
 In9rOejnkhkhRlc5hY9u2VqSVCiSgMpi8z97YljSkrwi1mDDU1GMLSfOlvfux2thlWAI
 ntCglUAQv9rOpJ4nmw3pWBrTdnIsfgKhIYtNVF69nZs4gCgRLik/akwRH57A2fNEWqcv
 +rjNSWPAnu5lShBSoAckGSRtnO+K0fh8cjpUL8IbgL5OC4Aq+WbQii23Rw7b+TjO9MJG
 Q5Vp7Y6PYfMVq3r6paVhcd8G9X6qMA8fzK2sFcIP4OnFr4nv3uQsiLMlQ24O/pCgINd8
 +Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727387708; x=1727992508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdgemor4lt2aGd89YRKtbPUBDU2mu8H6I+kpoQlnF3g=;
 b=I7/HTol16pZ8Z3XpkZPVIoP2OhOLBeLAB1sQnVlT6rofelLjfevG8JwU+u3sxvQ3yk
 LJWCveQ+qH3mk+0Ii23i9NECmLeS41qMNs5LxO/KgTLCB/i8HgTq9Vz5W4MjyxUz3+uN
 vhVaAouHVmGp74H/9O6bSUQbEDcD0roxCB6jueg1eXK0C7DbhiKTpoRgsK2o7RpAWu6+
 ivepniOP26+PbnxzKbwIDu5qH4zKV6YzqFsGJgCyKN3KUKh0YQ1P2IiP5BbsZehUtWas
 B02YcMoAz9HVBjjUsdECz+4sza+4VNt1cD0GUtWAYz7giwytSB37z3iEuna/ZZEuV/kl
 ecIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWukoZX5jmHQpkvnJYOavwVXZsvpNRlp09k56dXuxKFiPNtc3cYF3abMHSRL3NePa8HaBJIdtKJRI/8@nongnu.org
X-Gm-Message-State: AOJu0YyTwactNUyj6QALmWr47PYhwzlyXkxhuCc2WRg3eF5ThzBcZolO
 SmeMVXEcLfmZk5x3/8h16EjzDghIFa/iknJeEcn64ffY87eAQyxjQkaTj1KWuWY=
X-Google-Smtp-Source: AGHT+IE8s32QPI1adbimqSCui2pZMlRe0Aw0uB7248XX/ffekcB9smLaQVGEgdaptP2v1ndX34vmjg==
X-Received: by 2002:a17:90a:c682:b0:2d8:8eee:ccab with SMTP id
 98e67ed59e1d1-2e0b8d58457mr1246904a91.22.1727387708334; 
 Thu, 26 Sep 2024 14:55:08 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e0b6e15976sm523803a91.41.2024.09.26.14.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 14:55:07 -0700 (PDT)
Message-ID: <d8fb6869-5f3c-4ce0-90f9-001f64b43547@ventanamicro.com>
Date: Thu, 26 Sep 2024 18:55:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
 <20240919055048.562-9-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240919055048.562-9-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/19/24 2:50 AM, LIU Zhiwei wrote:
> make check-avocado AVOCADO_TESTS=tests/avocado/tuxrun_baselines.py: \
> TuxRunBaselineTest:test_riscv64_rv32
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/avocado/tuxrun_baselines.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 736e4aa289..589c7f254b 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -533,6 +533,22 @@ def test_riscv64_maxcpu(self):
>   
>           self.common_tuxrun(csums=sums)
>   
> +    def test_riscv64_rv32(self):
> +        """
> +        :avocado: tags=arch:riscv64
> +        :avocado: tags=machine:virt
> +        :avocado: tags=tuxboot:riscv32
> +        :avocado: tags=cpu:rv32
> +        """
> +        sums = { "Image" :
> +                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
> +                 "fw_jump.elf" :
> +                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
> +                 "rootfs.ext4.zst" :
> +                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
> +
> +        self.common_tuxrun(csums=sums)
> +
>       def test_s390(self):
>           """
>           :avocado: tags=arch:s390x

