Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6639D106703B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gzD-0007ly-Co; Thu, 12 Mar 2026 10:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1w0gyy-0007ky-J1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:25:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1w0gyp-0001Tu-8K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:25:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b78b638eso1220404f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773325537; x=1773930337; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R4yuRhJ7LclXTvBvZ37Tj0qI4Xn86icg3KV4lvWwXQg=;
 b=f9jPVxWB35cfkgwyIxmVi/Ughvbnr29IFX9yMbRVaYShMpkmyzptO4ssb6ABIGc8YE
 7JQ+VL4+DM6kEFWtizisAmLf4AC1CmIyBQcQS8anPw+aaVyxAbGL+W21tLxtjUtoNJAH
 XK2wy49L9R/+f443PEgZ1ALbD53wBYHctVefMctOkpXHtzut4hOIL085TLToBR7nLUXj
 AYmMaS9iwdabS8d6LHOrVrMOWjj2n5xvIAMowKR0Nrgo44Ava/pUmVln3mYYgIojb7U1
 dC1xLYmF8t4aBFNaDyymKviqQVgyAnPKeXleO8uZ3+hkzgHU70WxofyBPi6j5hxDeohK
 KfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773325537; x=1773930337;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4yuRhJ7LclXTvBvZ37Tj0qI4Xn86icg3KV4lvWwXQg=;
 b=FTzIFEGPB/f9C/OL/sm+mhAaDzbcm590REnRxW2KRPXLiHnzEJ3zhiO+a42BzQFNyR
 oUeU1IKdCz1ViCQqqjvLWbWvRy8HfhAzziI1VZJUjlB1u9jyKSMpMFmIhsDF/umlNCCh
 Lx2yKfbLsEUCMfKoTg+yZGUrQjBPoOG08fayPNYZJHUSExib4RuuLBX9pOZXcsdIRZBd
 aJihj4Fa5YgtZkFBQ03g/hgo4CQOj+Vre7KqoVpikfiSWEAVaFL/OkS12usqZeltQbLN
 ubcmJbT1lVKVTt6OId6TF0rrgfkZAYojQoMyqBfqAgav1KhDUzdmMCsB5Ika/PG6VnbY
 hO8w==
X-Gm-Message-State: AOJu0YwoolAUTFtclZra48AqLDMtHBVhHJ6KlK8KhyEhuFYVl9dCCdkc
 wCqFugB8WtlmcRWvHBnvKAs+yZjnzZqsv9s4q3xTScY832H/0xeQFRegUYmdNW6f
X-Gm-Gg: ATEYQzymb7UwGWicERGfRHO9Amh/8Pj6l84g8GQm0tL6YJQSZvlIAVI0+t0+52bHD96
 JNCGzOIAiIGhI8QfdrbgNa+1Yw+lmpoLhpnNx6tNZ4GCjjha4A9c+mDgbESv6BluLeAVeW9zXzs
 2dmEuoeAvI4M0lYY3FTlCAHvpiotoZbu+axAqyH4piPmKQLrd7+v/rmxT7BdnjlOc5ZzuAi/ryh
 /hG2F6Q1vliS8QV678F+b031UuhqK1GUscoLYt0OGAlleM+BAJbAFJdMmhctIGs7fd3oBJ7spqU
 SJL/48Jkp4ynkRhvvvtnVmnnccO757J1PFGbfHXZ6tGzaLIrcM+pNqR3p9i5XiSMrnj4/AKNK9Y
 EzM4Hf/6eBYqCIAEepqNj091UwLKtRe/UyCRX0amwXLeKdf/iekaGtWCgzCOx/CSvy9VuxaESSH
 cPlYHi7d2s1nMJsNtPKUqXya/1Y0SfxiqsVI+9yDQufoXu6lP48+l5JUGb6r/x0sLmcyyWkleE1
 dg5XmTpdEcKa79qz1PKTLmDuCGCQU7p9WGRmQ==
X-Received: by 2002:a05:6000:2385:b0:439:9282:e728 with SMTP id
 ffacd0b85a97d-439f81e2969mr12630089f8f.2.1773325537042; 
 Thu, 12 Mar 2026 07:25:37 -0700 (PDT)
Received: from ?IPv6:2a0d:6fc2:4ba1:a000:8b9d:e01e:98af:3679?
 ([2a0d:6fc2:4ba1:a000:8b9d:e01e:98af:3679])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm8435796f8f.4.2026.03.12.07.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 07:25:35 -0700 (PDT)
Message-ID: <3c5642537503a66459e71f95b02d81760d2d804a.camel@gmail.com>
Subject: Re: [PATCH v4] Handle wrap around in limit calculation
From: shlomopongratz@gmail.com
To: qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, philmd@linaro.org
Date: Thu, 12 Mar 2026 16:25:34 +0200
In-Reply-To: <20240123095821.59625-1-shlomop@pliops.com>
References: <20240123095821.59625-1-shlomop@pliops.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-01-23 at 11:58 +0200, Shlomo Pongratz wrote:
> =C2=A0=C2=A0=C2=A0 Hanlde wrap around when calculating the viewport size
> =C2=A0=C2=A0=C2=A0 caused by the fact that perior to version 460A the lim=
it variable
> =C2=A0=C2=A0=C2=A0 was 32bit quantity and not 64 bits quantity.
> =C2=A0=C2=A0=C2=A0 In the i.MX 6Dual/6Quad Applications Processor Referen=
ce Manual
> =C2=A0=C2=A0=C2=A0 document on which the original code was based upon in =
the
> =C2=A0=C2=A0=C2=A0 description of the iATU Region Upper Base Address Regi=
ster it is
> =C2=A0=C2=A0=C2=A0 written:
> =C2=A0=C2=A0=C2=A0 Forms bits [63:32] of the start (and end) address of t=
he address
> region to be
> =C2=A0=C2=A0=C2=A0 translated.
> =C2=A0=C2=A0=C2=A0 That is in this register is the upper of both base and=
 the limit.
> =C2=A0=C2=A0=C2=A0 In the current implementation this value was ignored f=
or the
> limit
> =C2=A0=C2=A0=C2=A0 which caused a wrap around of the size calculaiton.
> =C2=A0=C2=A0=C2=A0 Using the documnet example:
> =C2=A0=C2=A0=C2=A0 Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd0=
00ffff
> =C2=A0=C2=A0=C2=A0 The correct size is 0x80000000d000ffff - 0x80000000d00=
00000 + 1 =3D
> 0x010000
> =C2=A0=C2=A0=C2=A0 The wrong result is 0xd000ffff - 0x80000000d0000000 + =
1 =3D
> 0x8000000000010000
>=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>=20
> =C2=A0=C2=A0=C2=A0 ----
>=20
> =C2=A0=C2=A0=C2=A0 Changes since v3:
> =C2=A0=C2=A0=C2=A0=C2=A0 * Use Peter Maydell's suggestion for fixing the =
bug,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that is compute a 64 bits limit from=
 the upper 32 bits of the
> base
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and the given 32 bits limit.
>=20
> =C2=A0=C2=A0=C2=A0 Changes since v2:
> =C2=A0=C2=A0=C2=A0=C2=A0 * Don't try to fix the calculation.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Change the limit variable from 32bit to 64 bit
> =C2=A0=C2=A0=C2=A0=C2=A0 * Set the limit bits [63:32] same as the base ac=
cording to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the specification on which the origi=
nal code was base upon.
>=20
> =C2=A0=C2=A0=C2=A0 Changes since v1:
> =C2=A0=C2=A0=C2=A0=C2=A0 * Seperate subject and description
> ---
> =C2=A0hw/pci-host/designware.c | 14 +++++++++++++-
> =C2=A01 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index dd9e389c07..f81dbe3975 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -269,8 +269,20 @@ static void
> designware_pcie_update_viewport(DesignwarePCIERoot *root,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 const uint64_t target =3D viewport->target;
> =C2=A0=C2=A0=C2=A0=C2=A0 const uint64_t base=C2=A0=C2=A0 =3D viewport->ba=
se;
> -=C2=A0=C2=A0=C2=A0 const uint64_t size=C2=A0=C2=A0 =3D (uint64_t)viewpor=
t->limit - base + 1;
> +=C2=A0=C2=A0=C2=A0 uint64_t size;
> =C2=A0=C2=A0=C2=A0=C2=A0 const bool enabled=C2=A0=C2=A0=C2=A0 =3D viewpor=
t->cr[1] &
> DESIGNWARE_PCIE_ATU_ENABLE;
> +=C2=A0=C2=A0=C2=A0 uint64_t limit;
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Versions 460A and above of this PCI controlle=
r have a
> +=C2=A0=C2=A0=C2=A0=C2=A0 * 64-bit limit register. We currently model the=
 older type
> +=C2=A0=C2=A0=C2=A0=C2=A0 * where the limit register is 32 bits, and the =
upper 32 bits
> +=C2=A0=C2=A0=C2=A0=C2=A0 * of the end address are the same as the upper =
32 bits of
> +=C2=A0=C2=A0=C2=A0=C2=A0 * the start address.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +
> +=C2=A0=C2=A0=C2=A0 limit =3D deposit64(viewport->limit, 32, 32, extract6=
4(base, 32,
> 32));
> +=C2=A0=C2=A0=C2=A0 size =3D limit - base + 1;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *current, *other;
> =C2=A0

Hi all, just a gentle ping on this patc from 2024. It is in Patchwork
ever since but haven't been merged yet. Is there anything I need to do
to get these into a future pull request?"

