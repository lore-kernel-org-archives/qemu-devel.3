Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EA2C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcbP-0008RZ-2R; Mon, 29 Jul 2024 22:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYcbO-0008R5-BH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:28:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYcbM-0007vg-9Z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:28:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso2653885b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722306515; x=1722911315;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2EaZ+aIL+lwXwXvSIgd+06Yoo8LOG1/628P6VRlgoTI=;
 b=j0t0x0Q3SHnGXTFG382S3Xy8RtNVf63IYPaH+Mb6inNL6ObX+Hw/8zUNrY6VRG04UM
 2o7fVl8ASr61U+KrIwiwuEXv6VuyWupJp6rfMAqkxWriZ7OLeEG+7MWmpVS7qyY71rHJ
 qdpG54QeaTBRnzTMxMlFjXPw3dgo10yVqcubRmoGvczclmUifTwl51RCWBtsJm+KOnUZ
 1zycpksyaGtPEvjjahe9GpncMoc2IBJqOxGoZuJYTfn18e8TKuvDEkHlZePd2yL0+NUz
 sJS0o0DG7oIibiUHiyMhLo11LqSW5goyoJ191/AugT7RryvginPxr5br8iYiSPpDXb3O
 eTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306515; x=1722911315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EaZ+aIL+lwXwXvSIgd+06Yoo8LOG1/628P6VRlgoTI=;
 b=hTDXIsARapJ6JNaRsaJ/4+ZeKZZ/Y7yeJThGgFpJ36sKfcdsP7i7nQ16X0tfMCIAGT
 cJrWmZtnu4FPlUyKPC3XoTuNPrbqpnepaV2zJXp5sR+Xr74KcmOCV1u0/3YZg3v+IF5C
 yy09Yi7QD6yXjLktetjdj5hcgX8MGGRUnGTSVMXrb2U+MU6pqzWSsHe776/4yzhutAQA
 IulFj96jCYu5uUeWIBZd12hEQq64ZtDGdvXHlgXCGf4BSjdGoodewk/LocDF+GWl4ANx
 hu/BTeofd9yF4KZcaXOsfJ1KC97QVKRDgoDzjuBIB2CRHGPO/q++z4/DgRoch/l8IHYO
 5P1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDDOEwUgbCS92/tUJQ017jQfT9RgUCUON+yYRCx/ai3+yW/RQ3NDf4zCgmgj38nOOYppMlfX7sqbgoD2j/PS2GRwwUkmc=
X-Gm-Message-State: AOJu0YxDFP3yO2H1PQWBYYhioLt2VbQ5pqKsTp2U3RKJ+WF/eGsJF5Cy
 GlkKJf+nPttJEVIPtdSrus8TLF4HtqJBeTq8olAVfkImtUF1VmkXuzNbNkfFo2II5202jPlgF6H
 S
X-Google-Smtp-Source: AGHT+IGK4kDYOnzQ1LHP7gsh9qlHSbfFXnTFYONcHGHNRhTT3FI0voLN26sc4ZaMGv+blt8kta9mnA==
X-Received: by 2002:a05:6871:4006:b0:261:2c4:f7a0 with SMTP id
 586e51a60fabf-267d4f80cf9mr9752173fac.51.1722296021991; 
 Mon, 29 Jul 2024 16:33:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a35d2sm7364223b3a.199.2024.07.29.16.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 16:33:41 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:33:39 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2 03/24] target/riscv: save and restore elp state on
 priv transitions
Message-ID: <Zqgm0+qXaDmmsaKE@debug.ba.rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-4-debug@rivosinc.com>
 <2fea7463-89e9-4fc4-9926-dba304838aab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2fea7463-89e9-4fc4-9926-dba304838aab@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks Richard.

On Tue, Jul 30, 2024 at 09:04:29AM +1000, Richard Henderson wrote:
>On 7/30/24 03:53, Deepak Gupta wrote:
>>elp state is recorded in *status on trap entry (less privilege to higher
>>privilege) and restored in elp from *status on trap exit (higher to less
>>privilege).
>>
>>Additionally this patch introduces a forward cfi helper function to
>>determine if current privilege has forward cfi is enabled or not based on
>>*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
>>new field `ufcfien` is introduced which is by default set to false and
>>helper function returns value deposited in `ufcfien` for qemu-user.
>
>Why are you using a different field for qemu-user?
>Much better to simply configure menvcfg the same as for system mode.


I am assuming `CONFIG_USER_ONLY` is set for qemu-user builds and unset
for `not qemu-user` builds. Let me know if I got that right?

`menvcfg` (and a lot of other system related fields CPUArchstate for riscv)
are wrapped under `#ifndef CONFIG_USER_ONLY`. So `menvcfg` field is not
available for qemu-user compile.


>
>
>>+        return (env->menvcfg & MENVCFG_LPE) ? true : false;
>
>Never use ?: with true/false.  Use the correct boolean expression in 
>the first place, which in this case is just the & expression.

Noted.
Will fix this and other instances in patch series.

>
>
>r~

