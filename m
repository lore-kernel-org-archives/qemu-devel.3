Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F1EC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu7t-0006f7-Mf; Wed, 21 Feb 2024 16:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rcu7m-0006QX-3y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:27:31 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rcu7j-0003GH-FS
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:27:29 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-299e4b352cdso1587888a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708550846; x=1709155646;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mjv4bxLkrZRB4FbQtX61briJZD7pgF7JlPE3YnVgUAc=;
 b=S/CrLG6na+tJ+N2XvKUoLL41dDIu0eJdbtjNIfjrcPPeeoe5jfAOiwFBNVLelxUEc7
 z9u+G7evtXvVIZoHOjH+SGjmo2iS3t4FQJ9jielUt0WzqQP326D59uQy8ONLCK9II8f5
 an+4YRRaJVzstBAP4C7uZpf/fqdRwzOiHvSjvgzMplLRreIecpfaWd+JJXlrGMCgXMMU
 pgtZrXixeHhvUwbWhzQQM7qO6ZPIDaYtvzBH9R0h7309ENST7uoVOG3pwHJnVFd7HshA
 A9ujArLC/LzU1/cCuyahwQr7sTZG08g6UyP7My+0X0gxQbc5ubSDycykCz5doGGts7o5
 MF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550846; x=1709155646;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjv4bxLkrZRB4FbQtX61briJZD7pgF7JlPE3YnVgUAc=;
 b=MHbc6hADqlLRJn6V4d6iMswNReCy9IjdRkahgInn1L8srF0Vz4AL1P/gap42s2DNvl
 S5/cCmMUrxoKLRiVrAv+vvUYo88R7wg2AIs3qx4holbwPJRFwwMGc/dmi8asXUHkE3Xr
 3DHPNzm5Hp3IOSUxxrmnIa5FBTQLp6cq2dGzSQMTCNsI5Q0NtawzSFzDSRedEdnaGXt2
 OVBqYtjzexwV5DMGRcBU2RkIRhCIazga9QkZc+xlUP9kajxfCRFW4SoC3YQTW67BrtON
 0DUzDFB7axSPxxKmQEOlPJHl18lk0b1QQ5KCSiHfjt7yLbFI4QZl45wcH4JQEHijLEtF
 gkAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmQ2CATHer4JINKQ3qAe5WLy2pdzjTSFW8DL6hfiK42NC10HjD0/4KI9REmxJiA+7wdDYkGzM8RWAX4ksriuNguD5eXoc=
X-Gm-Message-State: AOJu0YwxchzlfaF3ya1qiC1LYlIRnSwmC5sN3I03CsLKlcnT0fZtXBo2
 jcAJRs/4kMHJtZV+Hwae3uKLprg/vGkvFV1gkRKZe5VidObC2toL/UsCHZ7f50A=
X-Google-Smtp-Source: AGHT+IEdxUqiZXt5mSpIZK6c/fbmXmAsdWH9qFobV1eGVFmlkMaxcimpweODCsMRe1vgThEmW3fn5g==
X-Received: by 2002:a17:90a:4381:b0:298:c136:2ffc with SMTP id
 r1-20020a17090a438100b00298c1362ffcmr14648869pjg.45.1708550846133; 
 Wed, 21 Feb 2024 13:27:26 -0800 (PST)
Received: from [172.16.0.69] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a17090a5b0200b00298ca131c75sm2310792pji.24.2024.02.21.13.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:27:25 -0800 (PST)
Message-ID: <56f06a67-3e8a-42e6-a828-f2c833c74ec4@rivosinc.com>
Date: Wed, 21 Feb 2024 13:27:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add missing include guard in pmu.h
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240220110907.10479-1-frank.chang@sifive.com>
 <9df86826-44c2-4816-ae59-189773c51d95@ventanamicro.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <9df86826-44c2-4816-ae59-189773c51d95@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/20/24 08:20, Daniel Henrique Barboza wrote:
> 
> 
> On 2/20/24 08:08, frank.chang@sifive.com wrote:
>> From: Frank Chang <frank.chang@sifive.com>
>>
>> Add missing include guard in pmu.h to avoid the problem of double
>> inclusion.
>>
>> Signed-off-by: Frank Chang <frank.chang@sifive.com>
>> ---
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
>>   target/riscv/pmu.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
>> index 505fc850d3..7c0ad661e0 100644
>> --- a/target/riscv/pmu.h
>> +++ b/target/riscv/pmu.h
>> @@ -16,6 +16,9 @@
>>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>> +#ifndef RISCV_PMU_H
>> +#define RISCV_PMU_H
>> +
>>   #include "cpu.h"
>>   #include "qapi/error.h"
>> @@ -31,3 +34,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum 
>> riscv_pmu_event_idx event_idx);
>>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char 
>> *pmu_name);
>>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>>                             uint32_t ctr_idx);
>> +
>> +#endif /* RISCV_PMU_H */
> 

Oops. Thanks for the fix.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

