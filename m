Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F9EC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgp1-0003Uy-96; Tue, 19 Mar 2024 17:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgp0-0003UA-96
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:16:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgox-00005r-PV
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:16:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dffa5e3f2dso21313955ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710882990; x=1711487790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OzXNFRQy4obpYoDpWQot9takJN/KNaAfNdmPPTGfPTw=;
 b=VEIkDuG7zgn+NpCTl7v7pVNnWtupvA6M3RPKNFArgltEDdFe4/I/9AQg1tUc6D878/
 L9fWhdrK9rQzzHhpKiH02UpSMyIjfo1iULE/eamjNviYnMAPAaOp1lWM4y0RWy/HMfLt
 DnPixkQBkQ87QZ0m2/iF8gvgC+0wa9ifZn/WCQJerKW95mjMFgS4EN/AvRSmL0BDWTFx
 jZrBL9+LpYuUdtXUb6E/+ClFSd1X0hwM+M6cGgJWDIUXQpEhjCKN8LeGPbwD2JYQdv66
 F24MVX9M0yh1Qgomq8Qg5KwPZf2q58iRyuutcLzOn0bBGeFLXfRDX/HZtsOEHik+qXeH
 AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882990; x=1711487790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzXNFRQy4obpYoDpWQot9takJN/KNaAfNdmPPTGfPTw=;
 b=LZdJLQhfpUmmZd8NVvHwS68pZc0WhInz665YFMJFuoXMHfLyTE4RPI9tw5u1Sq4jWC
 /2V1LnIKB6vnelu79nbbSSUsfR7+S0KznuyaXgEqZEXhMvOhHujA0R3cQKodzzkC8zVt
 Ct9fxZtB5w2f2ILReIrIRDX46LeNEKTjF/WubtYgzED6YQCCSYDRx7d/O+wmLPaJpzW5
 7y5FU2NZ4x2M781nDskkAUFqB67/bXXn443a4bsiuf89MFuql+KnH2f0BzcAGuR7NiDw
 C3MAyYREsfkxZ/udrc88MvtwyP13RPzMANkeiciELb+YwBS9hYzuzSMsytU+iYSe5+mR
 NXwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu27UXMDMZGh4vmGMcDUQIHRjoIsJPSc1xcrty/iZwBu0uhtsg0R13ya/HcOvl0nbqR7NibYfK03Vny2c1L7NfAxgsli0=
X-Gm-Message-State: AOJu0YxDJcy6PNu45j7pmZaSQgSno1WiXsuIRJPFMT6D9bntLnC4PTq+
 faeR+3fjDRYPVcFFFJ0oiD6uPouQej5ZIQ9VIfG2THN6tPErJr5s9SZLTHoRSIU=
X-Google-Smtp-Source: AGHT+IHzwEIxU66MqffiG8iwfijkFN5JmLaL9eD9OD/frstvwkoManrkt0fc5aM2X9YTT2QVyqWwWA==
X-Received: by 2002:a17:902:b70e:b0:1dd:de1a:bd02 with SMTP id
 d14-20020a170902b70e00b001ddde1abd02mr3441417pls.41.1710882990023; 
 Tue, 19 Mar 2024 14:16:30 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 i17-20020a17090332d100b001dd7a97a266sm11708110plr.282.2024.03.19.14.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:16:29 -0700 (PDT)
Message-ID: <f53deaf6-6b83-4eeb-aae1-3ef5925e3897@linaro.org>
Date: Tue, 19 Mar 2024 11:16:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 00/27] accel/tcg: Introduce
 TCGCPUOps::get_cpu_state() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>
References: <20240319154258.71206-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/19/24 05:42, Philippe Mathieu-Daudé wrote:
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

Modulo 3 notes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

