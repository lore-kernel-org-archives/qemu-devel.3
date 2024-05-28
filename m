Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CFC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByVb-0002KF-JT; Tue, 28 May 2024 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sByVZ-0002Jt-AM
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:13:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sByVX-0000ej-7H
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:13:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-65b4d0a7391so765466a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716909177; x=1717513977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUuZpeMIW/YE1YD3mxLFSdnjKa+Pqj7hhs7sIY7dhps=;
 b=ZUj7JwfEV9t84ovpDRg+L7lGRHW0vjCYdDZ4hERwPFFryTEyM1T4E60HiHE2cuuoji
 TG/7CnSSWqzQwWbD7h9VeriumjnpzaiwOkZ6fi4QxIIbohjnTJ8Up44lfvgkHS4/1ykI
 q3C2nEM1FUiY+iHoT34RRsMK448G+zqiv6JibjU0dndb3WBmiFM0M/HXuAscm+37FH5P
 m2CUX0U0G3n841gH4UVIjQjgHRTTFiJIn1YFzwwcN84W2wAcBTioI06HuNM4DiUUcP9n
 kFOcvJyc/vGHaJDrcpX2UASQIgxl7FvmjTwFbiXeJti2Cvle638irGiDGV8q/JRQELtV
 A1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716909177; x=1717513977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUuZpeMIW/YE1YD3mxLFSdnjKa+Pqj7hhs7sIY7dhps=;
 b=eErpq0rW2Cg050GH0xFfbc71UtTLB6+82GgxTQm3+/pNqRKIrQX0TcXB3vXStlo0VC
 cIZTByypJCs8qOywILFDTFhz43POCItXMWYCU01eewC6IjUieXhh/AamgEf8NejT3Py/
 104jZKcuXXJENZgIezIMMjSik3yB/Y6oRtRYawIvs6GrrmQL0LEXfLK4J1S9ySjILZWa
 y4TAS7BHD9C4iAuZYXLAVb/SsWs0sNwpVg5MY/H0Mf6BTa/Qubhb5BT0RyhLula3mpCK
 SHwMhmIV445sO3/ZiTmcvz29Oc4gTxaHVYuhpgEWS7f+zW9Fpg1eRBpZH6hypV8bgOha
 LF0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkXpOfpSN77HSSHm/F5nxaFGykwi1O9I/6FAlFPMPjbHvum08iGTgeMtQjjry9natX9VZVwTh8m5nlXZuyWVl5PF4HXuc=
X-Gm-Message-State: AOJu0Yzgbxu08WPDyhc71R0w8KTybGsW714Zgtr2F3wY4p3WDIzlTLOW
 Jm2/if4xfM1UKrz6u9r+0Bwk9BTCmNWs6gMv+ZecEkCM+lL+roUCvF+tjzljZ5I=
X-Google-Smtp-Source: AGHT+IGt+mt7mOYFETeXbvYoFXLLByyefsBpBNzcxV1oEJ3wZ0IyKvl63jWMmFiXQbs+jcd57bclUQ==
X-Received: by 2002:a17:90b:2301:b0:2a2:c16:d673 with SMTP id
 98e67ed59e1d1-2bf5f20891amr12238593a91.36.1716909176804; 
 Tue, 28 May 2024 08:12:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9ed370fsm9864598a91.7.2024.05.28.08.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 08:12:56 -0700 (PDT)
Message-ID: <47b5ff5d-b6f3-4845-b7bc-957b169ddb4f@linaro.org>
Date: Tue, 28 May 2024 08:12:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/27/24 19:43, Alistair Francis wrote:
> The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:
> 
>    Merge tag 'pull-error-2024-05-27' ofhttps://repo.or.cz/qemu/armbru  into staging (2024-05-27 06:40:42 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20240528
> 
> for you to fetch changes up to 1806da76cb81088ea026ca3441551782b850e393:
> 
>    target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR (2024-05-28 12:20:27 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> * APLICs add child earlier than realize
> * Fix exposure of Zkr
> * Raise exceptions on wrs.nto
> * Implement SBI debug console (DBCN) calls for KVM
> * Support 64-bit addresses for initrd
> * Change RISCV_EXCP_SEMIHOST exception number to 63
> * Tolerate KVM disable ext errors
> * Set tval in breakpoints
> * Add support for Zve32x extension
> * Add support for Zve64x extension
> * Relax vector register check in RISCV gdbstub
> * Fix the element agnostic Vector function problem
> * Fix Zvkb extension config
> * Implement dynamic establishment of custom decoder
> * Add th.sxstatus CSR emulation
> * Fix Zvfhmin checking for vfwcvt.f.f.v and vfncvt.f.f.w instructions
> * Check single width operator for vector fp widen instructions
> * Check single width operator for vfncvt.rod.f.f.w
> * Remove redudant SEW checking for vector fp narrow/widen instructions
> * Prioritize pmp errors in raise_mmu_exception()
> * Do not set mtval2 for non guest-page faults
> * Remove experimental prefix from "B" extension
> * Fixup CBO extension register calculation
> * Fix the hart bit setting of AIA
> * Fix reg_width in ricsv_gen_dynamic_vector_feature()
> * Decode all of the pmpcfg and pmpaddr CSRs
> * Raise an exception when CSRRS/CSRRC writes a read-only CSR

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/6953349448

ERROR:../tests/plugin/insn.c:58:vcpu_init: assertion failed: (count > 0)
timeout: the monitored command dumped core
Aborted
make[1]: *** [Makefile:178: run-plugin-catch-syscalls-with-libinsn.so] Error 134
make: *** [/builds/qemu-project/qemu/tests/Makefile.include:56: 
run-tcg-tests-riscv64-linux-user] Error 2

#0  riscv_gdb_get_csr (cs=<optimized out>, buf=0x5555558e7f50, n=3072)
     at ../src/target/riscv/gdbstub.c:183
#1  0x00007ffff7fb7841 in vcpu_init (id=<optimized out>,
     vcpu_index=<optimized out>) at ../src/tests/plugin/insn.c:57
#2  0x000055555569ef1a in plugin_vcpu_cb__simple (cpu=0x5555558fb820,
     ev=<optimized out>) at ../src/plugins/core.c:111


After

182	        result = riscv_csrrw_debug(env, n, &val, 0, 0);

result == 2.


r~

