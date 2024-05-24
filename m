Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3615DC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 11:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sATMH-0004xc-6d; Fri, 24 May 2024 07:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sATMB-0004vn-F4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 07:45:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sATM8-0001iE-2v
 for qemu-devel@nongnu.org; Fri, 24 May 2024 07:45:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054bso721595b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716551100; x=1717155900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a5tlHD8Yz3P5Pg+gzt5QRldJ3RVCiwb9EinU6f4f46w=;
 b=HJlQDoNbOkjCrKnxzMBG0f/YmT1IzOJsi9pZwyC0uekCO5h/neZ6bdbPajf5CzXgIl
 xTyzyFggezncXSDIOgFJiyD29Oxheu5nHoF7u3IS/KM5JcvfapiEG3fr43VAQDaZlksb
 49SRky0+PoGvOKZ3lAsI+vJR98p9/e3b+hhmKlp0CDMMwO9dVOoFDiq3MotXAbqI4K7u
 RXLkl4qKG49Dafvrv33aDN0vvi7ao9pRNkdcn3uAAKzirFsGNdQKG1jjxENqKdRj+g3M
 Ndmmtk/SjYtfqtnIHa1elVqbjK3KYczPriOUWBRVlEwQcapbgU1EeNkRTgX9qTdGqqkG
 DQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716551100; x=1717155900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a5tlHD8Yz3P5Pg+gzt5QRldJ3RVCiwb9EinU6f4f46w=;
 b=B1dlOD1YkEQPfxAuO9zRXr1iSayzJeDfj5aO62iSGEKs6vjNcsIkV7oann+LKFHqVv
 cTubdP0wNA4x9NiPE/QjGJYiRebmASGkhv3iculrhyca0h3HG+OlB9RkCoT/j97lXh4k
 6uRb5O6nUDRC326W2SoypWIUa2oHDaDpl0ssKSoXClW8nQbPV4Tq8CPgBQ0qzUHxBss9
 pcEDeDOkFt4ZG9OMlb5Zd4PnrBh8TO24+RS+UbzApfA+ysJi5YWbmuw3x5oPc3Jz5pnU
 9SuezX/k7Xx82MtszXSRxDB5OsZ2QZ69VUwvFj6BfmKoDwh9JvAo0nezHSRhYRIU1Ehg
 0lJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsSOTqbTzOtL3l8dg+ljPQen5++wjDYnLxhc3SZ5M34J/O5FZCxw4UQDG7etEPjyCs0kkc/0uNfdnoWYKSq1S+4o39bw=
X-Gm-Message-State: AOJu0YytKf3/WX/T1/3vbO/HkWWxh3nrn9Q/8YhZdMafAGFT1TXVSUmu
 cSviiar9MtfG0DxIWwNnp6k2j5vITXu8tYIywcFii5qym0+o3TwjWDRRbXyb3fw=
X-Google-Smtp-Source: AGHT+IF4K7A9sWr9/okEqrf1h6PN56PFTbwwE869AqJsBoO+ahB3YB+ydpPuPsts+5Pd+cPqfM0Xzg==
X-Received: by 2002:a05:6a21:6da3:b0:1b0:180b:218a with SMTP id
 adf61e73a8af0-1b212ccf871mr2666930637.13.1716551100505; 
 Fri, 24 May 2024 04:45:00 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3eaeesm950027b3a.43.2024.05.24.04.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 04:45:00 -0700 (PDT)
Message-ID: <8cc80b22-d159-4c8a-8860-30d229bae8d6@ventanamicro.com>
Date: Fri, 24 May 2024 08:44:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/riscv: Support Zabha extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Hi Zhiwei!



On 5/23/24 09:40, LIU Zhiwei wrote:
> Zabha adds support AMO operations for byte and half word. If zacas has been implemented,
> zabha also adds support amocas.b and amocas.h.
> 
> More details is on the specification here:
> https://github.com/riscv/riscv-zabha
> 
> The implemenation of zabha follows the way of AMOs and zacas.
> 
> This patch set is based on these two patch set:
> 1. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.html
> 2. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.html

These 2 series doesn't seem to apply on top of each other, doesn't matter which
order I try. Applying zimop/zcmop first, then zama16b:

$ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
Applying: target/riscv: Support Zama16b extension
error: patch failed: target/riscv/cpu.c:1464
error: target/riscv/cpu.c: patch does not apply
Patch failed at 0001 target/riscv: Support Zama16b extension
hint: Use 'git am --show-current-patch=diff' to see the failed patch


Applying zama16b first, then zimop/zcmop:

$ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
Applying: target/riscv: Support Zama16b extension
$
$ git am \[PATCH\ 1_4\]\ target_riscv\:\ Add\ zimop\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml \[PATCH\ 2_4\]\ disas_riscv\:\ Support\ zimop\ disassemble\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml
Applying: target/riscv: Add zimop extension
error: patch failed: target/riscv/cpu.c:1463
error: target/riscv/cpu.c: patch does not apply
Patch failed at 0001 target/riscv: Add zimop extension


If the series are dependent on each other perhaps it's easier to send everything
in a single 11 patches series.


Thanks,

Daniel

> 
> 
> LIU Zhiwei (6):
>    target/riscv: Move gen_amo before implement Zabha
>    target/riscv: Add AMO instructions for Zabha
>    target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
>    target/riscv: Add amocas.[b|h] for Zabha
>    target/riscv: Enable zabha for max cpu
>    disas/riscv: Support zabha disassemble
> 
>   disas/riscv.c                               |  60 ++++++++
>   target/riscv/cpu.c                          |   2 +
>   target/riscv/cpu_cfg.h                      |   1 +
>   target/riscv/insn32.decode                  |  22 +++
>   target/riscv/insn_trans/trans_rva.c.inc     |  21 ---
>   target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++++++
>   target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
>   target/riscv/translate.c                    |  36 +++++
>   8 files changed, 266 insertions(+), 34 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
> 

