Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C39CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 17:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsnP8-00067J-6S; Fri, 05 Apr 2024 13:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rsnP4-000672-El; Fri, 05 Apr 2024 13:31:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rsnP2-00074h-CM; Fri, 05 Apr 2024 13:31:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F207A5C24E;
 Fri,  5 Apr 2024 20:32:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B38CAC898;
 Fri,  5 Apr 2024 20:30:43 +0300 (MSK)
Message-ID: <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
Date: Fri, 5 Apr 2024 20:30:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
From: Michael Tokarev <mjt@tls.msk.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20240311075806.668555-1-pbonzini@redhat.com>
 <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
Content-Language: en-US
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

01.04.2024 09:02, Michael Tokarev:

> Anyone can guess why this rather trivial and obviously correct patch causes segfaults
> in a few tests in staging-7.2 - when run in tcg mode, namely:
> 
>    pxe-test
>    migration-test
>    boot-serial-test
>    bios-tables-test
>    vmgenid-test
>    cdrom-test
> 
> When reverting this single commit from staging-7.2, it all works fine again.

It sigsegvs in probe_access_internal():

   CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr); -- this one returns NULL,

and next there's a call

   tlb_addr = tlb_read_ofs(entry, elt_ofs);

which fails.

#0  0x0000555555c5de8a in tlb_read_ofs (ofs=8, entry=0x0) at 7.2/accel/tcg/cputlb.c:1455
#1  probe_access_internal
     (env=0x555556a862a0, addr=4294967280, fault_size=fault_size@entry=1, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=5, 
nonfault=nonfault@entry=false, phost=0x7fffea4d32a0, pfull=0x7fffea4d3298, retaddr=0)
     at 7.2/accel/tcg/cputlb.c:1555
#2  0x0000555555c62aba in get_page_addr_code_hostp
     (env=<optimized out>, addr=addr@entry=4294967280, hostp=hostp@entry=0x0)
     at 7.2/accel/tcg/cputlb.c:1691
#3  0x0000555555c52b54 in get_page_addr_code (addr=4294967280, env=<optimized out>)
     at 7.2/include/exec/exec-all.h:714
#4  tb_htable_lookup
     (cpu=cpu@entry=0x555556a85530, pc=pc@entry=4294967280, cs_base=cs_base@entry=4294901760, flags=flags@entry=64, cflags=cflags@entry=4278190080) at 
7.2/accel/tcg/cpu-exec.c:236
#5  0x0000555555c53e8e in tb_lookup
     (cflags=4278190080, flags=64, cs_base=4294901760, pc=4294967280, cpu=0x555556a85530)
     at 7.2/accel/tcg/cpu-exec.c:270
#6  cpu_exec (cpu=cpu@entry=0x555556a85530) at 7.2/accel/tcg/cpu-exec.c:1001
#7  0x0000555555c75d2f in tcg_cpus_exec (cpu=cpu@entry=0x555556a85530)
     at 7.2/accel/tcg/tcg-accel-ops.c:69
#8  0x0000555555c75e80 in mttcg_cpu_thread_fn (arg=arg@entry=0x555556a85530)
     at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95
#9  0x0000555555ded098 in qemu_thread_start (args=0x555556adac40)
     at 7.2/util/qemu-thread-posix.c:505
#10 0x00007ffff5793134 in start_thread (arg=<optimized out>)
#11 0x00007ffff58137dc in clone3 ()


I'm removing this whole set from 7.2 for now:

  2cc68629a6fc target/i386: fix direction of "32-bit MMU" test
  90f641531c78 target/i386: use separate MMU indexes for 32-bit accesses
  5f97afe2543f target/i386: introduce function to query MMU indices

This leaves us with

  b1661801c184 "target/i386: Fix physical address truncation"

but without its fix, 2cc68629a6fc.

It looks like I should revert b1661801c184 from 7.2 too, re-opening
https://gitlab.com/qemu-project/qemu/-/issues/2040 - since to me it isn't
clear if this change actually fixes this issue or not without the
previous change, 90f641531c78, which is missing from 7.2.10.

At the very least this will simplify possible another attempt to cherry-pick
these changes to 7.2.

Thanks,

/mjt

