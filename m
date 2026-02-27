Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F1CFD530E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtDr-0005LW-4B; Fri, 27 Feb 2026 03:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vvtDj-0005L8-H7; Fri, 27 Feb 2026 03:29:13 -0500
Received: from mwd01m.fhofhammer.de ([173.212.212.240])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vvtDf-0005lA-TY; Fri, 27 Feb 2026 03:29:10 -0500
Message-ID: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhofhammer.de;
 s=2023; t=1772180935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=VwxvP5Ed9+6mD2H0ZZhW5q2QVTuYa/dYTmAQCg13vCc=;
 b=rRzMZ+xhbz7UcY6ihWGOdJXEUNAwQGKXg+YvFwr51Uyp8J+ZHNn9GRp9tO81/s8hkKA6Rs
 IYMaTplNmsCLfTNe8Q11c/9miHxBK3wgmdCK+Xcrm/i9x9XBQ5ZQr88kMKPSbtY2HuhwLw
 KL6WoWX4rNhvppCYM7CCuPU6i9IoPCcvtBcXCtNuGMDWZiK+Vq4tGz9yc/MkvHe2WiOKbo
 uiU/I8aDNNDtUHeP3Ans/CVzOUvBltUkJBEB06NSHbAwPUOfsLWgv84mhLDi8KA+ab06WY
 1e/AmudZUrLtRGw2We8HAAKIIOoLfTfM96slpoPk75oxSLH+qVpYWiKTqU0zgMBslFmsHb
 AqYXwAOLH9f9GytwTZ0I2ia5DtyXAI7x1xHbs2I94NGj4q1XPAwKUv0l1WLIkzyATPL8fm
 uXAxd8X55H3jmf7FBbNnB78lQ7CwlGmBfH12bcJLfM0uZkc+4S/D7k2vUU2NLYiGJfNpKi
 GnpBFHfd+7D9CQ3PjyM9wGrcDKnshUncsE2CTrcxA83hAbReUwQU73M4+zCUqvl22PqF7q
 zvH3gI4c6lXKmb1wweDiy41AG9xU2RcdLuI6qSHbKSJWTh8ISGCTL98bmLFRaAg09nYue7
 nBFTF9lDrkNeR2wAZYmHKAbxA/f9tNX6wjIZglg77hcTwZgL0hfFA=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=florian.hofhammer@fhofhammer.de
 smtp.mailfrom=florian.hofhammer@fhofhammer.de
Date: Fri, 27 Feb 2026 09:28:54 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Subject: ppc-linux-user GDB stub broken
Autocrypt: addr=florian.hofhammer@fhofhammer.de; keydata=
 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
 /zEc5hMMZIzTI4AtIcgA3xe4Ew==
To: qemu-ppc@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, philmd@linaro.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=173.212.212.240;
 envelope-from=florian.hofhammer@fhofhammer.de; helo=mwd01m.fhofhammer.de
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
gdb stub test fails for ppc-linux-user when running "make check-tcg".
The error message is as follows:
      TEST    basic gdbstub support on ppc
    Python Exception <class 'gdb.error'>: Could not fetch register "fpscr"; remote failure reply '14'
    Error occurred in Python: Could not fetch register "fpscr"; remote failure reply '14'
    qemu-ppc: QEMU: Terminated via GDBstub
I've tested from a clean checkout with the following commands:
    ./configure --target-list=ppc-linux-user
    make -j$(nproc) all
    make check-tcg

According to git bisect, the test started failing with commit
1ec0fbe2ddadf17f7e0644b441833f0cd20dc137, which reduced
cc->gdb_num_core_regs from 71 to 70 (link to the patch on the mailing
list: https://lists.nongnu.org/archive/html/qemu-ppc/2026-02/msg00265.html).
Commit 7ddd3aca5f2efcf6aae10f836011e445ee77a6e1 (mailing list link:
https://lists.nongnu.org/archive/html/qemu-ppc/2026-02/msg00267.html)
got rid of the hardcoded value for cc->gdb_num_core_regs, but the test
still fails (people involved in the original patches in CC).

I've debugged around a bit but I don't know my way around the gdbstub
internals enough to propose a patch right away, so I'll just summarize
what I figured out so far.
1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
   set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
   function, cpu->gdb_num_regs gets set to 70.
2. When the test tries to read a register in gdbstub/gdbstub.c:gdb_read_register(),
   the first condition of "reg < cc->gdb_num_core_regs" is always false.
   Also, the register number for fpscr passed to the function is is 103,
   and cpu->gdb_num_regs is also 103. If the register number is supposed
   to be an index (as I understand it), this would indicate an
   off-by-one error somewhere.

If you have some pointers on where to look / what to check out for
fixing this, I'll happily try to work on a patch. But I suppose that
somebody more experienced with this could probably fix this much faster
than I can.

Best regards,
Florian

