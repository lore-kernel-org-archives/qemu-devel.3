Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F51CD4F52
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPFod-0007pU-4O; Tue, 19 May 2026 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wPFoc-0007pH-1m
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:28:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wPFoZ-0007CE-TJ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1779179308; x=1779784108; i=laurent@vivier.eu;
 bh=sKqgTwZ6LvpOsos1KxWPnY35FwLC/vn5SNOV4Lh97no=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NYJgcpH2TZ7a/z7Bhgp8+Qh3JdZbYor8ATVCXeT0v3ebA3j6qw4LGcPrdqhSPjPd
 NoPyAyhRjLcfDq/ZA9NvuvrK59Q/5j8n1pyGZHyxAKFoiPJDr/cPSnIlxWXr7/hr2
 cHM0Esh5ihal3zbfRVfUOE5JAiaTC2KhN0fNOo4YL2D0serQq0xNCTz4f18WJIf99
 3fv8rIhnNFraq4Xz5bFsU2FHqnaYGTw/xwRVEndA4/znZnAlkcNXkCEHzMwMsQezO
 LlwDED9lZ32C405qHKj9JFsnsvA1+8RyXLDqt2J0xuesaAgRM4z3s+mGxhjCpx7Zt
 VLjvG4w62x+Zn7PqWg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1MfYHQ-1x0lQS1u36-00akIT; Tue, 19
 May 2026 10:28:28 +0200
Message-ID: <5aaad430-aea3-4174-a9e5-add61a655d1c@vivier.eu>
Date: Tue, 19 May 2026 10:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Fix fmovem.l with multiple fpu control
 registers
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, Andreas Schwab <schwab@linux-m68k.org>
References: <20260517191715.3815186-1-visitorckw@gmail.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260517191715.3815186-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C1NSst6DD9gv49rDlEviEZdijiiRGnbSzMTyurm3UaRAVJZYFXC
 gkXvsz5hCEfa1j4ABxtQZGp+BeMNAM4ySADRgKCTNIpjIcdR0iWwQ3CfIA14f5o0rD0yasA
 Ot8lPvGG29Wf9P2Yvm5NBYGBVYwJEy208J8oBBYQ1rsfdCSXaJmOpEbEiedRiv7hQWfZnQJ
 mXlWNs5PtJZweL/uCnzNA==
UI-OutboundReport: notjunk:1;M01:P0:XdQ+DhXGCn4=;PeoZghftkEMkGKpXXPVbZe4e6pv
 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
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Le 17/05/2026 =C3=A0 21:17, Kuan-Wei Chiu a =C3=A9crit=C2=A0:
> Executing fmovem.l fpstate, %fpcr/%fpsr results in incorrect values
> being loaded into the fpu control registers.
>=20
> When fpu control registers are moved to/from memory, they must follow a
> strict order regardless of the addressing mode: FPCR is always at the
> lowest address, FPSR at the next, and FPIAR at the highest address.
>=20
> The current implementation in gen_op_fmove_fcr() processes the bitmask
> incorrectly and uses the wrong loop direction for pre-decrement mode,
> mapping the registers to the wrong memory addresses.
>=20
> Fix this by correcting the loop iteration order and mask checking to
> follow the architectural memory layout.
>=20
> Fixes: ba62494483ab ("target-m68k: add FPCR and FPSR")
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Closes: https://lore.kernel.org/qemu-devel/87cxyv4390.fsf@igel.home
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>   target/m68k/translate.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 138c89d3e5..8d8531b1ad 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -4837,24 +4837,26 @@ static void gen_op_fmove_fcr(CPUM68KState *env, =
DisasContext *s,
>        */
>  =20
>       if (is_write && mode =3D=3D 4) {
> -        for (i =3D 2; i >=3D 0; i--, mask >>=3D 1) {
> -            if (mask & 1) {
> +        for (i =3D 0; i < 3; i++) {
> +            if (mask & (1 << i)) {
>                   gen_qemu_store_fcr(s, addr, 1 << i);
> -                if (mask !=3D 1) {
> +                mask &=3D ~(1 << i);
> +                if (mask !=3D 0) {
>                       tcg_gen_subi_i32(addr, addr, opsize_bytes(OS_LONG)=
);
>                   }
>               }
>          }
>          tcg_gen_mov_i32(AREG(insn, 0), addr);
>       } else {
> -        for (i =3D 0; i < 3; i++, mask >>=3D 1) {
> -            if (mask & 1) {
> +        for (i =3D 2; i >=3D 0; i--) {
> +            if (mask & (1 << i)) {
>                   if (is_write) {
>                       gen_qemu_store_fcr(s, addr, 1 << i);
>                   } else {
>                       gen_qemu_load_fcr(s, addr, 1 << i);
>                   }
> -                if (mask !=3D 1 || mode =3D=3D 3) {
> +                mask &=3D ~(1 << i);
> +                if (mask !=3D 0 || mode =3D=3D 3) {
>                       tcg_gen_addi_i32(addr, addr, opsize_bytes(OS_LONG)=
);
>                   }
>               }


