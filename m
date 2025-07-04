Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DFC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdJ9-0003DV-Q7; Fri, 04 Jul 2025 06:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdJ6-0003BS-Qx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:06:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdIy-0003Dd-I8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:06:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso324066f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751623563; x=1752228363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mE77olLD1i/c2F6gH3IajYNMeuJm97QYEnUCwe9orY=;
 b=IBWZ5dJzqqIM/vOmEXFCYkh9pc936auXB9UVWsUmgsHqiJCUQ/1zZNpdrSSzlrqo8Z
 kba6Nk3dIdijWZzWZmaOMHvzaYc/aIhbuMGpx8lj+QrKvuEZ8xWSgw028T20ARXpS3YV
 8d5ZZI2WsJHVMUSQ0tZwi0hfBGwrMbFWO67YfIfBulpJJ4qqVLVVo0CjwFHraNYKQfa3
 6lkceLzXod0nq/wM6nwssW59hqXfViRtbYJLhDQ3/OPUbZuVrj/XkCzsBsb7z8NYw9HG
 V6QXv/m5lsNH6GkeAVEqaUrW1lcg0L+6v6ZpzKPgR4HA0m3SJ/beV0F66l7QKh3t9rEL
 7ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751623563; x=1752228363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mE77olLD1i/c2F6gH3IajYNMeuJm97QYEnUCwe9orY=;
 b=cFIc4fY6sfOPoCufx6M5ijbqfXAyrfA0YIcT/XWJLbiaT0xYeckzzdsSvMzEZFfZ7Y
 uVNeWB4ysVxilK30/AorUFaDQrMMsqhOHueG1qfdEgO0PYXuTUuusUZSZJP7oQycZbnQ
 Y/mW95YVEovGgiQt3aoOqxF3477Ed83ubNJcaHOZvrP/cXPPOo4C/ngn3ycSxjpDUi3Y
 tYxZpHe6Kv7l5mZdjbLskRcV55zotoo7+Bq0CCDeLtvhf2Fx3S3ZL0JMm/fyI5uIPLB0
 hltLqnWCMlK8bk3tmD2IZXCSEHQI3Tw+EHl3HRWY/fWkx4n8OcXOXaI4OnJrcdWr/wUM
 MetQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLJy2eZWRLyYl7kTF0h5WvDWEuFYDtbb3AYl55U1MEX25Ra29sTwcfUSFn58FC2uzMGEXYkuMGfe2A@nongnu.org
X-Gm-Message-State: AOJu0YzzJQw7Ehi61BFq4zIbL8BgKz8WQBLHKukPbJRhayToAcXAxgZR
 NtHsgqyNJkMqox9wFxgfWSU9+1nlJk/T4SZh3N01HIy2EHQdIGUtCqN/w7jy6HweTsA=
X-Gm-Gg: ASbGncubA9UE9l0gOZ9I4+R5BJAtfjqWCXIVV+0OfBTMFWAqU6vSaTUSCibAnL3rKR3
 yNcUqDrxLAEpL6SQeMVUerhvtrjGBRaORsU18QHaj95RLU7vbdOLGZl8ZYOrQf4GN9lfD9sRFzc
 48VEhWEGFCRGWAHK3b+1zhr9yFC/hi3r6fNQBjGLPKTF8pbjHJkN6Imr+SKHTkdUFqMwZxtMTys
 iE/ecQdnYP3+uDXQ2aWLd38AwoX6bDImpunliEWNqeBBFVxvjQOYgtJQkNeWNG2VQL89iccSdOe
 3LbQ3b0YyPfUPgbMIBlMdjPYGbXPKNXyfv1kIFlCPVfVcekai8d02j96qv26W/QMNaqn1LsoTM/
 KFiwibTrRyv0xmkYNB6rqcxDPNsvudA==
X-Google-Smtp-Source: AGHT+IFVPCRNr/nTQWbw9s7waCjzAb0IBSUKx9ynZRIpOxwWVoTaLtP3Ovovt1acIOdgc1qljJ1EjA==
X-Received: by 2002:a05:6000:240c:b0:3b3:9cc4:6830 with SMTP id
 ffacd0b85a97d-3b4964f7c5fmr1770107f8f.48.1751623562783; 
 Fri, 04 Jul 2025 03:06:02 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b9736bsm2111808f8f.60.2025.07.04.03.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 03:06:02 -0700 (PDT)
Message-ID: <0c01766d-577b-440f-9139-a095bd74da72@linaro.org>
Date: Fri, 4 Jul 2025 12:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hmp-cmds-target.c: add CPU_DUMP_VPU in
 hmp_info_registers()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250623145306.991562-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250623145306.991562-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 23/6/25 16:53, Daniel Henrique Barboza wrote:
> Commit b84694defb added the CPU_DUMP_VPU to allow vector registers to be
> logged by log_cpu_exec() in TCG. This flag was then used in commit
> b227f6a8a7 to print RISC-V vector registers using this flag. Note that
> this change was done in riscv_cpu_dump_state(), the cpu_dump_state()
> callback for RISC-V, the same callback used in hmp_info_registers().
> 
> Back then we forgot to change hmp_info_registers(), and 'info registers'
> isn't showing RISC-V vector registers as a result. No other target is
> impacted since only RISC-V is using CPU_DUMP_VPU.
> 
> There's no reason to not show VPU regs in info_registers(), so add
> CPU_DUMP_VPU to hmp_info_registers(). This will print vector registers
> for all RISC-V machines and, as said above, has no impact in other
> archs.
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   monitor/hmp-cmds-target.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.

