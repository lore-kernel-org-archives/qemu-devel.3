Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA98CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5o-0007Un-Cd; Wed, 07 Oct 2026 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHxB-0007xG-9x
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:04:41 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHx3-0007Af-Oz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:04:21 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3AF907A0142
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 09:54:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791294865; x=1791381265; bh=lm9IrxyAZ6qHOndZx9oTe7WA0TM9BmL0
 qX3CNqgZij0=; b=MrP7V1ACuvMTOFITI8WBquRcUhgKHlvl/WVdEWIdVHDu0Apu
 8GMYzsoOOi8/QQv247XE4GGWPQ8ycuz8SfdUpKwyjNtbGqtKvulbjofQeQrk3lha
 yAS0tuA0j6bUbwPdTXlv1oGxX6/Xarx777kC/ANbEdnfozPQwQNOag1G0qSKzGkI
 S4YTvEUQH+x4KEWLE2H1hnCdqACLSnBihQm4+j8YvqHL37Cee78dhpexHlJyeyKw
 Ymdu3+35v08eA/4Wd7DKU6a6sk0Urd2OCj2oQQZ5xURu3aNOv8to9YsUx2nfwFs1
 HDaLBKdg6/NOSsXCUbPYHxAZZJD9kSKYl91+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791294865; x=
 1791381265; bh=lm9IrxyAZ6qHOndZx9oTe7WA0TM9BmL0qX3CNqgZij0=; b=v
 iNa1h0y4Sf73FVFKmYk16JWNAyXPVxTl3K21uOtoJhsPOAbI+wZyOJAR6iKrI/jE
 dbuZd83MBdAT+V+p9i9F1I74OTw633/qXF2B3b9hK507/nWGyUi/NPohHk+QjRpo
 avIaHMG8dsI2st6/g0/rAWPayKYZWGhPxlVyypoNd9DXGL39FS7ftAhCkErdn4nK
 C+AwguiGKVeUgMv9R/AogE/DWhlw/z5/ZECUdvRjTeig+Zo0eVNI2IH7gD7x/F00
 PNLwXSfUFElYGx2NR2cud8Jh67N/zCmMHJX+jo3uNQG+hr5N3JWvGIlt2LkmyFlk
 AqFskqU7k54gobLmN/ndA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791294865; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:HivZ9QawfjXdPZv1gxIK0jiEy9JnBHy4SyrR3tKOVr4K0Fv
 f4yH7/2sA3D8Z089wwrZOSe46wT8MTO2ws1fbJoMEUD/TS92bYXRCRPx85MqawPu
 Em0D58AjW5GbsnB7NBtm1EcoSE5abCM5W6HSD1C8CJ2kyI51sx+bpNj0K5iy2t1S
 K0mMB065nZb7ux3EPH7zy/sqFpksBDrbdjdV06yOwn9gPI64LB4WSXAHAZbmyxZm
 mVst9CnkusvSJU65R6THPfnr3M57L68OXU9qZqLBWwyKYSNMKtTSkxx5+L79YsKK
 OJYNvlkOWbwTBY+b180kZDWJhKo5fnIvpmYEDHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:MASlSQ8HDFYMgOII5EqE7R4/e5I+ZA/HRFvaj3SyP94=:lm9IrxyAZ6qHOndZx9oTe7WA0TM9BmL0qX3CNqgZij0=;
X-ME-Sender: <xms:kf3EasSJLjwm-FKXcTtdm9ylTYfYu6YB1-qtXCiEv6VWIG_xg9aY6g>
 <xme:kf3Ealf57Nto-ZNqzCF-D9M-Ub-pskpMJUVIakuojFshdmPzsL_QhjJDlYR-oiLnB
 UfJAXxGLL744RBhNKfXyBMP_y_NzaOWyzXTb7HgYiJ9sngs83cvlZZA>
X-ME-Received: <xmr:kf3EamRVkwoB13agljbPO_4cX1POhxIO8VhFqT8ABtg0IOJLWb4nIkGFlYHKGalt5eITEvZW-ApX>
X-ME-Proxy-Cause: dmFkZTGG4cdYWkZl+OiS87QmLJZCZSYCzq+t5qj6SVGJXyNY0K9utq0wQSc5JU88OY7XEz
 CyOgtuuySOVlJFUEhc/lg8AD5ktzB9M9Qn13A6sOH3D2fIMYLNI/0bA6mM3j3UViUygoxF
 cULBXIYhYUu36kN5tPce45zTiVl7dVS/dDNcLDwa0WpdZR+e1MHshmvj5/TLwpCSP3Kf3C
 ozYaEmXr99SzrAPudG4SxxDoz7OO0eqIJgIx37JkPXz7JW3EmL4e0v4bL3CPhdFeQ6w9qk
 7mFVA+KGTAbeitYVNWoJnUUIEZF/4EzC9MjwVNzsxuRij6Y5b4BAmNJghYe2DwYntCoPEg
 n221lB9ujYPvnSHZVAur50l6TJFiyI3CeF4W25gWRRS+KN/lhRHDZ7srHGmhAFOSUS3cZP
 Zu03injTLQisWnC838a0CcAFkXP/tNOPcWzMxdFCtoQvcLpJ34YLpdoDl9YyiBI7KdMeIb
 Arsqvp2wsJiSR54Ec5/kVwJ0JBval+bNEB4DNGDJNfiHMRtJ5lTbYo7qtKIS6Evv7O/Lu5
 gz77gmph51CkICI11Uc8E217tnQc4i5dhvVUccsjTP7gjRZJ7LHEOtGgsLLky4DGBroHxB
 v1WxJxGNvQlpJ00jDShiAYi1Q1mEDCxuFyi68QBwxYIjAZqcmBgQXWfQfHaQ
X-ME-Proxy: <xmx:kf3EapILwas3XpAPKSh-YSBGQ2oW58xZXcx2FGtl3_7H_fsy283Isg>
 <xmx:kf3EarKQMbEDk6obQTVN1gB6ZndkNO-3672isDsYeXl-P2dBrR-skQ>
 <xmx:kf3Easjw8k2qbEMkxAU9cb2nqZ1gLWH7ag2Y_kxI1-sG735V2JPBXA>
 <xmx:kf3EatNFlp9b93UWQlALqonhLMS04EdPsLIKfgR0LhdkBYKkRtkGGA>
 <xmx:kf3EasEly45HxuYAEMemhi8JmePF83cCiMefWj-d3G13gFwysaQIDu15>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 09:54:17 -0400 (EDT)
Message-ID: <63fb07be15290675cf2f2f30171d9766937bc422.camel@alistair23.me>
Subject: Re: [PATCH v2 0/3] hw/riscv/virt: Fix the UART register width in SPCR
From: Alistair <alistair@alistair23.me>
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Sunil V L	
 <sunilvl@ventanamicro.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>
Date: Tue, 06 Oct 2026 23:54:13 +1000
In-Reply-To: <20261005104008.214588-1-rick@sloservers.com>
References: <20261005104008.214588-1-rick@sloservers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 2026-10-05 at 03:40 -0700, Rick Richard wrote:
> The riscv virt board's SPCR table says its 16550 UART has a 32-bit
> register stride, but the registers are actually byte spaced.=C2=A0 Linux
> doesn't use this field to work out the register spacing, but
> FreeBSD's
> EFI loader does, and the FreeBSD kernel then crashes on the console
> UART when booted through EDK2 with ACPI enabled.
>=20
> This series fixes the width, plus the usual bios-tables-test patches
> to
> update the golden reference so 'make check' keeps passing.
>=20
> v2:
> - Keep the relative file path in the patch 3 iasl diff (Daniel)
> - Add Reviewed-by tags
>=20
> Thanks,
> Rick
>=20
> Rick Richard (3):
> =C2=A0 tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
> =C2=A0 hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
> =C2=A0 tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden
> =C2=A0=C2=A0=C2=A0 reference

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/riscv/virt-acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
> =C2=A02 files changed, 1 insertion(+), 1 deletion(-)

