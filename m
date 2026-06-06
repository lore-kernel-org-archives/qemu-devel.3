Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107FCD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPE-0003UK-JC; Sat, 06 Jun 2026 01:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVjPB-00037G-9w; Sat, 06 Jun 2026 01:17:09 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVjP9-0008Iy-Eh; Sat, 06 Jun 2026 01:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1780723006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kxos7LJ1yinkzpP5ls5EJvUYc9+ztamvTpvne7FwStu33VYIrWw2RRpxCMJdNJ9/kl7/XxesPJS5Dm5YVOTSEfefstgObKeozRWVgbk2jmT4cinroDlYVpxa0a8ngwAcNjcsvYjoCiF7oHxv9e0D8wF40Ciz8xAL8JlmxEpK3+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780723006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Bud71TsslVRu8CyzB+cvMpilOUUTUGSLvUZRWJ3sshY=; 
 b=i/fTNWz0eDuBIAIE+Vle4M8C/fsvrWVUWlrKNCocwB6eI3msJ/JFvM3D25613WCcxHqXAcYJiErHnbh7lMw7uei3+xEDTkjimfov0eMf7zOPBwFi6QSgcpxB16HlxCY8p3oKNI3Xb4Tl9+sBC1Kgq9xTsnCWWPhhv79NlCMhl0U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780723006; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=Bud71TsslVRu8CyzB+cvMpilOUUTUGSLvUZRWJ3sshY=;
 b=nTFzYpFqjh2kpzOQv59SxHnoaItdF5dotHgAu2bnlCKUls2y7VMr/al3CUDNhmwo
 1vFG0JW1sHZgvhnHBzO+PNJMHOeaiZ7rhLAhv/JY3LlS3vj5EcNN3o520G1Dz2bEABE
 qaioHLXjqbY2V6iB85ImFJzRnwBp70fH0YQSHWDuruJnJZFuAe5v8+o5LH437HcLa2/
 pX7YSY7RikaM9wUy2Y3os4MsqH8rPyv9U/SBFoFILx7vO/EWGA18l4o0YobtGuaGDjU
 GR0RGFQ7s0tFdIbHEfkYmWkecwjWemKloM042IsHFHYwH4pMsCuScUWWbXKwbHqVcnS
 lHr1GrkL1A==
Received: by mx.zohomail.com with SMTPS id 1780723004105485.3738790350237;
 Fri, 5 Jun 2026 22:16:44 -0700 (PDT)
Message-ID: <17b395009bef17cc056ae4a58a83c744ebb12798.camel@icenowy.me>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
From: Icenowy Zheng <uwu@icenowy.me>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Andrew Jones
 <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, 	leif.lindholm@oss.qualcomm.com, Fei Wu
 <wu.fei9@sanechips.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Date: Sat, 06 Jun 2026 13:16:36 +0800
In-Reply-To: <3f9d50fb-304c-4ef3-bd63-9fd215b45965@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
 <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
 <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
 <3f9d50fb-304c-4ef3-bd63-9fd215b45965@oss.qualcomm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.12; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

=E5=9C=A8 2026-06-05=E4=BA=94=E7=9A=84 23:33 -0300=EF=BC=8CDaniel Henrique =
Barboza=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 6/5/2026 7:24 PM, Andrew Jones wrote:
> > On Fri, Jun 05, 2026 at 05:48:18PM -0300, Daniel Henrique Barboza
> > wrote:
> > ...
> > > > You're correct.=C2=A0 We're not initializing satp_mode to
> > > > max_satp_mode, so the
> > > > default value is being set to sv39.=C2=A0 This seems to be the case
> > > > for all
> > > > CPUs, not just this one.=C2=A0 For some reason I thought we were
> > > > defaulting
> > > > to the max_satp_mode.=C2=A0 I need to understand why sv39 is being
> > > > set as
> > > > default (i.e. why not BARE?).
> > >=20
> > > Got an update.=C2=A0 It turns out that what we're seeing is something
> > > that is
> > > only happening to this CPU we're trying to add.
> > >=20
> > > The way satp mode is set on QEMU assuming no command line input:
> > >=20
> > > - "Bare" CPUs, aka CPUs that has just I or E enabled: default to
> > > BARE;
> > >=20
> > > - Profile CPUs: default to the minimum required by the spec.=C2=A0
> > > E.g. for
> > > =C2=A0=C2=A0 RVA23 the default is set to sv39;
> > >=20
> > > - all other CPUs: default to satp_mode_max from the CPU
> > > definition.
> > >=20
> > > The riscv-server-ref CPU is a BARE CPU that is using the profile
> > > framework
> > > to enable extensions.=C2=A0 So for all intents and purposes the code
> > > is treating
> > > it as a profile CPU with extra stuff.=C2=A0 Which is good, but then
> > > the
> > > satp setting from RVA23 (sv39) is overwriting satp_mode_max from
> > > the
> > > CPU definition.
> > >=20
> > > I believe the way we're creating riscv-server-ref here is
> > > correct, so what
> > > I'm going to do is send a couple of fixes to allow riscv-server-
> > > ref to use
> > > RVA23 as a base and honor its satp_mode_max value too.
> >=20
> > But setting satp_mode_max to sv48 is not correct if that really
> > means
> > _max_ since we want the reference platform to default to the
> > minimum
> > (sv48) but also support the supported optional extensions and sv57
> > is
> > a supported optional extension.
>=20
> QEMU only works this way for profile CPUs.
>=20
> For non-profile CPUs: cpu.max_satp_mode is set internally as part of
> the CPU definition.=C2=A0 This is the maximum satp value that the CPU
> allows
> users to set via cmd line.=C2=A0 If the user does not provide a satp mode
> then we'll do curr_satp_mode =3D max_satp_mode.
>=20
> E.g. the thead vendor CPU defines .cfg.max_satp_mode =3D VM_1_10_SV39.
> In the command line we can't set anything higher than that:
>=20
> $ ./build/qemu-system-riscv64 -M virt -cpu thead-c906,sv57=3Don
> qemu-system-riscv64: satp_mode sv57 is higher than hw max capability
> sv39
>=20
>=20
> For profile CPUs things are different: they are bare_cpu types, which
> are
> initialized with max_satp_mode sv57, and then during profile init we
> set the current satp_mode (current, not max_satp_mode) to the minimum
> the profile requires.=C2=A0 Thus the rva23s64 CPU, by default, starts wit=
h
> sv39 but it can go up to sv57.
>=20
> =C2=A0From what I'm understanding we want the riscv-server-ref CPU to wor=
k
> like profile CPUs.=C2=A0 In fact I believe we can make it official by
> adding a 'default_satp_mode' setting in the CPU definition and
> allowing
> all CPUs to define a default satp and a max satp.=C2=A0 CPUs defs that
> don't
> set a default mode will keep working as today (default_satp_mode =3D=3D
> max_satp_mode
> if no user input).

I think we can just make RVSP a profile, and rvsp-ref CPU a BARE CPU
based on that profile; then set the profile's min SATP to Sv48, and the
BARE CPU's max SATP to Sv57.

In this case if any other CPU complying to RVSP is added, it can just
reuse the profile.

Thanks,
Icenowy

>=20
>=20
> I'll make changes and see how it goes.=C2=A0 Cheers,
>=20
> Daniel
>=20
> >=20
> > Thanks,
> > drew

