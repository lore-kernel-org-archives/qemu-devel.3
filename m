Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D798C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teG1k-0001M3-Rg; Sat, 01 Feb 2025 11:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cloos@jhcloos.com>) id 1teFph-0007e3-MW
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 10:54:57 -0500
Received: from ore.jhcloos.com ([192.40.56.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cloos@jhcloos.com>) id 1teFpf-00039O-V0
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 10:54:57 -0500
Received: from lugabout.jhcloos.org (lugabout [172.23.50.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (Client did not present a certificate)
 by ore.jhcloos.com (Postfix) with ESMTPS id 429DC1DF64;
 Sat, 01 Feb 2025 15:20:35 +0000 (UTC)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
 id 637CA301DB7DC; Sat, 01 Feb 2025 15:20:34 +0000 ()
From: James Cloos <cloos@jhcloos.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,
 peter.maydell@linaro.org,  stefanha@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  philmd@linaro.org,  mark.cave-ayland@ilande.co.uk,
 Liviu Ionescu <ilg@livius.net>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
In-Reply-To: <87plk72tvr.fsf@draig.linaro.org> ("Alex =?iso-8859-1?Q?Benn?=
 =?iso-8859-1?Q?=E9e=22's?= message of
 "Tue, 28 Jan 2025 09:02:48 +0000")
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEX///8ZGXBQKKnCrDQ3
 AAAAJElEQVQImWNgQAAXzwQg4SKASgAlXIEEiwsSIYBEcLaAtMEAADJnB+kKcKioAAAAAElFTkSu
 QmCC
Copyright: Copyright 2015 James Cloos
Date: Sat, 01 Feb 2025 10:20:34 -0500
Message-ID: <m35xltitdp.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=192.40.56.151; envelope-from=cloos@jhcloos.com;
 helo=ore.jhcloos.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 01 Feb 2025 11:07:19 -0500
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

AB>   - even the Pi Zero 2W can work with a 64 bit OS.

not complaining about the idea, but the above is not entirely true.

i had to drop back to the 32 bit version to get the 802.11 to work.

they released a new version after i reported the bug, but that also
failed to work....

-JimC
-- 
James Cloos <cloos@jhcloos.com>
            OpenPGP: https://jhcloos.com/0x997A9F17ED7DAEA6.asc

