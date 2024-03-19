Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C1CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbi4-0002up-C9; Tue, 19 Mar 2024 11:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbhm-0002k0-Sv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:48:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbhk-0006Fa-2P
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:48:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e1878e357so2367785f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863319; x=1711468119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVM5sczr6N9DCawSN+UIf+ICT806MOF/8Ruu+UYE2pM=;
 b=fIOgl0hKAXkiMcuO6asQsoetAuXOfYYOEjvAqHXxTww0WOUM8Hwx3jexZDoMSHT1XN
 AYDtSyJmAgqiLa+b2NMBoD4XWWE9FTc1j0j9dQkFLzYL8oRe0OUm9tq8cUGx4AyGwJEo
 AuIg0Gb5jSwC9uYudBQYd1np2eKAkGEUq4u6j6nrScECdgOYSDdjnXYg4Gf152Dfd4R4
 JGJXDlqQKXrHyKmqwdK+H/Igy3dK3sD3dz3fCgFrEMEmgy9HUlQt6ISz2TfGp1zVTbVu
 UAYXuCGkNP6ahxaRZBRrHIa2A3RfqqXSjaCOROQ1zGIx9SbZebUuN1ZSUQuavaVOdWaN
 uAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863319; x=1711468119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVM5sczr6N9DCawSN+UIf+ICT806MOF/8Ruu+UYE2pM=;
 b=v3GPnAI+iSFe4aMs3XgmOGY8Wp+CnVH525yV9lxOtJcFkwAOr0+6T8cY11BTVHf/YQ
 Nlvkz9zNHcYBpcjUiZDO5ONHFFL2FkHKn/tlbbvb0oIhKR72JtywCADXGD1UpcreWLPK
 POQ+cYz/m6f8OK2yu07tp9WIVVim4WDr5Nsu8PU6ul3wgy4uX7uOZWtoNuKSEEU6D6CY
 CvnqwOMTudYD1s6NMNlHQ04e8fxI5ECVVq2GM5eQpcbMSG96yhLaDfbLibve/9mEvu2L
 rAZJMYc4GLllR8nKeR6gntQ4eIeK8wKilVqaNuHkQ3DgaQQRNEl2gTIowtCbO8shjOuT
 V0Pg==
X-Gm-Message-State: AOJu0YwwWY7C7uBcMIXSe3pIpXM3w0D1gcud+6jk8HVc3IqP03/0UMWd
 5tTx7JCIWhT33FhLFfOkOMRn1jaw0CJSi2e+9eVJ47RiFPmTDI14Mb063ajFoOOn2nH1u5XG0Xw
 I
X-Google-Smtp-Source: AGHT+IGkvhxjgITgpuGtUSQC9jiRkm8/gVCkxMGSqgclhKR4FmV5GrSQ9330wmrPjP1Ykp1P2cIfgQ==
X-Received: by 2002:a5d:5265:0:b0:340:49a2:650a with SMTP id
 l5-20020a5d5265000000b0034049a2650amr2321972wrc.55.1710863318839; 
 Tue, 19 Mar 2024 08:48:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 f10-20020adffcca000000b0033d640c8942sm12655351wrs.10.2024.03.19.08.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 08:48:38 -0700 (PDT)
Message-ID: <b2b9f1f0-bb84-4cbe-828d-6142ebbbbd54@linaro.org>
Date: Tue, 19 Mar 2024 16:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 00/27] accel/tcg: Introduce
 TCGCPUOps::get_cpu_state() handler
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>
References: <20240319154258.71206-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

(Forgot to Cc Claudio to keep him updated)

On 19/3/24 16:42, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series introduce a generic get_cpu_state() handler in
> TCGCPUOps and convert each target to it.
> 
> This is required to get a single cpu_get_tb_cpu_state()
> for heterogeneous emulation (since this method is called
> by accel/tcg/).
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (27):
>    accel/tcg: Ensure frontends define restore_state_to_opc handler
>    accel/tcg: Introduce TCGCPUOps::get_cpu_state() handler
>    target/alpha: Convert to TCGCPUOps::get_cpu_state()
>    target/arm: Restrict TCG-specific declarations
>    target/arm: Convert to TCGCPUOps::get_cpu_state()
>    target/avr: Convert to TCGCPUOps::get_cpu_state()
>    target/cris: Convert to TCGCPUOps::get_cpu_state()
>    target/hexagon: Convert to TCGCPUOps::get_cpu_state()
>    target/hppa: Convert to TCGCPUOps::get_cpu_state()
>    target/i386: Convert to TCGCPUOps::get_cpu_state()
>    target/loongarch: Convert to TCGCPUOps::get_cpu_state()
>    target/m68k: Convert to TCGCPUOps::get_cpu_state()
>    target/microblaze: Convert to TCGCPUOps::get_cpu_state()
>    target/mips: Convert to TCGCPUOps::get_cpu_state()
>    target/nios2: Convert to TCGCPUOps::get_cpu_state()
>    target/openrisc: Convert to TCGCPUOps::get_cpu_state()
>    target/ppc: Indent ppc_tcg_ops[] with 4 spaces
>    target/ppc: Convert to TCGCPUOps::get_cpu_state()
>    target/riscv: Convert to TCGCPUOps::get_cpu_state()
>    target/rx: Convert to TCGCPUOps::get_cpu_state()
>    target/s390x: Restrict TCG-specific declarations
>    target/s390x: Convert to TCGCPUOps::get_cpu_state()
>    target/sh4: Convert to TCGCPUOps::get_cpu_state()
>    target/sparc: Convert to TCGCPUOps::get_cpu_state()
>    target/tricore: Convert to TCGCPUOps::get_cpu_state()
>    target/xtensa: Convert to TCGCPUOps::get_cpu_state()
>    accel/tcg: Remove check on TARGET_HAS_CPU_GET_TB_CPU_STATE


