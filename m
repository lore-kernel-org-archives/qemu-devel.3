Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F5C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 13:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3c55-0004Lf-NO; Sun, 05 May 2024 09:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s3c4y-0004JB-Nb
 for qemu-devel@nongnu.org; Sun, 05 May 2024 09:39:01 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s3c4x-0005n5-4I
 for qemu-devel@nongnu.org; Sun, 05 May 2024 09:39:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so692442a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714916335; x=1715521135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JIk+cR0a8DLadgqcTtMpU/TzIRx+PvKp4M+QF+YfvM4=;
 b=q+5jrlcO49OuTOzrDFK6rfbhmEZMuJBWeNjb3g5g8MzJpVoGAc3i5ftF4I2EmLNuAw
 1YAMdEFxFlVzMWObHBIHTNUeO6mlbNG3AEcIIlr03Ax01OF0nC3hpu60UQ+8ZCNSNXxt
 P9t1EQ1bVUBjXZNTrUzQzqn/NTPPMiE8kUNm22Kh9JXsNc3R4NUIUtJCYRnovNAJPelo
 9KALusoa83qo7s8Nx8rXB8OXTlbtGLsJbeCEv4hYEvNOoXHTE8PHB9PTf3bFWH43nz/m
 siB/xvQvgBOgYfmOWGTEvgtphW+H9QAWGfeh8wyyyBhPB0QxbzUQlt+piyrl5UzoeF8W
 oLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714916335; x=1715521135;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIk+cR0a8DLadgqcTtMpU/TzIRx+PvKp4M+QF+YfvM4=;
 b=oJxQIcPCoU9MaspI5XA5pHi4jkCoYN6ro8kreqpgy1dTtPAdxiNrlWUj0kD/q/g72b
 M6HnQrNk2/UpRdPKkDwrtfIgg2AaoEQXh1rwfpmOTjRIi2m/1uJuqTMeT0SRZxbE0fh5
 qn2yOLGbA6xv9sfLrl0f0WUdRQVeGKslBLzFNbM1BeSMt+LD69bmFosXxvdgogF617qD
 ZjGuPuD0M4YADoL30PvCEVn0SCMKjyRfPAzzf54si89/WQmJ+0O3k8imffMXYjWZjAuR
 CtBGwlf80gQOzJ4SG1P106n7aXsgksNqK6oAdEamRdtS0BqDNV7KLB38rTUWxlJzO/i3
 wUOg==
X-Gm-Message-State: AOJu0YyVW7bf3WDETBpU9U2Xy4x/oAGyasZ1GQ4fsJYWblkR9+T2yBTb
 LS/Bc4sBBsyx1RW11WXREfIMncoSfg19tKaBNmUOHOGXvDJwPx35kqQfe0ZTVI3BIcPhU8E1tw5
 bkGQ=
X-Google-Smtp-Source: AGHT+IH1U0aF8LqnDJMfHthkVARyL07eJ1TS4wXLrCeidwRJx3vcdYuuVzy1kY9fAORwFQBb2rfZ2w==
X-Received: by 2002:a05:6a20:8413:b0:1a7:8a02:3058 with SMTP id
 c19-20020a056a20841300b001a78a023058mr8649456pzd.12.1714916334599; 
 Sun, 05 May 2024 06:38:54 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001e8a7ec6aabsm6478468plx.49.2024.05.05.06.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 06:38:54 -0700 (PDT)
Message-ID: <1740f591-0b29-4f1d-b4cd-e2b7e579c4fd@linaro.org>
Date: Sun, 5 May 2024 15:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug
 System registers
To: qemu-devel@nongnu.org
References: <20240503153453.54389-1-zenghui.yu@linux.dev>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240503153453.54389-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-pg1-x535.google.com
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

W dniu 3.05.2024 o 17:34, Zenghui Yu pisze:
> We wrongly encoded ID_AA64PFR1_EL1 using {3,0,0,4,2} in hvf_sreg_match[] so
> we fail to get the expected ARMCPRegInfo from cp_regs hash table with the
> wrong key.
> 
> Fix it with the correct encoding {3,0,0,4,1}. With that fixed, the Linux
> guest can properly detect FEAT_SSBS2 on my M1 HW.
> 
> All DBG{B,W}{V,C}R_EL1 registers are also wrongly encoded with op0 == 14.
> It happens to work because HVF_SYSREG(CRn, CRm, 14, op1, op2) equals to
> HVF_SYSREG(CRn, CRm, 2, op1, op2), by definition. But we shouldn't rely on
> it.
> 
> Fixes: a1477da3ddeb ("hvf: Add Apple Silicon support")
> Signed-off-by: Zenghui Yu<zenghui.yu@linux.dev>

If your boot environment allows to run EFI binaries then my ArmCpuInfo 
app [1] can be used to check values of system registers and flags 
present in them.

https://github.com/hrw/edk2-armcpuinfo/releases/tag/v1.2.0

Example header:

ArmCpuInfo v1.2.0

ID_AA64MMFR0_EL1 = 0x0100032310201126
ID_AA64MMFR1_EL1 = 0x0010011010312122
ID_AA64MMFR2_EL1 = 0x1221011112011011
ID_AA64PFR0_EL1  = 0x1201001121112222
ID_AA64PFR1_EL1  = 0x0000000001000121
ID_AA64ISAR0_EL1 = 0x1221111110212120
ID_AA64ISAR1_EL1 = 0x0011111101211052
ID_AA64ISAR2_EL1 = 0x0000000000110000
ID_AA64DFR0_EL1  = 0x1000000010305609
ID_AA64SMFR0_EL1 = 0x80F100FD00000000
ID_AA64ZFR0_EL1  = 0x0110110100110021

Have to finish work on next release - it will show also values of 
MMFR3/4, ISAR3, AFR0/1 and FPFR0 registers.

