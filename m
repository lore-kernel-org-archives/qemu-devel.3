Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC4CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEIlI-00075m-Rc; Tue, 06 Oct 2026 23:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEFlE-0005b0-5o
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:44:25 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1xEFkw-0006Is-Dt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:43:43 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id E6F701D000C7
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 10:03:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 06 Oct 2026 10:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791295385; x=1791381785; bh=kj0vF7HyHKlYzHFRSXtVHdMTIab/Eu9S
 EGt78tLN8NI=; b=ZpXS8M3abxh81NKkZHsGziureG7lJEotXGDFw2PO/B4eOKq6
 89U0MtqJq/CtT4bH+KHvFndaPOafRWZ94snfWeTHNbbtvrpUEWgYx5Y+ZDvyFflG
 X3YbaZl8do7STRPIX7tTlw4/RcqNX8FQqF0tIXfHJU1Ay5I9rjl6XF7YtAt3rsSX
 bcqLWenBofNryG1sVnv5F422P6VaGEOkZ3brWlDkwA7hu1K9TMSDS5UmoSCsThJT
 YY2m1mBTmnsslMNT7m06PQj5Gs1yUhenhjp4JE41L8It/1p/xHOOPAc5Op/TY1DO
 nlSP6exyHVBJPioxs/U7dj+d5FGLbsnSAQuaNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791295385; x=
 1791381785; bh=kj0vF7HyHKlYzHFRSXtVHdMTIab/Eu9SEGt78tLN8NI=; b=u
 DA4zE662aen1dvyGGFTg8P+DmoUvve+PeI0/0StZdHBa1RCmMvLMjyNPGUjQ/pur
 XjslftNDlzuju2Xvq3sOK4Ev9lIMr9Xr39Y9jNrhAKAzIHXwbtDMhsc2FrnQO0jy
 KUHEktgOy7TWkNpXfGQKGk/KxZF4DPOijD1Eou7KBCycTjtSKZ2+H77EkteLlGmg
 4mFQQ2HH+4c8z70AysZ0wpoD9YBuBNQ38E9ln8M5KHJb2+nzAjgOALYtxVAYBNJc
 Tz8KsLL4KFlXV79jK3m6zbsmxs0+tSRHATW+qiqcRl4+B9HNrGK6Ww3u8Qccj1nG
 7nPN4KLSWhpFIt7pprWDQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791295385; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:cRQp95Y9Dr1noM93WIbpaEbkWD+lC9ovgOELLgNfaQKomY4
 U1wt58YAEn90Mk2E5jjU7ao731N542dTmKYvHaOZcp7k79cC9wj/wODq4ReZBwur
 Xfr6tNGo5BwfAQBwidhHvxGpjKqhFvhqjtWeV3hPKNlpyLtNhgk4JbIDgRGBetRW
 CT3k9Zzt52XqJ/SA7wu/G9FGMF8I+RJ15/Drnbpsa7HDv7PsQYY2ibejQLFjsiM2
 MBLr4QM+EuYhgSOHm6TfKI1skfCCmkpNf3It7CEseRbtMpX2SSRREoMJXUwr/kAi
 TtSL5U83hw9oICn4Hoslonglfy250qUnjPZ5gfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:nWIIkdVZH2aygXXuyS4lCxmnb7D+RrpDMBMSRiubOEE=:kj0vF7HyHKlYzHFRSXtVHdMTIab/Eu9SEGt78tLN8NI=;
X-ME-Sender: <xms:mP_EaubaEfSd4f3bshzRkdkbjPZWRf0YudjBy8laq3wHP91-B34Ozw>
 <xme:mP_EamWN2UM6DMfvYGwjyzBWe33v9W5c4yVZlvTBPgp3N-FXJJaowfEm1KbziufdR
 S2q7tfjluRS9aIfOtquUCiJrEue6pEHRK46F8LpP5vqA3GcBsmqBMI>
X-ME-Received: <xmr:mP_EatMhRsl7TmFlYrV1hxrwFNzHbi_BbT-SH3w9Ewgvh_Pll8cAM0xVFy9KywoO9bO20bstYDkL>
X-ME-Proxy-Cause: dmFkZTESC8THgcayfet7+y0YbhShFLOGJ/4WN2yz//JBzlHJBKwUQADEGI30eiBWcGCIrc
 7yVVEKeGC65cFm/3Ck61C3IvTupf/2YmCW+ubuByjShWwSGUCuWQBkwOyr8hy2n6l1uSAX
 Z5UAZTaX+YHz14qO4AtR6HLITOsQnA2+fjMq/BC9qiRfHsIfUdZM5fLUZVmIk/FLRjJCQi
 tROXaVnaksfQx7w2s7FIL3Y6LY9UFqvsYFmngK9R3L8y+8wNWR5puYs8wONWDF3xxcAMer
 UPJv4GWP0milBPWBD6VhgD4M5m3bRZLZqSS0lBZrspozxtvYzKSZlbLz53qoMtZGCM7vZa
 oPgBbAWENkkM7mys+RfZIwhdozhkPkwT1wD+/xdrOpUE9Av7op7yP+Z7JXgDOumSm7RiUf
 OU9jFbiubdZZKDnaJ3ZMGfol1NiQKfH9BlARr1kdoGX15JejapDeDKxnjajEN/JJ1cgafZ
 WfRekIBJrIVHo4kOKF6CYA2jTIAzx9J3RttNjvJ2x/g9rKZzpwgVVTORA5lxJXqR65szgt
 ufciDwEEDyoiedPWmjo2yxRtpx61Ep86IdujJurDei4CyAmPNr/yYfdJ3j18xMPnQvGAH/
 IjGBI6+leMNl4aB+vwxnBqZPujl/fEb/keItVyv33kHV4lCoDNifwF5kg2+g
X-ME-Proxy: <xmx:mP_EagavZe9EW7U6E1fALKLLaz6fgtAiXnzveepqDNfSqUKXLDOQ8Q>
 <xmx:mf_Eas_lGaDh8lsHC9XXCOQ9XHdttMHsbPrIALw6dXXiXXCmOr6emg>
 <xmx:mf_EahS6HkR2qhMWKap92YJgENfmC_ijyg5GBgnQbN4G6rRswKDPtw>
 <xmx:mf_EamdrWfIdGey5ujZsJvnJ1y_KPHXwMooTLTJX1u8LQreZDCPZ_w>
 <xmx:mf_Eak9Y694K69FdVyyIXXy4a4I5YeEG7AKpoWD7wGxd85l6aYk_g6TW>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 10:02:57 -0400 (EDT)
Message-ID: <9e0e12d117ddb5a629437fb48c73ec238faa17a7.camel@alistair23.me>
Subject: Re: [PATCH] target/riscv: Check Svnapot PTE before updating A/D bits
From: Alistair <alistair@alistair23.me>
To: dodochicha <kevincheng60303@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: Wed, 07 Oct 2026 00:02:53 +1000
In-Reply-To: <20261005115916.21196-1-kevincheng60303@gmail.com>
References: <20261005115916.21196-1-kevincheng60303@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=alistair@alistair23.me; helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, 2026-10-05 at 19:59 +0800, dodochicha wrote:
> Reserved Svnapot PTE encodings must raise a page fault without
> modifying the PTE. Currently the A/D bits may be updated before the
> Svnapot encoding is validated.
>=20
> Move the Svnapot validation before the A/D update so reserved PTEs
> fault without changing the PTE.
>=20

In future please wrap your commit messages at around 70 characters.

Thanks!

Applied to riscv-to-apply.next

Alistair


> Signed-off-by: dodochicha <kevincheng60303@gmail.com>
> ---
> =C2=A0target/riscv/tcg/cpu_helper.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/riscv/tcg/cpu_helper.c
> b/target/riscv/tcg/cpu_helper.c
> index 07d9222652..105f2f1927 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -1403,6 +1403,13 @@ static int get_physical_address(CPURISCVState
> *env, hwaddr *physical,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sstack_page ? TRA=
NSLATE_PMP_FAIL : TRANSLATE_FAIL;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N))=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 napot_bits =3D ctzl(ppn) + 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((i !=3D (levels - 1)) || =
(napot_bits !=3D 4)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n TRANSLATE_FAIL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 target_ulong updated_pte =3D pte;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /*
> @@ -1473,13 +1480,6 @@ static int get_physical_address(CPURISCVState
> *env, hwaddr *physical,
> =C2=A0=C2=A0=C2=A0=C2=A0 /* For superpage mappings, make a fake leaf PTE =
for the TLB's
> benefit. */
> =C2=A0=C2=A0=C2=A0=C2=A0 target_ulong vpn =3D addr >> PGSHIFT;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N))=
 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 napot_bits =3D ctzl(ppn) + 1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((i !=3D (levels - 1)) || =
(napot_bits !=3D 4)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n TRANSLATE_FAIL;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 napot_mask =3D (1 << napot_bits) - 1;
> =C2=A0=C2=A0=C2=A0=C2=A0 *physical =3D (((ppn & ~napot_mask) | (vpn & nap=
ot_mask) |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (vpn & (((target_ulong)1 << ptshift) -=
 1))

