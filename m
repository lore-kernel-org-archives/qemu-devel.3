Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA7DCD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVuml-0003He-8S; Sat, 06 Jun 2026 13:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVumk-0003Fk-8Q; Sat, 06 Jun 2026 13:26:14 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVumi-0001Dm-DS; Sat, 06 Jun 2026 13:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1780766749; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GkNe89N3ccPajdxwtl0b6ncGZOg0L1mA85R8EEu5LR2bDspHVYd93MFLz14NoJ60yGGfs7yJPHHj5Xoe3pJ9jYOU3Uzwd8wR2q1cOxL3IxcgfatBNGygxHbuFUsNHAg6Z3xvm9R/D3lk79qB8uvtdQzvK2IaWM9fMXjNo560s1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780766749;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z3UFztaGlhYb792H4HZIluZceq0eQ8TPRFTTB6uwWfc=; 
 b=YTFwaIh1T4uLHNv9aElcpsYsqOCoO29hN7satL0eWPf8/+MR1TLffKbmWVN5T5InKSWlinq4PYQnpyQ51xo35tmhnzuCPZ4XPrNp4tTs7/d2VcOjgFOgRa8ThfKueXKiU7e5XBYBaAwvZ1YGANKsInTnx7R0q+NmWAcsUnoxqZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780766749; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=z3UFztaGlhYb792H4HZIluZceq0eQ8TPRFTTB6uwWfc=;
 b=mgNIeRAzF59DqyU1wT5Dw2qVWfeyCGDTJZy5f6bRajj16HvObnUOfcSQwovypTvR
 qPEOao63kOvTmDz3ostwosvQUW4FSJs26pkeVtG9h2A0uL57gnb5zI030VrWKH9XXoZ
 sXGDSzm8iOFBqpKaNNAb3kTORXE5/wXF6C5hV45zYQzFwqiBLoVZbX768rtzcIBklHg
 OO3fn8DDWkAL8xL4zfTCzkOK3QWfcOIbP2TFjFBLSNEsxuHkG/n/ods9ehKtYeRmEvB
 w05oAfHFBDuzxln98r2DFsBxUytWwQEHL8ni+mPmcUFOQTMf8f42nNdam8kIhZJY2LG
 vChnC5t++w==
Received: by mx.zohomail.com with SMTPS id 1780766747568386.80379582955106;
 Sat, 6 Jun 2026 10:25:47 -0700 (PDT)
Message-ID: <b7bf59aed4e0e2882a89a96bab335797d8a1f6fe.camel@icenowy.me>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
From: Icenowy Zheng <uwu@icenowy.me>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, 	leif.lindholm@oss.qualcomm.com, Fei Wu
 <wu.fei9@sanechips.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Date: Sun, 07 Jun 2026 01:25:41 +0800
In-Reply-To: <skdkxsqs7ag7el6ikasgpdhc6p2g3zdoqexse2fj2mzhmlybmt@2pxvqsl7ho77>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
 <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
 <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
 <3f9d50fb-304c-4ef3-bd63-9fd215b45965@oss.qualcomm.com>
 <17b395009bef17cc056ae4a58a83c744ebb12798.camel@icenowy.me>
 <eb4169a9-6f28-4104-884a-62249f7ccdbd@oss.qualcomm.com>
 <skdkxsqs7ag7el6ikasgpdhc6p2g3zdoqexse2fj2mzhmlybmt@2pxvqsl7ho77>
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

=E5=9C=A8 2026-06-06=E5=85=AD=E7=9A=84 11:09 -0500=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Sat, Jun 06, 2026 at 07:21:32AM -0300, Daniel Henrique Barboza
> wrote:
> ...
> > > I think we can just make RVSP a profile, and rvsp-ref CPU a BARE
> > > CPU
> > > based on that profile; then set the profile's min SATP to Sv48,
> > > and the
> > > BARE CPU's max SATP to Sv57.
> > >=20
> > > In this case if any other CPU complying to RVSP is added, it can
> > > just
> > > reuse the profile.
> >=20
> > Having riscv-server-ref being a profile CPU seems compelling indeed
> > ...
> > new CPUs could instance it with .profile =3D &rvserver-ref to have
> > everything
> > already sorted out, we would also have a flag to enable the profile
> > for
> > existing cpus, e.g. -cpu rv64,rvserver-ref=3Don.
> >=20
> > Drew, any thoughts?
>=20
> As long as the concept of 'profile' is internal to QEMU and we
> comment its
> [ab]use explaining why the riscv-server-ref is modeled that way, then
> that
> sounds good to me. If the concept is exposed to users then I fear
> we'd
> confuse things by inventing profiles that don't exist in the profiles
> spec.

Well I think the problem here is that RVI doesn't restrict the
definition of required processor feature sets to profiles spec.

The best solution here is to make them create a proper profile
describing the ISA extension requirement of RV Server Platform spec,
instead of open-coding it in RVSP spec; otherwise they're effectively
creating a profile, even if it's not in the profiles spec.

Thanks,
Icenowy

>=20
> Thanks,
> drew

