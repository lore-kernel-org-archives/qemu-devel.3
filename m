Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEHwS-0007oX-7T; Tue, 06 Oct 2026 23:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEFcN-0004A1-Bb
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:35:57 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEFc9-0004qn-72
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:34:37 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 29A531D0010C
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 09:50:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 09:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791294646; x=1791381046; bh=Uj0wNxqrnR2qbFh6X7GTZOclshGEa0jt
 PZ0u931P9sg=; b=MRn8mgupUSaSQvVCPxlKnCln2AohmypHoqFcJycioewRcoid
 QyP8G8YhmKkOHhB1mMk+viKnDGQP4IaMvZ/cDUC1okj1BmzRG9JpPDPdz+5Ux0FD
 F7cvEa3GJK1HkXC17Bdq2pz/j6SC5M19hfzX52gbPlDNG+ufHYNeI98ZGZtpYhZF
 9AImFhQkTLv9Naq1/BI8kP+WrwI3WOMnefriVoz9R6su0vjHi5UoVMlPnTYR8QbJ
 CJBeoR7uIfp7hbmb3z20NnUnZWMPKDemoOZSOoE6pq8npYUWM/+Z5kcr9Y3a0N5Z
 8qIViI2fjiwDxgi0GMxHT+cshFSPLSbCwXfXRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791294646; x=
 1791381046; bh=Uj0wNxqrnR2qbFh6X7GTZOclshGEa0jtPZ0u931P9sg=; b=x
 /ykshM4yIj5ZW6zqMbap+GkqxqXf/S1hvr6RHPTqkIYKOir3Qm7Itj+d42JmKIgY
 TSqBOwFIioSvQAWfJIp8+lm/ThrBpv5VI6hb6AqDqZm9kY+grE05Ygw+Op3rauB1
 gmx8RRxcECCe6oul4Y6vdvSIffobyfGWLm/j/ITUoZTkrSMJZNAaQXCX4kNctrOf
 Aevb4Jr1ywFY8l8Zo8V7l2k4WMMFSknkHVWXEsAyEMkM6LLJd7cCuZJeLOFiv7pv
 07Dnv+xLf7asC+5G+R3+oO0b+HlbOaRhS12YtczlRvavcHgsIjA47OYnhD9gk45P
 9HIVUxF/r6P20IowbM2zQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791294646; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:LeFkytNguNAduVIbQT+7dAnDKPTs6R0DHd3+u4vDPZ72h7V
 AWC7FcjcnuXLTS7EhmIvqjAr5RWLxv+PNthMBe1CZQkI6B6q0ELE6X6ZV3CdN+SK
 7Q1DUv99ILvn18V39MXsG+yjPXcRhqoTQSh8+veiq0/5cUDOGOvF4X/Lal8jCPIe
 WBHSGUVCiRgcpxYdCjv3nBM12GS3WoMjWMG5OogxFRY9d9Q+BMSgJzzwzfHd41NR
 xtxATZeW3BQEUoEQQnomoe+XRD1uqRjFacHqSxIglGSyE6NLmNoylQtMCbLXy9Bz
 ABTKl9tgwvRWClqNhgFx+h9xDXo61rXyuKE4OlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:MvPiQJfik46Q8I2mSVYvWHLlXPEsNd9U5ZCsRDGbgTk=:Uj0wNxqrnR2qbFh6X7GTZOclshGEa0jtPZ0u931P9sg=;
X-ME-Sender: <xms:tvzEakzizIM1Kw7dHg85hYADWX0FeW4_LvgdO2wKPDGpwIM2CDb5gw>
 <xme:tvzEatNXKcXC0Lw7BCb49CnZ2Pc1squG0YGhNy3E2RkTssgO-_uxK9_3UqMallEm6
 paEeSbcOpQ72xVn5C7Xou-huSir3M9OMB1JzP9rkTkuSBKmZN7Eot_8>
X-ME-Received: <xmr:tvzEaqkmholI0-GigiamDHsIReMMNCtva1pFq7qrU0nZxQSzaFMFu6VmB5XqpAx24wIonJxEJkGF>
X-ME-Proxy-Cause: dmFkZTFOHIuVClSPo0iZNPqxqCyEH9GEAZ6xmYJcSoj4v5hQZhej11xpHX3iPXaOncVGZj
 JaduPlB5cB5vzFqtRqJiB9JNVLBa1YFlCH9Z8QVUuBqgl2VmY9H+/VYTeAwD2wNu33k3pY
 KDZ3ix60HCcVmsnO1bO4uElUtt+fDvch9R5UV+0pvAD2W5WralZxO/R9XbgOQWw1q6Bstj
 IDhzJPaIgse/vXAtPlfV/CMbgTbrX6cMep6rfPkJ0VQWXG1u1h3wzwxyzhCAUf6ikJxNG8
 EJ0pi8vTbBI01dzWvIXTDo+d/GrWqaTv/tw5mzZaRt4Ndevlt1jQm8jmKX3glrLE/KOFqZ
 qvGc9c/5BdLe2TZGnmm11T769N+GCGWvGFHeodWjTdRnWqmnqOJBp4i2pQ/uNaAZHPVp0p
 QYEeKV2pGyUn8AMmtZ+zMPO1wkL8tZpH1S/MF7NpM9H840VNN8C5lORfX6snPMHdU6U/eb
 5hQJsm/4nauIsfeaQhyZpeatWni6JfmMX4kPgeqphP+sq8vNSZdsmt/Y82vgWqCfDwELCx
 X2v3DpH+4/6skbYovcGEYhB78bI9e7z5NlfWN7Z1EOKWn2RyfMmw3nlED63O5XwbNp80Ze
 eqU3xtnDevFCbo+TH6Dk6IGhaJDXFnQE1df/KATD/fZ22hnKNTcD1MyOu9Lg
X-ME-Proxy: <xmx:tvzEaiQCSFiAnMkMglarXsWCjvO8qF8wDEiAxgcsqP0vjp2p2Hg-tg>
 <xmx:tvzEapU9zEJyw7X-fgnn-WSQHFO4m6dcX500MNUohuYfaa8LnwzcSw>
 <xmx:tvzEamL9cWMqTbber0pWD0ffxJhLB3g0goyc5ZGv7Vf5iyurr0Rpmg>
 <xmx:tvzEap0nLcfhZxf_9Xn8tx3OOghWERscOz-4sRfNLYn_eET-zswDOA>
 <xmx:tvzEam0ubolTNVLpUQCWLxlCctDiBDIISjUMjmLqocs57PcN7XD6IzVN>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 09:50:38 -0400 (EDT)
Message-ID: <c3afd961430a46e27647959efd6ea1096d36602a.camel@alistair23.me>
Subject: Re: [PATCH] target/riscv: Check Svnapot PTE before updating A/D bits
From: Alistair <alistair@alistair23.me>
To: dodochicha <kevincheng60303@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Date: Tue, 06 Oct 2026 23:50:34 +1000
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
> Signed-off-by: dodochicha <kevincheng60303@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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

