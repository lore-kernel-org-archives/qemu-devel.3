Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30EDEED630
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 18:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbNDZ-0001M4-6m; Thu, 01 Jan 2026 13:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbNCh-0001Bf-8z
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:27 -0500
Received: from 16.mo582.mail-out.ovh.net ([87.98.139.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbNCd-0006I5-48
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:18 -0500
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.254.66])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4dhw3J33Wpz6W45
 for <qemu-devel@nongnu.org>; Thu,  1 Jan 2026 18:15:08 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-kbmwb (unknown [10.110.164.150])
 by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 02DCDC02A2;
 Thu,  1 Jan 2026 18:15:06 +0000 (UTC)
Received: from petrot.fr ([37.59.142.99])
 by ghost-submission-7d8d68f679-kbmwb with ESMTPSA
 id QUyEM6q5Vmlo/w0A7Yva2g
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>);
 Thu, 01 Jan 2026 18:15:06 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003dc46b35d-15cc-44ba-a0bb-8556c1fb4bbe,
 8D8ADDDE20E1118D614694FD1C3138A4D0B19743) smtp.auth=frederic@petrot.fr
X-OVh-ClientIp: 79.90.201.35
To: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 0/2] Re: [PATCH 1/1] trans_rvi.c.inc: Make lq and sq use
 128-bit ld/st
Date: Thu,  1 Jan 2026 19:14:40 +0100
Message-ID: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13379068595533059349
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF1XeEvy9PULW+sBT+ey+2t3SKqc2kGk8KHip2/qJlh3tg7vmorAanpWAFMefSmUpU0OkOAoX7o8B/+gwgLc4I6Y5l9B8Lmb/Cc5QZqUFCXLBhYaZCNmrYxz3rylymGkuShtxPuqF4j43Jl+ZYQpYh8ZkCfZ0tUAB6cFu+/+fl+hvprTHF0/kScmM6DyDi3yfTNThlcXXh2dRDvP69330vRG04pxSuXrEFapA9qsmb/dNbI/ssC4IbvBcJQrXw107md1V5dJMzDI6xxHXu9hI9aGNdlCDNYvXxXmZv9yMKW3IF3YDRsxw9E1go4uNkLt/GVUHzDu8/uo3IxVqmFpOEpdwi9yehFI09iDcri4EKRQeGM7os1GfA5U3LKWChQSzMlf6OI+scYmUzzlfoH+cuVo4P7euXCxUHYED+but1l0W0GuRbSSC2qhdxAAQJpFL6T0td12/P//sDNZI69fmq9T07heSkUhFnztJPitm2breCUQnB86+H0pvrPCNwGzjvxH9X058nIxYwkkr4Q5IVKjF8J6nQ/wMrwIvJ1U65FM3wPHcfIvHAqUpQa8DFCAK+gy16osySzL3H19gxP+KSps67svW848jhdE6dxuvi4rPPgTUxTzukrqJyOFSd7sSF+8OJGXHmHcgBQGf5VTcm3tdeisXqlSwsRFPUtMbc0uw
Received-SPF: softfail client-ip=87.98.139.208;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=16.mo582.mail-out.ovh.net
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Reply-to:  =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
From: frederic.petrot--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 12/26/25 17:06, Philippe Mathieu-Daudé wrote:
> Hi Frédéric,
> 
> On 16/12/25 22:24, Frédéric Pétrot wrote:
>> The lq and sq helpers for the experimental rv128 architecture currently
>> use direct (and erroneous) memory accesses.
>> Replace these direct accesses with the standard tcg_gen_qemu_{ld,st}_i128
>> TCG helpers that handle endianness issues.
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Errors when building qemu-system-riscv32:
> 
> [3/5] Compiling C object libqemu-riscv32-softmmu.a.p/target_riscv_translate.c.o
> In file included from ../../target/riscv/translate.c:1192:
> ../../target/riscv/insn_trans/trans_rvi.c.inc:395:35: error: incompatible 
> pointer types passing 'TCGv' (aka 'struct TCGv_i32_d *') to parameter of type 
> 'TCGv_i64' (aka 'struct TCGv_i64_d *') [-Werror,-Wincompatible-pointer-types]
>    395 |             tcg_gen_extr_i128_i64(destl, desth, t16);
>        |                                   ^~~~~
> include/tcg/tcg-op-common.h:309:37: note: passing argument to parameter 'lo' here
>    309 | void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
>        |                                     ^~
> ... 

Outch, sorry for that!

Since lq/sq are meaningful only for x-rv128 that is based on rv64, I've
handled this compilation issue in such a way that it compiles for rv32
and compiles and does what is expected for rv64 with '-cpu x-rv128'.
Using these 128-bit ld/st has the additional benefit of allowing the use
of the mttcg, as, if I understood correctly, they are atomic.

Frédéric Pétrot (2):
  trans_rvi.c.inc: Make lq and sq use 128-bit ld/st
  riscv/tcg/tcg-cpu.c: Remove smp check for x-rv128

 target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
 target/riscv/tcg/tcg-cpu.c              | 10 --------
 2 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.43.0

