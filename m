Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E9EB26EA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprXQ-0001Jq-Rz; Tue, 10 Feb 2026 12:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vprXL-0001JD-QI
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:28:31 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vprXJ-0004XE-Vh
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770744508; x=1771349308; i=deller@gmx.de;
 bh=CfG+zhL86iwT6WUOHnk1ApJgyZCPTeycqfbFF9+8J9s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b6O9Qx9kxrvK4TJSVBTTy0J1HPgG6QA+Tz+YmYKWrspDeuWrdGLna5sjFzVq+W1g
 3fgKvouUz31pdDVopJpuQ1h95t3tyQCQRtPInrpUNR4wgXcptBagSgDbzlPPbYCpf
 /njzGnziuPNAkAdYMRyFZ1UON8rrYJlPjJV4EsjM8GGwm66O3dgJ0EiAXPtQ5jWob
 E1pjT7+iIBI33N13MWXAkt+ht+P2cfUTQmn637IMavsV4TRf3ow77F5fTqgMAjcay
 yU9+XpeuoD25nvig9oNWMyiVBytQrq3q908kOLl4lGoD1G9WvHxpxxcob5ZRzgaJs
 Ayemcl6ZbgHNYuCdZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1vxnkV1Ezj-002utV; Tue, 10
 Feb 2026 18:28:28 +0100
Message-ID: <5ba38c75-e1c6-41cc-9a5d-b81c22527993@gmx.de>
Date: Tue, 10 Feb 2026 18:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N6POtVGEItH70hd++ST74AreUQ0sbTcL3802EKYS1ev5fH7pZHE
 UD+RSqoSLdtQ+sVV4ac8Bg2pQoRWagqz5fvAmVIn11TixoIi78SE+/HJ/mJ/vkw77IYDDV/
 7ypouzsjAavGF6qFE0rxWwzxF/Ee90/xbYKiE82V1giAUQkiUZ2Bt09pjIkLuRtPmfvE8s6
 lXzHi6+qrV3HqkaZb6rYQ==
UI-OutboundReport: notjunk:1;M01:P0:9H0ORAGJyLE=;2uLjMkZ23yKx7CNH8RI7RrGGLcB
 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
 wDC53JLRKJ47fbhj2PFye9/L7BEdm
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/10/26 17:37, Anton Johansson via qemu development wrote:
> This patchset tries to address a discrepancy between the C3700 machine
> in QEMU/SeaBIOS and the documentation (chapter 5)
>=20
>    http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf
>=20
> where 40 bits of physical address space are used in SeaBISO compared

SeaBIOS (typo)

> to the 44 bits specified in the documentation.
>=20
> A PA-8600 CPU with 40 bits of physical address space is added along with
> a C3600 machine using it by default.  AFAICT there are no major
> differences from QEMUs side between the PA-8600 and 8700 aside from the
> physical address space size.  The PA-8700 machine can then be
> moved to using 44 bits.  To account for the discrepancy with SeaBIOS, th=
e
> functional tests now run a C3700 but with a PA-8600 CPU.
>=20
> CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
> use a HPPACPUDef sturct to provide model specifics, similar to the SPARC
> and RISCV targets.  This hopefully makes it easier to add other models,
> such as the 8800/8900.
>=20
> Based on:
>    PATCH v4 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
>    (20260210-phys_addr-v4-0-725a589e83c8@rev.ng)
>=20
> Signed-off-by: Anton Johansson <anjo@rev.ng>

I like your patchset.
I'm just wondering if we should merge it with my upcoming new SeaBIOS,
which adds support for an A400 machine (with a PA8500 CPU).
So, instead of adding a C3600 machine, we could add the A400 which
has 40-bit physical addresss space too.
See:
https://github.com/hdeller/seabios-hppa/branches -> devel-v22 branch
and
https://github.com/hdeller/qemu-hppa/commit/1c969c925fb76236e76b09e011f077=
66ab4441cb

In addition, I wonder what's necessary to change in SeaBIOS to fully
support the 40 and/or 44-bit case. It's easy to hand over the bits to
SeaBIOS, so SeaBIOS could do the right thing.

Helge

