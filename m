Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE96C5475B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgj9v-0007UZ-Lt; Sun, 03 Mar 2024 05:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1rgj9l-0007Tu-70; Sun, 03 Mar 2024 05:33:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1rgj9i-0005xA-Ti; Sun, 03 Mar 2024 05:33:20 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4TndSz6Y6Nz1qsP8;
 Sun,  3 Mar 2024 11:33:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4TndSz5dW3z1qqlS;
 Sun,  3 Mar 2024 11:33:07 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id klEGctD5HFrw; Sun,  3 Mar 2024 11:33:06 +0100 (CET)
X-Auth-Info: yNFI/4S470aCEYpBBLczPGvbs0ZkiuEy+ar8OniSFxeO2J1b0K/eYmdUkIvli/0K
Received: from tiger.home (aftr-62-216-202-45.dynamic.mnet-online.de
 [62.216.202.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun,  3 Mar 2024 11:33:06 +0100 (CET)
Received: by tiger.home (Postfix, from userid 1000)
 id 4E251266802; Sun,  3 Mar 2024 11:33:06 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Vineet Gupta <vineetg@rivosinc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [Stable-8.2.1 61/71] linux-user/riscv: Adjust vdso signal frame
 cfa offsets
In-Reply-To: <20240128175035.812352-7-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Sun, 28 Jan 2024 20:50:24 +0300")
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
 <20240128175035.812352-7-mjt@tls.msk.ru>
X-Yow: Hmmm...  a PINHEAD, during an EARTHQUAKE, encounters an ALL-MIDGET
 FIDDLE ORCHESTRA...  ha..  ha..
Date: Sun, 03 Mar 2024 11:33:06 +0100
Message-ID: <87ttlnehb1.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.9; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Jan 28 2024, Michael Tokarev wrote:

> From: Richard Henderson <richard.henderson@linaro.org>
>
> A typo in sizeof_reg put the registers at the wrong offset.
>
> Simplify the expressions to use positive addresses from the
> start of uc_mcontext instead of negative addresses from the
> end of uc_mcontext.

This breaks the testsuite of libunwind.  The test Gtest-resume-sig and
all dependent tests hang.  Reverting this commit fixes them.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

