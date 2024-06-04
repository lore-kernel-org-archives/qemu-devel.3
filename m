Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERJI-0001UX-3X; Tue, 04 Jun 2024 06:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERJF-0001SZ-9m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:22:30 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERJD-0003wc-22
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:22:29 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-794ab28c3d4so408604285a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717496546; x=1718101346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fpdJGsR7qgk4oT5VTeYTa8htjdGCAr6TqKVSUWgHDPI=;
 b=NA5oy8JYdWL7MjPaTHgMOXC8UcjyC4iDtsVxk+cRtNhyCtBhU2XBuujUVhKZlSVyug
 dbDnE/NIkF152/Dx76wOn3+qz4Xe8KetKKgiHbrqV4n2FOnQp0GVf9odqeh8VFS5nN3T
 ItWT0CwMyTGsNMpMWrGgN12WXblBv82M+yJXPhIcziTddtB4PK2bgWHcy31dtET6G6xE
 KLDQudF38esn7zOBID9ZDEmBi8+uSbpY7j6O0S+VmrqGjNYj1FGQ9ZsvV0s+f2ww1vSj
 tYvSCmRppg54Z4D8jp+cAqpzvtfrxzZEvyvGTrjqWG0o1dcfDNQytI5tGHhkXBJVSwLP
 rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717496546; x=1718101346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fpdJGsR7qgk4oT5VTeYTa8htjdGCAr6TqKVSUWgHDPI=;
 b=WhyZBYV9a3J0hMFwd1S4Q8pgNGYKA3pjM+XvGuqZeJZM0dm5ePFj7UF94ZmIYqpqSS
 Qul9Jphkj38lPShnw/RXmBtpFgwyzfYy7S2J4Ldf8CtXQrdFZC/eC9pFTfQczrrmSr+x
 r2S1D5jdr/pVbQZ2ia5KemYr1wj41a5rSMwEN90nkrwLbBR13u3R6N9x80GXgNLNyOdo
 S3Hw5EPrhjWPaCpp7L3OtugcuWik852Ak/2J855xJJDqGgyQX3KfgpKfNXVXAyBWywey
 hFmO//bSli8PMhXHZJGF3XuSFf19/VDx9YJLSsoKaHA5qI56X9L7Qyv5v5JXM9JD2cJc
 ZkSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzHENkwGEpAhlXuWg0obk2cRAHRe7qG3XmHavLNzczLVVuFWKgB731AvxS2wqA6iHHsLe0D7hNC15y0ISYztbRBVKN5TY=
X-Gm-Message-State: AOJu0Yw/icxZZbsoxAflBg3JYjQj6Y3s4R3Dkf3PX/vZ/CHkDaWAi1zQ
 BkYZn/2pP76ZZ0qKqwbdRdmQlZtMbfbKst01RnkceIwmGOFsfN1eAAdW42T2fAE=
X-Google-Smtp-Source: AGHT+IHBsjmOvKMTXR/9AhjEyJvUnZWfrVu16ORvWKW9W1f+RkhwQrAbD0fY/cEaL7WH+7SgyWpMPw==
X-Received: by 2002:a05:620a:5aca:b0:792:a9ea:37f8 with SMTP id
 af79cd13be357-794f5c794cbmr1007525885a.29.1717496545904; 
 Tue, 04 Jun 2024 03:22:25 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79519a7ba98sm30505085a.119.2024.06.04.03.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 03:22:25 -0700 (PDT)
Message-ID: <4cdab44f-79f4-4b15-bd75-0df705e17a8f@linaro.org>
Date: Tue, 4 Jun 2024 05:22:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/27] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 06:16, Alistair Francis wrote:
> The following changes since commit 74abb45dac6979e7ff76172b7f0a24e869405184:
> 
>    Merge tag 'pull-target-arm-20240531' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-05-31 11:10:10 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20240603
> 
> for you to fetch changes up to 915758c537b5fe09575291f4acd87e2d377a93de:
> 
>    disas/riscv: Decode all of the pmpcfg and pmpaddr CSRs (2024-06-03 11:12:12 +1000)
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

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


