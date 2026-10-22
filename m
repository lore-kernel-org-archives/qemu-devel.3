Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317E606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VAlmIJGr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJv5E-0004r8-72; Thu, 22 Oct 2026 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJv5C-0004qt-Lo
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:51:58 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJv5A-0002Jp-RG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:51:58 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b09e07e149so19466947b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684315; cv=none;
 d=google.com; s=arc-20260327;
 b=ZGIhw6oIF5Xh0OXZGP97qZbdAwbLdckifU6v12VChx4MayE9S56vTh1Tyx55io4MbG
 btTx5DoxGkxiX+iWzl2zfymyZdYNy7wq5RfCB/r+P2Nnndy9mdDY8yg6NBQF/seKcfgo
 f46kXLSpcEzuw25Z6aNu/aWz8AaVHUEzASvKnDXTJeAh+HYt5xluvpHj8Uow+CRHy7rm
 RcrJTeBusdIUnMN2/L2sNAI7V/JJwd03IBGQJ5t9fCYdCt2frgMr5FHg9T1nf3YN570E
 /ojDDiBwdNjg/oiCMlw3FdQrdegIRKph2MzeioIuZjjJnTKWYHcK0Y8094oU2fDFYjko
 +x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=J9CqLs6+Mm5qpzKwegGysuCsOhTAC0AaSvt284Er5HE=;
 fh=TRprHe8Ly4r4Gp/hkMfLWYg35Due7zYkNqSPlkAmVvg=;
 b=jEajtKpQ7iPff49IeWsLyZ5FtsrE972SI+JCeArGKFErJ263rusIGfsT/3CBnl+gd5
 GsP4rB+rYc4I7F/G/kBrpsbnU3kd2SygmDH+JcL6vzD5SVKDTwMg9UZijsUeM/Z2JDQ3
 tQoD/nT3nTvf4i9OnHKfoZwPg42UQcM0I7ssarHoXZhCD1qborSeuRU1/3eRrhpbFodz
 jALbWlXWWQR+VcJ7ZWPVXnwuKtyoHLsxak6+H+2NactXjChmnEn/2XvePi/HQdkw/TFN
 osH86P9XjLL7en/xuC+DA/9Uy6c3Lf6xVNYiVvMPNR7gKno4IxUMJd3XQa+Eebns4kv0
 KiEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792684315; x=1793289115; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J9CqLs6+Mm5qpzKwegGysuCsOhTAC0AaSvt284Er5HE=;
 b=VAlmIJGr7Hmy1K+5qYaBF6UJ92/w5S/G39nnMahtMxyl3gNQG5yjnEybwod/faG1lg
 UHuyiGK4ln79g+qK9m4grmKWGclagJBkt/DN3sBZLTsvM5OZfftBA7ZKC1KPjfzmBcs9
 AyOMtyfRXK5QmC/BShEJgYEgUPxDJ+cKgPA8W8+yT4UNp/h6daPuFmbKl/i/a/2meD1P
 3rC6hY0NGpx6CYcoYlm97343c2Az61FmcrWI167pzw+yeJB3YyAYN3dtcg5YSlXmy7AW
 YoxClhrxUpT8IU6ezjSSvJmmDrMijMCrlwzwqIduGTBa4VoYW5twYOJvIcPIgUF1Kccc
 fXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684315; x=1793289115;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J9CqLs6+Mm5qpzKwegGysuCsOhTAC0AaSvt284Er5HE=;
 b=lB7FKtYBFAuwmKyQOgIBeo/JxI0x8xyIai5GMEJmJY0t008/KIMckgCbI0YBmwd1DR
 O7zEUr+cfX9mR3i73/xeT3H4EoyCqER5jMqibXsPOmmLrWEABUKiFvP+gfOjcRWdQ4oh
 KqnZtgJKEk1uG3lYECfpnWSeKwqegaDYTKlk4aWiPyX6OQQOEYeV2epw7gXfBqK5hESd
 vy6NJ6PEQRcsTasf1AXxX/vRLe01SEgS9tR/JNd1vJoSXq12ht/AvClz8Z1/LZxvIIc/
 CxbMfSGuFj3Wk39ekX/jDaPHS1OVMSg3eGvBeXX2wqRs3U5DW+R/cLcw42efSN+S7Cmt
 R0kg==
X-Gm-Message-State: AFq9FYLOL4m49eyEKUlz1xHddAhN34NI0VYiJxNJU6Kz7ss2Nc+yrba7
 5CMTTkUH4TaT0q/TUeZR6gNd792aQ0KTIs00wySW+FiESH/Wn6Vo+ztyl35HlVkJ2DLQWJujXst
 48eeDX2yJBkqQadX5gBd7uD+vR+jsJo9Vl1idSVRF4cllCmiqPSRC04CGXg==
X-Gm-Gg: AYBFou2lxNINvM9WfHsEsZFX4Dnd4aqpKWwJoS00C8OqYi99q8E/fmfiYppxjnd7/4q
 IKdilqcfxhsIxXZFR1Bna3OyznE7B1+Iu04dmRYUVxdTNc/6tb9DGahhz9tkQkZTx8Nh+yhBN+A
 rfDYBUFx8UR2ehcskf3fl11kjNzAa282+AonJm0JeD9p9aLWMoaR5wlO8hIqkarUoV17sYbZF98
 +I3bUpLgBEMy/4uJG9AynN1/zA6WF4yeAw5bql0XeGUtoaE8/PDbZzIJh5cBfgtyRXtLvxQDKVp
 wqIbLH/v4b/nCFjm6bKSA5kuBTDbLR8PdUKHt+zV5BYZQNpYFtazOvR3ma/HeO6Nmp5CCGAhVv6
 7+at9rx2fuCVd/xui7OigCx0Q79Bc4p1n6/6hPWTbX5hLiH9U5U3R0IBC5qxzgD1ZKdQ/B6qbpO
 Zyazr+SHBrySDreNBq5tlZ
X-Received: by 2002:a05:690c:d8f:b0:8b0:6617:e241 with SMTP id
 00721157ae682-8b133d07ddcmr28693247b3.4.1792684314723; Thu, 22 Oct 2026
 08:51:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 16:51:42 +0100
X-Gm-Features: AclHuK-lbX4glG2jFpuTtDhHBF0OUZ-2EygR6lW_wlocbJlm6nUS186J_8Kp9hs
Message-ID: <CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com>
Subject: tests/tcg: how should we skip a gdb test if the host's gdb isn't new
 enough?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, 
 Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I noticed that the gdbstub/memory.py test hangs for me when it tries
to test the loongarch64 architecture. Running it as a standalone
test (which is what "make check" does) hangs too (transcript at
end of mail).

I'm guessing that the fundamental cause of this is that my host
gdb doesn't like talking to the gdbstub, and reports in the log:
"warning: Architecture rejected target-supplied description".
(The hang seems to be because we continually re-execute a
store insn that provokes a debug exception -- presumably the
gdb is not doing what it should at its end and reporting
and then deleting the watchpoint before continuing, so we just
keep reporting the watchpoint hit to gdb endlessly.)

The gdb is the gdb-multiarch Ubuntu one; --version reports
"GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1"

How in the gdbstub test framework should we detect "this gdb
isn't good enough for this architecture/test" and skip tests?


===begin===
$ /home/pm215/qemu/tests/tcg/../guest-debug/run-test.py --gdb
/usr/bin/gdb-multiarch --qemu
/home/pm215/qemu/build/loongarch-dbg/qemu-system-loongarch64 --qargs
'-display none -serial stdio -kernel' --bin
build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test --test
/home/pm215/qemu/build/loongarch-dbg/../../tests/tcg/multiarch/system/../gdbstub/memory.py
QEMU CMD: /home/pm215/qemu/build/loongarch-dbg/qemu-system-loongarch64
-display none -serial stdio -kernel
build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test -S -gdb
unix:path=/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=on
qemu-system-loongarch64: -gdb
unix:path=/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=on: info:
QEMU waiting for connection on:
disconnected:unix:/tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket,server=on
GDB CMD: /usr/bin/gdb-multiarch
build/loongarch-dbg/tests/tcg/loongarch64-softmmu-memory.test -q -n
-batch -ex 'set pagination off' -ex 'set confirm off' -ex 'target
remote /tmp/tmpodrh2895qemu-gdbstub/gdbstub.socket' -x
/home/pm215/qemu/build/loongarch-dbg/../../tests/tcg/multiarch/system/../gdbstub/memory.py
warning: Architecture rejected target-supplied description
0x000000001c000000 in ?? ()
ATTACHED: Loongarch64
Checking we can step the first few instructions
0x000000001c000004 in ?? ()
0x000000001c000008 in ?? ()
0x000000001c00000c in ?? ()
PASS: single step in boot code
Setup catch-all for _exit
Breakpoint 1 at 0x220000: file
../../tests/tcg/loongarch64/system/boot.S, line 24.
Breakpoint 2 at 0x2015ec: file
/home/pm215/qemu/tests/tcg/multiarch/system/memory.c, line 510.

Breakpoint 2, main () at
/home/pm215/qemu/tests/tcg/multiarch/system/memory.c:510
510         bool ok = true;
PASS: break @ 0x2015ec <main+16> ({int (void)} 0x2015dc <main> 1 hits)
Hardware access (read/write) watchpoint 3: test_data[128]
Test data start: 0x238000
Test data end: 0x23c000
Filling test area with u8 (238000):.
Hardware access (read/write) watchpoint 3: test_data[128]

Value = 0 '\000'
init_test_data_u8 (unused_offset=0) at
/home/pm215/qemu/tests/tcg/multiarch/system/memory.c:77
77              *ptr++ = BYTE_NEXT(count);
PASS: awatch for test_data[128]
Hardware read watchpoint 4: test_data[128]
...............................................................................................................................done
16384 @ 23c000
Reading u16 from 0x238000 (offset 0):.
Hardware read watchpoint 4: test_data[128]

Value = 128 '\200'
read_test_data_u16 (offset=0) at
/home/pm215/qemu/tests/tcg/multiarch/system/memory.c:213
213             word = *ptr++;
PASS: rwatch for test_data[128]
Hardware watchpoint 5: test_data[128]
...............................................................done
8192 @ 23c000
Reading u32 from 0x238000 (offset
0):................................done 4096 @ 23c000
Reading u64 from 0x238000 (offset 0):................done 2048 @ 23c000
Filling test area with u16 (offset 0, 238000):.
===endit===

thanks
-- PMM

