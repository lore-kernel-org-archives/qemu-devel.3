Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73CCE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVu4k-0001wG-A0; Thu, 09 Jan 2025 10:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVu4i-0001vl-AW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:03:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVu4g-00027V-MW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:03:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso8591805e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736435033; x=1737039833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZV9+RA3bWR5u/OiYfe9u0eTyfuuvo5IID0Yz3QU9FNM=;
 b=p8N1jVjuFl4oZ/iV4ShcDJZuXyVl6BzPLhL614qjcF9kqvTxfeiUFUvTsFgJQQi/0G
 b102yx8nQFeJ/FS29k6MEnli/CfhyOwQBd/ScUhgjzXo1PhkWvw/C3hyTy2uRxMCyLBS
 +IxMf5BHJ2qZqljuR3ERBboxYshmkqQ+T/4QvSUGUntOkUtcbLVd5MtstRw9/XVCfVJx
 wSlkVNBnu0koZ9Kw/+rOgMaOjZSA2hM5AGF0NeIbIxpZtpyLE2y5BVolh00thtyqQ9zu
 LpuEeXQbpsST4kuS9f4xYSPwyDVdH5wTGLr+EuP5BZDmHn22IrAZY0X8OZ7XbvnR6jOf
 XZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435033; x=1737039833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZV9+RA3bWR5u/OiYfe9u0eTyfuuvo5IID0Yz3QU9FNM=;
 b=jQZXjBLl6L952sMyQsGexMp3AfTMLNlupI0rvPGV4AYwHYpf0OYpOFldLaMD5E4/GF
 FBaxmNq8YbmX/gEey3FkY/PVlaOK98y8E8GpwkCieVFtf/Dl9y0DyacvaeYR8APPnA8c
 SIKaqPQC4PppNiRvHsNIuAvWG50UaVm/GPa4sl0T5IUd2LtaP5wmx0BGxyLvyyZhujqT
 bDVcgdGh2EC8qGGO7sflb6B4is+Aca+2LW8bnVM5joc2YSxO9dhijPDeQvdBpJi3Cbm4
 94vEttyEkOk0MZmyr8PpviDNLe7fJ/+PQ82hY6vy7RR1aiH44xzUc8s3GwD9oStPIYur
 Y1rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHcAMu8po4yDif/mxPaaJVin27QpLs7qF+yM7w9OgxVsS1Aof2aTGAYYZ6XyQU7K3UZqrn+bOiNujr@nongnu.org
X-Gm-Message-State: AOJu0YzNpH+TehGKS4tvWAIb/f3EkHGTqWDFqWCmYfWCCtrSLloQHG5A
 Wo0sliucYL6QNxBqNIUYbkAT9+PtUWtHBZuSKNhdpAfPzgBxLwti9+EDUx0y2ls=
X-Gm-Gg: ASbGncuWROQrfyOH4ob6nihdJ5kONx7AXg9HYwx4VpVqvHjJL6x1mZ8KujANpuipDsN
 6ruMtMdPdpog77v1wG9Wr07RHCojv7xbdZPYb/yzh+bU2BvubZ82xsa6Npzf1VCbX4cJtsxwkYJ
 CK+5ZT8iDkJVAXmJhtppIPhS5t1TQWnn2ssgdh2Bo4lJ2KPZT0Wlte71uVoJf/+Ngo+qcW4HhkO
 qGX9toUUGnBoVZAOvGZS2SM8UgQhr5vIs5EXp2GERqR6GhE7HksEpzamDDXaJ8+NbfLsbIM2TNL
 YHTkJASIShhB6iBn0XoXTzr4ugI=
X-Google-Smtp-Source: AGHT+IF/TzvP+0z/wbIUPWIrtiq2f2TKAwsgxZbyxbXkZroikNYrD2VVOyk2ZBBzDf7x1VZnKa8h1g==
X-Received: by 2002:a5d:5848:0:b0:385:edd1:2245 with SMTP id
 ffacd0b85a97d-38a8730dabfmr6200049f8f.30.1736435032480; 
 Thu, 09 Jan 2025 07:03:52 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7ff0sm2066585f8f.77.2025.01.09.07.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 07:03:52 -0800 (PST)
Message-ID: <f1a91701-0818-4987-b683-4f31abd5a35f@linaro.org>
Date: Thu, 9 Jan 2025 16:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, thuth@redhat.com, zhao1.liu@intel.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com, npiggin@gmail.com
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-4-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241227121336.25838-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 27/12/24 13:13, Phil Dennis-Jordan wrote:
> The XHCI specification, section 4.17.1 specifies that "If the
> Number of Interrupters (MaxIntrs) field is greater than 1, then
> Interrupter Mapping shall be supported." and "If Interrupter
> Mapping is not supported, the Interrupter Target field shall be
> ignored by the xHC and all Events targeted at Interrupter 0."
> 
> QEMU's XHCI device has so far not specially addressed this case,
> so we add a check to xhci_event() to redirect to event ring and
> interrupt 0 if mapping is disabled.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/usb/hcd-xhci.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


