Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EA1C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rvQ-0000oc-1W; Tue, 29 Apr 2025 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9rvM-0000ny-MG; Tue, 29 Apr 2025 16:51:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9rvK-0000wV-2f; Tue, 29 Apr 2025 16:51:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E246555D239;
 Tue, 29 Apr 2025 22:51:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AS7Zlk74QtLh; Tue, 29 Apr 2025 22:51:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A8C0A55C592; Tue, 29 Apr 2025 22:51:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A4BA2745682;
 Tue, 29 Apr 2025 22:51:20 +0200 (CEST)
Date: Tue, 29 Apr 2025 22:51:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <87tt663l1d.fsf@draig.linaro.org>
Message-ID: <35d18868-703a-7140-d4e9-c0be428997dd@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <87bjsf3s40.fsf@draig.linaro.org>
 <a121583f-2ec0-4f81-b5b3-1259906afb8e@linaro.org>
 <87tt663l1d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-3550498-1745959880=:53107"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-3550498-1745959880=:53107
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 29 Apr 2025, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 4/29/25 08:27, Alex Bennée wrote:
>>>>                 - 45.16% rr_cpu_thread_fn
>>> Hmm you seem to be running in icount mode here for some reason.
>>
>> For some reason ppc32 does not enable mttcg.
>> I'm not sure what's missing to enable it properly.
>
> I seem to recall it may have been reverted due to instability but I
> can't find the commit.

Or maybe it was never enabled? We've recently tried mttcg with G4 mac99 
machine and it seems to work but the needed patches were not cleaned up 
for upstream yet so they are using a fork for that now. But that's a 
digression.

I've tried to rerun the benchmark with qemu-system-ppc64 instead of 
qemu-system-ppc (no other change in the command) and it did not seem to 
help much, it's still slow. Here's the profile:

   Children      Self  Command          Shared Object            Symbol
-   99.42%     0.78%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_exec_loop
    - 99.32% cpu_exec_loop
       - 99.32% cpu_tb_exec
          - 91.29% 0x7f25d079f8b4
               helper_ldub_mmu
               do_ld_mmio_beN
             - cpu_io_recompile
                - 49.05% mttcg_cpu_thread_fn
                   - 49.05% tcg_cpu_exec
                      - 49.05% cpu_exec
                         - 49.04% cpu_exec_setjmp
                            - cpu_exec_loop
                               - 49.03% cpu_tb_exec
                                    38.92% 0x7f25cf3f0000
                                  - 0.63% 0x7f25fe78bd93
                                       helper_VPERM
                                  - 0.61% 0x7f25fe78bed8
                                       helper_VPERM
                - 42.24% cpu_loop_exit_noexc
                     cpu_loop_exit
                     __longjmp_chk
                     cpu_exec_setjmp
                   - cpu_exec_loop
                      - 42.23% cpu_tb_exec
                           38.67% 0x7f25cf3f0000
                         - 0.62% 0x7f25fe78bd93
                              helper_VPERM
                         - 0.60% 0x7f25fe78bed8
                              helper_VPERM
          - 5.78% 0x7f25d0625055
               helper_raise_exception
               mttcg_cpu_thread_fn
               tcg_cpu_exec
               cpu_exec
               cpu_exec_setjmp
               cpu_exec_loop
               cpu_tb_exec
               0x7f25d0625055
               helper_raise_exception
               mttcg_cpu_thread_fn
               tcg_cpu_exec
               cpu_exec
               cpu_exec_setjmp
               cpu_exec_loop
             - cpu_tb_exec
                - 5.78% 0x7f25d0625055
                   - helper_raise_exception
                      - 5.49% mttcg_cpu_thread_fn
                         - 5.16% tcg_cpu_exec
                            - 5.11% cpu_exec
                               - 5.03% cpu_exec_setjmp
                                  - 5.01% cpu_exec_loop
                                     - 4.27% cpu_tb_exec
                                          1.60% 0x7f25cf3f0000
+   99.41%     0.25%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_tb_exec
+   99.41%     0.01%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_exec_setjmp
+   98.02%     0.17%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_exec
+   97.99%     0.02%  qemu-system-ppc  qemu-system-ppc64        [.] tcg_cpu_exec
+   97.98%     0.05%  qemu-system-ppc  qemu-system-ppc64        [.] mttcg_cpu_thread_fn
+   92.38%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_io_recompile
+   91.54%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] do_ld_mmio_beN
+   91.51%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] helper_ldub_mmu
+   91.49%     0.00%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25d079f8b4
+   81.15%     0.00%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25cf3f0000
+   44.70%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_loop_exit
+   44.50%     0.01%  qemu-system-ppc  libc.so.6                [.] __longjmp_chk
+   43.16%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_loop_exit_noexc
+    9.57%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] helper_raise_exception
+    8.02%     0.08%  qemu-system-ppc  qemu-system-ppc64        [.] notdirty_write.isra.0
+    7.60%     0.05%  qemu-system-ppc  qemu-system-ppc64        [.] mmu_lookup
+    7.50%     0.03%  qemu-system-ppc  qemu-system-ppc64        [.] tb_invalidate_phys_range_fast
+    7.34%     0.05%  qemu-system-ppc  qemu-system-ppc64        [.] do_st4_mmu
+    7.18%     0.02%  qemu-system-ppc  qemu-system-ppc64        [.] mmu_watch_or_dirty
+    6.99%     6.99%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7bba4b
+    6.82%     6.82%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7c6545
+    6.01%     6.01%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7bbac9
+    5.94%     5.94%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7bbb47
+    5.90%     5.90%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7bb968
+    5.85%     0.00%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25d0625055
+    5.45%     1.17%  qemu-system-ppc  qemu-system-ppc64        [.] page_collection_lock
+    5.13%     5.13%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7c654b
+    5.08%     5.08%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe71f74b
+    5.07%     5.07%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7c624f
+    5.05%     5.05%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe7c6249
+    4.93%     4.93%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe71f740
+    4.64%     4.64%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe71f890
+    4.49%     4.49%  qemu-system-ppc  [JIT] tid 12410          [.] 0x00007f25fe71f885
+    4.05%     1.51%  qemu-system-ppc  qemu-system-ppc64        [.] page_trylock_add
+    3.64%     3.62%  qemu-system-ppc  qemu-system-ppc64        [.] helper_VPERM
+    2.43%     1.40%  qemu-system-ppc  qemu-system-ppc64        [.] probe_access
+    2.16%     0.51%  qemu-system-ppc  libglib-2.0.so.0.7600.3  [.] g_tree_lookup
+    2.09%     0.00%  qemu-system-ppc  qemu-system-ppc64        [.] cpu_loop_exit_restore
+    1.66%     0.06%  qemu-system-ppc  qemu-system-ppc64        [.] helper_store_msr
+    1.61%     0.12%  qemu-system-ppc  qemu-system-ppc64        [.] hreg_store_msr
+    1.52%     1.52%  qemu-system-ppc  qemu-system-ppc64        [.] tb_invalidate_phys_page_range__locked.constprop.0
+    1.49%     0.05%  qemu-system-ppc  qemu-system-ppc64        [.] dcbz_common

The times with 100 iterations were:
mapping 0x80800000
src 0xb773a008 dst 0xb7638000
byte loop: 6.49 sec
memset: 0.44 sec
memcpy: 1.6 sec
copyToVRAMNoAltivec: 0.8 sec
copyToVRAMAltivec: 0.88 sec
copyFromVRAMNoAltivec: 8.15 sec
copyFromVRAMAltivec: 8.41 sec

(previous results were with 10000 iterations but I did not rerun that now, 
I assume we can roughly take 100 times these results to compare to that. 
Then this may be even slower with qemu-system-ppc64 which can be as some 
code is compiled out without TARGET_PPC64 defined.)

I try to investigate more but I'm still quite lost.

Regards,
BALATON Zoltan
--3866299591-3550498-1745959880=:53107--

