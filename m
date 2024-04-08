Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6075CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlPK-0000F1-Ly; Mon, 08 Apr 2024 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlPJ-0000EB-0K
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:35:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlPF-0003zv-S4
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:35:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4166ccac761so5562765e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712568912; x=1713173712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayemA/VVv9k0Zz+UgTmGHdj9k8FnVzs1BskfoiT0CPI=;
 b=te12cmpKaZ7qoc+Jpgp7IxwdL3n1+HaAGZc3JA/otCPXrZBp+Au47nuufHo6Ck6Etc
 /0G03PtWo5GQ5+CAtObpbZGLMdYyjpfScmco9U+VTyppP0+9Zq+tAyvsYa1Z4Qak/1Yp
 Nz0Y2+MPBkt8zEBZepUE+RX4twZeAtoA9yxosYGvP+eHuXoJjlK5bBFH6tclxPRGpSao
 re7AjENhE65QI2P5o6e1WBKUqT0e/Vk5F/M0wLBalWjjiS7O3f4+ByVrx1VocQQXFPM0
 WpUuQXCd2kfAVK+M7coN3NnOvCzH4vmUtezwwr62f4BOnTSxPYCHRQGUSwnCMUlv/ucB
 +7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712568912; x=1713173712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayemA/VVv9k0Zz+UgTmGHdj9k8FnVzs1BskfoiT0CPI=;
 b=IbPxBBvR3Y2SO+5xgdIn5bcmsCfg280W5AEfT56V+AS64xE1nnPqslhiMBKU6vXjzg
 Vm9upFAC4Tf7c5rdiLZLUtSwS4CT7HrApcjPLwBWPzmXm0xyZ7Qupx/Mj4r6cF6TzDow
 a3UaxxBJ5bpYhGGMnS7jFGthxuTBQuBsssnBbrenCBHCH/Et85fbjcEKNSrAglE37f8V
 DsYkQYq+L2jVQ/LaPIrvaFJCCBWj1Tc4T5O8DL1j4NHrZCHZ311Cx3mIm4gj/tQ7jMoq
 l7CSrnyfGKlzk632ibzwzvCWilSyOlyQjKfUx3j0GhJu+jW+le1mlPMvecEvK+Z+etVy
 CA8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS2Zk6Vyxe9S/gaUPQQQUBskCRZf56/UH6llZh/cAehbmhkLcSs6ziD1HKxF/3RXgbBlgMDrsw8fjRaKxCz35bs41gN/o=
X-Gm-Message-State: AOJu0Yy8L8+fdmNzWBM5BPyfbooXzrjdF/uwQHuhXCeeSzNSATYevnds
 ML1qWVPxlyu+WBl5Llj168r3OU9h7ts0rkg9wtDvIaCsVjdkOaFGWFcCCyJyk5A=
X-Google-Smtp-Source: AGHT+IEnDCDsk3GhjQra+3Ep9Ort0Zqt7mVpygFX63mIcJC/COrcJ9TY/edny80HJNhSs1ZEk/humg==
X-Received: by 2002:a05:600c:4e90:b0:416:3f85:d49 with SMTP id
 f16-20020a05600c4e9000b004163f850d49mr4688499wmq.18.1712568911740; 
 Mon, 08 Apr 2024 02:35:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d5985000000b00345a5183f01sm2621162wri.108.2024.04.08.02.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 02:35:11 -0700 (PDT)
Message-ID: <feb6202e-5e27-4a3b-b281-2d3a9eb5f58a@linaro.org>
Date: Mon, 8 Apr 2024 11:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Giuseppe_Ghib=C3=B2?= <ghibo@mageia.org>
References: <20240311075806.668555-1-pbonzini@redhat.com>
 <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
 <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/4/24 19:30, Michael Tokarev wrote:
> 01.04.2024 09:02, Michael Tokarev:
> 
>> Anyone can guess why this rather trivial and obviously correct patch 
>> causes segfaults
>> in a few tests in staging-7.2 - when run in tcg mode, namely:
>>
>>    pxe-test
>>    migration-test
>>    boot-serial-test
>>    bios-tables-test
>>    vmgenid-test
>>    cdrom-test
>>
>> When reverting this single commit from staging-7.2, it all works fine 
>> again.
> 
> It sigsegvs in probe_access_internal():
> 
>    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr); -- this one 
> returns NULL,
> 
> and next there's a call
> 
>    tlb_addr = tlb_read_ofs(entry, elt_ofs);
> 
> which fails.
> 
> #0  0x0000555555c5de8a in tlb_read_ofs (ofs=8, entry=0x0) at 
> 7.2/accel/tcg/cputlb.c:1455
> #1  probe_access_internal
>      (env=0x555556a862a0, addr=4294967280, 
> fault_size=fault_size@entry=1, 
> access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=5, 
> nonfault=nonfault@entry=false, phost=0x7fffea4d32a0, 
> pfull=0x7fffea4d3298, retaddr=0)
>      at 7.2/accel/tcg/cputlb.c:1555
> #2  0x0000555555c62aba in get_page_addr_code_hostp
>      (env=<optimized out>, addr=addr@entry=4294967280, 
> hostp=hostp@entry=0x0)
>      at 7.2/accel/tcg/cputlb.c:1691
> #3  0x0000555555c52b54 in get_page_addr_code (addr=4294967280, 
> env=<optimized out>)
>      at 7.2/include/exec/exec-all.h:714
> #4  tb_htable_lookup
>      (cpu=cpu@entry=0x555556a85530, pc=pc@entry=4294967280, 
> cs_base=cs_base@entry=4294901760, flags=flags@entry=64, 
> cflags=cflags@entry=4278190080) at 7.2/accel/tcg/cpu-exec.c:236
> #5  0x0000555555c53e8e in tb_lookup
>      (cflags=4278190080, flags=64, cs_base=4294901760, pc=4294967280, 
> cpu=0x555556a85530)
>      at 7.2/accel/tcg/cpu-exec.c:270
> #6  cpu_exec (cpu=cpu@entry=0x555556a85530) at 
> 7.2/accel/tcg/cpu-exec.c:1001
> #7  0x0000555555c75d2f in tcg_cpus_exec (cpu=cpu@entry=0x555556a85530)
>      at 7.2/accel/tcg/tcg-accel-ops.c:69
> #8  0x0000555555c75e80 in mttcg_cpu_thread_fn 
> (arg=arg@entry=0x555556a85530)
>      at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95
> #9  0x0000555555ded098 in qemu_thread_start (args=0x555556adac40)
>      at 7.2/util/qemu-thread-posix.c:505
> #10 0x00007ffff5793134 in start_thread (arg=<optimized out>)
> #11 0x00007ffff58137dc in clone3 ()
> 
> 
> I'm removing this whole set from 7.2 for now:
> 
>   2cc68629a6fc target/i386: fix direction of "32-bit MMU" test
>   90f641531c78 target/i386: use separate MMU indexes for 32-bit accesses
>   5f97afe2543f target/i386: introduce function to query MMU indices

Cc'ing Giuseppe Ghibò for
https://gitlab.com/qemu-project/qemu/-/issues/2264

> This leaves us with
> 
>   b1661801c184 "target/i386: Fix physical address truncation"
> 
> but without its fix, 2cc68629a6fc.
> 
> It looks like I should revert b1661801c184 from 7.2 too, re-opening
> https://gitlab.com/qemu-project/qemu/-/issues/2040 - since to me it isn't
> clear if this change actually fixes this issue or not without the
> previous change, 90f641531c78, which is missing from 7.2.10.
> 
> At the very least this will simplify possible another attempt to 
> cherry-pick
> these changes to 7.2.
> 
> Thanks,
> 
> /mjt
> 


