Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504BEC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuFD-0005QJ-V3; Wed, 01 Jul 2026 08:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1weuFB-0005PR-Fx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:40:45 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1weuF9-0004L2-MW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782909637; x=1783514437; i=deller@gmx.de;
 bh=X2PZE3mxIZ9EOORQ3KgGj3Hk59U1uiT9uEU5FLuNzps=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nVDdA4dQTcVBR4tzSgGqdcuoKtuQYH+OIvfbcAvcwUFXe7yJcX9vrj/sOruyV0Ri
 5W0dOCwzsrDqqxTXEGQzUY+OGdNG5Gpq6MSNfQWyYkQS7CP0dUyCC6ddk87xYr4BK
 YflNUi3t3rZoqOcDGmjUpZFR2WBrApkVCi6R3XJ18f7+2DvE71w2hGmfUyxg2dKO5
 w4zetO+yKq+f0Q8PjC+CXAfLFtB4wyD8qixvgxspusyHvJ3HfIKwTcsJEyG3yeYpJ
 WGkr9U7SuXyX+DIjIdYDGK4qsSSnMzUj4zvoyk/rLCs8Pk6SZjEk/j0TdP8JK7Bg3
 gamn0WDIcakWvEkQmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1wfSCt07ak-000Y1z; Wed, 01
 Jul 2026 14:40:37 +0200
Message-ID: <c8135914-92ad-4c8e-81a1-d6fca4af06eb@gmx.de>
Date: Wed, 1 Jul 2026 14:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/scsi/ncr53c710: rewrite to support HP-UX, Linux
 and NetBSD
To: Keith Monahan <keith@techtravels.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260701031803.1817812-1-keith@techtravels.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260701031803.1817812-1-keith@techtravels.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmIf5fcVhHKpzy6ZWQLlAJ7qUQmIkK7gLDIJ6DR9A7QgrRvWnRq
 60FIhFUHA+8J/PsM5xu5YHs5OhgPxQ8u33PQ8QjDcPO/G+wNz3rlvhOodV3wd1C5p/0t20Q
 rlJZaODoUIfjPLCJuyo2tkU3/bnUzNBhNro/i4W+IMiRqelniqT9HQ5ewNw+WY+X7GdSiQV
 b1N2KZSv0aiPEbU5+DZ3Q==
UI-OutboundReport: notjunk:1;M01:P0:1/1Pce4y+oA=;jQfKjpLBh83hwl4U+6xDvbe19/3
 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
 vODA4qiC8hEzG8Q/+8=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/1/26 05:18, Keith Monahan wrote:
> This series replaces the NCR 53C710 model so HP-UX 10.20 (including the
> Ignite/16700A install media) installs and boots on the HP 715 (-M 715),
> while keeping the in tree Linux lasi700 and NetBSD osiop drivers working=
.
>=20
> I first tried to fix the existing model.  It took about a dozen fixes
> just to get the kernel's own 53c710 driver to negotiate its first
> command, and even then HP-UX would not boot reliably.  Two of the faults
> are in the core interpreter itself.  The model is connected only: no
> target initiated disconnect/reselect, which HP-UX needs (and so does any
> tagged, overlapped I/O).  And it runs SCRIPTS synchronously inside the
> guest register write, so completion interrupts come back reentrantly
> instead of the way the real chip delivers them.  Fixing either one meant
> rewriting the interpreter, so I rewrote it.
>=20
> The new model is derived from lsi53c895a.c, the maintained sibling in th=
e
> same NCR/LSI SCRIPTS family.  Its disconnect/reselect, asynchronous
> completion and DMA paths already work across many guests.  I adapted it
> to the 710: big endian SCRIPTS and table indirect fetch, 24 bit DMA byte
> counts, the 710 register map, and the single byte interrupt model.  The
> two LSI models share structure now, so a fix to one can carry to the
> other.
>=20
> Patch 1 is an independent LASI interrupt controller fix (a latched
> request register that floods the installed HP-UX boot with "unexpected
> core I/O interrupt").  Patch 2 is the rewrite, which depends on it.
>=20
> Tested: HP-UX 10.20 install + reboot (Ignite 16700A and an overlapping
> tagged software install); Debian install + boot (Linux 53c700);
> NetBSD/hppa 9.4 and 10.1 boot + device enumeration (osiop).
>=20
> Keith Monahan (2):
>    hw/misc/lasi: derive IRR from pending and unmasked sources
>    hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
>=20
>   hw/misc/lasi.c        |   27 +-
>   hw/scsi/lasi_ncr710.c |  120 +-
>   hw/scsi/lasi_ncr710.h |   28 +-
>   hw/scsi/ncr53c710.c   | 3062 +++++++++++++++++------------------------
>   hw/scsi/ncr53c710.h   |  295 ++--
>   hw/scsi/trace-events  |   31 +-
>   6 files changed, 1500 insertions(+), 2063 deletions(-)
Thanks for this series!!!
I've tested this driver with HP-UX 10.20 (which didn't worked with the pre=
vious
ncr710 driver yet), and it's a big step forward.
Thanks for doing this.

Tested-by: Helge Deller <deller@gmx.de>


