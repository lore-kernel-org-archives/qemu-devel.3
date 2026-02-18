Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC12E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsndO-0004HT-1z; Wed, 18 Feb 2026 14:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vsndA-0004E3-Bu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:54:41 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vsnd8-0004uh-DV
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771444469; x=1772049269; i=deller@gmx.de;
 bh=WexSOEzLNL3MKMlxp/HesyRGjg7vNt+RPjosTLFvB8E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hcv5w0psx87MmS5JDnsUP3mVikpn76xEKtAFU5zrITxnuWNKb1K/D23VT+Nvvml9
 ZqwlhcSexlFCZhaOO5CmOm5zRz3BKKwqSZrHvrR3X+19dgtPiZjNxoJcjpYSf/J8N
 yKmsxY8xqqLBnfgH8ihcvad7/4utfXU4ZqnXW+ZwkbCEKvQT72BMKut5y+/dczxZP
 U+rfNrUNAQVRLqgEZq4Zo/F2PrZE35Kq3glv4m45OZlnvsuROLKU5HgI+1xwF79/J
 8FQvkyJ87TFity2pQxK4y9Cffms219b5X1CiapjCRQ8qkRUb9z3Z72dYK9GP5Nsmm
 I97QIEVZLqwbBLB16Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1wDW3m2j7X-00Wfn7; Wed, 18
 Feb 2026 20:54:29 +0100
Message-ID: <cc002f2d-198d-4b59-b99b-0038d002f1e7@gmx.de>
Date: Wed, 18 Feb 2026 20:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtCRMluC1mZRkyzsfvCq23A2KJdBVYmav1/8E9NUM0H41+fZMNG
 VeLIPkwjJnk3J9QE2qdHsPkiA8Jd62kog6EtT7bRiUlySQcBfEt9t3cEVpwF58EcmajauX5
 P+6g362HMkVGc1TWq3ym5kajcw7GTey8y3xa4NionnmwlUp5Vv/v9Ko4+vYYlRFONj76q6S
 qhtZpReDDbKnmxtAM2A/g==
UI-OutboundReport: notjunk:1;M01:P0:J+QlZaOJTT0=;ZHSa+HO7yBiKO4c20iUQ5YJlYtY
 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
 PymsmwbM=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/18/26 20:48, Anton Johansson via qemu development wrote:
> This patchset tries to address a discrepancy between the C3700 machine
> in QEMU/SeaBIOS and the documentation (chapter 5)
>=20
>    http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf
>=20
> where 40 bits of physical address space are used in SeaBIOS compared
> to the 44 bits specified in the documentation.
>=20
> A PA-8600 CPU with 40 bits of physical address space is added along with
> a C3600 machine using it by default.

As I mentioned earlier, I've now the patches ready for submission
to add a A400 machine. The A400 uses a PA8500 CPU, which has 40bits too.
So, instead of adding the C3600, can we please rebase your patch on my
series instead?  I send my series in the the next few minutes...

Thanks!
Helge

>  AFAICT there are no major
> differences from QEMUs side between the PA-8600 and 8700 aside from the
> physical address space size.  The PA-8700 machine can then be
> moved to using 44 bits.  To account for the discrepancy with SeaBIOS, th=
e
> functional tests now run a C3700 but with a PA-8600 CPU.
>=20
> CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
> use a HPPACPUDef struct to provide model specifics, similar to the SPARC
> and RISCV targets.  This hopefully makes it easier to add other models,
> such as the 8800/8900.
>=20
> Based on:
>    [PATCH v6 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
>    (20260218-phys_addr-v6-0-a603bf363218@rev.ng)
>=20
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
> Changes in v3:
> - Fixed spelling in commit message/comment
> - Rebased
> - Dropped if statement in hppa_cpu_class_base_init() (patch
>    "hppa: Introduce HPPACPUDef").  Not needed as it will simply
>    be set to NULL for the abstract base class anyway.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v2-=
0-9ca09c677012@rev.ng
>=20
> Changes in v2:
> - Missed a reference to the old "hppa" CPU model, updated to
>    "pa-7300lc".
> - Link to v1: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v1-=
0-a17ec58f053f@rev.ng
>=20
> ---
> Anton Johansson (4):
>        hppa: Prepare for additional CPU models
>        hppa: Introduce HPPACPUDef
>        hppa: Get physical address space bits from HPPACPUDef
>        hppa: Add C3600 machine with PA-8600 CPU
>=20
>   target/hppa/cpu-qom.h                 |  8 ++++-
>   target/hppa/cpu.h                     | 35 +++++++++++++++----
>   hw/hppa/machine.c                     | 64 +++++++++++++++++++++++++++=
=2D-------
>   hw/pci-host/astro.c                   |  2 +-
>   linux-user/hppa/elfload.c             |  2 +-
>   target/hppa/cpu.c                     | 50 ++++++++++++++++++++-------
>   target/hppa/mem_helper.c              | 40 +++++++---------------
>   tests/qtest/machine-none-test.c       |  2 +-
>   tests/functional/hppa/test_seabios.py |  3 ++
>   9 files changed, 141 insertions(+), 65 deletions(-)
>=20
>=20


