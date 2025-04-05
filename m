Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E1CC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16DV-0005Wy-Op; Sat, 05 Apr 2025 12:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16DS-0005PN-WB
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:17:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16DQ-0005tE-WF
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:17:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso2269845f8f.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869871; x=1744474671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bL32MZDfrt2Pa7tUKwa3rlhSP0n9RGMA9b3vyjYciD0=;
 b=n1ZQ9+JyoTmvA0KV//iQaeCbiwbnZB4RcLunzfMOtrpq41KhEN5KfHWut0m0CamgHS
 16mZLAkMGmXrMNIY6brwEFuNF7AHSECLFzlPTyDPq6Q1IGBoN38+gySHe/aejfIXVST6
 GfZODJh2YDIQ2MDLOth13zdLwfiU1XQzawidMFWgB11cbwVB+Pn6i00Zz7aELulJVZwx
 4oghoLUYTxkBJWwFnv4J/ehev+5rYD2KAtDCB4wwPIFbj8Firqwb2ZsPy+aS/PPjPN0v
 I+0FYw4GB+PpRySHHkXY8E8+X5MJN/ozJLn3p3cFbd8FqmgC4omZUNmqfxJQ8nq+GZjg
 jqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869871; x=1744474671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bL32MZDfrt2Pa7tUKwa3rlhSP0n9RGMA9b3vyjYciD0=;
 b=vd3hBdsSv5pB/8KMty0CetRZ0UWJiCZ9pdvJje1sjPo86J+fMGaaY6DFDD00PerU9+
 fhbYcmO92l/iKlbJT/O3koNpCn2/sp8JmvUWTb6spEmP1YHIkgec+6igieWLePU+S4ma
 gB8AxzvbfVVsNsT2QGlQ//tV1eq0SEA5uY0dMj8xZcGIBdRO4hLBe9s97VQ9LZgaSx4E
 /udvBn0I4ejLkynFyqJCXwyJG1LpWw0DquPum2mUqwhsHAGk0+HFdpk234mIE/qHpeDS
 RaelHWKrozrDpnBzn2QlnP0r+wKl1hQ8/o8ABu8ayrOxBP6SHxXO+v1cHkvkKUijBxND
 wftQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxk2uhEYLTEc5RcYrVgsK0XivgIMebIpIc+k3gz03evp05XnDHl+1XqwKaU5++IAOInlZZlzpCmaHI@nongnu.org
X-Gm-Message-State: AOJu0YzCemy4XHK46rf0eXsAnZgENW701pGXON9ZfG3hNHEvQgqVfC8I
 QT0lwYFAzXA0ByIKi1KoTkcHPBUp0UwGN3hLkYdRLHgUSZuCQ9fEaw8yn2Phf8A=
X-Gm-Gg: ASbGncu0mOigCLlJLZGo89F/BJGNDpCx3RQJd1ywcBfRIGAJSQMZoFGQFygKxP+yBQX
 5RxuGfGJ8/GSvA10EPFX8mzE5iXw0BmR/YVSArm1zImsypkB9grLIaWFOkddqoO7icT/1jYeSmH
 2AhoFCA2a5OPKsLA6HBrHpfny+YO6+Gu8t54jClQ6/2f+teaxVPKqEBq/+fbBa0vztrLIfaLOeU
 36sDsjM0o4/jXd3cwzhV72RLg7YdquxP3/tnswrnPF2iod1AFuDlBUdyxPc2nm3jDoPiAtV+3oV
 DkFVPIkNl80vxAKhI/jTEl9hRlxw0PYK70dMJ8M/cAI5hUSgXrxIcSyjUJSJIeVN8M/DGDoUKS0
 nIzMpMKJG0PF9TsvktQ==
X-Google-Smtp-Source: AGHT+IE3wq0uOolwze19UyPsXzDYXP0X6JGGYb943SY+pGkCIxJbYPTfcP/gN9/F7xUSJel9PigpDg==
X-Received: by 2002:a5d:59ad:0:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39d6fd022eamr1880036f8f.50.1743869871403; 
 Sat, 05 Apr 2025 09:17:51 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec147c9dbsm82544795e9.0.2025.04.05.09.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:17:50 -0700 (PDT)
Message-ID: <59283204-5780-4019-9ff4-00b0e886735f@linaro.org>
Date: Sat, 5 Apr 2025 18:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250405155054.967307-1-richard.henderson@linaro.org>
 <20250405155054.967307-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250405155054.967307-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/4/25 17:50, Richard Henderson wrote:
> Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
> have each target set the 'precise_smc' field in the TCGCPUOps
> structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++++
>   include/exec/poison.h       |  1 -
>   target/i386/cpu.h           |  4 ----
>   target/s390x/cpu.h          |  2 --
>   accel/tcg/tb-maint.c        | 26 ++++++++++----------------
>   target/i386/tcg/tcg-cpu.c   |  1 +
>   target/s390x/cpu.c          |  1 +
>   7 files changed, 18 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


